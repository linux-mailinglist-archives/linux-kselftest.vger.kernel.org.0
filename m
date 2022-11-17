Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF57162DF8D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 16:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239976AbiKQPVa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 10:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240647AbiKQPUv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 10:20:51 -0500
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E77490AF;
        Thu, 17 Nov 2022 07:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1668698219;
        bh=gqWKlSzLddOrY9k3Jj3HmbY9CYQ+KSWRwr61fcT7li8=;
        h=From:To:Cc:Subject:Date;
        b=kjamsL987YNVgPf5g9Zib0dXtJcHASmTRdQu3FOoM5Do/aVImEoLI7iA+VsrbSgjU
         BuMHqM5gHEJk+Fn1EsTFozdqn1DyAPBDJ+YMwtKbOcwgk81rpa10Jen0RZ6MEiYbez
         KaSRVorGpWNQkwt0rG/8x8bpomOKeqEYpiBHT5eI=
Received: from localhost.localdomain ([111.199.191.46])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id 43607CAA; Thu, 17 Nov 2022 23:16:54 +0800
X-QQ-mid: xmsmtpt1668698214tfpb8kan0
Message-ID: <tencent_E1424259BD97672AD1AF00A3468858065E08@qq.com>
X-QQ-XMAILINFO: OR+tS2yJykEIbqqkNkQNYZT45wGcuLVANc/YHVBsiIKDNlbpsxwSCylukFzcoa
         W70Gjv5kl+YXFUOLthEzgQ0wb5kuRc41ZaUVPNe+qGMZ4U6Vx20IstmbTN+IJnWr8JGbfgj8vqhu
         zVyu8IIt2goe2ishzW4G0BXs2fHwPTPFuR6SuhN+gX872XyzXgVQgmvUqdqbLEz6MmjUHnejdQZD
         KI9bxyaTxL5rhU74XQuomNxoxgF9RCqOF4KQOJf3LboAoHYem4Ye1KXhQ9YvSYaEMuZAsfqBvMVb
         X9PCiSSfS9Rk3FTUv+7/S2lHO4fLTKpVwIqyVkOKPO79cHjGSMmKKe4jE43jFX9RLnzsMsFJFr2Y
         yAi13XhB9qYu/pDZoxUypnhqNFWVca6gFJD0WYWHWIyMhx3mOa9VKbyUg/SQfUZ8ZgVWcpo4poSr
         YbyoCTrRK+nBll8zEeLkk6giGYTiV3Q5IJkmVa9amaEdN5/wITr/eD6OgKA/EnaKGL3L/d/PZrqY
         gkp602g29VmzwzrYgMa2mhFAjxPhiJaFXYolzOh40V/Jtrlnz/IDAV/CmxBn2h2ZSdGHFDfEf3Vk
         NiIGgNw4Ch1+Ki9srWCX7Q6zh+ZQJ1dANChAloQbJKJ4V7U+rsa6I5+nBJtajYz69cQoN9LpUO3O
         +qfHaanOklW1wfr8Jj/cGLy/FrE18ubSCkVRvqOwAfoZn6HRhvpJXgl11W/8xMwTVrpF+DnuRCj7
         SE6JsFCwhH4O56F9bt4gSJ+64rkp+gdDqfpS7Awtn4wMNBLD3HUUhJ3OlfoSW8czjWgZn7MsSuLx
         KEV1/v4N8Hi6klrOPBKg4qZcn6/FJoSvusY4rwSAb+cCFPkpDpN7g0lGnTWKqBEq+eylFPXd2O64
         FJ+FXwW1vH6FSOz/RjGLdgC45fvKwm9+2KY3dQI2XfeYAV1xbr6Wdxd9Uu9jG6VEuSxJHn5Abq28
         C4qpcCHcaQ09FdCI4jmFF9LbDid3jxZPhOKZUItv3WCLgF3NoTdCiAIWUyY52AQT8HdXylllwNhF
         Gx0CqK/k6RUqDtfGYrrRU9k8nRado=
From:   Rong Tao <rtoax@foxmail.com>
To:     andrii.nakryiko@gmail.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, dxu@dxuuu.xyz, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        lkp@intel.com, lorenzo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, mykolal@fb.com, rongtao@cestc.cn,
        rtoax@foxmail.com, sdf@google.com, shuah@kernel.org,
        song@kernel.org, yhs@fb.com
