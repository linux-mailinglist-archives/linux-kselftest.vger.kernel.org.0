Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4C749F7EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 12:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244130AbiA1LJm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 06:09:42 -0500
Received: from foss.arm.com ([217.140.110.172]:36894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348068AbiA1LJS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 06:09:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B86E0113E;
        Fri, 28 Jan 2022 03:09:17 -0800 (PST)
Received: from [10.57.12.200] (unknown [10.57.12.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B73A3F766;
        Fri, 28 Jan 2022 03:09:15 -0800 (PST)
Subject: Re: [PATCH] kselftest: Fix vdso_test_abi return status
To:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Cristian Marussi <cristian.marussi@arm.com>
References: <20220126102723.23300-3-cristian.marussi@arm.com>
 <20220126122608.54061-1-vincenzo.frascino@arm.com>
 <5ea69341-73af-e741-7b5d-c161845583c9@linuxfoundation.org>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <3f0ed265-1eec-b12a-2fc2-6a558eb835c4@arm.com>
Date:   Fri, 28 Jan 2022 11:09:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5ea69341-73af-e741-7b5d-c161845583c9@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On 1/27/22 11:18 PM, Shuah Khan wrote:
> 
> You can use the ksft_* counts interfaces for this instead of adding
> counts here. ksft_test_result_*() can be used to increment the right
> result counters and then print counts at the end.
> 
> Either if there is a failure in any of the tests it will be fail with
> clear indication on which tests failed. vdso_test_clock() test for
> example is reporting false positives by overriding the Skip return
> with a pass.
> 

Good point. I missed one condition in updating the test. I will post v2 that
will be compliant with the interface you mentioned.

Thanks.

> thanks,
> -- Shuah

-- 
Regards,
Vincenzo
