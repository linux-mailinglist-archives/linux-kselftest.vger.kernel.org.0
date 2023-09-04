Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E430790F75
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 03:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjIDBCY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 Sep 2023 21:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbjIDBCX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 Sep 2023 21:02:23 -0400
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5750B106
        for <linux-kselftest@vger.kernel.org>; Sun,  3 Sep 2023 18:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1693789333;
        bh=VDeJU94IWnvseyKaMxC4IUln27g8AmHmoNXDqEplCe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=nnHqSdLwcrvpX+l8EK6pgvlXJCcdCyBBD5P/mqVmw6ZDyHPsFzYVuGHkOeIAqJ6mG
         ybWsoRKxeWCFatqkk482MNdq0uWqwY1j7ORCxoxpPoxjIdDZ8G0dLv6MkdPNXh+bJo
         F96Tu0QJ14l2n1NdVYQvoAs4B9LdqODAdlBKBvXc=
Received: from RT-NUC.. ([39.156.73.12])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 6E8B05F; Mon, 04 Sep 2023 09:01:46 +0800
X-QQ-mid: xmsmtpt1693789322tu7r1ivbs
Message-ID: <tencent_18D7A55144C423034AA1ABACF04B5E15DB07@qq.com>
X-QQ-XMAILINFO: N3l5ASPewLWqT89O7we2RNRqp9MTqjkcCAD+yHw2sSphskjDTrSDMjBsj+b2Dh
         2HxFkjSGf/6R77y7VfDAP+m7H+h1gh68C0WCCssZMNhgnrfMjy1X092t5dB0yLbqHKopEnBndYu1
         r1PNkKLwnAV7DdKkk6XK+If1Re0OmqOvpdMXPT7QuT7aaBywI/QS9mB0OppLFnoMEIC2tCy8aweb
         3RPBAdyfyecjYDiNudNrLN0bV4au6e6Tuo7Ft/3RBTxk/d/+o1oT7+9WS0Ik5vtQOKJGqcjCvXZa
         2Hr9tjv1JdRs6y+HFzcnmTyGjRfHrvXY/HkhyQ298Jsm4gcOilw/5gEfGePGF5xHxYegzVwMunJb
         PVUXLZY4ZNBWLWSFDyHl436p4IwAXmrgRwlMQxnxzEVHfZL4H7dyoxunAIFowfU5kKBF8hgtU/xb
         G3pUYX66jyBKkTmEdZ5HfVP4CMdEdIcAC1chmTA8lGz3rz5aelzUWcT6+t8Vx1ZJOQaYoz+US5cK
         XIG7vyguR9veJopCNYpE0btqpCS3IHGoGB5acXGRwiltea0U4vANbXlK9+yic2zSdFglaY5/esZf
         P8bHpp423MRYQJQmuAxdb9UndY7IaMrmn0+/Xz0QYGMqOr1I1IKncuRW+gPHpRiRtszfXCObmY8I
         Fgqcol6q8g3mhqKsnQ+DzFdoiQFhH/6v79CWpR5zzBeIs9I9fOdhKRyk+XE5iW8ZHqce0jrmCOeF
         E+dLMzKH8L4Q2TpDRdei9QS39CbmPZFU4Hx0qACJMh2+k5ZHt0/zgBS5pzQBmT2xkG0po/2hcQXV
         fEaagAtvMAKDEZImdOOff3GzNrsVn919m4jIWKClqFBGXBKYGQH28zk4jcQ3q1632l6YIqB+R/Pi
         3Lzq5IWebe9ipubsCS3WdtUVDC8p31MNo3IUMTkvf5em6a3Et5OIGUZJ7BbMVVxVy+sDMOYz8l8K
         HH/42VEv3KJdpiu2/31mXYx+GwDpSYKHjQyJ++GgjiyvjRfoD9RLWDEt71TnVzc4QmPd2W4clUfh
         mPDR8RQT/Eub6A8Duu
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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
Subject: [PATCH bpf-next v10 2/2] selftests/bpf: trace_helpers.c: Add a global ksyms initialization mutex
Date:   Mon,  4 Sep 2023 09:01:21 +0800
X-OQ-MSGID: <c17c97a13641448079027d287c1967cae493aab3.1693788910.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693788910.git.rongtao@cestc.cn>
References: <cover.1693788910.git.rongtao@cestc.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
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
index d64c4ef336e1..500b60226e5e 100644
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
@@ -115,8 +117,10 @@ struct ksyms *load_kallsyms_local(void)
 
 int load_kallsyms(void)
 {
+	pthread_mutex_lock(&ksyms_mutex);
 	if (!ksyms)
 		ksyms = load_kallsyms_local();
+	pthread_mutex_unlock(&ksyms_mutex);
 	return ksyms ? 0 : 1;
 }
 
-- 
2.41.0


