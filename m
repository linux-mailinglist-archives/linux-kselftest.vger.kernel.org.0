Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 742ADABABA
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2019 16:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387881AbfIFOVy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Sep 2019 10:21:54 -0400
Received: from foss.arm.com ([217.140.110.172]:57040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732020AbfIFOVx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Sep 2019 10:21:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E10228;
        Fri,  6 Sep 2019 07:21:53 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AA123F718;
        Fri,  6 Sep 2019 07:21:51 -0700 (PDT)
Subject: Re: [PATCH ARM64] selftests, arm64: add kernel headers path for
 tags_test
To:     Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>
References: <c28135c82eaf6d6e2c7e02c1ebc2b99a607d8116.1567615235.git.andreyknvl@google.com>
 <20190906135151.d74nq3qzjmhe4mb5@willie-the-truck>
 <CAAeHK+zDZo6oaSDnJfiD_S1WYqAT13yEFP7hbehZ62C-BBp3rQ@mail.gmail.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <febb420d-003a-0288-8636-7fd7878ef63b@arm.com>
Date:   Fri, 6 Sep 2019 15:21:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+zDZo6oaSDnJfiD_S1WYqAT13yEFP7hbehZ62C-BBp3rQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 06/09/2019 14:55, Andrey Konovalov wrote:
> On Fri, Sep 6, 2019 at 3:51 PM Will Deacon <will@kernel.org> wrote:
>>
>> On Wed, Sep 04, 2019 at 06:41:00PM +0200, Andrey Konovalov wrote:
>>> tags_test.c relies on PR_SET_TAGGED_ADDR_CTRL/PR_TAGGED_ADDR_ENABLE being
>>> present in system headers. When this is not the case the build of this
>>> test fails with undeclared identifier errors.
>>>
>>> Fix by providing the path to the KSFT installed kernel headers in CFLAGS.
>>>
>>> Reported-by: Cristian Marussi <cristian.marussi@arm.com>
>>> Suggested-by: Cristian Marussi <cristian.marussi@arm.com>
>>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>>> ---
>>>  tools/testing/selftests/arm64/Makefile | 1 +
>>>  1 file changed, 1 insertion(+)
>>
>> Damn, I just tagged the arm64 queue for 5.4 and didn't spot this patch.
>>
>> I'll queue it at -rc1 instead, if that's ok? It doesn't look urgent.
> 
> Sorry, I guess I should have pinged you directly.
> 
> I think it should be fine to leave it for rc1. It might cause a build
> error in some kernel CI systems if they run kselftests though.
> 

It won't be a big issue probably.

Cristian
