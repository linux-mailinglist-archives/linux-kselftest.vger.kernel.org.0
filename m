Return-Path: <linux-kselftest+bounces-14090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D5393A44C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 18:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13041F233EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 16:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08996158874;
	Tue, 23 Jul 2024 16:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMhz/b0z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC94C15886B;
	Tue, 23 Jul 2024 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721751735; cv=none; b=hPVfrMM7pF8d78+dfznAHYjU/GZ8FDAj+UPLqf0+MpnrBG4t2l1aiyH3uA2jzkcJ+mSGtaUb2gNPlZOYU2gLPitVnS7X9C9G6ugW+VYIz5/PehF9cQvtM4C2DYR9B/Yg4hhNHE76QqUXbnjzV4kZP55PvnT0JFXGj0h82H+l14M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721751735; c=relaxed/simple;
	bh=wojTuv6su0uFmhRH2+1K0rFYVgCtGhL1z6RmaNynhg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YIB7O9A14z7w7Uk6lgPsCLJk9OU9bK8Aew2dH1EJbAU7jCP+8bgEamcoonX9yOwtE5JiRub9cDpVQrd7l+jg0E/dPNHdLRfGXvxmTs0THfaAo9i/i89VIqmSZQbJlSV6QNH72LiFvPaLTb5oXOtC9YSA+uBTXqrDDYNfwnFoxgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMhz/b0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D02BC4AF0C;
	Tue, 23 Jul 2024 16:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721751735;
	bh=wojTuv6su0uFmhRH2+1K0rFYVgCtGhL1z6RmaNynhg4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DMhz/b0zRh55DJOm8CWSnM5flgLHP7InrJLHCjgxIKnEjLET3ESAonxbZas3aK3Jh
	 H6RrkUm9pD/GZZiMdkoa2Ol4rjK8jhL4MCnC9dqs2moOnzqjyVCkgCKQV3CjwPpYlp
	 /zcHI4U5QJgW0/TIzH3fb/mtrjmfzLnwuyudL0aRbufy2Y6rYo3Yl9AVPK8B2COKiJ
	 FWgKXLXFKc64lyAxQfpnOP6sAfMwBGFJC2a+X7kUU/UuGbEp+sEcq8qoLdR75up2ie
	 Bz1d82HwICygyERZrHWKLyumfnF0q4eIJDcREWK6bfEpL3M/qEFaLYweIV2KvJ5iFc
	 +asHo+76zBjiw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 23 Jul 2024 18:21:53 +0200
Subject: [PATCH HID 3/4] HID: bpf: prevent the same struct_ops to be
 attached more than once
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-fix-6-11-bpf-v1-3-b9d770346784@kernel.org>
References: <20240723-fix-6-11-bpf-v1-0-b9d770346784@kernel.org>
In-Reply-To: <20240723-fix-6-11-bpf-v1-0-b9d770346784@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721751728; l=1075;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=wojTuv6su0uFmhRH2+1K0rFYVgCtGhL1z6RmaNynhg4=;
 b=zl/ElL/hewvouwVJXiqkag8nfKVjOSgTcXX9gBKLkCqgaUZ6Ok09XqWGd08mn4k/WaJSTHtkp
 qvIS5KhjlGnCHoyICoTZqey/AG2P4RLq0Cx2gtDsVP1MxmQf+MEuNCF
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

If the struct_ops is already attached, we should bail out or we will
end up in various locks and pointer issues while unregistering.


Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/hid_bpf_struct_ops.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index f59cce6e437f..cd696c59ba0f 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -183,6 +183,10 @@ static int hid_bpf_reg(void *kdata, struct bpf_link *link)
 	struct hid_device *hdev;
 	int count, err = 0;
 
+	/* prevent multiple attach of the same struct_ops */
+	if (ops->hdev)
+		return -EINVAL;
+
 	hdev = hid_get_device(ops->hid_id);
 	if (IS_ERR(hdev))
 		return PTR_ERR(hdev);
@@ -248,6 +252,7 @@ static void hid_bpf_unreg(void *kdata, struct bpf_link *link)
 
 	list_del_rcu(&ops->list);
 	synchronize_srcu(&hdev->bpf.srcu);
+	ops->hdev = NULL;
 
 	reconnect = hdev->bpf.rdesc_ops == ops;
 	if (reconnect)

-- 
2.44.0


