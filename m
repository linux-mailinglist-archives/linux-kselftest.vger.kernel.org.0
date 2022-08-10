Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CF058F0DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 18:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbiHJQ7y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Aug 2022 12:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiHJQ7x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Aug 2022 12:59:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0B132BBE;
        Wed, 10 Aug 2022 09:59:51 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M2x4d5SC8z67jRt;
        Thu, 11 Aug 2022 00:59:45 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 10 Aug 2022 18:59:48 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <corbet@lwn.net>,
        <dhowells@redhat.com>, <jarkko@kernel.org>, <rostedt@goodmis.org>,
        <mingo@redhat.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <shuah@kernel.org>
CC:     <bpf@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v10 1/9] bpf: Allow kfuncs to be used in LSM programs
Date:   Wed, 10 Aug 2022 18:59:24 +0200
Message-ID: <20220810165932.2143413-2-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810165932.2143413-1-roberto.sassu@huawei.com>
References: <20220810165932.2143413-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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

From: KP Singh <kpsingh@kernel.org>

In preparation for the addition of new kfuncs, allow kfuncs defined in the
tracing subsystem to be used in LSM programs by mapping the LSM program
type to the TRACING hook.

Signed-off-by: KP Singh <kpsingh@kernel.org>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 kernel/bpf/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 903719b89238..e49b3b6d48ad 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7243,6 +7243,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 	case BPF_PROG_TYPE_STRUCT_OPS:
 		return BTF_KFUNC_HOOK_STRUCT_OPS;
 	case BPF_PROG_TYPE_TRACING:
+	case BPF_PROG_TYPE_LSM:
 		return BTF_KFUNC_HOOK_TRACING;
 	case BPF_PROG_TYPE_SYSCALL:
 		return BTF_KFUNC_HOOK_SYSCALL;
-- 
2.25.1

