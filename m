Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED7377D7D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 03:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbjHPBpi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 21:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241130AbjHPBpY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 21:45:24 -0400
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED7D2109;
        Tue, 15 Aug 2023 18:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1692150313;
        bh=p9swnxtjKzpWU0CCLxh3ai2IDMKAHQvIudSZ/qgIf5w=;
        h=From:To:Cc:Subject:Date;
        b=K77xyGgMT03mMbLwoxmznZYpD3JrtXcKL+eP0rMQu392ZXjQY/24C9D2bvrQCzHGG
         7pIa1siQ6JucETn3UTpV4a0jwl2IIOCOzGuBEZXLNAn1Su0dW+h2STXDtur1pg/UPu
         lnbIgFVSXk9FTyXjmst8wck0HLEF6crY2I+hCQmk=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 93B8F64C; Wed, 16 Aug 2023 09:36:59 +0800
X-QQ-mid: xmsmtpt1692149819tp6gg1e0n
Message-ID: <tencent_59C74613113F0C728524B2A82FE5540A5E09@qq.com>
X-QQ-XMAILINFO: OMWm0AbyvxL+tZBWJ1ZHcNDuZOj9clm0twjWnbc37IBWOt7o/a57bTkq0rSmIV
         tcjdYI21zz6zgaNTSF8LuqoMsSLpQtomXz3RUA9pARkOBr6PXNJBkSVCk5vmm3u/jWCNjWYwJxrd
         uVaDeUG/YIh3MdBbc0swXRt8rm9acY9/WAReHlsJ9jbks9dcncaxU4T8HlTmuTVdEDoK8bGtWWUn
         hidsQUYkc8wMac+ielWf5vlBricVMCX/uyfnKv5R0EJFk8HGVnwoTFTxAsQS02PIh9ZsgRYrR6UU
         XSjjolUuXAdqjfRqjIhJ0leaJLISF0LFHlPk9qM4hvR3Jm4ycuKkQ8vXDq1KaqNJb0g0EjKhsbg6
         SeiKoHocjlY8/j10oy0QXcEjysZDOwmRuhRJGYWQK6HNGrAuNTdeCU3Otm6Lw5yF4EByHjZCIF3p
         FESIsIYTerLC7H54McpcoXMESK1xvqJHIXOHJi9NaDtCfuqCJez+RgjG9j7PubLsaEnhwK2HMqHC
         R7L5c08fween1qvGvguvSbhvfAubIhgWjpDJQyVuBem0dJu/7GhQ07lLQbDHVyn3za950O5N2n1m
         j72gkjXyp8KG7MtsBgANoKQOCeM1DBPZs0lRtBKPRVGuM33N2SvL98ErOEGShW8SqYqxt3VYCim5
         rTkhShLPCcVQHBXsuSQ+VbAbn3qxMqIAT5dKfsjMogkBfIzJDk7jA4qPgB76iIqFGMne3LoNJ3sm
         GzMfkcY9qGqcTc6MuOaArbfN3aVQePoxX+oDm4aJUXzr6yIPUR3QHSzttwdqHTiSqzqSjF17ZVvl
         wcNB0tCHGgGUTdkUuTBQrdRlI4IKBSpgGuqXjA9IJyXUmNfgm84nT/GU1e1BS7GrOcpyWGHDjBH+
         7hA3l/Ud+Pf8CClMjHUv83tOvbtmkfSNHVPe0FOADIOhW8HYiIQyej5CGAgcZ0HLs8bY07hFSzYf
         boQU/jC+3JgDibnjgb3FABmtN+hGc3hNVycDwMsJAgXFH0sofDKTZZu6a1F2avQdhmFojD2cvryf
         dUJCLeNg==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From:   Rong Tao <rtoax@foxmail.com>
To:     sdf@google.com, daniel@iogearbox.net, andrii@kernel.org
Cc:     rongtao@cestc.cn, rtoax@foxmail.com,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org (open list:BPF [SELFTESTS] (Test Runners &
        Infrastructure)),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next v4] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date:   Wed, 16 Aug 2023 09:36:52 +0800
X-OQ-MSGID: <20230816013652.26900-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Static ksyms often have problems because the number of symbols exceeds the
MAX_SYMS limit. Like changing the MAX_SYMS from 300000 to 400000 in
commit e76a014334a6("selftests/bpf: Bump and validate MAX_SYMS") solves
the problem somewhat, but it's not the perfect way.

This commit uses dynamic memory allocation, which completely solves the
problem caused by the limitation of the number of kallsyms.

Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
v4: Make sure most cases we don't need the realloc() path to begin with,
    and check strdup() return value.
v3: https://lore.kernel.org/lkml/tencent_50B4B2622FE7546A5FF9464310650C008509@qq.com/
    Do not use structs and judge ksyms__add_symbol function return value.
v2: https://lore.kernel.org/lkml/tencent_B655EE5E5D463110D70CD2846AB3262EED09@qq.com/
    Do the usual len/capacity scheme here to amortize the cost of realloc, and
    don't free symbols.
v1: https://lore.kernel.org/lkml/tencent_AB461510B10CD484E0B2F62E3754165F2909@qq.com/
---
 tools/testing/selftests/bpf/trace_helpers.c | 46 ++++++++++++++++-----
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index f83d9f65c65b..a1461508925e 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -18,10 +18,35 @@
 #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
 #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
 
-#define MAX_SYMS 400000
-static struct ksym syms[MAX_SYMS];
+static struct ksym *syms;
+static int sym_cap;
 static int sym_cnt;
 
+static int ksyms__add_symbol(const char *name, unsigned long addr)
+{
+	void *tmp;
+	unsigned int new_cap;
+
+	if (sym_cnt + 1 > sym_cap) {
+		new_cap = sym_cap * 4 / 3;
+		tmp = realloc(syms, sizeof(struct ksym) * new_cap);
+		if (!tmp)
+			return -ENOMEM;
+		syms = tmp;
+		sym_cap = new_cap;
+	}
+
+	tmp = strdup(name);
+	if (!tmp)
+		return -ENOMEM;
+	syms[sym_cnt].addr = addr;
+	syms[sym_cnt].name = tmp;
+
+	sym_cnt++;
+
+	return 0;
+}
+
 static int ksym_cmp(const void *p1, const void *p2)
 {
 	return ((struct ksym *)p1)->addr - ((struct ksym *)p2)->addr;
@@ -33,9 +58,14 @@ int load_kallsyms_refresh(void)
 	char func[256], buf[256];
 	char symbol;
 	void *addr;
-	int i = 0;
+	int ret;
 
+	/* Make sure most cases we don't need the realloc() path to begin with */
+	sym_cap = 400000;
 	sym_cnt = 0;
+	syms = malloc(sizeof(struct ksym) * sym_cap);
+	if (!syms)
+		return -ENOMEM;
 
 	f = fopen("/proc/kallsyms", "r");
 	if (!f)
@@ -46,15 +76,11 @@ int load_kallsyms_refresh(void)
 			break;
 		if (!addr)
 			continue;
-		if (i >= MAX_SYMS)
-			return -EFBIG;
-
-		syms[i].addr = (long) addr;
-		syms[i].name = strdup(func);
-		i++;
+		ret = ksyms__add_symbol(func, (unsigned long)addr);
+		if (ret)
+			return ret;
 	}
 	fclose(f);
-	sym_cnt = i;
 	qsort(syms, sym_cnt, sizeof(struct ksym), ksym_cmp);
 	return 0;
 }
-- 
2.39.3

