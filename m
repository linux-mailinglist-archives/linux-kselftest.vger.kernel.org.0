Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A918A79284E
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 18:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239189AbjIEQH1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 12:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354754AbjIEOFW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 10:05:22 -0400
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F9F1A6
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Sep 2023 07:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1693922711;
        bh=8KlD3VW8L/5ayf8Ou0ZPfzGKalOanhbYs3ssojj7Rzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LdVlag21s+/faTL1akapXYiZja4GG2XtDEo/qT8ygWc1hYPXmDbomZTX/1SqGEdAm
         1faIpbJ6D99z6I3eyi78bGWA9Jq8nOgSsbiwIz3xMkyYuvRvFtvDXNYuKBuJjIf8ry
         j71sRqHv8E65mEMHc6/VFQeqVYZGeY8FUPOnUtwU=
Received: from rtoax.lan ([120.245.114.157])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 12C80033; Tue, 05 Sep 2023 22:04:44 +0800
X-QQ-mid: xmsmtpt1693922699t0dv0dw9r
Message-ID: <tencent_B44B7295FED7E0D11EC445032021F2AC8107@qq.com>
X-QQ-XMAILINFO: OUMxvQDaATieCv4GzYM8TxrYu4PTLFyfFshfV5c5Zjsi/jYVNr1yaBkldHod6j
         lYb/2nctmJPtCLSeVterfhWNKVaSC1Hw1IXm43J7JQKHcZIHEC9/ml08GA/RSOOeoNzFyUEefE+G
         EcbQwZL+CtmgWlY1tjnHgI5jqlM7igrBcNXLotQDNdy5OzBrGYwgf6k4JeyF0ecgqV+DhVnSHl5n
         6W7lM0BN4e/QdFYJ7r1V1lLKkjc6iKJeGKMpY9v09jTX2frjav0WIJUBfJyoVLqewoumV1fFJ9f0
         BjCrtVPjE5S7tYSI4mPRBc/ikuw021AYVYfeWA6r04p0/3j06WyA7o2pFG8yxA59plf/l2eucODK
         6An1iUGxxsciTjCmIRqwtTpOuHyAxgB/cCJR1D7wghzgtsNhRG/9BGUCsJ+iYwXWxJOpJB7EEHNT
         bUE7o/v/mPmH+2UZHR+zKDSEbHXdjX8fNHF77RXU0cTe17g/AdlYz8YSzIWzI4TnKHWMPtNYiJLo
         Z70i7AQlD+Us/ppjvPnz+OeSH24eMqUwPpqUhQRNYv3VXA9CpN9Ie2nslF7+YHK1b7pHHAHDtDUp
         OIH0ODulB6EktMufPvGYl1gni9Sfi0K7YQAJ8IdzEO30axwlkYFhuwzmHrYattgHmdWqYe5sQoYg
         6DyVDjIWY8VMSjs693sQJG7Z8z6Yoj3PHu3CbkERAE5/kQbR4E/DcVbBIT8E70up71mZ+YWjGbvt
         eFexZLgVTmf2sr5VSQwAji+5jgtjLwWQUM4z4x3XU3O7/uHtHluy+nxAU8doCLvYhrV8ejNAdD/2
         BFafAQZYJqO1AGuvtio+OjbA6aIfOEdV372IlMFvxpQRrx3TNbvGho+r3bZSu1KTB/6aewSIrVDj
         EiUd3ONBwTPXksWhId9V1Yqb+holqTA+CJglFgFPvsa/YQOw318nFbLHlFnlGX0mAXLOoIrTzaGt
         yf2hthNx0TYpClbb7kny+hHDO2iXTLOlYdc9Gf2FjBdZXYmGbooTzu+Kl02Wwc
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From:   Rong Tao <rtoax@foxmail.com>
To:     olsajiri@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
        sdf@google.com
Cc:     Rong Tao <rongtao@cestc.cn>, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and
        Tools)), linux-kernel@vger.kernel.org (open list),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE)
Subject: [PATCH bpf-next v11 2/2] selftests/bpf: trace_helpers.c: Add a global ksyms initialization mutex
Date:   Tue,  5 Sep 2023 22:04:19 +0800
X-OQ-MSGID: <b554ee17328a8bab6a815d1d3b8e7ecf6124cc68.1693922135.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693922135.git.rongtao@cestc.cn>
References: <cover.1693922135.git.rongtao@cestc.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

As Jirka said [0], we just need to make sure that global ksyms
initialization won't race.

[0] https://lore.kernel.org/lkml/ZPCbAs3ItjRd8XVh@krava/

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/testing/selftests/bpf/trace_helpers.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 7d026c128252..411f87d5aac7 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -7,6 +7,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <poll.h>
+#include <pthread.h>
 #include <unistd.h>
 #include <linux/perf_event.h>
 #include <sys/mman.h>
@@ -26,6 +27,7 @@ struct ksyms {
 };
 
 static struct ksyms *ksyms;
+static pthread_mutex_t ksyms_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 static int ksyms__add_symbol(struct ksyms *ksyms, const char *name,
 			     unsigned long addr)
@@ -110,8 +112,10 @@ struct ksyms *load_kallsyms_local(struct ksyms *ksyms)
 
 int load_kallsyms(void)
 {
+	pthread_mutex_lock(&ksyms_mutex);
 	if (!ksyms)
 		ksyms = load_kallsyms_local(NULL);
+	pthread_mutex_unlock(&ksyms_mutex);
 	return ksyms ? 0 : 1;
 }
 
-- 
2.41.0

