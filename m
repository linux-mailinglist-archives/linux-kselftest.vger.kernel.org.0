Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCE0256C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2019 19:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfEURdw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 May 2019 13:33:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbfEURdw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 May 2019 13:33:52 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9AC221019;
        Tue, 21 May 2019 17:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558460031;
        bh=jywQrl+QpM3jwW+FUzgX1ZMhcVzCTw6nvmX4el5YYE4=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=mmU2LBg/FHhKeDrYO1ldmRCfZGk2Dt4hb3mpnqdQx8xNrRJsufEUhyRv400FfjVD0
         BYhwgfooTjeMvdCtcj0X1rR8f5i+63tGke/aGBBW7eUBMaTMYxOaSM/yaLd8PG6rYB
         KEoGjm/e/NHO6I7NI4lb/p0hMMYlQcRtnHnY+A4I=
Subject: Re: [PATCH v2 5/5] kselftest: Extend vDSO selftest to clock_getres
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kselftest@vger.kernel.org, Will Deacon <will.deacon@arm.com>
References: <20190416161434.32691-1-vincenzo.frascino@arm.com>
 <20190416161434.32691-6-vincenzo.frascino@arm.com>
 <f07e07b0-4e53-96c8-ebe2-a0f5528fa329@arm.com>
 <252b011e-974a-2f3b-2cc3-0892d1c4a3c0@kernel.org>
Cc:     shuah <shuah@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <759f59b2-2cb3-130b-fb30-89e3fb92af33@kernel.org>
Date:   Tue, 21 May 2019 11:33:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <252b011e-974a-2f3b-2cc3-0892d1c4a3c0@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/21/19 10:24 AM, shuah wrote:
> On 5/21/19 10:11 AM, Vincenzo Frascino wrote:
>> Hi Shuah,
>>
>> I did not see this patch in 5.2-rc1 and I was wondering if there is 
>> anything I
>> can do to help with upstraming it.
>>
> 
> Thanks for the ping.
> 
> Sorry about this. I saw that this part of a series and thought it
> depends on other patches and should go through another tree.
> 
> Totally missed that Will suggested that I take it though selftests.
> 
> My bad. I will get this in - I hope there are no dependencies with other
> trees.
> 
> thanks,
> -- Shuah
> 
> 

Can you take a look at the macro in this patch. It has checkpatch
warn:

WARNING: Macros with flow control statements should be avoided


thanks,
-- Shuah
