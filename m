Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1EA6251A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 04:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiKKD1o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 22:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiKKD13 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 22:27:29 -0500
X-Greylist: delayed 2724 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 19:26:33 PST
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E15654E1;
        Thu, 10 Nov 2022 19:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1668137187;
        bh=VG03AryjN1xYa93c1hmpENqh0pc82ZJb7GUcVRfapEg=;
        h=From:To:Cc:Subject:Date;
        b=jxpyxrMzXu0S6nnjluXJY6+WLuU/FGUCfS4ZQWZemR8HF/hYMjCx7c7MdxBir5kFP
         48pXosBCB/s22b5nLKAa40AwQ7mIhaVSnwd5Jd+FtXChZ3h2WqwTfoGBqplF7qPj9M
         /KYZfgMv9/h2i6jncEPn21EKkPXIcOhq0WCN6fis=
Received: from localhost.localdomain ([111.199.191.46])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 695818DF; Fri, 11 Nov 2022 11:26:21 +0800
X-QQ-mid: xmsmtpt1668137181t31ricq3i
Message-ID: <tencent_29D7ABD1744417031AA1B52C914B61158E07@qq.com>
X-QQ-XMAILINFO: NhUkPfKlCtQwXEHQjVhadMlQmPdB09PSlN9uaDXEq28soLLj8jyChox9gJTCqR
         REubEYCYiEeRGIsZfrpDgCR2Mkm6LMvFNCkFWnzgkRTY70pR7Fqx47jRFUEZf2U9RU9TR3ROn4WC
         eVH7+y0yHhajHrr6DK2C6CYOtCzXZy0Jf+UhIRGQxYCq3BoADv7UNO4eeFJM1A36OBtQROfg7UKh
         z/t8VQZl+IWhQIAg3dR/qF/k7yxJTPxGL/Kp7PxU/2/oMFY2pOS4wWPr3sGLWdv57/s8ovIKBAzG
         2zXL6l/qCbSGaZdJ1yugAaRJnWBM0p/WJQ61XXq0V0UVmlTbr82VfGfZOHKYUv2+JXbTZXnjyH7f
         T72i/gaUnVPR8AmdaxnuQVPciL6r4D45K0c7o4hQu7ch1tjXLGppqO69PpN11Lwrqpw1UIvsXt1U
         n/Xy79DcTZcDATllKcLuwmP+mlgaRTZTMOebLj4T3VKnbfbM/I3eH4J6PNbPZfwyshk8sCcuE1hi
         QGI+23clUYl01WwnwOF5ghgTN8bb3XpX0ENJr4LtQXae+oYXH+PHRGPEVN8BJ2gChzSPEJFCdFPN
         AiPxmjT8D6vxhU2NQGl25jUfqUrGc3f3a83naZ1GQANUS19HmCAGBlQC421IoLWIV7/DRX29Z1Ew
         ZtxrGPv+sNy6E5g3aPp5SJVJPGVk6t6QadoWeuZC8aapdjOb4OXckbDE1MoLGvYVA/vvbmZj94xE
         cyxs3zXk1WsXygJ9JvVo6OMP4ACWTeyVh1XE15T95MXpJQu+R4xOpnGBHBY5sDKyZBKWUp1iJLpW
         xu3/q3VEBQZoGHVl+KNuACyKzeK4id4/S2Yop2kgmElAZsjhNu2Cy1XJ0drEZ3Dd6WlCEnugAWoP
         YP7XD8enx0UrBs8gCsuMoqWNz4eb+yDE/RVbeOLXO1r7/7H8I5MiOOv4r8zE++f1fvib229+WYX4
         Cn8KXKf5Pn2iwFP5tROOBbL9jhFHI890FEjwDMQ2bgRajRuH0v5CWAD3ubDVHt
From:   Rong Tao <rtoax@foxmail.com>
To:     ast@kernel.org
Cc:     Rong Tao <rongtao@cestc.cn>, kernel test robot <lkp@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>,
        bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and
        Tools)),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next] selftests/bpf: Fix error undeclared identifier 'NF_NAT_MANIP_SRC'
Date:   Fri, 11 Nov 2022 11:26:11 +0800
X-OQ-MSGID: <20221111032613.31106-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
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
kfunc") use NF_NAT_MANIP_SRC/DST in test_bpf_nf.c. We copy enum
nf_nat_manip_type to test_bpf_nf.c fix this error.

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

Link: https://lore.kernel.org/lkml/202210280447.STsT1gvq-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/testing/selftests/bpf/progs/test_bpf_nf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
index 227e85e85dda..307ca166ff34 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
@@ -3,6 +3,11 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+enum nf_nat_manip_type {
+	NF_NAT_MANIP_SRC,
+	NF_NAT_MANIP_DST
+};
+
 #define EAFNOSUPPORT 97
 #define EPROTO 71
 #define ENONET 64
-- 
2.31.1

