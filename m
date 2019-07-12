Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6067267509
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2019 20:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfGLSO7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Jul 2019 14:14:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbfGLSO6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Jul 2019 14:14:58 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87D3D205C9;
        Fri, 12 Jul 2019 18:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562955297;
        bh=FX5tQfx73p/PD4+aLUhm4xR9ruoKX9OaywZznKgJZ+M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mjPbw0igg4Pw25Fpu+sbcey7jz4oohHBsPOf6sjaT9dRYDYZGsYh0gDV5xYkn59uZ
         kHi8Bpij0uF7L3HTKVidrJmwoC2fKojgFRJR3jYdLZotjwLdIXb/Q/sXmybXIpQDLW
         /99SeOTWrAYmU5LR8dE/2igAn718lhRdla0BQ3Zg=
Subject: Re: [RFC PATCH] selftests/livepatch: only consider supported arches
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190712171402.15930-1-joe.lawrence@redhat.com>
 <20190712172517.GA15872@redhat.com>
 <eec9376b-8c0d-8f09-59cb-e38839b13368@kernel.org>
 <20190712175812.GB15872@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <2e1349e8-7c78-8aa5-e04b-18e824c6c029@kernel.org>
Date:   Fri, 12 Jul 2019 12:14:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712175812.GB15872@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/12/19 11:58 AM, Joe Lawrence wrote:
> On Fri, Jul 12, 2019 at 11:43:02AM -0600, shuah wrote:
>> Hi Joe,
>>
>> [ ... snip ... ]
>>
>> The one thing I am not seeing is Skip handling. Without that users will
>> complain livepatch test is failing as opposed to that the test can't
>> run due to unmet dependencies and skipped.
>>
>> Maybe that is all you need? I would recommend going in that direction
>> instead of Arch check.
>>
> 
> Okay, I see that kselftest/runner.sh compares test return code with
> skip_rc=4 to determine SKIP status... so perhaps our scripts could
> perform a simple "modinfo" on their test modules to determine if they
> have been built and installed?  If not found, just SKIP to the next
> test.
> 

Yes. That would fix the problem.

tools/testing/selftests/kselftest_module.sh has hooks to help you
with modules checks. e.g: assert_have_module

thanks,
-- Shuah
