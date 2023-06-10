Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04AB72AD03
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 18:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjFJQMp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Jun 2023 12:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjFJQMP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Jun 2023 12:12:15 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64823C00
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 09:12:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f7f4819256so21176065e9.1
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 09:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686413524; x=1689005524;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VbmmsXne9lBZDp9Sn/ZgZd5tJQZXSAy6sdaXotYsvUM=;
        b=OR4L99G4HwnJ1EdllP03KiFrRSjZedqP1NneYA6aNckQdAHuuEa4cCvEdIOoMUeObt
         qPqmg7CtTZS+88WBRsNNxMOvn1Cv2Iw5CUGFmEhVvZn2NvZK5QTFm1sA/bg+vv56oFsZ
         6T18FCKP0Pt0SlLIyETXI/7dZFJvFHDdUENMjDHaOt64g9b4wJ1cVa3z1YC0Ydg7yqyF
         jnxPsfrDQoaImusU/ksCLldoe9zPSi7OFpOgkbHIK7cTqPo8db6zcLprkYpcvvHNufH6
         t5EdLrq/1RMS0KP0RHtdz8hlPW2J8jU3HEDnifaVorS9XXejIJr9+MdmPi+QPsRFWHe+
         DWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686413524; x=1689005524;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbmmsXne9lBZDp9Sn/ZgZd5tJQZXSAy6sdaXotYsvUM=;
        b=Wm2L//W43+scjHryqSwf3UcFUyug/ThEaxdxhcLe9Oe0Vub2iP1tqzDyqrvKZ91wf4
         LQBk5UFNDTP0HiFsH4xfXT2vf9kQEns5i5u0NpBUALMbk8st8YUR4phZtLnI5ecCFb1f
         E4DVraGJQW5g3rRP8jsrn+opDocDSYX/8Fpb4Dqvw0SHC1SdJrShHWMGYV6+ib9vpmH4
         c62TqBVG0pVCClDsDvOChhiI6qhaBELO45Ab8mBkhfOXcqH0UxSKUstrng+5gUZVuZVQ
         4FC5h+DEoBobmmvrs1tYA9vhSE2RyFNp/Y8H6Pl7WZNNsdexFQDsOM7VT5W8cHdrVfaO
         uANA==
X-Gm-Message-State: AC+VfDzRkZAwVmdg6bJpVp2A4CK2n0OJuTZumUWN/rSV01rfhKb74Ya2
        5REQZ2ceavOBQO3xi1n9Qi7Jmg==
X-Google-Smtp-Source: ACHHUZ7htSHEHhoR8p2Q8ku8T3iUp3nRjhQvfhpUAPmFVuD+UA1St4Rez8cT+y/aOXvH82l1XrJm4w==
X-Received: by 2002:a5d:49ca:0:b0:309:4f23:e52d with SMTP id t10-20020a5d49ca000000b003094f23e52dmr1346961wrs.43.1686413524327;
        Sat, 10 Jun 2023 09:12:04 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d4349000000b003079c402762sm7431145wrr.19.2023.06.10.09.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 09:12:03 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Sat, 10 Jun 2023 18:11:49 +0200
Subject: [PATCH net 14/17] selftests: mptcp: join: skip MPC backups tests
 if not supported
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-upstream-net-20230610-mptcp-selftests-support-old-kernels-part-3-v1-14-2896fe2ee8a3@tessares.net>
References: <20230609-upstream-net-20230610-mptcp-selftests-support-old-kernels-part-3-v1-0-2896fe2ee8a3@tessares.net>
In-Reply-To: <20230609-upstream-net-20230610-mptcp-selftests-support-old-kernels-part-3-v1-0-2896fe2ee8a3@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Davide Caratti <dcaratti@redhat.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Geliang Tang <geliangtang@gmail.com>,
        Geliang Tang <geliang.tang@suse.com>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2543;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=BsRVkTeR5aGWlyqCY68sJFSqvmvIGz5WWgXLNAhE4WU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkhKC+RaVYSNlxR0uL/RIHvGnDUPeCrdycTjaiJ
 lgCwc13n9OJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZISgvgAKCRD2t4JPQmmg
 c9eFD/9YTn+w5OQPaFF8RVr9ORXioVsgRjp1fbU8D+f1Sv5G1ihqj/R9TnH6GJtt+Oyo8fsHHaK
 5sPfdwwYSzV0eGVssqxnOhpSUaAsfTM8TDH+HKWrHClE8ZWnQatTBLCEbN+YoO4znBCTCwuKZj3
 62R4Ylp8uTRsZeNiDqvWH2RhGIhAvozgG8vCzpGmjgyYSQNBKXoR46Pjy8ZdfVo4Y8I+Er8YjrW
 td2PWbHhh4sty7iEQ137yl8boK+H9QA9YCAMgO7ealZ8MvDZxwDQlrj+lPENhx8zqsmyk2p5/8q
 QQGwvFrOAvoTQ/n73IGn5z3lpzpyucy2wzz3NQ/MaVyIVLP3Qrgmd6GjvcRamPQEuquoF+zpNvU
 TcGuWXe2BiQPe/P647grtHygknDMtlDhptFbec+56ZDEvIuqOidz0IngXRI/iI0d/vNDM300ZPn
 BhPzDpje+4tCNjOk13y8A5sgLc2Vk1qOXrzr5QgbIAJwArkC/kYtAwBhIkjOf3vW0avJnm2RGAw
 TG87DFtVrbYejgSCSYAsLiAr7+ss4RuZKywsntO2Yxi4M/ySERDOH93CyDDbk3Tp9XjIq56QOIT
 5RUdN9ddRdRUZcRFtZTgT7Qom3D/AolPogJN+FosUnxSO6b+WRCVVX8r/BXPT2U6FYr5ILj6ajQ
 rc7A4gzmiMXnTlg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of sending an MP_PRIO signal for the initial
subflow, introduced by commit c157bbe776b7 ("mptcp: allow the in kernel
PM to set MPC subflow priority").

It is possible to look for "mptcp_subflow_send_ack" in kallsyms because
it was needed to introduce the mentioned feature. So we can know in
advance if the feature is supported instead of trying and accepting any
results.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 914f6a59b10f ("selftests: mptcp: add MPC backup tests")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 7867bad59253..554fcafd6e8a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2713,14 +2713,16 @@ backup_tests()
 		chk_prio_nr 1 1
 	fi
 
-	if reset "mpc backup"; then
+	if reset "mpc backup" &&
+	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
 
-	if reset "mpc backup both sides"; then
+	if reset "mpc backup both sides" &&
+	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
@@ -2728,14 +2730,16 @@ backup_tests()
 		chk_prio_nr 1 1
 	fi
 
-	if reset "mpc switch to backup"; then
+	if reset "mpc switch to backup" &&
+	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
 
-	if reset "mpc switch to backup both sides"; then
+	if reset "mpc switch to backup both sides" &&
+	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup

-- 
2.40.1

