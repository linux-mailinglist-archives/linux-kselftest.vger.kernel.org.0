Return-Path: <linux-kselftest+bounces-24972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA75A19AB4
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 23:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DCCF7A4692
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 22:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E481C68B6;
	Wed, 22 Jan 2025 22:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="q+HB5p1z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB9B1C4A0E;
	Wed, 22 Jan 2025 22:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737584030; cv=none; b=mFkrVboXB3RSYFeSjRY1PMjN4CD7wS7N2dl+QCHokGsehlNMKsdR8SvSrLTp3QUCtBI9rLAj8K1XSeEpTHixpOn88C1bblkcg15L221lAH82xSGcFupcMgaQy2olN/SDddUQBW0IVwPeR7nwosRHLzqyd6h6MRKpglk69PqrI2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737584030; c=relaxed/simple;
	bh=tSHLFp4nA+ODjO/AwFDSjH9fIsXaycd2i/4P7Jh3bHU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkZQhzZP0xktnX/jqQ6s5y4Toxh6HDnNPpt1cX3QP4UZxdQrkjyeVTgKTDsGf05lN4QXvp9KNmkKNgfiSCZ9kX5L6V9F/BIzLiDuwHWhkdpcqOB1mYhxiEDI2zAquyW1fegHPFYxx5b802qvuSIZxENU1D48ovVjoIj+3SsxlN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=q+HB5p1z; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ML2ZgB005646;
	Wed, 22 Jan 2025 21:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=default; bh=hr
	y+jnYwS98pUVZ+p9wNYSFd2o9PjxLvATANi8mXWXY=; b=q+HB5p1zrBt+foJYEi
	oCfYju0vzb6+3WBrSNdyDrASwlXNaTn/Yb/Ags6UGgzeRkLBE6VsYdrTpz6RpsYW
	/f2+dPcU0sKRwtdtb2Uog+tJzbTfDl4wFQLRbRcC+LoMIumfHQD/68Xv7aThBIu6
	ho53+7P62Np+7CkL5Fx6Fi/3HmqN+4yuqopH30ts453koI46CtVGULcvvq2sAbtQ
	HEi23M1RYi5Qbildrzha4hrEo29ai8Wmj1lmbsPliGUgTP3Aaj2barMZJlcVcwCW
	I1ZVu1rc2UelC50kp21CfR7juRx7Mwn4XVj5sBKhczbtzt/xtxLJbVJmcAc9J96c
	WoFw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 44b889g49r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 21:52:39 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH007.crowdstrike.sys (10.100.11.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 22 Jan 2025 21:52:34 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
        <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
        <jolsa@kernel.org>, <mykolal@fb.com>, <shuah@kernel.org>,
        <slava.imameev@crowdstrike.com>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <martin.kelly@crowdstrike.com>, <mark.fontana@crowdstrike.com>
Subject: [PATCH 2/2] libbpf: BPF programs dynamic loading and attaching
Date: Thu, 23 Jan 2025 08:52:06 +1100
Message-ID: <20250122215206.59859-2-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250122215206.59859-1-slava.imameev@crowdstrike.com>
References: <20250122215206.59859-1-slava.imameev@crowdstrike.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH010.crowdstrike.sys (10.100.11.80) To
 04WPEXCH007.crowdstrike.sys (10.100.11.74)
X-Disclaimer: USA
X-Proofpoint-ORIG-GUID: 6NIhaAa1sNEylgDgwgpxSBlpzoHBXzMQ
X-Authority-Analysis: v=2.4 cv=HpOMG1TS c=1 sm=1 tr=0 ts=679168a7 cx=c_pps a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17 a=EjBHVkixTFsA:10 a=VdSt8ZQiCzkA:10 a=pl6vuDidAAAA:8 a=xXNyRu6nBHi_Q7GlAEgA:9
X-Proofpoint-GUID: 6NIhaAa1sNEylgDgwgpxSBlpzoHBXzMQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_09,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 adultscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501220158

BPF programs designated as dynamically loaded can be loaded and
attached independently after the initial bpf_object loading and
attaching.

These programs can also be reloaded and reattached multiple times,
enabling more flexible management of a resident BPF program set.

A key motivation for this feature is to reduce load times for
utilities that include hundreds of BPF programs. When the selection
of a resident BPF program set cannot be determined at the time of
bpf_object loading and attaching, all BPF programs would otherwise
need to be marked as autoload, leading to unnecessary overhead.
This patch addresses that inefficiency.

Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c                        | 144 +++++++++++++++--
 tools/lib/bpf/libbpf.h                        |   5 +-
 tools/lib/bpf/libbpf.map                      |   2 +
 .../selftests/bpf/prog_tests/dynamicload.c    | 145 ++++++++++++++++++
 .../selftests/bpf/prog_tests/load_type.c      |  61 ++++++++
 .../selftests/bpf/progs/test_dynamicload.c    |  31 ++++
 .../selftests/bpf/progs/test_load_type.c      |   8 +
 7 files changed, 385 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dynamicload.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_dynamicload.c

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9af5c0b08b8b..731a4a09f865 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -689,6 +689,7 @@ struct bpf_object {
 	bool loaded;
 	bool has_subcalls;
 	bool has_rodata;
+	bool has_dynload_progs;
 
 	struct bpf_gen *gen_loader;
 
@@ -7551,13 +7552,15 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	 * custom log_buf is specified; if the program load fails, then we'll
 	 * bump log_level to 1 and use either custom log_buf or we'll allocate
 	 * our own and retry the load to get details on what failed
+	 * A shared buffer cannot be used for dynamically loaded programs as they
+	 * can be loaded concurrently.
 	 */
 	if (log_level) {
 		if (prog->log_buf) {
 			log_buf = prog->log_buf;
 			log_buf_size = prog->log_size;
 			own_log_buf = false;
-		} else if (obj->log_buf) {
+		} else if (obj->log_buf && prog->load_type != BPF_PROG_LOAD_TYPE_DYNAMIC) {
 			log_buf = obj->log_buf;
 			log_buf_size = obj->log_size;
 			own_log_buf = false;
@@ -7911,6 +7914,7 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 			pr_debug("prog '%s': skipped auto-loading\n", prog->name);
 			continue;
 		}
+
 		prog->log_level |= log_level;
 
 		if (obj->gen_loader)
@@ -8588,8 +8592,11 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 			err = bpf_gen__finish(obj->gen_loader, obj->nr_programs, obj->nr_maps);
 	}
 
-	/* clean up fd_array */
-	zfree(&obj->fd_array);
+	/* The fd array is needed for dynamically loaded programs,
+	 * so defer freeing it in that case to the end of the object lifetime.
+	 */
+	if (!obj->has_dynload_progs || !obj->fd_array_cnt)
+		zfree(&obj->fd_array);
 
 	/* clean up module BTFs */
 	for (i = 0; i < obj->btf_module_cnt; i++) {
@@ -8597,11 +8604,17 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 		btf__free(obj->btf_modules[i].btf);
 		free(obj->btf_modules[i].name);
 	}
-	free(obj->btf_modules);
+	obj->btf_module_cnt = 0;
+	zfree(&obj->btf_modules);
 
-	/* clean up vmlinux BTF */
-	btf__free(obj->btf_vmlinux);
-	obj->btf_vmlinux = NULL;
+	/* The btf_vmlinux data is needed for dynamically loaded programs,
+	 * so defer freeing it in that case to the end of the object lifetime.
+	 */
+	if (!obj->has_dynload_progs) {
+		/* clean up vmlinux BTF */
+		btf__free(obj->btf_vmlinux);
+		obj->btf_vmlinux = NULL;
+	}
 
 	obj->loaded = true; /* doesn't matter if successfully or not */
 
@@ -9103,6 +9116,8 @@ void bpf_object__close(struct bpf_object *obj)
 
 	zfree(&obj->arena_data);
 
+	zfree(&obj->fd_array);
+
 	free(obj);
 }
 
@@ -9230,8 +9245,16 @@ bool bpf_program__autoload(const struct bpf_program *prog)
 
 int bpf_program__set_autoload(struct bpf_program *prog, bool autoload)
 {
-	return bpf_program__set_load_type(prog,
-		autoload ? BPF_PROG_LOAD_TYPE_AUTO : BPF_PROG_LOAD_TYPE_DISABLED);
+	enum bpf_prog_load_type type = prog->load_type;
+
+	if (autoload)
+		type = BPF_PROG_LOAD_TYPE_AUTO;
+	else if (prog->load_type == BPF_PROG_LOAD_TYPE_AUTO)
+		type = BPF_PROG_LOAD_TYPE_DISABLED;
+	else
+		return 0; /* Otherwise, keep the current load type. */
+
+	return bpf_program__set_load_type(prog, type);
 }
 
 bool bpf_program__autoattach(const struct bpf_program *prog)
@@ -14086,12 +14109,67 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
 	free(s);
 }
 
