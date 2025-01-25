Return-Path: <linux-kselftest+bounces-25155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBEEA1C20A
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 08:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F272818872D4
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 07:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A4F20767D;
	Sat, 25 Jan 2025 07:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wf1iiUpj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C0715A8;
	Sat, 25 Jan 2025 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737789272; cv=none; b=SGvUt4THrOmSMLb3pOlkOBMvRasoBCIV0P4Bg+92d2iFbFPJvwlmFtXwp7rahtY7FsXaHuajT2L9I+vwrJnhSeE1GU6J1CR2QO7nb7Xw4QHJRXPF0htyHzzbZJn9Hnvkw0XbdmfvXGfUISfn7K79c8lAYTyY0Z4TcRxwpiCLUBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737789272; c=relaxed/simple;
	bh=bAEytCmIJItVawz5FtwbLf3Rs6v1xKcIjfJjz13uw38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F25Ey6pX0wyVD4PksqVweI2Eb8R/W3e4WcthqycdpgbckPhWXZzNXkcgGbE8eI4EVuZxqLmsfPq+QNMrZMUdS1fNwjZ7MseuRFNtkTbZ42GUoN+F7ViogLhfpAQTSsJ8lPOrq3F/oOOr/MWPHT1Ou8de94zDjVIJlendRJLCKik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wf1iiUpj; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so5287651a91.0;
        Fri, 24 Jan 2025 23:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737789270; x=1738394070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YbT6Z5w0G7bq6lWLN+mHRo7+c/FiVemmHUOtqfnUWhk=;
        b=Wf1iiUpjfC9DW/sWQEu4G+f8otc5ks7dTzAaLpMn+ztxSKyi5TQ6rjLcG8UF2inxT9
         EJlKLzBE4HzrWuuVfj1XYdXNraDzJ+DizO/3Y44eb3hLtbQ4lsDTsDSG4n1FmtISrvxA
         gf+5seAUg3UP/QH4SkCId6MocT+Z6CM9Z42/xRg+66gAqS4weiJDRWZ8LlgqeYTfTNqw
         ItLOqeaI7CKGPVlfXCR1Il7vSXeq/b7Farh/nLD201l3TywVURiGHt0hoM/eTM3DeiUv
         /lhgc4dd/IlPBsWrf7ZBbNU/oClpPGiPJvgKDXMShtf7gW+2yDOTD4I1H8HgFdyJBU4H
         yQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737789270; x=1738394070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YbT6Z5w0G7bq6lWLN+mHRo7+c/FiVemmHUOtqfnUWhk=;
        b=mfZyWW9UrhklwibnXSa1oUQbwwSWdNFEsNYu5e1YINUXjZJRsJCKn4A9axibEcI0CO
         o8Wff2M3yip8ze1lJeX66qP3Bu9NrzX6V2eZDDxh/h6Wm+qj4qOlwzMnmn04d74MZweO
         YIGQ6Cxy121e/FyufpTJ3sAbxs0Od3wXTUY3cpKoF7wNLVqiomSSK6JOXd4TLOF4abLQ
         kY5ciliyApvqUw6+JqXuZ5MfsOGY7KEOLNmJxqowiJNt/Yulv/IcLkdyGsfp9zGN1tgi
         braIOJSG25EyOcNa8XBev5Uy1Ec/gVeoXjqtf9yCKz1Cg70jlkGtz3SSaPVQeAXIvlt+
         eoBg==
X-Forwarded-Encrypted: i=1; AJvYcCVCwGpEpI8QtT+uuR74RHGOWKHEcWQCiLhURzqvj4kSSs4QVqGtb4xUQDhLxAiH6XcHgNhJPKxaBuiuhB27/yY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ+pE9JLNTxKpwpQUxQqCM2QNeA67DPjCKhXal51qZkEOIMRT9
	euJK+kO4UOEiGWlSWFfZHr6/TqsbLrfzLdQXfNF34ec1FXU6bN/QZcvTtvn6
