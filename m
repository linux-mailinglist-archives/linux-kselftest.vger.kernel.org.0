Return-Path: <linux-kselftest+bounces-26434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4549FA31955
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 00:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECDC31671EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 23:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89271F7092;
	Tue, 11 Feb 2025 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ij6SwSed"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241ED272910;
	Tue, 11 Feb 2025 23:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739315789; cv=none; b=I2We7fowcO6T8gDErFg3wLL6p+BvPQ128wgEoZZdA8g28d9kCJlk8/mpet72ScWUInhG/qOXSmWfANcLoECWx0hyYDICN4bLlI3za0XjDh146OxQnHZr5PQzAoZU2zYHIYD13Yo9thvzXTKlO2blJADyxHTo5rztGTpcIQvm3b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739315789; c=relaxed/simple;
	bh=Ys1rhJgXEnjNdv2VFm8kkhafAaLZPOuF2zw82IRSTpI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ioDwKK8s3W5jAkAj/SQYq43e1TTwMlQp+sVvZHgwj32xS8p+al1T1kz+2d3vnDRlZGa0/0tYHW6UpZc7/1zTdI6l2P5vm1E3LZEETMw0ZbwZp24ZlD93lziRuQewqj4rtGXmYjSj/i7Ct4Z/JVglIaCUaakSfSsLGukWhg11JVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ij6SwSed; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7d58aa674so288222066b.0;
        Tue, 11 Feb 2025 15:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739315786; x=1739920586; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aO6abGurUc0b4USPskQVxLQPxPraxFKYOUzF3VnWLZI=;
        b=Ij6SwSedB3PXgTurtvGYx0Qpf1uOyHBO/SUgQSLXkHNL0tqsj6vjw/9Ol4+lf+XsTd
         RaVFbtpQg1s0g5AuxbHDwSEMbQy1OQ2+lAoLocoZdEYhVIiB19znU4lPkwugPwD3Ud+e
         Q7XcmxTXthO+SqEuWvNtueO9kaN6UWEdWfBfu5i+eedrzmtFtuexoxnUDdigGU2C8Ynu
         R+14qtyJOJD6GIKM6lDY8W2CVRz7QWvaZ6Er46RZfsloriFMwFFTc3PN5+vnU56+QUfM
         +hjdQ3728hZJVIlHcQxl2K+PKmrZT9NaAT4Tq1+i21xYOnK5tCv23EfGh3mqMymSOyRo
         sYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739315786; x=1739920586;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aO6abGurUc0b4USPskQVxLQPxPraxFKYOUzF3VnWLZI=;
        b=NC1Hv708P3YTRPbLkITZ5nkJrJZsMja1F7nwiERU3L8y99j9yiwcjG9nVWAZdXREIy
         zT6UHu3YHnYB1awNcvq5iJ+7wZa1zuWpn3d6NdzCdaQg4kvgq6T+3vOzaKoFkhIf+foZ
         0rBCP0JW1R287rPlKgAapkTfWngY7a7t7YvIgng7UmvZg3+r5lHvxcv4QVE8vbS9v3+g
         qNZTc9j0bJfgrL1+6gMNyPC+6uYDBg1imQSjFmV/3o8LPHMXz49dYBVWzQH5VIO7Hlrh
         l37MCeQi39UfQaMjBaf6Vmp79OaD61o5U4QRHZCzITauaMGhHneTMvQCzbRGv/WoXn2H
         g5+A==
X-Forwarded-Encrypted: i=1; AJvYcCUOhOyvN2tGCEc2wPOYPkXYTFViAx6LG4XGDG5VXzhdPFw4UwFsIAdryvQN9ZhHHfJ9kRoybhdvYZ46/Df4YJqX@vger.kernel.org, AJvYcCVbyRlQEDARU81xUuF6Y8VXInc6oqCOxdyO5sHB+E3NMFlrtuuh32W3FIuKgjRDbEm+NbF2m/78AgIBbSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrmhdNuNIb2bvsdvVj93ZB8c8odNbouEAbwyjia1bRfVP9pstg
	kiFZuBut4jg1b9zYh6EW5POD0mE0UTHVuORaot5UmW3HQFKdM8Ow
X-Gm-Gg: ASbGnctzDMV7F/jto1iZ/GqaY3mXbHw9rxkIJ0RA5PXQPN/RY25NIijvX8XRbSdoYkL
	SDx9+Xr8aJPUZBR3uZXrnqz3br2YOtCqLDQxOV4lOTRHPntD7Nx0L7kQAQ6Df1rkl7DXV8eR5F2
	VxMTcypvTNsHhlFn0sEqFbb/Bxc8Z8ApSOlOxgspmLWCDQOnFHBEBqdag0GDa+tyrVQ0v5MsOMQ
	X2A7sIBofEp4kuVGA77AaLeDCgDr70MkzuiFJqDDP1o8C2xt2DeOAOjABpAosUwhAnuDwK9X1x8
	q1hw8LgmVSzKKrxamj/ZCC0l9LckfHtfKHTNgraDHdESboCNzgDTq1NA6Ji3gFEAppI=
X-Google-Smtp-Source: AGHT+IFRMxaQWc4CweYkS5E/aJgKc3I6MfhoY2jkKP65WChnoZkLoI9IzknT+GJzEi9P0e+GxdYDMw==
X-Received: by 2002:a17:907:97cd:b0:ab7:b0e4:aa93 with SMTP id a640c23a62f3a-ab7f33bec22mr52917966b.13.1739315785997;
        Tue, 11 Feb 2025 15:16:25 -0800 (PST)
Received: from localhost (tor-exit-44.for-privacy.net. [185.220.101.44])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab7b35b0d2csm620651166b.122.2025.02.11.15.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 15:16:25 -0800 (PST)
Date: Wed, 12 Feb 2025 01:16:17 +0200
From: Ahmed Salem <x0rw3ll@gmail.com>
To: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, shuah@kernel.org, 
	skhan@linuxfoundation.org
Cc: linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v4] selftests: tpm2: test_smoke: use POSIX-conformant
 expression operator
Message-ID: <37ztyakgrrtgvec344mg7mspchwjpxxtsprtjidso3pwkmm4f4@awsa5mzgqmtb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use POSIX-conformant expression operator symbol '='.

The use of the non POSIX-conformant symbol '==' would work 
in bash, but not in sh where the unexpected operator error 
would result in test_smoke.sh being skipped.

Instead of changing the shebang to use bash, which may not be 
available on all systems, use the POSIX-conformant expression 
symbol '=' to test for equality.

Without this patch:
===================
 # make -j8 TARGETS=tpm2 kselftest
 # selftests: tpm2: test_smoke.sh
 # ./test_smoke.sh: 9: [: 2: unexpected operator
 ok 1 selftests: tpm2: test_smoke.sh # SKIP

With this patch:
================
 # make -j8 TARGETS=tpm2 kselftest
 # selftests: tpm2: test_smoke.sh
 # Ran 9 tests in 9.236s
 ok 1 selftests: tpm2: test_smoke.sh

Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>
---

Changes in v4:
 - Include relevant parts of the script showing 
   the issue before and after the patch

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

base-commit: 34c26c5e1cb0cc7f54c1b89c6e9168cad8ffb580
-- 
2.47.2


