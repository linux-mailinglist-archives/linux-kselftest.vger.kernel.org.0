Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316A373FFF9
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 17:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjF0PpB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 11:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjF0Por (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 11:44:47 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34E4E68;
        Tue, 27 Jun 2023 08:44:45 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qEArv-00056u-Ur; Tue, 27 Jun 2023 17:44:39 +0200
Date:   Tue, 27 Jun 2023 17:44:39 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Toke =?iso-8859-15?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, coreteam@netfilter.org,
        netfilter-devel@vger.kernel.org, fw@strlen.de,
        daniel@iogearbox.net, dsahern@kernel.org
Subject: Re: [PATCH bpf-next 0/7] Support defragmenting IPv(4|6) packets in
 BPF
Message-ID: <20230627154439.GA18285@breakpoint.cc>
References: <cover.1687819413.git.dxu@dxuuu.xyz>
 <874jmthtiu.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874jmthtiu.fsf@toke.dk>
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
> > The basic idea is we bump a refcnt on the netfilter defrag module and
> > then run the bpf prog after the defrag module runs. This allows bpf
> > progs to transparently see full, reassembled packets. The nice thing
> > about this is that progs don't have to carry around logic to detect
> > fragments.
> 
> One high-level comment after glancing through the series: Instead of
> allocating a flag specifically for the defrag module, why not support
> loading (and holding) arbitrary netfilter modules in the UAPI?

How would that work/look like?

defrag (and conntrack) need special handling because loading these
modules has no effect on the datapath.

Traditionally, yes, loading was enough, but now with netns being
ubiquitous we don't want these to get enabled unless needed.

Ignoring bpf, this happens when user adds nftables/iptables rules
that check for conntrack state, use some form of NAT or use e.g. tproxy.

For bpf a flag during link attachment seemed like the best way
to go.

At the moment I only see two flags for this, namely
"need defrag" and "need conntrack".

For conntrack, we MIGHT be able to not need a flag but
maybe verifier could "guess" based on kfuncs used.

But for defrag, I don't think its good to add a dummy do-nothing
kfunc just for expressing the dependency on bpf prog side.
