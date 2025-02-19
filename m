Return-Path: <linux-kselftest+bounces-26929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A6AA3B03E
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 05:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3820F1891DD7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 04:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7879516D9AF;
	Wed, 19 Feb 2025 04:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6ruJuMl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CD7286289
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 04:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739937973; cv=none; b=CrGh8qc2GUESlbBFjkjjUpy0aw4fOA1jQab10C3rrILFRIvMwWN3fuW9pePdfJocg5Kzy8oGA8yQx90ck8wSSecPTr4lzodLtJITp5+nrQrIxv5VXXb54VxWmX7awwodfjszMLgpUg9yMgZTlNU13JXiNAWrTU3w0WlXJ7YdaPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739937973; c=relaxed/simple;
	bh=LY909uE20HGY8kbg7QsQ+Tfz4kh5u73Tnd8efP6URZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fpcDQnw3hNXcu+Xa3uSC/FiVChRFk+MGODY8PmDkeQUgYYaKcY76VmQz/hCVWeAUTggpnUc6iqEtvrwFHLN7fZ4Cvch+s/FJsa4nLxgCsDifbSQaZ6iVLh9bpJbCYH/CsZK+Ol1bliWxr5ggFN64VjEXq6mFas4CK4xWBcZD8jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6ruJuMl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-219f8263ae0so114440485ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 20:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739937971; x=1740542771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cGCD8Xmo4CTXqvRSBwD5tpydeLKW3NyH+g1I9UkvPF8=;
        b=E6ruJuMlC7fwHiY24FxccFBDGmI+gG+M0uqH4Oq1iSO+8SsAFgTxA4NNkSUxntrrOl
         upb3IZ/kKpb7Cs++5nvLIYhTWUrXdR87FJSeH5CuNn1KlAs2pFBHmSjN0xWleH2rh81n
         39QxsUF9WvMU1do2CyE6zsgmNUw+1mrDk1S8b42y3QfdD4iQofTkU9k+WE7+jFt3k5Hg
         E0ci+eXFroGr9UWj1Ct/UZevVSx0vUDdxdbeolsUuY3V6hHOrh7hOD1kqxL7x7sgrWAQ
         OCkbpFyOVz5LPHzv6dKcwRmngTVyYWeVpKaPJle0sjeIlrECmNO51F/1HLuk0OIwQjdq
         h6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739937971; x=1740542771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGCD8Xmo4CTXqvRSBwD5tpydeLKW3NyH+g1I9UkvPF8=;
        b=K3KycHPx31LcapGP5oRvDl559A8QwsfeTl/harZznBekn6+JpaE1s439FxOej5UhHN
         LTnw5taWFGzkwe5zTHlkveOjz8AmSNxflJNdUzf1ZJ4viuEnVqufdHlp1q7hB4p+/WRt
         /ceW9Wx7/0Agae6VjJZ2mY5g8aXZYJbOIWUJeR111il5ByOLYmjhAda1B0G7RVYiqAKF
         QZKCn5sxd9XQLFUGhPvjK7CuScTN8UTosHtL0arejn9ClJ4uMAvjMe15lr/GLL+RF+Gu
         NqY/qpAxvyaKb2QzS5Aou/lWTDYs7fMDwQgrWrC8I7mOwAEGnrLVKUSDrWcz+kxgd9xn
         bq5Q==
X-Gm-Message-State: AOJu0YyqCEc69B59eJ0TlOPSAqUoxk6+DTn6vfrnuRZ+i21UDFGuRtLG
	aIOMtq9QHQLd19Bq2/TxqNGLX4wmCJ5c6xIGv4UT4k4W8P3ujums
X-Gm-Gg: ASbGncuFBYXZipgGTyCGS1SBuwkoNDvJ7leLD1MXGpYwrTtRph/QYf22TPtptq9fnlm
	CGYNt5PpsKgA+97NQa2Zgwlrb/+SbBEqhXRtIjmEDSZ2k6RfT0v6MvWivGas3hamtOQOuG5oN5G
	jyHa7MNO6Jn+v6eZl4tKz2HHYJxF2aQzzr2Bd0QzmScTUIwXfRcOu5tUHpspgLxyoNW157ARU21
	8In/l1CBjM/iEgEdb+8lC7d5ft9Kzsysm74j4NhX0qiJjUYJrSPVzhwXUpu827JjXtx3dJHiw50
	6WjOJXRREoXAmW7iuaHXJiwIQTKlFNgMWs15HuI=
X-Google-Smtp-Source: AGHT+IEJo5xx38QelHQ3VismoM+WbmQd+Pv73e1M94U1VKsMxtpOT03lAb8m33HD4OV99iK9FPBEPQ==
X-Received: by 2002:a17:902:ce89:b0:21f:6c81:f6c with SMTP id d9443c01a7336-221040bdab7mr272925205ad.41.1739937971166;
        Tue, 18 Feb 2025 20:06:11 -0800 (PST)
Received: from ritvikos.localdomain ([49.36.192.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5596133sm96625285ad.259.2025.02.18.20.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 20:06:10 -0800 (PST)
Received: by ritvikos.localdomain (Postfix, from userid 1000)
	id 8408EB8D541; Wed, 19 Feb 2025 09:36:07 +0530 (IST)
From: ritvikfoss@gmail.com
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] Fix SC2181 warning
Date: Wed, 19 Feb 2025 09:36:07 +0530
Message-ID: <20250219040607.17125-1-ritvikfoss@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ritvik Gupta <ritvikfoss@gmail.com>

Check exit-code directly with '!' instead of '$?'
to improve readability and fix SC2181 warning,
reported by shellcheck.

Signed-off-by: Ritvik Gupta <ritvikfoss@gmail.com>
---
 tools/testing/selftests/kselftest_deps.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest_deps.sh b/tools/testing/selftests/kselftest_deps.sh
index 487e49fdf2a6..2a4720723ebf 100755
--- a/tools/testing/selftests/kselftest_deps.sh
+++ b/tools/testing/selftests/kselftest_deps.sh
@@ -262,8 +262,8 @@ then
 	for lib in $test_libs; do
 
 	let total_cnt+=1
-	$CC -o $tmp_file.bin $lib $tmp_file > /dev/null 2>&1
-	if [ $? -ne 0 ]; then
+	if ! $CC -o $tmp_file.bin $lib $tmp_file > /dev/null 2>&1
+	then
 		echo "FAIL: $test dependency check: $lib" >> $fail
 		let fail_cnt+=1
 		fail_libs+="$lib "
-- 
2.48.1


