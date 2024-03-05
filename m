Return-Path: <linux-kselftest+bounces-5864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D645C8711A4
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 01:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8511F223BF
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 00:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C39EECF;
	Tue,  5 Mar 2024 00:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5FM0iLZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC7A10E4;
	Tue,  5 Mar 2024 00:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709598362; cv=none; b=BSAXENNz7pYdpcIy8eKJcufteAM9w6+c0LUzilmRt67isSoDb8fDe4QJDDjesTF5MsYOcO10vSVm28zbBfSFmev0tdArUrRt8lq9QzsUb6keEXf17AmFQ77SnJ/mZbjAqMXg1crSsKTYi3SxkuSJfU85sSbiBGn89UlOzE5HEwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709598362; c=relaxed/simple;
	bh=Vic1yyYZkTyBkcHMN/DlotFLffO5adzTXya6pqwwL2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t5hl7z9WtrVYOne6Jm2mKf4uoPYsdRc+RnEySX8Kg9c3HwrW50Nd32aPlAPOFF+8HRUGexsP6yyCfxGfRrzZpyw5VEoalJmrG2aTDEgWTNHNvnAEJN3N2q8OCMaN5X16u6sYRDTvV0+HpSgeAUUd5oqYBaGace6HMzGhuuPC0MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5FM0iLZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dc13fb0133so37902165ad.3;
        Mon, 04 Mar 2024 16:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709598360; x=1710203160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=apgfPOyBm8fjbNIlIAw478BrY43o1tnAskOyysD67Fs=;
        b=f5FM0iLZMtFLWqAXPmIYuqfgTfYvkxU8c2SuIuRe3oooH5rvzDqHERIqfsgMRKoUvQ
         Y20Qt1W1IDXa3tVR0mYYtucGqYA9Rk87vdEnuYtzcNrGlOQ2yV1uHak+emlouhiTSHnc
         pGMWbrn5CLTZr6RLwPzYYsbkQ5kWPkLR0nsmr69am2mils40r5mJjNISJdG3oq62ec2A
         3O9QolBPLETtG5WRX+jMhlkDr+qY/awh7K9auB5cwPv1ML48BgSpUxdA0Lm0yZosskm5
         n/MgrtsMxKmHoo5bUaAEdIyDLvE/CMDYbzQKlGjJgYsDTkn4yj3z13756/T1Ii2/fjxq
         DoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709598360; x=1710203160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apgfPOyBm8fjbNIlIAw478BrY43o1tnAskOyysD67Fs=;
        b=m+OlDuOMU69Bhkhjm8R8gcpKUEkICYm3tPX8x1OYSoX5goosst81jjZn5B+t2YRfsB
         b3+V2z/fqWdu+RaklY7iLOxuzSzF9vT+he/MsDDxvT8I4uLgkW3RprAof1Mcz0TLW325
         QjvMie4+G+xa0CA6RrgfXujYPIpalF/CMApRzisiOspdOgx8Z4iBj57BIsJCBcBYfzEd
         3UTq2bsKPdjYjVyFAh48cLIH7KRQG3ukjH3RAmvjJy3tRnIzISsrnH/9see93ZDJljGc
         Layxq5zk5e0MnQibLKQ97NDHiXjg+OVjKvP7CSeS3xdG9vNlSjyaAqTEfQaJ8WnuSb8j
         2AxA==
X-Forwarded-Encrypted: i=1; AJvYcCVpshuTl4l8jwWt4OxAWil3Cm5inYBqcoBZeXwrT+yJuwVhqvZJ4umWvv/buylcVXfdVEH3sNu1fqLWbcYf+tWLdTxMw3cnaSGmAaZXH4DgabTByz2c6VzxhS0IhhV720nOO+jI4Iy/TvZj/w==
X-Gm-Message-State: AOJu0YwjZpgybyE0W6/clV/A8Z5KN6Fso4SD3oe90GkEqT2F9wCOF2Iu
	EcPPh+NZ0EVmqO51g3KjE7CkNDRqnNWECQb1RTwwyzm8WXIxv6asqM+GrDNb
X-Google-Smtp-Source: AGHT+IH8VISteBQwVu/ywVhok1br8asTz3CWnUenMckIjlocnVPMmLNsv+ZYwZwB+41xt68s6nRvRg==
X-Received: by 2002:a17:903:1104:b0:1dc:1c81:1b19 with SMTP id n4-20020a170903110400b001dc1c811b19mr404186plh.3.1709598359824;
        Mon, 04 Mar 2024 16:25:59 -0800 (PST)
Received: from rigel.home.arpa ([220.235.35.85])
        by smtp.gmail.com with ESMTPSA id mm12-20020a1709030a0c00b001dc96d1a662sm9131940plb.197.2024.03.04.16.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 16:25:59 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	bartosz.golaszewski@linaro.org,
	andriy.shevchenko@linux.intel.com,
	christophe.leroy@csgroup.eu,
	shuah@kernel.org,
	bamv2005@gmail.com
Cc: Kent Gibson <warthog618@gmail.com>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Yi Lai <yi1.lai@intel.com>
Subject: [PATCH] selftest: gpio: remove obsolete gpio-mockup test
Date: Tue,  5 Mar 2024 08:21:24 +0800
Message-Id: <20240305002124.7552-1-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the removal of the ARCH_NR_GPIOS, the number of available GPIOs
is effectively unlimited, causing the gpio-mockup module load failure
test that overflowed the number of GPIOs to unexpectedly succeed, and
so fail.

The test is no longer relevant so remove it.
Promote the "no lines defined" test so there is still one load
failure test in the basic set.

Fixes: 7b61212f2a07 ("gpiolib: Get rid of ARCH_NR_GPIOS")
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Reported-by: Yi Lai <yi1.lai@intel.com>
Closes: https://lore.kernel.org/linux-gpio/ZC6OHBjdwBdT4sSb@xpf.sh.intel.com/
Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 tools/testing/selftests/gpio/gpio-mockup.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/gpio/gpio-mockup.sh b/tools/testing/selftests/gpio/gpio-mockup.sh
index 0d6c5f7f95d2..fc2dd4c24d06 100755
--- a/tools/testing/selftests/gpio/gpio-mockup.sh
+++ b/tools/testing/selftests/gpio/gpio-mockup.sh
@@ -377,13 +377,10 @@ if [ "$full_test" ]; then
 	insmod_test "0,32,32,44,-1,22,-1,31" 32 12 22 31
 fi
 echo "2.  Module load error tests"
-echo "2.1 gpio overflow"
-# Currently: The max number of gpio(1024) is defined in arm architecture.
-insmod_test "-1,1024"
+echo "2.1 no lines defined"
+insmod_test "0,0"
 if [ "$full_test" ]; then
-	echo "2.2 no lines defined"
-	insmod_test "0,0"
-	echo "2.3 ignore range overlap"
+	echo "2.2 ignore range overlap"
 	insmod_test "0,32,0,1" 32
 	insmod_test "0,32,1,5" 32
 	insmod_test "0,32,30,35" 32
-- 
2.39.2


