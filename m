Return-Path: <linux-kselftest+bounces-26593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAB4A35059
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 22:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 852C17A4930
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 21:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C692698A2;
	Thu, 13 Feb 2025 21:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PQgOjTPS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853E4269823
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739481158; cv=none; b=owfCD6d3ip/UUW+l62UdI0dU/L/lqbbYSQ7rm4s0wuTJqtEO2/V3huSRsNiKLt88uOHVtai+V53L2XkwPgpZVricbT1DxpfqJtF4rs9NN7Veyi9FlogDI8y24XYsRRo/56fayg1coKQVore7pfoU1Lh6KlOwil4a7Kta2mxjwRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739481158; c=relaxed/simple;
	bh=LaWY661hGGOsz8ab9A8tX3O52beRD/JORrirTIwPdYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AyeBT37iI2C9TExdz3Fq9ssJZCkF2zS8IqD33G6tUL+80yttK26qFHVMHOiUu3iGx7F3W5z9rAkpZKHDGA0yreFXq6/10A9hQaNdZUyhnMI7R5UrE4F3NGzn0h8q5qUhk0czxDu48QnVzWD9mUYKJoPyJTRNHMy4jEAsnsGfJsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PQgOjTPS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f55fbb72bso25346835ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 13:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739481155; x=1740085955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dCT5jcbY95du2Tjjq6rItJv9SEP2f87N9w5dx/eCvk=;
        b=PQgOjTPSZ018B7gXHtYTZ5cRL50oqDk9VjHlUmAM1ERVJShkmoz/p6hKEKzwtRjDNY
         po6iTqmYTlvXp98UsSVtAkMNSQ/MBAAbYVQycjTeVLKTtnVOtrT5IwJx0pp7bJW8yzRM
         zycNB69qQDWQLooo6hDzJfOC6QSax+5hV8oD04YhjuRF4dmcKVwW1ZnooFrXvHyLOnEJ
         TFypj/qjuk49tse64lXBXoEyp5453DjrsmfnDxc6Tij4a0XpLwBOS7iCIdQlF5ru8Ock
         Ueav0D4Msz4raWAfzewlOF1AGnZL0oQPiS4Es067DrW12AIveFAApfkEPV6L7S5W+Mwa
         tbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739481155; x=1740085955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dCT5jcbY95du2Tjjq6rItJv9SEP2f87N9w5dx/eCvk=;
        b=hG8HFatXejdwNQypl+c7ueyw2jvZwz1GhFHn1u+2xivVjlawH6Y9J1M/RHKuuF2OdL
         EcHxJQDdsG9JJcuMF9T+d0DLM0VYx4uh0IyJy6kP3XMxtlJzMmmghYYLkOyhVaWMXM/o
         /yPi3gOPIFTg3zRL6kz8Yj/gTY7S9Ke6jL8a4mTYHGU+zeNtfW3wPYPdZ9OZfsG0SKYX
         Xvzr4wq+dihOyPlOFVfsaxFLX2MCHgD8/tTat65qv25Sac3nrg+DU43z66lMTaClFk4H
         pwckFvisFq8DAIq1mXuAaHgXIFbbe3um6q1w6haQKejJtY3earB6+85d2EMjQOnb0HBE
         j3Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVnnIJgstRuUGyu+YE5IParVgBG74m9vitBEuwFuIPs/gGUnWFcgER6YjuN1E7LlPYlMt9K0LatRt7oNrVr21Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrdA0OGFVOr/mKArtT19Fd1Rjjhtgp5wN08qiijAd5UB9ikVQq
	wVxkfkkz9HuN87EjZehSxUFIHGyjDz3pcxjEnD+WPXBDf00PFvQmjr+H612S558=
X-Gm-Gg: ASbGnctp3Czusb/3L0khcZt2Pamhir2NGoKrc8qPnLMXwOUuU8n7LHZTnfuN+IAlv2w
	/9wRf0j9cZbe4BWyIpOIMm2RzYHrdi2cViUMdlGHg+wCCLHbkTmmMkXKzSmINUpi4XUwr98a7i8
	k1Joc9mrApc3rq82Yv73KAK6B9GOcGPjMZc6OJEqNxiBdnVYCun4MC05RqY+Gz/mJVveNJsMYV3
	fnanO3LGXr5NQytOsmuXQoJtHOj+QhGHTa7sHfaLPkgryOPpYY0Hbw/+cHGplo6FosQuikx+FtH
	JjArJbLPtg+GYD/PLwaqgHyCMJgnco0=
