Return-Path: <linux-kselftest+bounces-36972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A15B004AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 16:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B66448464E
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 14:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142B8272E4E;
	Thu, 10 Jul 2025 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rd3znu73"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89E6272E41;
	Thu, 10 Jul 2025 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752156145; cv=none; b=BKI+sQVj86vPMbP8lhEfzhvCo2zIR/m1x8+ZlwXBQMZ6X9MiLov58K1EvppEx9oIiMl1mVaUupOl47to2S5Vxw4BVxG1hBweRVb1Rwx+KRygPZeRr/KwyF6wjqKzkMv1T9a3qqDGpiP03ZOH9htNTIA4bC9p2HYV74Ev1UIepNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752156145; c=relaxed/simple;
	bh=L8+bJF4j7IK17zKC3J3eZHMafR8FtMP0+RphfMVg0FU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iPMSWJNFSMBXPzoAWLPGGDr3e/0+jjkMUshdOheYd/XVGZztHA+/Ykd2daJkNFVBbh7RKCWMjOcNIbL0oPeA0WE85ezDhrMpiKKwiIcf/OVJheMTjD1Zg31DC4kcSSnuJRbytYuYm2fVR1HlhYVfuyUarHet3FpFIZ4Jj3dxxBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rd3znu73; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9F7C4AF09;
	Thu, 10 Jul 2025 14:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752156144;
	bh=L8+bJF4j7IK17zKC3J3eZHMafR8FtMP0+RphfMVg0FU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rd3znu73D1SyxHcxxNwyHZr9xTkaOys2N6r6jYRcQwUIP7WfIqhnl5LSj0Lffhq5m
	 QMEp6gBIbu3uJoje9fZUo7GEB45E3BQ+b00nLUfAfQVBNwC6vD46Bwro25S0N2yUdU
	 lVU5B/rs946fxlNt1+LAgmI2VHIxV26fCuvi+jOllGThFNWz/S8pW5zYfRSMFdDo9f
	 OuKUtk73P6ViNIZU7A+BQatVRqJj5+CKysdNOr8/rQWu0Z1sN8Iq7Tr3VmA+bKU/PT
	 FtQaHl9UpOCHylpD564U1qZKAUCSjWMRlWFI4nPOAvrLcKj6mpPdYHl38ZaM5b/dEm
	 hpXLfgsYdXUdg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Thu, 10 Jul 2025 16:01:34 +0200
Subject: [PATCH v2 2/4] HID: core: ensure __hid_request reserves the report
 ID as the first byte
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-report-size-null-v2-2-ccf922b7c4e5@kernel.org>
References: <20250710-report-size-null-v2-0-ccf922b7c4e5@kernel.org>
In-Reply-To: <20250710-report-size-null-v2-0-ccf922b7c4e5@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 syzbot+8258d5439c49d4c35f43@syzkaller.appspotmail.com, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752156138; l=1990;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=L8+bJF4j7IK17zKC3J3eZHMafR8FtMP0+RphfMVg0FU=;
 b=p8JpT/l6x6L7bc9rN5/cXJGtW5BtwLcKq2m0Aam/11DpM8UFb06HMOdiuVT7u1F8mguZrKnT6
 437kFiGm6Z6BAnt6BIu3sjrxd0bMS0C+xngaorK+zRbPVIUmbhUDD9b
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

The low level transport driver expects the first byte to be the report
ID, even when the report ID is not use (in which case they just shift
the buffer).

However, __hid_request() whas not offsetting the buffer it used by one
in this case, meaning that the raw_request() callback emitted by the
transport driver would be stripped of the first byte.

Reported-by: Alan Stern <stern@rowland.harvard.edu>
Closes: https://lore.kernel.org/linux-input/c75433e0-9b47-4072-bbe8-b1d14ea97b13@rowland.harvard.edu/
Reported-by: syzbot+8258d5439c49d4c35f43@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8258d5439c49d4c35f43
Tested-by: syzbot+8258d5439c49d4c35f43@syzkaller.appspotmail.com
Fixes: 4fa5a7f76cc7 ("HID: core: implement generic .request()")
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/hid-core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 1a231dd9e4bc83202f2cbcd8b3a21e8c82b9deec..320887c365f7a36f7376556ffd19f99e52b7d732 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1976,7 +1976,7 @@ static struct hid_report *hid_get_report(struct hid_report_enum *report_enum,
 int __hid_request(struct hid_device *hid, struct hid_report *report,
 		enum hid_class_request reqtype)
 {
-	char *buf;
+	char *buf, *data_buf;
 	int ret;
 	u32 len;
 
@@ -1984,10 +1984,17 @@ int __hid_request(struct hid_device *hid, struct hid_report *report,
 	if (!buf)
 		return -ENOMEM;
 
+	data_buf = buf;
 	len = hid_report_len(report);
 
+	if (report->id == 0) {
+		/* reserve the first byte for the report ID */
+		data_buf++;
+		len++;
+	}
+
 	if (reqtype == HID_REQ_SET_REPORT)
-		hid_output_report(report, buf);
+		hid_output_report(report, data_buf);
 
 	ret = hid->ll_driver->raw_request(hid, report->id, buf, len,
 					  report->type, reqtype);

-- 
2.49.0


