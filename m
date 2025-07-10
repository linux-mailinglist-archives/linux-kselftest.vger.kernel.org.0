Return-Path: <linux-kselftest+bounces-36971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9998B0049C
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 16:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741071889E64
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 14:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A182727F3;
	Thu, 10 Jul 2025 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYcut2lz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0155D271A9D;
	Thu, 10 Jul 2025 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752156143; cv=none; b=gNpw2HgVBJEsQ35sRR9ZdGLaRgSfS+Gs7eDnE8XI7vrEG+WoaXdZbLURkaojhsC+lKjimlBesKSEIYtHgTMOWIyNO09uT1atGdoauNZlZL+j4oNsRkSEqhG3uMVlOFY3zPLks4VvcpX6JGnD3Y/f9PvkHSjL+XeyfV6G3TZJkhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752156143; c=relaxed/simple;
	bh=Co8as0JEy3sYgEqTMquGxvLRQOzjREC6NPEM+EJDGaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zlfi/yewHugmNgSwBCAyMgqar8ZmgTBmqz6lSAGJr2Nf+UElOCb+c64plbFQ1y/16fNDQMUxKFw8uRWlRbNK0WpwSiBJGpTDEnfl8QQcWKUpPxY3zrMvDHb4l/4QF1caBAfDNp1r5wYr49HKtx1kXEl6AGkZvY6NDVIO42bJiz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYcut2lz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02684C4CEED;
	Thu, 10 Jul 2025 14:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752156142;
	bh=Co8as0JEy3sYgEqTMquGxvLRQOzjREC6NPEM+EJDGaA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IYcut2lz3QhniyOh45T7rE82xKzsV9T4PrOO2G9ZbSpCTsOqqbvGmijeO6W2V7EWY
	 Ts8rp8KA4XZ4D3tC2jRDQvJNu6bl+EUfUMHOGGZH+ZOgAp7wKImOvUPTsCTr8FhNc2
	 XdBSPgoizJP2ZbwXQ8/pStte9APz95iRRHC7L5uisuEpkQRW69zrLyikXOhzOAd3/I
	 xF4ZVZouTvnIjbIol+vWKutwb4uzrMNtSOffQ/hBnnkhMALymPx6dnYZQUDdkINxWZ
	 zbxfoctMPE05jIJbLn4/JK6QIqNDpe2xV+RTwQEQUdbAi5LShqgdTdt7mz3+5tA4p1
	 ggQGnih5S82fw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Thu, 10 Jul 2025 16:01:33 +0200
Subject: [PATCH v2 1/4] HID: core: ensure the allocated report buffer can
 contain the reserved report ID
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-report-size-null-v2-1-ccf922b7c4e5@kernel.org>
References: <20250710-report-size-null-v2-0-ccf922b7c4e5@kernel.org>
In-Reply-To: <20250710-report-size-null-v2-0-ccf922b7c4e5@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752156138; l=1423;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=Co8as0JEy3sYgEqTMquGxvLRQOzjREC6NPEM+EJDGaA=;
 b=gPC4tV0NRIY4GQ0pGBpc/9NTIFhSSe5QHrzI2IP5DHO6ZmQWtA4O77giACqp8cb96JJlGtrg3
 JSyhRg7/pzrDneito10Pd7p+CC6XdNF8sK3OYowYoaMCUyoLjqRtNid
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

When the report ID is not used, the low level transport drivers expect
the first byte to be 0. However, currently the allocated buffer not
account for that extra byte, meaning that instead of having 8 guaranteed
bytes for implement to be working, we only have 7.

Reported-by: Alan Stern <stern@rowland.harvard.edu>
Closes: https://lore.kernel.org/linux-input/c75433e0-9b47-4072-bbe8-b1d14ea97b13@rowland.harvard.edu/
Cc: stable@vger.kernel.org
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/hid-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b348d0464314ca331da073128f0ec4e0a6a91ed1..1a231dd9e4bc83202f2cbcd8b3a21e8c82b9deec 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1883,9 +1883,12 @@ u8 *hid_alloc_report_buf(struct hid_report *report, gfp_t flags)
 	/*
 	 * 7 extra bytes are necessary to achieve proper functionality
 	 * of implement() working on 8 byte chunks
+	 * 1 extra byte for the report ID if it is null (not used) so
+	 * we can reserve that extra byte in the first position of the buffer
+	 * when sending it to .raw_request()
 	 */
 
-	u32 len = hid_report_len(report) + 7;
+	u32 len = hid_report_len(report) + 7 + (report->id == 0);
 
 	return kzalloc(len, flags);
 }

-- 
2.49.0