X-Google-Smtp-Source: AGHT+IHWMlGwUiWdsiNRbvm7dD8sEMzLzmRqwl/PU5Ys8fbVS90IAlTNhDD0UoMI3fOVabW+kAQ4WQ==
X-Received: by 2002:a05:6a00:3e04:b0:730:9334:18f3 with SMTP id d2e1a72fcca58-7323c1bcde7mr7654326b3a.19.1739481154657;
        Thu, 13 Feb 2025 13:12:34 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324257fdd6sm1758072b3a.76.2025.02.13.13.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 13:12:34 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 13 Feb 2025 13:06:22 -0800
Subject: [PATCH v3 2/2] tools: Remove redundant quiet setup
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-quiet_tools-v3-2-07de4482a581@rivosinc.com>
References: <20250213-quiet_tools-v3-0-07de4482a581@rivosinc.com>
In-Reply-To: <20250213-quiet_tools-v3-0-07de4482a581@rivosinc.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Quentin Monnet <qmo@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10133; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=LaWY661hGGOsz8ab9A8tX3O52beRD/JORrirTIwPdYI=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/q6BGu5TUfqNyQ4drwoiJ+XWX7zwBmVfSudWRT0mS+9f
 6jGzv6oo5SFQYyLQVZMkYXnWgNz6x39sqOiZRNg5rAygQxh4OIUgImsvszwz7bS6cPv4DW/n82q
 c1vDlz51t8ZH3vIlkd7+d8qjXp67tpThf3xtgqCr1zKtYgkrh/mW1rFZmbr1cr4pv1r89977OvU
 rMwA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Q is exported from Makefile.include so it is not necessary to manually
set it.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Acked-by: Quentin Monnet <qmo@kernel.org>
---
 tools/arch/arm64/tools/Makefile           |  6 ------
 tools/bpf/Makefile                        |  6 ------
 tools/bpf/bpftool/Documentation/Makefile  |  6 ------
 tools/bpf/bpftool/Makefile                |  6 ------
 tools/bpf/resolve_btfids/Makefile         |  2 --
 tools/bpf/runqslower/Makefile             |  5 +----
 tools/lib/bpf/Makefile                    | 13 -------------
 tools/lib/perf/Makefile                   | 13 -------------
 tools/lib/thermal/Makefile                | 13 -------------
 tools/objtool/Makefile                    |  6 ------
 tools/testing/selftests/bpf/Makefile.docs |  6 ------
 tools/testing/selftests/hid/Makefile      |  2 --
 tools/thermal/lib/Makefile                | 13 -------------
 tools/tracing/latency/Makefile            |  6 ------
 tools/tracing/rtla/Makefile               |  6 ------
 tools/verification/rv/Makefile            |  6 ------
 16 files changed, 1 insertion(+), 114 deletions(-)

diff --git a/tools/arch/arm64/tools/Makefile b/tools/arch/arm64/tools/Makefile
index 7b42feedf647190ad498de0937e8fb557e40f39c..de4f1b66ef0148b7bfd0fd16655ad854c7542240 100644
--- a/tools/arch/arm64/tools/Makefile
+++ b/tools/arch/arm64/tools/Makefile
@@ -13,12 +13,6 @@ AWK	?= awk
 MKDIR	?= mkdir
 RM	?= rm
 
-ifeq ($(V),1)
-Q =
-else
-Q = @
-endif
-
 arm64_tools_dir = $(top_srcdir)/arch/arm64/tools
 arm64_sysreg_tbl = $(arm64_tools_dir)/sysreg
 arm64_gen_sysreg = $(arm64_tools_dir)/gen-sysreg.awk
diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
index 243b79f2b451e52ca196f79dc46befd1b3dab458..062bbd6cd048e9e42f9bc8f9972ec96594f3dbd2 100644
--- a/tools/bpf/Makefile
+++ b/tools/bpf/Makefile
@@ -27,12 +27,6 @@ srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif
 
-ifeq ($(V),1)
-  Q =
-else
-  Q = @
-endif
-
 FEATURE_USER = .bpf
 FEATURE_TESTS = libbfd disassembler-four-args disassembler-init-styled
 FEATURE_DISPLAY = libbfd
diff --git a/tools/bpf/bpftool/Documentation/Makefile b/tools/bpf/bpftool/Documentation/Makefile
index 4315652678b9f2e27e48b7815f3b9ddc70a57165..bf843f328812e10dd65a73f355f74e6825ad95b9 100644
--- a/tools/bpf/bpftool/Documentation/Makefile
+++ b/tools/bpf/bpftool/Documentation/Makefile
@@ -5,12 +5,6 @@ INSTALL ?= install
 RM ?= rm -f
 RMDIR ?= rmdir --ignore-fail-on-non-empty
 
