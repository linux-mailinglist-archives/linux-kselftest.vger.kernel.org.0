Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777C2752526
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 16:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjGMOcX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 10:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjGMOcX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 10:32:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32B651BEB;
        Thu, 13 Jul 2023 07:32:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 739BD1570;
        Thu, 13 Jul 2023 07:33:04 -0700 (PDT)
Received: from [10.1.30.48] (C02Z41KALVDN.cambridge.arm.com [10.1.30.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 922C23F73F;
        Thu, 13 Jul 2023 07:32:20 -0700 (PDT)
Message-ID: <1e560ea5-3eb2-40a8-33aa-514eb026de3a@arm.com>
Date:   Thu, 13 Jul 2023 15:32:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/9] selftests: Line buffer test program's stdout
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230713135440.3651409-1-ryan.roberts@arm.com>
 <20230713135440.3651409-2-ryan.roberts@arm.com>
 <8a8d077c-55bd-4710-9dfd-1cbb1a9170a8@sirena.org.uk>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <8a8d077c-55bd-4710-9dfd-1cbb1a9170a8@sirena.org.uk>
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

On 13/07/2023 15:16, Mark Brown wrote:
> On Thu, Jul 13, 2023 at 02:54:32PM +0100, Ryan Roberts wrote:
>> The selftests runner pipes the test program's stdout to tap_prefix. The
>> presence of the pipe means that the test program sets its stdout to be
>> fully buffered (as aposed to line buffered when directly connected to
>> the terminal). The block buffering means that there is often content in
>> the buffer at fork() time, which causes the output to end up duplicated.
>> This was causing problems for mm:cow where test results were duplicated
>> 20-30x.
>>
>> Solve this by using `stdbuf`, when available to force the test program
>> to use line buffered mode. This means previously printf'ed results are
>> flushed out of the program before any fork().
> 
> This is going to be useful in general since not all selftests use the
> kselftest helpers but it'd probably also be good to make
> ksft_print_header() also make the output unbuffered 

Yeah sounds reasonable.

> so that if setbuf
> isn't installed on the target system or the tests are run standalone we
> don't run into issues there.  Even if the test isn't corrupting data
> having things unbuffered is going to be good for making sure we don't
> drop any output if the test dies.

Note that currently I've set stdbuf to encourage line buffering rather than no
buffering. Are you saying no buffering is preferred? I took the view that line
buffering is a good middle ground, and and aligns with what people see when
developing and running the program manually in the terminal.

> 
>> +		if [ -x /usr/bin/stdbuf ]; then
>> +			stdbuf="/usr/bin/stdbuf --output=L "
>> +		fi
> 
> Might be more robust to use type -p to find stdbuf in case it's in /bin
> or something?

Yep good idea.
