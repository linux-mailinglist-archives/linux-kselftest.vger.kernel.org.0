Return-Path: <linux-kselftest+bounces-26194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EE6A2F493
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 18:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C54967A3384
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 17:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCEF255E31;
	Mon, 10 Feb 2025 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GThPyTMX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC80D243962;
	Mon, 10 Feb 2025 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739207030; cv=none; b=KCsnda5TPrvvATb/lgCALt/nv4z6rjiL2GVQk48WzxLpuGQ0Be0zAPhliWxAmlKFB2SRxgJa5RBpDEZTtWiKXjpw6MULeyOOjzyXqJTlp+hLnMjlgH9Ra+9/cki+M07LCfmZB/JLb1A++mowDIia4o9jlHXT8QBJ0rTjo4y4WH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739207030; c=relaxed/simple;
	bh=chOXu6gLWKiwj8SMWHC/CWXdIHHM7I8yTbShobTfqHA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tKUyV9sK0pPPSxFKieV1MEZEJubpC/8uiyH8WIhnZFVoTmOYo4CMsL0/Ygiqxb6YDLRoG9vEV3cWVWNqJRlUPy04AvGQlwmmI3tCcljTQtiO2uIjC5UNR6TIVO+GQEzcmdDCLr+WbAu5nj13utqsL1NPQyNnslCYwzyj/Y3I8ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GThPyTMX; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1023163266b.1;
        Mon, 10 Feb 2025 09:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739207027; x=1739811827; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xmyo2xaQvKLsluKclvN31gRyFpLzRrfjlczkugaFeIM=;
        b=GThPyTMXzOa8DK3lTcMVKHThi+10z/3y7/Cy94p4lFhKAOi07I6MRcRUME+Od5G+8y
         D99mHyN3OS4y8Ja4HgdUejAVDOCEdQibqKY9daxka51/0d3i6aSc/+96L+LfxqRIQam3
         pyEs/t//fTVa4+Klfw4BtH610sPRXYK5vRAUKFU5UugwzsP78aBBoNMkYoh3b2WeQ+lB
         ArykSsx7bvShiLmdf95Q3OSZq/QAW+eXbN28iy2nk1Thy360ET6j8gNnrzgDOkvOQpPt
         ca2KSvn3foJj37dHkFjWZPVanplJGxZZBjE+27qDDAJfwyHwkf4i47eyQB8Eu7W/5rk0
         VrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739207027; x=1739811827;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmyo2xaQvKLsluKclvN31gRyFpLzRrfjlczkugaFeIM=;
        b=fLQLiguDu0+lSh3dR7BQpJe1fRowEnP6IsGLXn2/npvjJ44VEtC1WE4fz+I4eCsvXY
         8z/W32GYbj6G2WH5dNqUUzS7fCf41Fj4Zs1Qga6lCfGuGXJ5jQpy4f6dyr3tgwMkLs0y
         gThHKzp+R9+Ta5KFk2Vd6iVMBrAH8WNsFdWuPJvEf6nisym232Vd/mau9ioAxmjcUL1G
         sJIWYy7xSY6Uph4tQzD1g+wd0Q9xKKuQ8I6owSsDZ4DU3ziy6QBTZFw+GGiDhnA4q4mm
         awaQPrg7fPa5hUJKKJIpk4Q8j1em+s9o47w5RG1l/TCw+M4dvJPlW7Rm7GIm4nNL+glZ
         PuMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFCf93JsMZSuHGRXEsG/zN8qrh7RmmHgOOrGhBAtv64QbUDlRMHQXjb0UnXEN/gmgsTUARbxcXsAwx5zzk8Sdc@vger.kernel.org, AJvYcCVXPq2lhoTcFPaBi6VtlXuvTCZds72v++sqaF7P+RneMgBL9vcr3vNXMEoDbXHmxTvx1wkG47a7xUSvmJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu6I/6z8w9rICxWR3dxXIG7L/VTHoLNkIUnvTXWRDrQpJyziTf
	V7Xn0utZnBrk/8nGb279dOA8KhCdyViN+HJbBiDcfBTbzznGC3QY
X-Gm-Gg: ASbGncsXse4qozVDaIs3sw+c8XWos40MIpuvr9iHZQ4HRKEmpBjlm0uq6loXQ9Sf+Wj
	7il8LuNsno+qZgjWI8JiiZ1DCp8ln+UuDm6HPmPyRU6esHITBpcJ4jNoh9PXSaZPiY8dfzuPp7i
	X5Qrll6+xcUt5i65f8hZmIRM1yVLPnI+fp5ak7WEnJQXcMKl63T25JdiVqGnkHsRppMmu4CPRvl
	yGael6MafcAsWxOlT0AECeiPAXVSEt1TKac2XFFSNjk+1S3MHO2BriN23OTyNtxNDmOkluaQqz2
	AZWu
