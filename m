Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BA56EC1AA
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Apr 2023 20:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjDWSzW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Apr 2023 14:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDWSzV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Apr 2023 14:55:21 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9412E10D4;
        Sun, 23 Apr 2023 11:55:19 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2a8bca69e8bso33848521fa.3;
        Sun, 23 Apr 2023 11:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682276118; x=1684868118;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jQg8fQpPXaUKtSBTIp1XY4SP+/G7plSzsEOw8t/yqpk=;
        b=ZwZNj/SXflrvOEiNCwp8MBBm/A7NOAjZ7JNBVa/nKDE2zOw8VFnmquQPCtyE2H/5Yt
         EwLyOmwrSrF7RZNGH2Ve7xnczKP+7XTpoLUpljb8+2seZtFMwUkMkqah9cy0Ecp2pxQm
         p8ryfjTh9DuRFw5GgoG+ln6HLOIuKfrncHrqlj4oP6YnhrR4aTUSuGckEMIJmcKH94xy
         nRplnAuInDUyli0nYGMQQbUWwJNBEhP6g668sQdzJbv0UYgYzsY1SVNlgfiygjBgl5sH
         B6a4OmRYwpZQNv+meDzA52Qq1gONLGlW0KzgnMQCzqku9giIWItiMOzYO7ls982HFTF7
         Ga+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682276118; x=1684868118;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQg8fQpPXaUKtSBTIp1XY4SP+/G7plSzsEOw8t/yqpk=;
        b=K5d+1ybyIdwb6Hf3C6pjLupYE1POYjWKjRudAD4+UBq2c5HVClCyeR6lBE98vJqJfc
         hlhF43q3qAAPxF4ycHZq6NUeOVGKfzEpYk0KKPhuFWpBd5r3ppBLcd2Dn4C4d6CmrXyv
         ZOlLB1wyMRrDfxv5dbhpNSXfwLrUXWJdWsUYlM1xeUVNiFuCsj4wlX6kkU1+lcm763Y7
         XxFL9QV+6aPr5vPcLsL5ED1ggRVR62BlwCG44UdG3wiODhdmUM1/HYxJ4loLw5BiOTof
         QzzP7dBhKpdj97Djdo7kaoxOP9ClaNyB2v5KFvVlst+wsJJPLJCj1+VeD1p9dXr0ZNjF
         ur8A==
X-Gm-Message-State: AAQBX9dOdsyWC8buTGAhKKL2Bhu6qOVGsp+/0uW7nQHbWD3nXKKVJxQK
        uIYmBGNDiIrOcqMN9RqSUfg=
X-Google-Smtp-Source: AKy350Y6IRu/s7WKt/UrMYzBQcJdiJnfyrHbB5cffh3cTNIExZ+gpI15v5c/IKWYXN5R6IGUzZBF5A==
X-Received: by 2002:a2e:8894:0:b0:2aa:e7cd:69f7 with SMTP id k20-20020a2e8894000000b002aae7cd69f7mr1137820lji.43.1682276117441;
        Sun, 23 Apr 2023 11:55:17 -0700 (PDT)
Received: from eg ([2a01:799:1727:1d00:655:71a:e699:402e])
        by smtp.gmail.com with ESMTPSA id u20-20020a2ea174000000b002a784085edbsm1474381ljl.99.2023.04.23.11.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 11:55:16 -0700 (PDT)
Date:   Sun, 23 Apr 2023 20:55:15 +0200
From:   Espen Grindhaug <espen.grindhaug@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2] libbpf: Improve version handling when attaching uprobe
Message-ID: <ZEV/EzOM+TJomP66@eg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This change fixes the handling of versions in elf_find_func_offset.
In the previous implementation, we incorrectly assumed that the
version information would be present in the string found in the
string table.

We now look up the correct version string in the version symbol
table before constructing the full name and then comparing.

This patch adds support for both name@version and name@@version to
match output of the various elf parsers.

