Return-Path: <linux-kselftest+bounces-15842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673C695987E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 12:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2008528123B
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 10:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729461E3892;
	Wed, 21 Aug 2024 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmwmy6BQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C1B1E3884;
	Wed, 21 Aug 2024 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231451; cv=none; b=pCoGeXiZRl1EppcSR4+OJEMmAFn7DFl/1yNatyeHCr9uvOMog5HcLlc4x3AEsMrJD61IRobwywyOo/Wxcy/u0jdh4ok7+511Lb8oFdtyF/K/5Qhz8ZrHb7ew2saelQblmV2aK3MLZ7/al3E66H6LK0K/SFsxzwZnn2xsqUFQaco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231451; c=relaxed/simple;
	bh=jOVV1mUFmYUSpiM3Wvxtf5xJ3j3iWH6e+YjabNu1HEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G52UdBiv6bhAoM7+Oawc1y4Xc+/jUc7TYn7xsIWa1eCMqxSa1rggLb95FoLH5Z/ukbTC+C0f88kaczU6G4ssAobs8fYNaNv2XBKAHOw3h3ljyORRrrYFOgPT7oFlY64Xu9G/AbkeiAqIN1i41sVJUVs5rvn0Q/+v3XihNo3nmos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmwmy6BQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fee6435a34so42669155ad.0;
        Wed, 21 Aug 2024 02:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724231449; x=1724836249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdS8Gy+ep2HLBkBMxdTVMiQLpqkMJJLaLRhG56RDYoI=;
        b=bmwmy6BQRSDKRL/Uq5Hi118gMRoJqPzV9KYKnb7KGctiIe0RHg1T8qBMcTfSVz4MMT
         KdoNym4137fClk+tTYkGQJD1G1hC7afVDN8zR6+PYpOfHenpYygy1kte+GUe1gi0hwsV
         RjanaSbqJUgYqC26AxQ9jA6Du8WlE//Jjg0yKU+wBnSzc7OZQQq50DntrWwE4JMqJ9Px
         eY+l6npYY5qAf0kU8u0pQG3Cm0uoLbRf3cc7fdOphzoqmXcmXGUbgEUpj0IEacbxVfYL
         53sbtUeS0PnEAByi7uiOw1LW9Bm7BaTxdZ7xDHC3rJxGynFXgEH5LHUpkHUX/QMhETX8
         gTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724231449; x=1724836249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdS8Gy+ep2HLBkBMxdTVMiQLpqkMJJLaLRhG56RDYoI=;
        b=Z5EnJoJVTDHNflmdcmanTIQogtg0N4LI8T4sbwu0SFbdZTjVxMvcPRhbJUk3rJf0yW
         wI4zNDMAuZdlcZqhYaNzOZafK11PEEJj3KI71+dtk/zgppoC3kXYLL7HpXZD2dvNphVA
         EzTT5UxPsy4UhPo7AeSMbbH3Hzg7ZixoqH7zVVnSr9VU9lywYoAlDRMhHdBCi2IVW6z6
         IQselMmBooH+mb9k2Wwd1e/k3sh4KuTWyIbwBBX9IJ7YztEd0Lrg2QWc1VIK8h79o1Xg
         GodHqQoVlhdFZ66Lpmp79cexdI/FPSWFz/Q8kyzCcrWU4kzA6grhpYyseAp1F26QZ1Am
         edCA==
X-Forwarded-Encrypted: i=1; AJvYcCWuARcviVV1iDfHlYtJhWsecchB5t4IqiUbcynyKJAmlRX6r5ofE7+hQtwTOt53l4iK2Ar0YVpmfOasP1zFMGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzZIWEDFb3f2W3Mi2ptNwmyD3JEIKx80UNAe5Gj86hsZkK961I
	aL1D4mSkP8EO3jwcqlPbIAIcOTwU9O4HSsyZK5Zw0B2Ho9DwS5HWOylTBVRR
X-Google-Smtp-Source: AGHT+IH98hIkJylIYSiG+E0o1DWyqiOa/70qeq3+sEmv/mgfnnSvy9r3GJ8qRODZthWWyehPeFQ6Pw==
X-Received: by 2002:a17:902:ea0a:b0:1ff:56b8:2c1b with SMTP id d9443c01a7336-203682151c6mr19130645ad.60.1724231449092;
        Wed, 21 Aug 2024 02:10:49 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031c5e1sm90191405ad.94.2024.08.21.02.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 02:10:48 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v1 8/8] selftests/bpf: Support cross-endian building
Date: Wed, 21 Aug 2024 02:09:26 -0700
Message-Id: <80190c7c8c65aa9ed61341949090fe08f5252c18.1724216108.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724216108.git.tony.ambardar@gmail.com>
References: <cover.1724216108.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update Makefile build rules to compile BPF programs with target endianness
rather than host byte-order. With recent changes, this allows building the
full selftests/bpf suite hosted on x86_64 and targeting s390x or mips64eb
for example.

Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 3b9f345f7909..69ec6960af42 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -402,6 +402,7 @@ endef
 IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null | \
 			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
 MENDIAN=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
+BPF_TARGET_ENDIAN=$(if $(IS_LITTLE_ENDIAN),--target=bpfel,--target=bpfeb)
 
 ifneq ($(CROSS_COMPILE),)
 CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
@@ -429,17 +430,17 @@ $(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
 # $4 - binary name
 define CLANG_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$4,$2)
-	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v3 -o $2
+	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v3 -o $2
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
 define CLANG_NOALU32_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$4,$2)
-	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v2 -o $2
+	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v2 -o $2
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with cpu-v4
 define CLANG_CPUV4_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$4,$2)
-	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v4 -o $2
+	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v4 -o $2
 endef
 # Build BPF object using GCC
 define GCC_BPF_BUILD_RULE
-- 
2.34.1


