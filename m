Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8D342306E
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Oct 2021 20:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhJES4K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 14:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhJES4I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 14:56:08 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8421C061749;
        Tue,  5 Oct 2021 11:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=FVV1YBR9IhK1qGAecM676RSXQazVBgX6DGfNAvuxHgc=; b=f583AHTNgWAXJ8zuMWjbXeWRjT
        WrYsMtxnSidRz5GscdqlzgrkcjjaciUNW7qTvj0nOuCpHeqgCAkB3AhqCB3DuaOVIq5X4uSvmlr7Y
        5u9p3ZxbBJqT6s7DUM2skHjcyJIMFyg5tRADwX5oIRpl4cPlj1ZLeTku6bVPsCwUpn9NrLVzIlG1F
        4/SDJtQFLWO1iqp2rOL02Uh7inJwUTPqfnxHRLwT6URkjYWwJ8xtoJc0F9vSE/fL3lGimq73sXNhU
        WviSOgDte/2FY7Q2tO0JR4We+TIVy9myu/F53UyJddgJwSw4A7V3fvUpQAw9ehkVSWkFf2rp3/jlJ
        HvwjaAbQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXpZv-00BZNT-TI; Tue, 05 Oct 2021 18:54:15 +0000
Subject: Re: [PATCH] kunit: fix kernel-doc warnings in doc. build
To:     Daniel Latypov <dlatypov@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211005053019.26284-1-rdunlap@infradead.org>
 <CAGS_qxqRQ+1DmKQwyw-=Yud5LTeZ9LzPQfh-ooOrFuQFN1V3Dg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <70b0b0c4-47d0-7bb3-3bdd-688a91074bfb@infradead.org>
Date:   Tue, 5 Oct 2021 11:54:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAGS_qxqRQ+1DmKQwyw-=Yud5LTeZ9LzPQfh-ooOrFuQFN1V3Dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/5/21 9:21 AM, Daniel Latypov wrote:
> On Mon, Oct 4, 2021 at 10:30 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Fix documentation build warnings in <kunit/test.h>:
>>
>> ../include/kunit/test.h:616: warning: Function parameter or member 'flags' not described in 'kunit_kmalloc_array'
>> ../include/kunit/test.h:616: warning: Excess function parameter 'gfp' description in 'kunit_kmalloc_array'
>> ../include/kunit/test.h:661: warning: Function parameter or member 'flags' not described in 'kunit_kcalloc'
>> ../include/kunit/test.h:661: warning: Excess function parameter 'gfp' description in 'kunit_kcalloc'
>>
>> Fixes: 0a756853586c ("kunit: test: add test resource management API")
>> Fixes: 7122debb4367 ("kunit: introduce kunit_kmalloc_array/kunit_kcalloc() helpers")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Brendan Higgins <brendanhiggins@google.com>
>> Cc: linux-kselftest@vger.kernel.org
>> Cc: kunit-dev@googlegroups.com
>> Cc: Daniel Latypov <dlatypov@google.com>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   include/kunit/test.h |    4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> --- lnx-515-rc4.orig/include/kunit/test.h
>> +++ lnx-515-rc4/include/kunit/test.h
>> @@ -607,7 +607,7 @@ void kunit_remove_resource(struct kunit
>>    * @test: The test context object.
>>    * @n: number of elements.
>>    * @size: The size in bytes of the desired memory.
>> - * @gfp: flags passed to underlying kmalloc().
>> + * @flags: gfp flags passed to underlying kmalloc().
> 
> Thanks for catching this.
> But can we instead rename the parameters?
> I can send out a patch for that if you'd prefer.
> 
> The other funcs here use `gfp_t gfp`, which is why this copy-pasted
> comment does too.
> In test.c, kmalloc_array() actually calls the parameter `gfp` as well.
> 

Sure, go ahead with it, please.

-- 
~Randy
