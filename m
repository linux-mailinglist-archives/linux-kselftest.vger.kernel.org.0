Return-Path: <linux-kselftest+bounces-18159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD6D97D208
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 09:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5DE28129D
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 07:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E742502B1;
	Fri, 20 Sep 2024 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYYovQTK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B240B4D9FB;
	Fri, 20 Sep 2024 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726818593; cv=none; b=QTgo6sqS2okGIoZ8Y8smliZr87JvyFExgGLuVfZiYdTFnsdzG7pUrzDEgPIs1yWU7NiJzmVm6A3IB3pkzN7UKkBx1FLJkdNZx4kB0eAzsfGimkshMwQe2qkD+FZ0nxcUlR24j6tC1Ttrc0jiocpo1Ol8j81qlX+lrGKp0/UmNzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726818593; c=relaxed/simple;
	bh=KWLDpztzVbYK1KBMhhpMWgMtRWDVoN5Lkrnz32H+YjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LjpTjKFEzVRyz+FbW5BpVtv1MLX3g3HfdzF5ng2jOgNUoSPcpJeIzu2vQQv5MGJDnMvHBVzAOvoqCg5N11g65ccRmLLdUe7YzjG/6IdILckz+hUX6/7Z5KHPCougqmtfFDef3sFpdOhI8KbFxvZ5Ryl91j2Q4mhxlpLpmbIhFsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYYovQTK; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7db908c9c83so822615a12.2;
        Fri, 20 Sep 2024 00:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726818591; x=1727423391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oe+h4uk3Jrp0ffDd+CRexEyHhRh2av2HRgIHFJhluXo=;
        b=MYYovQTKer42fr+Pu+9XSCObD+bmP2Dg+7Z9gou7zLHZcexW0F6IqPBqFcbXL+Ksqk
         9pJIkf4dz2qSGVwz3qu7H9e9dNifDSDNZD94cgUrOLSHcXiyI2cXI+e5oyNFzH234w/+
         gFnsgilx4M5EBiRCkG8cSdL6YPLtELxmnVvObJ4vZC10gYBtLyXSUMYxLNnime28jFka
         7UYfvQC89LIUFjvv2LJB7FnyNvRlmkvM73Sj2nPlp4rbyMYUuSpwMCehxrfXaNgloWRf
         dfPt8cTx6Zb3N/m76YrTEDeF4Jvr95sYjGKnj8aKUJEz+ZVS6CBMFU1ug6qRNReQFDqc
         42mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726818591; x=1727423391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oe+h4uk3Jrp0ffDd+CRexEyHhRh2av2HRgIHFJhluXo=;
        b=Rjinkt8RJVl+kcc8eFqLyjq2CzUEnCdlLLNRsoVAHDPiWCOVLAzMn/JcwaIxmt/Q8N
         ZR+gMY8yK7n4S5Sa5YO5kS2C/Z8M0Sb38flDI7sTWBmtJge9jthM7xKLHMsRt7IG18vI
         7w4cM3pL1Jl5UazZwn1MhNO+U/J/gZQYgtIv0zkvOuC6H1RggY3oO4pBSFPHkt+JIWzU
         OYW0duiGtoRzVFlR+EN3Mc+Dd+2i0Jf1QwJC9uIJUpNe+Fiq5gd/aY7Elul/hyBX5al5
         Ai8jLNPzoa2EFYDJ+LKjVl7GYEFwgvHCvbX9BY656XQy5CYl87CgOE16p/Jigw9gqw+S
         hmBw==
X-Forwarded-Encrypted: i=1; AJvYcCUpVRoEphru+fczBpillwIW34RoALg53/6zBBYTwhJjtlV5bFu5nnmRAm465phkoW0lh+Cp8+xB2PYi3gpEarA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzUruPzyg/OTzIiCCv6zju7sCmiB6f/LafBgztSJgRcmo56bnQ
	Tc37lnpdlMTzEOkwUG3SNrN7ylVyBHBxSXJo1G2xRY+wOYqHbgcQq2PzkA==
