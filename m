Return-Path: <linux-kselftest+bounces-12799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E96918304
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 15:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B351F21895
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 13:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1B61862AB;
	Wed, 26 Jun 2024 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3fBmUvQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACB2186284;
	Wed, 26 Jun 2024 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409612; cv=none; b=Tp++CmDr2qr+vIveRozu8W4ufC2rONq+wxTJszCZikzoEzryDAzvWhvYsftXakD5AFaf/bOfJivxNzOjHlGsSN8ekxjxsWx5EEf8xA6J+UEXIEwQAT6lTneRGo31v+bXk/NL+8/i1v4HswFF7RXFH2HxbXg4IOwW/CHJt+8NqSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409612; c=relaxed/simple;
	bh=hLxv1tQ4ND5CQTyY2sweAPBolNhSrfyuhdyzuv4wmEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bmdVID6RKLA75IIk3dKQ7fpIxZKpltnuPFe2/YMt78MWXI/F0DqL3J1YfYh9ujSD7wmTrqa6qUhh+RwuNFwqQl+3shUVgewaRmogGVDgydW0tSBMJ/cGF2cMe/eONe1OQy1zeAUqJGP6rUxI1H0SH1zDNp82VnLeWstRSDv403Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3fBmUvQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E582EC32782;
	Wed, 26 Jun 2024 13:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719409611;
	bh=hLxv1tQ4ND5CQTyY2sweAPBolNhSrfyuhdyzuv4wmEQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E3fBmUvQVBBtJnrFsB8vp3Wx0IQLJ/rpj/nd0NfLfHdPAQS69pBNmecEA4ownvMJ0
	 KKOl21La9grVtvaJ3l7kf6YHSKc3Et7bgc34qRW6ct08qFzV+MrI2OkK7z8D72rsou
	 GczODF2wC7M04Lk093R6U2ncJilKTpTuDyJzS/s3EvGpO9JLBBAIthcwy+ir1fTULw
	 lPT4ULKcMj8G5cnD4g9EEJ7jU2prjlW2lghncGJxGpLK/dkmhPkt5PAIquyZayDOyY
	 S3ALJv619EXJfNLrzyUexE0Ny+hqk5uCFM0qVU/FpBQA+2koAuEftI+Jf4HnWKYPmi
	 /Nq+Y+PE70GEQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 26 Jun 2024 15:46:24 +0200
Subject: [PATCH HID v2 03/13] HID: bpf: protect HID-BPF prog_list access by
 a SRCU
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-hid_hw_req_bpf-v2-3-cfd60fb6c79f@kernel.org>
References: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
In-Reply-To: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719409602; l=4479;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=hLxv1tQ4ND5CQTyY2sweAPBolNhSrfyuhdyzuv4wmEQ=;
 b=euocECF82/VA2Yc9x6TuL1sM4rve+X1wAuPOCXC7da15J48DHtEaZKST0aTxrBeZDrc99mjAk
 u3xTD//3BTrBKmVBwF7DR3V8NHnR8gYVaCb4mc0Zns1ol3tglsSnXjh
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We want to add sleepable callbacks for hid_hw_raw_request() and
hid_hw_output_report(), but we can not use a plain RCU for those.

Prepare for a SRCU so we can extend HID-BPF.

This changes a little bit how hid_bpf_device_init() behaves, as it may
now fail, so there is a tiny hid-core.c change to accommodate for this.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

new in v2
---
 drivers/hid/bpf/hid_bpf_dispatch.c   | 6 +++++-
 drivers/hid/bpf/hid_bpf_struct_ops.c | 2 ++
 drivers/hid/hid-core.c               | 8 +++++++-
 include/linux/hid_bpf.h              | 6 ++++--
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 2df31decaac3..c026248e3d73 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -506,13 +506,17 @@ void hid_bpf_destroy_device(struct hid_device *hdev)
 	hdev->bpf.destroyed = true;
 
 	__hid_bpf_ops_destroy_device(hdev);