+static int bpf_program__set_dynamicload(struct bpf_program *prog)
+{
+	struct bpf_object *obj;
+	const char *attach_name;
+
+	obj = prog->obj;
+	if (!obj)
+		return libbpf_err(-EINVAL);
+
+	/* Dynamically loaded programs are not supported for gen_loader.
+	 * This limitation exists because bpf_object_load_prog is not invoked
+	 * for dynamically loaded programs, making them invisible to gen_loader.
+	 * To ensure compatibility, bpf_program__set_dynamicload should not be
+	 * called when gen_loader is used to generate a BPF object loader.
+	 * The gen_loader implementation handles autoloaded programs and follows
+	 * its own model for loading BPF programs. To pass a BPF program to
+	 * gen_loader, set the program's load type to BPF_PROG_LOAD_TYPE_AUTO.
+	 */
+	if (obj->gen_loader)
+		return libbpf_err(-ENOTSUP);
+
+	if (prog_is_subprog(obj, prog))
+		return libbpf_err(-EINVAL);
+
+	attach_name = strchr(prog->sec_name, '/');
+	if (!attach_name || strchr(attach_name, ':')) {
+		/* Dynamic loading is not supported if module's BTF
+		 * data is required for a bpf program.
+		 * The module's BTF data is required in the folowing cases:
+		 * - If a BPF program is annotated with just SEC("fentry")
+		 * (or similar) without declaratively specifying
+		 * target, then it is expected that target will be
+		 * specified with bpf_program__set_attach_target() at
+		 * runtime before BPF object load step. The module's
+		 * BTF data will be required by libbpf_prepare_prog_load and
+		 * libbpf_find_attach_btf_id.
+		 * - The attach name is prepended with a module name.
+		 */
+		return libbpf_err(-EINVAL);
+	}
+
+	obj->has_dynload_progs = true;
+	prog->load_type = BPF_PROG_LOAD_TYPE_DYNAMIC;
+	prog->autoattach = false;
+
+	return 0;
+}
+
 int bpf_program__set_load_type(struct bpf_program *prog, enum bpf_prog_load_type type)
 {
 	if (prog->obj->loaded)
 		return libbpf_err(-EINVAL);
 
-	prog->load_type = type;
+	switch (type) {
+	case BPF_PROG_LOAD_TYPE_DYNAMIC:
+		return bpf_program__set_dynamicload(prog);
+	default:
+		prog->load_type = type;
+		break;
+	}
+
 	return 0;
 }
 
