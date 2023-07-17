Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E950B755E5F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 10:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjGQIXe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 04:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGQIXd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 04:23:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A915E3;
        Mon, 17 Jul 2023 01:23:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18BA913D5;
        Mon, 17 Jul 2023 01:24:15 -0700 (PDT)
Received: from [10.57.76.30] (unknown [10.57.76.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 414D13F73F;
        Mon, 17 Jul 2023 01:23:30 -0700 (PDT)
Message-ID: <473af190-5c1f-557c-f670-5b045d35dc49@arm.com>
Date:   Mon, 17 Jul 2023 09:23:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v1 3/9] selftests/mm: Skip soft-dirty tests on arm64
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Florent Revest <revest@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230713135440.3651409-1-ryan.roberts@arm.com>
 <20230713135440.3651409-4-ryan.roberts@arm.com>
 <57995c19-36c5-d868-293a-f03ad507da98@nvidia.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <57995c19-36c5-d868-293a-f03ad507da98@nvidia.com>
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

On 15/07/2023 01:04, John Hubbard wrote:
> On 7/13/23 06:54, Ryan Roberts wrote:
>> arm64 does not support the soft-dirty PTE bit. However there are tests
>> in `madv_populate` and `soft-dirty` which assume it is supported and
>> cause spurious failures to be reported when preferred behaviour would be
>> to mark the tests as skipped.
>>
>> Unfortunately, the only way to determine if the soft-dirty dirty bit is
>> supported is to write to a page, then see if the bit is set in
>> /proc/self/pagemap. But the tests that we want to conditionally execute
>> are testing precicesly this. So if we introduced this feature check, we
>> could accedentally turn a real failure (on a system that claims to
>> support soft-dirty) into a skip.
> 
> ...
> 
>> diff --git a/tools/testing/selftests/mm/soft-dirty.c
>> b/tools/testing/selftests/mm/soft-dirty.c
>> index cc5f144430d4..8a2cd161ec4d 100644
>> --- a/tools/testing/selftests/mm/soft-dirty.c
>> +++ b/tools/testing/selftests/mm/soft-dirty.c
> 
> Hi Ryan,
> 
> Probably very similar to what David is requesting: given that arm64
> definitively does not support soft dirty, I'd suggest that we not even
> *build* the soft dirty tests on arm64!
> 
> There is no need to worry about counting, skipping or waiving such
> tests, either. Because it's just a non-issue: one does not care about
> test status for something that is documented as "this feature is simply
> unavailable here".

OK fair enough. I'll follow this approach for v2.

Thanks for the review!

> 
> 
> thanks,

