Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7F67428E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jun 2023 16:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjF2OxW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 10:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjF2OxV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 10:53:21 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595152D62;
        Thu, 29 Jun 2023 07:53:20 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qEt1H-0007I0-3C; Thu, 29 Jun 2023 16:53:15 +0200
Date:   Thu, 29 Jun 2023 16:53:15 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Toke =?iso-8859-15?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Florian Westphal <fw@strlen.de>, Daniel Xu <dxu@dxuuu.xyz>,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
        daniel@iogearbox.net, dsahern@kernel.org
Subject: Re: [PATCH bpf-next 0/7] Support defragmenting IPv(4|6) packets in
 BPF
Message-ID: <20230629145315.GB10165@breakpoint.cc>
References: <cover.1687819413.git.dxu@dxuuu.xyz>
 <874jmthtiu.fsf@toke.dk>
 <20230627154439.GA18285@breakpoint.cc>
 <87o7kyfoqf.fsf@toke.dk>
 <20230629132141.GA10165@breakpoint.cc>
 <87leg2fia0.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87leg2fia0.fsf@toke.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> Florian Westphal <fw@strlen.de> writes:
> As for the original question, that's answered by your point above: If
> those two modules are the only ones that are likely to need this, then a
> flag for each is fine by me - that was the key piece I was missing (I'm
> not a netfilter expert, as you well know).

No problem, I was worried I was missing an important piece of kfunc
plumbing :-)

You do raise a good point though.  With kfuncs, module is pinned.
So, should a "please turn on defrag for this bpf_link" pin
the defrag modules too?

For plain netfilter we don't do that, i.e. you can just do
"rmmod nf_defrag_ipv4".  But I suspect that for the new bpf-link
defrag we probably should grab a reference to prevent unwanted
functionality breakage of the bpf prog.
