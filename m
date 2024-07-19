Return-Path: <linux-kselftest+bounces-13945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C55937E00
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 01:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793362818E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jul 2024 23:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FAD824BD;
	Fri, 19 Jul 2024 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+SrCbom"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B20148832;
	Fri, 19 Jul 2024 23:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721431372; cv=none; b=RqG6oXlhwxEPB3CkSWNxEF/5CGyTFfbGE9iqeJ8OIW0zI7sGgPe0vEbHB49CisneuDTGk+a9eng7ww+ZnAmZIMpgTlcFysXa4iuvQ+8qoO/6oy8rY3iwlj8kP5Lbq1KxQkOpvH/PUSS/bYP5T1wd4LGnomSdzYoquD6/k3hBF2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721431372; c=relaxed/simple;
	bh=k5yWts3IfpxL5kY101C26SrZnISGe8ThAleI4AjQr5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JZQ1XspmjBUNIRc++wJhU/ux7hi30ZbExrCQ6Y7GbnZZYBG2liGDaBo2GXcDwj0GlhWADI89gzNkw3PISMdY8FukGtgpzl4Fge6MbtDtzrhBJv5ZCwNqhl7lP/hiYd1iHROu8TAnWbso9y7A3ltGpJFbtcdY1RrvPq0K8qdJ5eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+SrCbom; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-708cf5138b6so1824367a34.0;
        Fri, 19 Jul 2024 16:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721431370; x=1722036170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlPUdh5CqwjsPLrSfhJrbf/di0LioDu/KZ6/nhZkLEI=;
        b=g+SrCbomV+q78z+QXsLE+uk9v/H4jbLU0bBL/bNSmQDiKTVv4soe/KSufyvZsdTmOd
         +i9uiUKDcowKFnYsLSma4FNIcYGT49MsFremFRpam6dlO3wafIK1KSjrgapNE4gn2oa/
         opQXIWpEz683zp69/lEz+35EtQBQxJwi/xQnWwIXPBNnKlOPw++f0Ll/K1MGtgyW98ZT
         E/kes0+OVTiQXWQ8eYsRuTHWll7+6k+gFSwAc/2Y9x0s6aKppo5OQk5Dvq9OXJoDXaC0
         67kj/ClGc/WUgnUF+lmjpIEzk38EQ4BSVWgr/ZdvQauq75aNupJNQxptkMNAEfqwxC98
         c7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721431370; x=1722036170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DlPUdh5CqwjsPLrSfhJrbf/di0LioDu/KZ6/nhZkLEI=;
        b=fKavk94SBqcUgdsYXt/KS70dankNvhAJp5SjntzeSFgfHv/8fakTTfJMzLTqRPTDOp
         M+41gWl5aywi8D/lM5nD2I7FvcfRzhCMTdIkOfscxAe/+LoO19bT3l8xOEYO/Fvfp+YS
         ETnILF/HZMRUmVCad+cx5N1RUkwwS0jigM7w5RzVDe2xFTBxolq4uQuIeTf+ZDNEvM0o
         hLOI7AMxsPh5Nm/2XWKJhTzaEMbz8vjN8DeV0JfgL7Qt5PiUVUaSdKCeBAiQjHqLN3W6
         1LYHQKx5rlhnqPHByptNV7xMD6GL8C3ORE4QXvKyj5J7cmEmZFpI5ueFtjdxM6Ic68xZ
         RwhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWroEfc2BEQ1IldcmY0vg+3qx4VdvglCUhnQHgOfgJxKcWV3MtYwPWgXkW2hpEAU2kVOXlyuej+Ly2qvekRr0Vgd5xH0FUSvOHbWFZ98s2S
X-Gm-Message-State: AOJu0YxsanUsowZUIxbx2nXISRXuhebg4dc24GwaM6RIRMMXYeNJgDpF
	aAmTCl1RL8MXIagl4fqLVTCa9zQ/Omlw0sfiE/QwfebRCAqVMJ9Dhwh7VHMx
X-Google-Smtp-Source: AGHT+IHkmdjDvJEeIBGjQa+p+9ky4wWaxzKP6CUMg6og3d6ciIIzNfJKed1fILbgpVpglMZLdkO/6Q==
X-Received: by 2002:a05:6870:41c8:b0:254:affe:5a05 with SMTP id 586e51a60fabf-261213de6dcmr1227717fac.21.1721431369852;
        Fri, 19 Jul 2024 16:22:49 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff5f894dsm1701616b3a.185.2024.07.19.16.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 16:22:49 -0700 (PDT)
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
Subject: [PATCH bpf-next v1] selftests/bpf: Fix wrong binary in Makefile log output
Date: Fri, 19 Jul 2024 16:21:59 -0700
Message-Id: <20240719232159.2147210-1-tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAEf4BzarKiUZqNcq1E+6SaeG8oP5+SfSLLoTNKF3_+7MS6CtyQ@mail.gmail.com>
References: <CAEf4BzarKiUZqNcq1E+6SaeG8oP5+SfSLLoTNKF3_+7MS6CtyQ@mail.gmail.com>
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
 tools/testing/selftests/bpf/Makefile | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 0b4bfbc0ef68..67921e3367dd 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -425,27 +425,28 @@ $(OUTPUT)/flow_dissector_load.o: flow_dissector_load.h
 $(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
 
 # Build BPF object using Clang
-# $1 - input .c file
-# $2 - output .o file
-# $3 - CFLAGS
+# $1 - binary name
+# $2 - input .c file
+# $3 - output .o file
+# $4 - CFLAGS
 define CLANG_BPF_BUILD_RULE
-	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
-	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v3 -o $2
+	$(call msg,CLNG-BPF,$1,$3)
+	$(Q)$(CLANG) $4 -O2 --target=bpf -c $2 -mcpu=v3 -o $3
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
 define CLANG_NOALU32_BPF_BUILD_RULE
-	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
-	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v2 -o $2
+	$(call msg,CLNG-BPF,$1,$3)
+	$(Q)$(CLANG) $4 -O2 --target=bpf -c $2 -mcpu=v2 -o $3
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with cpu-v4
 define CLANG_CPUV4_BPF_BUILD_RULE
-	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
-	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v4 -o $2
+	$(call msg,CLNG-BPF,$1,$3)
+	$(Q)$(CLANG) $4 -O2 --target=bpf -c $2 -mcpu=v4 -o $3
 endef
 # Build BPF object using GCC
 define GCC_BPF_BUILD_RULE
-	$(call msg,GCC-BPF,$(TRUNNER_BINARY),$2)
-	$(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c $1 -o $2
+	$(call msg,GCC-BPF,$1,$3)
+	$(Q)$(BPF_GCC) $4 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c $2 -o $3
 endef
 
 SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
@@ -534,7 +535,7 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
 		     $(wildcard $(BPFDIR)/bpf_*.h)			\
 		     $(wildcard $(BPFDIR)/*.bpf.h)			\
 		     | $(TRUNNER_OUTPUT) $$(BPFOBJ)
-	$$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,			\
+	$$(call $(TRUNNER_BPF_BUILD_RULE),$(TRUNNER_BINARY),$$<,$$@,	\
 					  $(TRUNNER_BPF_CFLAGS)         \
 					  $$($$<-CFLAGS)		\
 					  $$($$<-$2-CFLAGS))
-- 
2.34.1


