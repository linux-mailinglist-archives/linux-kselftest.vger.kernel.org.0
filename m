Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A57E62F158
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Nov 2022 10:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241840AbiKRJig (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Nov 2022 04:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241455AbiKRJif (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Nov 2022 04:38:35 -0500
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1FF18B1E;
        Fri, 18 Nov 2022 01:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1668764310;
        bh=L9lq49fnBMKkQ6EuS4f8o+JJ8V25XS/8kzp+eL7tIWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=vomaaK8om7aXuHPG/6QLlnTsOhG2LOfp1MyQo7vXmVCjQEf5+uK677n15LkBFLJ86
         JFrohXsDRiOD9dIir6LNznuYWhBnFsqnFEzRw4PBylXhPogt8xmrLFBv8ES6NZ+9T5
         8eEvVtyJulJFq6NiUGgmv1iEV/UnCayVqIDEruUw=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszc1-0.qq.com (NewEsmtp) with SMTP
        id 99998261; Fri, 18 Nov 2022 17:38:25 +0800
X-QQ-mid: xmsmtpt1668764305t267nbr74
Message-ID: <tencent_4C0B445E0305A18FACA04B4A959B57835107@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8PsoUArMVLcQjYBngMKSICsRNPPynwW4aNwXDhozF5Xfxfozh+U
         7JZcwTINU7QfSW9nR0uSp2nGEKT2hNFqCSzHVwHeBST3deqAH7PoGgkalzNmjPQ4meuiXLXymvIf
         EvDNGmMtQs+S7Lxl2CIMK6eKf9QJmjYA0e1kq7x9wiI+Ke/2ZqLMSuJIfOqzXysWMQYG4qp07FHZ
         V4djqscvuk0rw9UKlIFtUYEDZ4TIDmHXGcOjPhq+soHIQJOrViOEtdWylmVy7WC89SF32WFkBolI
         B5gDwVFUjydKu/MPb7b01hQkjDuTF05FqvyI+sh5LFw+9TDsgGpmH1NKl+MR1hy2s/0+2maNrWx8
         JpkBuSdLDZVeAZK3MatCkdkm71xMnqhzPv3e4ogGIhvP2mlIC9/3q6G8/pis/RPfm5oe+DlJf6A7
         tOQWQ8f/dtraLFXfsFIkKt/nNKB9VemQwTvVqhDm3bTjn0Y/JYtb0gDz0mnzEI7pu0fNG+uIPa5t
         +4cJGZch4Vs6l2QQE/qQUL3QjlIXyUusSSnvJ8etFcjBOBr6ujiKH1GGTuOEHZCJMrYDsy9bR+l/
         +T+gPSYQb507fRXMR6JG2cKnjRg4u35FSDlxcpxfbILnvoSO3LQQK3wD/3sVW5gFn/we5ekG749N
         2frzeyJapq1tb2Jwf1bGwRMw4DP7VVehzmYZ3m2LywiGO1HJLcfymIYNQYkJANDLTUx1GWhQjmdL
         /HkIehXHA6eMX9irFPaq/GsBG2DRLZfHTcnm6H3ZSoKlZhDC6PCgibe8fvXaDUo+hFzlgZGaxzKm
         rNsrOKf3HefdZOHE6n7fNrKrglfEsKRKp9/qvEyeYDPuj8m/APIGz6KkN5rS4U2LumP20OvNqbrj
         HB/IaRCUYYnkOqX6pbKPADXfdPikMzyDx/CNDb4TcNxKOzf1Hx0n2SpBV8OMvQdLsgA5lm9B9g4k
         Iiy+DPVCK07hGVwcV711u9opps53Cd7d0YhgT9ZECH+oMIGP6N+kAI5efpHC2xnrmyXj3+Kc4=
From:   Rong Tao <rtoax@foxmail.com>
To:     andrii.nakryiko@gmail.com, sdf@google.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, dxu@dxuuu.xyz, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        lkp@intel.com, lorenzo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, mykolal@fb.com, rongtao@cestc.cn,
        rtoax@foxmail.com, shuah@kernel.org, song@kernel.org, yhs@fb.com
Subject: [PATCH bpf-next v2] selftests/bpf: Fix error: undeclared identifier 'NF_NAT_MANIP_SRC'
Date:   Fri, 18 Nov 2022 17:38:24 +0800
X-OQ-MSGID: <20221118093824.108797-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <CAEf4BzZE5=OOp6OesB=P8PE=Ps62fkecDSZ9MzwHCD68=+oN0g@mail.gmail.com>
References: <CAEf4BzZE5=OOp6OesB=P8PE=Ps62fkecDSZ9MzwHCD68=+oN0g@mail.gmail.com>
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

commit 472caa69183f("netfilter: nat: un-export nf_nat_used_tuple")
introduce NF_NAT_MANIP_SRC/DST enum in include/net/netfilter/nf_nat.h,
and commit b06b45e82b59("selftests/bpf: add tests for bpf_ct_set_nat_info
kfunc") use NF_NAT_MANIP_SRC/DST in test_bpf_nf.c.

In bpf kself-test config (tools/testing/selftests/bpf/config) nf_nat
is compiled as built-in, this issue occurs just if it is compiled as
module. we just hardcode 1/0 here.

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
 tools/testing/selftests/bpf/progs/test_bpf_nf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
index 227e85e85dda..075cd9b31d76 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
@@ -157,10 +157,10 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
 
 		/* snat */
 		saddr.ip = bpf_get_prandom_u32();
-		bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
+		bpf_ct_set_nat_info(ct, &saddr, sport, 0 /*NF_NAT_MANIP_SRC*/);
 		/* dnat */
 		daddr.ip = bpf_get_prandom_u32();
-		bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
+		bpf_ct_set_nat_info(ct, &daddr, dport, 1 /*NF_NAT_MANIP_DST*/);
 
 		ct_ins = bpf_ct_insert_entry(ct);
 		if (ct_ins) {
-- 
2.31.1

