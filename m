Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2603E20966C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jun 2020 00:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389453AbgFXWfg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jun 2020 18:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732806AbgFXWfg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jun 2020 18:35:36 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B572AC061573;
        Wed, 24 Jun 2020 15:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=bhS1Vuyypm9th+5GJw/HKQdOHuU/MTx6akXfmJuKHvw=; b=if31kHFgzAbw0rU+YUMGkqrRxq
        Q8SFQDr9SbCuqGcy0B4jVxrVBH4/HCNRbndoho42nZ58DkzXL6Oj+WAl5UL1Cto1C3aNoBtfQlvln
        Mua2teIZlo7OITMedu5+wQ/4L01fOnD2dPx2sldyaWxGdmkE2zOz9ddeQ504JN4PHKExNyKd0p/1y
        WBa3yIkLqLX//UwN62cMfQwySJI0H777IMAlMaufuG+fvSAMvgbb3NDumQqwFkyN6dn7L00ic01pI
        E53pV2tcRqWg1suL6qo8s24b7MSOsnzTWcg2/lFSsssfSpNWdbWYGRgdL8ImUgQEaRbIdfs/xysy0
        cMvkxrjg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1joDzB-0001oJ-1l; Wed, 24 Jun 2020 22:35:17 +0000
Subject: Re: [PATCH drivers/misc 0/4] lkdtm: Various clean ups
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200529200347.2464284-1-keescook@chromium.org>
 <202006231610.4993DC5@keescook>
 <2356a78c-750b-538f-3d64-b9c78aff89cb@infradead.org>
 <903628180.54697.1592983405305.JavaMail.zimbra@nod.at>
 <202006241335.2C0FB5DF90@keescook>
 <b97853f0-c4be-7039-1d4c-96b3ab802472@infradead.org>
 <CAFLxGvxiyyX9s=y4phGxvWh-vonS1WPOUbRZr9mgq-B+wY+2nQ@mail.gmail.com>
 <10f7c20a-0a32-f5cf-7fdf-761db22afcd9@infradead.org>
Message-ID: <03486f13-b138-2fc6-4d90-2737d86add2f@infradead.org>
Date:   Wed, 24 Jun 2020 15:35:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <10f7c20a-0a32-f5cf-7fdf-761db22afcd9@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/24/20 3:23 PM, Randy Dunlap wrote:
> On 6/24/20 3:01 PM, Richard Weinberger wrote:
>> On Wed, Jun 24, 2020 at 11:29 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>> On 6/24/20 1:36 PM, Kees Cook wrote:
>>>> On Wed, Jun 24, 2020 at 09:23:25AM +0200, Richard Weinberger wrote:
>>>>> ----- Ursprüngliche Mail -----
>>>>>>>> Regardless, it seems arch/x86/um/asm/desc.h is not needed any more?
>>>>>>
>>>>>>> True that, we can rip the file.
>>>>>>
>>>>>> Has anyone fixed the uml build errors?
>>>>>
>>>>> I didn't realize that this is a super urgent issue. ;-)
>>>>>
>>>>> Kees, if you want you can carry a patch in your series, I'll ack it.
>>>>> Otherwise I can also do a patch and bring it via the uml tree upstream
>>>>> as soon more fixes queued up.
>>>>
>>>> I think the lkdtm change will tweak this bug, so I'm happy to carry the
>>>> patch (I just haven't had time to create and test one). Is it really
>>>> just as simple as removing arch/x86/um/asm/desc.h?
>>>>
>>>
>>> I just tried that and the build is still failing, so No, it's not that simple.
>>>
>>> But thanks for offering.
>>>
>>> I'll just ignore the UML build errors for now.
>>
>> This is a allyesconfig?
>> I just gave CONFIG_LKDTM=y a try, builds fine here.
>>
> 
> I'm building linux-next and it fails.

More specifically, uml for i386 fails. x86_64 is OK.
The problem is with the <asm/desc.h> file.
I'm tampering with it...

>> But the desc.h in uml is still in vain and can be deleted AFAICT.


-- 
~Randy

