Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF55184BF8
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Mar 2020 17:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgCMQFb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 12:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgCMQFb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 12:05:31 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFC8B206EB;
        Fri, 13 Mar 2020 16:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584115531;
        bh=Bvh/Q7EbRtajUaWy5dHeFmGlTN0o6U8tvfsJdHTlJ9Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Jp5rb4jEwbDeIH0KiE/cAnLC9Yk3FoDiIEM5Pyu6bFo/s8AcLCbAadPrz4L1mnW4e
         xCbihyWDn+iqc9UrvjS3y/nFMJmYSj9FPSpEpjScOWAYoevoQ0gAEkJAiZh7eejESM
         N27P6U3pkYbsrZqPZcssCtjlg0c3LxgN5A7u+kJU=
Subject: Re: [PATCH v4] Documentation: kunit: Make the KUnit documentation
 less UML-specific
To:     Frank Rowand <frowand.list@gmail.com>,
        David Gow <davidgow@google.com>, brendanhiggins@google.com,
        skhan@linuxfoundation.org, corbet@lwn.net
Cc:     kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tim.Bird@sony.com, Frank Rowand <frank.rowand@sony.com>,
        shuah <shuah@kernel.org>
References: <20200228191821.42412-1-davidgow@google.com>
 <dd15aa59-d2ef-d42e-1a4f-82b42e2ea350@gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <ec2f35ef-54d2-cd67-5e30-33ce7612a6d4@kernel.org>
Date:   Fri, 13 Mar 2020 10:05:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <dd15aa59-d2ef-d42e-1a4f-82b42e2ea350@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/2/20 9:50 AM, Frank Rowand wrote:
> Hi David,
> 
> On 2/28/20 1:18 PM, David Gow wrote:
>> Remove some of the outmoded "Why KUnit" rationale, and move some
>> UML-specific information to the kunit_tool page. Also update the Getting
>> Started guide to mention running tests without the kunit_tool wrapper.
>>
>> Signed-off-by: David Gow <davidgow@google.com>
>> Reviewed-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>> Sorry: I missed a couple of issues in the last version. They're fixed
>> here, and I think this should be ready to go.
>>
>> Changelog:
>>
>> v4:
>> - Fix typo: s/offsers/offers
>> - Talk about KUnit tests running on most "architectures" instead of
>>    "kernel configurations.
>> v3:
>> https://lore.kernel.org/linux-kselftest/20200214235723.254228-1-davidgow@google.com/T/#u
>> - Added a note that KUnit can be used with UML, both with and without
>>    kunit_tool to replace the section moved to kunit_tool.
>> v2:
>> https://lore.kernel.org/linux-kselftest/f99a3d4d-ad65-5fd1-3407-db33f378b1fa@gmail.com/T/
>> - Reinstated the "Why Kunit?" section, minus the comparison with other
>>    testing frameworks (covered in the FAQ), and the description of UML.
>> - Moved the description of UML into to kunit_tool page.
>> - Tidied up the wording around how KUnit is built and run to make it
>>    work
>>    without the UML description.
>> v1:
>> https://lore.kernel.org/linux-kselftest/9c703dea-a9e1-94e2-c12d-3cb0a09e75ac@gmail.com/T/
>> - Initial patch
> 
> Thanks for all the changes.  The documents are now much more understandable
> and useful.
> 

Is this ready to go? If it goes through doc tree:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Otherwise, I can pic it up.

thanks,
-- Shuah
