Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD791DF1CB
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 May 2020 00:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbgEVWYu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 May 2020 18:24:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731160AbgEVWYt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 May 2020 18:24:49 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 337D42088E;
        Fri, 22 May 2020 22:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590186289;
        bh=LrPMKVxMQYci29ldyPdIYlZ8Mp0AOgaammsFo/ALCog=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MPzVwv1kiCIphU507FMnZCOEH05Fd5W19aX14ZcaEBwDYBDVjufkApZkvvxO2FxxL
         2SWln5OHYRJmivPPO1H0a1rDiSh29DIaUavPUlaoPQ8SC7t/QtpdocXyKB/Eg1ySi1
         2uOyMdt2flvWd9/Qq1K7r6ai4U0mTTbuPtccHRFo=
Subject: Re: [PATCH v5] Documentation: test.h - fix warnings
To:     Jonathan Corbet <corbet@lwn.net>,
        Lothar Rubusch <l.rubusch@gmail.com>
Cc:     brendanhiggins@google.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200415201653.106-1-l.rubusch@gmail.com>
 <20200421133313.5f41fcf4@lwn.net>
From:   shuah <shuah@kernel.org>
Message-ID: <7dcdabd2-3a7c-4004-6355-12e44b4b0456@kernel.org>
Date:   Fri, 22 May 2020 16:24:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421133313.5f41fcf4@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/21/20 1:33 PM, Jonathan Corbet wrote:
> On Wed, 15 Apr 2020 20:16:53 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
> 
>> Fix warnings at 'make htmldocs', and formatting issues in the resulting
>> documentation.
>>
>> - test.h: Fix annotation in kernel-doc parameter description.
>>
>> - Documentation/*.rst: Fixing formatting issues, and a duplicate label
>>    issue due to usage of sphinx.ext.autosectionlabel and identical labels
>>    within one document (sphinx warning)
>>
>> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
>> ---
>> v2: Several documentation fixes
>>
>> v3: Do not touch API documentation index
>>
>> v4: Replace macro argument in test.h by named variadic argument
>>
>> v5: Patch format fixed
>>
>> NB: checkpatch.pl will complain about flow control statements (i.e. usage
>>      of "return") within the macro kunit_test_suites(suites_list...).
>>
>> Better? I feel I'm making you a lot of extra work. I'm really sorry for
>> all this fuzz!
> 
> So I'm assuming this will go via Shuah's tree; let me know if that's
> incorrect.
> 

Applied to linux-kselftest kunit for Linux 5.8-rc1.

thanks,
-- Shuah
