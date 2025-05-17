Return-Path: <linux-kselftest+bounces-33248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BA8ABA9FE
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 14:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF8A1B625EE
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 12:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E1915B135;
	Sat, 17 May 2025 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJT3wMEA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DE82B2DA
	for <linux-kselftest@vger.kernel.org>; Sat, 17 May 2025 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747484145; cv=none; b=I7GoTHNkPnfXIDl1nLWErVML1uF23h9r4ch5FHUbAsMIE68fsTH0QufD54sdPmO5QoG8bJqw3kARjfNOcfMeQzP33JnGn8SK9hh+NZLPeSdIPl03b9VyA+U6WIYLKxcsFjN9BRjMpKlrFJiI2zt+ddwHuwnP0kSRNBEWlhAubJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747484145; c=relaxed/simple;
	bh=v6aJtGI/gJei4sR4l9jO3KUUlQfqrTfTxF3qFKafwQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Purwyt10VPC5+l+d1mIW+OjOTve7SjVv5XlMkw9T2+XqMDmpxThYXlSx68gtIcbU1VHEZDLn8M4d8gI9w/9vCYQWe5I3NR4QihHBSTSCqIw9B5rUPiUhtNnpM5/5HV+Hvf9RLXFeKAHwHDH3rJApk9Q235yJnGXM/waUX0ynLLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJT3wMEA; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30572effb26so2742636a91.0
        for <linux-kselftest@vger.kernel.org>; Sat, 17 May 2025 05:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747484143; x=1748088943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L3PURKzMmySLXa163LLM7D3/spF36tXOR9uSznKHgjI=;
        b=CJT3wMEAUrQhzULqbr3EdmsM/c0dpMCTr8fMYO8GVaKcKFKVE/fZA4ogpHtIRyg3M/
         nKVkm0/uB41r83unGkJvw2oj4fffYTUlyc8Fbu4B8d15ifppwC8sQTb1BiPDcew1ieKK
         pMfTU/RYx4ikDn8HX22qyBN2t65Y7SttoE6sGri9VZtO8qW1Kj1n35Niddi/FxZiXIKt
         IC4IRhXlF+JO4FE50VM9JFTTUIhZ6czmo8Cob/bb3RlG9Q822KE4fYIMYgVGDSXeFxTM
         JoYWl7ckkCPx2DcGYect5O3k7Ec8N8O+Q+V7d5NG+t8La+QfIGQpcELRCPP7xScDrks4
         huHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747484143; x=1748088943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3PURKzMmySLXa163LLM7D3/spF36tXOR9uSznKHgjI=;
        b=qUAmrKWdJP9RbH5poXyQg2rHuUBk/CJEnD1sCfs+7xZmQDPi8r7xmpwbVjIqTkWG6D
         ZqUPESfRPwyr+D9KmYNg8gYKHsTGMydF1jyXddllItcXr+MmnFsX6OdSPz46UZn5LnHx
         lbkuwUrBi065zHtYDRzsv7hi+UKkKQNHXdKHuXc3s3ZfiVsG1lrr4FJxVEuSwpJAnv3f
         2ScKrd422zczoZINELpTZQsQaMLbGKVn6i428+EMSF89iVfHL3upwZTs7cejEdCiGsTs
         spc/dzdY2E6OpzIqTEBLlzjhKTSxbEa0dSGu5/00wJU3VVT8ghKtpw3DiroKh/Ey9iJw
         +JHw==
X-Gm-Message-State: AOJu0YyGh5UqBpW5x8mYEDMHgGMehqkosDhAs/PHU+C+3gmUVxpwWAzh
	o2OUnx/4Jw9+Gw+B4hph+qQkcC6GVs2bHD8n3JNWHLoOecnHotJ+vei2DfJ9kQ==
X-Gm-Gg: ASbGncsNXQ0M6eWkMDHg5a8NFLaf170mLzEysUcbZkXPmSqm/YTn1n6QJMIN8hd294a
	SxE2bH268SvjL0WvyZ8j1Xj1Nfa66eYF6pmbgaOfU7/ZVYSQinC/iMM6LjkqEoZGPVONj3mlQOx
	EXSldavNv6Y8+PuBBicpOd34FQa6CzvXB0Qe8ulXCy331vubKVFLdqW3DBZ0sPJEa6W422f4GWN
	v5+TgEVghDJoBaBVIWkjkOmQZfUFTaIKUF/Dq5wnf0bs9NviqkLTa6amzRKsAfzL/mWYM3NoPiH
	u4AmGd/o4KtPSSlOtkbSkzKeuneeKpKS0aT0US1iUqv9YNKOeYaF
X-Google-Smtp-Source: AGHT+IG2fmJGaxDpwDg+aXtINmaHAno98TKGFPX9963kSvbf5YDP/01HSx7IeD6qlLYNQOQ12PY5pg==
X-Received: by 2002:a17:90b:5603:b0:2fa:228d:5af2 with SMTP id 98e67ed59e1d1-30e7d53fa9cmr9432312a91.15.1747484142680;
        Sat, 17 May 2025 05:15:42 -0700 (PDT)
Received: from skc-Dell-Pro-16-Plus-PB16250.. ([139.167.223.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e334016e7sm6907081a91.9.2025.05.17.05.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 05:15:42 -0700 (PDT)
From: Suresh K C <suresh.k.chandrappa@gmail.com>
X-Google-Original-From: Suresh K C
To: linux-kselftest@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	suresh.k.chandrappa@gmail.com
Subject: [PATCH] docs: msm: fix grammar and spelling in crash dump format
Date: Sat, 17 May 2025 17:45:09 +0530
Message-ID: <20250517121509.104933-1-suresh.k.chandrappa@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suresh K C <suresh.k.chandrappa@gmail.com>

Fixes minor grammar and spelling issues in the MSM crash dump documentation:

- Corrected "uinque" to "unique"
- Changed "Set of registers values" to "Set of register values"

These changes improve clarity and maintain consistency with kernel documentation standards.

Signed-off-by: Suresh K C <suresh.k.chandrappa@gmail.com>
---
 Documentation/gpu/msm-crash-dump.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/msm-crash-dump.rst b/Documentation/gpu/msm-crash-dump.rst
index 9509cc4224f4..6a7a947044ee 100644
--- a/Documentation/gpu/msm-crash-dump.rst
+++ b/Documentation/gpu/msm-crash-dump.rst
@@ -70,7 +70,7 @@ ringbuffer
 
 bo
 	List of buffers from the hanging submission if available.
-	Each buffer object will have a uinque iova.
+	Each buffer object will have a unique iova.
 
 	iova
 		GPU address of the buffer object.
@@ -83,7 +83,7 @@ bo
 		Trailing zeros at the end of the buffer will be skipped.
 
 registers
-	Set of registers values. Each entry is on its own line enclosed
+	Set of register values. Each entry is on its own line enclosed
 	by brackets { }.
 
 	offset
-- 
2.43.0


