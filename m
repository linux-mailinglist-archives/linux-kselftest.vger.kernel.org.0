Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FA6728C32
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 02:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbjFIAJX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 20:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbjFIAJW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 20:09:22 -0400
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEF11706
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Jun 2023 17:09:19 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 30377500BF3
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 00:09:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id AE6BD500B48
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 00:09:15 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686269355; a=rsa-sha256;
        cv=none;
        b=W3u401YWVLHooPA7ky8JTPf0tEGj1ueQowQ9HNfr6yq/UvscVO6Vxkj+T++XIk/0qopVRU
        UVQr12vyEtLnAEqrQayfwiuF+ZdxG6q0CY/Mneb8FQw2CSsxOkN70ekZuGgN0pEAYLmT6V
        CiP1AbOo8Hxl6EwXZjwItOGoPgc1ZXhYmMAH+Fa9sGQ9jeV/yoMTHJpZV6Pj5DxxaMnHOq
        X5Bm6Skg70ZEV5mlhqMLKmQDqozmkpw1PQGdRavPZxPsINnVFyktZNOSm0qMYsqNR/C13m
        MaT3zuRAR7cCTddg7KoRvkulW+UuRnkjUwuNHoAE+uUM4kJe369vpz55maKXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686269355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=lQJUql2528Cy+DS6D/lrrawtBMQvuJVlQtJ26lBfYIk=;
        b=nxCHSGRg3ZJkxRy8SBBy57H+IEcLM5Tkw0MS40CrfH8CGirPp79zFfRrFTmQCeRwKQniia
        8a1XoRqxLi5CPrtqkEBgIRf1Ub1dwswZOyKazoFnbMEJrmBwOQZQ6DDj7fS2CUaNYu1nUE
        d7QkoVPGXyMdum0i1Y9ygfxlyNa4Qb8dmA3txPkdOSqtHl2+agK614vmr68CCc5M1J46fx
        NrxI3Z7ILlECRqDfKsOKFDMb+z4jP18dvk9Ugf5sjDcDXnN1A2UxuEvB0u17+MWtlXJ/ib
        jIvnSlsFdvFRSzI0zSc4l5EQvT3nhjcJ3wkSPeNS2j63XyJlQ/TDFMzRvThbwA==
ARC-Authentication-Results: i=1;
        rspamd-fcb9f4dcf-gg558;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Army-Unite: 146eaa1e74c98d3d_1686269355927_3673106434
X-MC-Loop-Signature: 1686269355927:41386030
X-MC-Ingress-Time: 1686269355927
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.115.252.249 (trex/6.8.1);
        Fri, 09 Jun 2023 00:09:15 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4QchJq3WP6zWN
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Jun 2023 17:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1686269355;
        bh=lQJUql2528Cy+DS6D/lrrawtBMQvuJVlQtJ26lBfYIk=;
        h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
        b=dDoHPKhVC+rSbuXrQXH1ctahyAjgA25ZAMjDsDW+522psbJy33cRsO9a2Cg/4XYOi
         Ltrq5G01Y8FBynl/M4J7Vkd2TZtyVkvfX5p5/NuGhPauvEr5fCwwfu8xzC/sb8vZqG
         PipsXZb9CtdoVe3oOri82oo52gIu8s+CmmhxOwWw=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0042
        by kmjvbox (DragonFly Mail Agent v0.12);
        Thu, 08 Jun 2023 17:09:14 -0700
Date:   Thu, 8 Jun 2023 17:09:14 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, stable <stable@vger.kernel.org>
Subject: Re: [PATCH bpf v2 2/2] bpf: ensure main program has an extable
Message-ID: <20230609000914.GA4980@templeofstupid.com>
References: <cover.1686166633.git.kjlx@templeofstupid.com>
 <de425e99876dc6c344e1a4254894a3c81e71a2ec.1686166633.git.kjlx@templeofstupid.com>
 <CAADnVQJd=_OZJUWVcQH7OtaH2cv8FLsB7kBhxZANsR9O3+AfZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJd=_OZJUWVcQH7OtaH2cv8FLsB7kBhxZANsR9O3+AfZA@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 08, 2023 at 03:01:36PM -0700, Alexei Starovoitov wrote:
> On Wed, Jun 7, 2023 at 2:04 PM Krister Johansen <kjlx@templeofstupid.com> wrote:
> > Cc: stable@vger.kernel.org
> > Fixes: 1c2a088a6626 ("bpf: x64: add JIT support for multi-function programs")
> > Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> > ---
> >  kernel/bpf/verifier.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 5871aa78d01a..d6939db9fbf9 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -17242,6 +17242,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
> >         prog->jited = 1;
> >         prog->bpf_func = func[0]->bpf_func;
> >         prog->jited_len = func[0]->jited_len;
> > +       prog->aux->extable = func[0]->aux->extable;
> 
> Why not to do this hunk and what I suggested earlier: start from func=1 ?
> That will address double ksym insertion that Yonghong mentioned.

Sure thing.  Yonghong and you have convinced me.

I'll send out a v3 with all changes requested so far.

-K
