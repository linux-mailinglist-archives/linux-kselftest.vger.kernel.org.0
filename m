Return-Path: <linux-kselftest+bounces-18035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E78979D00
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 10:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416391F22AA5
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 08:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4FF148307;
	Mon, 16 Sep 2024 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Htu+jnXY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EBD1482E1;
	Mon, 16 Sep 2024 08:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726475954; cv=none; b=FyQoBHi47CSV2tMS8Kr0Cc/8TwYIO8kMVyUUbMKO05dETG1QvjZqFJ8yPW4hyynvhDQ06GLSOaYNjw3IUZ6QYQ8XgYBkF4wlSOIKuEkoPZhkI2A5UjQmryV4/wbcqGP7Pb/ExbCe6DimMVBb7MyL6sQ0qd4M+ZWWuEahsc8njPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726475954; c=relaxed/simple;
	bh=wYhjsx5j0fSruWiw7lF8smhly6RiatiU3SuINB0Dgns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B/yLLqZ27BLewtXtM5rzlOG13GTLWMmPDe9ioQyx77Vvitc/ewWuJvx9F4wVK9LEzDHWNh9e6i+pdGi+7sWoaLDWXtzOd4TQ73D2iUpFeFsPJTWz6uZmXbKuTLqAOZrsI3zNvCeLW01cfUTugjVKB+zYSjjTfhJkm7V7P7hvXdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Htu+jnXY; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d8abac30ddso3353520a91.0;
        Mon, 16 Sep 2024 01:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726475952; x=1727080752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lrrcX4sFl9xP5tQ4rgS/LVCcaLEvFX62xTF6IwSfAU=;
        b=Htu+jnXYDTYUg30dP7ovuBDCLH98otBGrd5gzndMoE3wF0wgkg8eEb+yHm6QCZYpDY
         LYV5GRcw5PqLvfuiSsWSrIvVBfXqUSkawr//JSxXGxzAkKmYd47v+yP334WvaNiB2uL0
         vIHmrhiPsV1q64CktvG2gWXG1aOYOWrKV2XANLIhCkClfHDjhyPmgBJukToFfAVc02gV
         NKaKS/jaPlTcDKOu2JsY30vTfUZK/M/ZnaBiauzPWcimc1jwPdsw2sX/dfRd5gx5y9oZ
         Iq8HmMrlMdjet8Ah8Y2lipJjnQH+5oZ9I9Cdp01JfAXhfY44aTZZYj11JvedOU4EQvNC
         t+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726475952; x=1727080752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lrrcX4sFl9xP5tQ4rgS/LVCcaLEvFX62xTF6IwSfAU=;
        b=LFEqykxG2WPImQvluzJHu+HqYJ6mTE8/3jxbzfmSzxiehLpCmsEJJQmjAQEt8kbaub
         cgmosSpExS4hsgyk8lXuRKCkZtQP4S4LYPMdZr+5Sh5ed7RUTFU3b/ucFyuL0UxU+9Hd
         FimLz525T8xpu9avueTAk/x4kQNem8Nb2Wzyjejd+GjHPj4CCVujHM1DHOAWs3hEPnRw
         uwGGN/zBUAGHKe0hkxn9PcqmrA1VEdmP3sHIAmR9FdY1p7rAtVa63Q2qHjdmh+F1lnBq
         ZII40RygVjdFcPHZeXLh7xKbIqfNabokfItpVGqGt7EOT1HszuGwlvLNTrw602w6XSOZ
         DSOg==
X-Forwarded-Encrypted: i=1; AJvYcCUPea9ejtFY6h5WLUiKpdmTMBFrGh5x5wSXv0ElD34dUevd/VDKRtpYvnXpIlq9zVLBUz3zEIaeXFZ82j0GKqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeGlxvP8GS8/+1gG4KP0m0eMG1Ieavr0ZLJSDlmbkzJHnPSlCw
	nqZ8VEKRJfuMP5XG7K3ewKKXgPNI/mYPx0dpjYYtafnSWqp9QdUWV5Oonw==
X-Google-Smtp-Source: AGHT+IHfy+YwKDLqXgEJCABCfB88Ld0SIoFmbJeurWm032FCSH4b4G3KPoeopwedhBnITpy5yR8niA==
X-Received: by 2002:a17:90a:77cb:b0:2d8:8681:44ba with SMTP id 98e67ed59e1d1-2db9ffbccb4mr15478025a91.15.1726475951628;
        Mon, 16 Sep 2024 01:39:11 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfcbb424sm4585832a91.7.2024.09.16.01.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 01:39:11 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 8/8] selftests/bpf: Support cross-endian building
Date: Mon, 16 Sep 2024 01:37:47 -0700
Message-Id: <880ccc6342cfc4d3c48b44f581e87adfbce2876e.1726475448.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1726475448.git.tony.ambardar@gmail.com>
References: <cover.1726475448.git.tony.ambardar@gmail.com>
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

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f04af11df8eb..5d302db43778 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -446,6 +446,7 @@ endef
 IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null | \
 			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
 MENDIAN=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
+BPF_TARGET_ENDIAN=$(if $(IS_LITTLE_ENDIAN),--target=bpfel,--target=bpfeb)
 
 ifneq ($(CROSS_COMPILE),)
 CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
@@ -473,17 +474,17 @@ $(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
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


