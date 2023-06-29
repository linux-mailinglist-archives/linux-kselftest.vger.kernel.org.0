Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6729F742B9F
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jun 2023 19:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjF2R7K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 13:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjF2R7J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 13:59:09 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4694EE49;
        Thu, 29 Jun 2023 10:59:08 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 99BFF5C030F;
        Thu, 29 Jun 2023 13:59:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 29 Jun 2023 13:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1688061547; x=1688147947; bh=zcTZxE9rpOoRkiMqNrWJKVYoGMOyFfMOjEX
        rxqdBCO0=; b=QOcUfjyvHJ6D2L3Dlwp0WTQ344bF9/0nbhpJze8piFkWG8+MkX+
        UOCg6rcslYY1EqcOC9he1B8AmiuhRwPu0c2DeD7QPI0hWv/1sYtWjycs1MDaWBfY
        mY+9LtflSl5HTTi2SXulWzPe+sOwJQGOzk7LLeObAaWQOjlLOx1Y0CImH1dXkCYa
        +p/ajyTPybxU/CG5mpPwuZ5D2CO7rrhj1mxhl9sG48oG6LGHk40C1J7Uo/WE8/zo
        y/P1NFDLv3zKD9xTfd8TYmlMsUe0+56nnDxgyNm7rksmrEnE2MqOv3KFYr9o6mb/
        6HimsdiRxljAD0epXrfU2FI5ifeO98xrRgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1688061547; x=1688147947; bh=zcTZxE9rpOoRkiMqNrWJKVYoGMOyFfMOjEX
        rxqdBCO0=; b=KvDjFlOX3It/jB2DidOzLexu8tyDdbcVc97bseorb+kgeE6Cp+t
        xGOuDCM0m5yGblZCDv8LYKshsajzIOIC8/TmFYxCcQeo/LwnR6uN2cb1t85vLXM8
        w8KWP9sQqPmxhc0iZXCacKSbIRDZUdlTzzMAWXpR18Hau423nXMoGGllJOmdsJq4
        IahcQpjXUnAKpCxqQ4CIcsk6fs+Qoyqwj6dRfDI8z1+2Wzcxqa1itwWI48h3v6Mu
        7GKFr5iEe0+FvG3kXsrrxnAJLVbgREk1y+TmVJtGh2JES8ZaDKKYTVdoU8szn/m0
        H3cBGwJOcsa3wYE24ChLDIpLLVaRKygqdsA==
X-ME-Sender: <xms:asadZDjkKMaWuDTze6cFuJbqwcwnWbMh16BQlZdyNeTgGDdC3P9hIg>
    <xme:asadZACYCVgLwjQtSadOrI9bn_iBQmGEFgioAGdIDwu78UbZ2eHW8piFHKvOnmDxC
    lzZ_eb7jn4zaeTISw>
X-ME-Received: <xmr:asadZDEQBjLJcoOU0ux7N7J5jGQEa_C4EYqpuOP4j7RmLSicnzRv7_bZd90I6ttiIqCtB3PythTSGUeEhICiJED0CWun6AZxXU-_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeggdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpeffhffvvefukfhfgggtugfgjgestheksfdt
    tddtudenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedufeeitdeiheffueffleffgeehgeejkeetkefgtdekfeej
    heffjedtgfekieetleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:asadZARXMG_Xg5rfhd2yeyDHqx1XwQBXhhaBr0DDozekyiC_-39tvw>
    <xmx:asadZAxptrHuJMR4cUkl-YO_rGhERLHkICobjSNACkhSoTozdLe1iw>
    <xmx:asadZG4eAk216siHH6UQI0kuyExIcLUmG4Ty_24wADoCLFTcg360rQ>
    <xmx:a8adZPlmja08QxHviOqdJjap12poRut-N_BKnVIyu1k6y7RXWpoQ5Q>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jun 2023 13:59:06 -0400 (EDT)
Date:   Thu, 29 Jun 2023 11:59:04 -0600
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Florian Westphal <fw@strlen.de>
Cc:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
        daniel@iogearbox.net, dsahern@kernel.org
Subject: Re: [PATCH bpf-next 0/7] Support defragmenting IPv(4|6) packets in
 BPF
Message-ID: <nk6jl4hqougwim4sfgnm6rleh64dqad6qbqghbmjcfi6o7qrae@q3jtw34azrml>
References: <cover.1687819413.git.dxu@dxuuu.xyz>
 <874jmthtiu.fsf@toke.dk>
 <20230627154439.GA18285@breakpoint.cc>
 <87o7kyfoqf.fsf@toke.dk>
 <20230629132141.GA10165@breakpoint.cc>
 <87leg2fia0.fsf@toke.dk>
 <20230629145315.GB10165@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230629145315.GB10165@breakpoint.cc>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 29, 2023 at 04:53:15PM +0200, Florian Westphal wrote:
> Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> > Florian Westphal <fw@strlen.de> writes:
> > As for the original question, that's answered by your point above: If
> > those two modules are the only ones that are likely to need this, then a
> > flag for each is fine by me - that was the key piece I was missing (I'm
> > not a netfilter expert, as you well know).
> 
> No problem, I was worried I was missing an important piece of kfunc
> plumbing :-)
> 
> You do raise a good point though.  With kfuncs, module is pinned.
> So, should a "please turn on defrag for this bpf_link" pin
> the defrag modules too?
> 
> For plain netfilter we don't do that, i.e. you can just do
> "rmmod nf_defrag_ipv4".  But I suspect that for the new bpf-link
> defrag we probably should grab a reference to prevent unwanted
> functionality breakage of the bpf prog.

Ack. Will add to v3.

Thanks,
Daniel
