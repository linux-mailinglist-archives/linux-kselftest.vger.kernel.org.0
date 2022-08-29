Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4305A4046
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 02:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiH2AKN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 Aug 2022 20:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiH2AKI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 Aug 2022 20:10:08 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0AB1FCE2;
        Sun, 28 Aug 2022 17:10:03 -0700 (PDT)
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mx0.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4MG9mp4sF9zDrP4;
        Mon, 29 Aug 2022 00:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1661731802; bh=f4+prBiGFgdsfKSr1oPKSV/k0Dk38ybPDQ/q4E5A+E8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+iXiOZO2DwIGR/PO2Cy5Y/sBvsQsOJqGdkc/XAR7LOARQ5YHf/AWCcuclpTBKuJ+
         mWVhAhp9I5trtfyvGjwlMrTy9to+JLXo6vkZGCaZedyIHT9E9rQg9kgRfE5Q3KFkfR
         g6bjN+eQZ/G/182D3lj3EnWZNNQA7KmiO2KIahzk=
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4MG9mj6h4Hz9st8;
        Mon, 29 Aug 2022 00:09:57 +0000 (UTC)
X-Riseup-User-ID: 273D4EC73442C7EBCDD9757B70B29BC09C9B5794DDD05F577B1F011D24FD1BAF
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4MG9mc50g1z5vTc;
        Mon, 29 Aug 2022 00:09:52 +0000 (UTC)
From:   Isabella Basso <isabbasso@riseup.net>
To:     igt-dev@lists.freedesktop.org
Cc:     magalilemes00@gmail.com, maira.canal@usp.br,
        tales.aparecida@gmail.com, rodrigo.siqueira@amd.com,
        mwen@igalia.com, andrealmeid@riseup.net, twoerner@gmail.com,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        kunit-dev@googlegroups.com, davidgow@google.com,
        dlatypov@google.com, brendanhiggins@google.com, daniel@ffwll.ch,
        skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel@fooishbar.org,
        linux-kernel@vger.kernel.org, Isabella Basso <isabbasso@riseup.net>
Subject: [PATCH i-g-t v2 3/4] lib/igt_kmod: add compatibility for KUnit
Date:   Sun, 28 Aug 2022 21:09:19 -0300
Message-Id: <20220829000920.38185-4-isabbasso@riseup.net>
In-Reply-To: <20220829000920.38185-1-isabbasso@riseup.net>
References: <20220829000920.38185-1-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds functions for both executing the tests as well as parsing (K)TAP
kmsg output, as per the KTAP spec [1].

[1] https://www.kernel.org/doc/html/latest/dev-tools/ktap.html

Signed-off-by: Isabella Basso <isabbasso@riseup.net>
---
 lib/igt_kmod.c | 290 +++++++++++++++++++++++++++++++++++++++++++++++++
 lib/igt_kmod.h |   2 +
 2 files changed, 292 insertions(+)

diff --git a/lib/igt_kmod.c b/lib/igt_kmod.c
index 97cac7f5..93cdfcc5 100644
--- a/lib/igt_kmod.c
+++ b/lib/igt_kmod.c
@@ -25,6 +25,7 @@
 #include <signal.h>
 #include <errno.h>
 #include <sys/utsname.h>
+#include <limits.h>
 
 #include "igt_aux.h"
 #include "igt_core.h"
@@ -32,6 +33,8 @@
 #include "igt_sysfs.h"
 #include "igt_taints.h"
 
