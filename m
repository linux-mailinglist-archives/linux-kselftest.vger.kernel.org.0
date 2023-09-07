Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8442797734
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Sep 2023 18:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241684AbjIGQWe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Sep 2023 12:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241882AbjIGQVz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Sep 2023 12:21:55 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA9383D5;
        Thu,  7 Sep 2023 09:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YnJ5JC5iajchb3U20EbsFBAArwtwZ+ilg9vdtAjBlVw=; b=ZaV1IhBaYd9RETJxMh96lJGQl+
        wcIzXgTjKgLF2vHlQ6V3tE1+2hxq/PrtevrN+AChji9tvH/CXSD6IhZJabbluRW6IwDBeZ9cPVc2n
        jk/T8D4GfJYS935QaAGHGjVz4glBIjwRYqnWMFLp5SmAtf33Z65B5C2DEMUEfIdoD4NNuz7+fWOcV
        gm4yoOKeypl1iNcCPxV8WWi4MjVZ4BNOn21ct298oaZ/Ter6jt10FG4B4CO0nXJX+g1JqSZiT2H47
        cVmpHURYmJJO+tjUQgUVcP4JsvHEAK49upbidM7x7CPo7Tjsc+TAv7VnLiCmJHstvWex2UdWKNV3Y
        sNswkm5g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52526)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qeAXw-0001cz-23;
        Thu, 07 Sep 2023 09:39:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qeAXw-0005gq-5b; Thu, 07 Sep 2023 09:39:28 +0100
Date:   Thu, 7 Sep 2023 09:39:28 +0100
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
Subject: Re: [PATCH bpf-next v2 1/8] arm32, bpf: add support for 32-bit
 offset jmp instruction
Message-ID: <ZPmMQHwp4cyi4f+/@shell.armlinux.org.uk>
References: <20230906183320.1959008-1-puranjay12@gmail.com>
 <20230906183320.1959008-2-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906183320.1959008-2-puranjay12@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 06, 2023 at 06:33:13PM +0000, Puranjay Mohan wrote:
> The cpuv4 adds unconditional jump with 32-bit offset where the immediate
> field of the instruction is to be used to calculate the jump offset.
> 
> BPF_JA | BPF_K | BPF_JMP32 => gotol +imm => PC += imm.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
