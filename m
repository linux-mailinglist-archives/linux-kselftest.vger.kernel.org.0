Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBD4724489
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 15:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjFFNgN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 09:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbjFFNgL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 09:36:11 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696EA10EA;
        Tue,  6 Jun 2023 06:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1686058562;
        bh=SxczWj3C0sN+bBEqmoP7lrNeQ6Ge5rxR4BAb86lqCNs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pfWEGVo8XfxY0qYzq5bvQVnb6MJsLDiCcDJudFnzHd5AqDdMI5FG2WchZy6wGHC5G
         QGv4id5yFhNWebTPZiTV1kaT9KZjzjvZZEZdxzNg0FoI8DFdqs43qg/Xo6bWNXjzRm
         LLLgfQ2HrgyY8G8V3Vfns8B+XMut8gGxHXNkhd6DysYqgMLuAZbWwrVZVJeskY+iVp
         10sg/LCGoIpS56XNyVyAftfgfcyss50To3dQcAj0IV9aWhOuWuvSqqa8VIpMw9ocR2
         BWA8aDTNH2i7weu+XDY3VABVIG0dH5ECpgwAGKUA4MrvnYgiYbrfJFoGV4yJ674Caa
         vZnwfDNdIUDdQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QbBM62F78z17C5;
        Tue,  6 Jun 2023 09:36:02 -0400 (EDT)
Message-ID: <fd64bf35-8e18-8da7-d83c-882fdc60a87d@efficios.com>
Date:   Tue, 6 Jun 2023 09:36:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/4] RSEQ selftests updates
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
References: <20230515135801.15220-1-mathieu.desnoyers@efficios.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230515135801.15220-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Peter,

Can you queue those fixes through your tree ?

Thanks,

Mathieu

On 5/15/23 09:57, Mathieu Desnoyers wrote:
> Hi,
> 
> You will find in this series updates to the rseq selftests, mainly
> bringing fixes from librseq project back into the RSEQ selftests.
> 
> Thanks,
> 
> Mathieu
> 
> Mathieu Desnoyers (4):
>    selftests/rseq: Fix CID_ID typo in Makefile
>    selftests/rseq: Implement rseq_unqual_scalar_typeof
>    selftests/rseq: Fix arm64 buggy load-acquire/store-release macros
>    selftests/rseq: Use rseq_unqual_scalar_typeof in macros
> 
>   tools/testing/selftests/rseq/Makefile     |  2 +-
>   tools/testing/selftests/rseq/compiler.h   | 26 ++++++++++
>   tools/testing/selftests/rseq/rseq-arm.h   |  4 +-
>   tools/testing/selftests/rseq/rseq-arm64.h | 58 ++++++++++++-----------
>   tools/testing/selftests/rseq/rseq-mips.h  |  4 +-
>   tools/testing/selftests/rseq/rseq-ppc.h   |  4 +-
>   tools/testing/selftests/rseq/rseq-riscv.h |  6 +--
>   tools/testing/selftests/rseq/rseq-s390.h  |  4 +-
>   tools/testing/selftests/rseq/rseq-x86.h   |  4 +-
>   9 files changed, 70 insertions(+), 42 deletions(-)
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

