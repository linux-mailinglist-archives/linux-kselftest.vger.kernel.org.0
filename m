Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092AB616B67
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 19:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiKBSCu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 14:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiKBSCo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 14:02:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6344E1DF02
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Nov 2022 11:02:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h9-20020a25e209000000b006cbc4084f2eso17006734ybe.23
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Nov 2022 11:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9l8lXjhxyvx7hugLBY5a32mtgpwYy/QS8EhOcey2iJI=;
        b=N4qvZiTh6z/VpHEhAgpt+iXW10wLeCyb2cfbL6vwglqWIp2RVKilvjOiNlHxER0jpt
         znhYMS+GXRgJc9ovLRn5F0PBQhLD2mYCI1X+ms77VFGTxodL6kBNC5q6U7m4pYdmSMZb
         dw+cilBQuDcwZRFBWtHD9kFcMemn/ocwOmlxiIyK7vquw6uzPO0tiaXqk8Tc0cfxQdhu
         FJORiG3npVqhFSKbb2N/st34l4T+XzzM47ZA7iF/2T/ZbgiEZNBJNz8O/1GKGekYcbip
         gVG6Si/IGK0IdLp+BA8pmoVlCCGx+OhJuyxPbqhpIltp+pDVcQZxMTAYruwIChHoEisR
         J5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9l8lXjhxyvx7hugLBY5a32mtgpwYy/QS8EhOcey2iJI=;
        b=RMcb0PqL/ElpMj4oeOxXTl8lnl6K3OVpLvd7XcYrBiYIz4YGYfR4IRC3+gn7/2onMR
         k5By7smBBYjKS0955M3cJew14lCAqCaE0mo3cmO0yOwaZgGEElpOG1O0OYZRDH9DiuwG
         5N1ykWpqMUAWY8ZXckuJaAJg5FPy8WVN42iFYlUrUmbyAV8GNtsMKYlEF665CW4bEjLV
         nt30s4h59OhVKKMzKImpJXdvvf51uCMpRcWQ7E61RmlQUJ7NZ1MRcpkZmJFmEupazTAj
         DX7VSkXFTjDWGZqzprBeGLiouv2G3ZEu4Kb31n5jnj1vLAVggtjjSGslWfjoYQLwMhGQ
         6j5g==
X-Gm-Message-State: ACrzQf0jbeeQe4fuctniNMhIR0bLpwtSM1/oTk7qyqZuauvqbGGJQuqZ
        WzBlVUJYUu96SGJSgvIXRx7mfJStvg==
X-Google-Smtp-Source: AMsMyM5AVh8CpO5jJTevTDqw22vtL9e0CmtvIVvSCpW2+ILj37woZ0CBjDZE4kGPbtPZIRlCwwwEOVuZGA==
X-Received: from rmoar.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:4259])
 (user=rmoar job=sendgmr) by 2002:a25:ae08:0:b0:6ca:2041:7c8c with SMTP id
 a8-20020a25ae08000000b006ca20417c8cmr24515071ybj.250.1667412162715; Wed, 02
 Nov 2022 11:02:42 -0700 (PDT)
Date:   Wed,  2 Nov 2022 17:59:59 +0000
In-Reply-To: <20221102175959.2921063-1-rmoar@google.com>
Mime-Version: 1.0
References: <20221102175959.2921063-1-rmoar@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221102175959.2921063-3-rmoar@google.com>
Subject: [PATCH v1 2/2] apparmor: test: make static symbols visible during
 kunit testing
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, tales.aparecida@gmail.com,
        john.johansen@canonical.com, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        apparmor@lists.ubuntu.com, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use macros, VISIBLE_IF_KUNIT and EXPORT_SYMBOL_IF_KUNIT, to allow
static symbols to be conditionally set to be visible during KUnit
testing. Remove the need to include testing file in the implementation
file. Provide example of how static symbols can be dealt with in
testing.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 security/apparmor/Kconfig                 |  4 +-
 security/apparmor/Makefile                |  2 +
 security/apparmor/include/policy_unpack.h | 50 ++++++++++++++++
 security/apparmor/policy_unpack.c         | 72 +++++++----------------
 security/apparmor/policy_unpack_test.c    |  5 ++
 5 files changed, 80 insertions(+), 53 deletions(-)

diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index cb3496e00d8a..f334e7cccf2d 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -106,8 +106,8 @@ config SECURITY_APPARMOR_PARANOID_LOAD
 	  Disabling the check will speed up policy loads.
 
 config SECURITY_APPARMOR_KUNIT_TEST
-	bool "Build KUnit tests for policy_unpack.c" if !KUNIT_ALL_TESTS
-	depends on KUNIT=y && SECURITY_APPARMOR
+	tristate "Build KUnit tests for policy_unpack.c" if !KUNIT_ALL_TESTS
+	depends on KUNIT && SECURITY_APPARMOR
 	default KUNIT_ALL_TESTS
 	help
 	  This builds the AppArmor KUnit tests.
diff --git a/security/apparmor/Makefile b/security/apparmor/Makefile
index ff23fcfefe19..6a92428375eb 100644
--- a/security/apparmor/Makefile
+++ b/security/apparmor/Makefile
@@ -8,6 +8,8 @@ apparmor-y := apparmorfs.o audit.o capability.o task.o ipc.o lib.o match.o \
               resource.o secid.o file.o policy_ns.o label.o mount.o net.o
 apparmor-$(CONFIG_SECURITY_APPARMOR_HASH) += crypto.o
 
+obj-$(CONFIG_SECURITY_APPARMOR_KUNIT_TEST) += policy_unpack_test.o
+
 clean-files := capability_names.h rlim_names.h net_names.h
 
 # Build a lower case string table of address family names
diff --git a/security/apparmor/include/policy_unpack.h b/security/apparmor/include/policy_unpack.h
index eb5f7d7f132b..a963687bcc9b 100644
--- a/security/apparmor/include/policy_unpack.h
+++ b/security/apparmor/include/policy_unpack.h
@@ -48,6 +48,43 @@ enum {
 	AAFS_LOADDATA_NDENTS		/* count of entries */
 };
 
+/*
+ * The AppArmor interface treats data as a type byte followed by the
+ * actual data.  The interface has the notion of a named entry
+ * which has a name (AA_NAME typecode followed by name string) followed by
+ * the entries typecode and data.  Named types allow for optional
+ * elements and extensions to be added and tested for without breaking
+ * backwards compatibility.
+ */
+
+enum aa_code {
+	AA_U8,
+	AA_U16,
+	AA_U32,
+	AA_U64,
+	AA_NAME,		/* same as string except it is items name */
+	AA_STRING,
+	AA_BLOB,
+	AA_STRUCT,
+	AA_STRUCTEND,
+	AA_LIST,
+	AA_LISTEND,
+	AA_ARRAY,
+	AA_ARRAYEND,
+};
+
+/*
+ * aa_ext is the read of the buffer containing the serialized profile.  The
+ * data is copied into a kernel buffer in apparmorfs and then handed off to
+ * the unpack routines.
+ */
+struct aa_ext {
+	void *start;
+	void *end;
+	void *pos;		/* pointer to current position in the buffer */
+	u32 version;
+};
+
 /*
  * struct aa_loaddata - buffer of policy raw_data set
  *
@@ -126,4 +163,17 @@ static inline void aa_put_loaddata(struct aa_loaddata *data)
 		kref_put(&data->count, aa_loaddata_kref);
 }
 
+#if IS_ENABLED(CONFIG_KUNIT)
+bool inbounds(struct aa_ext *e, size_t size);
+size_t unpack_u16_chunk(struct aa_ext *e, char **chunk);
+bool unpack_X(struct aa_ext *e, enum aa_code code);
+bool unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name);
+bool unpack_u32(struct aa_ext *e, u32 *data, const char *name);
+bool unpack_u64(struct aa_ext *e, u64 *data, const char *name);
+size_t unpack_array(struct aa_ext *e, const char *name);
+size_t unpack_blob(struct aa_ext *e, char **blob, const char *name);
+int unpack_str(struct aa_ext *e, const char **string, const char *name);
+int unpack_strdup(struct aa_ext *e, char **string, const char *name);
+#endif
+
 #endif /* __POLICY_INTERFACE_H */
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 55d31bac4f35..c23aa70349aa 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -14,6 +14,7 @@
  */
 
 #include <asm/unaligned.h>
