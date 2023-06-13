Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BFE72D68F
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 02:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbjFMAo6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jun 2023 20:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239321AbjFMAos (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jun 2023 20:44:48 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1570910C2
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 17:44:45 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E07447E255D
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 00:44:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 7EE847E25D9
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 00:44:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686617081; a=rsa-sha256;
        cv=none;
        b=hoCTQA45NLqVz41ZKuP0mmA8EBuFt0nBsTgAzcgyfbPW75DRF6lK/JGQcOJiyA/vY/4w+V
        KNeVNJGbtIF8kdqPcgwfs8o3qOP+u01kbVV83KqxFEg9X4+ztMdRRMvnTie+1RCcbWVK/w
        UIIC/c7Al1F5pK9+v0Qy6zE61MUs1NSjl1+nKCaFr3eqmLKJpTwcNQN98TFf+oeDESRQB1
        IL6CpS72DMfNmB1Kh95xkpEyJuGrYUtPp75h7HFrGDyB7i5SDvdrbCYfXqNB2bE2WrdcN6
        tbPMxn9PN1lWuuLKPrKdOdWxpoJPz6thWmgDVvxOOGSByDHQtNTuWFpFAo4H7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686617081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=hHwx7Ba0o/7i8sGMU2jMvDl3Qtii6c0+2eMa3jNioQU=;
        b=eZqXajnVnCabCMa8swWfAztJmv0naHP4bvr5oTQI5B9Hc9IFXqawh6k7gLAyzonjBYHFgw
        JczXdV/FuWHN8Mvm9EkC30rv+ERiwKcfxd+Prz0M5UUeUx67QRoFEH1dRcvSy1kMRwJ3dS
        SOkWYbmM0Um46NSlPIdLP5Yuo2ohTrE429fEwrpdwqP9LwWdQuEOIf9UXGvnmh2+72S0bc
        24ZZGoLKenvOZooJEPHwQfKqDt3W+e69ekyoPeSZ455jJV6zovMZyzfMI8L1h27ynQqtiL
        8DawiD6W11O9LbOv0iH0r88M0z0A2neZvcGoHXUQ3IKFBLM+aS2XOaqWWSKrNQ==
ARC-Authentication-Results: i=1;
        rspamd-7c78575475-97xkg;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Spot-Irritate: 620912084972ef85_1686617081752_2410182552
X-MC-Loop-Signature: 1686617081752:2865450518
X-MC-Ingress-Time: 1686617081752
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.123.193.171 (trex/6.8.1);
        Tue, 13 Jun 2023 00:44:41 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4Qg8vs1nzDz4g
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 17:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1686617081;
        bh=hHwx7Ba0o/7i8sGMU2jMvDl3Qtii6c0+2eMa3jNioQU=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Bs7T50A61vSftJ/OUskXcc7QbtAU6/hxoQ1ZimtxVarYPRBQw4WPlKR94ozis/mFy
         h+CRGQSB2fgXOmzBZk43U1XNRqqZ/K4JJM72tDvPDb9I19/SuOcqPqdxevKCxyo0wm
         OuNRdTn1+W6LDLGsuBrm+9h3ZurA4FpOpcMLU2V0=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e027c
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 12 Jun 2023 17:44:40 -0700
Date:   Mon, 12 Jun 2023 17:44:40 -0700
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
        Ilya Leoshkevich <iii@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v5 1/2] bpf: ensure main program has an extable
Message-ID: <6de9b2f4b4724ef56efbb0339daaa66c8b68b1e7.1686616663.git.kjlx@templeofstupid.com>
References: <cover.1686616663.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686616663.git.kjlx@templeofstupid.com>
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
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/bpf/verifier.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0dd8adc7a159..cf5f230360f5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17217,9 +17217,10 @@ static int jit_subprogs(struct bpf_verifier_env *env)
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
@@ -17245,6 +17246,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	prog->jited = 1;
 	prog->bpf_func = func[0]->bpf_func;
 	prog->jited_len = func[0]->jited_len;
+	prog->aux->extable = func[0]->aux->extable;
+	prog->aux->num_exentries = func[0]->aux->num_exentries;
 	prog->aux->func = func;
 	prog->aux->func_cnt = env->subprog_cnt;
 	bpf_prog_jit_attempt_done(prog);
-- 
2.25.1

