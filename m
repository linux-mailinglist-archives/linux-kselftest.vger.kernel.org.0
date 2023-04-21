Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199A96EB19D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 20:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjDUS2D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 14:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjDUS2C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 14:28:02 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0C519A1;
        Fri, 21 Apr 2023 11:28:00 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A18465C00CA;
        Fri, 21 Apr 2023 14:27:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 21 Apr 2023 14:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1682101676; x=1682188076; bh=1x
        lLdlOEPewjSa9H68FV8Q5PO9B90Oygi7b4UAbYuQc=; b=P0wYN+pJ1GfvlJDlIK
        3HaP8g8yxh54ko7FtDNoDaJ2UbAHZEH6f/Q++W6+apsYdWGtFEWE+VFQXClEsVG0
        cNC/sNVd7/oMjY/xFtIAWOJvmZ7uXQ3mbJVWBHrrjEx3NEiwyXlrYfFrx4cv6pDx
        VHBa48YtKHzwfxpnI4JwohAAQtDQDSVVXx3QUmBAY7B+68+wZhG/dLvNn0OnsREa
        qjko2RCCZp7nO9MKyb0UCfHlnuT0PwJTFQfwhCSCs45y7Jxi3w6bnMbx8tbwVJ+3
        //HYMjrxXN9VmmIBgsf8diCnZkCyjN3KiEiba50EMyFCX6mLalVggfzcTxbFQiYz
        Lytw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682101676; x=1682188076; bh=1xlLdlOEPewjS
        a9H68FV8Q5PO9B90Oygi7b4UAbYuQc=; b=YTbnAZJ3qUMiRj76RGU6xiJMr7F8Z
        AkF4d4qdl55apNKQF1ibg7v+FTxNs6LEJ9T/CbhXqMm/CMr0JUPsGdGAWF/cq1n4
        hdoa6M0lt7boS8FLRptsOOIxImYCjFW8X9zq0pzlUlPuvbO8jWhlu7IAumUoDL66
        qPBnyF2O0qu3+eKvQDofPbKIcJxXx7Vd0ivDUBvs9vBJAhlWOK1cWnup0gDjoYZS
        h8IXrSxl6vOW0PEIz+/bZERGinxio39/2lX8YmfR8N9mQat+4+V3G24GUH/f4JCM
        ZhJu46SbqRu3jmGtCF3l1bDmHnLHOFm9RUaS0AiHZtwdl0+ofXuNUEK5A==
X-ME-Sender: <xms:q9VCZCFDX2nqX67ccz6mq1jOzR_AMacb5lcdq5NNHqkuLc3FbSfYSw>
    <xme:q9VCZDVXQTxIZCG0loGHeTRP5Q4y_FCfIYkj1kRq-oMsIjPR5cLqZLWopyE52ma_Y
    RAwezAEAyhyTkOKUxo>
X-ME-Received: <xmr:q9VCZMIXaK428S5JbttqSvA3CLOiVtzsGyu9Uq5cGBDezl-8UN-jCAiqdY1pNdbsbZ8Qw0SvXWigkQe0O6tdGCfnSg9YPtHNSQ61RVgkTrQ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtgedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
    geeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:rNVCZMHVZS-4pncHd9-02mz0hAwf0CGUjbWL3hNW6AshGaj9kybLCg>
    <xmx:rNVCZIUtl1QWh3zeGrKmIctWOfETI1j93FF58B4EwRfQ2D1V_xxXcA>
    <xmx:rNVCZPN7xqRHXuvJcK01DNR4CQUHk5_viNRdAndV--AkHsVzceDCkw>
    <xmx:rNVCZJuMXQ7scwPUwjssuOK1J9USlnK-U41WGOH4io698Rs2VCTkrQ>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Apr 2023 14:27:54 -0400 (EDT)
References: <20230418051342.1919757-1-shr@devkernel.io>
 <20230418152849.505124-1-david@redhat.com>
 <20230418152849.505124-4-david@redhat.com>
 <qvqwildqi62z.fsf@devbig1114.prn1.facebook.com>
 <14d89518-0c11-7bfb-0c72-329a834ba1a1@redhat.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1 3/3] mm/ksm: move disabling KSM from s390/gmap code
 to KSM code
Date:   Fri, 21 Apr 2023 11:27:23 -0700
In-reply-to: <14d89518-0c11-7bfb-0c72-329a834ba1a1@redhat.com>
Message-ID: <qvqw1qkdt7iw.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> [...]
>
>>> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
>>> index 0949811761e6..dfe905c7bd8e 100644
>>> --- a/arch/s390/mm/gmap.c
>>> +++ b/arch/s390/mm/gmap.c
>>> @@ -2585,30 +2585,12 @@ EXPORT_SYMBOL_GPL(s390_enable_sie);
>>>
>>>   int gmap_mark_unmergeable(void)
>>>   {
>>> -	struct mm_struct *mm = current->mm;
>>> -	struct vm_area_struct *vma;
>>> -	unsigned long vm_flags;
>>> -	int ret;
>>> -	VMA_ITERATOR(vmi, mm, 0);
>>> -
>>>   	/*
>>>   	 * Make sure to disable KSM (if enabled for the whole process or
>>>   	 * individual VMAs). Note that nothing currently hinders user space
>>>   	 * from re-enabling it.
>>>   	 */
>>> -	clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
>>> -
>>> -	for_each_vma(vmi, vma) {
>>> -		/* Copy vm_flags to avoid partial modifications in ksm_madvise */
>>> -		vm_flags = vma->vm_flags;
>>> -		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
>>> -				  MADV_UNMERGEABLE, &vm_flags);
>>> -		if (ret)
>>> -			return ret;
>>> -		vm_flags_reset(vma, vm_flags);
>>> -	}
>>> -	mm->def_flags &= ~VM_MERGEABLE;
>>>
>>
>
> Hi Stefan,
>
>> This clears the def_flags struct member, however, in ksm_disable() we
>> clear the __flags struct member. Is this a problem?
>
> The patch description contains a comment regarding def_flags: "The existing
> "mm->def_flags &= ~VM_MERGEABLE;" was essentially a NOP and can be dropped,
> because def_flags should never include VM_MERGEABLE."
>
> We keep clearing the MADV_UNMERGEABLE flag from MADV_UNMERGEABLE. In the old
> code, ksm_madvise() would have cleared it from local vm_flags and
> vm_flags_reset() would have modified vma->vm_flags. Now we clear it directly via
> vm_flags_clear(vma, VM_MERGEABLE);
>
>
> Long story short, the mm->def_flags code as wrong and most probably copied from
> thp_split_mm() where we do:
> 	mm->def_flags |= VM_NOHUGEPAGE;
> Which makes more sense.
>
> Thanks!

Thanks for the explanation.

Acked-by: Stefan Roesch <shr@devkernel.io>
