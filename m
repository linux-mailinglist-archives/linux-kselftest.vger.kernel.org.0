Return-Path: <linux-kselftest+bounces-36973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DA4B004AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 16:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F0C4E34C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 14:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A167273800;
	Thu, 10 Jul 2025 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKMtGCzz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2952737F3;
	Thu, 10 Jul 2025 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752156147; cv=none; b=FE2UQ86aHs8jc3raAeH6mTFdMYGTvy/ATUl6HWSIQzIhMf7GUjukRqZHSBBTSP31gE8qUSjUjWtocbPT03Rn4czyAcLnwm467/hywJ/MJMUzdGqBpUDvnsn96VWDmJ1ah/bJxFUM3nvGVvkOdOt+BMijTGNWYOA/Bo7T4eJ7Eqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752156147; c=relaxed/simple;
	bh=ln3XynQ38sbyzJkbc6ukGWTXFvmEi9JBe++zC7jvuHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WyfZmgGQNO5+L0XJgbDZbVbLssITRScvvu/uE+90m/X18wobDlOC9bajtSk6CG7fjlAbrpVwMEYZkB0EpeAfR//2Au8zmt2tucZOZuZcEwmyBMnQPQgGpEn/xTZdTJIILkBhn7gwtOboirKg4ZBaz4eGqyWkq6bJT3KT/Z4AKh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKMtGCzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC03FC4CEED;
	Thu, 10 Jul 2025 14:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752156146;
	bh=ln3XynQ38sbyzJkbc6ukGWTXFvmEi9JBe++zC7jvuHA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VKMtGCzzm1SKJT3oBGHtqWOeuXPbV2yLtOv9CytCGAyfHC8Dev/pSNqY16QZZFCeK
	 dHTVa47uSrehaKnUjsSOG28pyC++k6fR9rMgWtd0hR4ENFKGfKDLkQvxsh4gF11PXI
	 r6QrhSar2d+hGWtqdaIXLEPi023IyHaOE03hJmEQ6egpkRoh5lbhC7ZR/EAvRTbZQv
	 Vd7KP4hTe9UEPCg81AiDGwwW7YpJzFUOeNQb8VXxE/qGXujG8XPHhAYGy3uO4VgzBS
	 dLbefliNlQEwT9YJtKJYm0994ggMZN7OCDZbVxm7CWL8+VDFUFtW0iEJ+AENaO86YL
	 sQcfoo45Vwa0A==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Thu, 10 Jul 2025 16:01:35 +0200
Subject: [PATCH v2 3/4] HID: core: do not bypass hid_hw_raw_request
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-report-size-null-v2-3-ccf922b7c4e5@kernel.org>
References: <20250710-report-size-null-v2-0-ccf922b7c4e5@kernel.org>
In-Reply-To: <20250710-report-size-null-v2-0-ccf922b7c4e5@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752156138; l=1215;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=ln3XynQ38sbyzJkbc6ukGWTXFvmEi9JBe++zC7jvuHA=;
 b=jKAc4d7acUg913xWdSGyq+whZiXJ0uwYVSpIfKFOOOUQc50QR6pTwqQfPTDHbgUdVimeZsVeQ
 NnfTfSXQz4uBpg+InzixicxJi9SJmF4r1qZmDJAy5rO9LRKW07Zxi/q
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

hid_hw_raw_request() is actually useful to ensure the provided buffer
and length are valid. Directly calling in the low level transport driver
function bypassed those checks and allowed invalid paramto be used.

Reported-by: Alan Stern <stern@rowland.harvard.edu>
Closes: https://lore.kernel.org/linux-input/c75433e0-9b47-4072-bbe8-b1d14ea97b13@rowland.harvard.edu/
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/hid-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 320887c365f7a36f7376556ffd19f99e52b7d732..b31b8a2fd540bd5ed66599020824726e69d10d75 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1996,8 +1996,7 @@ int __hid_request(struct hid_device *hid, struct hid_report *report,
 	if (reqtype == HID_REQ_SET_REPORT)
 		hid_output_report(report, data_buf);
 
-	ret = hid->ll_driver->raw_request(hid, report->id, buf, len,
-					  report->type, reqtype);
+	ret = hid_hw_raw_request(hid, report->id, buf, len, report->type, reqtype);
 	if (ret < 0) {
 		dbg_hid("unable to complete request: %d\n", ret);
 		goto out;

-- 
2.49.0


