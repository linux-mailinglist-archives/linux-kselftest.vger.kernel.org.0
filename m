Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A109798427
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 10:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjIHIgl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 04:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjIHIgk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 04:36:40 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB26C173B;
        Fri,  8 Sep 2023 01:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bAIlNlhSV1vyCOAvZ0nrlCVU+qTundSRL1Lq1G06UzQ=; b=gTaNmUqodxA7w0bp9tF29M1hyU
        ChQH1P4/YxuWR5GtCnihZaBtrzFmFc4r9ix/MbSbSERy078XQHUTEbxJn0L3vb0hQsKy/ishrdGrp
        PbedoLIyM/F3CEunWh+oFhVx7aD4TxZ0ZroRkj+tjsdE8c925Y62zebaSWEjiUYzxU8MJHr7Z0day
        M9XB22CVADPIZUGLDTtwyDOMXpMiQYjPnTvfO8lghM0kaNqVMtasooz+rLxnxWhFv6rvUQYiVEkM/
        AS4pZasAnWNCQ2Ao4Gr16ZCxqIzYo1MNHIBtw2AM4B7nP/FntCZhHiTGZOMZplg7COE18ojqj9wFK
        hNaIBJ7g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60418)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qeWyT-0004jo-0U;
        Fri, 08 Sep 2023 09:36:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qeWyT-0006jV-7w; Fri, 08 Sep 2023 09:36:21 +0100
Date:   Fri, 8 Sep 2023 09:36:21 +0100
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
Subject: Re: [PATCH bpf-next v3 6/9] arm32, bpf: add support for 64 bit
 division instruction
Message-ID: <ZPrdBeHZp8nsBsRq@shell.armlinux.org.uk>
References: <20230907230550.1417590-1-puranjay12@gmail.com>
 <20230907230550.1417590-7-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907230550.1417590-7-puranjay12@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 07, 2023 at 11:05:47PM +0000, Puranjay Mohan wrote:
> ARM32 doesn't have instructions to do 64-bit/64-bit divisions. So, to
> implement the following instructions:
> BPF_ALU64 | BPF_DIV
> BPF_ALU64 | BPF_MOD
> BPF_ALU64 | BPF_SDIV
> BPF_ALU64 | BPF_SMOD
> 
> We implement the above instructions by doing function calls to div64_u64()
> and div64_u64_rem() for unsigned division/mod and calls to div64_s64()
> for signed division/mod.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
