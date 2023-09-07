Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE67797722
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Sep 2023 18:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjIGQVw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Sep 2023 12:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241684AbjIGQVX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Sep 2023 12:21:23 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAAA3C0A;
        Thu,  7 Sep 2023 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tYZfoQFarCr3wikOO/eo68MuRLV1cM1gy+Be4eb4RnI=; b=sWJ15AtGpMt6z1wpaWH8XMk35B
        WwVubNRfiNgca/T8Um2BKAFUjfGKrwDX1GK1DGIYat5KOLl9+875FjmhBUJv3uHgMChWCZ+C86BOC
        xTOe8jGJa/aihof0Cmb6rKHqtpMAX/3GYE3DF6qNBWCg/BeSCrhWAykXOpOzjiyv0l49AUU1hJlUi
        nq27xrPRY0VcV7ataO3iJNp4eWTXOHPYMKmYmPMmu5m+fo9YB48z3jqkuyb7T3f+JxQUTZScv6RHL
        1EozMtsI7NI1zSZ2gaRrx4ogCuMqj/L7LK0Ate7Ej3iPZZ0+wRlozKWsRjL8EkUdkva5BX6WU/SF6
        M6DPlElQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42104)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qeAdI-0001dv-0c;
        Thu, 07 Sep 2023 09:45:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qeAdI-0005h9-IK; Thu, 07 Sep 2023 09:45:00 +0100
Date:   Thu, 7 Sep 2023 09:45:00 +0100
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
Subject: Re: [PATCH bpf-next v2 3/8] arm32, bpf: add support for
 sign-extension mov instruction
Message-ID: <ZPmNjOLqC1cAMgGL@shell.armlinux.org.uk>
References: <20230906183320.1959008-1-puranjay12@gmail.com>
 <20230906183320.1959008-4-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906183320.1959008-4-puranjay12@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 06, 2023 at 06:33:15PM +0000, Puranjay Mohan wrote:
> The cpuv4 added a new BPF_MOVSX instruction that sign extends the src
> before moving it to the destination.
> 
> BPF_ALU | BPF_MOVSX sign extends 8-bit and 16-bit operands into 32-bit
> operands, and zeroes the remaining upper 32 bits.
> 
> BPF_ALU64 | BPF_MOVSX sign extends 8-bit, 16-bit, and 32-bit  operands
> into 64-bit operands.
> 
> The offset field of the instruction is used to tell the number of bit to
> use for sign-extension. BPF_MOV and BPF_MOVSX have the same code but the
> former sets offset to 0 and the later one sets the offset to 8, 16 or 32
> 
> The behaviour of this instruction is dst = (s8,s16,s32)src
> 
> On ARM32 the implementation uses LSH and ARSH to extend the 8/16 bits to
> a 32-bit register and then it is sign extended to the upper 32-bit
> register using ARSH. For 32-bit we just move it to the destination
> register and use ARSH to extend it to the upper 32-bit register.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
