Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563045987D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Aug 2022 17:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344383AbiHRPuz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Aug 2022 11:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344439AbiHRPue (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Aug 2022 11:50:34 -0400
X-Greylist: delayed 298 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 Aug 2022 08:50:31 PDT
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2452D647E9;
        Thu, 18 Aug 2022 08:50:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4M7pj521R2z9v7Ys;
        Thu, 18 Aug 2022 23:29:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwB3MhqAW_5ilLIyAA--.42520S4;
        Thu, 18 Aug 2022 16:32:52 +0100 (CET)
From:   roberto.sassu@huaweicloud.com
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        corbet@lwn.net, dhowells@redhat.com, jarkko@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v12 07/10] selftests/bpf: Compile kernel with everything as built-in
Date:   Thu, 18 Aug 2022 17:29:26 +0200
Message-Id: <20220818152929.402605-8-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220818152929.402605-1-roberto.sassu@huaweicloud.com>
References: <20220818152929.402605-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwB3MhqAW_5ilLIyAA--.42520S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1fGry3urWDWw4fJrW5KFg_yoW5Xw45pw
        n3A3y8JFWrtF1YyrW7CrWDGFZ5t3ZrXFW7G3W7Jr15uw18Jw4kJr18KFWUGrWDXa9rZr4r
        AF97KF13AF1UJ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1j6r18M7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64
        k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
        xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
        kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v2
        6r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUwPEf
        UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBF1jj34XKgABs9
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Since the eBPF CI does not support kernel modules, change the kernel config
to compile everything as built-in.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/testing/selftests/bpf/config        | 26 +++++++++++------------
 tools/testing/selftests/bpf/config.x86_64 |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 3fc46f9cfb22..0fdd11e6b742 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -7,9 +7,9 @@ CONFIG_BPF_LSM=y
 CONFIG_BPF_STREAM_PARSER=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_CGROUP_BPF=y
-CONFIG_CRYPTO_HMAC=m
-CONFIG_CRYPTO_SHA256=m
-CONFIG_CRYPTO_USER_API_HASH=m
+CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_DYNAMIC_FTRACE=y
 CONFIG_FPROBE=y
 CONFIG_FTRACE_SYSCALLS=y
@@ -24,30 +24,30 @@ CONFIG_IP_NF_FILTER=y
 CONFIG_IP_NF_RAW=y
 CONFIG_IP_NF_TARGET_SYNPROXY=y
 CONFIG_IPV6=y
-CONFIG_IPV6_FOU=m
-CONFIG_IPV6_FOU_TUNNEL=m
+CONFIG_IPV6_FOU=y
+CONFIG_IPV6_FOU_TUNNEL=y
 CONFIG_IPV6_GRE=y
 CONFIG_IPV6_SEG6_BPF=y
-CONFIG_IPV6_SIT=m
+CONFIG_IPV6_SIT=y
 CONFIG_IPV6_TUNNEL=y
 CONFIG_LIRC=y
 CONFIG_LWTUNNEL=y
 CONFIG_MPLS=y
-CONFIG_MPLS_IPTUNNEL=m
-CONFIG_MPLS_ROUTING=m
+CONFIG_MPLS_IPTUNNEL=y
+CONFIG_MPLS_ROUTING=y
 CONFIG_MPTCP=y
 CONFIG_NET_CLS_ACT=y
 CONFIG_NET_CLS_BPF=y
-CONFIG_NET_CLS_FLOWER=m
-CONFIG_NET_FOU=m
+CONFIG_NET_CLS_FLOWER=y
+CONFIG_NET_FOU=y
 CONFIG_NET_FOU_IP_TUNNELS=y
 CONFIG_NET_IPGRE=y
 CONFIG_NET_IPGRE_DEMUX=y
 CONFIG_NET_IPIP=y
-CONFIG_NET_MPLS_GSO=m
+CONFIG_NET_MPLS_GSO=y
 CONFIG_NET_SCH_INGRESS=y
 CONFIG_NET_SCHED=y
-CONFIG_NETDEVSIM=m
+CONFIG_NETDEVSIM=y
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_SYNPROXY=y
 CONFIG_NETFILTER_XT_CONNMARK=y
@@ -60,7 +60,7 @@ CONFIG_NF_DEFRAG_IPV6=y
 CONFIG_RC_CORE=y
 CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
-CONFIG_TEST_BPF=m
+CONFIG_TEST_BPF=y
 CONFIG_USERFAULTFD=y
 CONFIG_VXLAN=y
 CONFIG_XDP_SOCKETS=y
diff --git a/tools/testing/selftests/bpf/config.x86_64 b/tools/testing/selftests/bpf/config.x86_64
index f0859a1d37ab..ce70c9509204 100644
--- a/tools/testing/selftests/bpf/config.x86_64
+++ b/tools/testing/selftests/bpf/config.x86_64
@@ -47,7 +47,7 @@ CONFIG_CPU_IDLE_GOV_LADDER=y
 CONFIG_CPUSETS=y
 CONFIG_CRC_T10DIF=y
 CONFIG_CRYPTO_BLAKE2B=y
-CONFIG_CRYPTO_DEV_VIRTIO=m
+CONFIG_CRYPTO_DEV_VIRTIO=y
 CONFIG_CRYPTO_SEQIV=y
 CONFIG_CRYPTO_XXHASH=y
 CONFIG_DCB=y
-- 
2.25.1