-ifeq ($(V),1)
-  Q =
-else
-  Q = @
-endif
-
 prefix ?= /usr/local
 mandir ?= $(prefix)/man
 man8dir = $(mandir)/man8
diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index dd9f3ec842017f1dd24054bf3a0986d546811dc4..6ea4823b770cbbe7fd9eb7da79956cc1dae1f204 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -7,12 +7,6 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif
 
-ifeq ($(V),1)
-  Q =
-else
-  Q = @
-endif
-
 BPF_DIR = $(srctree)/tools/lib/bpf
 
 ifneq ($(OUTPUT),)
diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 4b8079f294f65b284481e9a2bf6ff52594a4669a..afbddea3a39c64ffb2efc874a3637b6401791c5b 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -5,10 +5,8 @@ include ../../scripts/Makefile.arch
 srctree := $(abspath $(CURDIR)/../../../)
 
 ifeq ($(V),1)
-  Q =
   msg =
 else
-  Q = @
   ifeq ($(silent),1)
     msg =
   else
diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index c4f1f1735af659c2e660a322dbf6912d9a5724bc..e49203ebd48c18607a6136a9e805ccf16ee960d3 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -26,10 +26,7 @@ VMLINUX_BTF_PATHS := $(if $(O),$(O)/vmlinux)		\
 VMLINUX_BTF_PATH := $(or $(VMLINUX_BTF),$(firstword			       \
 					  $(wildcard $(VMLINUX_BTF_PATHS))))
 
-ifeq ($(V),1)
-Q =
-else
-Q = @
+ifneq ($(V),1)
 MAKEFLAGS += --no-print-directory
 submake_extras := feature_display=0
 endif
diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 857a5f7b413d6dc4cbe7bc4167496674dd08d875..168140f8e6461bd06db40e23d21a3fb8847ccbf4 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -53,13 +53,6 @@ include $(srctree)/tools/scripts/Makefile.include
 
 # copy a bit from Linux kbuild
 
-ifeq ("$(origin V)", "command line")
-  VERBOSE = $(V)
-endif
-ifndef VERBOSE
-  VERBOSE = 0
-endif
-
 INCLUDES = -I$(or $(OUTPUT),.) \
 	   -I$(srctree)/tools/include -I$(srctree)/tools/include/uapi \
 	   -I$(srctree)/tools/arch/$(SRCARCH)/include
@@ -96,12 +89,6 @@ override CFLAGS += $(CLANG_CROSS_FLAGS)
 # flags specific for shared library
 SHLIB_FLAGS := -DSHARED -fPIC
 
-ifeq ($(VERBOSE),1)
-  Q =
-else
-  Q = @
-endif
-
 # Disable command line variables (CFLAGS) override from top
 # level Makefile (perf), otherwise build Makefile will get
 # the same command line setup.
diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 3a9b2140aa048ea919c69ed2240bf0ea444dbf21..e9a7ac2c062e2b398c2f22af41907b62815ca07e 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -39,19 +39,6 @@ libdir = $(prefix)/$(libdir_relative)
 libdir_SQ = $(subst ','\'',$(libdir))
 libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
 
-ifeq ("$(origin V)", "command line")
-  VERBOSE = $(V)
-endif
-ifndef VERBOSE
-  VERBOSE = 0
-endif
-
-ifeq ($(VERBOSE),1)
-  Q =
-else
-  Q = @
-endif
-
 TEST_ARGS := $(if $(V),-v)
 
 # Set compile option CFLAGS
diff --git a/tools/lib/thermal/Makefile b/tools/lib/thermal/Makefile
index 8890fd57b110ccc1a837d37624a5dead00f18656..a1f5e388644d31d36f973d3ddce48d036ee0a083 100644
--- a/tools/lib/thermal/Makefile
+++ b/tools/lib/thermal/Makefile
@@ -39,19 +39,6 @@ libdir = $(prefix)/$(libdir_relative)
 libdir_SQ = $(subst ','\'',$(libdir))
 libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
 
-ifeq ("$(origin V)", "command line")
-  VERBOSE = $(V)
-endif
-ifndef VERBOSE
-  VERBOSE = 0
-endif
-
-ifeq ($(VERBOSE),1)
-  Q =
-else
-  Q = @
-endif
-
 # Set compile option CFLAGS
 ifdef EXTRA_CFLAGS
   CFLAGS := $(EXTRA_CFLAGS)
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index f56e2772753414ff8d3462bdebbc8e95e7667fcd..7a65948892e569cbe1d6e5a78db68bb35102cd26 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -46,12 +46,6 @@ HOST_OVERRIDES := CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)"
 AWK = awk
 MKDIR = mkdir
 