+#include <kunit/visibility.h>
 #include <linux/ctype.h>
 #include <linux/errno.h>
 #include <linux/zlib.h>
@@ -37,43 +38,6 @@
 #define v7	7
 #define v8	8	/* full network masking */
 
-/*
- * The AppArmor interface treats data as a type byte followed by the
- * actual data.  The interface has the notion of a named entry
- * which has a name (AA_NAME typecode followed by name string) followed by
- * the entries typecode and data.  Named types allow for optional
- * elements and extensions to be added and tested for without breaking
- * backwards compatibility.
- */
-
-enum aa_code {
-	AA_U8,
-	AA_U16,
-	AA_U32,
-	AA_U64,
-	AA_NAME,		/* same as string except it is items name */
-	AA_STRING,
-	AA_BLOB,
-	AA_STRUCT,
-	AA_STRUCTEND,
-	AA_LIST,
-	AA_LISTEND,
-	AA_ARRAY,
-	AA_ARRAYEND,
-};
-
-/*
- * aa_ext is the read of the buffer containing the serialized profile.  The
- * data is copied into a kernel buffer in apparmorfs and then handed off to
- * the unpack routines.
- */
-struct aa_ext {
-	void *start;
-	void *end;
-	void *pos;		/* pointer to current position in the buffer */
-	u32 version;
-};
-
 /* audit callback for unpack fields */
 static void audit_cb(struct audit_buffer *ab, void *va)
 {
@@ -199,10 +163,11 @@ struct aa_loaddata *aa_loaddata_alloc(size_t size)
 }
 
 /* test if read will be in packed data bounds */
-static bool inbounds(struct aa_ext *e, size_t size)
+VISIBLE_IF_KUNIT bool inbounds(struct aa_ext *e, size_t size)
 {
 	return (size <= e->end - e->pos);
 }
