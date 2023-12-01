Return-Path: <linux-kselftest+bounces-980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62647801456
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 21:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847351C20A1B
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 20:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66543584DE;
	Fri,  1 Dec 2023 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="YNgx8Hvm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="spe0L5Kb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA4610E5;
	Fri,  1 Dec 2023 12:24:00 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailnew.nyi.internal (Postfix) with ESMTP id B5EC6580992;
	Fri,  1 Dec 2023 15:23:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 01 Dec 2023 15:23:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1701462239; x=
	1701469439; bh=D8noEFBJZ4ewr1BGMuw+TiQmHop9t4Qe8cy7C7t2YkI=; b=Y
	Ngx8HvmT5P6l9C65V3JzMgc5wRfw6QvgfzXbCJVKZFC/XVm9fVzDErtiXdaKdpAN
	6ZGMuMiz0OIoLZX7JVUZN9RheTS9OU0SjbJalCUp5bKiRlOtXUheRTrX5U6P/97z
	tMuLHD2bURLvEepZTPTTBofCnSXeZZYdvHMLSdbMFzwWw3urTO8Xj3V7BtJYBR2+
	GP5qXVpCY9gNn0TUgurzLNIeq1lPjngGUzYAymEJhLUYNXvGQDHX1QI3fpDITl+A
	rAKuAwo/KBUBZA8qY6GcIsf0rWnmj9N+rWMyOglogENQMXTRVd7o3WvCEpZxtTLj
	Mg6TPN5s9HOjvv42raBQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701462239; x=
	1701469439; bh=D8noEFBJZ4ewr1BGMuw+TiQmHop9t4Qe8cy7C7t2YkI=; b=s
	pe0L5Kb5EQesoz68YAYAKkIwIFOkUWSup0tY/AqFhM1Ww/KSh2vl6GmVSCe7gkgC
	j2324KysdrsZG2dpsd/mceN3vE9pHo83+0P/uQrocipH/ZuL2cQyfB2PmSkEQpPw
	m9qh7jVTywfTEY0lBlzEPodBO8gCMQr+eF1eO0LuHRbc1fpPk1gNRsef5qzqiScX
	QJfTVaBep1ccgsfoufABgQCrobhMxI9mwE0SYOBsQCg4rQrjArtpLP2eODhhdAk5
	ddm24JhWu0LZOF07gOcSaD3trVjp6WSRK7NSzV4t6eTb9HMR2T+hydAPghjMqDNc
	nQ0Zj5qvnf3/NLAEcLc5g==
X-ME-Sender: <xms:30BqZe6n7pj0r_5hgF2ecq-PbFd8YQ-8omTCQzZ616ijtdTm4v15IQ>
    <xme:30BqZX5w2wNe_ijIdX2xk6p1BYMXliVcsw2ca9-nat6-LBO3uH44bVtlUgz5vAimw
    -eMyLWKlvXoQkGZQA>
X-ME-Received: <xmr:30BqZddxCLuBHOXyrBBEpquatSLwwidEIqyNWvDUoT9OvSVlsKgLpoSA1xWLjvSEfxIWL90XOsPvxqhGSa3s0C_KW86uWJzPq-TWGBKJRikjBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:30BqZbIO9-HKNCXcKMUNx5WuodFRkNxldFh3e_nLiiFM09a-dcoXlw>
    <xmx:30BqZSLywFEY-q59dbzjkVo4Vty77qP4YmJvNUHwTAORZdZLMnc7lw>
    <xmx:30BqZcxA8FxQB1Symv8ee7MCrv_W9ef9VwQ9uU3cTCAO7efCJ-UK0Q>
    <xmx:30BqZSJI3ry_1IS2IsbJhXV3bSec5iu9ItsbDGu9HISE6ptILlKMnQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 15:23:58 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	daniel@iogearbox.net,
	shuah@kernel.org,
	andrii@kernel.org,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Cc: mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devel@linux-ipsec.org,
	netdev@vger.kernel.org
Subject: [PATCH ipsec-next v3 4/9] bpf: selftests: test_loader: Support __btf_path() annotation
Date: Fri,  1 Dec 2023 13:23:15 -0700
Message-ID: <68419933c552bd30e92d432e287ce91deb3ed52e.1701462010.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701462010.git.dxu@dxuuu.xyz>
References: <cover.1701462010.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds support for per-prog btf_custom_path. This is necessary
for testing CO-RE relocations on non-vmlinux types using test_loader
infrastructure.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 1 +
 tools/testing/selftests/bpf/test_loader.c    | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 799fff4995d8..2fd59970c43a 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -71,6 +71,7 @@
 #define __retval_unpriv(val)	__attribute__((btf_decl_tag("comment:test_retval_unpriv="#val)))
 #define __auxiliary		__attribute__((btf_decl_tag("comment:test_auxiliary")))
 #define __auxiliary_unpriv	__attribute__((btf_decl_tag("comment:test_auxiliary_unpriv")))
+#define __btf_path(path)	__attribute__((btf_decl_tag("comment:test_btf_path=" path)))
 
 /* Convenience macro for use with 'asm volatile' blocks */
 #define __naked __attribute__((naked))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index a350ecdfba4a..74ceb7877ae2 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -27,6 +27,7 @@
 #define TEST_TAG_RETVAL_PFX_UNPRIV "comment:test_retval_unpriv="
 #define TEST_TAG_AUXILIARY "comment:test_auxiliary"
 #define TEST_TAG_AUXILIARY_UNPRIV "comment:test_auxiliary_unpriv"
+#define TEST_BTF_PATH "comment:test_btf_path="
 
 /* Warning: duplicated in bpf_misc.h */
 #define POINTER_VALUE	0xcafe4all
@@ -58,6 +59,7 @@ struct test_spec {
 	const char *prog_name;
 	struct test_subspec priv;
 	struct test_subspec unpriv;
+	const char *btf_custom_path;
 	int log_level;
 	int prog_flags;
 	int mode_mask;
@@ -288,6 +290,8 @@ static int parse_test_spec(struct test_loader *tester,
 					goto cleanup;
 				update_flags(&spec->prog_flags, flags, clear);
 			}
+		} else if (str_has_pfx(s, TEST_BTF_PATH)) {
+			spec->btf_custom_path = s + sizeof(TEST_BTF_PATH) - 1;
 		}
 	}
 
@@ -578,6 +582,9 @@ void run_subtest(struct test_loader *tester,
 		}
 	}
 
+	/* Implicitly reset to NULL if next test case doesn't specify */
+	open_opts->btf_custom_path = spec->btf_custom_path;
+
 	tobj = bpf_object__open_mem(obj_bytes, obj_byte_cnt, open_opts);
 	if (!ASSERT_OK_PTR(tobj, "obj_open_mem")) /* shouldn't happen */
 		goto subtest_cleanup;
-- 
2.42.1


