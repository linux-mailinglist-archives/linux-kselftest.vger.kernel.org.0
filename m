Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E404A79312F
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 23:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbjIEVp1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 17:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239813AbjIEVpF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 17:45:05 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD82E6C;
        Tue,  5 Sep 2023 14:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RP2BcEn+8aFlLrX6eNmHsSCtG2o4XwjdTT8CiBk75TQ=; b=fmI5Poa0e3rVT26hXT4IYeXNes
        COX4kzs+V+Q2MdyE7h0bAPQVgPZuCraUA0GErDDGwEdc1YNTAOmH6JJAGEOmtNCaTTRa80mZdjZyQ
        fN7wOSSvGRrJAckYvF30str23qCcIl20HSaRZ7PW1RTqlBkt6R6HyDiYHbVXCWS7IQ8LU8pvv3bRL
        kEdWaecsPofZNgwV+h5xMmXLJZMv2xvnJdFEuXRjpsiatdr15SBcNmn80iCV0fYG9gIs8XtIDEjLQ
        8OWd/GbioQ16zR+smRrsO5RY5CEkMuJSmd50zzGTE4WXGcL8xixGJVLYRnDAaY0gtW/gLqS5zV6EG
        WQQ0SI3A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47972)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qddqH-0008Lh-1X;
        Tue, 05 Sep 2023 22:44:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qddqG-000436-Pu; Tue, 05 Sep 2023 22:44:12 +0100
Date:   Tue, 5 Sep 2023 22:44:12 +0100
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
Subject: Re: [PATCH bpf-next 5/8] arm32, bpf: add support for 32-bit signed
 division
Message-ID: <ZPehLN6cUFL+AT/B@shell.armlinux.org.uk>
References: <20230905210621.1711859-1-puranjay12@gmail.com>
 <20230905210621.1711859-6-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905210621.1711859-6-puranjay12@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 05, 2023 at 09:06:18PM +0000, Puranjay Mohan wrote:
> The cpuv4 added a new BPF_SDIV instruction that does signed division.
> The encoding is similar to BPF_DIV but BPF_SDIV sets offset=1.
> 
> ARM32 already supports 32-bit BPF_DIV which can be easily extended to
> support BPF_SDIV as ARM32 has the SDIV instruction. When the CPU is not
> ARM-v7, we implement that SDIV/SMOD with the function call similar to
> the implementation of DIV/MOD.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  arch/arm/net/bpf_jit_32.c | 26 ++++++++++++++++++++------
>  arch/arm/net/bpf_jit_32.h |  2 ++
>  2 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
> index 09496203f13e..f580ecf75710 100644
> --- a/arch/arm/net/bpf_jit_32.c
> +++ b/arch/arm/net/bpf_jit_32.c
> @@ -228,6 +228,16 @@ static u32 jit_mod32(u32 dividend, u32 divisor)
>  	return dividend % divisor;
>  }
>  
> +static s32 jit_sdiv32(s32 dividend, s32 divisor)
> +{
> +	return dividend / divisor;
> +}
> +
> +static s32 jit_smod32(s32 dividend, s32 divisor)
> +{
> +	return dividend % divisor;
> +}
> +
>  static inline void _emit(int cond, u32 inst, struct jit_ctx *ctx)
>  {
>  	inst |= (cond << 28);
> @@ -477,7 +487,7 @@ static inline int epilogue_offset(const struct jit_ctx *ctx)
>  	return to - from - 2;
>  }
>  
> -static inline void emit_udivmod(u8 rd, u8 rm, u8 rn, struct jit_ctx *ctx, u8 op)
> +static inline void emit_udivmod(u8 rd, u8 rm, u8 rn, struct jit_ctx *ctx, u8 op, u8 sign)
>  {
>  	const int exclude_mask = BIT(ARM_R0) | BIT(ARM_R1);
>  	const s8 *tmp = bpf2a32[TMP_REG_1];
> @@ -485,9 +495,10 @@ static inline void emit_udivmod(u8 rd, u8 rm, u8 rn, struct jit_ctx *ctx, u8 op)
>  #if __LINUX_ARM_ARCH__ == 7
>  	if (elf_hwcap & HWCAP_IDIVA) {
>  		if (op == BPF_DIV)
> -			emit(ARM_UDIV(rd, rm, rn), ctx);
> +			sign ? emit(ARM_SDIV(rd, rm, rn), ctx) : emit(ARM_UDIV(rd, rm, rn), ctx);

Oh no, let's not go using the ternary operator like that. If we want
to use the ternary operator, then:

			emit(sign ? ARM_SDIV(rd, rm, rn) :
				    ARM_UDIV(rd, rm, rn), ctx);

would be _much_ better, since what is actually conditional is the value
passed to emit().

If we want to avoid the ternary operator altogether, then obviously
if() emit() else emit(), but I'd prefer my suggestion above.
>  	/* Call appropriate function */
> -	emit_mov_i(ARM_IP, op == BPF_DIV ?
> -		   (u32)jit_udiv32 : (u32)jit_mod32, ctx);
> +	if (sign)
> +		emit_mov_i(ARM_IP, op == BPF_DIV ? (u32)jit_sdiv32 : (u32)jit_smod32, ctx);
> +	else
> +		emit_mov_i(ARM_IP, op == BPF_DIV ? (u32)jit_udiv32 : (u32)jit_mod32, ctx);

	u32 dst;

	if (sign) {
		if (op == BPF_DIV)
			dst = (u32)jit_sdiv32;
		else
			dst = (u32)jit_smod32;
	} else {
		if (op == BPF_DIV)
			dst = (u32)jit_udiv32;
		else
			dst = (u32)hit_mod32;
	}

	emit_mov_i(ARM_IP, dst, dtx);
>  	emit_blx_r(ARM_IP, ctx);
>  
>  	/* Restore caller-saved registers from stack */

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
