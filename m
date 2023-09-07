Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94CF797753
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Sep 2023 18:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjIGQYR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Sep 2023 12:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbjIGQIC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Sep 2023 12:08:02 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C562686;
        Thu,  7 Sep 2023 09:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kD1YyyXNG+bKprfq5aUsbhIrdAQXRAipj+bdh10wsGU=; b=R5fqY8O2CcUumwu92I2xrAwmUL
        yMLTuJVgImd3QuqAH0tF6A3Y566HtfP1Y114wlFKQQET0OJr4PIH4abLwJpaJ5OEe6T3+eUmrVakt
        yPTbl5ao/TDmrhHhDhq4VSYSnse/2m6jQp8RL7c69MzMBr4a51OfMpOK7G6krh2FY80dnTZV1ll3K
        I2RW11wNhczD+0zYkplqeuxtmqek4kcYeOTZifCnBoaboKiGe+nyTJrAvIjCr8BE/b1UlocnCUFof
        v08TR5qtkTSUbqghY4XTGtxl4qmPgfCHPZ3AbooDxRztGtWLnL5pl1uVwyaRx8v/c7WC5CF21ToZx
        nBrSed5w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36812)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qeB6R-0001lj-0o;
        Thu, 07 Sep 2023 10:15:07 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qeB6Q-0005ie-Gr; Thu, 07 Sep 2023 10:15:06 +0100
Date:   Thu, 7 Sep 2023 10:15:06 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 4/8] arm32, bpf: add support for
 unconditional bswap instruction
Message-ID: <ZPmUmqzvq1sV7r/f@shell.armlinux.org.uk>
References: <20230906183320.1959008-1-puranjay12@gmail.com>
 <20230906183320.1959008-5-puranjay12@gmail.com>
 <ZPmOUYBdRxR1/8vw@shell.armlinux.org.uk>
 <mb61pzg1y1hb5.fsf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mb61pzg1y1hb5.fsf@amazon.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 07, 2023 at 09:08:46AM +0000, Puranjay Mohan wrote:
> On Thu, Sep 07 2023, Russell King (Oracle) wrote:
> 
> > On Wed, Sep 06, 2023 at 06:33:16PM +0000, Puranjay Mohan wrote:
> >> @@ -1633,8 +1633,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
> >>  	/* dst = htobe(dst) */
> >>  	case BPF_ALU | BPF_END | BPF_FROM_LE:
> >>  	case BPF_ALU | BPF_END | BPF_FROM_BE:
> >> +	/* dst = bswap(dst) */
> >> +	case BPF_ALU64 | BPF_END | BPF_TO_LE:
> >>  		rd = arm_bpf_get_reg64(dst, tmp, ctx);
> >> -		if (BPF_SRC(code) == BPF_FROM_LE)
> >> +		if (BPF_SRC(code) == BPF_FROM_LE && BPF_CLASS(code) != BPF_ALU64)
> >
> > With the addition of the BPF_ALU64 case, I'm wondering why this if() is
> > affected. If you were adding:
> >
> > 	case BPF_ALU64 | BPF_END | BPF_FROM_LE:
> >
> > then maybe there would be a reason, but the BPF_ALU64 | BPF_END |
> > BPF_TO_LE case will never match even the original if() statement.
> 
> The reason is that these mean the same thing.
> from: include/uapi/linux/bpf.h
> 
> #define BPF_TO_LE	0x00	/* convert to little-endian */
> #define BPF_TO_BE	0x08	/* convert to big-endian */
> #define BPF_FROM_LE	BPF_TO_LE
> #define BPF_FROM_BE	BPF_TO_BE
> 
> So, to not cause confusion and follow the earlier cases I can add:
> 
> case BPF_ALU64 | BPF_END | BPF_FROM_LE:
> 
> in the next version.

It might be worth adding a comment after each stating one of:

	/* also BPF_TO_LE */
	/* also BPF_TO_BE */

as appropriate to make this more readable.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
