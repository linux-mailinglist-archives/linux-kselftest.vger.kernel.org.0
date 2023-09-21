Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6727AA5BC
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Sep 2023 01:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjIUXl1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 19:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIUXl1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 19:41:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B992F4;
        Thu, 21 Sep 2023 16:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1695339675;
        bh=bX9898W4DHPQgbdu2jfMPofkblqEnbzz8c5KFbbLPQo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Vjmw/9YrBmUs0JBH+tAWqE9VhYUn3cMu5lM0EfxOQue+11jQZrl0pH4fF+Ltn7OB0
         3nZ0f/C4LA/joz4t/E2YSTguB8y1fObmI1qPuBYWtdQ+GH93vhfjpPjaDbUe9ERx6s
         7R1T061RtAE1Jca/jkf8XQuBV1hBRmpMPp+2cSILJ9cRJIrR1GXs/z3CmzXz04JQ70
         3tir4+ZCgGBAeQyv7MWI6tLr6GlSMUtt4plxAsAdJk8x4faRB5U1/esdDkfUg63ovL
         D168caCBRrYAgLOWZsDUbeKeHT2D/kx3pW3E+FCHp6J/UCCiWjk/uiePxRM1aNedT/
         z02ajjQYfmbJQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RsBk31wB3z4wy2;
        Fri, 22 Sep 2023 09:41:15 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Aboorva Devarajan <aboorvad@linux.vnet.ibm.com>
Cc:     sshegde@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        npiggin@gmail.com, rmclure@linux.ibm.com, arnd@arndb.de,
        joel@jms.id.au, shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        pratik.r.sampat@gmail.com
Subject: Re: [RFC v3 1/2] powerpc/cpuidle: cpuidle wakeup latency based on
 IPI and timer events
In-Reply-To: <50798cd4558299eb62e2c3a11e367a6dbe11f915.camel@linux.vnet.ibm.com>
References: <20230911053620.87973-1-aboorvad@linux.vnet.ibm.com>
 <20230911053620.87973-2-aboorvad@linux.vnet.ibm.com>
 <87a5trvw88.fsf@mail.lhotse>
 <50798cd4558299eb62e2c3a11e367a6dbe11f915.camel@linux.vnet.ibm.com>
Date:   Fri, 22 Sep 2023 09:41:14 +1000
Message-ID: <87r0mrm6w5.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Aboorva Devarajan <aboorvad@linux.vnet.ibm.com> writes:
> On Wed, 2023-09-13 at 08:54 +1000, Michael Ellerman wrote:
>> Aboorva Devarajan <aboorvad@linux.vnet.ibm.com> writes:
>> > From: Pratik R. Sampat <psampat@linux.ibm.com>
>> > 
>> > Introduce a mechanism to fire directed IPIs from a source CPU to a
>> > specified target CPU and measure the time incurred on waking up the
>> > target CPU in response.
>> > 
>> > Also, introduce a mechanism to queue a hrtimer on a specified CPU
>> > and
>> > subsequently measure the time taken to wakeup the CPU.
>> > 
>> > Define a simple debugfs interface that allows for adjusting the
>> > settings to trigger IPI and timer events on a designated CPU, and
>> > to
>> > observe the resulting cpuidle wakeup latencies.
>> > 
>> > Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>> > Signed-off-by: Pratik R. Sampat <psampat@linux.ibm.com>
>> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.vnet.ibm.com>
>> > ---
>> >  arch/powerpc/Kconfig.debug                 |  10 ++
>> >  arch/powerpc/kernel/Makefile               |   1 +
>> >  arch/powerpc/kernel/test_cpuidle_latency.c | 154
>> > +++++++++++++++++++++
>>   
>> I don't see anything here that's powerpc specific?
>> 
>> Which makes me wonder 1) could this be done with some existing
>> generic
>> mechanism?, and 2) if not can this test code be made generic.
>> 
>> At the very least this should be Cc'ed to the cpuidle lists &
>> maintainers given it's a test for cpuidle latency :)
>> 
>> cheers
>
> Hi Michael,
>
> Thanks a lot for taking a look at this.
>
> Yes, this test-case can be used as a generic benchmark for evaluating
> CPU idle latencies across different architectures, as it has thus far
> been exclusively tested and used on PowerPC, so we thought it would be
> more beneficial to incorporate it into a PowerPC specific self-test
> suite. But I will work on making it a generic self-test and send across
> a v4.

I'd suggest just posting v3 again but Cc'ing the cpuidle lists &
maintainers, to see if there is any interest in making it generic.

cheers
