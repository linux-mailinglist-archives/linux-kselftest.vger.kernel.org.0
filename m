Return-Path: <linux-kselftest+bounces-12415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2818B911F88
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D684028ECB7
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 08:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A8E16E864;
	Fri, 21 Jun 2024 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePDGLSwG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED5D16DEDA;
	Fri, 21 Jun 2024 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960183; cv=none; b=nuJV5aO7hBZwE0Ygn6Qjjg9zpb1qumoXHh8bGRmbCQwTqXO8dnL22e6bera7SDXA1wdh4v4STlTS9JKRncgmJvVwgzlqcEiwcY2Cp6ENzsw7D6znkUxK8BhgHvanDm2uuJUkRyKM16JY+0fJAJ0LIrodnPkbEDgGP2czFNbNnVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960183; c=relaxed/simple;
	bh=try8ZWtAUg6Ukt7b3pjA4YPLk6y7CVixKPFM4oJ6bxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mkDCTke7LwZUd1L1474kThLu4fljAjnWA+Ig0Twz5Fd8xCxrmYlLG0VmPhGWToWapcsZsur4vsCfv30JkfPp/OJ9++zhHEVU7jSgHUhrwfbU4EY/EZ3we0y4JpOmdg0UliehGzc6HtqbfmIPTPl7JN9UkbYG/bpfnFcGu/qxbJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePDGLSwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B128C4AF09;
	Fri, 21 Jun 2024 08:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718960183;
	bh=try8ZWtAUg6Ukt7b3pjA4YPLk6y7CVixKPFM4oJ6bxU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ePDGLSwGPXvIKHvDJs7FZabXXHmBtxmRhktcahPmHnITASn4IxmgaQGVKIi8yNZmn
	 /ZF2WXvDj/Q0lxG2WsC0uc4/1Hz3YFZGNTsIKpm89U8g8IaqTr/zFhBZxTl0t50xRI
	 pl3LCl3Bg8wGaCfVuTGLym8y+ILy3Fla04treInQ6+I0MvCFLn2TIB/k8FnJP9rAsi
	 LlruDxLY0G/1TKZGoacJoJyGwcvDp9Av57r6pc+6PjFB7UkL8CeJY2jBPQWXaw/BT4
	 j4DrAxp4xSpBrBmBtqVrnMHK/kbaxohpgwQEePar8RMTAIGOqLmdo3lsK2nPnaeDQi
	 Fp/nlcKwOaoIQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 21 Jun 2024 10:55:46 +0200
Subject: [PATCH HID 01/12] HID: bpf: fix dispatch_hid_bpf_device_event
 uninitialized ret value
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-hid_hw_req_bpf-v1-1-d7ab8b885a0b@kernel.org>
References: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
In-Reply-To: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718960178; l=1321;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=try8ZWtAUg6Ukt7b3pjA4YPLk6y7CVixKPFM4oJ6bxU=;
 b=TNapiMqxjdgFuXLGHRuthlSuKwkQkVy2NeFj6vAIS3C/TllsGkIgKKZwwszhZIsQZqFewgO4q
 EYsGH84ThGTD0IxSHRdqu8NJkeAazj/w5TP3Z4WutS1YACPYxXP/dW4
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


