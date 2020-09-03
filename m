Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEE425BF59
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Sep 2020 12:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgICKsw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Sep 2020 06:48:52 -0400
Received: from foss.arm.com ([217.140.110.172]:58772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgICKsm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Sep 2020 06:48:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10C40101E;
        Thu,  3 Sep 2020 03:48:42 -0700 (PDT)
Received: from [10.57.7.89] (unknown [10.57.7.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2F5C3F66F;
        Thu,  3 Sep 2020 03:48:39 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] kselftests/arm64: add PAuth test for whether
 exec() changes keys
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, boian4o1@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        amit.kachhap@arm.com, vincenzo.frascino@arm.com,
        Shuah Khan <shuah@kernel.org>
References: <20200831110450.30188-1-boyan.karatotev@arm.com>
 <20200831110450.30188-4-boyan.karatotev@arm.com>
 <20200902170854.GK6642@arm.com>
From:   Boyan Karatotev <boyan.karatotev@arm.com>
Message-ID: <926691e4-1990-207e-bcb9-40ab6d3b0fa0@arm.com>
Date:   Thu, 3 Sep 2020 11:48:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902170854.GK6642@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02/09/2020 18:08, Dave Martin wrote:
> On Mon, Aug 31, 2020 at 12:04:49PM +0100, Boyan Karatotev wrote:
>> +/*
>> + * fork() does not change keys. Only exec() does so call a worker program.
>> + * Its only job is to sign a value and report back the resutls
>> + */
>> +TEST(exec_unique_keys)
>> +{
> 
> The kernel doesn't guarantee that keys are unique.
> 
> Can we present all the "unique keys" wording differently, say
> 
> 	exec_key_collision_likely()

I agree that this test's name is a bit out of place. I would rather have
it named "exec_changed_keys" though.

> Otherwise people might infer from this test code that the keys are
> supposed to be truly unique and start reporting bugs on the kernel.
> 
> I can't see an obvious security argument for unique keys (rather, the
> keys just need to be "unique enough".  That's the job of
> get_random_bytes().)

The "exec_unique_keys" test only checks that the keys changed after an
exec() which I think the name change would reflect.

The thing with the "single_thread_unique_keys" test is that the kernel
says the the keys will be random. Yes, there is no uniqueness guarantee
but I'm not sure how to phrase it differently. There is some minuscule
chance that the keys end up the same, but for this test I pretend this
will not happen. Would changing up the comments and the failure message
communicate this? Maybe substitute "unique" for "different" and say how
many keys clashed?

-- 
Regards,
Boyan