Signed-off-by: Espen Grindhaug <espen.grindhaug@gmail.com>
---
Changes since v1:
- Added test
---
 tools/lib/bpf/libbpf.c                        | 148 +++++++++++++++---
 .../selftests/bpf/prog_tests/attach_probe.c   |  37 +++++
 .../selftests/bpf/progs/test_attach_probe.c   |  15 ++
 3 files changed, 181 insertions(+), 19 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 49cd304ae3bc..ef5e11ce6241 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10620,31 +10620,94 @@ static int perf_event_uprobe_open_legacy(const char *probe_name, bool retprobe,
 }
 
 /* Return next ELF section of sh_type after scn, or first of that type if scn is NULL. */
-static Elf_Scn *elf_find_next_scn_by_type(Elf *elf, int sh_type, Elf_Scn *scn)
+static Elf_Scn *elf_find_next_scn_by_type(Elf *elf, int sh_type, Elf_Scn *scn, size_t *idx)
 {
 	while ((scn = elf_nextscn(elf, scn)) != NULL) {
 		GElf_Shdr sh;
 
 		if (!gelf_getshdr(scn, &sh))
 			continue;
-		if (sh.sh_type == sh_type)
+		if (sh.sh_type == sh_type) {
+			if (idx)
+				*idx = sh.sh_link;
 			return scn;
+		}
+	}
+	return NULL;
+}
+
+static Elf_Data *elf_find_data_by_type(Elf *elf, int sh_type, size_t *idx)
+{
+	Elf_Scn *scn = elf_find_next_scn_by_type(elf, sh_type, NULL, idx);
+
+	if (scn)
+		return elf_getdata(scn, NULL);
+
+	return NULL;
+}
+
+static Elf64_Verdef *elf_verdef_by_offset(Elf_Data *data, size_t offset)
+{
+	if (offset + sizeof(Elf64_Verdef) > data->d_size)
+		return NULL;
+
+	return (Elf64_Verdef *)((char *) data->d_buf + offset);
+}
+
+static Elf64_Versym *elf_versym_by_idx(Elf_Data *data, size_t idx)
+{
+	if (idx >= data->d_size / sizeof(Elf64_Versym))
+		return NULL;
+
+	return (Elf64_Versym *)(data->d_buf + idx * sizeof(Elf64_Versym));
+}
+
+static Elf64_Verdaux *elf_verdaux_by_offset(Elf_Data *data, size_t offset)
+{
+	if (offset + sizeof(Elf64_Verdaux) > data->d_size)
+		return NULL;
+
+	return (Elf64_Verdaux *)((char *) data->d_buf + offset);
+}
+
+#define ELF_VERSYM_HIDDEN 0x8000
+#define ELF_VERSYM_IDX_MASK 0x7fff
+
+static Elf64_Verdaux *elf_get_verdaux_by_versym(Elf_Data *verdef_data, Elf64_Versym *versym)
+{
+	size_t offset = 0;
+
+	while (offset + sizeof(Elf64_Verdef) <= verdef_data->d_size) {
+		Elf64_Verdef *verdef = elf_verdef_by_offset(verdef_data, offset);
+
+		if (!verdef)
+			break;
+
+		if (verdef->vd_ndx == (*versym & ELF_VERSYM_IDX_MASK))
+			return elf_verdaux_by_offset(verdef_data, offset + verdef->vd_aux);
+
+		if (verdef->vd_next == 0)
+			break;
+
+		offset += verdef->vd_next;
 	}
 	return NULL;
 }
 
 /* Find offset of function name in the provided ELF object. "binary_path" is
  * the path to the ELF binary represented by "elf", and only used for error
- * reporting matters. "name" matches symbol name or name@@LIB for library
- * functions.
+ * reporting matters. "name" matches symbol name, name@LIB or name@@LIB for
+ * library functions.
  */
 static long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
 {
 	int i, sh_types[2] = { SHT_DYNSYM, SHT_SYMTAB };
 	bool is_shared_lib, is_name_qualified;
 	long ret = -ENOENT;
-	size_t name_len;
 	GElf_Ehdr ehdr;
+	Elf_Data *versym_data = NULL;
+	Elf_Data *verdef_data = NULL;
+	size_t verdef_stridx = 0;
 
 	if (!gelf_getehdr(elf, &ehdr)) {
 		pr_warn("elf: failed to get ehdr from %s: %s\n", binary_path, elf_errmsg(-1));
@@ -10654,9 +10717,12 @@ static long elf_find_func_offset(Elf *elf, const char *binary_path, const char *
 	/* for shared lib case, we do not need to calculate relative offset */
 	is_shared_lib = ehdr.e_type == ET_DYN;
 
-	name_len = strlen(name);
-	/* Does name specify "@@LIB"? */
-	is_name_qualified = strstr(name, "@@") != NULL;
+	/* Does name specify "@@LIB" or "@LIB"? */
+	is_name_qualified = strstr(name, "@") != NULL;
+
+	/* Extract version definition and version symbol table */
+	versym_data = elf_find_data_by_type(elf, SHT_GNU_versym, NULL);
+	verdef_data = elf_find_data_by_type(elf, SHT_GNU_verdef, &verdef_stridx);
 
 	/* Search SHT_DYNSYM, SHT_SYMTAB for symbol. This search order is used because if
 	 * a binary is stripped, it may only have SHT_DYNSYM, and a fully-statically
@@ -10671,10 +10737,10 @@ static long elf_find_func_offset(Elf *elf, const char *binary_path, const char *
 		const char *sname;
 		GElf_Shdr sh;
 
-		scn = elf_find_next_scn_by_type(elf, sh_types[i], NULL);
+		scn = elf_find_next_scn_by_type(elf, sh_types[i], NULL, NULL);
 		if (!scn) {
 			pr_debug("elf: failed to find symbol table ELF sections in '%s'\n",
-				 binary_path);
+				binary_path);
 			continue;
 		}
 		if (!gelf_getshdr(scn, &sh))
@@ -10705,16 +10771,60 @@ static long elf_find_func_offset(Elf *elf, const char *binary_path, const char *
 			if (!sname)
 				continue;
 
-			curr_bind = GELF_ST_BIND(sym.st_info);
+			if (is_name_qualified) {
+				Elf64_Versym *versym;
+				Elf64_Verdaux *verdaux;
+				int res;
+				char full_name[256];
 
-			/* User can specify func, func@@LIB or func@@LIB_VERSION. */
-			if (strncmp(sname, name, name_len) != 0)
-				continue;
-			/* ...but we don't want a search for "foo" to match 'foo2" also, so any
-			 * additional characters in sname should be of the form "@@LIB".
-			 */
-			if (!is_name_qualified && sname[name_len] != '\0' && sname[name_len] != '@')
-				continue;
+				/* check that name at least starts with sname before building
+				 * the full name
+				 */
+				if (strncmp(name, sname, strlen(sname)) != 0)
+					continue;
+
+				if (!versym_data || !verdef_data) {
+					pr_warn("elf: failed to find version definition or version symbol table in '%s'\n",
+						binary_path);
+					break;
+				}
+
+				versym = elf_versym_by_idx(versym_data, idx);
+				if (!versym) {
+					pr_warn("elf: failed to lookup versym for '%s' in '%s'\n",
+						sname, binary_path);
+					continue;
+				}
+
+				verdaux = elf_get_verdaux_by_versym(verdef_data, versym);
+				if (!verdaux) {
+					pr_warn("elf: failed to lookup verdaux for '%s' in '%s'\n",
+						sname, binary_path);
+					continue;
+				}
+
+				res = snprintf(full_name, sizeof(full_name),
+					       (*versym & ELF_VERSYM_HIDDEN) ? "%s@%s" :
+								    "%s@@%s",
+					       sname,
+					       elf_strptr(elf, verdef_stridx,
+							  verdaux->vda_name));
+
+				if (res < 0 || res >= sizeof(full_name)) {
+					pr_warn("elf: failed to build full name for '%s' in '%s'\n",
+						sname, binary_path);
+					continue;
+				}
+
+				if (strcmp(full_name, name) != 0)
+					continue;
+			} else {
+				/* If name is not qualified, we want to match the symbol name */
+				if (strcmp(sname, name) != 0)
+					continue;
+			}
+
+			curr_bind = GELF_ST_BIND(sym.st_info);
 
 			if (ret >= 0) {
 				/* handle multiple matches */
diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 7175af39134f..c3f33f7e9d12 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -192,6 +192,41 @@ static void test_uprobe_lib(struct test_attach_probe *skel)
 	ASSERT_EQ(skel->bss->uretprobe_byname2_res, 8, "check_uretprobe_byname2_res");
 }
 
+static void test_uprobe_lib_with_versions(struct test_attach_probe *skel)
+{
+	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
+	char absolute_path[256];
+
+	/* test attach with a versioned name.
+	 * realpath has two implementations in libc, only the default version will be used.
+	 */
+	uprobe_opts.func_name = "realpath@@GLIBC_2.3";
+	uprobe_opts.retprobe = false;
+	skel->links.handle_uprobe_byversionedname_a =
+			bpf_program__attach_uprobe_opts(skel->progs.handle_uprobe_byversionedname_a,
+							0 /* this pid */,
+							"libc.so.6",
+							0, &uprobe_opts);
+	if (!ASSERT_OK_PTR(skel->links.handle_uprobe_byversionedname_a, "attach_handle_uprobe_byversionedname_a"))
+		return;
+
+	uprobe_opts.func_name = "realpath@GLIBC_2.2.5";
+	uprobe_opts.retprobe = false;
+	skel->links.handle_uprobe_byversionedname_b =
+			bpf_program__attach_uprobe_opts(skel->progs.handle_uprobe_byversionedname_b,
+							0 /* this pid */,
+							"libc.so.6",
+							0, &uprobe_opts);
+	if (!ASSERT_OK_PTR(skel->links.handle_uprobe_byversionedname_b, "attach_handle_uprobe_byversionedname_b"))
+		return;
+
+	/* trigger & validate probes */
+	realpath("/", absolute_path);
+
+	ASSERT_EQ(skel->bss->uprobe_byversionedname_a_res, 13, "check_uprobe_byversionedname_a_res");
+	ASSERT_NEQ(skel->bss->uprobe_byversionedname_b_res, 14, "check_uprobe_byversionedname_b_res");
+}
+
 static void test_uprobe_ref_ctr(struct test_attach_probe *skel)
 {
 	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
@@ -316,6 +351,8 @@ void test_attach_probe(void)
 		test_kprobe_sleepable();
 	if (test__start_subtest("uprobe-lib"))
 		test_uprobe_lib(skel);
+	if (test__start_subtest("uprobe-lib-with-versions"))
+		test_uprobe_lib_with_versions(skel);
 	if (test__start_subtest("uprobe-sleepable"))
 		test_uprobe_sleepable(skel);
 	if (test__start_subtest("uprobe-ref_ctr"))
diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe.c b/tools/testing/selftests/bpf/progs/test_attach_probe.c
index 68466a6ad18c..079b58901ff8 100644
--- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
+++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
@@ -17,6 +17,8 @@ int uprobe_byname3_sleepable_res = 0;
 int uprobe_byname3_res = 0;
 int uretprobe_byname3_sleepable_res = 0;
 int uretprobe_byname3_res = 0;
+int uprobe_byversionedname_a_res = 0;
+int uprobe_byversionedname_b_res = 0;
 void *user_ptr = 0;
 
 SEC("ksyscall/nanosleep")
@@ -121,5 +123,18 @@ int handle_uretprobe_byname3(struct pt_regs *ctx)
 	return 0;
 }
 
+SEC("uprobe")
+int BPF_UPROBE(handle_uprobe_byversionedname_a, const char *a, char *b)
+{
+	uprobe_byversionedname_a_res = 13;
+	return 0;
+}
+
+SEC("uprobe")
+int BPF_UPROBE(handle_uprobe_byversionedname_b, const char *a, char *b)
+{
+	uprobe_byversionedname_b_res = 14;
+	return 0;
+}
 
 char _license[] SEC("license") = "GPL";
-- 
2.34.1

