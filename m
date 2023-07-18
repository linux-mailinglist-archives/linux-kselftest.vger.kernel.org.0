Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32857758694
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 23:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjGRVLv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 17:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjGRVLu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 17:11:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59BCEC;
        Tue, 18 Jul 2023 14:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689714709; x=1721250709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MK2n2OSkVqVYu9YHHQNwvJQ+yMJ1cHclPzK02uREhtk=;
  b=FJ2g2VrI38Je68Zl75TQvwGbm9EXHzbG+yIG/J2RB5FxFqjkTEjlCeM6
   7RhAKTPU+6nY9t7Wx2XQmvLwH65dFiFQKwKaIVQYrJx7efCfbBv7pS6vp
   yZ+rkHjHt7+SdFRcTyB/Bp0ZaoK2AI5B8LvMma8ddmhIcsmJYBE1NHb1q
   sJMOcZTHj6bgx3j8PTis8f09OkS2nia4i3wrPpsAioHjYxdr5LlDCWcEW
   CyF8dBB74P2o10xMkHxO5JNkMoJ//XOUBm3YpGbfn7rocQdVQW9mFU9Ei
   7jDm3MbAZyM0oCwSa0Ev340qBZkZtknG6EnwsybuywbXkCMGgZ5BblQTC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="397161854"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="397161854"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 14:11:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="789206000"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="789206000"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jul 2023 14:11:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E0266516; Wed, 19 Jul 2023 00:11:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 4/4] genetlink: Replace custom CONCATENATE() implementation
Date:   Wed, 19 Jul 2023 00:11:47 +0300
Message-Id: <20230718211147.18647-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230718211147.18647-1-andriy.shevchenko@linux.intel.com>
References: <20230718211147.18647-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Replace custom implementation of the macros from args.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/genl_magic_func.h   | 27 ++++++++++++++-------------
 include/linux/genl_magic_struct.h |  8 +++-----
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/include/linux/genl_magic_func.h b/include/linux/genl_magic_func.h
index 2984b0cb24b1..d4da060b7532 100644
--- a/include/linux/genl_magic_func.h
+++ b/include/linux/genl_magic_func.h
@@ -2,6 +2,7 @@
 #ifndef GENL_MAGIC_FUNC_H
 #define GENL_MAGIC_FUNC_H
 
+#include <linux/args.h>
 #include <linux/build_bug.h>
 #include <linux/genl_magic_struct.h>
 
@@ -23,7 +24,7 @@
 #define GENL_struct(tag_name, tag_number, s_name, s_fields)		\
 	[tag_name] = { .type = NLA_NESTED },
 
