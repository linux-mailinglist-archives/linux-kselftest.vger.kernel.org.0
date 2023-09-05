Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA22793145
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 23:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbjIEVup (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 17:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbjIEVun (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 17:50:43 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750828E;
        Tue,  5 Sep 2023 14:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RjYVcovQwGIMChPsBzWzCng27uL6Qkw1MCKSw167nPA=; b=nDLyRYzrfXZV7kll8VOiusPyIj
        Vw8Xt7G3BJI623eee8WWL1accKvcttauaIegcAvZVTbx3WY1OVFIRcBr0ZK1d/N6wuiSckWcF71uB
        WEBNFOIQOTV6zykQbB1S7aPI6/fnByGGxA141STaAYXHZbpXCWIqW+Rdmi5tbVZnITRW5+Piku+gM
        aKmCRKZuGjaAL5cZuM632Mrim/EOXGpC+zjcdQwWbhx/vp6JnJsm/BF7P20t995jFfm1TCloy8tUV
        a4cMNB0t6OTsajdOxnxeHA577PqWnPhGryEaxCpsNw8LMTy4TDpl8WUi3ydRwpDYfhGImvK3ingEH
        5CbHHnYQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42980)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qddwG-0008MI-0q;
        Tue, 05 Sep 2023 22:50:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qddwF-00043J-8o; Tue, 05 Sep 2023 22:50:23 +0100
Date:   Tue, 5 Sep 2023 22:50:23 +0100
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
Message-ID: <ZPein8oS5egqGwzp@shell.armlinux.org.uk>
References: <20230905210621.1711859-1-puranjay12@gmail.com>
 <20230905210621.1711859-7-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905210621.1711859-7-puranjay12@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 05, 2023 at 09:06:19PM +0000, Puranjay Mohan wrote:
> +cont:
> +
> +	/* Call appropriate function */
> +	if (sign)
> +		emit_mov_i(ARM_IP, op == BPF_DIV ? (u32)jit_sdiv64 : (u32)jit_smod64, ctx);
> +	else
> +		emit_mov_i(ARM_IP, op == BPF_DIV ? (u32)jit_udiv64 : (u32)jit_mod64, ctx);

Same comment as the previous patch here.

> +
> +	emit_blx_r(ARM_IP, ctx);
> +
> +	/* Save return value */
> +	if (rd[1] != ARM_R0) {
> +		emit(ARM_MOV_R(rd[0], ARM_R1), ctx);
> +		emit(ARM_MOV_R(rd[1], ARM_R0), ctx);
> +	}
> +
> +	/* Recover {R1, R0} from stack if it is not Rd */
> +	if (rd[1] != ARM_R0)
> +		emit(ARM_POP(BIT(ARM_R0) | BIT(ARM_R1)), ctx);
> +	else
> +		emit(ARM_ADD_I(ARM_SP, ARM_SP, 8), ctx);
> +
> +	/* Recover {R3, R2} from stack if it is not Rd */
> +	if (rd[1] != ARM_R2)
> +		emit(ARM_POP(BIT(ARM_R2) | BIT(ARM_R3)), ctx);
> +	else
> +		emit(ARM_ADD_I(ARM_SP, ARM_SP, 8), ctx);

	if (rd[1] != ARM_R0) {
		emit(ARM_POP(BIT(ARM_R0) | BIT(ARM_R1)), ctx);
		emit(ARM_ADD_I(ARM_SP, ARM_SP, 8), ctx);
	} else if (rd[1] != ARM_R2) {
		emit(ARM_ADD_I(ARM_SP, ARM_SP, 8), ctx);
		emit(ARM_POP(BIT(ARM_R2) | BIT(ARM_R3)), ctx);
	} else {
		emit(ARM_ADD_I(ARM_SP, ARM_SP, 16), ctx);
	}

Hmm?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
