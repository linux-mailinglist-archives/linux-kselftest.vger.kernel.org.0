Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF3867202D
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 15:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjAROwp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Jan 2023 09:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjAROw3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Jan 2023 09:52:29 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD302386B;
        Wed, 18 Jan 2023 06:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1674053152;
        bh=jnoOetXYIGXsnxje52HdC8DNcTcXPQAKGIEjinWGQdA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tVdtZaHi3/AsRHSiU/ctzQigE1bSd5wKtpMUJaP6o9TDDW+xssa+HU9SN/VKobcFJ
         2s6yMn6TbDDtMm2MIWE6P57epomXiN0mOHVmjrcxbN+ddfuV4+Uca6fj0s+PdDWqZ2
         YzuboSSZNdFnyhVqWsytBaaU0N4xSz+HLb5BUH1MQKpr6EA46cRy/MpkCttVuE/aKV
         N8/gAyDcEc6ydp9erW2dNA1A89RDAEQCFrhIj2ga3zu2IJGfjMlmYOhY/v7A/2Hxlm
         hPvCfzeLAr/Ezn8dGIPUOBWMSmXCEBQyXJ1Yd6RLZIs89qjMBGCRB4PppWcoLkcSqE
         hI/pfiuWrBXkA==
Received: from [172.16.0.101] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NxpTr2WlfzhCY;
        Wed, 18 Jan 2023 09:45:52 -0500 (EST)
Message-ID: <a7ce23b5-c60f-e515-8a15-f4de30ebfe75@efficios.com>
Date:   Wed, 18 Jan 2023 09:46:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] KVM: selftests: Fix build of rseq test
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20230106-fix-kvm-rseq-build-v1-1-b704d9831d02@kernel.org>
 <Y8f2HA02BJNYUYc7@sirena.org.uk>
 <c8901eb2-bee5-a7b3-cd43-ace970754ade@efficios.com>
 <Y8gFutX+TaukU1BX@sirena.org.uk>
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <Y8gFutX+TaukU1BX@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-01-18 09:44, Mark Brown wrote:
> On Wed, Jan 18, 2023 at 09:30:01AM -0500, Mathieu Desnoyers wrote:
>> On 2023-01-18 08:37, Mark Brown wrote:
>>> On Fri, Jan 06, 2023 at 07:24:19PM +0000, Mark Brown wrote:
> 
>>>> The KVM rseq test is failing to build in -next due to a commit merged
>>>> from the tip tree which adds a wrapper for sys_getcpu() to the rseq
>>>> kselftests, conflicting with the wrapper already included in the KVM
>>>> selftest:
> 
>>> Any thoughts on this?  The KVM tests are still failing to build
>>> in -next:
> 
>> I'm OK with the fix you submitted in this email thread. Should it be routed
>> through -tip ?
> 
> I think so, it'll need to go along with the patch that introduced
> the new wrapper.
> 
>> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Peter, can you pick up this patch through tip ?

https://lore.kernel.org/r/20230106-fix-kvm-rseq-build-v1-1-b704d9831d02@kernel.org

Thanks,

Mathieu

> 
> Thanks.

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

