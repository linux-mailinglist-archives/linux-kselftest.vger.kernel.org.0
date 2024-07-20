Return-Path: <linux-kselftest+bounces-13949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2759A937F09
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 07:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C780A28157B
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 05:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561A6D28D;
	Sat, 20 Jul 2024 05:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R79Rbeth"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C08D2E6;
	Sat, 20 Jul 2024 05:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721453192; cv=none; b=nEOt+6B8A1mW3e8ElHWmhlKu4U3Yt4JmBlq1byqn9IkektAOTLPRTkNkRHOP3lsZlVSiSUr11uNkjwBk9eDZ+H9H7QayzGhS1I8QGe/46PtSFT3rCImN/M+lRDpW5tPqeeTbiXLAbVLS2+6FBHV12NFmDkrVD4Q6aLdkuWz5IHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721453192; c=relaxed/simple;
	bh=+YC1Hrl1E961SO8HFvnXRTaKZ1qdLhzYog3y55+7BT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rCbx1OFUGZiCgfjnFL8nqC5japlcggFwva0cty0OdB78kZKQbN3fy6QgXIfbq7KwqxEbiyHdgWO/XEjSIB2dxm51zFA+FVWAkPL4j/digf0684lW7uU3AkchJDonsfjeu04PyzxlSWRVEI7dWyEOqN1UKHJ22HkU4KfW/wm9uIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R79Rbeth; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fb3b7d0d3aso15517665ad.2;
        Fri, 19 Jul 2024 22:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721453190; x=1722057990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oj4bUQiEqdtRbLD9n4XkiJyLnyaVflatpwLV4yaEQao=;
        b=R79RbethZazarhGl9SR7fj1w5LRyNjoV2uGkBxlbp6UPBWDPGQDv0vRSsKvhVEhGWk
         55HeH7xEKatjlTDLiTeAFdpGBzqeESmgP2BEsGFjEf7tJt/PAZupNMtuZRov9oMex++S
         CPwAfh2yqgTjyUPSjgQX7zuzvcyP6AlhBnlMTRF+qGZ7EwgpRHbOIHOGvMnVfsFzSlnM
         NYaI9lf4XUZ0sEWipCa5rutBhtcNzxImwCD6kA3+CSAtGdEYy0Ec8pfJb7G5sUOCj5aI
         9oNr6o/AZK/MpVOLWx41xE6dsi0FbL1N/m/10E46ZsOu3myR6yPGgDXXDmaTpn3bTThj
         +i8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721453190; x=1722057990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oj4bUQiEqdtRbLD9n4XkiJyLnyaVflatpwLV4yaEQao=;
        b=YEfuCHKchNgyJGRai7y9/bOrvsl23gu7fs0+qRUlBdjG/HhGMqs9cegXVIVdDHKFNc
         D+J1h0dAgXv2JxX41bokgV/LvykOPN3w4CZ2SDGzCFjU9oN7hw+FudebuUjTtj5TMPC0
         EtvVM19YTwt7uFj7aiY/TrB2VacxkVLme1kKnPozoxQu6CouX1Gp/Bj8Z/W2fJYD83WT
         TTThDq1hyHckSOvmBSYcD2f/8S0NLgBtZA7zX/AXgdjk3UndzqVB1GRylZDBZCRqqdba
         GK2WkKIi/mhrdLcjrtiWFqOrLzwsoUg+LrVqt4M6/GBDd+RUPzOK9CEpuaCltAKs2grS
         Q4fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeErPztQcZARcS5A6URSzUNt1Qk14u6v7z/mznt0f5mk3epDgyEIhutZcgt6ErFMr1ErfoimXUifx9a4eDZsw1rcb/RoCDVEy5HSOMZWGC
X-Gm-Message-State: AOJu0YwBWrW0iuAvLpOxyl/DFmvYgUKN87mmvr2mySHIxKwtucDlSQE5
	hHH25yj5EmChm2/q17xh9FHXfWBTNCfqFk1UKDasWHcXJEML0HGj3fysizm8nn8=
X-Google-Smtp-Source: AGHT+IH3HjPfXG+cU1rnUaNWMKVbKxzd+jn1jLPPP+FhZobNbUvFl59qz548Sgnte2Aah5Abq51HjA==
X-Received: by 2002:a17:903:41cb:b0:1f9:f538:4b09 with SMTP id d9443c01a7336-1fd74650672mr21554005ad.57.1721453189791;
        Fri, 19 Jul 2024 22:26:29 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31a3ecsm13753955ad.177.2024.07.19.22.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 22:26:29 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH bpf-next v2] selftests/bpf: Fix wrong binary in Makefile log output
Date: Fri, 19 Jul 2024 22:25:35 -0700
Message-Id: <20240720052535.2185967-1-tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240719232159.2147210-1-tony.ambardar@gmail.com>
References: <20240719232159.2147210-1-tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make log output incorrectly shows 'test_maps' as the binary name for every
'CLNG-BPF' build step, apparently picking up the last value defined for the
$(TRUNNER_BINARY) variable. Update the 'CLANG_BPF_BUILD_RULE' variants to
fix this confusing output.

Current output:
  CLNG-BPF [test_maps] access_map_in_map.bpf.o
  GEN-SKEL [test_progs] access_map_in_map.skel.h
  ...
  CLNG-BPF [test_maps] access_map_in_map.bpf.o
  GEN-SKEL [test_progs-no_alu32] access_map_in_map.skel.h
  ...
  CLNG-BPF [test_maps] access_map_in_map.bpf.o
  GEN-SKEL [test_progs-cpuv4] access_map_in_map.skel.h

After fix:
  CLNG-BPF [test_progs] access_map_in_map.bpf.o
  GEN-SKEL [test_progs] access_map_in_map.skel.h
  ...
  CLNG-BPF [test_progs-no_alu32] access_map_in_map.bpf.o
  GEN-SKEL [test_progs-no_alu32] access_map_in_map.skel.h
  ...
  CLNG-BPF [test_progs-cpuv4] access_map_in_map.bpf.o
  GEN-SKEL [test_progs-cpuv4] access_map_in_map.skel.h

Fixes: a5d0c26a2784 ("selftests/bpf: Add a cpuv4 test runner for cpu=v4 testing")
Fixes: 89ad7420b25c ("selftests/bpf: Drop the need for LLVM's llc")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 0b4bfbc0ef68..41acba62b8c4 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -428,23 +428,24 @@ $(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
 # $1 - input .c file
 # $2 - output .o file
 # $3 - CFLAGS
+# $4 - binary name
 define CLANG_BPF_BUILD_RULE
-	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
+	$(call msg,CLNG-BPF,$4,$2)
 	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v3 -o $2
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
 define CLANG_NOALU32_BPF_BUILD_RULE
-	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
+	$(call msg,CLNG-BPF,$4,$2)
 	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v2 -o $2
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with cpu-v4
 define CLANG_CPUV4_BPF_BUILD_RULE
-	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
+	$(call msg,CLNG-BPF,$4,$2)
 	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v4 -o $2
 endef
 # Build BPF object using GCC
 define GCC_BPF_BUILD_RULE
-	$(call msg,GCC-BPF,$(TRUNNER_BINARY),$2)
+	$(call msg,GCC-BPF,$4,$2)
 	$(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c $1 -o $2
 endef
 
@@ -537,7 +538,7 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
 	$$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,			\
 					  $(TRUNNER_BPF_CFLAGS)         \
 					  $$($$<-CFLAGS)		\
-					  $$($$<-$2-CFLAGS))
+					  $$($$<-$2-CFLAGS),$(TRUNNER_BINARY))
 
 $(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
-- 
2.34.1