Subject: [PATCH bpf-next v2] selftests/bpf: Fix error: undeclared identifier 'NF_NAT_MANIP_SRC'
Date:   Thu, 17 Nov 2022 23:16:43 +0800
X-OQ-MSGID: <20221117151645.25101-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

commit 472caa69183f("netfilter: nat: un-export nf_nat_used_tuple")
introduce NF_NAT_MANIP_SRC/DST enum in include/net/netfilter/nf_nat.h,
and commit b06b45e82b59("selftests/bpf: add tests for bpf_ct_set_nat_info
kfunc") use NF_NAT_MANIP_SRC/DST in test_bpf_nf.c.

In bpf kself-test config (tools/testing/selftests/bpf/config) nf_nat
is compiled as built-in, this issue occurs just if it is compiled as
module. We could use BPF CO-RE and ___suffix rule to avoid this.

How to reproduce the error:

    $ make -C tools/testing/selftests/bpf/
    ...
      CLNG-BPF [test_maps] test_bpf_nf.bpf.o
      error: use of undeclared identifier 'NF_NAT_MANIP_SRC'
            bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
                                                           ^
      error: use of undeclared identifier 'NF_NAT_MANIP_DST'
            bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
                                                           ^
    2 errors generated.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
v2: use BPF CO-RE and ___suffix rule to avoid this error.
v1: https://lore.kernel.org/lkml/tencent_29D7ABD1744417031AA1B52C914B61158E07@qq.com/
---
 .../testing/selftests/bpf/progs/test_bpf_nf.c | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
index 227e85e85dda..1706984e1a6a 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
@@ -2,6 +2,7 @@
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
+#include <bpf/bpf_core_read.h>
 
 #define EAFNOSUPPORT 97
 #define EPROTO 71
@@ -11,6 +12,11 @@
 
 extern unsigned long CONFIG_HZ __kconfig;
 
+enum nf_nat_manip_type___x {
+	NF_NAT_MANIP_SRC___x,
+	NF_NAT_MANIP_DST___x,
+};
+
 int test_einval_bpf_tuple = 0;
 int test_einval_reserved = 0;
 int test_einval_netns_id = 0;
@@ -58,7 +64,7 @@ int bpf_ct_change_timeout(struct nf_conn *, u32) __ksym;
 int bpf_ct_set_status(struct nf_conn *, u32) __ksym;
 int bpf_ct_change_status(struct nf_conn *, u32) __ksym;
 int bpf_ct_set_nat_info(struct nf_conn *, union nf_inet_addr *,
-			int port, enum nf_nat_manip_type) __ksym;
+			int port, int type) __ksym;
 
 static __always_inline void
 nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
@@ -151,16 +157,34 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
 		union nf_inet_addr saddr = {};
 		union nf_inet_addr daddr = {};
 		struct nf_conn *ct_ins;
+		int manip_src;
+		int manip_dst;
+		enum nf_nat_manip_type___x mapip_type_x;
+
+		if (!bpf_core_type_exists(enum nf_nat_manip_type)) {
+			bpf_printk("enum nf_nat_manip_type not exist.\n");
+			return;
+		}
+
+		if (bpf_core_enum_value_exists(mapip_type_x, NF_NAT_MANIP_SRC___x))
+			manip_src = bpf_core_enum_value(mapip_type_x, NF_NAT_MANIP_SRC___x);
+		else
+			return;
+
+		if (bpf_core_enum_value_exists(mapip_type_x, NF_NAT_MANIP_DST___x))
+			manip_dst = bpf_core_enum_value(mapip_type_x, NF_NAT_MANIP_DST___x);
+		else
+			return;
 
 		bpf_ct_set_timeout(ct, 10000);
 		ct->mark = 77;
 
 		/* snat */
 		saddr.ip = bpf_get_prandom_u32();
-		bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
+		bpf_ct_set_nat_info(ct, &saddr, sport, manip_src);
 		/* dnat */
 		daddr.ip = bpf_get_prandom_u32();
-		bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
+		bpf_ct_set_nat_info(ct, &daddr, dport, manip_dst);
 
 		ct_ins = bpf_ct_insert_entry(ct);
 		if (ct_ins) {
-- 
2.31.1

