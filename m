Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E63F5D0DFB
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2019 13:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfJILwR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Oct 2019 07:52:17 -0400
Received: from foss.arm.com ([217.140.110.172]:60670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfJILwR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Oct 2019 07:52:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A49A28;
        Wed,  9 Oct 2019 04:52:16 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79E563F703;
        Wed,  9 Oct 2019 04:52:15 -0700 (PDT)
Subject: Re: [PATCH v8 01/12] kselftest: arm64: extend toplevel skeleton
 Makefile
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        amit.kachhap@arm.com, andreyknvl@google.com
References: <20191009082611.9441-1-cristian.marussi@arm.com>
 <20191009082611.9441-2-cristian.marussi@arm.com>
 <20191009111513.GA27757@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <9acb0be8-512f-5e32-8dc7-1dd9534dc3fb@arm.com>
Date:   Wed, 9 Oct 2019 12:52:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009111513.GA27757@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 09/10/2019 12:15, Dave Martin wrote:
> On Wed, Oct 09, 2019 at 09:26:00AM +0100, Cristian Marussi wrote:
>> Modify KSFT arm64 toplevel Makefile to maintain arm64 kselftests organized
>> by subsystem, keeping them into distinct subdirectories under arm64 custom
>> KSFT directory: tools/testing/selftests/arm64/
>>
>> Add to such toplevel Makefile a mechanism to guess the effective location
>> of Kernel headers as installed by KSFT framework.
>>
>> Fit existing arm64 tags kselftest into this new schema moving them into
>> their own subdirectory (arm64/tags).
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>> Based on:
>> commit 9ce1263033cd ("selftests, arm64: add a selftest for passing
>> 		     tagged pointers to kernel")
>> ---
>> v6 --> v7
>> - renamed SUBTARGETS to ARM64_SUBTARGETS to avoid name clashes
>> - rebased on v5.4-rc2 accounting for further new patches on top of commit 9ce1263033cd
>> v5 --> v6
>> - using realpath to avoid passing down relative paths
>> - fix commit msg & Copyright
>> - removed unneded Makefile export
>> - added SUBTARGETS specification, to allow building specific only some
>>   arm64 test subsystems
>> v4 --> v5
>> - rebased on arm64/for-next/core
>> - merged this patch with KSFT arm64 tags patch, while moving the latter
>>   into its own subdir
>> - moved kernel header includes search mechanism from KSFT arm64
>>   SIGNAL Makefile
>> - export proper top_srcdir ENV for lib.mk
>> v3 --> v4
>> - comment reword
>> - simplified documentation in README
>> - dropped README about standalone
>> ---
>>  tools/testing/selftests/Makefile              |  1 +
>>  tools/testing/selftests/arm64/Makefile        | 64 +++++++++++++++++--
>>  tools/testing/selftests/arm64/README          | 25 ++++++++
>>  tools/testing/selftests/arm64/tags/Makefile   |  7 ++
>>  .../arm64/{ => tags}/run_tags_test.sh         |  0
>>  .../selftests/arm64/{ => tags}/tags_test.c    |  0
>>  6 files changed, 92 insertions(+), 5 deletions(-)
>>  create mode 100644 tools/testing/selftests/arm64/README
>>  create mode 100644 tools/testing/selftests/arm64/tags/Makefile
>>  rename tools/testing/selftests/arm64/{ => tags}/run_tags_test.sh (100%)
>>  rename tools/testing/selftests/arm64/{ => tags}/tags_test.c (100%)
> 
> Do you need to move the tags_test line in arm64/.gitignore to
> arm64/tags/.gitignore?
> 

Damn...I've not spotted that since it works anyway. I'll fix in v9.

Cristian

> With that change, FWIW:
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> 
> (i.e., this looks reasonable, but I'm not a kselftest expert...)
> 
> [...]
> 
> Cheers
> ---Dave
> 

