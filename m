Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7B9671FD5
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 15:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjAROj6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Jan 2023 09:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjAROjc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Jan 2023 09:39:32 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7691371F31;
        Wed, 18 Jan 2023 06:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1674052168;
        bh=s5FTFZUAsofXC14ZekJ4DUIt+9W4vk9LYk+7lyZybVA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ijNl1IyUFehlJE6H4lI5IceLmAHRXCeEW2NYwvXoiASmOx8zuxCDPPn1N34o8mxV5
         1As/5znwqOdDqpyHj+oGj6bhvGsc987eVdqlltVQOFqTb2g8ZwvrYh1/0eMpjKTTbf
         3z3gFmOlmnBUESkt00XjT8RGlLi7qWinU8Y5jKii7KCk/E+X+U/u/qCnFIyh7dJQ2/
         wAa7ivo74BWfRZMP7sgDa2sOa2Y9nBVkKerSH/mSvpp9Oa7xPWkrm3EiSWP5pqTuJi
         AexCW8dy/xwxpRoFKEy5CFrCjD8UO65fxEfND4ua9OTHQGyU6aF+k5t878I7giNd2m
         MJf6KAaNg2FZw==
Received: from [172.16.0.101] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Nxp6w2G03zgqQ;
        Wed, 18 Jan 2023 09:29:28 -0500 (EST)
Message-ID: <c8901eb2-bee5-a7b3-cd43-ace970754ade@efficios.com>
Date:   Wed, 18 Jan 2023 09:30:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] KVM: selftests: Fix build of rseq test
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Oliver Upton <oliver.upton@linux.dev>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20230106-fix-kvm-rseq-build-v1-1-b704d9831d02@kernel.org>
 <Y8f2HA02BJNYUYc7@sirena.org.uk>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <Y8f2HA02BJNYUYc7@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-01-18 08:37, Mark Brown wrote:
> On Fri, Jan 06, 2023 at 07:24:19PM +0000, Mark Brown wrote:
> 
>> The KVM rseq test is failing to build in -next due to a commit merged
>> from the tip tree which adds a wrapper for sys_getcpu() to the rseq
>> kselftests, conflicting with the wrapper already included in the KVM
>> selftest:
> 
> Any thoughts on this?  The KVM tests are still failing to build
> in -next:

I'm OK with the fix you submitted in this email thread. Should it be 
routed through -tip ?

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

> 
> rseq_test.c:48:13: error: conflicting types for ‘sys_getcpu’
>     48 | static void sys_getcpu(unsigned *cpu)
>        |             ^~~~~~~~~~
> In file included from rseq_test.c:23:
> ../rseq/rseq.c:82:12: note: previous definition of ‘sys_getcpu’ was here
>     82 | static int sys_getcpu(unsigned *cpu, unsigned *node)
>        |            ^~~~~~~~~~
> 
> https://storage.kernelci.org/next/master/next-20230118/arm64/defconfig/gcc-10/logs/kselftest.log

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

