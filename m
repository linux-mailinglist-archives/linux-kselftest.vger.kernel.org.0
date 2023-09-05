Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CA57930ED
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 23:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243679AbjIEVcy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 17:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjIEVcx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 17:32:53 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EE19C;
        Tue,  5 Sep 2023 14:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LKja5aws2FuNbyMoiBbVd5qqc3cfPi6iSJhvodwsuqM=; b=bhse1LJf0wCvKVxWcxMHkE2xQX
        1w5p5Ls0CgbTqToctz5FOJayXxu22r1vtmpavi6mHDvw/EhXjGib6Fscu//F6EUB5d74kx6/oi/UG
        BgZ8htWEgiRNfZ3c1eUF+s8rRjhn6mh1Z99+md+APBnvyVuU0q5xkxF4nnkRVv1BkfKrtxL0RkpIM
        EQKrBeLwSPQLCfK0fxY3yWnHDq7XmgDtYXMZgtBhjxcinQFjK0y2w/ekb9o/PJKMEan8mJRGCkTkg
        x/6sGZHymUxuu/mWm4bR7iT7vE/1Jl8sVsAA/H5Kd5rxK6zZQRULsAaCu6uMz7CnK/qsweZIWS+ni
        9AsRTH0g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36498)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qddez-0008Kz-3A;
        Tue, 05 Sep 2023 22:32:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qddez-000424-EO; Tue, 05 Sep 2023 22:32:33 +0100
Date:   Tue, 5 Sep 2023 22:32:33 +0100
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
Subject: Re: [PATCH bpf-next 4/8] arm32, bpf: add support for unconditional
 bswap instruction
Message-ID: <ZPeecV807AVEkCJB@shell.armlinux.org.uk>
References: <20230905210621.1711859-1-puranjay12@gmail.com>
 <20230905210621.1711859-5-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905210621.1711859-5-puranjay12@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 05, 2023 at 09:06:17PM +0000, Puranjay Mohan wrote:
> The cpuv4 added a new unconditional bswap instruction with following
> behaviour:
> 
> BPF_ALU64 | BPF_TO_LE | BPF_END with imm = 16/32/64 means:
> dst = bswap16(dst)
> dst = bswap32(dst)
> dst = bswap64(dst)
> 
> As we already support converting to big-endian from little-endian we can
> use the same for unconditional bswap.
> Since ARM32 is always little-endian, just treat the unconditional scenario

This is not true. Arm32 BPF is disabled for BE32 but not for BE8. It's
entirely possible to build a kernel using BE8 for ARMv7 and have the
BPF JIT enabled:

        select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32

So it's not true to say "Since ARM32 is always little-endian".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
