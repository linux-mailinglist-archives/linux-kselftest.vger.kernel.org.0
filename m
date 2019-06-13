Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 735A4441AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2019 18:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387534AbfFMQQF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jun 2019 12:16:05 -0400
Received: from foss.arm.com ([217.140.110.172]:44920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731160AbfFMQQF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jun 2019 12:16:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12AAE367;
        Thu, 13 Jun 2019 09:16:04 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB5643F694;
        Thu, 13 Jun 2019 09:15:58 -0700 (PDT)
Subject: Re: [PATCH v17 03/15] arm64: Introduce prctl() options to control the
 tagged user addresses ABI
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Evgeniy Stepanov <eugenis@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Lee Smith <Lee.Smith@arm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        enh <enh@google.com>, Robin Murphy <robin.murphy@arm.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
References: <cover.1560339705.git.andreyknvl@google.com>
 <a7a2933bea5fe57e504891b7eec7e9432e5e1c1a.1560339705.git.andreyknvl@google.com>
 <20190613111659.GX28398@e103592.cambridge.arm.com>
 <20190613153505.GU28951@C02TF0J2HF1T.local>
 <99cc257d-5e99-922a-fbe7-3bbaf3621e38@arm.com>
 <20190613155754.GX28951@C02TF0J2HF1T.local>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <e481dbf9-880e-c77e-5200-1dbc35be7a48@arm.com>
Date:   Thu, 13 Jun 2019 17:15:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190613155754.GX28951@C02TF0J2HF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 13/06/2019 16:57, Catalin Marinas wrote:
> On Thu, Jun 13, 2019 at 04:45:54PM +0100, Vincenzo Frascino wrote:
>> On 13/06/2019 16:35, Catalin Marinas wrote:
>>> On Thu, Jun 13, 2019 at 12:16:59PM +0100, Dave P Martin wrote:
>>>> On Wed, Jun 12, 2019 at 01:43:20PM +0200, Andrey Konovalov wrote:
>>>>> +
>>>>> +/*
>>>>> + * Control the relaxed ABI allowing tagged user addresses into the kernel.
>>>>> + */
>>>>> +static unsigned int tagged_addr_prctl_allowed = 1;
>>>>> +
>>>>> +long set_tagged_addr_ctrl(unsigned long arg)
>>>>> +{
>>>>> +	if (!tagged_addr_prctl_allowed)
>>>>> +		return -EINVAL;
>>>>
>>>> So, tagging can actually be locked on by having a process enable it and
>>>> then some possibly unrelated process clearing tagged_addr_prctl_allowed.
>>>> That feels a bit weird.
>>>
>>> The problem is that if you disable the ABI globally, lots of
>>> applications would crash. This sysctl is meant as a way to disable the
>>> opt-in to the TBI ABI. Another option would be a kernel command line
>>> option (I'm not keen on a Kconfig option).
>>
>> Why you are not keen on a Kconfig option?
> 
> Because I don't want to rebuild the kernel/reboot just to be able to
> test how user space handles the ABI opt-in. I'm ok with a Kconfig option
> to disable this globally in addition to a run-time option (if actually
> needed, I'm not sure).
> 
There might be scenarios (i.e. embedded) in which this is not needed, hence
having a config option (maybe Y by default) that removes from the kernel the
whole feature would be good, obviously in conjunction with the run-time option.

Based on my previous review, if we move out the code from process.c in its own
independent file when the Kconfig option is turned off we could remove the
entire object from the kernel (this would remove the sysctl and let still the
prctl return -EINVAL).

These changes though could be done successively with a separate patch set, if
the Kconfig is meant to be Y by default.

-- 
Regards,
Vincenzo
