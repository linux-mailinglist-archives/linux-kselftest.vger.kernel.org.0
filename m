Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B45D72ACE4
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 18:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjFJQMf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Jun 2023 12:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjFJQMO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Jun 2023 12:12:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6CF3C30
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 09:12:01 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30fb7e668c8so191778f8f.1
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 09:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686413520; x=1689005520;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RyTC3i+tL1e1KohwNfL5rcAn2kD/jZ7ZYJWIbElBNMQ=;
        b=8SYbwS8quGxgs0rUrCRIrQCB5iXdv1yrre5Db/uHWslG4hWS8z0hYEUcDAxVuBB0u3
         Q7ezw1BGhWwQQaZwPqOVyMhahbYdPMeCizqFc6U91WMKgeC1KEOiRlvywL17p2bgsZzf
         P4Gzl8Y3ojdwPTQfhAv/gQqKegOEeRkIzQB5OQ63BDSj2mM1eDaQDoliaSk9CuBeWZU6
         nzciJpwPkL2mi6ASNqDNzqbNbHvC9KARARrrfzy2TNtiOsDm3AylEhntSWRvjPmTpB8l
         LVrCJW6Tc9ONpcnU6B+w8cexPb7t/tPkxFtO9mYlSY2+LNubLxULb7Ck+8LjvAfzSD60
         UfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686413520; x=1689005520;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyTC3i+tL1e1KohwNfL5rcAn2kD/jZ7ZYJWIbElBNMQ=;
        b=WuqohGdECccIwpRRMBWcrukYOQsrvKPNz5FXN2OXWn1j2Y9W0L9qv0hIQBOZoKOfvE
         uGJUfUfLB7HRMJAY4iVmW3bil+FXl7S0pEuFWVHNFJM1nuiB4IIxIZ4BQpxpHAbIXEVx
         xJVNFUE7WW6ZAsDVjIkiTB3Ef1+iOL/msjc3goNWdsSrit7I1YnFR9PugNUXqKMKF7Kr
         AcGjjq57rgmJgAbPPM38Moz41uRiXjmjVzh3Z46vnYi9irofQs4Zg8JTcoo0/7SH+eo1
         2bON0WZ+rqjpIhJFv0S2O6v/fZkbtyxry5zjcFF0lixwUf7vb7t7/9wiQyee3aHL8gBW
         Z+zA==
X-Gm-Message-State: AC+VfDzQJDqIomXtGdg7CdugfIPSK8zz/puEqfEUk4UdMq4ZuytMbVGX
        iQm1dVqVnK6rgm8O9s0k2lLETA==
X-Google-Smtp-Source: ACHHUZ6YpDEMouSjwol8z+p7bYurmmH74xuvGbojtJsg1H/xz6aUPiX0Y/YhIs7KeGogNDgKHdoGjg==
X-Received: by 2002:adf:e38f:0:b0:307:9081:d355 with SMTP id e15-20020adfe38f000000b003079081d355mr1444633wrm.26.1686413520223;
        Sat, 10 Jun 2023 09:12:00 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d4349000000b003079c402762sm7431145wrr.19.2023.06.10.09.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 09:11:59 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Sat, 10 Jun 2023 18:11:46 +0200
Subject: [PATCH net 11/17] selftests: mptcp: join: skip fullmesh flag tests
 if not supported
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-upstream-net-20230610-mptcp-selftests-support-old-kernels-part-3-v1-11-2896fe2ee8a3@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2784;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=S7UdnJ4qdCLymGYFyzykYWhOhatHjYbGlgY4hALZQAg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkhKC+xCmMmEjDr4x8Nfmu4YujlzmCdrVCWER/f
 2hJ1zmuzLyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZISgvgAKCRD2t4JPQmmg
 c9eOD/9e+ou2ZTUkv/YpCHinhIImNnS+mPi225Ia4FKa8Fe6prJGKR44qpX7rJqj9CY/UXOQLC7
 90arvoruPiDgq2/Gzf8FtevKpwP7EXOiKsKjXP5LNFuVt1C/o40dvjMG0oKqgNBbuipqQAjm+gw
 9+sZCBhIJK/DyFR8VWX4TGtVMkEMPQCOaWIh5odiNvihJI8aQVfVK4wZBwMJFoh5FvXt3gHCaYp
 fZ94ImXgxazRPKV4+o5Sro73sb+aHRYKt+QGK77iD6RzTcb4P5FUi3jKS6nz95vQXTDxc38u9xG
 2NU9eHZ62XSaK+6gZFfJxVAtW2yRMeAgyOtD6sqKsifGyxWJtBJhbF33gENJ1jsG9UvU6wUMwzg
 KAnX1NEgaVPL0f0X/PP/tp+CMtsRWFcQAcm9iIIKT3QvIZCM0oHHidGKQkMPBVu7hUMncUz5VkU
 Dvfr1QBWhDOZcY3Wm2WVFxI14qGBLiZhZXbyaaYMUCra038PrxoyV/nq+j45juX2kqqSSOQgvJm
 N9iB0t97cjtset/SIOYF59ieBs136NvuvgApCrS9Lv2676tPd+xI9MigiqmlpeNh6WYVIsGmMMT
 CFuzrKFEdzHnWi6GzybgyHXv+wJycwaDglmY9KfbQdvfcF6uxtf5ERpUclKRLUF20W/tgAhBm3Q
 A34nRtELxAGfPKA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of the fullmesh flag for the in-kernel PM
introduced by commit 2843ff6f36db ("mptcp: remote addresses fullmesh")
and commit 1a0d6136c5f0 ("mptcp: local addresses fullmesh").

It looks like there is no easy external sign we can use to predict the
expected behaviour. We could add the flag and then check if it has been
added but for that, and for each fullmesh test, we would need to setup a
new environment, do the checks, clean it and then only start the test
from yet another clean environment. To keep it simple and avoid
introducing new issues, we look for a specific kernel version. That's
not ideal but an acceptable solution for this case.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 6a0653b96f5d ("selftests: mptcp: add fullmesh setting tests")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index adbe297a95cf..f8e58ebcdd54 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3098,7 +3098,8 @@ fullmesh_tests()
 	fi
 
 	# set fullmesh flag
-	if reset "set fullmesh flag test"; then
+	if reset "set fullmesh flag test" &&
+	   continue_if mptcp_lib_kversion_ge 5.18; then
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
@@ -3108,7 +3109,8 @@ fullmesh_tests()
 	fi
 
 	# set nofullmesh flag
-	if reset "set nofullmesh flag test"; then
+	if reset "set nofullmesh flag test" &&
+	   continue_if mptcp_lib_kversion_ge 5.18; then
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
@@ -3118,7 +3120,8 @@ fullmesh_tests()
 	fi
 
 	# set backup,fullmesh flags
-	if reset "set backup,fullmesh flags test"; then
+	if reset "set backup,fullmesh flags test" &&
+	   continue_if mptcp_lib_kversion_ge 5.18; then
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
@@ -3129,7 +3132,8 @@ fullmesh_tests()
 	fi
 
 	# set nobackup,nofullmesh flags
-	if reset "set nobackup,nofullmesh flags test"; then
+	if reset "set nobackup,nofullmesh flags test" &&
+	   continue_if mptcp_lib_kversion_ge 5.18; then
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_set_limits $ns2 4 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh

-- 
2.40.1

