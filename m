Return-Path: <linux-kselftest+bounces-26323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA6BA301F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 04:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6743B3A36ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 03:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3141C5D5E;
	Tue, 11 Feb 2025 03:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjItOrxd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4389C374EA;
	Tue, 11 Feb 2025 03:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739242865; cv=none; b=lPP0tWM+7+B6rrC1aBOjoyXmP+/c20LTodHRqIpXlCFoLvHw+Lfdi4XC0rUe5J/Yr6IMsH7UFgNkpnGKwXwGoie++AJPbGxY7uylu4nqt0fCyr/QTggG4JflRpwAimm9ppliM5YowLlGN8ewKbXntgdNh2uS74z3+dIky4cLGsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739242865; c=relaxed/simple;
	bh=cZRSGsPr5NDIpPaoHCeAoLx/Cg6l0wSrIJIyEW42Puc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mOVaxeC0O5xXo6RbsHNi0CJbH5zJlZ41rEARLfR6VhDAwpNmdS4h3Jt5M7WX4YvK0DMwFbcmh2MtwbNevB+lfyPwv+cmZplzFs7n+OMd5741Ioto8QpBUHxGJnFO3Wufs/HcuLuNcMzj2Ncf6GxEmyHY5mOSEVkFE1FGPD/WUD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjItOrxd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so12964565e9.3;
        Mon, 10 Feb 2025 19:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739242862; x=1739847662; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I0+Ftmctz1tHLKGjM2SvsvtPNyMgN+i6G6rr2ncjwYw=;
        b=MjItOrxdIpK9Beqn0GLeYGdPvTYTn6rSyfdBEB++5bPg19oPBSXTPFext8gMkWpykE
         5K++coT/zGq6cxCtcN51VNAX49sjcR5sL4dHqCFtX0UfEkqVdOc6awnAY+cE5VZzKmww
         1M2NLpb/1u3V8flavez9oJetoBSJxbUdJIjKDYE1Ob99FOtmspUTVX+fM80ynafUwpIB
         1Nk1WCNQ08h7kffR6lfPDuJDSf+o4hyYK+DjKQldnmFh6JYKKbB1wT+/XypG4vS86NJ/
         lLsYLEhejK/javnUh8EuJMEg6mqW4Sc+ZMD88JlfRX5kmXGGapP+RSRD9qV95unuASIN
         hACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739242862; x=1739847662;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0+Ftmctz1tHLKGjM2SvsvtPNyMgN+i6G6rr2ncjwYw=;
        b=DIqzlAz76c5jzko1VVCwVzBiUuuNmugXbc8f16SDc821u8Bo6bHtscTjUzIQvl5Zpw
         bMkDBNizm1+GvkMz0qM2edsnj016PudKf0RLpWyjEmPs3i4v+D/D/jk9Ix3Zo067Ghtz
         Dpgp2fRq2kX+96ohWWuTxuAMAsDMZM2ScwsfiSJRgXTelxSWWRjj5e7QBRCjqOl6DTr2
         TOMZR5ndoRZWdrN6VNd6uJOs4MYKbqLEkGLh12vTks1o3HLgjF0kn4sNq2zDYZ2a26OC
         1gnwAvrdXl+JZxbFypijbzEu/jikBzqDSwzeIlyKQbZWKwWtfHhiKyPXpI7I3Cr8Wnc1
         3EaA==
X-Forwarded-Encrypted: i=1; AJvYcCUgy8COySLBYU08ESORVbeJVbX2xu49AQIdAv//pK4soNe6ju0MiRo6PZivl1I8y77F7icu/CqlfuvD9/yaHS78@vger.kernel.org, AJvYcCVqbEsMk1Zg1oHSF2hxHQ65Jv78NZr69TFH8ycy6mCVJ68W3UgthpU6CXGcvrgzLFuVIjKBoRHR4o/GvYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz84ITrCEtPM1dsEfKM8LBgUDL8pXMTtEEDBfp8BOcDCMOjBezI
	xg2GTjAlgO06MEjL9d6a5iCMEe70hnVTwuo/LMyz0ingY1l3u3pM
X-Gm-Gg: ASbGncurzILuWgToRjcvQZoUl3rA+TRg3sWovt9bHxpUs+nY6a4wAagabFjhbqevHfK
	x1P2T4fIikol0T6Z1ZwdCuU7hIRKCaFxapxieCUJucYJUGgvVfQpf3yuu9ZJKUoQIzoGTGAyDQ6
	QEJZpsuBF1BqQxCKD/jsd63fZIHbKirVBECp0N3NtU5dCnUekQCCl4cRa4ERC6ukHnQt2RXQuaH
	Oof62ASxv2kytzU4Wwmv0VVeMpa4Q8W8FXWE7+TlF0Xznb3zGk7yhIpY83Y36qQHjFPqMLEeLLS
	TlKSGb/9MmRkZ6KbJjpcP0waShD0VYwCLRooNw4=
X-Google-Smtp-Source: AGHT+IFQ5ct/eLOgfDv7Qw2gj1n3vazuwUHtEoARoYyP42j6t/7paFBG0Ke21LcKUs+x9M67T3tGLQ==
X-Received: by 2002:a5d:6d0b:0:b0:38d:bd41:2f8b with SMTP id ffacd0b85a97d-38de41bdfe9mr1852527f8f.44.1739242862468;
        Mon, 10 Feb 2025 19:01:02 -0800 (PST)
Received: from localhost (tor-exit-9.zbau.f3netze.de. [185.220.100.248])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38dd4342502sm8153548f8f.26.2025.02.10.19.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 19:01:01 -0800 (PST)
Date: Tue, 11 Feb 2025 05:00:22 +0200
From: Ahmed Salem <x0rw3ll@gmail.com>
To: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, shuah@kernel.org, 
	skhan@linuxfoundation.org
Cc: linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v3] selftests: tpm2: test_smoke: use POSIX-conformant
 expression operator
Message-ID: <nyskb7mbqk2dvlwhez4sua7ryz5gyi73yker6y3qhd4chyyeaw@x6nhqgtxcyvl>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use POSIX-conformant operator symbol '='.

Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>
---

Apologies for my previous mistakes.

Changes in v3:
 - Reword mistaken commit message

Changes in v2:
 - Remove snippets pinpointing the issue 
   from commit message

 tools/testing/selftests/tpm2/test_smoke.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
index 168f4b166234..3a60e6c6f5c9 100755
--- a/tools/testing/selftests/tpm2/test_smoke.sh
+++ b/tools/testing/selftests/tpm2/test_smoke.sh
@@ -6,6 +6,6 @@ ksft_skip=4
 
 [ -e /dev/tpm0 ] || exit $ksft_skip
 read tpm_version < /sys/class/tpm/tpm0/tpm_version_major
-[ "$tpm_version" == 2 ] || exit $ksft_skip
+[ "$tpm_version" = 2 ] || exit $ksft_skip
 
 python3 -m unittest -v tpm2_tests.SmokeTest 2>&1
-- 
2.47.2


