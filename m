Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC776C7ABB
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 10:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjCXJE7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 05:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjCXJE6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 05:04:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1371855A6
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 02:04:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C478811FB;
        Fri, 24 Mar 2023 02:05:39 -0700 (PDT)
Received: from [10.57.64.178] (unknown [10.57.64.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D61A33F67D;
        Fri, 24 Mar 2023 02:04:54 -0700 (PDT)
Message-ID: <7c3377b8-716a-fe95-81b9-0637075475dc@arm.com>
Date:   Fri, 24 Mar 2023 09:04:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2 0/3] KVM: selftests: Fixes for broken tests
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, kvmarm@lists.linux.dev
References: <20230308110948.1820163-1-ryan.roberts@arm.com>
 <4eca298b-411f-e6db-04d2-e8963a0e5d98@arm.com> <ZByOn79zokUpLGSs@linux.dev>
 <2d3bc930bd3fdc20a7257b6f343313ed@kernel.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <2d3bc930bd3fdc20a7257b6f343313ed@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23/03/2023 18:56, Marc Zyngier wrote:
> On 2023-03-23 17:38, Oliver Upton wrote:
>> Hey Ryan,
>>
>> On Thu, Mar 23, 2023 at 12:56:18PM +0000, Ryan Roberts wrote:
>>> Hi Oliver,
>>>
>>> Just a polite nudge on this: I was originally hoping to get these into 6.3 since
>>> I thought they were fairly uncontroversial and clearly fixing bugs. What are my
>>> chances?
>>
>> Yes, your changes are indeed uncontroversial :) At least for me, fixes to
>> selftests take a strictly lower priority than fixes to the kernel outside of
>> a merge window. AFAICT, only LPA systems are affected by the changes here and
>> I'm not aware of any of those out in the wild.

The first patch is not related to LPA, it adds a missing kernel config to the
config fragment so that one of the tests (access_tracking_perf_test) is not
skipped. This change will mean our CI system starts actually running the test.

> 
> Agreed. My usual take on fixing tests is that unless the test has been
> broken in the current cycle, we can safely delay merging the fix until
> the following cycle.

Thanks for the explanation. I have a slightly different opinion though (please
bare with me through the rant):

Being fairly new to Linux development, I'd like to be able to run (all) the
selftests as a matter of course to be able to quickly answer the "did I
obviously break anything?" question. But there is a lot of friction to even
being able to compile, let alone run, the things - undocumented dependencies on
libraries (even more difficult when needing to cross compile), undocumented
dependencies on kernel configs, test code that is broken and fails to compile,
tests that silently skip for difficult to determine reasons, tests that fail
even when run against the unmodified kernel, and results buried in copious
amounts of logs. These are all paper cuts that make them difficult to use and
trust. Or perhaps I'm just doing it wrong...

I would love to live in a world where I could confidently take a mainline
release, compile and run tests at close-to-zero effort and see all tests running
and passing... one day, perhaps. But only if we give more priority to the test
code ;-)


> 
> And yes, LPA-capable HW is essentially vapourware at this stage.
> 
>>
>> So, unless there is a burning issue, I'd like to defer these patches to the
>> 6.4 merge window. Nonetheless, it all looks good to me:
>>
>> Reviewed-by: Oliver Upton <oliver.upton@linux.dev>

Thanks for that.

> 
> Thanks for that. I'll start queuing 6.4 material once I'm back to my
> usual time zone, beginning of next week.

Appreciated. Thanks for taking the patches. If you have a rule-of-thumb about
the best time to post different types of patches (and what it's best to base
them on), I'll try to follow it in future.

Thanks,
Ryan

> 
> Cheers,
> 
>         M.

