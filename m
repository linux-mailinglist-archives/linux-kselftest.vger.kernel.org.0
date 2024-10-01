Return-Path: <linux-kselftest+bounces-18747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F24B698C001
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 16:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263891C23925
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 14:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72DA1C9B7C;
	Tue,  1 Oct 2024 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocGJRVNb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D61C9DC1;
	Tue,  1 Oct 2024 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793042; cv=none; b=jMhGzGOjONX0PU3fGSHyyXxfacDEmK+FN5XJfF9XgnwEFT6cGALeEN9U6EytNwLwdSiETiA2L29ZrqCc/I58qcEC98tUY/KrfvsdUY+Ib0gh5VZgQdrGNWKvCwMrACUFqTjhlwTxqNXHC4lrcsrNdQAF7JvQ3XScUaWsD2YWD5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793042; c=relaxed/simple;
	bh=p4g+iwuaYIPus8wrmkFnFCeAl5kqd+1zqwGl6fVXFWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bNFUJ0K1g4TPtbBPyIuXSGlC9TEs4nU5JEsMVRVcjIEH6a4Pyt7rQlx6dqmJvDevLPjflPaC+yi11QdrL8vXCM2wuXhlaUqDGa6bqFmh0/0gLVyIidZ1T3JB9A6FJnw4orZN1uklFbsoyUIunNnvWjP+SFYovPMlUR98wSzK6ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocGJRVNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762A1C4CED2;
	Tue,  1 Oct 2024 14:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727793042;
	bh=p4g+iwuaYIPus8wrmkFnFCeAl5kqd+1zqwGl6fVXFWE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ocGJRVNbFA/7E2zayrfR3BWZWLLONrKzKKdL0KHVBGcTqGOcW1JR8qvGQvdoBsNs/
	 B3SJQY6eDA7AIKvdFahYEHawctHYVtxfQxxBXNe77FU++LcPEqEZxj5UFHe+Zl1DmA
	 bVH12kceqfJMDAaOTiC9oavCPvFZa1wEls5FyUOh2iqtFM+MOgP1+a/Y260mkrZd+x
	 oHjtfUCF3c0z7JU5OWfCWA9Yu5ZYtCHlhC0zsHN3F1cdRvVE1/27PiikaGmJyI44o3
	 x9w7Xf+UczC7YovqooDUgm6RDSrZfih39kVt8AgqdG7SCyOtU+C+IZYi+0HxTmCjMz
	 kyzC1XQIf9PeQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 01 Oct 2024 16:30:08 +0200
Subject: [PATCH HID v3 4/9] HID: bpf: allow write access to quirks field in
 struct hid_device
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-hid-bpf-hid-generic-v3-4-2ef1019468df@kernel.org>
References: <20241001-hid-bpf-hid-generic-v3-0-2ef1019468df@kernel.org>
In-Reply-To: <20241001-hid-bpf-hid-generic-v3-0-2ef1019468df@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727793031; l=2396;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=p4g+iwuaYIPus8wrmkFnFCeAl5kqd+1zqwGl6fVXFWE=;
 b=0kRm3zqZd8+zQST2NYsrIYpThkwG5zqfgZFhExQwrERHuSh/HaCyfCmemX11ESUk42bkYhZGz
 UK1NkLcQPjCDP5F6K35qIHZ1Yh0gEYTq0C7yuQxCBCXm86RNYua4PrK
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This allows to give more control from BPF during report descriptor fixup.
We already reset the quirks before calling ->probe(), so now we reset
it once before calling hid_bpf_rdesc_fixup().

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v3

new in v2
---
 drivers/hid/bpf/hid_bpf_struct_ops.c |  1 +
 drivers/hid/hid-core.c               | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index 702c22fae136..0e611a9d79d7 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -79,6 +79,7 @@ static int hid_bpf_ops_btf_struct_access(struct bpf_verifier_log *log,
 		WRITE_RANGE(hid_device, name, true),
 		WRITE_RANGE(hid_device, uniq, true),
 		WRITE_RANGE(hid_device, phys, true),
+		WRITE_RANGE(hid_device, quirks, false),
 	};
 #undef WRITE_RANGE
 	const struct btf_type *state = NULL;
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b0a22e173502..8e879937e956 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2709,6 +2709,12 @@ static int __hid_device_probe(struct hid_device *hdev, struct hid_driver *hdrv)
 	int ret;
 
 	if (!hdev->bpf_rsize) {
+		unsigned int quirks;
+
+		/* reset the quirks that has been previously set */
+		quirks = hid_lookup_quirk(hdev);
+		hdev->quirks = quirks;
+
 		/* in case a bpf program gets detached, we need to free the old one */
 		hid_free_bpf_rdesc(hdev);
 
@@ -2718,6 +2724,9 @@ static int __hid_device_probe(struct hid_device *hdev, struct hid_driver *hdrv)
 		/* call_hid_bpf_rdesc_fixup will always return a valid pointer */
 		hdev->bpf_rdesc = call_hid_bpf_rdesc_fixup(hdev, hdev->dev_rdesc,
 							   &hdev->bpf_rsize);
+		if (quirks ^ hdev->quirks)
+			hid_info(hdev, "HID-BPF toggled quirks on the device: %04x",
+				 quirks ^ hdev->quirks);
 	}
 
 	if (!hid_check_device_match(hdev, hdrv, &id))
@@ -2727,8 +2736,6 @@ static int __hid_device_probe(struct hid_device *hdev, struct hid_driver *hdrv)
 	if (!hdev->devres_group_id)
 		return -ENOMEM;
 
-	/* reset the quirks that has been previously set */
-	hdev->quirks = hid_lookup_quirk(hdev);
 	hdev->driver = hdrv;
 
 	if (hdrv->probe) {

-- 
2.46.0


