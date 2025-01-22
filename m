Return-Path: <linux-kselftest+bounces-24971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1631A19AAE
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 23:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5B81655C9
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 22:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543821C5F12;
	Wed, 22 Jan 2025 22:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="E5PUMewB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C09C149E17;
	Wed, 22 Jan 2025 22:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737583908; cv=none; b=rFzO/ytbshGqQG9TTy6TC0jgqZaUXiyjeMNvCb1uCxzaobsCZEeriVY0fkC1Zsz6/AuqPZA+7Q5kF7PS5mZcd3i4D89CZDg/fLdiLJFARsXwlu5k0XeJ2ymqOS4sRZUoRCOHt8BT7yvDbKegdcGszaDtE/KUNL5Ym5WP0KOydSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737583908; c=relaxed/simple;
	bh=0mdowEal7Fz+3ZlzxDQ7nzOmg8EJqLlYHS/QtnN4Tdg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lUlWEb2K88WQtEX/mFww9LAVjjZwwd5r2mzyrsr88TemmSQYdAdt9royycoZ7pmBPVaWiP6GaMOt/uJHiY6hYhJeQAXs6Z2fDazNbw0t6e66MQAXhMoYiQCSBmLO22Rotj96ukNrBFO+AUl2UFv/+xCsqnsQgyzqtfOQ1wS9Rik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=E5PUMewB; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MKpccJ014900;
	Wed, 22 Jan 2025 21:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=default; bh=lQ1TufVmvQ4m2aRztYlHsVDg
	nC7YjNb8pNFbhJRB/Ns=; b=E5PUMewBt+cOf4pvG1dPM6J63D+f+m8XmiKRG8vq
	9kw2OhivsfXit/5VvqddokSvBAHCgyvp4MbF2SgdlV+IIsJjQ73yS4vsg04Con4D
	iafWcKPaM7tBBu+FtROwj2V7lBZBQDIphE9m9M8vS3DpujqcaoqSI45L9Whn0WMF
	AjygWxVU/2ph3gI/i08UGm2vVlQuHPq6e0G0VEWxpJFEq0JT8EmNyL9BETeuptYd
	9VwcxkProKBsaC78bA+pKN+UQU/LsK07FKUZ4jFf7mZAREQbWNXaY/axSUrQzt22
	gxvmHYaHz62kh98bmgxNLMBk/zxSlDjuUZuq7J5p6t4EJw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 44b833r547-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 21:52:31 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH007.crowdstrike.sys (10.100.11.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 22 Jan 2025 21:52:26 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
        <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
        <jolsa@kernel.org>, <mykolal@fb.com>, <shuah@kernel.org>,
        <slava.imameev@crowdstrike.com>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <martin.kelly@crowdstrike.com>, <mark.fontana@crowdstrike.com>
Subject: [PATCH 1/2] libbpf: BPF program load type enum
Date: Thu, 23 Jan 2025 08:52:05 +1100
Message-ID: <20250122215206.59859-1-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
X-Proofpoint-ORIG-GUID: pcSDXapAefiJVGddC7iIvvIyNmCFn7mu
X-Proofpoint-GUID: pcSDXapAefiJVGddC7iIvvIyNmCFn7mu
X-Authority-Analysis: v=2.4 cv=RuE/LDmK c=1 sm=1 tr=0 ts=6791689f cx=c_pps a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17 a=EjBHVkixTFsA:10 a=VdSt8ZQiCzkA:10 a=pl6vuDidAAAA:8 a=n6LNyLDMJeuWqLzqYPUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_09,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 clxscore=1011
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220158

Replacing the boolean field with an enum simplifies the addition
of new load types. Currently, the bpf_program structure defines
the autoload type using a boolean field. This field is now
replaced with an enum, allowing new BPF program loading types
to be introduced by extending the enum value range.

This patch is the first in a series of two.

Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c                        | 50 ++++++++++++-------
 tools/lib/bpf/libbpf.h                        | 16 ++++++
 tools/lib/bpf/libbpf.map                      |  2 +
 .../selftests/bpf/prog_tests/load_type.c      | 40 +++++++++++++++
 .../selftests/bpf/progs/test_load_type.c      | 23 +++++++++
 5 files changed, 112 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/load_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_load_type.c

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 194809da5172..9af5c0b08b8b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -473,7 +473,7 @@ struct bpf_program {
 	struct bpf_object *obj;
 
 	int fd;
-	bool autoload;
+	enum bpf_prog_load_type load_type;
 	bool autoattach;
 	bool sym_global;
 	bool mark_btf_static;
@@ -824,11 +824,11 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
 	 * autoload set to false.
 	 */
 	if (sec_name[0] == '?') {
-		prog->autoload = false;
+		prog->load_type = BPF_PROG_LOAD_TYPE_DISABLED;
 		/* from now on forget there was ? in section name */
 		sec_name++;
 	} else {
-		prog->autoload = true;
+		prog->load_type = BPF_PROG_LOAD_TYPE_AUTO;
 	}
 
 	prog->autoattach = true;
@@ -1117,7 +1117,8 @@ static int bpf_object_adjust_struct_ops_autoload(struct bpf_object *obj)
 			}
 		}
 		if (use_cnt)
