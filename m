Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1D84B516B
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2019 17:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfIQPZe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Sep 2019 11:25:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbfIQPZe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Sep 2019 11:25:34 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93B73214AF;
        Tue, 17 Sep 2019 15:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568733933;
        bh=lQSXCnZ640THBX9rsAXRexki343qzvOe6cZrKb10Y+I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ab1F31rotgAqLYpOsIMQE1reY4N2E1K4zMLIE/Fe/QConGl9hbRUyQNKnZJLD2JCh
         1Kjb3HPOQwipABIvv5l6jfwVMkseigXE2Z/ktACXQ9QARtWo4xjWlifKFUzwdMFmyU
         JjmaxETqpa0VTUe7Ke3tLsp0V5r/nCDWllFq0WFE=
Subject: Re: [PATCH v2] selftests: watchdog: Validate optional file argument
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     "George G. Davis" <george_davis@mentor.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        shuah <shuah@kernel.org>
References: <1568659751-1845-1-git-send-email-george_davis@mentor.com>
 <fa008fd8-f867-b80e-84ed-148e1630c09e@kernel.org>
 <20190917145400.GA14341@vmlxhi-102.adit-jv.com>
From:   shuah <shuah@kernel.org>
Message-ID: <73bab70b-e22c-42b4-cfca-b4e33431b423@kernel.org>
Date:   Tue, 17 Sep 2019 09:25:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917145400.GA14341@vmlxhi-102.adit-jv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/17/19 8:54 AM, Eugeniu Rosca wrote:
> Shuah,
> 
> On Mon, Sep 16, 2019 at 07:19:35PM -0600, shuah wrote:
>> On 9/16/19 12:49 PM, George G. Davis wrote:
>>> As reported by Eugeniu Rosca, a side of affect of commit c3f2490d6e92
>>> ("selftests: watchdog: Add optional file argument") is that arbitrary files
>>> may be opened for watchdog testing, e.g.
>>>
>>
>> You don't need to say this here since you are already have a
>> Reported-by tag.
> 
> This looks like asking people to stick to your personal taste which
> BTW doesn't really match the patterns established in Linux community.
> 
> With a bit of scripting, I am able to find around 4600 vanilla commits
> which happen to mention the name of the reporter in addition to
> Reported-by: https://paste.ubuntu.com/p/wNXfdGCJbX/ .
> 
> I really don't care if my name is mentioned once or twice, but I do
> believe that requesting a new patch revision just based on this criteria
> is nonsense. Can you please revise your review criteria?

I already said what I want. I want two patches and the first one with
Fixes tag. The reason for that is that the first patch fixes a problem
in patch that is already in my tree which is fixes a problem.

I am going to mark the patch for stables and the first patch in this
series.

I would like the commit log written clearly. Having a clear commit log
is a critical review comment. It is important for any change to have
clear commit logs for clarity and maintainability.

So please send me two patches one with Fixes tag and second that has
the -i support.

thanks,
-- Shuah


