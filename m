Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53BDC7DBA4
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2019 14:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfHAMiO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Aug 2019 08:38:14 -0400
Received: from foss.arm.com ([217.140.110.172]:35274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfHAMiN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Aug 2019 08:38:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA8AC1570;
        Thu,  1 Aug 2019 05:38:12 -0700 (PDT)
Received: from [10.1.194.48] (e123572-lin.cambridge.arm.com [10.1.194.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E84103F575;
        Thu,  1 Aug 2019 05:38:07 -0700 (PDT)
Subject: Re: [PATCH v19 02/15] arm64: Introduce prctl() options to control the
 tagged user addresses ABI
To:     Dave Hansen <dave.hansen@intel.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
References: <cover.1563904656.git.andreyknvl@google.com>
 <1c05651c53f90d07e98ee4973c2786ccf315db12.1563904656.git.andreyknvl@google.com>
 <7a34470c-73f0-26ac-e63d-161191d4b1e4@intel.com>
From:   Kevin Brodsky <kevin.brodsky@arm.com>
Message-ID: <2b274c6f-6023-8eb8-5a86-507e6000e13d@arm.com>
Date:   Thu, 1 Aug 2019 13:38:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7a34470c-73f0-26ac-e63d-161191d4b1e4@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 31/07/2019 18:05, Dave Hansen wrote:
> On 7/23/19 10:58 AM, Andrey Konovalov wrote:
>> +long set_tagged_addr_ctrl(unsigned long arg)
>> +{
>> +	if (!tagged_addr_prctl_allowed)
>> +		return -EINVAL;
>> +	if (is_compat_task())
>> +		return -EINVAL;
>> +	if (arg & ~PR_TAGGED_ADDR_ENABLE)
>> +		return -EINVAL;
>> +
>> +	update_thread_flag(TIF_TAGGED_ADDR, arg & PR_TAGGED_ADDR_ENABLE);
>> +
>> +	return 0;
>> +}
> Instead of a plain enable/disable, a more flexible ABI would be to have
> the tag mask be passed in.  That way, an implementation that has a
> flexible tag size can select it.  It also ensures that userspace
> actually knows what the tag size is and isn't surprised if a hardware
> implementation changes the tag size or position.
>
> Also, this whole set deals with tagging/untagging, but there's an
> effective loss of address space when you do this.  Is that dealt with
> anywhere?  How do we ensure that allocations don't get placed at a
> tagged address before this gets turned on?  Where's that checking?

This patch series only changes what is allowed or not at the syscall interface. It 
does not change the address space size. On arm64, TBI (Top Byte Ignore) has always 
been enabled for userspace, so it has never been possible to use the upper 8 bits of 
user pointers for addressing.

If other architectures were to support a similar functionality, then I agree that a 
common and more generic interface (if needed) would be helpful, but as it stands this 
is an arm64-specific prctl, and on arm64 the address tag is defined by the 
architecture as bits [63:56].

Kevin
