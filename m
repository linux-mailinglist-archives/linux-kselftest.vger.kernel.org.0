Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB7A185036
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Mar 2020 21:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCMUYH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 16:24:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgCMUYH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 16:24:07 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A17D22074D;
        Fri, 13 Mar 2020 20:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584131047;
        bh=yMoU/FbUdD2N1CFUaD6+ZxXX1ocMmdl1pxHfs53ZL1M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=avoUwfgh+QU+KB35TaTD8FPLSPScxxAblOQu/kCoe3XkuljZNad7QTNEJQbrl6Wpo
         xmIbynPP70iRdxYXCn+ha6EsOGI34QBpCOHO8YwZ/Unb9lF9grR4TDiEr0zbsz6Z5w
         vbMcqGr8ez1u2Uuq8rhKsBCp3URsbNKLvKWNe7pg=
Subject: Re: [PATCH] kunit: add --make_options
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Greg Thelen <gthelen@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        shuah <shuah@kernel.org>
References: <20200227063134.261636-1-gthelen@google.com>
 <20200229015350.GA26612@ubuntu-m2-xlarge-x86>
From:   shuah <shuah@kernel.org>
Message-ID: <4bb8eeef-54ac-86a7-4bc4-8e16fc149c1a@kernel.org>
Date:   Fri, 13 Mar 2020 14:24:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200229015350.GA26612@ubuntu-m2-xlarge-x86>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/28/20 6:53 PM, Nathan Chancellor wrote:
> On Wed, Feb 26, 2020 at 10:31:34PM -0800, 'Greg Thelen' via Clang Built Linux wrote:
>> The kunit.py utility builds an ARCH=um kernel and then runs it.  Add
>> optional --make_options flag to kunit.py allowing for the operator to
>> specify extra build options.
>>
>> This allows use of the clang compiler for kunit:
>>    tools/testing/kunit/kunit.py run --defconfig \
>>      --make_options CC=clang --make_options HOSTCC=clang
>>
>> Signed-off-by: Greg Thelen <gthelen@google.com>
> 
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> 

Please rebase on Linux 5.6-rc5 and resend. I tried applying
on Linux 5.6-rc1 as well as 5.6-rc5 and both fail.

thanks,
-- Shuah
