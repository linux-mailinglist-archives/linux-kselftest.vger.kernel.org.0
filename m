Return-Path: <linux-kselftest+bounces-26205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB43BA2F72F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 19:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F2A167856
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 18:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D448B2566F1;
	Mon, 10 Feb 2025 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="eoYEbEe3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11585255E56
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212505; cv=none; b=OXrOcYkEbNHI3tfxcD66KV9D2i0e5nXBlV44UlnBzatg1eMsr2MSNISqaq2pNdgmHg0CUzMZsm7k/n6tYJOy8OC9S0K5MoCbt+nScNc1UFG9QK9Aup78cEeRO1bogCvHVGW9UVq6k7SvpO4owvDvMJU1S1BtvLCG/LeEpKEEorA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212505; c=relaxed/simple;
	bh=m6vPvto3/8VAhwSYAOsb0B0lfqjzn/c3aN5DgiXezEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B7IphTEXDAWOM+t6qAUw+lroAtbx4tY+JmJB8plhddnZtp5wf2Z2JtmMqYpx8YkY5Y4AIZ7OHZX5HYM8vm+n7u5DY09818eKmbMPOX2MHg1JDQrvOqWoFxu5mIe8siQWBZ1xbqV4aULhl0Aus+btUkqk0jkREAfgm8hcG9c9ypI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=eoYEbEe3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f464b9a27so77748405ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 10:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739212503; x=1739817303; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vp4U5RjZNMaLfDL8FhGoAp2lWpVtDVf1/5CCeKs7dXI=;
        b=eoYEbEe3PbIZxg7miQabqeR5BEYTfaoDPioosHFjvmskgJbDMsdaI+3W3LtsMQO/hv
         9qym1BnbAbvHathgSt8ii+ELgBPKwVpxaHWdrxgw5E97kxHQLotEtTjTsJslTL3X0cJY
         HoGIYFNOtrzk/H+YCrlGO9YsRxU8vVwqUDK1HKKUIQ+WzRR8pOeFBou9f91loeP3OSal
         U/O2KWs3oxTfTXQAEZxsDriyVz0Q88rdt1j2pLg1tX22nswKShr1+hnNEYXhnxiDIrh5
         RWtOpYtRaU6pGSu/F0EFd90djrU3Rlqe2pVERN+o81eg+DautBss+41uJ1dBEHxbb5Hv
         dMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739212503; x=1739817303;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vp4U5RjZNMaLfDL8FhGoAp2lWpVtDVf1/5CCeKs7dXI=;
        b=qHtne8uAEWFvvydy2RSRkPXuB9CwlFFBNHO4BsFEElczTC6xE0wNdfZQjOpeDd4hU9
         sArRax9lx2PvVcWlRtL9Vud2WFpDw6o20tJRbg5EdPnRsb4OreubhDx83UjjtByc/83I
         htJJ/x01lrhuSaGUGU6Qpyey+quXADHvgE9yVyiE5q3+mU37RKTE3E9IlPP6P5KTIUfE
         qv97MXnoT+A5etxc+ZFW2oWrN//eiio4qtGmgXsPdR9vXqV5KgaTasx6JwjpxNe5QAnh
         Fp/cO1VUrnd9hOAcA/vuogVqQe+i70/0EHe3NLl+QwJdrCCtYwgWBl0K4dCgfU7++82q
         p7HA==
X-Forwarded-Encrypted: i=1; AJvYcCVUc7khXLCswFMpZwplz0Ga8gh9RCTOG7fLzDHPmysJ6o0EnRShAIsYaQpUMhykoGWV+KWogqrHHBOvqZTQHms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxREs3BX/LUaYqxqaskUa/N7IFNs+fV3r83LRxvea9Q9LN4rGuh
	Sx1y60vME8ZKDJcfWscj1/Wa0+j9h3wUyMTCfJC4E0yg21FFEoOxRMdu2Tl3xi8=
X-Gm-Gg: ASbGnctGqJx9tEgugBgF1OpU8aM4FlnGvW8uRDnzb20Qb92VDznXuGfOIV8JBnd3iCr
	n1U+P5dgruUSM42T7vs6P0aFZlYJOGud3s0ld/S7oMgYEoU5TYqZlnbx9sj1rYrP3oLu6gk+4EY
	omiGzTEelJCjfAEcIjnvbFKev/eH4DQu9c6AtHNu7+BsiAy3qoCJV335uRFUoDLic1lpNKXkchd
	ABZotYzMQ1ETyihVM9hqsMliIptCbMErcVGwvwYWvG+4/fv1gfCUs69y+3MiZX75DlMgNdE0CT4
	Gl4U5mJTUFFriDyU2KK2UilsdOwh7Ao=
X-Google-Smtp-Source: AGHT+IGhadsK8o0zywnt3E3VuQTTrNcoOsyBwprzXa7M/vo7zyIHtpYN9nvJLck9Wi1ntjXoOtMSKQ==
X-Received: by 2002:a17:902:e547:b0:215:5935:7eef with SMTP id d9443c01a7336-21f4e6b1204mr276368625ad.22.1739212503138;
        Mon, 10 Feb 2025 10:35:03 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650e6b5sm82534815ad.46.2025.02.10.10.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:35:02 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 10 Feb 2025 10:34:42 -0800