-static struct nla_policy CONCAT_(GENL_MAGIC_FAMILY, _tla_nl_policy)[] = {
+static struct nla_policy CONCATENATE(GENL_MAGIC_FAMILY, _tla_nl_policy)[] = {
 #include GENL_MAGIC_INCLUDE_FILE
 };
 
@@ -209,7 +210,7 @@ static int s_name ## _from_attrs_for_change(struct s_name *s,		\
  * Magic: define op number to op name mapping				{{{1
  *									{{{2
  */
-static const char *CONCAT_(GENL_MAGIC_FAMILY, _genl_cmd_to_str)(__u8 cmd)
+static const char *CONCATENATE(GENL_MAGIC_FAMILY, _genl_cmd_to_str)(__u8 cmd)
 {
 	switch (cmd) {
 #undef GENL_op
@@ -235,7 +236,7 @@ static const char *CONCAT_(GENL_MAGIC_FAMILY, _genl_cmd_to_str)(__u8 cmd)
 	.cmd = op_name,						\
 },
 
-#define ZZZ_genl_ops		CONCAT_(GENL_MAGIC_FAMILY, _genl_ops)
+#define ZZZ_genl_ops		CONCATENATE(GENL_MAGIC_FAMILY, _genl_ops)
 static struct genl_ops ZZZ_genl_ops[] __read_mostly = {
 #include GENL_MAGIC_INCLUDE_FILE
 };
@@ -248,32 +249,32 @@ static struct genl_ops ZZZ_genl_ops[] __read_mostly = {
  * and provide register/unregister functions.
  *									{{{2
  */
-#define ZZZ_genl_family		CONCAT_(GENL_MAGIC_FAMILY, _genl_family)
+#define ZZZ_genl_family		CONCATENATE(GENL_MAGIC_FAMILY, _genl_family)
 static struct genl_family ZZZ_genl_family;
 /*
  * Magic: define multicast groups
  * Magic: define multicast group registration helper
  */
-#define ZZZ_genl_mcgrps		CONCAT_(GENL_MAGIC_FAMILY, _genl_mcgrps)
+#define ZZZ_genl_mcgrps		CONCATENATE(GENL_MAGIC_FAMILY, _genl_mcgrps)
 static const struct genl_multicast_group ZZZ_genl_mcgrps[] = {
 #undef GENL_mc_group
 #define GENL_mc_group(group) { .name = #group, },
 #include GENL_MAGIC_INCLUDE_FILE
 };
 
-enum CONCAT_(GENL_MAGIC_FAMILY, group_ids) {
+enum CONCATENATE(GENL_MAGIC_FAMILY, group_ids) {
 #undef GENL_mc_group
-#define GENL_mc_group(group) CONCAT_(GENL_MAGIC_FAMILY, _group_ ## group),
+#define GENL_mc_group(group) CONCATENATE(GENL_MAGIC_FAMILY, _group_ ## group),
 #include GENL_MAGIC_INCLUDE_FILE
 };
 
 #undef GENL_mc_group
 #define GENL_mc_group(group)						\
-static int CONCAT_(GENL_MAGIC_FAMILY, _genl_multicast_ ## group)(	\
+static int CONCATENATE(GENL_MAGIC_FAMILY, _genl_multicast_ ## group)(	\
 	struct sk_buff *skb, gfp_t flags)				\
 {									\
 	unsigned int group_id =						\
-		CONCAT_(GENL_MAGIC_FAMILY, _group_ ## group);		\
+		CONCATENATE(GENL_MAGIC_FAMILY, _group_ ## group);		\
 	return genlmsg_multicast(&ZZZ_genl_family, skb, 0,		\
 				 group_id, flags);			\
 }
@@ -289,8 +290,8 @@ static struct genl_family ZZZ_genl_family __ro_after_init = {
 #ifdef GENL_MAGIC_FAMILY_HDRSZ
 	.hdrsize = NLA_ALIGN(GENL_MAGIC_FAMILY_HDRSZ),
 #endif
-	.maxattr = ARRAY_SIZE(CONCAT_(GENL_MAGIC_FAMILY, _tla_nl_policy))-1,
-	.policy	= CONCAT_(GENL_MAGIC_FAMILY, _tla_nl_policy),
+	.maxattr = ARRAY_SIZE(CONCATENATE(GENL_MAGIC_FAMILY, _tla_nl_policy))-1,
+	.policy	= CONCATENATE(GENL_MAGIC_FAMILY, _tla_nl_policy),
 	.ops = ZZZ_genl_ops,
 	.n_ops = ARRAY_SIZE(ZZZ_genl_ops),
 	.mcgrps = ZZZ_genl_mcgrps,
@@ -299,12 +300,12 @@ static struct genl_family ZZZ_genl_family __ro_after_init = {
 	.module = THIS_MODULE,
 };
 
-int CONCAT_(GENL_MAGIC_FAMILY, _genl_register)(void)
+int CONCATENATE(GENL_MAGIC_FAMILY, _genl_register)(void)
 {
 	return genl_register_family(&ZZZ_genl_family);
 }
 
-void CONCAT_(GENL_MAGIC_FAMILY, _genl_unregister)(void)
+void CONCATENATE(GENL_MAGIC_FAMILY, _genl_unregister)(void)
 {
 	genl_unregister_family(&ZZZ_genl_family);
 }
diff --git a/include/linux/genl_magic_struct.h b/include/linux/genl_magic_struct.h
index f81d48987528..a419d93789ff 100644
--- a/include/linux/genl_magic_struct.h
+++ b/include/linux/genl_magic_struct.h
@@ -14,14 +14,12 @@
 # error "you need to define GENL_MAGIC_INCLUDE_FILE before inclusion"
 #endif
 
+#include <linux/args.h>
 #include <linux/genetlink.h>
 #include <linux/types.h>
 
-#define CONCAT__(a,b)	a ## b
-#define CONCAT_(a,b)	CONCAT__(a,b)
-
-extern int CONCAT_(GENL_MAGIC_FAMILY, _genl_register)(void);
-extern void CONCAT_(GENL_MAGIC_FAMILY, _genl_unregister)(void);
+extern int CONCATENATE(GENL_MAGIC_FAMILY, _genl_register)(void);
+extern void CONCATENATE(GENL_MAGIC_FAMILY, _genl_unregister)(void);
 
 /*
  * Extension of genl attribute validation policies			{{{2
-- 
2.40.0.1.gaa8946217a0b

