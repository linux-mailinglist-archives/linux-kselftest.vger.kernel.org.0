Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B445C75275A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 17:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjGMPg0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 11:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGMPgZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 11:36:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D377526AE;
        Thu, 13 Jul 2023 08:36:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FA231570;
        Thu, 13 Jul 2023 08:37:03 -0700 (PDT)
Received: from [10.1.30.48] (C02Z41KALVDN.cambridge.arm.com [10.1.30.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F0553F73F;
        Thu, 13 Jul 2023 08:36:19 -0700 (PDT)
Message-ID: <8d2e75e7-0d38-6e6c-a02a-b66a18515dfb@arm.com>
Date:   Thu, 13 Jul 2023 16:36:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v1 9/9] selftests/mm: Run all tests from run_vmtests.sh
To:     Mark Brown <broonie@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230713135440.3651409-1-ryan.roberts@arm.com>
 <20230713135440.3651409-10-ryan.roberts@arm.com>
 <d77c6592-09f4-036d-ad00-a7a28de1da3f@redhat.com>
 <2b586ba2-7522-a823-afd6-7b4d978f18c2@arm.com>
 <97742685-e026-417b-8c8f-938330027636@sirena.org.uk>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <97742685-e026-417b-8c8f-938330027636@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 13/07/2023 16:30, Mark Brown wrote:
> On Thu, Jul 13, 2023 at 04:04:44PM +0100, Ryan Roberts wrote:
> 
>> So with this change at the kselftest level, there is a single test in its list;
>> run_vmtests.sh. And all the other tests that were previously in that list are
>> moved into run_vmtests.sh (if they weren't there already).
> 
> The results parsers I'm aware of like the LAVA one will DTRT with nested
> kselftests since that's required to pull see individual test cases run
> by a single binary so it's the common case to see at least one level of
> nesting.

That's good to hear. But bear in mind that run_vmtests.sh does not use TAP. So
you end up with a single top-level test who's result is reported with
run_kselftest.sh's TAP output. Then you have a second level (run_vmtests.sh)
using custom reporting, then _some_ of the tests invoked use TAP so you
sometimes have TAP at level 3. But those tests at level 2 that don't do their
own TAP output probably won't be parsed by LAVA?

Since you agreed to put this into the CI, I was going to call this part "your
problem" ;-)
