Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FB4755E94
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 10:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjGQIg5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 04:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjGQIg4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 04:36:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADCF6135;
        Mon, 17 Jul 2023 01:36:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1178D75;
        Mon, 17 Jul 2023 01:37:34 -0700 (PDT)
Received: from [10.57.76.30] (unknown [10.57.76.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C00FC3F73F;
        Mon, 17 Jul 2023 01:36:49 -0700 (PDT)
Message-ID: <50687516-987b-75ca-c6be-255ee3091b6c@arm.com>
Date:   Mon, 17 Jul 2023 09:36:48 +0100
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
> ksft_print_header() also make the output unbuffered so that if setbuf
> isn't installed on the target system or the tests are run standalone we
> don't run into issues there.  Even if the test isn't corrupting data
> having things unbuffered is going to be good for making sure we don't
> drop any output if the test dies.
> 
>> +		if [ -x /usr/bin/stdbuf ]; then
>> +			stdbuf="/usr/bin/stdbuf --output=L "
>> +		fi
> 
> Might be more robust to use type -p to find stdbuf in case it's in /bin
> or something?

Just looking at making this change; run_selftest.sh's shebang is for sh, and
sh's type doesn't support the -p option. So I'm inclined to leave it as is.
There are multiple other places in the script where /usr/bin is hardcoded when
looking for programs too. Shout if you violently disagree.

