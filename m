Return-Path: <linux-kselftest+bounces-7578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1531689FE25
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 19:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D281C21FCA
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 17:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D76517BB37;
	Wed, 10 Apr 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpNx8O69"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDCD17BB30;
	Wed, 10 Apr 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769594; cv=none; b=PICA5ZWL4mwGZmpbghMv/N5531RFXyC+tXsCQa6Qnmc02K+3QzvfXvR9yqC5p9C9WC3BOVDhG7KYZsjBcGkzV85BeFYB20ArulcTKHrFeHfQ/hXJXrALs9oXOjGyeKzkDmYZLRdBYOD6UcSjoSqB3oKPlNJWzBeJJRB/3y2H1zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769594; c=relaxed/simple;
	bh=KsZw3etfLaKHH2rg/n8zRwwG7f+ZJgP0Ctx+1hM+nNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NAONXRj2OaFCaBV8Z30fIigxxgR5M7hDf1CPC0Ofi9sl0G7exvG6Td+Z1i/iHu6CjvxYK8jnj/NVKnL9q9dehWq1G78I6259b7iqJYCRVfhHDbTLDIFxuXOD1Cr1Ytbf5MpuhZ1DuOMfrmxnrkCXTzyjObMHZbuB4fNxMcNPKFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpNx8O69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE39C433A6;
	Wed, 10 Apr 2024 17:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712769594;
	bh=KsZw3etfLaKHH2rg/n8zRwwG7f+ZJgP0Ctx+1hM+nNQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jpNx8O69ehKmFositRJB6R86vNtB2ovuhA5Y3gorWWNchOjkNgb+SqStB731PJwF5
	 iBxR0YUJFh0/a6YNeuKNYoGEPuVcfZhsrWjqK+LtTLeCtqIrPmTnL3Kaj7AXQZ6Dcb
	 jtxjpK4VGAdzZVztrHJt2PvdUKLrunT7MVPFtvRfYlxfEgTLaLYRGQ2nv0m+u5K9Gp
	 +5peGg4apX4AHVrAIlY5nBesaxZWPm6MjT3rOQUY6QP20Grucivc6gT3gmK9FXcHRO
	 DM7dx+MAsmImtPOFrFO6Yge3y+QEKfZIhTmKygGrugpx/xVRRqwmFOu2iET/StYQiJ
	 v0WUxyB3nLMrQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 10 Apr 2024 19:19:21 +0200
Subject: [PATCH 01/18] HID: do not assume HAT Switch logical max < 8
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-bpf_sources-v1-1-a8bf16033ef8@kernel.org>
References: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
In-Reply-To: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712769589; l=1080;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=KsZw3etfLaKHH2rg/n8zRwwG7f+ZJgP0Ctx+1hM+nNQ=;
 b=JPPlgg5xA03dGvEoFMmWtqh12ox55NRqUBzewkucEmNjAG/XQlflf8Ogdb/rEMY2Cyaysxbyf
 B2tI1VnDlT1DPSXSDhAP43H4sXc3ztJFAefeyUhygIouB4Kz7ZuDk5C
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Turns out that the code can handle a greater range, but the data stored
can not. This is problematic on the Raptor Mach 2 joystick which
logical max is 239. The kernel interprets it as `-15` and thus ignores
the Hat Switch handling.

Link: https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/issues/17
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 include/linux/hid.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index b12cb1c8e682..8e06d89698e6 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -474,9 +474,9 @@ struct hid_usage {
 	__s8	  wheel_factor;		/* 120/resolution_multiplier */
 	__u16     code;			/* input driver code */
 	__u8      type;			/* input driver type */
-	__s8	  hat_min;		/* hat switch fun */
-	__s8	  hat_max;		/* ditto */
-	__s8	  hat_dir;		/* ditto */
+	__s16	  hat_min;		/* hat switch fun */
+	__s16	  hat_max;		/* ditto */
+	__s16	  hat_dir;		/* ditto */
 	__s16	  wheel_accumulated;	/* hi-res wheel */
 };
 

-- 
2.44.0