Subject: [PATCH v2 1/2] tools: Unify top-level quiet infrastructure
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-quiet_tools-v2-1-b2f18cbf72af@rivosinc.com>
References: <20250210-quiet_tools-v2-0-b2f18cbf72af@rivosinc.com>
In-Reply-To: <20250210-quiet_tools-v2-0-b2f18cbf72af@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4587; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=m6vPvto3/8VAhwSYAOsb0B0lfqjzn/c3aN5DgiXezEc=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/oqt0vxR7caCa0+ZyG9dZKngbLdN+5YvRDHjY1PZjzMm
 /m1dc/pjlIWBjEuBlkxRRaeaw3MrXf0y46Klk2AmcPKBDKEgYtTACaySIvhf9Xljw4mVvlWBVbt
 LR5LFnT/kHJ3/WTcEvg1nEV1bdaJFYwMF3+lXJiW9+7i3rQpEcq7T6yNUPJoX36jOKJlUrlO7Gp
 JFgA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Commit f2868b1a66d4 ("perf tools: Expose quiet/verbose variables in
Makefile.perf") moved the quiet infrastructure out of
tools/build/Makefile.build and into the top-level Makefile.perf file so
that the quiet infrastructure could be used throughout perf and not just
in Makefile.build.

Extract out the quiet infrastructure into Makefile.include so that it
can be leveraged outside of perf.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: f2868b1a66d4 ("perf tools: Expose quiet/verbose variables in Makefile.perf")
---
 tools/build/Makefile           |  8 +-------
 tools/perf/Makefile.perf       | 41 -----------------------------------------
 tools/scripts/Makefile.include | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 31 insertions(+), 49 deletions(-)

diff --git a/tools/build/Makefile b/tools/build/Makefile
index 18ad131f6ea74aebfc3fd6aa6dddfdc00634b66c..63ef2187876169d8daaeed6f7a4ff27e4b610271 100644
--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -17,13 +17,7 @@ $(call allow-override,LD,$(CROSS_COMPILE)ld)
 
 export HOSTCC HOSTLD HOSTAR
 
-ifeq ($(V),1)
-  Q =
-else
-  Q = @
-endif
-
-export Q srctree CC LD
+export srctree CC LD
 
 MAKEFLAGS := --no-print-directory
 build     := -f $(srctree)/tools/build/Makefile.build dir=. obj
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 55d6ce9ea52fb2a57b8632cc6d0ddc501e29cbfc..05c083bb11220486e3246896af4fa0051f048832 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -161,47 +161,6 @@ export VPATH
 SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)
 endif
 
-# Beautify output
-# ---------------------------------------------------------------------------
-#
-# Most of build commands in Kbuild start with "cmd_". You can optionally define
-# "quiet_cmd_*". If defined, the short log is printed. Otherwise, no log from
-# that command is printed by default.
-#
-# e.g.)
-#    quiet_cmd_depmod = DEPMOD  $(MODLIB)
-#          cmd_depmod = $(srctree)/scripts/depmod.sh $(DEPMOD) $(KERNELRELEASE)
-#
-# A simple variant is to prefix commands with $(Q) - that's useful
-# for commands that shall be hidden in non-verbose mode.
-#
-#    $(Q)$(MAKE) $(build)=scripts/basic
-#
-# To put more focus on warnings, be less verbose as default
-# Use 'make V=1' to see the full commands
-
-ifeq ($(V),1)
-  quiet =
-  Q =
-else
-  quiet=quiet_
-  Q=@
-endif
-
-# If the user is running make -s (silent mode), suppress echoing of commands
-# make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
-ifeq ($(filter 3.%,$(MAKE_VERSION)),)
-short-opts := $(firstword -$(MAKEFLAGS))
-else
-short-opts := $(filter-out --%,$(MAKEFLAGS))
-endif
-
-ifneq ($(findstring s,$(short-opts)),)
-  quiet=silent_
-endif
-
-export quiet Q
-
 # Do not use make's built-in rules
 # (this improves performance and avoids hard-to-debug behaviour);
 MAKEFLAGS += -r
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 0aa4005017c72f10bb7c5e47bc78ec81718c47ef..71703a39f8bc29074eb257d5df8e01ff151ba23d 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -136,6 +136,33 @@ else
 NO_SUBDIR = :
 endif
 
+# Beautify output
+# ---------------------------------------------------------------------------
+#
+# Most of build commands in Kbuild start with "cmd_". You can optionally define
+# "quiet_cmd_*". If defined, the short log is printed. Otherwise, no log from
+# that command is printed by default.
+#
+# e.g.)
+#    quiet_cmd_depmod = DEPMOD  $(MODLIB)
+#          cmd_depmod = $(srctree)/scripts/depmod.sh $(DEPMOD) $(KERNELRELEASE)
+#
+# A simple variant is to prefix commands with $(Q) - that's useful
+# for commands that shall be hidden in non-verbose mode.
+#
+#    $(Q)$(MAKE) $(build)=scripts/basic
+#
+# To put more focus on warnings, be less verbose as default
+# Use 'make V=1' to see the full commands
+
+ifeq ($(V),1)
+  quiet =
+  Q =
+else
+  quiet = quiet_
+  Q = @
+endif
+
 # If the user is running make -s (silent mode), suppress echoing of commands
 # make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
 ifeq ($(filter 3.%,$(MAKE_VERSION)),)
@@ -145,9 +172,11 @@ short-opts := $(filter-out --%,$(MAKEFLAGS))
 endif
 
 ifneq ($(findstring s,$(short-opts)),)
-  silent=1
+  quiet=silent_
 endif
 
+export quiet Q
+
 #
 # Define a callable command for descending to a new directory
 #

-- 
2.43.0