@@ -14099,3 +14177,49 @@ enum bpf_prog_load_type bpf_program__load_type(const struct bpf_program *prog)
 {
 	return prog->load_type;
 }
+
+/*
+ * This function must be called after bpf_object__load_progs.
+ * Dynamically-loaded program data is initialized on object load.
+ * Post-load initialization is not supported.
+ */
+int
+bpf_program__load_dynamically(struct bpf_program *prog, int extra_log_level)
+{
+	int err;
+	struct bpf_object *obj;
+
+	obj = prog->obj;
+	if (!obj || !obj->loaded)
+		return libbpf_err(-EINVAL);
+
+	if (prog_is_subprog(obj, prog) || prog->load_type != BPF_PROG_LOAD_TYPE_DYNAMIC)
+		return libbpf_err(-EINVAL);
+
+	prog->log_level |= extra_log_level;
+
+	err = bpf_object_load_prog(obj, prog, prog->insns, prog->insns_cnt,
+					obj->license, obj->kern_version, &prog->fd);
+	if (err) {
+		pr_warn("prog '%s': failed to dynamically load: %d\n", prog->name, err);
+		prog->log_level &= ~extra_log_level;
+		return err;
+	}
+
+	prog->log_level &= ~extra_log_level;
+	return 0;
+}
+
+int bpf_program__unload_dynamically(struct bpf_program *prog)
+{
+	int err;
+
+	if (!prog || prog->load_type != BPF_PROG_LOAD_TYPE_DYNAMIC)
+		return libbpf_err(-EINVAL);
+
+	/* Close the file descriptor but retain the program's data to
+	 * support reloading the program if it is required again.
+	 */
+	err = zclose(prog->fd);
+	return err ? libbpf_err(-errno) : 0;
+}
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 21e3d1f51cb3..531f30491f0b 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1923,16 +1923,19 @@ LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
  *
  * - BPF_PROG_LOAD_TYPE_DISABLED: the program is not loaded.
  * - BPF_PROG_LOAD_TYPE_AUTO: the program is autoloaded when the bpf_object is loaded.
