Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D853172A570
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 23:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjFIVkN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 17:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjFIVkM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 17:40:12 -0400
Received: from cheetah.elm.relay.mailchannels.net (cheetah.elm.relay.mailchannels.net [23.83.212.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9C035BE
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 14:40:10 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 60CEE7E1D5E
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 21:40:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a291.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B0CBF7E2BDD
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 21:40:09 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686346809; a=rsa-sha256;
        cv=none;
        b=hc6j65DivfrCCV6bXLmM2iSPZY6eyIVsX2RW40fTs2OO3IW26U1LOtsCK8Jl5/8BcJgq2w
        Yzz/9UUSVzRtCnK8oJrl5UMSW19Z4ImISd/qJHP9RrlTOMDe8AQOxtIgRJgooKO78hZUKZ
        +U5152EqkqKCaL9nXlTAG+/swTK4FSDKOb1nY58sF8/GNUFkx7tgmkq7e08h237UFvYWLy
        3QtbCidsJTgxU19Qtcw4lgImtdmoX9k/trqdH26YhjX92Lc8OyaPllhNQDknmZTAdwB7RM
        7u8oEiFqftR7EmqeZU7+WdtpjhXsnwK2ED7ItrObJNqcw8NDa8+WpAXhUKoJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686346809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=u6VFkU8CeRSXxG9CpKygUWaCfdMHq1wUPGyeNaB+TlE=;
        b=GhBl7CUL3AqzvrfuKDAoCNg/FmGZFr6+yLlKuMORXWUoWOYFBE2m+dMl3SDfc6SKCuBd+a
        fFnfHp1tNVtF+M5P1GuCwlNpiG3v37pjhONxmV2zwylqrSBtTSYo4RV8cNVQ/Ox6HnfJde
        dQIkylEdh53Bjrc5jSC1jy2VSrUdHt9xhJtXJmKX1D7ZtpbXsmD9+VXv2JwL7Nzfbt60q8
        mJy34bVHmxDeNOJn6zaBHgbZjJcnJiDSDD0JJZ7MBJtEUpWWzh1jLAhkebKrasHsle73hD
        IHbXwqq+Ht4kqBJ74rFkDwCtcrPYZjnjlNmoFAHW7vySsr5Y8sM1UCCHsGllxg==
ARC-Authentication-Results: i=1;
        rspamd-7c78575475-xtsqr;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Towering-Relation: 37cf606d19bc44ec_1686346810218_3115947551
X-MC-Loop-Signature: 1686346810218:252784323
X-MC-Ingress-Time: 1686346810218
Received: from pdx1-sub0-mail-a291.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.48.103 (trex/6.8.1);
        Fri, 09 Jun 2023 21:40:10 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a291.dreamhost.com (Postfix) with ESMTPSA id 4QdDyJ6ddwzYN
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 14:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1686346809;
        bh=u6VFkU8CeRSXxG9CpKygUWaCfdMHq1wUPGyeNaB+TlE=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Iyv1QSXdQRbIWJQoNqScr1eFgnvlDibXQ2N/j+Rghgo11nkvnTKr+NuMf+YgJ8tYb
         AwT8Hv6fI5B9CmxFLyrB2X2or1ckwfM+ikaRFmxQNjmgV1/b0ah/DBZCvZ8356O+9l
         UegCkqq/hwdeSAjg+Rp6Sfdrrs7p8Eu6AJdRAdp0=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e00d9
        by kmjvbox (DragonFly Mail Agent v0.12);
        Fri, 09 Jun 2023 14:40:07 -0700
Date:   Fri, 9 Jun 2023 14:40:07 -0700
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
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v4 1/2] bpf: ensure main program has an extable
Message-ID: <9253ce691956f19adc93be7dc4c3a7aabe3db3de.1686345886.git.kjlx@templeofstupid.com>
References: <cover.1686345886.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686345886.git.kjlx@templeofstupid.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When subprograms are in use, the main program is not jit'd after the
subprograms because jit_subprogs sets a value for prog->bpf_func upon
success.  Subsequent calls to the JIT are bypassed when this value is
non-NULL.  This leads to a situation where the main program and its
func[0] counterpart are both in the bpf kallsyms tree, but only func[0]
has an extable.  Extables are only created during JIT.  Now there are
two nearly identical program ksym entries in the tree, but only one has
an extable.  Depending upon how the entries are placed, there's a chance
that a fault will call search_extable on the aux with the NULL entry.

Since jit_subprogs already copies state from func[0] to the main
program, include the extable pointer in this state duplication.
Additionally, ensure that the copy of the main program in func[0] is not
added to the bpf_prog_kallsyms table. Instead, let the main program get
added later in bpf_prog_load().  This ensures there is only a single
copy of the main program in the kallsyms table, and that its tag matches
the tag observed by tooling like bpftool.

Cc: stable@vger.kernel.org
Fixes: 1c2a088a6626 ("bpf: x64: add JIT support for multi-function programs")
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5871aa78d01a..b62d1fc0f92b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17214,9 +17214,10 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	}
 
 	/* finally lock prog and jit images for all functions and
-	 * populate kallsysm
+	 * populate kallsysm. Begin at the first subprogram, since
+	 * bpf_prog_load will add the kallsyms for the main program.
 	 */
-	for (i = 0; i < env->subprog_cnt; i++) {
+	for (i = 1; i < env->subprog_cnt; i++) {
 		bpf_prog_lock_ro(func[i]);
 		bpf_prog_kallsyms_add(func[i]);
 	}
@@ -17242,6 +17243,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	prog->jited = 1;
 	prog->bpf_func = func[0]->bpf_func;
 	prog->jited_len = func[0]->jited_len;
+	prog->aux->extable = func[0]->aux->extable;
 	prog->aux->func = func;
 	prog->aux->func_cnt = env->subprog_cnt;
 	bpf_prog_jit_attempt_done(prog);
-- 
2.25.1

