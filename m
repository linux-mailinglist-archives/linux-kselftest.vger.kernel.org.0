Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DF0794354
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 20:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbjIFS4k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 14:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjIFS4k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 14:56:40 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50AEB2;
        Wed,  6 Sep 2023 11:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wGVu+H0nJ0Nv4MtAJyw2wEgIkDxNR2bIfl7bbVzTes0=; b=Qbn96ZifpLepP1pc/98Pnkczx4
        Z12NdtNb2jZyTWjC4x9Rt3W0K3mNWpryN/x+nBLJV2K3tg7lWDy/jVIU54ti8ejzSf1dWzjRyP5sf
        VZWwq6EqoCaT5PCZyy7dEebwKxefyU6YPaPDaXT28lh9TFQD/TK4KwV/70Wbjko5oQ0XmxOQBdP2o
        l0R0KPVSkJ322+Vvv+iP6E95gZ9sLsZYjmaNJa1ri6xT8dRpxZa66QuPdkDOszCSu4zH+DGv89JFO
        D+oDRPrjy5e2Qm6TcJkzIXGdcG8CHbv54pGid8/u7NaGrybZu6ROeFwwiKxqbf3UeSfX2RajnYMvF
        Ehj9JYJQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54108)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qdxhB-0000x1-1i;
        Wed, 06 Sep 2023 19:56:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qdxhA-00052G-Be; Wed, 06 Sep 2023 19:56:08 +0100
Date:   Wed, 6 Sep 2023 19:56:08 +0100
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
Subject: Re: [PATCH bpf-next 6/8] arm32, bpf: add support for 64 bit division
 instruction
Message-ID: <ZPjLSHG7JToLWvmT@shell.armlinux.org.uk>
References: <20230905210621.1711859-1-puranjay12@gmail.com>
 <20230905210621.1711859-7-puranjay12@gmail.com>
 <ZPein8oS5egqGwzp@shell.armlinux.org.uk>
 <mb61po7if3b0w.fsf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mb61po7if3b0w.fsf@amazon.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 06, 2023 at 09:29:19AM +0000, Puranjay Mohan wrote:
> On Tue, Sep 05 2023, Russell King (Oracle) wrote:
> 
> > On Tue, Sep 05, 2023 at 09:06:19PM +0000, Puranjay Mohan wrote:
> Actually, there can also be a situation where rd[1] != ARM_R0 && rd[1] != ARM_R2,
> so should I do it like:
> 
>  	if (rd[1] != ARM_R0 && rd[1] != ARM_R2) {
>  		emit(ARM_POP(BIT(ARM_R0) | BIT(ARM_R1)), ctx);
>  		emit(ARM_POP(BIT(ARM_R2) | BIT(ARM_R3)), ctx);      
>  	} else if (rd[1] != ARM_R0) {
>  		emit(ARM_POP(BIT(ARM_R0) | BIT(ARM_R1)), ctx);
>  		emit(ARM_ADD_I(ARM_SP, ARM_SP, 8), ctx);
>  	} else if (rd[1] != ARM_R2) {
>  		emit(ARM_ADD_I(ARM_SP, ARM_SP, 8), ctx);
>  		emit(ARM_POP(BIT(ARM_R2) | BIT(ARM_R3)), ctx);
>  	} else {
>  		emit(ARM_ADD_I(ARM_SP, ARM_SP, 16), ctx);
>  	}

Are you sure all four states are possible?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
