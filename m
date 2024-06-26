Return-Path: <linux-kselftest+bounces-12797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155BA9182FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 15:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8873281B93
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 13:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63941849FB;
	Wed, 26 Jun 2024 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qp4VFuwu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9067A18412F;
	Wed, 26 Jun 2024 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409607; cv=none; b=FVGehEvVshVK/uy+D+qk8hIed+3H0hOPA3JoJzCSLoQvOe7o9U2HXy9/s5PbS+WRmpYejkdtFiNmS8+udfis6yCmYRUmEVCbTlAchR2Pg4f/R9DhrxOtPk0ZzQCMg+j7+5DfMC8A947/78ArinpYG+zwQ2xZk8mXA9NFQBfBS7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409607; c=relaxed/simple;
	bh=GtU69AclojvTXAELtzrkbmBbNsYZg/7S9LDXSSiB/1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kSQl4XF14aLbz/RrrWjGW+v6LtpYB59Ni2XS0yhb2pqLZdT6tp5zI1lMk56yAM5B0aIoaUiWRzOpEn7ysMNQgG605rwcLXHZrOI+Pb5WecjHHSfjY/mVrdXgg7aWMDsHN66QHPJlR+VAW0yVcUadscjVLy5t13Wu4cLj8ABiXCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qp4VFuwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C897C4AF0A;
	Wed, 26 Jun 2024 13:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719409607;
	bh=GtU69AclojvTXAELtzrkbmBbNsYZg/7S9LDXSSiB/1k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qp4VFuwuqQaoyDzGEp8H4cMEdE/DyvHDmXRCYpnYMKFAARwNxG1H5T/1Pj1NGH/Ec
	 oLDbDyNEGULy5qAvsT34TXfQ6taL/nyL119KOoBcJNsgj7IgkVM5IFmjAGu+mQnqM3
	 KmfJwdyHUVNmR71fEHIDj/5G+F4wrGetdyknc/V/l4IzGlkwZmUXBGSs40s81Rdght
	 SJpGYjsrINsUGC2yU4dk4tcKpXsuczU0PljrxIqRUx8CF1DDrlfh0CsPrNdQkTdEIy
	 o3lz8jOO9rm8VqwE2EhJP9WtZ0/ICXlOvs4Fgij6GnbLqV8/mgVrZDEA9UMs9XNxnP
	 loX6M31R0o7AA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 26 Jun 2024 15:46:22 +0200
Subject: [PATCH HID v2 01/13] HID: bpf: fix dispatch_hid_bpf_device_event
 uninitialized ret value
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-hid_hw_req_bpf-v2-1-cfd60fb6c79f@kernel.org>
References: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
In-Reply-To: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719409602; l=1348;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=GtU69AclojvTXAELtzrkbmBbNsYZg/7S9LDXSSiB/1k=;
 b=UlCY4s8u+cxp33zBsPAQOuYqWQ0xbzGfujIKMNFxsFyCRVxN9Prsc5k487uOwZtlTQZBv2XnV
 hvRRZQtklceBKKbswmEGnsMv14WUwM5RfBSXuXIn/PkZt9vH1uqDdFz
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Looks like if a bpf program gets inserted and then removed,
hdev->bpf.device_data is then allocated, but the loop iterating
over the bpf program is never assigning ret.

This is a problem and also revealed another bug in which only the last
value of ret was checked. This effectively meant than only the last
program in the chain could change the size of the incoming buffer.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/all/00f7b624-219f-4a05-a7ad-5335f15a41c7@moroto.mountain
Fixes: 4a86220e046d ("HID: bpf: remove tracing HID-BPF capability")
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 06cc628e7bb4..b7b11a7c69db 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -57,11 +57,12 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type
 			}
 
 			if (ret)
-				ctx_kern.ctx.retval = ret;
+				ctx_kern.ctx.size = ret;
 		}
 	}
 	rcu_read_unlock();
 
+	ret = ctx_kern.ctx.size;
 	if (ret) {
 		if (ret > ctx_kern.ctx.allocated_size)
 			return ERR_PTR(-EINVAL);

-- 
2.44.0


