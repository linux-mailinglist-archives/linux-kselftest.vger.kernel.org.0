Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE037139B2
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 May 2023 15:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjE1Np4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 May 2023 09:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjE1Np4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 May 2023 09:45:56 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB887B1;
        Sun, 28 May 2023 06:45:54 -0700 (PDT)
Date:   Sun, 28 May 2023 15:45:35 +0200 (GMT+02:00)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1685281552; bh=TNSOyj/R8fRwL21orChWBpSrPcruLGOuSxC646omTOA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=CVfO9Pj1iezqL/76Vf1+9NQyZKUbHT4Arq7S+cTYS0BiJTkkMSVxTlA4bl5tDYX4X
         gA5L3UqFK3jEuNrZaHF6lqM5nCC3mzKTwPGgTmxjPR/k+mGZGtlVvUzxOs4B4fat+W
         Ua4VrvX3sD/pOPnEB5PRBnMLjFWeEaa0a39dhlcQ=
From:   =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Message-ID: <b25f79f0-a8fb-428a-ad54-fc4afe0df6ff@t-8ch.de>
In-Reply-To: <20230528103957.318267-1-falcon@tinylab.org>
References: <20230528075955.GE1956@1wt.eu> <20230528103957.318267-1-falcon@tinylab.org>
Subject: Re: [PATCH 00/13] tools/nolibc: riscv: Add full rv32 support
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <b25f79f0-a8fb-428a-ad54-fc4afe0df6ff@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,


May 28, 2023 12:40:31 Zhangjin Wu <falcon@tinylab.org>:

> Hi, Willy
>
>> Hi Zhangjin,
>>
>> On Thu, May 25, 2023 at 01:33:14AM +0800, Zhangjin Wu wrote:
>>> Hi, Willy
>>>
>>> Thanks very mush for your kindly review, discuss and suggestion, now we
>>> get full rv32 support ;-)
>>>
>>> In the first series [1], we have fixed up the compile errors about
>>> _start and __NR_llseek for rv32, but left compile errors about tons of
>>> time32 syscalls (removed after kernel commit d4c08b9776b3 ("riscv: Use
>>> latest system call ABI")) and the missing fstat in nolibc-test.c [2],
>>> now we have fixed up all of them.
>>
>> (...)
>>
>> I have read the comments that others made on the series and overall
>> agree. I've seen that you intend to prepare a v2. I think we must
>> first decide how to better deal with emulated syscalls as I said in
>> an earlier message. Probably that we should just add a specific test
>> case for EFAULT in nolibc-test since it's the only one (I think) that
>> risks to trigger crashes with emulated syscalls. We could also imagine
>> dealing with the signal ourselves but I'm not that keen on going to
>> implement signal() & longjmp() for now :-/
>>
>
> Yes, user-space signal() may be the right direction, we just need to let
> user-space not crash the kernel, what about this 'solution' for current stage
> (consider the pure time64 support too):

If you did manage to crash the actual kernel than that would be a bug in the kernel that needs to be fixed.
Feel free to describe how it happened and I'll take a look.

Thomas