-ifeq ($(V),1)
-  Q =
-else
-  Q = @
-endif
-
 BUILD_ORC := n
 
 ifeq ($(SRCARCH),x86)
diff --git a/tools/testing/selftests/bpf/Makefile.docs b/tools/testing/selftests/bpf/Makefile.docs
index eb6a4fea8c794d8354363ac8daa0baac3e3bd060..f7f9e7088bb38c7507282990fb62921ca7a636d2 100644
--- a/tools/testing/selftests/bpf/Makefile.docs
+++ b/tools/testing/selftests/bpf/Makefile.docs
@@ -7,12 +7,6 @@ INSTALL ?= install
 RM ?= rm -f
 RMDIR ?= rmdir --ignore-fail-on-non-empty
 
-ifeq ($(V),1)
-  Q =
-else
-  Q = @
-endif
-
 prefix ?= /usr/local
 mandir ?= $(prefix)/man
 man2dir = $(mandir)/man2
diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index 0336353bd15f0d56dbed6c8fa02f53c234f949e1..2839d2612ce3a70f4332f8e886586e9cca6f03cb 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -43,10 +43,8 @@ TEST_GEN_PROGS = hid_bpf hidraw
 # $3 - target (assumed to be file); only file name will be emitted;
 # $4 - optional extra arg, emitted as-is, if provided.
 ifeq ($(V),1)
-Q =
 msg =
 else
-Q = @
 msg = @printf '  %-8s%s %s%s\n' "$(1)" "$(if $(2), [$(2)])" "$(notdir $(3))" "$(if $(4), $(4))";
 MAKEFLAGS += --no-print-directory
 submake_extras := feature_display=0
diff --git a/tools/thermal/lib/Makefile b/tools/thermal/lib/Makefile
index f2552f73a64c7eb1be24c27b3a1414617391315b..056d212f25cf51cd8c02260fbe2ef28dda5e4acb 100644
--- a/tools/thermal/lib/Makefile
+++ b/tools/thermal/lib/Makefile
@@ -39,19 +39,6 @@ libdir = $(prefix)/$(libdir_relative)
 libdir_SQ = $(subst ','\'',$(libdir))
 libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
 
-ifeq ("$(origin V)", "command line")
-  VERBOSE = $(V)
-endif
-ifndef VERBOSE
-  VERBOSE = 0
-endif
-
-ifeq ($(VERBOSE),1)
-  Q =
-else
-  Q = @
-endif
-
 # Set compile option CFLAGS
 ifdef EXTRA_CFLAGS
   CFLAGS := $(EXTRA_CFLAGS)
diff --git a/tools/tracing/latency/Makefile b/tools/tracing/latency/Makefile
index 6518b03e05c71b4fa84498f9628adf81a38c9f56..257a56b1899f23837de533353e9c2cebdb6035bd 100644
--- a/tools/tracing/latency/Makefile
+++ b/tools/tracing/latency/Makefile
@@ -37,12 +37,6 @@ FEATURE_TESTS	+= libtracefs
 FEATURE_DISPLAY	:= libtraceevent
 FEATURE_DISPLAY	+= libtracefs
 
-ifeq ($(V),1)
-  Q 		=
-else
-  Q 		= @
-endif
-
 all: $(LATENCY-COLLECTOR)
 
 include $(srctree)/tools/build/Makefile.include
diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 8b5101457c70b48e9c720f1ba53293f1307c15a2..0b61208db604ec0754024c3007db6b2fe74a613c 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -37,12 +37,6 @@ FEATURE_DISPLAY	:= libtraceevent
 FEATURE_DISPLAY	+= libtracefs
 FEATURE_DISPLAY	+= libcpupower
 
-ifeq ($(V),1)
-  Q		=
-else
-  Q		= @
-endif
-
 all: $(RTLA)
 
 include $(srctree)/tools/build/Makefile.include
diff --git a/tools/verification/rv/Makefile b/tools/verification/rv/Makefile
index 411d62b3d8eb93abf85526ad33cafd783df86bc1..5b898360ba4818b12e8a16c27bd88c75d0076fb9 100644
--- a/tools/verification/rv/Makefile
+++ b/tools/verification/rv/Makefile
@@ -35,12 +35,6 @@ FEATURE_TESTS	+= libtracefs
 FEATURE_DISPLAY	:= libtraceevent
 FEATURE_DISPLAY	+= libtracefs
 
-ifeq ($(V),1)
-  Q		=
-else
-  Q		= @
-endif
-
 all: $(RV)
 
 include $(srctree)/tools/build/Makefile.include

-- 
2.43.0


