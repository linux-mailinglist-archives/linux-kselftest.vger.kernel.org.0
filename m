Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4DB728C41
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 02:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237546AbjFIALU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 20:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237175AbjFIALT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 20:11:19 -0400
Received: from antelope.pear.relay.mailchannels.net (antelope.pear.relay.mailchannels.net [23.83.216.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F972733
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Jun 2023 17:11:14 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E02066411C4
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 00:11:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 7F311640EA9
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 00:11:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686269465; a=rsa-sha256;
        cv=none;
        b=1cliiNdK3/rs7W8X9KsdEpAaduikx/zZQWQ1BabLyAW/2nWZhTo2NRfy4COxjKu+m7XOG7
        Rypmyn2fFgzjZqCmmgMqGyr7jO1wTYaXMlboZgVcZftYPF2Q6DNtzCMtw7+JFMwLeo6tIf
        AgN5yA8k3xy2psYGzvN9B+PaIjnYbu0O2YQYqphX9hPbQWowq3Hp2YIufWmOZUtm1lKrK/
        EVy60JS7JCV4a/VyOHWCxB6uSxs4gQxGAyDNU0aaeK1lx6AeWx5iMTY1vi8wLvoBsVQ3gn
        7VsJG8jtM7FgR/H4uvJQoyRrbJBRNOsNhh2/g29RvLY5PYaH6dG6AejQZFVO6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686269465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=RLbI/q+jNwtC3CHXt0I4xW5xpj8BgznW9VU/aHNxfd0=;
        b=HexMjbvxpHyuLkF9YWQYL3PchkOqrPDgjfzd60e4OjmFxbBjfSBLfSm1AWO9msnw2Vbmqw
        byUbrTYQF1Glr224+Wn19BfEYytth0Ne6dRMpuHdwfn4WrDYTGfLV8hq/XhsIfq2i5I2Zf
        a6XiKpYaM3uZ1jZxbuOp3Pptt3FT3Oe282Hc755v4qG/YnqI5wV4HE5AeEdFEQXxlKMzVE
        N7jebehfiiCWIsAQUP4zSJIg1d8/Yyn+JwE/Qmhpu08Yf+zOB6Ug0ch5x9EFhUdH24xW5B
        2/5WSFrCtyFmPbIBGDaq/UO2EuDkIjRkiKDFn17Ou/zD1eRYQ77baZCiWBXRHg==
ARC-Authentication-Results: i=1;
        rspamd-6f5cfd578c-jwvbw;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Soft-Broad: 13f2a5f569096219_1686269465749_424654662
X-MC-Loop-Signature: 1686269465749:1977246838
X-MC-Ingress-Time: 1686269465748
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.49 (trex/6.8.1);
        Fri, 09 Jun 2023 00:11:05 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4QchLq44TGz1qH
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Jun 2023 17:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1686269459;
        bh=RLbI/q+jNwtC3CHXt0I4xW5xpj8BgznW9VU/aHNxfd0=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=ZV0VvWueE8CSb7L2iDzEP4wufwbaN5u4R5zhLLdIi03X5t1BN8Pzu1tuw3tEoZ3f8
         77ENKM53Zmq9z1rOh4wgY5Mc22JDFdBNEvO3Tj4bqkCB60f8RfYKgcPhayh1EsGh1V
         yyjlFVGp+pigziGilygQhjOMvqfaBlUMXHQbtyrs=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0042
        by kmjvbox (DragonFly Mail Agent v0.12);
        Thu, 08 Jun 2023 17:10:58 -0700
Date:   Thu, 8 Jun 2023 17:10:58 -0700
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
Subject: [PATCH bpf v3 1/2] bpf: ensure main program has an extable
Message-ID: <d0c703a2d47d3368032c65fa70297cdcb5a16da7.1686268304.git.kjlx@templeofstupid.com>
References: <cover.1686268304.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686268304.git.kjlx@templeofstupid.com>
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