X-Google-Smtp-Source: AGHT+IF0wXFZ5zT8dZVr/RFuwJJhx/R9KlLvE34+6aNfluIBlpNgagp69AeFE1t9bUot/HPYG8Tyfg==
X-Received: by 2002:a05:6a21:398c:b0:1cf:9a86:a29b with SMTP id adf61e73a8af0-1d30a9000admr3411896637.20.1726818590593;
        Fri, 20 Sep 2024 00:49:50 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794600fe8sm90481625ad.68.2024.09.20.00.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 00:49:50 -0700 (PDT)
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
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v1 3/3] tools/bpf, selftests/bpf : Sync btf_ids.h to tools
Date: Fri, 20 Sep 2024 00:49:13 -0700
Message-Id: <728fd3a356ae5f9a0c0a84d8b9fc6af1bcd22c1d.1726806756.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1726806756.git.tony.ambardar@gmail.com>
References: <cover.1726806756.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update to include latest changes, including BTF_SET8 support and correct
alignment of .BTF_ids sections, and remove the now-redundant alignment fix
introduced in 3effc06a4dde ("selftests/bpf: Fix alignment of .BTF_ids").

CC: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/include/linux/btf_ids.h                 | 80 +++++++++++++++++--
 .../selftests/bpf/prog_tests/resolve_btfids.c |  6 --
 2 files changed, 74 insertions(+), 12 deletions(-)

diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index 72ea363d434d..3ba37d00e3ae 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -10,6 +10,9 @@ struct btf_id_set {
 	u32 ids[];
 };
 
