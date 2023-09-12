Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D3E79D0D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 14:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbjILMQ1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 08:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbjILMQP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 08:16:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 858FD10D2;
        Tue, 12 Sep 2023 05:16:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62CB8C15;
        Tue, 12 Sep 2023 05:16:48 -0700 (PDT)
Received: from [10.1.32.154] (XHFQ2J9959.cambridge.arm.com [10.1.32.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 741BC3F67D;
        Tue, 12 Sep 2023 05:16:09 -0700 (PDT)
Message-ID: <2a503271-0d44-40ae-8d13-65aba0345d4a@arm.com>
Date:   Tue, 12 Sep 2023 13:16:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [selftests] 58e2847ad2:
 kernel-selftests.openat2.resolve_test.fail
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
Content-Language: en-GB
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <202309121342.97e2f008-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/09/2023 07:17, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "kernel-selftests.openat2.resolve_test.fail" on:
> 
> commit: 58e2847ad2e6322a25dedf8b4549ff924baf8395 ("selftests: line buffer test program's stdout")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Thanks for the report - I'm looking into this now and will get back to you once
I have some more info.

Thanks,
Ryan

