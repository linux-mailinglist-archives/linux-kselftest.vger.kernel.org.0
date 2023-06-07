Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6732972707F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 23:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjFGVWK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 17:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjFGVWJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 17:22:09 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Jun 2023 14:22:08 PDT
Received: from cheetah.elm.relay.mailchannels.net (cheetah.elm.relay.mailchannels.net [23.83.212.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1528519BA
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Jun 2023 14:22:07 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 027493405C1
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Jun 2023 21:04:34 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 93919341D68
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Jun 2023 21:04:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686171873; a=rsa-sha256;
        cv=none;
        b=eGFjd6I2eaoG5z3hceeruUmTK3mcI96FXQv/X2ynaP5Sf1LXeePxizO+9KLGnPWyIkygVz
        RwdPZ5juonyMnCEj77bLZ1j/XoywPHloeHp2zTL9f6lJoN6GLFz/Nee3uaRNZT80U9Jc41
        3YYqvBq+xZh3URlQFNqGIKs4DWgdJ8Qry4yAGGPHcu9dHTeu05cjBU1n4UsnnXqG7Yxfc/
        6TkTZ8fh4ustKNueceNPZxHItHot2mzv2lc3UKownbuHrDM9MaTzICcCtujb1eG3ZgsdA9
        0a8Mf1/7zyx89WGZADlL687OOrQtPGWN2UdFr8ZTnJE8pM9O4EwUcmySOPoXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686171873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=GNnQmH+wS+zURx3eyS+tueWtQk84sc6MMvTdEAlLPgk=;
        b=i6d5PtONtLMGQMbAuvpFETAKfGOEEczPydFUlSmgb2G+VN33UAApUHTf0apf7BHnDZpNp1
        w+AGNVBvivDK8wlLL3sYnq3XcYB9Ed6A5vpiwLylWwWaP+yQbbjzkkBTKQWCvXAMwc9c14
        Jcn2httvqCwlrgIP+ixsMG7LL7zpyjPRSNeSSPSaeiX/iT8SaYfKDDsYW8OGC1su6fDBF6
        cKHi6sqtYEcsnW0/KJ+Epnk9e4cbQk5kWQWzqg4OjGdi8seG6g3vGbRar5BfIsrk0Iphr+
        RwXNbO30mDzpQt3SUvaPnLwxSosDgwTnE2IgevNx2OraZBsqfSDwDyoa2rt6Ig==
ARC-Authentication-Results: i=1;
        rspamd-6f5cfd578c-qjfqd;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Supply-Wiry: 336ba39254bd7b17_1686171873818_3232545307
X-MC-Loop-Signature: 1686171873818:509787909
X-MC-Ingress-Time: 1686171873818
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.59.22 (trex/6.8.1);
        Wed, 07 Jun 2023 21:04:33 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4Qc0G86Phczfv
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Jun 2023 14:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1686171872;
        bh=GNnQmH+wS+zURx3eyS+tueWtQk84sc6MMvTdEAlLPgk=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=S9bzB4RJPOCOTOBe1eHyTI2ybvqkq7haGr0inpIci+G56RBFJf1PH6YsHOAlTxm0N
         qB15gt4jUq4eDHjdp9QECico3dubCY4Lmd5qPH20vn8Io3UlzN+0xHouAGzOZy41CS
         f/BbPxLP8Ea87E2RvSCJ3ehO1sNJ1Tfml7i+ckzM=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e005f
        by kmjvbox (DragonFly Mail Agent v0.12);
        Wed, 07 Jun 2023 14:04:31 -0700
Date:   Wed, 7 Jun 2023 14:04:31 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH bpf v2 2/2] bpf: ensure main program has an extable
Message-ID: <de425e99876dc6c344e1a4254894a3c81e71a2ec.1686166633.git.kjlx@templeofstupid.com>
References: <cover.1686166633.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686166633.git.kjlx@templeofstupid.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When bpf subprograms are in use, the main program is not jit'd after the
subprograms because jit_subprogs sets a value for prog->bpf_func upon
success.  Subsequent calls to the JIT are bypassed when this value is
non-NULL.  This leads to a situation where the main program and its
func[0] counterpart are both in the bpf kallsyms tree, but only func[0]
has an extable.  Extables are only created during JIT.  Now there are
two nearly identical program ksym entries in the tree, but only one has
an extable.  Depending upon how the entries are placed, there's a chance
that a fault will call search_extable on the aux with the NULL entry.

Since jit_subprogs already copies state from func[0] to the main
program, include the extable pointer in this state duplication.  The
alternative is to skip adding the main program to the bpf_kallsyms
table, but that would mean adding a check for subprograms into the
middle of bpf_prog_load.

Cc: stable@vger.kernel.org
Fixes: 1c2a088a6626 ("bpf: x64: add JIT support for multi-function programs")
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5871aa78d01a..d6939db9fbf9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17242,6 +17242,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	prog->jited = 1;
 	prog->bpf_func = func[0]->bpf_func;
 	prog->jited_len = func[0]->jited_len;
+	prog->aux->extable = func[0]->aux->extable;
 	prog->aux->func = func;
 	prog->aux->func_cnt = env->subprog_cnt;
 	bpf_prog_jit_attempt_done(prog);
-- 
2.25.1

