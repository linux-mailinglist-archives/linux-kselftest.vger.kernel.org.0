Return-Path: <linux-kselftest+bounces-16767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0559896587B
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 09:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A161C23C45
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 07:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79F516BE36;
	Fri, 30 Aug 2024 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/+8cHw/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC0616BE0C;
	Fri, 30 Aug 2024 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003024; cv=none; b=q3l/MZcAzG2bow9vAH6LX04U83fquSUaaTEVHdde1eBLJ2gdoNZaNtaq995r8o8Ag4P74zkjxR4pBxroADqlUVuxZnEcQW/Z+WRmtGtJ+rgsh/cmXc//LRzrDul0I8zQi4nIunvn5b2QXCLHXEmFUWWDd4vlV61qfP1KC6VGrkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003024; c=relaxed/simple;
	bh=Sf7g9q6kzZ2QDVZ42l9TEK1MrgR/netlPt93lP7g9x4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qvu5kMo2Owsez961UyXU8cjowkfWFoajArp6mx2HKmtAwHkuitIQUZkwfgw7F840umaCYZVz6/nl9dgtT5sm7eRuI3c37QTduGxtFjT/iOK2PnvusVDKHC74cc2hK7cV0hAqkZMa1PoERMj4oGUDcbPoqX1VVwgh4hR7IpmVT5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/+8cHw/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-201f2b7fe0dso12818905ad.1;
        Fri, 30 Aug 2024 00:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725003022; x=1725607822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRgUXWe8dZjfzs16xzJQ+DDVhbgl0JeJ2Y/m+gXLXrs=;
        b=D/+8cHw/6SMPg0vXP2K+PVjCQpvUBYFwPaA8ioQSgBd+MCK/eYjpdbdrudd1nazRKt
         S77ipLRYWnEPgDZtNLGzU5k9AbHDc59sg+ieml6ohJ8Q9MkfuD9a3CpJ3XJA+bRbU3Qo
         FPGrcCYBKQiHJkgZ96a54plk2gfnyWKPcTluuBzwV1YTTZisKfyshvaTA6EmVj1GHIA+
         uQALOhcnhRfpnXbTc1/0bjaE6sE9otd/4nXqPpJP9kpHwwndxvWiNbVKFV0buN7oRBfy
         tC1KMPnyj4KnEO5OcOp9F+jFOgaOfD9pkubMa9V/kRVbMiUV3VxbalOiXQaI1MN+Vt1X
         GvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725003022; x=1725607822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRgUXWe8dZjfzs16xzJQ+DDVhbgl0JeJ2Y/m+gXLXrs=;
        b=Mbra98jErVwR7ippTWo7HOcg8rG6WsbR1LHFbs7NFsADg2+h9UpqqZT2HUyaNhaBPE
         6x80uv9ALziWsr+ZO93JuOibVIergd7kIDzyADjEl8Z+Sctdg5DR7Na5vjnX4rAqpH6D
         LxxXOph2u9TGKOzJoYvHoS0Aje68syOSvbqRHl6TgWhKuVqdjdq4vSnX+OpHP5sqU87w
         0lB7QsmwEMhrhZTdWYY5TiRPq8lxIqh6RvoccJH7gdUaKeRvpIcZnpSthAp4rQfxHkAf
         IkINAxQWRu+W3oW7oQ5khUrgjDb1NQxl4WRoS65GZ+0OCrsXQj9J8vIVpuCtXTDSHocy
         5KGg==
X-Forwarded-Encrypted: i=1; AJvYcCWzJSLLLPlRvzO/QyrH3O16Nb0Pjv02tGyKoLtnvtOgKxajS9qIrxR3atAOSMP/m98wER3+WUJFVYHV1Zpzbsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYQzeYAEnMTh4YsMENvy1ug1xVV8BkGGT67Uiw1okEHSuGcfLe
	U3XDkKhTL6KM4Vryiye4isWwF1DcktZwD/N5gabDDDrH/C3UgETRoQ9VKRFW
X-Google-Smtp-Source: AGHT+IF8A+tzbxB2dPzmuiLZQVlvRGJkJrjG6ut3uVXWa1gSLUlWERkW2TZfKNDo8kF7/P8Ei5N+yw==
X-Received: by 2002:a17:903:2444:b0:202:562c:f3cd with SMTP id d9443c01a7336-2050c4f4331mr54598785ad.56.1725003022188;
        Fri, 30 Aug 2024 00:30:22 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b4dd0sm21698085ad.15.2024.08.30.00.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 00:30:22 -0700 (PDT)
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
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next v4 8/8] selftests/bpf: Support cross-endian building
Date: Fri, 30 Aug 2024 00:29:30 -0700
Message-Id: <b375baf509ca7f470b2e34668443837903a565bb.1724976539.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724976539.git.tony.ambardar@gmail.com>
References: <cover.1724976539.git.tony.ambardar@gmail.com>
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
index c120617b64ad..27afbfa9e831 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -438,6 +438,7 @@ endef
 IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null | \
 			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
 MENDIAN=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
+BPF_TARGET_ENDIAN=$(if $(IS_LITTLE_ENDIAN),--target=bpfel,--target=bpfeb)
 
 ifneq ($(CROSS_COMPILE),)
 CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
@@ -465,17 +466,17 @@ $(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
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


