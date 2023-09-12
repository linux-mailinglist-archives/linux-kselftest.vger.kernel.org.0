Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BAE79D2EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 15:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbjILNyj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 09:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbjILNyi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 09:54:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91B5010CE;
        Tue, 12 Sep 2023 06:54:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 764301007;
        Tue, 12 Sep 2023 06:55:11 -0700 (PDT)
Received: from [10.1.32.154] (XHFQ2J9959.cambridge.arm.com [10.1.32.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DD4A3F5A1;
        Tue, 12 Sep 2023 06:54:32 -0700 (PDT)
Message-ID: <7ce438e4-2f6c-4644-adff-b8cc95d8ee73@arm.com>
Date:   Tue, 12 Sep 2023 14:54:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [selftests] 58e2847ad2:
 kernel-selftests.openat2.resolve_test.fail
Content-Language: en-GB
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Florent Revest <revest@chromium.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
References: <202309121342.97e2f008-oliver.sang@intel.com>
 <2a503271-0d44-40ae-8d13-65aba0345d4a@arm.com>
In-Reply-To: <2a503271-0d44-40ae-8d13-65aba0345d4a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/09/2023 13:16, Ryan Roberts wrote:
> On 12/09/2023 07:17, kernel test robot wrote:
>>
>>
>> Hello,
>>
>> kernel test robot noticed "kernel-selftests.openat2.resolve_test.fail" on:
>>
>> commit: 58e2847ad2e6322a25dedf8b4549ff924baf8395 ("selftests: line buffer test program's stdout")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> Thanks for the report - I'm looking into this now and will get back to you once
> I have some more info.

I found the problem and sent a patch to the list with the explanation of what it
going on. Sorry about that!

https://lore.kernel.org/lkml/20230912135048.1755771-1-ryan.roberts@arm.com/

> 
> Thanks,
> Ryan
> 

