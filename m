Return-Path: <linux-kselftest+bounces-40781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE4AB43BEE
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 14:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6F0A1C213D6
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 12:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16EF2F5465;
	Thu,  4 Sep 2025 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJeIKzZM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C86B2F3627;
	Thu,  4 Sep 2025 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756989864; cv=none; b=UO/XG7gaA6O95s73zIei3Q/BgVPUzMxIwj/Zn6N7t0J/exZVz5T4ZkS32I8VH8qyNg1sPBagJeV89xT9FpyW6WrDaOrWZ6yQ2Nu6+f9C1Hc5IzJ9OX4kClFIaCQEBi/2BW8eKCpp/vytpUfAuNRVLsZqAMo8PBRd6XKGZDDi2bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756989864; c=relaxed/simple;
	bh=CMzTLzSuPzZSKmPCVID34LoXc6n8pN+Vcm6j0KSBe3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=naeKp+jT4QSGz5gIzpMiZGBtFlW00z0zQX1r/Z09IUwfEfL1i1Ndboq9ewKo1HNQVtmssb1ElUjK3PuEyheqg52l0UhzMKtduF/dV+FSOQI2dlP5f9EAymE3fO93Bf0Ku47FIzH/hxkyvbuaroRP3yp5IVWmI5rc87O2JAA4JFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJeIKzZM; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77264a94031so725908b3a.2;
        Thu, 04 Sep 2025 05:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756989863; x=1757594663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+4TpF34W3PHvsBrekGwm1rvuPQAafzFCgW5mxOcoS+s=;
        b=dJeIKzZMKEz2izYybXNzVY6cy6NtLKf+/ELJ9b/yU4+4cE9SfpRvGYb0oQTSlaFGjF
         0oGKX3OKVnq8ZnslZIFK7U8PP8309d+XmE5sOyRxjQJLef6ITJApTQtBN3xaTXKO86p7
         G/yBVj5PkmrOLJnVApgpswkJJedIJVXFxplgh/U0Ig/Io9lX8GRWs8Ycq891YlVhU2UD
         a3o/7pSKL8PVjGkF/+PmpOo+HFRgpjW6ViVgRSHm4sEvHZzztQz0DfftKu638ai+tXJG
         5ES9vMC2mFMwsv866LG8XB7J0IaSW83g6T60a7Df4dd9DfBRlhImvgexPywMr+UEXA1Y
         ytYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756989863; x=1757594663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4TpF34W3PHvsBrekGwm1rvuPQAafzFCgW5mxOcoS+s=;
        b=LbnK4UngxzEI+zCREVrCI8v/Z2hGqF+OJTX3tApnMDWHEp8O/DDIyPSCBTMSfe3QqJ
         g/xqI2T9CR3CGC/+wrfT5GtPIqBDf8o/WxT6ogp5coPdxdKUysfRD3O/AcubHsTPMNq9
         YFudZoHs9WTBq6IGzDhHSo4DQjmWT6pxIaya2ScyQYBebDgg+qgKdQHyZBaijNGAJwaz
         cheFwzXAAWj9KFi8ZbJIZ7McUC4um3s4/8stanjWgLTwb/ECRLhjMOS4ILo6uhcrXi1j
         OUyVVBxcy8YtcKE8SFla3hyey4vsXvYHj4hLKGoS/VHj5oy5VF/k3CgRf/Y+mnF11nkw
         gR1A==
X-Forwarded-Encrypted: i=1; AJvYcCUrXqZy3YQtiXHPfnKx0/apPjHIDkUCrQGf10yyddugtB4MFKWhfP7t3g9Gb1+Bs+LktICh0kVRHZ8oBSSSnipA@vger.kernel.org, AJvYcCXOEPaKdfxnS/43VukFXoAAL4JNAK1NYwcKgrWNYLGA1dtU4D1qe4txLMiXziofwPzoNj7R3UMa3CGAJkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrxvCzyt4dlsYiMzg/u8m3dsI/XX/cX7tAduHvCdqMOBgW8kbE
	vBx7p1jUPBPnBRUIK0fYhGPubtkDdpLdtt7xgnprN8gDZgQ+EDRJIiwe6mf+ygOhlSQ=
X-Gm-Gg: ASbGncva6QK+46I9EIYpg1NcpFS51SqRFCFrUa0pYuwd/I0xR3NGkfZWAQ3LQ6J3PIy
	pRPdbuf5RKtXFNQm3qldPLZwuFUPo2xDmxCaQSqezUyHTahUWLzZRnkL7UQoXw9fY1luawMe/Vt
	IqrhoppHCCYH/yVsDR7PKnll/+ntM84UCOXJKLFdylUgs5eBFqsFXPvKEfgCyfoprfGAQRF59Ln
	totbEgYTxkcThH/y1ESSVr4Kzr9Awp0juXB7eMy5pj8tWhpYlD73KBtEkFO7LecQ1FhqF1GxuNK
	4BItB9vQfLW1PYVoIUvrgUuK94jNPAkpJniPFggOSyvOymbh0LxSqGsq7B0UY+6/LYb/tLCb3R1
	3WmFW7CLPHQoyjOHtximud28zNJD7KzsYTu7jpPMMolQ=
X-Google-Smtp-Source: AGHT+IG6ptwhAi2WTl+f7P5ZxhCvDz0tuMXhkbgEzCii/VqANS73LGKBj4D0rLB4cKm9/rE75RrMQg==
X-Received: by 2002:a05:6a21:7988:b0:243:f86b:3856 with SMTP id adf61e73a8af0-243f87ac36bmr15437336637.38.1756989862589;
        Thu, 04 Sep 2025 05:44:22 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f9c35f391sm5854642a12.25.2025.09.04.05.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 05:44:22 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: maddy@linux.ibm.com
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	shuah@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org
Subject: [PATCH] selftests/powerpc/pmu/: Add check_extended_reg_test to .gitignore
Date: Thu,  4 Sep 2025 18:14:01 +0530
Message-ID: <20250904124404.4425-1-krishnagopi487@gmail.com>
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