+ * - BPF_PROG_LOAD_TYPE_DYNAMIC: the program is loaded and attached dynamically.
  */
 enum bpf_prog_load_type {
 	BPF_PROG_LOAD_TYPE_DISABLED = 0,
 	BPF_PROG_LOAD_TYPE_AUTO,
+	BPF_PROG_LOAD_TYPE_DYNAMIC,
 };
 
 LIBBPF_API int bpf_program__set_load_type(struct bpf_program *prog,
 					    enum bpf_prog_load_type loadtype);
 LIBBPF_API enum bpf_prog_load_type bpf_program__load_type(const struct bpf_program *prog);
-
+LIBBPF_API int bpf_program__load_dynamically(struct bpf_program *prog, int extra_log_level);
+LIBBPF_API int bpf_program__unload_dynamically(struct bpf_program *prog);
 
 #ifdef __cplusplus
 } /* extern "C" */
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 08323e7930fd..4d84e4794685 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -438,4 +438,6 @@ LIBBPF_1.6.0 {
 		bpf_linker__new_fd;
 		bpf_program__load_type;
 		bpf_program__set_load_type;
+		bpf_program__load_dynamically;
+		bpf_program__unload_dynamically;
 } LIBBPF_1.5.0;
diff --git a/tools/testing/selftests/bpf/prog_tests/dynamicload.c b/tools/testing/selftests/bpf/prog_tests/dynamicload.c
new file mode 100644
index 000000000000..9cde7dd45608
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/dynamicload.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <time.h>
+#include "test_dynamicload.skel.h"
+
+void test_dynamicload(void)
+{
+	int duration = 0, err;
+	struct bpf_link *link;
+	struct test_dynamicload *skel;
+
+	skel = test_dynamicload__open();
+	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
+		goto cleanup;
+
+	/* don't load prog1 */
+	bpf_program__set_load_type(skel->progs.prog1, BPF_PROG_LOAD_TYPE_DISABLED);
+
+	/* prog2 is autoload */
+	bpf_program__set_load_type(skel->progs.prog2, BPF_PROG_LOAD_TYPE_AUTO);
+
+	/* prog3 is dynamically loaded */
+	bpf_program__set_load_type(skel->progs.prog3, BPF_PROG_LOAD_TYPE_DYNAMIC);
+
+	err = test_dynamicload__load(skel);
+	if (CHECK(err, "skel_load", "failed to load skeleton: %d\n", err))
+		goto cleanup;
+
+	err = test_dynamicload__attach(skel);
+	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
+		goto cleanup;
+
+	/* trigger the BPF programs */
+	usleep(1);
+
+	CHECK(skel->bss->prog1_called, "prog1", "called?!\n");
+	CHECK(!skel->bss->prog2_called, "prog2", "not called\n");
+	CHECK(skel->bss->prog3_called, "prog3", "called?!\n");
+
+	/* prog1 is disabled for load */
+	err = bpf_program__load_dynamically(skel->progs.prog1, 0);
+	if (CHECK(!err, "load_dynamically", "disabled program loaded?!\n"))
+		goto cleanup;
+
+	/* prog1 is disabled for load */
+	err = bpf_program__unload_dynamically(skel->progs.prog1);
+	if (CHECK(!err, "load_dynamically", "disabled program unloaded?!\n"))
+		goto cleanup;
+
+	/* prog2 is autoload */
+	err = bpf_program__load_dynamically(skel->progs.prog1, 0);
+	if (CHECK(!err, "load_dynamically", "autoload loaded dynamically?!\n"))
+		goto cleanup;
+
+	/* prog2 is autoload */
+	err = bpf_program__unload_dynamically(skel->progs.prog1);
+	if (CHECK(!err, "load_dynamically", "autoload unloaded dynamically?!\n"))
+		goto cleanup;
+
+	/* reset the call flags */
+	skel->bss->prog2_called = false;
+	skel->bss->prog3_called = false;
+
+	usleep(1);
+
+	CHECK(skel->bss->prog1_called, "prog1", "called?!\n");
+	CHECK(!skel->bss->prog2_called, "prog2", "not called\n");
+	CHECK(skel->bss->prog3_called, "prog3", "called?!\n");
+
+	/* load prog3 */
+	err = bpf_program__load_dynamically(skel->progs.prog3, 0);
+	if (CHECK(err, "load_dynamically", "dynamic loading failed: %d\n", err))
+		goto cleanup;
+
+	/* attach prog3 */
+	link = bpf_program__attach(skel->progs.prog3);
+	if (CHECK(libbpf_get_error(link), "attach", "attaching failed: %ld\n",
+		  libbpf_get_error(link)))
+		goto cleanup;
+
+	usleep(1);
+
+	CHECK(!skel->bss->prog3_called, "prog3", "not called\n");
+
+	/* detach prog3 as test_dynamicload__destroy doesn't detach dynamically loaded programs */
+	err = bpf_link__destroy(link);
+	if (CHECK(err, "link__destroy", "link destroy failed: %d\n", err))
+		goto cleanup;
+
+	/* reset the call flags after detach */
+	skel->bss->prog2_called = false;
+	skel->bss->prog3_called = false;
+
+	usleep(1);
+
+	CHECK(!skel->bss->prog2_called, "prog2", "not called\n");
+	CHECK(skel->bss->prog3_called, "prog3", "called?!\n");
+
+	/* unload prog3 */
+	err = bpf_program__unload_dynamically(skel->progs.prog3);
+	if (CHECK(err, "unload_dynamically", "unload dynamically failed: %d\n", err))
+		goto cleanup;
+
+	/* reload prog3 */
+	err = bpf_program__load_dynamically(skel->progs.prog3, 0);
+	if (CHECK(err, "load_dynamically", "dynamic reloading failed: %d\n", err))
+		goto cleanup;
+
+	/* reattach prog3 */
+	link = bpf_program__attach(skel->progs.prog3);
+	if (CHECK(libbpf_get_error(link), "attach", "reattaching failed: %d\n", err))
+		goto cleanup;
+
+	usleep(1);
+
+	CHECK(!skel->bss->prog3_called, "prog3", "not called\n");
+
+	/* detach prog3 as test_dynamicload__destroy doesn't detach dynamically loaded programs */
+	err = bpf_link__destroy(link);
+	if (CHECK(err, "link__destroy", "link destroy failed: %d\n", err))
+		goto cleanup;
+
+	/* verify regular unload for dynamically loaded program,
+	 * unload prog3 as a regular program
+	 */
+	bpf_program__unload(skel->progs.prog3);
+
+	/* reset the call flags after unload */
+	skel->bss->prog2_called = false;
+	skel->bss->prog3_called = false;
+
+	usleep(1);
+
+	CHECK(!skel->bss->prog2_called, "prog2", "not called\n");
+	CHECK(skel->bss->prog3_called, "prog3", "called?!\n");
+
+	/* reloading prog3 must fail as it was unloaded as a regular program */
+	err = bpf_program__load_dynamically(skel->progs.prog3, 0);
+	if (CHECK(!err, "load_dynamically", "dynamic reloading succeeded?! %d\n", err))
+		goto cleanup;
+
+cleanup:
+	test_dynamicload__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/load_type.c b/tools/testing/selftests/bpf/prog_tests/load_type.c
index 7c8d55173b2b..8bd082b3bc9d 100644
--- a/tools/testing/selftests/bpf/prog_tests/load_type.c
+++ b/tools/testing/selftests/bpf/prog_tests/load_type.c
@@ -7,6 +7,7 @@
 void test_load_type(void)
 {
 	int duration = 0, err;
+	struct bpf_link *link;
 	struct test_load_type *skel;
 
 	skel = test_load_type__open();
@@ -20,11 +21,47 @@ void test_load_type(void)
 	bpf_program__set_load_type(skel->progs.prog2, BPF_PROG_LOAD_TYPE_AUTO);
 	CHECK(!bpf_program__autoload(skel->progs.prog2), "prog2", "not autoload?!\n");
 
+	err = bpf_program__set_load_type(skel->progs.prog3, BPF_PROG_LOAD_TYPE_DYNAMIC);
+	if (CHECK(err, "set_load_type", "set_load_type(DYNAMIC) failed: %d\n", err))
+		goto cleanup;
+	CHECK(bpf_program__load_type(skel->progs.prog3) != BPF_PROG_LOAD_TYPE_DYNAMIC,
+		"prog3", "didn't set type?!\n");
+
+	/* bpf_program__set_autoload(program, false) doesn't have effect if the program
+	 * type is not BPF_PROG_LOAD_TYPE_AUTO
+	 */
+	err = bpf_program__set_autoload(skel->progs.prog3, false);
+	if (CHECK(err, "set_autoload", "set_autoload(false) failed: %d\n", err))
+		goto cleanup;
+
+	CHECK(bpf_program__load_type(skel->progs.prog3) != BPF_PROG_LOAD_TYPE_DYNAMIC,
+		"prog3", "changed type?!\n");
+
+	err = bpf_program__set_autoload(skel->progs.prog3, true);
+	if (CHECK(err, "set_autoload", "set_autoload(true) failed: %d\n", err))
+		goto cleanup;
+
+	CHECK(bpf_program__load_type(skel->progs.prog3) != BPF_PROG_LOAD_TYPE_AUTO,
+		"prog3", "didn't change type to auto?!\n");
+
+	/* change the type back to BPF_PROG_LOAD_TYPE_DYNAMIC */
+	err = bpf_program__set_load_type(skel->progs.prog3, BPF_PROG_LOAD_TYPE_DYNAMIC);
+	if (CHECK(err, "set_load_type", "changing from AUTO to DYNAMIC failed: %d\n", err))
+		goto cleanup;
+
+	CHECK(bpf_program__load_type(skel->progs.prog3) != BPF_PROG_LOAD_TYPE_DYNAMIC,
+		"prog3", "didn't change type from autoload to dynamic?!\n");
+
 	err = test_load_type__load(skel);
 	if (CHECK(err, "skel_load", "failed to load skeleton: %d\n", err))
 		goto cleanup;
 
 	CHECK(!bpf_program__autoattach(skel->progs.prog2), "prog2", "not autoattach?!\n");
+	CHECK(bpf_program__autoattach(skel->progs.prog3), "prog3", "autoattach?!\n");
+
+	/* loaded program type cannot be changed */
+	err = bpf_program__set_load_type(skel->progs.prog3, BPF_PROG_LOAD_TYPE_DISABLED);
+	CHECK(!err, "prog3", "changed type after load?!\n");
 
 	err = test_load_type__attach(skel);
 	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
@@ -34,6 +71,30 @@ void test_load_type(void)
 
 	CHECK(skel->bss->prog1_called, "prog1", "called?!\n");
 	CHECK(!skel->bss->prog2_called, "prog2", "not called\n");
+	CHECK(skel->bss->prog3_called, "prog3", "called?!\n");
+
+	err = bpf_program__load_dynamically(skel->progs.prog3, 0);
+	if (CHECK(err, "load_dynamically", "load dynamically failed: %d\n", err))
+		goto cleanup;
+
+	err = bpf_program__load_dynamically(skel->progs.prog3, 0);
+	if (CHECK(err, "load_dynamically", "load dynamically failed: %d\n", err))
+		goto cleanup;
+
+	/* attach prog3 */
+	link = bpf_program__attach(skel->progs.prog3);
+	if (CHECK(libbpf_get_error(link), "attach", "attaching failed: %ld\n",
+		  libbpf_get_error(link)))
+		goto cleanup;
+
+	usleep(1);
+
+	CHECK(!skel->bss->prog3_called, "prog3", "not called?!\n");
+
+	/* detach prog3 as test_load_type__destroy doesn't detach dynamically loaded programs */
+	err = bpf_link__destroy(link);
+	if (CHECK(err, "link__destroy", "link destroy failed: %d\n", err))
+		goto cleanup;
 
 cleanup:
 	test_load_type__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/test_dynamicload.c b/tools/testing/selftests/bpf/progs/test_dynamicload.c
new file mode 100644
index 000000000000..3d9b81691d7a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_dynamicload.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+bool prog1_called = false;
+bool prog2_called = false;
+bool prog3_called = false;
+
+SEC("raw_tp/sys_enter")
+int prog1(const void *ctx)
+{
+	prog1_called = true;
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+int prog2(const void *ctx)
+{
+	prog2_called = true;
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+int prog3(const void *ctx)
+{
+	prog3_called = true;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_load_type.c b/tools/testing/selftests/bpf/progs/test_load_type.c
index a0d39757c5b9..3d9b81691d7a 100644
--- a/tools/testing/selftests/bpf/progs/test_load_type.c
+++ b/tools/testing/selftests/bpf/progs/test_load_type.c
@@ -5,6 +5,7 @@
 
 bool prog1_called = false;
 bool prog2_called = false;
+bool prog3_called = false;
 
 SEC("raw_tp/sys_enter")
 int prog1(const void *ctx)
@@ -20,4 +21,11 @@ int prog2(const void *ctx)
 	return 0;
 }
 
+SEC("raw_tp/sys_enter")
+int prog3(const void *ctx)
+{
+	prog3_called = true;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.39.5 (Apple Git-154)


