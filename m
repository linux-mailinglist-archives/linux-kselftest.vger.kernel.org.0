Return-Path: <linux-kselftest+bounces-16036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E50B95B199
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 11:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7661F22132
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 09:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EFB17BB14;
	Thu, 22 Aug 2024 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgBmHHqK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2A0157A43;
	Thu, 22 Aug 2024 09:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318730; cv=none; b=Zd+7nitmf1vhWMD1f1hZjvHs13aSfvC38kKoQzuaAuAH9kxHd3raQc+InxIwzYzUAvqYISujz1A+blc0VjWJSXsfW7PhGe4qS899coNodT8MPKv7HGYy8JdKwSUnB52DWG8qL3RV7pBc+i/BuA/gfEOQ2yqyZdN9o8WqDW74c+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318730; c=relaxed/simple;
	bh=I8dp+kesygSB9+8F1GpPULPBgIQF3hHl+DnvJFnCgiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N1Lp9M27X5oFjkmOnC0ohIL0vEbrRHuu7J35qnVA9lhKZeP+vCjoEWABkvTg+KPB5llmg4FIy7WZ1whHPBidzEQ97cloYGQAkIirV+8oxknJkZ2ayYu4r1Gwipuni3G/lgzQ7GU9fQ/kIYuWlNb0vZUTsFIlNO5PA9vH5gAiv6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgBmHHqK; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso417091a12.2;
        Thu, 22 Aug 2024 02:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724318728; x=1724923528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpEuvKhFfEwio+ubyjOlPYD9dr64SM/zhh4p3oDzBHk=;
        b=AgBmHHqKmlaFwgi3oSVTVdj4KgInmXAG5hH1wQ/fQpY1liR9xOu5amZlr/a0TXAj3R
         HXHoNuBvGthjP45AfxsyyB/LZoSB6h2J8SEZRPm8PQ4XxNY1gAlBKgCP9bxcBktd741t
         fIhVrZwLlP/2gE5ZJLL/K/jPkB49iT0nbdN7iJqC9CxYWL4813AL71NoNpdPRKrKneww
         /CwVqMVaDeJ5hlPLgPwZ0SBZ/EgEVTKwKhadc96n+EP8bc9Ux7buEV4muJbdXtXgw9cD
         H1PxZ6EOnLDSm1uFzpBf24HAE9OIGZaXuWcvpUOqezxz0K0tRbVQQbLiMdt6pn0Ot5jx
         kHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724318728; x=1724923528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpEuvKhFfEwio+ubyjOlPYD9dr64SM/zhh4p3oDzBHk=;
        b=j6rXBYVDhH/NRDlFpyVda+ugvWmCla6UqmZphRYjQPBrZB5ijm7ZVp+6CScHGORupY
         DkBS4SGlSr2vIg++7RvHVQzW8a0NWy8N8BxJdKjkmmr+KB2dkaYp4WcO5QTEaLK4VLAb
         w9ieKVwwiJSXl9U+kBnUzvyHqzpAGVYZyGLtEc/xCTnCUOzxXQLkZdJM4nkcZ3e5RFlk
         BdrXJ4cWMQqUfdI/QfvluBAhZAV8i7wZuELZUoNc64fuNMtgivPa2fLtK5UmUExn6Rnf
         qzPm1gIIhNmJPJ+KQpxMWmWXtlS1aRjdoH5rsqHq8I8L5AjRNxghvHD9glsIhOzySrCd
         67Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWC0a+51zD8ZdfyKvBdWQz3GBGD6m56B9HhT4DQi6Ci7mzzeJZn16uTfg31+ryAC6+FYJPP0/zBZq+S1cGmvfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDgm/lf7h5qQk0+uoJuycKdFdK46m3RHcg6RxO975+XnAlf0Wd
	EjvzxOPpUxAk1WM97p9B+AGiyU9TnZ2Pv6ghyhuiAgLq/VyGY5uDOJ+tcQPR
X-Google-Smtp-Source: AGHT+IE0ocyOXhI1kzh65on43bQLjOXxVjqRZt8SwimkRCelqkpvDRDK2/cT9gH4NW6ZNZ4yGDyFMg==
X-Received: by 2002:a17:90a:f601:b0:2d3:b49f:acdd with SMTP id 98e67ed59e1d1-2d616b280famr1381963a91.21.1724318727559;
        Thu, 22 Aug 2024 02:25:27 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb90decasm3548820a91.23.2024.08.22.02.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:25:27 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <itugrok@yahoo.com>
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
Subject: [PATCH bpf-next v2 8/8] selftests/bpf: Support cross-endian building
Date: Thu, 22 Aug 2024 02:24:31 -0700
Message-Id: <58f6fcdb52b7a5b9ad173c266910da6f08ebfff6.1724313164.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724313164.git.tony.ambardar@gmail.com>
References: <cover.1724313164.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Ambardar <tony.ambardar@gmail.com>

Update Makefile build rules to compile BPF programs with target endianness
rather than host byte-order. With recent changes, this allows building the
full selftests/bpf suite hosted on x86_64 and targeting s390x or mips64eb
for example.

Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ec7d425c4022..11cc930ae3c5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -437,6 +437,7 @@ endef
 IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null | \
 			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
 MENDIAN=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
+BPF_TARGET_ENDIAN=$(if $(IS_LITTLE_ENDIAN),--target=bpfel,--target=bpfeb)
 
 ifneq ($(CROSS_COMPILE),)
 CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
@@ -464,17 +465,17 @@ $(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
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