+EXPORT_SYMBOL_IF_KUNIT(inbounds);
 
 static void *kvmemdup(const void *src, size_t len)
 {
@@ -220,7 +185,7 @@ static void *kvmemdup(const void *src, size_t len)
  *
  * Returns: the size of chunk found with the read head at the end of the chunk.
  */
-static size_t unpack_u16_chunk(struct aa_ext *e, char **chunk)
+VISIBLE_IF_KUNIT size_t unpack_u16_chunk(struct aa_ext *e, char **chunk)
 {
 	size_t size = 0;
 	void *pos = e->pos;
@@ -239,9 +204,10 @@ static size_t unpack_u16_chunk(struct aa_ext *e, char **chunk)
 	e->pos = pos;
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(unpack_u16_chunk);
 
 /* unpack control byte */
-static bool unpack_X(struct aa_ext *e, enum aa_code code)
+VISIBLE_IF_KUNIT bool unpack_X(struct aa_ext *e, enum aa_code code)
 {
 	if (!inbounds(e, 1))
 		return false;
@@ -250,6 +216,7 @@ static bool unpack_X(struct aa_ext *e, enum aa_code code)
 	e->pos++;
 	return true;
 }
+EXPORT_SYMBOL_IF_KUNIT(unpack_X);
 
 /**
  * unpack_nameX - check is the next element is of type X with a name of @name
@@ -267,7 +234,7 @@ static bool unpack_X(struct aa_ext *e, enum aa_code code)
  *
  * Returns: false if either match fails, the read head does not move
  */
-static bool unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name)
+VISIBLE_IF_KUNIT bool unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name)
 {
 	/*
 	 * May need to reset pos if name or type doesn't match
@@ -296,6 +263,7 @@ static bool unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name)
 	e->pos = pos;
 	return false;
 }
+EXPORT_SYMBOL_IF_KUNIT(unpack_nameX);
 
 static bool unpack_u8(struct aa_ext *e, u8 *data, const char *name)
 {
@@ -315,7 +283,7 @@ static bool unpack_u8(struct aa_ext *e, u8 *data, const char *name)
 	return false;
 }
 
-static bool unpack_u32(struct aa_ext *e, u32 *data, const char *name)
+VISIBLE_IF_KUNIT bool unpack_u32(struct aa_ext *e, u32 *data, const char *name)
 {
 	void *pos = e->pos;
 
@@ -332,8 +300,9 @@ static bool unpack_u32(struct aa_ext *e, u32 *data, const char *name)
 	e->pos = pos;
 	return false;
 }
+EXPORT_SYMBOL_IF_KUNIT(unpack_u32);
 
-static bool unpack_u64(struct aa_ext *e, u64 *data, const char *name)
+VISIBLE_IF_KUNIT bool unpack_u64(struct aa_ext *e, u64 *data, const char *name)
 {
 	void *pos = e->pos;
 
@@ -350,8 +319,9 @@ static bool unpack_u64(struct aa_ext *e, u64 *data, const char *name)
 	e->pos = pos;
 	return false;
 }
+EXPORT_SYMBOL_IF_KUNIT(unpack_u64);
 
-static size_t unpack_array(struct aa_ext *e, const char *name)
+VISIBLE_IF_KUNIT size_t unpack_array(struct aa_ext *e, const char *name)
 {
 	void *pos = e->pos;
 
@@ -368,8 +338,9 @@ static size_t unpack_array(struct aa_ext *e, const char *name)
 	e->pos = pos;
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(unpack_array);
 
-static size_t unpack_blob(struct aa_ext *e, char **blob, const char *name)
+VISIBLE_IF_KUNIT size_t unpack_blob(struct aa_ext *e, char **blob, const char *name)
 {
 	void *pos = e->pos;
 
@@ -390,8 +361,9 @@ static size_t unpack_blob(struct aa_ext *e, char **blob, const char *name)
 	e->pos = pos;
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(unpack_blob);
 
-static int unpack_str(struct aa_ext *e, const char **string, const char *name)
+VISIBLE_IF_KUNIT int unpack_str(struct aa_ext *e, const char **string, const char *name)
 {
 	char *src_str;
 	size_t size = 0;
@@ -413,8 +385,9 @@ static int unpack_str(struct aa_ext *e, const char **string, const char *name)
 	e->pos = pos;
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(unpack_str);
 
-static int unpack_strdup(struct aa_ext *e, char **string, const char *name)
+VISIBLE_IF_KUNIT int unpack_strdup(struct aa_ext *e, char **string, const char *name)
 {
 	const char *tmp;
 	void *pos = e->pos;
@@ -432,6 +405,7 @@ static int unpack_strdup(struct aa_ext *e, char **string, const char *name)
 
 	return res;
 }
+EXPORT_SYMBOL_IF_KUNIT(unpack_strdup);
 
 
 /**
@@ -1251,7 +1225,3 @@ int aa_unpack(struct aa_loaddata *udata, struct list_head *lh,
 
 	return error;
 }
-
-#ifdef CONFIG_SECURITY_APPARMOR_KUNIT_TEST
-#include "policy_unpack_test.c"
-#endif /* CONFIG_SECURITY_APPARMOR_KUNIT_TEST */
diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
index 0a969b2e03db..3474fe2cd922 100644
--- a/security/apparmor/policy_unpack_test.c
+++ b/security/apparmor/policy_unpack_test.c
@@ -4,6 +4,7 @@
  */
 
 #include <kunit/test.h>
+#include <kunit/visibility.h>
 
 #include "include/policy.h"
 #include "include/policy_unpack.h"
@@ -43,6 +44,8 @@
 #define TEST_ARRAY_BUF_OFFSET \
 	(TEST_NAMED_ARRAY_BUF_OFFSET + 3 + strlen(TEST_ARRAY_NAME) + 1)
 
+MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
+
 struct policy_unpack_fixture {
 	struct aa_ext *e;
 	size_t e_size;
@@ -605,3 +608,5 @@ static struct kunit_suite apparmor_policy_unpack_test_module = {
 };
 
 kunit_test_suite(apparmor_policy_unpack_test_module);
+
+MODULE_LICENSE("GPL");
-- 
2.38.1.273.g43a17bfeac-goog

