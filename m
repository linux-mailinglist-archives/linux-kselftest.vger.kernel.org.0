Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986EC25BE95
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Sep 2020 11:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgICJqi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Sep 2020 05:46:38 -0400
Received: from foss.arm.com ([217.140.110.172]:57742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgICJqi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Sep 2020 05:46:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46C25101E;
        Thu,  3 Sep 2020 02:46:37 -0700 (PDT)
Received: from [10.57.7.89] (unknown [10.57.7.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B47E3F68F;
        Thu,  3 Sep 2020 02:46:35 -0700 (PDT)
Subject: Re: [PATCH 0/4] kselftests/arm64: add PAuth tests
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, boian4o1@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        amit.kachhap@arm.com, vincenzo.frascino@arm.com,
        Shuah Khan <shuah@kernel.org>
References: <20200828131606.7946-1-boyan.karatotev@arm.com>
 <20200902164825.GH6642@arm.com>
From:   Boyan Karatotev <boyan.karatotev@arm.com>
Message-ID: <7ed52c37-a448-55c9-4ec8-b803ec62ecf6@arm.com>
Date:   Thu, 3 Sep 2020 10:46:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902164825.GH6642@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02/09/2020 17:48, Dave Martin wrote:
> On Fri, Aug 28, 2020 at 02:16:02PM +0100, Boyan Karatotev wrote:
>> Pointer Authentication (PAuth) is a security feature introduced in ARMv8.3.
>> It introduces instructions to sign addresses and later check for potential
>> corruption using a second modifier value and one of a set of keys. The
>> signature, in the form of the Pointer Authentication Code (PAC), is stored
>> in some of the top unused bits of the virtual address (e.g. [54: 49] if
>> TBID0 is enabled and TnSZ is set to use a 48 bit VA space). A set of
>> controls are present to enable/disable groups of instructions (which use
>> certain keys) for compatibility with libraries that do not utilize the
>> feature. PAuth is used to verify the integrity of return addresses on the
>> stack with less memory than the stack canary.
>>
>> This patchset adds kselftests to verify the kernel's configuration of the
>> feature and its runtime behaviour. There are 7 tests which verify that:
>> 	* an authentication failure leads to a SIGSEGV
>> 	* the data/instruction instruction groups are enabled
>> 	* the generic instructions are enabled
>> 	* all 5 keys are unique for a single thread
>> 	* exec() changes all keys to new unique ones
>> 	* context switching preserves the 4 data/instruction keys
>> 	* context switching preserves the generic keys
>>
>> The tests have been verified to work on qemu without a working PAUTH
>> Implementation and on ARM's FVP with a full or partial PAuth
>> implementation.
>>
>> Note: This patchset is only verified for ARMv8.3 and there will be some
>> changes required for ARMv8.6. More details can be found here [1]. Once
>> ARMv8.6 PAuth is merged the first test in this series will required to be
>> updated.
> 
> Nit: is it worth running checkpatch over this series?
> 
> Although this is not kernel code, there are a number of formatting
> weirdnesses and surplus blank lines etc. that checkpatch would probably
> warn about.
> 
I ran it through checkpatch and it came out clean except for some
MAINTAINERS warnings. I see that when I add --strict it does complain
about multiple blank lines which I can fix for the next version. Are
there any other flags I should be running checkpatch with?
> [...]
> 
> Cheers
> ---Dave
> 


-- 
Regards,
Boyan