X-Google-Smtp-Source: AGHT+IE3NayDwSGSY/pjr5Z6qk6OlohSwgAJfXQLCMr7RNIdB2uEhMuxgyvunfj+t3kNKovxvzFNRw==
X-Received: by 2002:a17:907:c04:b0:aa6:9198:75a2 with SMTP id a640c23a62f3a-ab789cbe579mr1442584466b.44.1739207026926;
        Mon, 10 Feb 2025 09:03:46 -0800 (PST)
Received: from localhost ([95.85.21.13])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab7bfee782asm265491366b.142.2025.02.10.09.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:03:46 -0800 (PST)
Date: Mon, 10 Feb 2025 19:03:43 +0200
From: Ahmed Salem <x0rw3ll@gmail.com>
To: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, shuah@kernel.org, 
	skhan@linuxfoundation.org
Cc: linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: tpm2: test_smoke: use POSIX-conformant expression
 operator
Message-ID: <zdfnlpdb24tk6aikzucyomylf4lqdyhdvlingwyku46fy75eyg@giq5dqojdxj5>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

test_smoke.sh:9: expression uses non POSIX-conformant operator
symbol '==', resulting in skipping the remaining tests.

This patch ensures the use of POSIX-conformant operator symbol '='.

w/o this patch for test_smoke.sh
================================
$ sudo make -j8 TARGETS=tpm2 kselftest
make[3]: Nothing to be done for 'all'.
TAP version 13
1..3
 # timeout set to 600
 # selftests: tpm2: test_smoke.sh
 # ./test_smoke.sh: 9: [: 2: unexpected operator
ok 1 selftests: tpm2: test_smoke.sh # SKIP
 # timeout set to 600
 # selftests: tpm2: test_space.sh
 # test_flush_context (tpm2_tests.SpaceTest.test_flush_context) ... ok
 # test_get_handles (tpm2_tests.SpaceTest.test_get_handles) ... ok
 # test_invalid_cc (tpm2_tests.SpaceTest.test_invalid_cc) ... ok
 # test_make_two_spaces (tpm2_tests.SpaceTest.test_make_two_spaces) ... ok
 #
 # ----------------------------------------------------------------------
 # Ran 4 tests in 8.647s
 #
 # OK
ok 2 selftests: tpm2: test_space.sh
 # timeout set to 600
 # selftests: tpm2: test_async.sh
 # test_async (tpm2_tests.AsyncTest.test_async) ... ok
 # test_flush_invalid_context (tpm2_tests.AsyncTest.test_flush_invalid_context) ... ok
 #
 # ----------------------------------------------------------------------
 # Ran 2 tests in 0.005s
 #
 # OK
ok 3 selftests: tpm2: test_async.sh

with this patch for test_smoke.sh
=================================
$ sudo make -j8 TARGETS=tpm2 kselftest
make[3]: Nothing to be done for 'all'.
TAP version 13
1..3
 # timeout set to 600
 # selftests: tpm2: test_smoke.sh
 # test_read_partial_overwrite (tpm2_tests.SmokeTest.test_read_partial_overwrite) ... ok
 # test_read_partial_resp (tpm2_tests.SmokeTest.test_read_partial_resp) ... ok
 # test_seal_with_auth (tpm2_tests.SmokeTest.test_seal_with_auth) ... ok
 # test_seal_with_policy (tpm2_tests.SmokeTest.test_seal_with_policy) ... ok
 # test_seal_with_too_long_auth (tpm2_tests.SmokeTest.test_seal_with_too_long_auth) ... ok
 # test_send_two_cmds (tpm2_tests.SmokeTest.test_send_two_cmds) ... ok
 # test_too_short_cmd (tpm2_tests.SmokeTest.test_too_short_cmd) ... ok
 # test_unseal_with_wrong_auth (tpm2_tests.SmokeTest.test_unseal_with_wrong_auth) ... ok
 # test_unseal_with_wrong_policy (tpm2_tests.SmokeTest.test_unseal_with_wrong_policy) ... ok
 #
 # ----------------------------------------------------------------------
 # Ran 9 tests in 9.278s
 #
 # OK
ok 1 selftests: tpm2: test_smoke.sh
 # timeout set to 600
 # selftests: tpm2: test_space.sh
 # test_flush_context (tpm2_tests.SpaceTest.test_flush_context) ... ok
 # test_get_handles (tpm2_tests.SpaceTest.test_get_handles) ... ok
 # test_invalid_cc (tpm2_tests.SpaceTest.test_invalid_cc) ... ok
 # test_make_two_spaces (tpm2_tests.SpaceTest.test_make_two_spaces) ... ok
 #
 # ----------------------------------------------------------------------
 # Ran 4 tests in 8.701s
 #
 # OK
ok 2 selftests: tpm2: test_space.sh
 # timeout set to 600
 # selftests: tpm2: test_async.sh
 # test_async (tpm2_tests.AsyncTest.test_async) ... ok
 # test_flush_invalid_context (tpm2_tests.AsyncTest.test_flush_invalid_context) ... ok
 #
 # ----------------------------------------------------------------------
 # Ran 2 tests in 0.004s
 #
 # OK
ok 3 selftests: tpm2: test_async.sh

Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>
---
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


