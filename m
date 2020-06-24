Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243F1207E8B
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jun 2020 23:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403910AbgFXVaB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jun 2020 17:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390437AbgFXVaB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jun 2020 17:30:01 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCCAC061573;
        Wed, 24 Jun 2020 14:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=1HvsEisY+JqAH4eB24qkTv31vmmbufpD8xgSfU5UPdM=; b=Jgwwd3HKSCGDIrGfcDNLwUtCRw
        owE94w39EisUXpMHYIv1pbv2n5zjSMpa7/iif05p6zELIAPYkGaboNNN6TH29l13zX633oAS6RM8i
        u+py1W93Ar3xSPtumosRbnxJhxzE/IlIJ8zzS6Msi31BJfjrcR7Li/mepAU5QxssYRUraWQyCdWh/
        e0DBYe+ioO8w/tPmJJ0AAlXzL2Y9mhiO5Z3pKnX3q8XvSWDPiBsyiYMeVffdZCvaIkWLaSxm+lp/5
        GzV+OHjm+HMcDNoGcHIV0nUjJZLKNJmSJLKH4rSTl33X5olQIgDM/8f26BmNOkuNFTA7+0rVin7ia
        KLsAR9OA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1joCxj-0007YQ-1Z; Wed, 24 Jun 2020 21:29:43 +0000
Subject: Re: [PATCH drivers/misc 0/4] lkdtm: Various clean ups
To:     Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard.weinberger@gmail.com>
References: <20200529200347.2464284-1-keescook@chromium.org>
 <202006231610.4993DC5@keescook>
 <2356a78c-750b-538f-3d64-b9c78aff89cb@infradead.org>
 <903628180.54697.1592983405305.JavaMail.zimbra@nod.at>
 <202006241335.2C0FB5DF90@keescook>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b97853f0-c4be-7039-1d4c-96b3ab802472@infradead.org>
Date:   Wed, 24 Jun 2020 14:29:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <202006241335.2C0FB5DF90@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/24/20 1:36 PM, Kees Cook wrote:
> On Wed, Jun 24, 2020 at 09:23:25AM +0200, Richard Weinberger wrote:
>> ----- Ursprüngliche Mail -----
>>>>> Regardless, it seems arch/x86/um/asm/desc.h is not needed any more?
>>>
>>>> True that, we can rip the file.
>>>
>>> Has anyone fixed the uml build errors?
>>
>> I didn't realize that this is a super urgent issue. ;-)
>>
>> Kees, if you want you can carry a patch in your series, I'll ack it.
>> Otherwise I can also do a patch and bring it via the uml tree upstream
>> as soon more fixes queued up.
> 
> I think the lkdtm change will tweak this bug, so I'm happy to carry the
> patch (I just haven't had time to create and test one). Is it really
> just as simple as removing arch/x86/um/asm/desc.h?
> 

I just tried that and the build is still failing, so No, it's not that simple.

But thanks for offering.

I'll just ignore the UML build errors for now.

-- 
~Randy

