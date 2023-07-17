Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72B975635B
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 14:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjGQMz1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 08:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjGQMz0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 08:55:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F96E47;
        Mon, 17 Jul 2023 05:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689598524; x=1721134524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MK2n2OSkVqVYu9YHHQNwvJQ+yMJ1cHclPzK02uREhtk=;
  b=cNekgUbg7L2cr9vERT4MGchD/T8Vd6IO86JnMSJdZuof3GLyvZjGMHuy
   X1FhTleXcH+DOMgSA3nUV25/iZhZtAeB+XjEVvjDl6t7K5L/xmDCd0a/t
   7M/j1p4QlTqrkoinhz5UQh7zkKoAB0FO97DXhbP1ZsXjF6S1kpmzjeWfv
   oMX4kcsGBtD69dp4tVlRBVsyCsRk/0gtANa8h/fq2ecKyOZVr9MfEwrgP
   vPeVG/D2GFcAFVEwggmjy4sBUlaR+2GgKsUOvYhS5CNN4+S0gIqdCMnNX
   LUuH9hdaOQEIAxbt2ClMcLRULfuvrD2DG6inS5I37rWbABHuMW4Tbwp3E
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="452295022"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="452295022"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 05:55:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="752886763"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="752886763"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 17 Jul 2023 05:55:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 000055FC; Mon, 17 Jul 2023 15:55:23 +0300 (EEST)
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
Subject: [PATCH v3 4/4] genetlink: Replace custom CONCATENATE() implementation
Date:   Mon, 17 Jul 2023 15:55:21 +0300
Message-Id: <20230717125521.43176-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230717125521.43176-1-andriy.shevchenko@linux.intel.com>
References: <20230717125521.43176-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

