Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9493379772E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Sep 2023 18:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240046AbjIGQWP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Sep 2023 12:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241382AbjIGQVe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Sep 2023 12:21:34 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2517A8D;
        Thu,  7 Sep 2023 09:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HP99QBggKxWC0MQc67tYwL7MaK1GG61WU4HuRZHkIzI=; b=muHwqQU5vUMmckKwuGxOBCmlU3
        Uv3bB7U+SixKIxPgm/TYAeL0J3O1bFS+U8XG3zHT7+Q+qVh0Q2aJ2cXukVxZeNc1jyvuc0SIbV70t
        w+ySfFmlUKTHr5OWhCDucIeDJB6wajQdBvZ0aslcCaSmfFm86OAS9ICkipyJi8gqq+qFjFHugyisA
        73LTIGMxjGZWkLEnDvHgGVpQOzPLZr6su0BOjeJbth0DKL2yDlmIv2WVveTtWCLcchSu6/G1OZ+9Y
        Y782YEnxUjvmPog6Z6CkwZv0YmiTCIVs40iK6YemSt8W/y1JR8HIxIDSEJPgYPrvSt5zB2rLvq0c9
        dz3xtGyA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42484)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qeAcR-0001dd-03;
        Thu, 07 Sep 2023 09:44:07 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qeAcQ-0005h0-Hr; Thu, 07 Sep 2023 09:44:06 +0100
Date:   Thu, 7 Sep 2023 09:44:06 +0100
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
Subject: Re: [PATCH bpf-next v2 2/8] arm32, bpf: add support for
 sign-extension load instruction
Message-ID: <ZPmNVrXwJ1Q75CV+@shell.armlinux.org.uk>
References: <20230906183320.1959008-1-puranjay12@gmail.com>
 <20230906183320.1959008-3-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906183320.1959008-3-puranjay12@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 06, 2023 at 06:33:14PM +0000, Puranjay Mohan wrote:
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

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

but see below...

Thanks!

> +static inline void emit_ldsx_r(const s8 dst[], const s8 src,
> +			       s16 off, struct jit_ctx *ctx, const u8 sz){
> +	const s8 *tmp = bpf2a32[TMP_REG_1];
> +	const s8 *rd = is_stacked(dst_lo) ? tmp : dst;
> +	s8 rm = src;
> +	int add_off;
> +
> +	if (!is_ldst_imm8(off, sz)) {

I think a comment here would be useful:
		/* offset does not fit in the load/store immediate,
		 * construct an ADD instruction to apply the offset.
		 */

otherwise I'm sure someone will question why we aren't handling the zero
case below... since zero will fit in the load/store immediate.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
