Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECC8C8AF76
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 08:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfHMGL0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 02:11:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58794 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfHMGLZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 02:11:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D68qma039301;
        Tue, 13 Aug 2019 06:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=Uy/BMiU/6+cWYwyuGulp2z1PvG2gjuEr4h5V5AOFnps=;
 b=bseU9hdVmB1A+Dk0d5EgItfE7Bqp6KFA0P5q2Ti0ZdmhBaBM7sd9z+8V8odxDX3t99o0
 QFzmuKVv1TOjCmFHJlV09W+OdFFzPRrkUG7CQhBK6FWaBKNSts0XtX4Ff/735efVONc0
 2BgPL3ENvQQSK2N8pPV9gG/SPdMIrGH627ux5ZImBz40p8EHwvI6hgiT5ZzYO85HqJiT
 G7PHNX3gUvji4nWjny/XSq8A7UUet/kLSUVVqlcXCxMKiQDYlN8MtlLidZlNF4rrYUa5
 EjI7vHoRs7gql8mltjSsLqfB25V+vbDlzot5Kl0ypfH+Vzh0eA47vihvJvcp7ERyUUuJ Kg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=Uy/BMiU/6+cWYwyuGulp2z1PvG2gjuEr4h5V5AOFnps=;
 b=f4LOi+gT1LbC4u+uMdpH+QRodUD4BB8Ss1ST/KzYabW4UZElZLcSbCe0M94B/uvtOXl3
 NJnlWXWuWYiciU6BCkGQPtaeFOG+4gKu5U00nYijXsHXVFsQUiY55wDfVjs1O7Ca0Wag
 zvwmopqO2LWKdUm5Yd0tBD+glqmSq8s23HrsTZCu8iifOPfhwe80fDi7fbVCwcgN4Uaf
 wsh0VVSA+iO4w8RN6c1UmeFdWiqyHDQFdTi4BIW0UXK7vnM/plQKI7hwOhEKI5OpbfYN
 A19lWWfwmY1jZLpACUSPsowNVhyzbpPGvCc6iU2jLU+Rd01sMV0JKPUbaetEqJgTdps0 pQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2u9nvp41a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D67SsC157036;
        Tue, 13 Aug 2019 06:11:03 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2u9nrenkff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:03 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7D6B23C026398;
        Tue, 13 Aug 2019 06:11:02 GMT
