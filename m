Return-Path: <linux-kselftest+bounces-42042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1619B8EA0F
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 02:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7147B17B8D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 00:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE495789D;
	Mon, 22 Sep 2025 00:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMvV4n2d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776F078F43
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Sep 2025 00:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758501907; cv=none; b=Vs2LZsuJPuZXUt1hGwTCfreuqL0V1H/MWjQ6c2kL5i5u2hsNebR3CDv8GT65d5aKsscZzIAW3Rh0cDRA48obPEte7DBkxMS+bJUyucZ/PbQYvtG+ipmtgllFZNoif5uE3dB/UC8pSga8XEgKItWejZvWPw1SwrZNTvwqg13Xo7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758501907; c=relaxed/simple;
	bh=CMzTLzSuPzZSKmPCVID34LoXc6n8pN+Vcm6j0KSBe3M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MJRLrk6B0KDjcyiIvLHYXZKn/9xrSPkuhHz6PmabDJiyI2jqQRwgJU7uMxKaC4vEDr0mE6HFx2IqkNRcrZfnXNSgwNrgXu2rGQPxK7xV9SBHUJrsiiX+GGrj8xPRBznuQ4EDsKq7mlw3Fr56VBeq1tf2/UbbLMEVPERbqgi0nDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMvV4n2d; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4c3d8bd21eso2708371a12.2
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Sep 2025 17:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758501904; x=1759106704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+4TpF34W3PHvsBrekGwm1rvuPQAafzFCgW5mxOcoS+s=;
        b=kMvV4n2d1G53xqdBgS9QkMa68yAuMWJRbnFWpMwK6DXBR7Kd6+vt6eqkIjUuUVhn4b
         VPpDZpboqARJfMX1oY44IsuuhjRpEQ+NwiVgGBi0bDwEuuYXU+rMHQlT3X/S3uJRK/PY
         Yigqbv31Djv5hZdVzS/iHhnoGdFfkvfaIcPeqsK5sA1cVMm8sRomHx4syaU9Ke3iXg53
         +mtMUT3GHZxftB7Yyg3Frc3GmS5glMezPmGKH82OJEBLJXuFnnbs/4nqzIpcdlSO8sGo
         6rP9qSjIFstNZE/vO5U7SIPr/6It3eS0g/KGrTBmaLt8x0raZH1ntemei5z0KfoVNJ0u
         fNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758501904; x=1759106704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4TpF34W3PHvsBrekGwm1rvuPQAafzFCgW5mxOcoS+s=;
        b=PCNSBscEdWR7iJndKh2FpgxAzrCEkvAaqNHhTE02TV0liY1SL1ROMDh7uDbBDIgEY0
         RMEZM6pXp1mxs1/+fhTMZDPeMEfyOj5863G4IgEY01F7fkIlAAsiBpEyg3ccvjqguJp/
         8O0q6xknkNEdtJArvdncOdsp56VbK5nPyc5Av3AO7sskh9ps3CLSyeQfeZveLVaz7FbP
         j00cBbz2xoBMtkCnOsXeFnoieR73LKtqyZyMRfLpQ97jgQM5qbqVOFBK1zjYv3WlJQy8
         WbgAX7a+irAxNl0uIF2cJ5FtXq1WMWTHJIc9XmKFxCkoTNy1XFLumWpPjK4jwFRVTIxb
         Ndyg==
X-Forwarded-Encrypted: i=1; AJvYcCXEwlV1DNrTImGClgNVTyOYlpw4fXpIdvPazEtWXwiihB8SDaLSEyvgMqwNyMlZcp8lIzb4ZX3jx0vYWB6/oQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRlBMglI2kCNrTCnjGE86/Xy81u6VWz19FO5qxUielG0HwqsmS
	6JLjsw6h4M2eKM14xpclIktvI9FonggWUrsveC7fGLP1Wre3t25+w1L+EHolK6GjtaY=
X-Gm-Gg: ASbGncvNPhlkJDtWqAV0XarMGjOIXFu5wWICVUoLVS4aDEOnSyZGmirKLS3b4CsP8ME
	G2aHIU6cj9ooRhVxirR1Oa1TdFKHAWoTJCSHgT5xfsnlN1BU1Sz0gaySAZR4PIaNuFtzsTPUtGz
	zAbseVlEsSn2TrboVM/KTxCSh5HDoaqi1mxqn2eKbAGel9w9t0nbiED2ucrDA2dfoKPYBe7129h
	vI8ImwvwH1YMmiaf41iaj6y/aMYSa4WAULcpPCKzFsiZgdEPO6CgL4JhUP4gYHoYHvBg5i91EY2
	Ukoz5xAUZj5jztc5GTbG+3TrgxQtDJvON5YV73UjB5kMOiDkCslc8buUPD/wA7Zn1kqTCvCp4Tu
	kU/YHBn4+jz5z+2WDVXC4QH2n/dmK57TrU1Red5HfwFey7h9GIxr9
X-Google-Smtp-Source: AGHT+IGeGCeJGDQO792G7blZZbjio2dz2UzvLzPbvR3uVFdQj+v9IaRb+EMqbWNhfxxc4quvxfrw7A==
X-Received: by 2002:a17:902:cf4c:b0:267:776b:a315 with SMTP id d9443c01a7336-269ba508205mr140392845ad.32.1758501903638;
        Sun, 21 Sep 2025 17:45:03 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f0da42fdesm6769810b3a.66.2025.09.21.17.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 17:45:03 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	shuah@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	krishnagopi487@gmail.com
Subject: [PATCH RESEND] selftests/powerpc/pmu/: Add check_extended_reg_test to .gitignore
Date: Mon, 22 Sep 2025 06:11:23 +0530
Message-ID: <20250922004439.2395-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the check_extended_reg_test binary to .gitignore to avoid accidentally
staging the build artifact.

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 tools/testing/selftests/powerpc/pmu/sampling_tests/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/powerpc/pmu/sampling_tests/.gitignore b/tools/testing/selftests/powerpc/pmu/sampling_tests/.gitignore
index f93b4c7c3a8a..ea29228334e8 100644
--- a/tools/testing/selftests/powerpc/pmu/sampling_tests/.gitignore
+++ b/tools/testing/selftests/powerpc/pmu/sampling_tests/.gitignore
@@ -1,5 +1,6 @@
 bhrb_filter_map_test
 bhrb_no_crash_wo_pmu_test
+check_extended_reg_test
 intr_regs_no_crash_wo_pmu_test
 mmcr0_cc56run_test
 mmcr0_exceptionbits_test
-- 
2.43.0