+#define BUF_LEN 4096
+
 /**
  * SECTION:igt_kmod
  * @short_description: Wrappers around libkmod for module loading/unloading
@@ -713,6 +716,293 @@ void igt_kselftest_get_tests(struct kmod_module *kmod,
 	kmod_module_info_free_list(pre);
 }
 
+/**
+ * lookup_value:
+ * @haystack: the string to search in
+ * @needle: the string to search for
+ *
+ * Returns: the value of the needle in the haystack, or -1 if not found.
+ */
+static long lookup_value(const char *haystack, const char *needle)
+{
+	const char *needle_rptr;
+	char *needle_end;
+	long num;
+
+	needle_rptr = strcasestr(haystack, needle);
+
+	if (needle_rptr == NULL)
+		return -1;
+
+	/* skip search string and whitespaces after it */
+	needle_rptr += strlen(needle);
+
+	num = strtol(needle_rptr, &needle_end, 10);
+
+	if (needle_rptr == needle_end)
+		return -1;
+
+	if (num == LONG_MIN || num == LONG_MAX)
+		return 0;
+
+	return num > 0 ? num : 0;
+}
+
+static int find_next_tap_subtest(char *record, char *test_name,
+				 bool is_subtest)
+{
+	const char *name_lookup_str,
+	      *lend, *version_rptr, *name_rptr;
+	long test_count;
+
+	name_lookup_str = "test: ";
+
+	version_rptr = strcasestr(record, "TAP version ");
+	name_rptr = strcasestr(record, name_lookup_str);
+
+	/*
+	 * total test count will almost always appear as 0..N at the beginning
+	 * of a run, so we use it as indication of a run
+	 */
+	test_count = lookup_value(record, "..");
+
+	/* no count found, so this is probably not starting a (sub)test */
+	if (test_count < 0) {
+		if (name_rptr != NULL) {
+			if (test_name[0] == '\0')
+				strncpy(test_name,
+					name_rptr + strlen(name_lookup_str),
+					BUF_LEN);
+			else if (strcmp(test_name, name_rptr + strlen(name_lookup_str)) == 0)
+				return 0;
+			else
+				test_name[0] = '\0';
+
+		}
+		return -1;
+	}
+
+	/*
+	 * "(K)TAP version XX" should be the first line on all (sub)tests as per
+	 * https://www.kernel.org/doc/html/latest/dev-tools/ktap.html#version-lines
+	 * but actually isn't, as it currently depends on whoever writes the
+	 * test to print this info
+	 */
+	if (version_rptr == NULL)
+		igt_info("Missing test version string\n");
+
+	if (name_rptr == NULL) {
+		/* we have to keep track of the name string, as it might be
+		 * contained in a line read previously */
+		if (test_name[0] == '\0') {
+			igt_info("Missing test name string\n");
+
+			if (is_subtest)
+				igt_info("Running %ld subtests...\n", test_count);
+			else
+				igt_info("Running %ld tests...\n", test_count);
+		} else {
+			lend = strchrnul(test_name, '\n');
+
+			if (*lend == '\0') {
+				if (is_subtest)
+					igt_info("Executing %ld subtests in: %s\n",
+						 test_count, test_name);
+				else
+					igt_info("Executing %ld tests in: %s\n",
+						 test_count, test_name);
+				return test_count;
+			}
+
+			if (is_subtest)
+				igt_info("Executing %ld subtests in: %.*s\n",
+					 test_count, (int)(lend - test_name),
+					 test_name);
+			else
+				igt_info("Executing %ld tests in: %.*s\n",
+					 test_count, (int)(lend - test_name),
+					 test_name);
+			test_name[0] = '\0';
+		}
+	} else {
+		name_rptr += strlen(name_lookup_str);
+		lend = strchrnul(name_rptr, '\n');
+		/*
+		 * as the test count comes after the test name we need not check
+		 * for a long line again
+		 */
+		if (is_subtest)
+			igt_info("Executing %ld subtests in: %.*s\n",
+				 test_count, (int)(lend - name_rptr),
+				 name_rptr);
+		else
+			igt_info("Executing %ld tests in: %.*s\n",
+				 test_count, (int)(lend - name_rptr),
+				 name_rptr);
+	}
+
+	return test_count;
+}
+
+static void parse_kmsg_for_tap(const char *lstart, char *lend,
+			       int *sublevel, bool *failed_tests)
+{
+	const char *nok_rptr, *comment_start, *value_parse_start;
+
+	nok_rptr = strstr(lstart, "not ok ");
+	if (nok_rptr != NULL) {
+		igt_warn("kmsg> %.*s\n",
+			 (int)(lend - lstart), lstart);
+		*failed_tests = true;
+		return;
+	}
+
+	comment_start = strchrnul(lstart, '#');
+
+	/* check if we're still in a subtest */
+	if (*comment_start != '\0') {
+		comment_start++;
+		value_parse_start = comment_start;
+
+		if (lookup_value(value_parse_start, "fail: ") > 0) {
+			igt_warn("kmsg> %.*s\n",
+				 (int)(lend - comment_start), comment_start);
+			*failed_tests = true;
+			(*sublevel)--;
+			return;
+		}
+	}
+
+	igt_info("kmsg> %.*s\n",
+		 (int)(lend - lstart), lstart);
+}
+
+static void igt_kunit_subtests(int fd, char *record,
+			       int *sublevel, bool *failed_tests)
+{
+	char test_name[BUF_LEN + 1], *lend;
+
+	lend = NULL;
+	test_name[0] = '\0';
+	test_name[BUF_LEN] = '\0';
+
+	while (*sublevel >= 0) {
+		const char *lstart;
+		ssize_t r;
+
+		if (lend != NULL && *lend != '\0')
+			lseek(fd, (int) (lend - record), SEEK_CUR);
+
+		r = read(fd, record, BUF_LEN);
+
+		if (r <= 0) {
+			switch (errno) {
+			case EINTR:
+				continue;
+			case EPIPE:
+				igt_warn("kmsg truncated: too many messages. \
+					 You may want to increase log_buf_len \
+					 in your boot options\n");
+				continue;
+			case !EAGAIN:
+				igt_warn("kmsg truncated: unknown error (%m)\n");
+				*sublevel = -1;
+			default:
+				break;
+			}
+			break;
+		}
+
+		lend = strchrnul(record, '\n');
+
+		/* in case line > 4096 */
+		if (*lend == '\0')
+			continue;
+
+		if (find_next_tap_subtest(record, test_name, *sublevel > 0) != -1)
+			(*sublevel)++;
+
+		if (*sublevel > 0) {
+			lstart = strchrnul(record, ';');
+
+			if (*lstart == '\0') {
+				igt_warn("kmsg truncated: output malformed (%m)\n");
+				igt_fail(IGT_EXIT_FAILURE);
+			}
+
+			lstart++;
+			while (isspace(*lstart))
+				lstart++;
+
+			parse_kmsg_for_tap(lstart, lend, sublevel, failed_tests);
+		}
+	}
+
+	if (*failed_tests || *sublevel < 0)
+		igt_fail(IGT_EXIT_FAILURE);
+	else
+		igt_success();
+}
+
+/**
+ * igt_kunit:
+ * @module_name: the name of the module
+ * @opts: options to load the module
+ *
+ * Loads the kunit module, parses its dmesg output, then unloads it
+ */
+void igt_kunit(const char *module_name, const char *opts)
+{
+	struct igt_ktest tst;
+	char record[BUF_LEN + 1];
+	bool failed_tests = false;
+	int sublevel = 0;
+
+	record[BUF_LEN] = '\0';
+
+	/* get normalized module name */
+	if (igt_ktest_init(&tst, module_name) != 0) {
+		igt_warn("Unable to initialize ktest for %s\n", module_name);
+		return;
+	}
+
+	if (igt_ktest_begin(&tst) != 0) {
+		igt_warn("Unable to begin ktest for %s\n", module_name);
+
+		igt_ktest_fini(&tst);
+		return;
+	}
+
+	if (tst.kmsg < 0) {
+		igt_warn("Could not open /dev/kmsg");
+		goto unload;
+	}
+
+	if (lseek(tst.kmsg, 0, SEEK_END)) {
+		igt_warn("Could not seek the end of /dev/kmsg");
+		goto unload;
+	}
+
+	/* The kunit module is required for running any kunit tests */
+	if (igt_kmod_load("kunit", NULL) != 0) {
+		igt_warn("Unable to load kunit module\n");
+		goto unload;
+	}
+
+	if (igt_kmod_load(module_name, opts) != 0) {
+		igt_warn("Unable to load %s module\n", module_name);
+		goto unload;
+	}
+
+	igt_kunit_subtests(tst.kmsg, record, &sublevel, &failed_tests);
+unload:
+	igt_kmod_unload("kunit", 0);
+
+	igt_ktest_end(&tst);
+
+	igt_ktest_fini(&tst);
+}
+
 static int open_parameters(const char *module_name)
 {
 	char path[256];
diff --git a/lib/igt_kmod.h b/lib/igt_kmod.h
index ceb10cd0..737143c1 100644
--- a/lib/igt_kmod.h
+++ b/lib/igt_kmod.h
@@ -45,6 +45,8 @@ int __igt_i915_driver_unload(char **whom);
 int igt_amdgpu_driver_load(const char *opts);
 int igt_amdgpu_driver_unload(void);
 
+void igt_kunit(const char *module_name, const char *opts);
+
 void igt_kselftests(const char *module_name,
 		    const char *module_options,
 		    const char *result_option,
-- 
2.37.2

