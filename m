Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1617930E1
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 23:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjIEVYc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 17:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjIEVYc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 17:24:32 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CF2BD;
        Tue,  5 Sep 2023 14:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+RBJLgVUDREWIJFzDxWWK30XLiLgsU765nHC8rQ9Yyw=; b=F6TDlNuM4fI7YMJzbG/8XgKzX3
        ozDbzJRyVym9Gv9OXc9wSOTPi3/x1ddUJWjW0wnsE31XbV+JfbZOzl0ee6fWJJQIwcyB3cmvgoPf7
        NlEHg1+sntq9odnIgy1tmA8LefWVfCkVbrtznv2NQcHNCxhuVRu0ABDJHxbMdoXcq9yzn9w7DWSk3
        rG5IeFQmO//qCHjYKpYdkbGTUHkGRyhD55Z7fNc7K1wvcA26AmvCimv3dHQMlsoOyWRUtm1hpUvs1
        14Xfuy8zVwPvtC8mPOKhL14DjQfGnLcfb+IJzwzUNjb26gDj49cyLP8zyh/Kh40ee+aemN7L2+Z4R
        HBYk9qWA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36086)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qddWr-0008KL-2e;
        Tue, 05 Sep 2023 22:24:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qddWr-00041p-C4; Tue, 05 Sep 2023 22:24:09 +0100
Date:   Tue, 5 Sep 2023 22:24:09 +0100
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
Subject: Re: [PATCH bpf-next 2/8] arm32, bpf: add support for sign-extension
 load instruction
Message-ID: <ZPeceR+qKgsedJ1H@shell.armlinux.org.uk>
References: <20230905210621.1711859-1-puranjay12@gmail.com>
 <20230905210621.1711859-3-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905210621.1711859-3-puranjay12@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 05, 2023 at 09:06:15PM +0000, Puranjay Mohan wrote:
> The cpuv4 added the support of an instruction that is similar to load
> but also sign-extends the result after the load.
> 
> BPF_MEMSX | <size> | BPF_LDX means dst = *(signed size *) (src + offset)
> here <size> can be one of BPF_B, BPF_H, BPF_W.
> 
> ARM32 has instructions to load a byte or a half word with sign
> extension into a 32bit register. As the JIT uses two 32 bit registers
> to simulate a 64-bit BPF register, an extra instruction is emitted to
> sign-extent the result up to the second register.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  arch/arm/net/bpf_jit_32.c | 69 ++++++++++++++++++++++++++++++++++++++-
>  arch/arm/net/bpf_jit_32.h |  2 ++
>  2 files changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
> index b26579da770e..f7c162479cf2 100644
> --- a/arch/arm/net/bpf_jit_32.c
> +++ b/arch/arm/net/bpf_jit_32.c
> @@ -333,6 +333,9 @@ static u32 arm_bpf_ldst_imm8(u32 op, u8 rt, u8 rn, s16 imm8)
>  #define ARM_LDRD_I(rt, rn, off)	arm_bpf_ldst_imm8(ARM_INST_LDRD_I, rt, rn, off)
>  #define ARM_LDRH_I(rt, rn, off)	arm_bpf_ldst_imm8(ARM_INST_LDRH_I, rt, rn, off)
>  
> +#define ARM_LDRSH_I(rt, rn, off) arm_bpf_ldst_imm8(ARM_INST_LDRSH_I, rt, rn, off)
> +#define ARM_LDRSB_I(rt, rn, off) arm_bpf_ldst_imm8(ARM_INST_LDRSB_I, rt, rn, off)
> +
>  #define ARM_STR_I(rt, rn, off)	arm_bpf_ldst_imm12(ARM_INST_STR_I, rt, rn, off)
>  #define ARM_STRB_I(rt, rn, off)	arm_bpf_ldst_imm12(ARM_INST_STRB_I, rt, rn, off)
>  #define ARM_STRD_I(rt, rn, off)	arm_bpf_ldst_imm8(ARM_INST_STRD_I, rt, rn, off)
> @@ -1026,6 +1029,24 @@ static bool is_ldst_imm(s16 off, const u8 size)
>  	return -off_max <= off && off <= off_max;
>  }
>  
> +static bool is_ldst_imm8(s16 off, const u8 size)
> +{
> +	s16 off_max = 0;
> +
> +	switch (size) {
> +	case BPF_B:
> +		off_max = 0xff;
> +		break;
> +	case BPF_W:
> +		off_max = 0xfff;
> +		break;
> +	case BPF_H:
> +		off_max = 0xff;
> +		break;
> +	}
> +	return -off_max <= off && off <= off_max;
> +}
> +
>  /* *(size *)(dst + off) = src */
>  static inline void emit_str_r(const s8 dst, const s8 src[],
>  			      s16 off, struct jit_ctx *ctx, const u8 sz){
> @@ -1105,6 +1126,45 @@ static inline void emit_ldx_r(const s8 dst[], const s8 src,
>  	arm_bpf_put_reg64(dst, rd, ctx);
>  }
>  
> +/* dst = *(signed size*)(src + off) */
> +static inline void emit_ldsx_r(const s8 dst[], const s8 src,
> +			       s16 off, struct jit_ctx *ctx, const u8 sz){
> +	const s8 *tmp = bpf2a32[TMP_REG_1];
> +	const s8 *rd = is_stacked(dst_lo) ? tmp : dst;
> +	s8 rm = src;
> +
> +	if (!is_ldst_imm8(off, sz)) {
> +		emit_a32_mov_i(tmp[0], off, ctx);
> +		emit(ARM_ADD_R(tmp[0], tmp[0], src), ctx);

Hmm. This looks inefficient when "off" is able to fit in an immediate.
Please try:

	int add_off;

	if (!is_ldst_imm8(off, sz)) {
		add_off = imm8m(off);
		if (add_off > 0) {
			emit(ARM_ADD_I(tmp[0], src, add_off), ctx);
			rm = tmp[0];
		} else {
			emit_a32_mov_i(tmp[0], off, ctx);
			emit(ARM_ADD_R(tmp[0], tmp[0], src), ctx);
			rm = tmp[0];
		}
		off = 0;
> +	} else if (rd[1] == rm) {
> +		emit(ARM_MOV_R(tmp[0], rm), ctx);
> +		rm = tmp[0];

Why do you need this? rd and rm can be the same for LDRS[BH].

> +	}
> +	switch (sz) {
> +	case BPF_B:
> +		/* Load a Byte with sign extension*/
> +		emit(ARM_LDRSB_I(rd[1], rm, off), ctx);
> +		/* Carry the sign extension to upper 32 bits */
> +		emit(ARM_ASR_I(rd[0], rd[1], 31), ctx);
> +		break;
> +	case BPF_H:
> +		/* Load a HalfWord with sign extension*/
> +		emit(ARM_LDRSH_I(rd[1], rm, off), ctx);
> +		/* Carry the sign extension to upper 32 bits */
> +		emit(ARM_ASR_I(rd[0], rd[1], 31), ctx);
> +		break;
> +	case BPF_W:
> +		/* Load a Word*/
> +		emit(ARM_LDR_I(rd[1], rm, off), ctx);
> +		/* Carry the sign extension to upper 32 bits */
> +		emit(ARM_ASR_I(rd[0], rd[1], 31), ctx);

The last instruction extending to the upper 32 bits is the same in each
of these cases, so is there any reason not to do it outside the switch
statement?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
