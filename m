Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADD7E96911
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2019 21:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbfHTTIe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Aug 2019 15:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728185AbfHTTIe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Aug 2019 15:08:34 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDF8A2082F;
        Tue, 20 Aug 2019 19:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566328112;
        bh=EQcE7jgODYPqBxFha4axxuVZtCHbZv+lyg0wG/vxuqE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=V//JOo/nBlns1BIGxHPsWcL0jiR9TJx2KmCu8eYP4YNIYAdhdLuzoIx3vOjLgJOWf
         qywhT+G/ZqWkgzBVmgCpi40PPee/iCkXqnClTUaQ9H817cboZ6rQYsqsdhOXzkxXEe
         SSvE0tF9mSLKe15z7ad2lgpjVB8OR8ObBpC4AYuQ=
Subject: Re: [PATCH v13 00/18] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
        shuah <shuah@kernel.org>
References: <20190814055108.214253-1-brendanhiggins@google.com>
 <5b880f49-0213-1a6e-9c9f-153e6ab91eeb@kernel.org>
 <20190820182450.GA38078@google.com>
From:   shuah <shuah@kernel.org>
Message-ID: <e8eaf28e-75df-c966-809a-2e3631353cc9@kernel.org>
Date:   Tue, 20 Aug 2019 13:08:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820182450.GA38078@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/20/19 12:24 PM, Brendan Higgins wrote:
> On Tue, Aug 20, 2019 at 11:24:45AM -0600, shuah wrote:
>> On 8/13/19 11:50 PM, Brendan Higgins wrote:
>>> ## TL;DR
>>>
>>> This revision addresses comments from Stephen and Bjorn Helgaas. Most
>>> changes are pretty minor stuff that doesn't affect the API in anyway.
>>> One significant change, however, is that I added support for freeing
>>> kunit_resource managed resources before the test case is finished via
>>> kunit_resource_destroy(). Additionally, Bjorn pointed out that I broke
>>> KUnit on certain configurations (like the default one for x86, whoops).
>>>
>>> Based on Stephen's feedback on the previous change, I think we are
>>> pretty close. I am not expecting any significant changes from here on
>>> out.
>>>
>>
>> Hi Brendan,
>>
>> I found checkpatch errors in one or two patches. Can you fix those and
>> send v14.
> 
> Hi Shuah,
> 
> Are you refering to the following errors?
> 
> ERROR: Macros with complex values should be enclosed in parentheses
> #144: FILE: include/kunit/test.h:456:
> +#define KUNIT_BINARY_CLASS \
> +       kunit_binary_assert, KUNIT_INIT_BINARY_ASSERT_STRUCT
> 
> ERROR: Macros with complex values should be enclosed in parentheses
> #146: FILE: include/kunit/test.h:458:
> +#define KUNIT_BINARY_PTR_CLASS \
> +       kunit_binary_ptr_assert, KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT
> 
> These values should *not* be in parentheses. I am guessing checkpatch is
> getting confused and thinks that these are complex expressions, when
> they are not.
> 
> I ignored the errors since I figured checkpatch was complaining
> erroneously.
> 
> I could refactor the code to remove these macros entirely, but I think
> the code is cleaner with them.
> 

Please do. I am not veru sure what value these macros add.

thanks,
-- Shuah
