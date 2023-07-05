Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA78A74844F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jul 2023 14:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjGEMi6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jul 2023 08:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGEMi6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jul 2023 08:38:58 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A359129;
        Wed,  5 Jul 2023 05:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=NGAR6ZIiv7c024DeENENlyWBZsZPUFDDAkTK7aDiRWY=; b=Y9Kty3Q0jfYzDgiSs/NQXlUGnN
        W+HbPJJjBuYvAII4Pe+UlYF6bvoEno/MpdVEo5qDs/DjgZhw/rkm8krLK7kuGhRPz7dBfOuvRUnXs
        AjNhpvPHJMNH8tO7Ok988hVTkknYH9BCQceXNy0SsOXmMgczHROb9lm8g04l2fo6/Pxx/Nk/db4/O
        KdXGkUMDAFCFKCXtQ7OcU/JcFKVzCnsVi8huCofS68rr5QA0szwbG+IMHUgyXNj4HLEnwHYD3jmQQ
        L8yVo3194TUwCCBDanzRqJFT8sBzo2yMUrMIyT7PKUGRs81fkyZV60f+S0egXzPjjXazzTrof2sAd
        gjIRxCXQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qH1mU-000NUt-UR; Wed, 05 Jul 2023 14:38:50 +0200
Received: from [178.197.249.31] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qH1mU-000P5n-Cr; Wed, 05 Jul 2023 14:38:50 +0200
Subject: Re: [PATCH bpf-next 0/2] BPF kselftest cross-build/RISC-V fixes
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20230705113926.751791-1-bjorn@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9ee053a4-500c-2722-d822-d137648e55e5@iogearbox.net>
Date:   Wed, 5 Jul 2023 14:38:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230705113926.751791-1-bjorn@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26960/Wed Jul  5 09:29:05 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/5/23 1:39 PM, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> This series has two minor fixes, found when cross-compiling for the
> RISC-V architecture.
> 
> Some RISC-V systems do not define HAVE_EFFICIENT_UNALIGNED_ACCESS,
> which made some of tests bail out. Fix the failing tests by adding
> F_NEEDS_EFFICIENT_UNALIGNED_ACCESS.
> 
> ...and some RISC-V systems *do* define
> HAVE_EFFICIENT_UNALIGNED_ACCESS. In this case the autoconf.h was not
> correctly picked up by the build system.

Looks good, applied thanks! Any plans on working towards integrating riscv
into upstream BPF CI? Would love to see that happening. :)

Thanks,
Daniel
