Return-Path: <linux-kselftest+bounces-12422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE6E911FAF
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A2E1F2184F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 08:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348E916F905;
	Fri, 21 Jun 2024 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8259Jcg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00B216F901;
	Fri, 21 Jun 2024 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960200; cv=none; b=FzeGmXY17a5noA9ooQsAmavqUlKrcsSxa0KIa2Qo3QHnY2U9YjJnc4HH3FfDnDP0W9e29FhKH3hZyJm49ntB7pyzxWSoJWDLfoexDw/Owlafd+TO+e/zXwoK2AP6giHqWUgQluqa/65mYS9NDZiIEeiV4iv8DtiY2oSsV5krXK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960200; c=relaxed/simple;
	bh=FY4fOdYsbEiDF1mtQ6jtcThcESXlgLKN9iRKwTb540Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CpKE5QcDS/ZAn4Tq52wO1VT+pBAyMg+qKQr9oJlU84LDGeeS6IxKoL54VYms2iAoKbwdmOUsadCNUTUduEVMiEQFA9VGgsMTfoc0W0i3vllzaG0p9vRgo3PxZ7BvW0CJAR6Y/YXT4Au/X7woPyCnrmIN0Tndm+YMcMVj20VycCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8259Jcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F73EC4AF0C;
	Fri, 21 Jun 2024 08:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718960199;
	bh=FY4fOdYsbEiDF1mtQ6jtcThcESXlgLKN9iRKwTb540Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p8259JcgxREzl/oEhWwr8lL7m7uFscLGXn5jucUaNO5Ricirk9uJwRMlmg7eCEOPe
	 JxRct93OGvK9wWs6G3xZwRnyZCCW8QeaQHpKjl3VxfFjYMTHjawz3XRnE7vuoV2GeD
	 B8bNytuMZOoc7oQFWgEOyTZUk5lZUQ1+ZX/11s855NSsZpYPFwgeh2oA52YUsiZe1+
	 i6QiO+QTJWEi03cXHPcd/jNvljF9pNHzpQZK6+Gm6GqXDbK1UrsAEc7iDn2gAto4Ta
	 m/rYocRRP1jVrpffUFVPO0Dxg44ZoHbAF7tfcXKczHAz1x6ounQh3E+AQoTJG6dz03
	 zzR0JsRXlLklQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 21 Jun 2024 10:55:53 +0200
Subject: [PATCH HID 08/12] HID: bpf: make hid_bpf_input_report() sleep
 until the device is ready
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-hid_hw_req_bpf-v1-8-d7ab8b885a0b@kernel.org>
References: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
In-Reply-To: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718960178; l=4595;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=FY4fOdYsbEiDF1mtQ6jtcThcESXlgLKN9iRKwTb540Q=;
 b=MbXCw9ERBP8ohJC2T2ZtRkf5ma5wG66m+qlxkPjKIQl7spvHCShubl9BI7RanWs0XZO2qqGu0
 HvrTAF5INVJBMnkxY5ISBI2shlndzSUe9Q0bbcknjTdSZVb3xWz+60s
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

hid_bpf_input_report() is already marked to be used in sleepable context
only. So instead of hammering with timers the device to hopefully get
an available slot where the device is not sending events, we can make
that kfunc wait for the current event to be terminated before it goes in.

This allows to work with the following pseudo code:

in struct_ops/hid_device_event:
  - schedule a bpf_wq, which calls hid_bpf_input_report()
  - once this struct_ops function terminates, hid_bpf_input_report()
    immediately starts before the next event

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 16 ++++++++++++----
 drivers/hid/hid-core.c             | 16 ++++++++++++----
 include/linux/hid_bpf.h            |  3 ++-
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 709403340fd7..3ab513fba3d2 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -492,24 +492,32 @@ hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz)
  * @buf: a %PTR_TO_MEM buffer
  * @buf__sz: the size of the data to transfer
  *
- * Returns %0 on success, a negative error code otherwise.
+ * Returns %0 on success, a negative error code otherwise. This function will wait for the
+ * device to be available before injecting the event, thus needs to be called in sleepable
+ * context.
  */
 __bpf_kfunc int
 hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum hid_report_type type, u8 *buf,
 		     const size_t buf__sz)
 {
-	struct hid_device *hdev;
 	size_t size = buf__sz;
 	int ret;
 
+	ret = down_interruptible(&ctx->hid->driver_input_lock);
+	if (ret)
+		return ret;
+
 	/* check arguments */
 	ret = __hid_bpf_hw_check_params(ctx, buf, &size, type);
 	if (ret)
 		return ret;
 
-	hdev = (struct hid_device *)ctx->hid; /* discard const */
+	ret = hid_ops->hid_input_report(ctx->hid, type, buf, size, 0, (__u64)ctx,
+					true /* lock_already_taken */);
+
+	up(&ctx->hid->driver_input_lock);
 
-	return hid_ops->hid_input_report(hdev, type, buf, size, 0, (__u64)ctx);
+	return ret;
 }
 __bpf_kfunc_end_defs();
 
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 5a5fa4a32cbc..b45d060f68c2 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2027,7 +2027,8 @@ EXPORT_SYMBOL_GPL(hid_report_raw_event);
 
 
 static int __hid_input_report(struct hid_device *hid, enum hid_report_type type,
-			      u8 *data, u32 size, int interrupt, u64 source)
+			      u8 *data, u32 size, int interrupt, u64 source,
+			      bool lock_already_taken)
 {
 	struct hid_report_enum *report_enum;
 	struct hid_driver *hdrv;
@@ -2037,8 +2038,13 @@ static int __hid_input_report(struct hid_device *hid, enum hid_report_type type,
 	if (!hid)
 		return -ENODEV;
 
-	if (down_trylock(&hid->driver_input_lock))
+	ret = down_trylock(&hid->driver_input_lock);
+	if (lock_already_taken && !ret) {
+		up(&hid->driver_input_lock);
+		return -EINVAL;
+	} else if (!lock_already_taken && ret) {
 		return -EBUSY;
+	}
 
 	if (!hid->driver) {
 		ret = -ENODEV;
@@ -2079,7 +2085,8 @@ static int __hid_input_report(struct hid_device *hid, enum hid_report_type type,
 	ret = hid_report_raw_event(hid, type, data, size, interrupt);
 
 unlock:
-	up(&hid->driver_input_lock);
+	if (!lock_already_taken)
+		up(&hid->driver_input_lock);
 	return ret;
 }
 
@@ -2097,7 +2104,8 @@ static int __hid_input_report(struct hid_device *hid, enum hid_report_type type,
 int hid_input_report(struct hid_device *hid, enum hid_report_type type, u8 *data, u32 size,
 		     int interrupt)
 {
-	return __hid_input_report(hid, type, data, size, interrupt, 0);
+	return __hid_input_report(hid, type, data, size, interrupt, 0,
+				  false /* lock_already_taken */);
 }
 EXPORT_SYMBOL_GPL(hid_input_report);
 
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index 3872c6fac62b..1e450d38e239 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -71,7 +71,8 @@ struct hid_ops {
 	int (*hid_hw_output_report)(struct hid_device *hdev, __u8 *buf, size_t len,
 				    __u64 source, bool from_bpf);
 	int (*hid_input_report)(struct hid_device *hid, enum hid_report_type type,
-				u8 *data, u32 size, int interrupt, u64 source);
+				u8 *data, u32 size, int interrupt, u64 source,
+				bool lock_already_taken);
 	struct module *owner;
 	const struct bus_type *bus_type;
 };

-- 
2.44.0


