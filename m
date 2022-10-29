Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523A8611F92
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Oct 2022 05:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJ2DII (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 23:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJ2DH7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 23:07:59 -0400
X-Greylist: delayed 464 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Oct 2022 20:07:53 PDT
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D9614BB48
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Oct 2022 20:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1667012871;
        bh=c8DKeSJHy7nv5V+vv7J8kQrLnkZeHMgYOuYV61olSO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=tmhW+oRwhGJgHzvwGIqcjzKtg7Y4iuLFWB9xeGpFG2515R5Jp44bPD3mkBjvzvevZ
         EwVCZmaHYI5xUOHtd5CyAzeoojj/oksnY5eH2yl0ia7a+zj00uWWqviIvbuVCJgUr1
         dhWoZEukvbFRTMmBxpF1AnWXyx40IEI1sfqfuGto=
Received: from localhost.localdomain ([111.199.189.86])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 1EE9CAFF; Sat, 29 Oct 2022 11:07:46 +0800
X-QQ-mid: xmsmtpt1667012866tszdu6uwh
Message-ID: <tencent_D977F40871CDA0474822CBF7324D25F9B505@qq.com>
X-QQ-XMAILINFO: M5KH7ZjKOjx4y5ReN9Ig/rkL+0Hdd95Phowszp3b8X0t9jtQIK/Tmf8UovW4pj
         2pILr1dmXvV9WdTOEEXIajKMZfAfcnVUKbnosj7k4TzakQC9qSEYk74EMq0ZO+toWT2O3SPvbmgh
         DWlOVi+nEJOnuKEQtzkPKwvfGud8gRvsoKyqQyZQtIJTCYvBX3d6LoSUrXbuTcIWlAsNX31gXOLM
         oDGyz6kWukIIEtiKTxfwI7xScBX1ny9vIwv939+Ll5Uteg2P9WVMQ7qdYzrD+IVBuQv+veFVlTaB
         uXbTN7Akr3o4pJkd8hf9lCFkLUojtGfHoU7c/XTRdz8T5AephBAg9p/qcDZGSOjACla9xn1DpLha
         o+HMxY4dsZZL4WJMrr9tmm7L7gQzIBNpX++JTleScZ88+XqWaC8xrWYjbrInptBvGySwSE0gCXy9
         oFZBAjQbykXcmPR6i8/Ey7w7SRIrFBtcoerdwL773lL0v91BJtvuimfmZgmzP0+MIsO4JQHbO8jx
         EpmrEoMzZn2g/iC5lWqZ00/xtukjBhDGU/sdgosfvo9pVB2Geno/HtOw9vGLNtBXx7PCONIafb67
         IfvOzuHs2HCNpIn7SbFgzwR4VaS/+SWzSxK36EpcRXv3TM7/iuQzwz7KeZtk4HIzMCZY8DmTkBTJ
         bx0o6tvr9LJ2yrcv0Gu24ba8JwSAXS32IkGIHtQRzaPPRnpZ+8SCJioorTw+lCPMTC9boWqUet0m
         Sgw98kj38wXUdXEU4L8o1EKBKX9VwE5kwnIGS80ETOj8q3z9OA/QPDC8dBF47aQVH8KLVDHwiJ3H
         a3tbL7Et9lyTFXgL5paksucNePksbwBVUVCjw/oRv4qEIiw631ci9bRNEyC1HYCKISJH2k8u3aCZ
         S2sgct1zUCnotBzFuBcAFxA9Qn8/KqyVYFYM18h1s93piWkjCJnGZuMVZNqFPl7LI9z7k5V8D6rr
         dm9QTdxYZPKXok/t2JDZ0OtIVvBF76b852KDJ9bnQC4IWq4S8xjOVj1wRTrxV/sov5fQHhAeOkqM
         M3h+BAtR+8I9XxdRyjLZNLPquVFOdmZmqAUhJ+CWtKCZKpI/psDeqNa5da9+w=
From:   Rong Tao <rtoax@foxmail.com>
To:     andrii.nakryiko@gmail.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, martin.lau@linux.dev,
        mykolal@fb.com, rongtao@cestc.cn, rtoax@foxmail.com,
        sdf@google.com, shuah@kernel.org, song@kernel.org, yhs@fb.com
Subject: [RESEND PATCH bpf-next] selftests/bpf: Fix strncpy() fortify warning
Date:   Sat, 29 Oct 2022 11:07:45 +0800
X-OQ-MSGID: <20221029030745.25588-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <CAEf4BzazYVkVKrKzPD8a7tRZrcWDvvgoVksJHYk3+46V=8kZhw@mail.gmail.com>
References: <CAEf4BzazYVkVKrKzPD8a7tRZrcWDvvgoVksJHYk3+46V=8kZhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Replace strncpy() with strncat(), strncat() leaves the dst string zero
terminated. Compile samples/bpf warning:

$ cd samples/bpf
$ make
...
In function ‘__enable_controllers’:
samples/bpf/../../tools/testing/selftests/bpf/cgroup_helpers.c:80:17: warning: ‘strncpy’ specified bound 4097 equals destination size [-Wstringop-truncation]
   80 |                 strncpy(enable, controllers, sizeof(enable));
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index e914cc45b766..912e6522c7c5 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -77,7 +77,8 @@ static int __enable_controllers(const char *cgroup_path, const char *controllers
 		enable[len] = 0;
 		close(fd);
 	} else {
-		strncpy(enable, controllers, sizeof(enable));
+		enable[0] = '\0';
+		strncat(enable, controllers, sizeof(enable) - 1);
 	}
 
 	snprintf(path, sizeof(path), "%s/cgroup.subtree_control", cgroup_path);
-- 
2.31.1

