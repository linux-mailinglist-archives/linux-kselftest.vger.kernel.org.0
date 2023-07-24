Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFF475FF47
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 20:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjGXStT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 14:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGXStT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 14:49:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67BC910D9;
        Mon, 24 Jul 2023 11:49:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B6DFFEC;
        Mon, 24 Jul 2023 11:50:00 -0700 (PDT)
Received: from [10.57.76.172] (unknown [10.57.76.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A5273F67D;
        Mon, 24 Jul 2023 11:49:15 -0700 (PDT)
Message-ID: <ef907f64-f7aa-3759-1adc-3fb7e3f3487b@arm.com>
Date:   Mon, 24 Jul 2023 19:49:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 0/8] selftests/mm fixes for arm64
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20230724082522.1202616-1-ryan.roberts@arm.com>
 <20230724093804.bbe8bc2a83d4575f17778eb0@linux-foundation.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230724093804.bbe8bc2a83d4575f17778eb0@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 24/07/2023 17:38, Andrew Morton wrote:
> On Mon, 24 Jul 2023 09:25:14 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>> This is v3 of my series to clean up mm selftests so that they run correctly on
>> arm64. See [1] for full explanation.
> 
> Please don't do that.  Please maintain the [0/n] description alongside the
> patchset and resend it each time you resend the series.

OK understood. Sorry about that. Do you have any docs for the mm submission
process? If not, please keep pointing issues out and I'll get it right eventually.

I previously thought that the cover letter was primarily for the email
recipients and the description on each patch was the part that went into git?
Clearly I'm wrong, but can't see anything in submitting-patches.rst so guess the
mm process is a bit different?

> 
> I could go over and copy-paste [1] into this patchset, but I don't know if it
> is fully up to date.   I'll leave the patchset intro blank for now - please
> review/edit [1] and send the result in reply to this email, thanks. 

I doubt you would want the whole cover letter in git, so here is the relavent intro:

---8<---

Hi All,

Given my on-going work on large anon folios and contpte mappings, I decided it
would be a good idea to start running mm selftests to help guard against
regressions. However, it soon became clear that I couldn't get the suite to run
cleanly on arm64 with a vanilla v6.5-rc1 kernel (perhaps I'm just doing it
wrong??), so got stuck in a rabbit hole trying to debug and fix all the issues.
Some were down to misconfigurations, but I also found a number of issues with
the tests and even a couple of issues with the kernel.

This series aims to fix (most of) the test issues. It applies on top of
v6.5-rc3.

Changes Since v2 [2]
--------------------

  - Patch 6: Change approach to cleaning up child processes; Use "parent death
    signal", as suggested by David.
  - Added Reviewed-by/Acked-by tags: thanks to David, Mark and Peter!

Changes Since v1 [1]
--------------------

  - Patch 1: Explicitly set line buffer mode in ksft_print_header()
  - Dropped v1 patch 2 (set execute permissions): Andrew has taken this into his
    branch separately.
  - Patch 2: Don't compile `soft-dirty` suite for arm64 instead of skipping it
    at runtime.
  - Patch 2: Declare fewer tests and skip all of test_softdirty() if soft-dirty
    is not supported, rather than conditionally marking each check as skipped.
  - Added Reviewed-by tags: thanks DavidH!
  - Patch 8: Clarified commit message.

---8<---

Thanks,
Ryan