-			prog->autoload = should_load;
+			prog->load_type = should_load ? BPF_PROG_LOAD_TYPE_AUTO
+				: BPF_PROG_LOAD_TYPE_DISABLED;
 	}
 
 	return 0;
@@ -1202,7 +1203,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 				 * then bpf_object_adjust_struct_ops_autoload() will update its
 				 * autoload accordingly.
 				 */
-				st_ops->progs[i]->autoload = false;
+				st_ops->progs[i]->load_type = BPF_PROG_LOAD_TYPE_DISABLED;
 				st_ops->progs[i] = NULL;
 			}
 
@@ -1241,7 +1242,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 			 * if user replaced it with another program or NULL
 			 */
 			if (st_ops->progs[i] && st_ops->progs[i] != prog)
-				st_ops->progs[i]->autoload = false;
+				st_ops->progs[i]->load_type = BPF_PROG_LOAD_TYPE_DISABLED;
 
 			/* Update the value from the shadow type */
 			st_ops->progs[i] = prog;
@@ -3482,7 +3483,7 @@ static bool obj_needs_vmlinux_btf(const struct bpf_object *obj)
 	}
 
 	bpf_object__for_each_program(prog, obj) {
-		if (!prog->autoload)
+		if (prog->load_type == BPF_PROG_LOAD_TYPE_DISABLED)
 			continue;
 		if (prog_needs_vmlinux_btf(prog))
 			return true;
@@ -5973,7 +5974,7 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 			/* no need to apply CO-RE relocation if the program is
 			 * not going to be loaded
 			 */
-			if (!prog->autoload)
+			if (prog->load_type == BPF_PROG_LOAD_TYPE_DISABLED)
 				continue;
 
 			/* adjust insn_idx from section frame of reference to the local
@@ -7106,7 +7107,7 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 		 */
 		if (prog_is_subprog(obj, prog))
 			continue;
-		if (!prog->autoload)
+		if (prog->load_type == BPF_PROG_LOAD_TYPE_DISABLED)
 			continue;
 
 		err = bpf_object__relocate_calls(obj, prog);
@@ -7142,7 +7143,7 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 		prog = &obj->programs[i];
 		if (prog_is_subprog(obj, prog))
 			continue;
-		if (!prog->autoload)
+		if (prog->load_type == BPF_PROG_LOAD_TYPE_DISABLED)
 			continue;
 
 		/* Process data relos for main programs */
@@ -7906,8 +7907,8 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 		prog = &obj->programs[i];
 		if (prog_is_subprog(obj, prog))
 			continue;
-		if (!prog->autoload) {
-			pr_debug("prog '%s': skipped loading\n", prog->name);
+		if (prog->load_type != BPF_PROG_LOAD_TYPE_AUTO) {
+			pr_debug("prog '%s': skipped auto-loading\n", prog->name);
 			continue;
 		}
 		prog->log_level |= log_level;
@@ -9224,16 +9225,13 @@ const char *bpf_program__section_name(const struct bpf_program *prog)
 
 bool bpf_program__autoload(const struct bpf_program *prog)
 {
-	return prog->autoload;
+	return prog->load_type == BPF_PROG_LOAD_TYPE_AUTO;
 }
 
 int bpf_program__set_autoload(struct bpf_program *prog, bool autoload)
 {
-	if (prog->obj->loaded)
-		return libbpf_err(-EINVAL);
-
-	prog->autoload = autoload;
-	return 0;
+	return bpf_program__set_load_type(prog,
+		autoload ? BPF_PROG_LOAD_TYPE_AUTO : BPF_PROG_LOAD_TYPE_DISABLED);
 }
 
 bool bpf_program__autoattach(const struct bpf_program *prog)
@@ -13983,7 +13981,7 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 		struct bpf_program *prog = *prog_skel->prog;
 		struct bpf_link **link = prog_skel->link;
 
-		if (!prog->autoload || !prog->autoattach)
+		if (prog->load_type != BPF_PROG_LOAD_TYPE_AUTO || !prog->autoattach)
 			continue;
 
 		/* auto-attaching not supported for this program */
@@ -14087,3 +14085,17 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
 	free(s->progs);
 	free(s);
 }
+
+int bpf_program__set_load_type(struct bpf_program *prog, enum bpf_prog_load_type type)
+{
+	if (prog->obj->loaded)
+		return libbpf_err(-EINVAL);
+
+	prog->load_type = type;
+	return 0;
+}
+
+enum bpf_prog_load_type bpf_program__load_type(const struct bpf_program *prog)
+{
+	return prog->load_type;
+}
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 3020ee45303a..21e3d1f51cb3 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1918,6 +1918,22 @@ LIBBPF_API int libbpf_register_prog_handler(const char *sec,
  */
 LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
 
+/**
+ * The program load type:
+ *
+ * - BPF_PROG_LOAD_TYPE_DISABLED: the program is not loaded.
+ * - BPF_PROG_LOAD_TYPE_AUTO: the program is autoloaded when the bpf_object is loaded.
+ */
+enum bpf_prog_load_type {
+	BPF_PROG_LOAD_TYPE_DISABLED = 0,
+	BPF_PROG_LOAD_TYPE_AUTO,
+};
+
+LIBBPF_API int bpf_program__set_load_type(struct bpf_program *prog,
+					    enum bpf_prog_load_type loadtype);
+LIBBPF_API enum bpf_prog_load_type bpf_program__load_type(const struct bpf_program *prog);
+
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index a8b2936a1646..08323e7930fd 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -436,4 +436,6 @@ LIBBPF_1.6.0 {
 		bpf_linker__add_buf;
 		bpf_linker__add_fd;
 		bpf_linker__new_fd;
+		bpf_program__load_type;
+		bpf_program__set_load_type;
 } LIBBPF_1.5.0;
diff --git a/tools/testing/selftests/bpf/prog_tests/load_type.c b/tools/testing/selftests/bpf/prog_tests/load_type.c
new file mode 100644
index 000000000000..7c8d55173b2b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/load_type.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <time.h>
+#include "test_load_type.skel.h"
+
+void test_load_type(void)
+{
+	int duration = 0, err;
+	struct test_load_type *skel;
+
+	skel = test_load_type__open();
+	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
+		goto cleanup;
+
+	/* don't load prog1 */
+	bpf_program__set_load_type(skel->progs.prog1, BPF_PROG_LOAD_TYPE_DISABLED);
+
+	/* load and attach prog2 */
+	bpf_program__set_load_type(skel->progs.prog2, BPF_PROG_LOAD_TYPE_AUTO);
+	CHECK(!bpf_program__autoload(skel->progs.prog2), "prog2", "not autoload?!\n");
+
+	err = test_load_type__load(skel);
+	if (CHECK(err, "skel_load", "failed to load skeleton: %d\n", err))
+		goto cleanup;
+
+	CHECK(!bpf_program__autoattach(skel->progs.prog2), "prog2", "not autoattach?!\n");
+
+	err = test_load_type__attach(skel);
+	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
+		goto cleanup;
+
+	usleep(1);
+
+	CHECK(skel->bss->prog1_called, "prog1", "called?!\n");
+	CHECK(!skel->bss->prog2_called, "prog2", "not called\n");
+
+cleanup:
+	test_load_type__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_load_type.c b/tools/testing/selftests/bpf/progs/test_load_type.c
new file mode 100644
index 000000000000..a0d39757c5b9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_load_type.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+bool prog1_called = false;
+bool prog2_called = false;
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
+char _license[] SEC("license") = "GPL";
-- 
2.39.5 (Apple Git-154)