+
+	synchronize_srcu(&hdev->bpf.srcu);
+	cleanup_srcu_struct(&hdev->bpf.srcu);
 }
 EXPORT_SYMBOL_GPL(hid_bpf_destroy_device);
 
-void hid_bpf_device_init(struct hid_device *hdev)
+int hid_bpf_device_init(struct hid_device *hdev)
 {
 	INIT_LIST_HEAD(&hdev->bpf.prog_list);
 	mutex_init(&hdev->bpf.prog_list_lock);
+	return init_srcu_struct(&hdev->bpf.srcu);
 }
 EXPORT_SYMBOL_GPL(hid_bpf_device_init);
 
diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index 8063db1c8d62..d34731a1b457 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -214,6 +214,7 @@ static int hid_bpf_reg(void *kdata)
 		list_add_rcu(&ops->list, &hdev->bpf.prog_list);
 	else
 		list_add_tail_rcu(&ops->list, &hdev->bpf.prog_list);
+	synchronize_srcu(&hdev->bpf.srcu);
 
 out_unlock:
 	mutex_unlock(&hdev->bpf.prog_list_lock);
@@ -244,6 +245,7 @@ static void hid_bpf_unreg(void *kdata)
 	mutex_lock(&hdev->bpf.prog_list_lock);
 
 	list_del_rcu(&ops->list);
+	synchronize_srcu(&hdev->bpf.srcu);
 
 	reconnect = hdev->bpf.rdesc_ops == ops;
 	if (reconnect)
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 0775a32f5272..ad08289752da 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2875,9 +2875,15 @@ struct hid_device *hid_allocate_device(void)
 	mutex_init(&hdev->ll_open_lock);
 	kref_init(&hdev->ref);
 
-	hid_bpf_device_init(hdev);
+	ret = hid_bpf_device_init(hdev);
+	if (ret)
+		goto out_err;
 
 	return hdev;
+
+out_err:
+	hid_destroy_device(hdev);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(hid_allocate_device);
 
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index a54741db0415..f93845de5cac 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -5,6 +5,7 @@
 
 #include <linux/bpf.h>
 #include <linux/mutex.h>
+#include <linux/srcu.h>
 #include <uapi/linux/hid.h>
 
 struct hid_device;
@@ -145,6 +146,7 @@ struct hid_bpf {
 	struct hid_bpf_ops *rdesc_ops;
 	struct list_head prog_list;
 	struct mutex prog_list_lock;	/* protects prog_list update */
+	struct srcu_struct srcu;	/* protects prog_list read-only access */
 };
 
 #ifdef CONFIG_HID_BPF
@@ -153,7 +155,7 @@ u8 *dispatch_hid_bpf_device_event(struct hid_device *hid, enum hid_report_type t
 int hid_bpf_connect_device(struct hid_device *hdev);
 void hid_bpf_disconnect_device(struct hid_device *hdev);
 void hid_bpf_destroy_device(struct hid_device *hid);
-void hid_bpf_device_init(struct hid_device *hid);
+int hid_bpf_device_init(struct hid_device *hid);
 u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *size);
 #else /* CONFIG_HID_BPF */
 static inline u8 *dispatch_hid_bpf_device_event(struct hid_device *hid, enum hid_report_type type,
@@ -162,7 +164,7 @@ static inline u8 *dispatch_hid_bpf_device_event(struct hid_device *hid, enum hid
 static inline int hid_bpf_connect_device(struct hid_device *hdev) { return 0; }
 static inline void hid_bpf_disconnect_device(struct hid_device *hdev) {}
 static inline void hid_bpf_destroy_device(struct hid_device *hid) {}
-static inline void hid_bpf_device_init(struct hid_device *hid) {}
+static inline int hid_bpf_device_init(struct hid_device *hid) { return 0; }
 #define call_hid_bpf_rdesc_fixup(_hdev, _rdesc, _size)	\
 		((u8 *)kmemdup(_rdesc, *(_size), GFP_KERNEL))
 

-- 
2.44.0


