Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353CA7930C8
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 23:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjIEVMN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 17:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjIEVMM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 17:12:12 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E098BC;
        Tue,  5 Sep 2023 14:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=POHH1s69OZhhIoly8t+gHQRa+V14TkySJxr8REu5gqQ=; b=zR/9kXm2gyEwHdmXtLo4N29tnk
        VpAcVPhEJVu1YP9clUMfPMr+FcFTM4ex6FLG3SmVsJtYKTBW3xQONz/Nb33tEXRPNOrONBcVc9uQS
        nLLSGhtKpukeelvISUmt8UCUsf6kt64ZTMjtuJ6QKp8SFkdOTZyyBDifZjoa1nN24UlvDIhOQ+zBj
        rcwePqCnF+OZ6deh1A1xj2AjblRIEfLWtDgHorAafsGsTpeddCq+rYFS0LE2HlbrOQz8MRrVjbFrU
        CP4hNEoAb2PyikZJ2CcnB0hI/Ldc0UnbtTSwt0EYa5Wpy+OpaOT/7p8JDgfZ01LsTacAiCGSkzE/y
        gGHTT41w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34224)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qddKh-0008JM-0q;
        Tue, 05 Sep 2023 22:11:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qddKg-00041Y-5F; Tue, 05 Sep 2023 22:11:34 +0100
Date:   Tue, 5 Sep 2023 22:11:34 +0100
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
Subject: Re: [PATCH bpf-next 1/8] arm32, bpf: add support for 32-bit offset
 jmp instruction
Message-ID: <ZPeZhhAciDRgGL+s@shell.armlinux.org.uk>
References: <20230905210621.1711859-1-puranjay12@gmail.com>
 <20230905210621.1711859-2-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905210621.1711859-2-puranjay12@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 05, 2023 at 09:06:14PM +0000, Puranjay Mohan wrote:
> The cpuv4 adds unconditional jump with 32-bit offset where the immediate
> field of the instruction is to be used to calculate the jump offset.
> 
> BPF_JA | BPF_K | BPF_JMP32 => gotol +imm => PC += imm.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  arch/arm/net/bpf_jit_32.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
> index 6a1c9fca5260..b26579da770e 100644
> --- a/arch/arm/net/bpf_jit_32.c
> +++ b/arch/arm/net/bpf_jit_32.c
> @@ -1761,10 +1761,15 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
>  		break;
>  	/* JMP OFF */
>  	case BPF_JMP | BPF_JA:
> +	case BPF_JMP32 | BPF_JA:
>  	{
> -		if (off == 0)
> +		if (BPF_CLASS(code) == BPF_JMP32 && imm != 0)
> +			jmp_offset = bpf2a32_offset(i + imm, i, ctx);
> +		else if (BPF_CLASS(code) == BPF_JMP &&  off != 0)

Please tidy up the coding style - one space between "&&" and "off"

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