+/* This flag implies BTF_SET8 holds kfunc(s) */
+#define BTF_SET8_KFUNCS		(1 << 0)
+
 struct btf_id_set8 {
 	u32 cnt;
 	u32 flags;
@@ -21,7 +24,8 @@ struct btf_id_set8 {
 
 #ifdef CONFIG_DEBUG_INFO_BTF
 
-#include <linux/compiler.h> /* for __PASTE */
+#include <linux/compiler.h> /* for __PASTE and __maybe_unused */
+#include <linux/stringify.h>
 
 /*
  * Following macros help to define lists of BTF IDs placed
@@ -35,7 +39,7 @@ struct btf_id_set8 {
 
 #define BTF_IDS_SECTION ".BTF_ids"
 
-#define ____BTF_ID(symbol)				\
+#define ____BTF_ID(symbol, word)			\
 asm(							\
 ".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
 ".local " #symbol " ;                          \n"	\
@@ -43,10 +47,11 @@ asm(							\
 ".size  " #symbol ", 4;                        \n"	\
 #symbol ":                                     \n"	\
 ".zero 4                                       \n"	\
+word							\
 ".popsection;                                  \n");
 
-#define __BTF_ID(symbol) \
-	____BTF_ID(symbol)
+#define __BTF_ID(symbol, word) \
+	____BTF_ID(symbol, word)
 
 #define __ID(prefix) \
 	__PASTE(__PASTE(prefix, __COUNTER__), __LINE__)
@@ -56,7 +61,14 @@ asm(							\
  * to 4 zero bytes.
  */
 #define BTF_ID(prefix, name) \
-	__BTF_ID(__ID(__BTF_ID__##prefix##__##name##__))
+	__BTF_ID(__ID(__BTF_ID__##prefix##__##name##__), "")
+
+#define ____BTF_ID_FLAGS(prefix, name, flags) \
+	__BTF_ID(__ID(__BTF_ID__##prefix##__##name##__), ".long " #flags "\n")
+#define __BTF_ID_FLAGS(prefix, name, flags, ...) \
+	____BTF_ID_FLAGS(prefix, name, flags)
+#define BTF_ID_FLAGS(prefix, name, ...) \
+	__BTF_ID_FLAGS(prefix, name, ##__VA_ARGS__, 0)
 
 /*
  * The BTF_ID_LIST macro defines pure (unsorted) list
@@ -76,6 +88,7 @@ asm(							\
 #define __BTF_ID_LIST(name, scope)			\
 asm(							\
 ".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
+".balign 4, 0;                                 \n"	\
 "." #scope " " #name ";                        \n"	\
 #name ":;                                      \n"	\
 ".popsection;                                  \n");
@@ -155,10 +168,58 @@ asm(							\
 ".popsection;                                 \n");	\
 extern struct btf_id_set name;
 
+/*
+ * The BTF_SET8_START/END macros pair defines sorted list of
+ * BTF IDs and their flags plus its members count, with the
+ * following layout:
+ *
+ * BTF_SET8_START(list)
+ * BTF_ID_FLAGS(type1, name1, flags)
+ * BTF_ID_FLAGS(type2, name2, flags)
+ * BTF_SET8_END(list)
+ *
+ * __BTF_ID__set8__list:
+ * .zero 8
+ * list:
+ * __BTF_ID__type1__name1__3:
+ * .zero 4
+ * .word (1 << 0) | (1 << 2)
+ * __BTF_ID__type2__name2__5:
+ * .zero 4
+ * .word (1 << 3) | (1 << 1) | (1 << 2)
+ *
+ */
+#define __BTF_SET8_START(name, scope, flags)		\
+__BTF_ID_LIST(name, local)				\
+asm(							\
+".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
+"." #scope " __BTF_ID__set8__" #name ";        \n"	\
+"__BTF_ID__set8__" #name ":;                   \n"	\
+".zero 4                                       \n"	\
+".long " __stringify(flags)                   "\n"	\
+".popsection;                                  \n");
+
+#define BTF_SET8_START(name)				\
+__BTF_SET8_START(name, local, 0)
+
+#define BTF_SET8_END(name)				\
+asm(							\
+".pushsection " BTF_IDS_SECTION ",\"a\";      \n"	\
+".size __BTF_ID__set8__" #name ", .-" #name "  \n"	\
+".popsection;                                 \n");	\
+extern struct btf_id_set8 name;
+
+#define BTF_KFUNCS_START(name)				\
+__BTF_SET8_START(name, local, BTF_SET8_KFUNCS)
+
+#define BTF_KFUNCS_END(name)				\
+BTF_SET8_END(name)
+
 #else
 
-#define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
+#define BTF_ID_LIST(name) static u32 __maybe_unused name[64];
 #define BTF_ID(prefix, name)
+#define BTF_ID_FLAGS(prefix, name, ...)
 #define BTF_ID_UNUSED
 #define BTF_ID_LIST_GLOBAL(name, n) u32 __maybe_unused name[n];
 #define BTF_ID_LIST_SINGLE(name, prefix, typename) static u32 __maybe_unused name[1];
@@ -166,6 +227,10 @@ extern struct btf_id_set name;
 #define BTF_SET_START(name) static struct btf_id_set __maybe_unused name = { 0 };
 #define BTF_SET_START_GLOBAL(name) static struct btf_id_set __maybe_unused name = { 0 };
 #define BTF_SET_END(name)
+#define BTF_SET8_START(name) static struct btf_id_set8 __maybe_unused name = { 0 };
+#define BTF_SET8_END(name)
+#define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
+#define BTF_KFUNCS_END(name)
 
 #endif /* CONFIG_DEBUG_INFO_BTF */
 
@@ -215,5 +280,8 @@ MAX_BTF_TRACING_TYPE,
 };
 
 extern u32 btf_tracing_ids[];
+extern u32 bpf_cgroup_btf_id[];
+extern u32 bpf_local_storage_map_btf_id[];
+extern u32 btf_bpf_map_id[];
 
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
index 51544372f52e..c3c021e3783e 100644
--- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
+++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
@@ -28,12 +28,6 @@ struct symbol test_symbols[] = {
 	{ "func",    BTF_KIND_FUNC,    -1 },
 };
 
-/* Align the .BTF_ids section to 4 bytes */
-asm (
-".pushsection " BTF_IDS_SECTION " ,\"a\"; \n"
-".balign 4, 0;                            \n"
-".popsection;                             \n");
-
 BTF_ID_LIST(test_list_local)
 BTF_ID_UNUSED
 BTF_ID(typedef, S)
-- 
2.34.1


