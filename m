Return-Path: <linux-kselftest+bounces-16996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F04968BDB
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 18:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47BFA1C218A2
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 16:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBA12139DA;
	Mon,  2 Sep 2024 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tc5rwWph"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3CB1AB6CD;
	Mon,  2 Sep 2024 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725293716; cv=none; b=t3cVv2Xj3BPsG+3bb0b9yPXfhpKb4lYNF29+bbB9LSTaWf3k1RYrwzYXi9YywHBwxeLSgrqI53C4+h5U4Ju0GsuXF5N+vrlmuE6m2MZ86AB/LdppszyAtnIxI33X8+24H6L2SWS+re1c653xeBRUKVapNNCflLC+K14Fv77JCqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725293716; c=relaxed/simple;
	bh=XMF4tyjgQTZmmDwd1PZu42vm+Z1+DNVxea8aQd/u1RQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rCApBgNrmFtv4Kv4Kva870Wql6ZO01nmvCywab8LbCWrsr2U7RY3dwQlfddnyoA3Of/ObYGDIWYNaJAEeaF7i9J5iUuOrm7Fxu1f05DhdkaGYKgcertxFc1KBWwP468hruo29eW2uirMwwtVo8TqW/sZw2nX9EZTNMqU7OhjJMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tc5rwWph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FB8C4CEC4;
	Mon,  2 Sep 2024 16:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725293716;
	bh=XMF4tyjgQTZmmDwd1PZu42vm+Z1+DNVxea8aQd/u1RQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tc5rwWphxCyI28z4DRwWHG+TL1iqLOFJggafMwQOoI6j4rhVEqb+NFDH5YE4RGyz2
	 xhFq+07M8IcFXyAJpBK76PnElq6bDDy7xLsNyiENdXa5AesbQEPjKi0Y9UMZyVSuXt
	 H+9xoE9plzwMa4cnTbgnt6g/yhx+bic0KQlf2Bey0rZhgchxccYwCwKNsqEJyEYvFP
	 +G3gEzAFY5+1p4+TFkrrcWTARlvqPViWoWdAit6K7mAMuN7Z+S0rOMX1+SuZWef1/3
	 vOEWDzLFxAM69ciAXkyvf/F76xQhjyYwHNOnpd9P75RMxpoPMq470hJ1fFi56WUN5T
	 ReC8++PGgB99g==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 03 Sep 2024 01:14:36 +0900
Subject: [PATCH HID 6/7] HID: bpf: Allow to control the connect mask of
 hid-generic from BPF
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-hid-bpf-hid-generic-v1-6-9511a565b2da@kernel.org>
References: <20240903-hid-bpf-hid-generic-v1-0-9511a565b2da@kernel.org>
In-Reply-To: <20240903-hid-bpf-hid-generic-v1-0-9511a565b2da@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725293696; l=3583;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=XMF4tyjgQTZmmDwd1PZu42vm+Z1+DNVxea8aQd/u1RQ=;
 b=WDKNwNUxU5NH071omL+ADXlWlicmd4sE9+4iMgORKVSh4qt/QwemvY3k4tvaY2auD2g952VNF
 B86i6pNs6QEBjqtG7cD+jQMY6aHjyIK0FvynZ7s0ylHXNXSq9q2DnSg
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We make struct hid_device_id writeable and use the .driver_data field
of hid-generic as the connect mask.

This way, we can control from a HID-BPF program if a device needs to
be exported through hidraw and/or hid-input mainly.

This is useful in case we want to have a third party program that directly
talks to the hidraw node and we don't want regular input events to be
emitted. This third party program can load a BPF program that instructs
hid-generic to rebind on the device with hidraw only and then open the
hidraw node itself.

When the application is closed, the BPF program is unloaded and the normal
driver takes back the control of the device.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/hid_bpf_struct_ops.c |  1 +
 drivers/hid/hid-core.c               | 14 ++++++++------
 drivers/hid/hid-generic.c            |  5 +++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index 1e13a22f73a1..bb755edd02f0 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -80,6 +80,7 @@ static int hid_bpf_ops_btf_struct_access(struct bpf_verifier_log *log,
 		WRITE_RANGE(hid_device, name, true),
 		WRITE_RANGE(hid_device, uniq, true),
 		WRITE_RANGE(hid_device, phys, true),
+		WRITE_RANGE(hid_device_id, driver_data, false),
 		WRITE_RANGE(hid_bpf_driver, force_driver, false),
 		WRITE_RANGE(hid_bpf_driver, ignore_driver, false),
 	};
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 7845f0a789ec..2bd279b23aa4 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2637,15 +2637,17 @@ EXPORT_SYMBOL_GPL(hid_compare_device_paths);
 
 static bool hid_check_device_match(struct hid_device *hdev,
 				   struct hid_driver *hdrv,
-				   const struct hid_device_id **id)
+				   struct hid_device_id *id)
 {
+	const struct hid_device_id *_id = hid_match_device(hdev, hdrv);
 	int ret;
 
-	*id = hid_match_device(hdev, hdrv);
-	if (!*id)
+	if (!_id)
 		return false;
 
-	ret = call_hid_bpf_driver_probe(hdev, hdrv, *id);
+	memcpy(id, _id, sizeof(*id));
+
+	ret = call_hid_bpf_driver_probe(hdev, hdrv, id);
 	if (ret)
 		return ret > 0;
 
@@ -2662,7 +2664,7 @@ static bool hid_check_device_match(struct hid_device *hdev,
 
 static int __hid_device_probe(struct hid_device *hdev, struct hid_driver *hdrv)
 {
-	const struct hid_device_id *id;
+	struct hid_device_id id;
 	int ret;
 
 	if (!hid_check_device_match(hdev, hdrv, &id))
@@ -2677,7 +2679,7 @@ static int __hid_device_probe(struct hid_device *hdev, struct hid_driver *hdrv)
 	hdev->driver = hdrv;
 
 	if (hdrv->probe) {
-		ret = hdrv->probe(hdev, id);
+		ret = hdrv->probe(hdev, &id);
 	} else { /* default probe */
 		ret = hid_open_report(hdev);
 		if (!ret)
diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
index f9db991d3c5a..5cd1f3a79a4b 100644
--- a/drivers/hid/hid-generic.c
+++ b/drivers/hid/hid-generic.c
@@ -64,11 +64,12 @@ static int hid_generic_probe(struct hid_device *hdev,
 	if (ret)
 		return ret;
 
-	return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	return hid_hw_start(hdev, id->driver_data);
 }
 
 static const struct hid_device_id hid_table[] = {
-	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, HID_ANY_ID, HID_ANY_ID) },
+	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, HID_ANY_ID, HID_ANY_ID),
+		.driver_data = HID_CONNECT_DEFAULT },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, hid_table);

-- 
2.46.0


