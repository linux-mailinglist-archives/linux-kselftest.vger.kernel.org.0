Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3747E590F37
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Aug 2022 12:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238438AbiHLKUD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Aug 2022 06:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbiHLKUC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Aug 2022 06:20:02 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1118AB4C6;
        Fri, 12 Aug 2022 03:20:00 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M40386BLgz688sr;
        Fri, 12 Aug 2022 18:17:08 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 12:19:57 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <mykolal@fb.com>,
        <corbet@lwn.net>, <dhowells@redhat.com>, <jarkko@kernel.org>,
        <rostedt@goodmis.org>, <mingo@redhat.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <shuah@kernel.org>
CC:     <bpf@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v11 4/9] KEYS: Move KEY_LOOKUP_ to include/linux/key.h
Date:   Fri, 12 Aug 2022 12:18:57 +0200
Message-ID: <20220812101902.2846182-5-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812101902.2846182-1-roberto.sassu@huawei.com>
References: <20220812101902.2846182-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In preparation for the patch that introduces the bpf_lookup_user_key() eBPF
kfunc, move KEY_LOOKUP_ definitions to include/linux/key.h, to be able to
validate the kfunc parameters.

Also, introduce key_lookup_flags_check() directly in include/linux/key.h,
to reduce the risk that the check is not in sync with currently defined
flags.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/key.h      | 11 +++++++++++
 security/keys/internal.h |  2 --
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 7febc4881363..b5bbae77a9e7 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -88,6 +88,17 @@ enum key_need_perm {
 	KEY_DEFER_PERM_CHECK,	/* Special: permission check is deferred */
 };
 
+#define KEY_LOOKUP_CREATE	0x01
+#define KEY_LOOKUP_PARTIAL	0x02
+
+static inline int key_lookup_flags_check(u64 flags)
+{
+	if (flags & ~(KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL))
+		return -EINVAL;
+
+	return 0;
+}
+
 struct seq_file;
 struct user_struct;
 struct signal_struct;
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 9b9cf3b6fcbb..3c1e7122076b 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -165,8 +165,6 @@ extern struct key *request_key_and_link(struct key_type *type,
 
 extern bool lookup_user_key_possessed(const struct key *key,
 				      const struct key_match_data *match_data);
-#define KEY_LOOKUP_CREATE	0x01
-#define KEY_LOOKUP_PARTIAL	0x02
 
 extern long join_session_keyring(const char *name);
 extern void key_change_session_keyring(struct callback_head *twork);
-- 
2.25.1

