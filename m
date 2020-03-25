Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3412A192A4E
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Mar 2020 14:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgCYNnq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 09:43:46 -0400
Received: from foss.arm.com ([217.140.110.172]:48708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbgCYNnq (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 09:43:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF01531B;
        Wed, 25 Mar 2020 06:43:45 -0700 (PDT)
Received: from [10.37.9.12] (unknown [10.37.9.12])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C24C03F71F;
        Wed, 25 Mar 2020 06:43:44 -0700 (PDT)
Subject: Re: [PATCH 2/3] kselftest: Extend vDSO selftest
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200324145120.42194-1-vincenzo.frascino@arm.com>
 <20200324145120.42194-3-vincenzo.frascino@arm.com>
 <CALCETrUPaJCgY_herAUJAfqUbXS6S9xOaLz9abFEWOjEouNf+A@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <281cc0c3-dbe3-2c39-3964-ce1147af9933@arm.com>
Date:   Wed, 25 Mar 2020 13:44:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUPaJCgY_herAUJAfqUbXS6S9xOaLz9abFEWOjEouNf+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Andy,

On 3/24/20 5:22 PM, Andy Lutomirski wrote:
> On Tue, Mar 24, 2020 at 7:51 AM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> The current version of the multiarch vDSO selftest verifies only
>> gettimeofday.
>>
>> Extend the vDSO selftest to the other library functions:
>>  - time
>>  - clock_getres
>>  - clock_gettime
>>
>> The extension has been used to verify the unified vdso library on the
>> supported architectures.
> 
> The code in tools/testing/selftests/x86/test_vdso.c actually checks
> that the times returned by the vDSO are correct.  Perhaps that code
> should be copied or moved here?
> 

Good point. I was not aware of such a test. I will definitely move it here and
make sure it works for non x86 platforms as well in the next iteration of this
series.

-- 
Regards,
Vincenzo
