Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3C6790535
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Sep 2023 07:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237603AbjIBFQI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Sep 2023 01:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351518AbjIBFQH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Sep 2023 01:16:07 -0400
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A811170A
        for <linux-kselftest@vger.kernel.org>; Fri,  1 Sep 2023 22:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1693631761;
        bh=VDeJU94IWnvseyKaMxC4IUln27g8AmHmoNXDqEplCe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=y98HrSljU15JiM4eaxs4iPQ85bCyaOAwK51n36h4MBI17vJXGmmWzMKvHnAKpvB0Y
         De7nRbXL+INgiwL1YV1poTb9pTre1cNVHbvmbL8l/yd/TdxUSw7gAtmLkWnWltX3+d
         +/TEgY7xqCtDRjy0xjiVOCidefICoTdu2vyAm+e8=
Received: from rtoax.lan ([120.245.114.63])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id 3EA29043; Sat, 02 Sep 2023 13:15:42 +0800
X-QQ-mid: xmsmtpt1693631746tb9aw2kru
Message-ID: <tencent_610B9D67B15C66A858BD5E8DF623CA18840A@qq.com>
X-QQ-XMAILINFO: NKv2G1wnhDBne0mgP5e8Y2tcHeHRdNu5Q0RL7PHJuVBIhlza8+x+J6yuCnozKQ
         Bd9sjr0FaoV3Ewulrh4ofynlPvtSqJj0N4bqDCnALENDC7cLq6+A6XtJqom7ARNR2SI7KUkW+2Px
         YE/2Rl1vGzdus6T9H6+OP/gXEI8S/YvhxThr0D+xcwzUHWlkEGbdwY6Ca3TmU++IwmyV8xkgRwb+
         s/9p2A9q9kCFxnfiri24XCl5v+SWlPslQl4GBZRDnjv3o+ijfsedpZVLK+Sfn4X9ygwK/rBQ0zDR
         RzIoP91t9hgg4Tp9nTmngcMAV6LM5VG+/6dAhVTARq+GjVtzSO7IdWzp5pVmCMz/PExE+itSKo0g
         8u8JLQxnT4o3xu28ixiB4h5CoB5hle4/zsPwJ8zb4Y1AzedwWwTiJajaWZi5tM5tgwUa1+aNCTW+
         IRFRyzcvsTa9z6SPrDcGrm46oXQb9tqxKq6Ai4rj/I9CgTIeAMaaFsbYUWntyzAPpJa5C/JbsVFo
         LJb9j4jikTBh0JwRLT3CTKQSzURW1rWwMnkgJ8SF92le7JklBvN4J0ylrHl1p+fugu1dlLOUy14d
         pQcBOyACmcepJSi1qiLQdn7rGZ3VHRzWr/A1iwgsk4h6wegkus95GtWUFjTMSZqHLGJfNAQLB2j3
         S9XZ9PNno6wsJT4Y8+tkQio4kiymt6z0KKi+963FWUG1n0STvHxYspD8fvzR7GVQMwl7DUZe7GQq
         mCVS5spq0myogqsAcP7UeMUc35ExqE5i7Kb92sbS3rIyqddty+UilEWe8l+/IDdcKbqPUEyy/L0t
         QHhRmXWV9MM1RnB5URGv/ATDhJ9H/NJPBaC7iQJDV2s+04cu5/1SSoOyhMD6lm3OvSoNqg7fWw8L
         UvJP4IuoevqrBUrG1CNtsH2r8PLOkWimwODo1iALnhKNI2Q/zPNpW5pQwCof8PVvkU5SJdOTtszh
         MHlQLJzim8Nx39r/oI0RAlFb5levTZV9AsZhT+bAV9R6Y+eEi6vbkZIeS/nzykbn/clWHFTKrIPb
         1+I6SV8yfZAXm895L7
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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
Date:   Sat,  2 Sep 2023 13:14:05 +0800
X-OQ-MSGID: <20230902051421.139040-2-rtoax@foxmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902051421.139040-1-rtoax@foxmail.com>
References: <tencent_4F0CF08592B31A2E69546C5E174785109F09@qq.com>
 <20230902051421.139040-1-rtoax@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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