Received: from abi.no.oracle.com (/10.172.144.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Aug 2019 23:11:01 -0700
From:   Knut Omang <knut.omang@oracle.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Hidenori Yamaji <hidenori.yamaji@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Subject: [RFC 03/19] ktf: Introduce a generic netlink protocol for test result communication
Date:   Tue, 13 Aug 2019 08:09:18 +0200
Message-Id: <a29b3d27234a7ad3f5d6f7571d08167077dc0350.1565676440.git-series.knut.omang@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908130067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908130067
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The generic netlink protocol used to communicate between
kernel and user space about tests and test results, as well as some
means for configuring tests within the kernel.

Unlike other kernel side test code in the kernel, ktf does not print
anything from inside the kernel (except for optional debugging
features to help "internal" debugging of ktf or ktf tests).
Instead all test results are communicated back to the user space
frontend, which decides how to do the reporting.

ktf_nl.c:        ktf netlink protocol implementation
ktf_unlproto.h:  implements interfaces for user-kernel netlink interactions

Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 tools/testing/selftests/ktf/kernel/ktf_nl.c       | 516 +++++++++++++++-
 tools/testing/selftests/ktf/kernel/ktf_nl.h       |  15 +-
 tools/testing/selftests/ktf/kernel/ktf_unlproto.h | 105 +++-
 3 files changed, 636 insertions(+)
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_nl.c
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_nl.h
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_unlproto.h

diff --git a/tools/testing/selftests/ktf/kernel/ktf_nl.c b/tools/testing/selftests/ktf/kernel/ktf_nl.c
new file mode 100644
index 0000000..56d5f3b
--- /dev/null
+++ b/tools/testing/selftests/ktf/kernel/ktf_nl.c
@@ -0,0 +1,516 @@
+/*
+ * Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
+ *    Author: Knut Omang <knut.omang@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * ktf_nl.c: ktf netlink protocol implementation
+ */
+#include <linux/version.h>
+#include <net/netlink.h>
+#include <net/genetlink.h>
+#define NL_INTERNAL 1
+#include "ktf_unlproto.h"
+#include "ktf_test.h"
+#include "ktf_nl.h"
+#include "ktf.h"
+#include "ktf_cov.h"
+
+/* Generic netlink support to communicate with user level
+ * test framework.
+ */
+
+/* Callback functions defined below */
+static int ktf_run(struct sk_buff *skb, struct genl_info *info);
+static int ktf_query(struct sk_buff *skb, struct genl_info *info);
+static int ktf_req(struct sk_buff *skb, struct genl_info *info);
+static int ktf_resp(struct sk_buff *skb, struct genl_info *info);
+static int ktf_cov_cmd(enum ktf_cmd_type type, struct sk_buff *skb,
+		       struct genl_info *info);
+static int ktf_ctx_cfg(struct sk_buff *skb, struct genl_info *info);
+static int send_version_only(struct sk_buff *skb, struct genl_info *info);
+
+/* operation definition */
+static struct genl_ops ktf_ops[] = {
+	{
+		.cmd = KTF_C_REQ,
+		.flags = 0,
+		.doit = ktf_req,
+		.dumpit = NULL,
+	},
+	{
+		.cmd = KTF_C_RESP,
+		.flags = 0,
+		.doit = ktf_resp,
+		.dumpit = NULL,
+	}
+};
+
+/* family definition */
+static struct genl_family ktf_gnl_family = {
+	.module = THIS_MODULE,
+	.hdrsize = 0,
+	.name = "ktf",
+	.version = 1,
+	.maxattr = KTF_A_MAX + 4,
+	.policy = ktf_gnl_policy,
+	.ops = ktf_ops,
+	.n_ops = ARRAY_SIZE(ktf_ops),
+};
+
+/* handler, returns 0 on success, negative
+ * values on failure. It doesn't make much difference
+ * what error values are used, as they are anyway discarded
+ * at the netlink level, but do result in a nonzero return
+ * from nl_wait_for_ack() in user space.
+ */
+static int ktf_req(struct sk_buff *skb, struct genl_info *info)
+{
+	enum ktf_cmd_type type;
+	u64 version;
+
+	/* Dispatch on type of request */
+
+	if (!info->attrs[KTF_A_TYPE] || !info->attrs[KTF_A_VERSION]) {
+		terr("received netlink msg with no type/version!");
+		return -EINVAL;
+	}
+
+	version = nla_get_u64(info->attrs[KTF_A_VERSION]);
+	if (ktf_version_check(version)) {
+		/* a query is the first call for any reasonable application:
+		 * Respond to it with a version only:
+		 */
+		if (nla_get_u32(info->attrs[KTF_A_TYPE]) == KTF_CT_QUERY)
+			return send_version_only(skb, info);
+		return -EINVAL;
+	}
+
+	type = nla_get_u32(info->attrs[KTF_A_TYPE]);
+	switch (type) {
+	case KTF_CT_QUERY:
+		return ktf_query(skb, info);
+	case KTF_CT_RUN:
+		return ktf_run(skb, info);
+	case KTF_CT_COV_ENABLE:
+	case KTF_CT_COV_DISABLE:
+		return ktf_cov_cmd(type, skb, info);
+	case KTF_CT_CTX_CFG:
+		return ktf_ctx_cfg(skb, info);
+	default:
+		terr("received netlink msg with invalid type (%d)", type);
+	}
+	return -EINVAL;
+}
+
+/* Reply with just version information to let user space report the issue: */
+static int send_version_only(struct sk_buff *skb, struct genl_info *info)
+{
+	struct sk_buff *resp_skb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	void *data;
+	int retval = 0;
+
+	if (!resp_skb)
+		return -ENOMEM;
+	data = genlmsg_put_reply(resp_skb, info, &ktf_gnl_family,
+				 0, KTF_C_RESP);
+	if (!data) {
+		retval = -ENOMEM;
+		goto resp_failure;
+	}
+	nla_put_u32(resp_skb, KTF_A_TYPE, KTF_CT_QUERY);
+	nla_put_u64_64bit(resp_skb, KTF_A_VERSION, KTF_VERSION_LATEST, 0);
+
+	/* Recompute message header */
+	genlmsg_end(resp_skb, data);
+
+	retval = genlmsg_reply(resp_skb, info);
+resp_failure:
+	/* Free buffer if failure */
+	if (retval)
+		nlmsg_free(resp_skb);
+	return retval;
+}
+
+/* Send data about one testcase */
+static int send_test_data(struct sk_buff *resp_skb, struct ktf_case *tc)
+{
+	struct nlattr *nest_attr;
+	struct ktf_test *t;
+	int stat;
+	int cnt = 0;
+
+	stat = nla_put_string(resp_skb, KTF_A_STR, ktf_case_name(tc));
+	if (stat)
+		return stat;
+
+	nest_attr = nla_nest_start(resp_skb, KTF_A_TEST);
+	ktf_testcase_for_each_test(t, tc) {
+		cnt++;
+		/* A test is not valid if the handle requires a context and none is present */
+		if (t->handle->id) {
+			stat = nla_put_u32(resp_skb, KTF_A_HID, t->handle->id);
+			if (stat)
+				goto fail;
+		} else if (t->handle->require_context) {
+			continue;
+		}
+		stat = nla_put_string(resp_skb, KTF_A_STR, t->name);
+		if (stat)
+			goto fail;
+	}
+	nla_nest_end(resp_skb, nest_attr);
+	tlog(T_DEBUG, "Sent data about %d tests", cnt);
+	return 0;
+fail:
+	twarn("Failed with status %d after sending data about %d tests", stat, cnt);
+	/* we hold reference to t here - drop it! */
+	ktf_test_put(t);
+	return stat;
+}
+
+static int send_handle_data(struct sk_buff *resp_skb, struct ktf_handle *handle)
+{
+	struct ktf_context_type *ct;
+	struct nlattr *nest_attr;
+	struct ktf_context *ctx;
+	int stat;
+
+	tlog(T_DEBUG, "Sending context handle %d: ", handle->id);
+
+	/* Send HID */
+	stat = nla_put_u32(resp_skb, KTF_A_HID, handle->id);
+	if (stat)
+		return stat;
+
+	/* Send contexts */
+	nest_attr = nla_nest_start(resp_skb, KTF_A_LIST);
+	if (!nest_attr)
+		return -ENOMEM;
+
+	tlog(T_DEBUG, "Sending context type list");
+	/* Send any context types that user space are allowed to create contexts for */
+	ktf_map_for_each_entry(ct, &handle->ctx_type_map, elem) {
+		if (ct->alloc) {
+			stat = nla_put_string(resp_skb, KTF_A_FILE, ct->name);
+			if (stat)
+				return -ENOMEM;
+		}
+	}
+
+	/* Then send all the contexts themselves */
+	ctx = ktf_find_first_context(handle);
+	while (ctx) {
+		nla_put_string(resp_skb, KTF_A_STR, ktf_context_name(ctx));
+		if (ctx->config_cb) {
+			stat = nla_put_string(resp_skb, KTF_A_MOD, ctx->type->name);
+			if (stat)
+				return stat;
+			stat = nla_put_u32(resp_skb, KTF_A_STAT, ctx->config_errno);
+			if (stat)
+				return stat;
+		}
+		ctx = ktf_find_next_context(ctx);
+	}
+	nla_nest_end(resp_skb, nest_attr);
+	return 0;
+}
+
+static int ktf_query(struct sk_buff *skb, struct genl_info *info)
+{
+	struct sk_buff *resp_skb;
+	void *data;
+	int retval = 0;
+	struct nlattr *nest_attr;
+	struct ktf_handle *handle;
+	struct ktf_case *tc;
+
+	/* No options yet, just send a response */
+	resp_skb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!resp_skb)
+		return -ENOMEM;
+
+	data = genlmsg_put_reply(resp_skb, info, &ktf_gnl_family,
+				 0, KTF_C_RESP);
+	if (!data) {
+		retval = -ENOMEM;
+		goto resp_failure;
+	}
+
+	nla_put_u64_64bit(resp_skb, KTF_A_VERSION, KTF_VERSION_LATEST, 0);
+
+	/* Add all test sets to the report
+	 *  We send test info as follows:
+	 *    KTF_CT_QUERY hid1 [context1 [context2 ...]] hid2 [context1 [context2 ...]]
+	 *                   testset_num [testset1 [name1 name2 ..] testset2 [name1 name2 ..]]
+	 *  Handle IDs without contexts are not present
+	 */
+	if (!nla_put_u32(resp_skb, KTF_A_TYPE, KTF_CT_QUERY)) {
+		if (!list_empty(&context_handles)) {
+			/* Traverse list of handles with contexts */
+			nest_attr = nla_nest_start(resp_skb, KTF_A_HLIST);
+			list_for_each_entry(handle, &context_handles, handle_list) {
+				retval = send_handle_data(resp_skb, handle);
+				if (retval)
+					goto resp_failure;
+			}
+			nla_nest_end(resp_skb, nest_attr);
+		}
+
+		/* Send total number of tests */
+		tlog(T_DEBUG, "Total #of test cases: %ld", ktf_case_count());
+		nla_put_u32(resp_skb, KTF_A_NUM, ktf_case_count());
+		nest_attr = nla_nest_start(resp_skb, KTF_A_LIST);
+		if (!nest_attr) {
+			retval = -ENOMEM;
+			goto resp_failure;
+		}
+		ktf_for_each_testcase(tc) {
+			retval = send_test_data(resp_skb, tc);
+			if (retval) {
+				retval = -ENOMEM;
+				goto resp_failure;
+			}
+		}
+		nla_nest_end(resp_skb, nest_attr);
+	}
+
+	/* Recompute message header */
+	genlmsg_end(resp_skb, data);
+
+	retval = genlmsg_reply(resp_skb, info);
+resp_failure:
+	if (retval)
+		twarn("Message failure (status %d)", retval);
+	/* Free buffer if failure */
+	if (retval)
+		nlmsg_free(resp_skb);
+	return retval;
+}
+
+static int ktf_run_func(struct sk_buff *skb, const char *ctxname,
+			const char *setname, const char *testname,
+			u32 value, void *oob_data, size_t oob_data_sz)
+{
+	struct ktf_case *testset = ktf_case_find(setname);
+	struct ktf_test *t;
+	int tn = 0;
+
+	if (!testset) {
+		tlog(T_INFO, "No such testset \"%s\"\n", setname);
+		return -EFAULT;
+	}
+
+	/* Execute test functions */
+	ktf_testcase_for_each_test(t, testset) {
+		if (t->fun && strcmp(t->name, testname) == 0) {
+			struct ktf_context *ctx = ktf_find_context(t->handle, ctxname);
+
+			ktf_run_hook(skb, ctx, t, value, oob_data, oob_data_sz);
+		} else if (!t->fun) {
+			tlog(T_DEBUG, "** no function for test %s.%s **", t->tclass, t->name);
+		}
+		tn++;
+	}
+	tlog(T_DEBUG, "Set %s contained %d tests", ktf_case_name(testset), tn);
+	ktf_case_put(testset);
+	return 0;
+}
+
+static int ktf_run(struct sk_buff *skb, struct genl_info *info)
+{
+	u32 value = 0;
+	struct sk_buff *resp_skb;
+	void *data;
+	int retval = 0;
+	struct nlattr *nest_attr, *data_attr;
+	char ctxname_store[KTF_MAX_NAME + 1];
+	char *ctxname = ctxname_store;
+	char setname[KTF_MAX_NAME + 1];
+	char testname[KTF_MAX_NAME + 1];
+	void *oob_data = NULL;
+	size_t oob_data_sz = 0;
+
+	if (info->attrs[KTF_A_STR])
+		nla_strlcpy(ctxname, info->attrs[KTF_A_STR], KTF_MAX_NAME);
+	else
+		ctxname = NULL;
+
+	if (!info->attrs[KTF_A_SNAM])	{
+		terr("received KTF_CT_RUN msg without testset name!");
+		return -EINVAL;
+	}
+	nla_strlcpy(setname, info->attrs[KTF_A_SNAM], KTF_MAX_NAME);
+
+	if (!info->attrs[KTF_A_TNAM])	{  /* Test name wo/context */
+		terr("received KTF_CT_RUN msg without test name!");
+		return -EINVAL;
+	}
+	nla_strlcpy(testname, info->attrs[KTF_A_TNAM], KTF_MAX_NAME);
+
+	if (info->attrs[KTF_A_NUM])	{
+		/* Using NUM field as optional u32 input parameter to test */
+		value = nla_get_u32(info->attrs[KTF_A_NUM]);
+	}
+
+	data_attr = info->attrs[KTF_A_DATA];
+	if (data_attr)	{
+		/* User space sends out-of-band data: */
+		oob_data = nla_memdup(data_attr, GFP_KERNEL);
+		oob_data_sz = nla_len(data_attr);
+	}
+
+	tlog(T_DEBUG, "Request for testset %s, test %s\n", setname, testname);
+
+	/* Start building a response */
+	resp_skb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!resp_skb)
+		return -ENOMEM;
+
+	data = genlmsg_put_reply(resp_skb, info, &ktf_gnl_family,
+				 0, KTF_C_RESP);
+	if (!data) {
+		retval = -ENOMEM;
+		goto put_fail;
+	}
+
+	nla_put_u32(resp_skb, KTF_A_TYPE, KTF_CT_RUN);
+	nest_attr = nla_nest_start(resp_skb, KTF_A_LIST);
+	retval = ktf_run_func(resp_skb, ctxname, setname, testname, value, oob_data, oob_data_sz);
+	nla_nest_end(resp_skb, nest_attr);
+	nla_put_u32(resp_skb, KTF_A_STAT, retval);
+
+	/* Recompute message header */
+	genlmsg_end(resp_skb, data);
+
+	retval = genlmsg_reply(resp_skb, info);
+	if (!retval)
+		tlog(T_DEBUG, "Sent reply for test %s.%s\n", setname, testname);
+	else
+		twarn("Failed to send reply for test %s.%s - value %d",
+		      setname, testname, retval);
+
+	kfree(oob_data);
+put_fail:
+	/* Free buffer if failure */
+	if (retval)
+		nlmsg_free(resp_skb);
+	return retval;
+}
+
+static int ktf_resp(struct sk_buff *skb, struct genl_info *info)
+{
+	/* not to expect this message here */
+	terr("unexpected netlink RESP msg received");
+	return 0;
+}
+
+static int ktf_cov_cmd(enum ktf_cmd_type type, struct sk_buff *skb,
+		       struct genl_info *info)
+{
+	char *cmd = type == KTF_CT_COV_ENABLE ? "COV_ENABLE" : "COV_DISABLE";
+	char module[KTF_MAX_NAME + 1];
+	struct sk_buff *resp_skb;
+	int retval = 0;
+	void *data;
+	u32 opts = 0;
+
+	if (!info->attrs[KTF_A_MOD])   {
+		terr("received KTF_CT_%s msg without module name!", cmd);
+		return -EINVAL;
+	}
+	nla_strlcpy(module, info->attrs[KTF_A_MOD], KTF_MAX_NAME);
+	if (info->attrs[KTF_A_COVOPT])
+		opts = nla_get_u32(info->attrs[KTF_A_COVOPT]);
+
+	/* Start building a response */
+	resp_skb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!resp_skb)
+		return -ENOMEM;
+
+	tlog(T_DEBUG, "%s coverage for %s\n", cmd, module);
+	if (type == KTF_CT_COV_ENABLE)
+		retval = ktf_cov_enable(module, opts);
+	else
+		ktf_cov_disable(module);
+
+	data = genlmsg_put_reply(resp_skb, info, &ktf_gnl_family,
+				 0, KTF_C_RESP);
+	if (!data) {
+		retval = -ENOMEM;
+		goto put_fail;
+	}
+	nla_put_u32(resp_skb, KTF_A_TYPE, type);
+	nla_put_u32(resp_skb, KTF_A_STAT, retval);
+	/* Recompute message header */
+	genlmsg_end(resp_skb, data);
+
+	retval = genlmsg_reply(resp_skb, info);
+	if (!retval)
+		tlog(T_DEBUG, "Sent reply for %s module %s\n",
+		     cmd, module);
+	else
+		twarn("Failed to send reply for %s module %s - value %d",
+		      cmd, module, retval);
+put_fail:
+	/* Free buffer if failure */
+	if (retval)
+		nlmsg_free(resp_skb);
+	return retval;
+}
+
+/* Process request to configure a configurable context:
+ * Expected format:  KTF_CT_CTX_CFG hid type_name context_name data
+ * placed in A_HID, A_FILE, A_STR and A_DATA respectively.
+ */
+static int ktf_ctx_cfg(struct sk_buff *skb, struct genl_info *info)
+{
+	char ctxname[KTF_MAX_NAME + 1];
+	char type_name[KTF_MAX_NAME + 1];
+	struct nlattr *data_attr;
+	void *ctx_data = NULL;
+	size_t ctx_data_sz = 0;
+	int hid;
+	struct ktf_handle *handle;
+	struct ktf_context *ctx;
+	int ret;
+
+	if (!info->attrs[KTF_A_STR] || !info->attrs[KTF_A_HID])
+		return -EINVAL;
+	data_attr = info->attrs[KTF_A_DATA];
+	if (!data_attr)
+		return -EINVAL;
+	hid = nla_get_u32(info->attrs[KTF_A_HID]);
+	handle = ktf_handle_find(hid);
+	if (!handle)
+		return -EINVAL;
+	if (info->attrs[KTF_A_FILE])
+		nla_strlcpy(type_name, info->attrs[KTF_A_FILE], KTF_MAX_NAME);
+	else
+		strcpy(type_name, "default");
+	nla_strlcpy(ctxname, info->attrs[KTF_A_STR], KTF_MAX_NAME);
+	tlog(T_DEBUG, "Trying to find/create context %s with type %s\n", ctxname, type_name);
+	ctx = ktf_find_create_context(handle, ctxname, type_name);
+	if (!ctx)
+		return -ENODEV;
+
+	tlog(T_DEBUG, "Received context configuration for context %s, handle %d\n",
+	     ctxname, hid);
+
+	ctx_data = nla_memdup(data_attr, GFP_KERNEL);
+	ctx_data_sz = nla_len(data_attr);
+	ret = ktf_context_set_config(ctx, ctx_data, ctx_data_sz);
+	kfree(ctx_data);
+	return ret;
+}
+
+int ktf_nl_register(void)
+{
+	int stat = genl_register_family(&ktf_gnl_family);
+	return stat;
+}
+
+void ktf_nl_unregister(void)
+{
+	genl_unregister_family(&ktf_gnl_family);
+}
diff --git a/tools/testing/selftests/ktf/kernel/ktf_nl.h b/tools/testing/selftests/ktf/kernel/ktf_nl.h
new file mode 100644
index 0000000..87d8012
--- /dev/null
+++ b/tools/testing/selftests/ktf/kernel/ktf_nl.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
+ *    Author: Knut Omang <knut.omang@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * nl.h: ktf netlink protocol interface
+ */
+#ifndef KTF_NL_H
+#define KTF_NL_H
+
+int ktf_nl_register(void);
+void ktf_nl_unregister(void);
+
+#endif
diff --git a/tools/testing/selftests/ktf/kernel/ktf_unlproto.h b/tools/testing/selftests/ktf/kernel/ktf_unlproto.h
new file mode 100644
index 0000000..e6d4525
--- /dev/null
+++ b/tools/testing/selftests/ktf/kernel/ktf_unlproto.h
@@ -0,0 +1,105 @@
+/*
+ * Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
+ *    Author: Knut Omang <knut.omang@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * ktf_unlproto.h: implements interfaces for user-kernel netlink interactions
+ *   for querying/running tests.
+ */
+#ifndef _KTF_UNLPROTO_H
+#define _KTF_UNLPROTO_H
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+enum ktf_cmd_type {
+	KTF_CT_UNSPEC,
+	KTF_CT_QUERY,
+	KTF_CT_RUN,
+	KTF_CT_COV_ENABLE,
+	KTF_CT_COV_DISABLE,
+	KTF_CT_CTX_CFG,
+	KTF_CT_MAX,
+};
+
+/* Netlink protocol definition shared between user and kernel space
+ * Include once per user app as it defines struct values!
+ */
+
+/* supported attributes */
+enum ktf_attr {
+	KTF_A_UNSPEC,
+	KTF_A_TYPE,
+	KTF_A_VERSION,
+	KTF_A_SNAM,   /* Test suite name */
+	KTF_A_TNAM,   /* Test name */
+	KTF_A_NUM,
+	KTF_A_STR,
+	KTF_A_FILE,
+	KTF_A_STAT,
+	KTF_A_LIST,
+	KTF_A_TEST,
+	KTF_A_HID,    /* Test handle ID */
+	KTF_A_HLIST,  /* List of handles repr. as a LIST of contexts for a given HID */
+	KTF_A_MOD,    /* module for coverage analysis, also used for context type */
+	KTF_A_COVOPT, /* options for coverage analysis */
+	KTF_A_DATA,   /* Binary data used by a.o. hybrid tests */
+	KTF_A_MAX
+};
+
+/* attribute policy */
+#ifdef NL_INTERNAL
+static struct nla_policy ktf_gnl_policy[KTF_A_MAX] = {
+	[KTF_A_TYPE]  = { .type = NLA_U32 },
+	[KTF_A_VERSION] = { .type = NLA_U64 },
+	[KTF_A_SNAM]  = { .type = NLA_STRING },
+	[KTF_A_TNAM]  = { .type = NLA_STRING },
+	[KTF_A_NUM]   = { .type = NLA_U32 },
+	[KTF_A_STAT]  = { .type = NLA_U32 },
+	[KTF_A_HID]   = { .type = NLA_U32 },
+	[KTF_A_LIST]  = { .type = NLA_NESTED },
+	[KTF_A_TEST]  = { .type = NLA_NESTED },
+	[KTF_A_HLIST] = { .type = NLA_NESTED },
+	[KTF_A_STR]   = { .type = NLA_STRING },
+	[KTF_A_FILE]  = { .type = NLA_STRING },
+	[KTF_A_MOD]   = { .type = NLA_STRING },
+	[KTF_A_COVOPT] = { .type = NLA_U32 },
+	[KTF_A_DATA] = { .type = NLA_BINARY },
+};
+#endif
+
+/* supported commands */
+enum ktf_cmd {
+	KTF_C_UNSPEC,
+	KTF_C_REQ,
+	KTF_C_RESP,
+	KTF_C_MAX
+};
+
+enum ktf_vshift {
+	KTF_VSHIFT_BUILD = 0,
+	KTF_VSHIFT_MICRO = 16,
+	KTF_VSHIFT_MINOR = 32,
+	KTF_VSHIFT_MAJOR = 48
+};
+
+#define KTF_VERSION(__field, __v) \
+	((__v & (0xffffULL << KTF_VSHIFT_##__field)) \
+	>> KTF_VSHIFT_##__field)
+
+#define KTF_VERSION_SET(__field, __v) \
+	((__v & 0xffffULL) << KTF_VSHIFT_##__field)
+
+#define	KTF_VERSION_LATEST	\
+	(KTF_VERSION_SET(MAJOR, 0ULL) | KTF_VERSION_SET(MINOR, 2ULL) | KTF_VERSION_SET(MICRO, 1ULL))
+
+/* Coverage options */
+#define	KTF_COV_OPT_MEM		0x1
+
+struct nla_policy *ktf_get_gnl_policy(void);
+
+#ifdef __cplusplus
+}
+#endif
+#endif
-- 
git-series 0.9.1
