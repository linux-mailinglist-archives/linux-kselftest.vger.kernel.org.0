Return-Path: <linux-kselftest+bounces-17592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26384973A4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 16:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B588BB24577
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 14:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B2E19F404;
	Tue, 10 Sep 2024 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohOGReQH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499F6195FF0;
	Tue, 10 Sep 2024 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979440; cv=none; b=Itg7UDPRUynNClQFDWvQJ8SKxDs/ALl0IS15kyURCK+T02OSpkfA9xh5rmbfjtodse9oOQkPAKRf5sNz1HgQEBqG6pLbuuYZpnuuSvhKmgvQHtD6b9XfVILd/9vS86S6iFNMn5umMi4yiXeMHi9YnuZJxW5d36VX4pvVJZUxH2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979440; c=relaxed/simple;
	bh=ViWIkS3pENGlV8JsArrtQVZLs5ZqoLV/BOu0z+rM8eQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gpnD1XdRO4X4Km5bR8BZhP9TcjWdJonXc/cmfKRncMNAgwpJJg0s6AM61WAzII4jYtvILJLJh9geM2nSc50e68cq4ZcO08cNUf+k9W2wlgIDr7B7mGUDtuzBzi06pylrNgtiTR29TtY51kz0ghMa7MWsenT49thUmt0cnkrJsIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohOGReQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1826BC4CEC3;
	Tue, 10 Sep 2024 14:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725979438;
	bh=ViWIkS3pENGlV8JsArrtQVZLs5ZqoLV/BOu0z+rM8eQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ohOGReQHOZgTJ1tI5zc/QVIatKUx0XbYh15WYbtxxmpEc4YPK31rKhxBRVwJZIWR9
	 Q6xu8IRpFkMR37RN5dXLe4FQhNN6D67nArJuCNKumFI40LIRuLp1Q3uDZl1n2XWOoF
	 A/0HfcAgzr4KpO5ZZPBRLdRVquMplbUTeiPJJe/rSWM/z/ghTrSfXsd47ZvH3sZpCM
	 ci5sv4n8lxAR6182o9rVH7ZImYVG7rc+s0Atd0KSZHG75KCc+DIn2K6BVcIyG3vnib
	 F+mWq0Ad+uBb9uCtmhIH0U5WDkrvln2e6s3Gb6XmBq7/ZF4OMI4WQtihNrO2ijUECV
	 hb7jwBM3F4Etg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 10 Sep 2024 23:43:40 +0900
Subject: [PATCH HID v2 04/11] HID: bpf: allow write access to quirks field
 in struct hid_device
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-hid-bpf-hid-generic-v2-4-083dfc189e97@kernel.org>
References: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
In-Reply-To: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725979428; l=2073;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=ViWIkS3pENGlV8JsArrtQVZLs5ZqoLV/BOu0z+rM8eQ=;
 b=PVKuJyPMXrekjkrvb1iGSwOV4LtFK8vfroehMdz3WWF5qRjHmIWsiEy/SiHxr2iXg2gTMKE9+
 B/33+IqZFg4DyPm2Fxgg5PgFEHGdP/bbCFupo43ms48iYayVy2fLUmi
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This allows to give more control from BPF during report descriptor fixup.
We already reset the quirks before calling ->probe(), so now we reset
it once before calling hid_bpf_rdesc_fixup().

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

new in v2
---
 drivers/hid/bpf/hid_bpf_struct_ops.c |  1 +
 drivers/hid/hid-core.c               | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index cd696c59ba0f..e4c25ade54a3 100644
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
index 2b70a12a2135..37e52759a931 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2676,9 +2676,17 @@ static int __hid_device_probe(struct hid_device *hdev, struct hid_driver *hdrv)
 	int ret;
 
 	if (!hdev->bpf_rsize) {
+		unsigned int quirks;
+
+		/* reset the quirks that has been previously set */
+		quirks = hid_lookup_quirk(hdev);
+		hdev->quirks = quirks;
 		hdev->bpf_rsize = hdev->dev_rsize;
 		hdev->bpf_rdesc = call_hid_bpf_rdesc_fixup(hdev, hdev->dev_rdesc,
 							   &hdev->bpf_rsize);
+		if (quirks ^ hdev->quirks)
+			hid_info(hdev, "HID-BPF toggled quirks on the device: %04x",
+				 quirks ^ hdev->quirks);
 	}
 
 	if (!hid_check_device_match(hdev, hdrv, &id))
@@ -2688,8 +2696,6 @@ static int __hid_device_probe(struct hid_device *hdev, struct hid_driver *hdrv)
 	if (!hdev->devres_group_id)
 		return -ENOMEM;
 
-	/* reset the quirks that has been previously set */
-	hdev->quirks = hid_lookup_quirk(hdev);
 	hdev->driver = hdrv;
 
 	if (hdrv->probe) {

-- 
2.46.0


