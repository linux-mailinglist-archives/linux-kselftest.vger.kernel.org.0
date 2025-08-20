Return-Path: <linux-kselftest+bounces-39365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1BEB2D82A
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 11:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 596F14E2134
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 09:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E8F2D97BB;
	Wed, 20 Aug 2025 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvT7Hya3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FF31B4233;
	Wed, 20 Aug 2025 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681941; cv=none; b=kSI4UWbabvsaevLyhCXtrQ/p1omN3lbGvHK+u4xJMZ9vr7LRNljO0ejiKUfWOXiTwyr90Qa5UPwn02W7nMRPJ/iumAwC9s2LtNC6wHp1asVI+IPKZ0wxLARSDVWBUEFN20LmUdWM9xNvvebVWd8RJ7CWFMERMzSpPcF2ABH3tpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681941; c=relaxed/simple;
	bh=je5AHg/youKOa+xhCXnHlhnCi4E0rhPm8H3bXUt+7zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WpXP8zbL5tc2QVTTSavkpCRTnC2718HU6yrlemzvOMIm7mA+NW2xiJnxTE7pLREg14PAUB2in/tgFYiNn3aX99Rs0ULOs49PnmcVGjibykgWZrUIJpEHVqvJ5K9eWa54ee9ePI48dCvPNxOUDfRILmtqrKMtxyxBMhsFzeIuCiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvT7Hya3; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32372c05c5dso2694707a91.0;
        Wed, 20 Aug 2025 02:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755681938; x=1756286738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=moqMZqhapfuLQfkSPWKxhFFyVYs5GkMX6FHp/4+cuAI=;
        b=CvT7Hya3j68rWwf3Pplp22TEXEw5oAZE9wWfGywrYxAGb6A+JSiKoguZrVZ0rlQrG0
         L4bC+VAaC+k6EJ2XGD80snxLdYUqi9EH4fH8vEI1U13cGuOfDnPLzpm2vbDE2TRHX2dl
         bb2MyDpJnUUDSjUX9zdusMcoVK6+WnlZ5b5sDap1RczzhAZ5aluqK2AwT97K4vrpm3U4
         N6ejKA35MJIdg77401a0gECB622YPfbOQGhAU//L+V9g8Vos3vGArQhI9NITFA2wskyq
         gQqyz/JY/UsJmHIaci/C1TRKDSPP/0j2A4XkKDlth8ptC+qKCR2lmtez+TJBkUz2yCgw
         mSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755681938; x=1756286738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=moqMZqhapfuLQfkSPWKxhFFyVYs5GkMX6FHp/4+cuAI=;
        b=noH0yAYOWZJcQSLJuderCA/43ddvfT2Sk3jESEkwb9zzmnJ8uDIQyaZ7/jzWA1auPx
         qSAQREPJM/tVntPEayDxcoZ3mUMp9UncZJylWk1JAvRVf4LT7suF3IDnIH2SBrnRxBdt
         Anud/+VlsG8CZKYF7YmVmZ8HOojiWeQo4mRhiYdOMD4KqydRoekofLn5qNWZzAFI4stH
         ejyBk+cuqcG6AS3nQ0UlTnp070zVmMS5l8kZX86In4hqByfFswLpgYLaeDczthoSXJ6u
         PVXuc/wYsCKaHzfYpEQMmqKt0cbO8uYg/lbMhAu6AvTQu6JAwr0CMYfOPDdV8TifENpM
         58xw==
X-Forwarded-Encrypted: i=1; AJvYcCXfGQLCiWhSG3JOi04JWgUCrP2aurQdTN0XNpUdxwHS/v2jqepfCF16X26HaSpQrEjxpk5xBGO7ktj8KzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8h6tHL51W8MM3VXxn3h77ALV9DVHGnXl4q98fKW/SfZMnNBQy
	x9KPibBaTSxZ8mQXzJu3gHzKOHbAu649BeEx5QneYKYDfqa9W0pIQjm5
X-Gm-Gg: ASbGncs60CstZtJRH3GVi8efeJRLxcO/YjqElw15+d2wqhd9UZqgypFQZEHZIQC1sal
	q5Fs98Zt0EUUZSX32jlOS+EcuWdI11NjYy5hUxgUJDt//RWHdbfp/zYrG1wMM2/B3LlboDcLH0B
	TAl0SXHfUzdgidkdk7b4sN5TrKhnhA+HnsvaZhUsLHT1cV2rY83KHSwBxgUTdLhK2UmtZoDsK/i
	Vrx7aUvAyzMVyQF1SLK9VMTZx8qi96KFzxwTrl1Khen+oEnmILD2rUm2uemi5ZBdD2QVZGMtlIU
	ICRsQzJruIFXjtGKRDNV3dzB2XWsTRh0NrvRx4Dv/yYxAm4ie+bvXfXxIngS6nD6TSEvA6/QXLL
	uHEDm/xJTMkQXDoyV2DhAYVYdiKrDgTJAcw==
X-Google-Smtp-Source: AGHT+IHfofIsMiWoNimXexXoDKvhKGpCqUQtCSn9RIsIQgxCsfV79DHB65P82HThv2L137MX9dVq+w==
X-Received: by 2002:a17:90b:3c12:b0:323:7e80:8817 with SMTP id 98e67ed59e1d1-324e14239d9mr2854023a91.36.1755681938297;
        Wed, 20 Aug 2025 02:25:38 -0700 (PDT)
Received: from OSC.. ([106.222.231.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e252f8c8sm1752044a91.11.2025.08.20.02.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:25:38 -0700 (PDT)
From: Pavan Bobba <opensource206@gmail.com>
To: shuah@kernel.org,
	cvam0000@gmail.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH] kselftests:grammer correction
Date: Wed, 20 Aug 2025 14:55:33 +0530
Message-ID: <20250820092533.10985-1-opensource206@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

corrected a minor grammer mistake

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 tools/testing/selftests/acct/acct_syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/acct/acct_syscall.c b/tools/testing/selftests/acct/acct_syscall.c
index 87c044fb9293..ee2894e4f7bc 100644
--- a/tools/testing/selftests/acct/acct_syscall.c
+++ b/tools/testing/selftests/acct/acct_syscall.c
@@ -22,7 +22,7 @@ int main(void)
 	ksft_print_header();
 	ksft_set_plan(1);
 
-	// Check if test is run a root
+	// Check if test is run as root
 	if (geteuid()) {
 		ksft_exit_skip("This test needs root to run!\n");
 		return 1;
-- 
2.43.0