X-Gm-Gg: ASbGncs5GtVZBXeDsYWcgyMoTOZY7J5fgHScLkdBC4EWCsxSWEuFIQZi+pByV1p5MgX
	BzmpwdGIKCi+yWTpg5zVQfF+BvOCT/W3su9Uym1yiuBTKWDLWA9CFeKlvlLjjJdzmQ4YUwDdwyU
	3efwIhrRYMc8RBu9mnz3mo5YqXJH80iGRDuz98T/sYmvwV4rFVNKFbnZPawlJmPruZ6lfNpviFn
	m6pKwjjEd3nQ5HU8UMlaD5ilPfZ0HmKWdPx+OtYDUR7nqGdKeawkN8e+LhG90zxpfs7toIwwoDh
	09OWp6JVfHdOHQ8ud1Tww5mCwPJvmIgpUNufokJ03U9fg4yB
X-Google-Smtp-Source: AGHT+IF/x5u//p/sLbrSoc+/DtEl2pQlBUwtefFUMMFvJHqqSPz/Q81Tg0l7W612xzqnDojUykvNTg==
X-Received: by 2002:a17:90b:2548:b0:2ee:fdf3:390d with SMTP id 98e67ed59e1d1-2f782d9a164mr46743099a91.31.1737789270080;
        Fri, 24 Jan 2025 23:14:30 -0800 (PST)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa450c9sm2925910a91.9.2025.01.24.23.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 23:14:29 -0800 (PST)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <itugrok@yahoo.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v1] selftests/bpf: Fix runqslower cross-endian build
Date: Fri, 24 Jan 2025 23:14:23 -0800
Message-Id: <20250125071423.2603588-1-itugrok@yahoo.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Ambardar <tony.ambardar@gmail.com>

The runqslower binary from a cross-endian build currently fails to run
because the included skeleton has host endianness. Fix this by passing the
target BPF endianness to the runqslower sub-make.

Fixes: 5a63c33d6f00 ("selftests/bpf: Support cross-endian building")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/bpf/runqslower/Makefile        | 3 ++-
 tools/testing/selftests/bpf/Makefile | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index c4f1f1735af6..5613b5736d93 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -6,6 +6,7 @@ OUTPUT ?= $(abspath .output)/
 BPFTOOL_OUTPUT := $(OUTPUT)bpftool/
 DEFAULT_BPFTOOL := $(BPFTOOL_OUTPUT)bootstrap/bpftool
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
+BPF_TARGET_ENDIAN ?= --target=bpf
 LIBBPF_SRC := $(abspath ../../lib/bpf)
 BPFOBJ_OUTPUT := $(OUTPUT)libbpf/
 BPFOBJ := $(BPFOBJ_OUTPUT)libbpf.a
@@ -63,7 +64,7 @@ $(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o | $(BPFTOOL)
 	$(QUIET_GEN)$(BPFTOOL) gen skeleton $< > $@
 
 $(OUTPUT)/%.bpf.o: %.bpf.c $(BPFOBJ) | $(OUTPUT)
-	$(QUIET_GEN)$(CLANG) -g -O2 --target=bpf $(INCLUDES)		      \
+	$(QUIET_GEN)$(CLANG) -g -O2 $(BPF_TARGET_ENDIAN) $(INCLUDES)	      \
 		 -c $(filter %.c,$^) -o $@ &&				      \
 	$(LLVM_STRIP) -g $@
 
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 87551628e112..6722080b2107 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -306,6 +306,7 @@ $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUTPUT)
 		    BPFTOOL_OUTPUT=$(HOST_BUILD_DIR)/bpftool/		       \
 		    BPFOBJ_OUTPUT=$(BUILD_DIR)/libbpf/			       \
 		    BPFOBJ=$(BPFOBJ) BPF_INCLUDE=$(INCLUDE_DIR)		       \
+		    BPF_TARGET_ENDIAN=$(BPF_TARGET_ENDIAN)		       \
 		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS) $(EXTRA_CFLAGS)' \
 		    EXTRA_LDFLAGS='$(SAN_LDFLAGS) $(EXTRA_LDFLAGS)' &&	       \
 		    cp $(RUNQSLOWER_OUTPUT)runqslower $@
-- 
2.34.1


