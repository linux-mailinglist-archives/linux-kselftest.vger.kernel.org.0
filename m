Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07E46E2B51
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 22:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjDNUyk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 16:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjDNUyj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 16:54:39 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA70B3C33;
        Fri, 14 Apr 2023 13:54:37 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id B653732009AF;
        Fri, 14 Apr 2023 16:54:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 14 Apr 2023 16:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1681505674; x=1681592074; bh=rl
        FheFZweK49BGNnFZwEc5L1U+sCs9kJT/iFa/MIfcY=; b=u1KA8P2Tn9lh3rLH8/
        IKeBdjNTCA2wxQNFIbuPaY07Py0Y0ltUhQ5goajpEAUVtiAwucxonhvnyocX3xux
        r56rJRVSFg+D6i+luKjatEQy+zj7s6s5kp0ebHYGPL1gdQE6sT9W5xe8loLNgDBi
        Okg7PEwo3ZS5VRbdFXExWzY/PKj8gAwMn05eBeZg2dTcPBfelIirqURrStGOGMIy
        n64Wugriv0ITNyunTinny1460VZb++52aAxFNEG+ziAECVtpIZ38pKGYnV+gCxm6
        JaRaXfQcVuPDA/xmysVjeToN9qZVzsAmoTE07cuCUszwsn3W3+5yPaLUbX9LpuZo
        Jj6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681505674; x=1681592074; bh=rlFheFZweK49B
        GNnFZwEc5L1U+sCs9kJT/iFa/MIfcY=; b=JWAQb6wJO0ZMS2m0H5Z1TIrf0S9I9
        2pFUgxntkJmVV7z6EzbmF14L47kj4w4w8cdNK7SXSCHuNALtL47LC2OUQrPNFV2G
        jufOL8wePIOJQBUhgUxXz8ac8IIrG3YZwP6gzvdEuJ1hcRw4Fej95mcnVpQodorV
        7o4kApOZCmJmIdX0+LoQYqwlhB5aM1pdCwBQ3v+0qTnnl2B9I1wOc1lCpshYX/0m
        09esXPm4ImkltPrclx1Cvv2HQ5JTzhno98B4mi15ShIWlNCE/X1V7LW8CmB3+Eci
        H43Fv6HfGyeR3/sGO89BmaRzHDx5IowhLcWYgSxPgEgdzyDVOkXVZG7Rg==
X-ME-Sender: <xms:ib05ZPQYm8GkfVOjZfyTZRHAtNo1swXQbdimbehpTw8ppy2t0dn5EA>
    <xme:ib05ZAz0Wqgr-5AxgfE8BYHoccDeSMAmMxcHCqyX4-LWnc4gC6zI5nRnTfordAZ3x
    tUcv-yI1rmksu9lEmY>
X-ME-Received: <xmr:ib05ZE0JbcA8U9qC4SVcsuRHzMHeFUmTHSRa6LsBF1EeFP7A8HXu5Rzc1NbY--is7Piq89vpcy9oyyF8NkRloSFm90-xGHjSMjPX55qbdpHC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeltddgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
    geeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:ib05ZPCPp4LuPEHYpE4j7pZiIO1ylhg5Bo6uqLuDU1h08wQ0aylQ5g>
    <xmx:ib05ZIitLTp-DSRqR_kAxRsb9rtxguOMRes6XU9qBmkzx5azF3XNeQ>
    <xmx:ib05ZDqvoTkqjpqvD3F-ad68jCFl5tEpRIm1TVuQwmAAAJs3H_Gf2g>
    <xmx:ir05ZLOMgNEP3U30CDYNavf5UO0urWeu_CibcYbb9bHtjLL0GSGZTQ>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Apr 2023 16:54:32 -0400 (EDT)
References: <20230413233115.1878303-1-shr@devkernel.io>
 <20230413233115.1878303-2-shr@devkernel.io>
 <d2df2d42-66bd-3b7a-99a1-370cc91906e4@redhat.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, willy@infradead.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v7 1/3] mm: add new api to enable ksm per process
Date:   Fri, 14 Apr 2023 13:53:15 -0700
In-reply-to: <d2df2d42-66bd-3b7a-99a1-370cc91906e4@redhat.com>
Message-ID: <qvqwcz46gp6j.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> Thanks!
>
> In general,
>
> Acked-by: David Hildenbrand <david@redhat.com>
>
> Two nits below, after staring at some other prctl implementations.
>
>> +#define PR_SET_MEMORY_MERGE		67
>> +#define PR_GET_MEMORY_MERGE		68
>>   #endif /* _LINUX_PRCTL_H */
>> diff --git a/kernel/sys.c b/kernel/sys.c
>> index 495cd87d9bf4..8c2e50edeb18 100644
>> --- a/kernel/sys.c
>> +++ b/kernel/sys.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/highuid.h>
>>   #include <linux/fs.h>
>>   #include <linux/kmod.h>
>> +#include <linux/ksm.h>
>>   #include <linux/perf_event.h>
>>   #include <linux/resource.h>
>>   #include <linux/kernel.h>
>> @@ -2661,6 +2662,30 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>>   	case PR_SET_VMA:
>>   		error = prctl_set_vma(arg2, arg3, arg4, arg5);
>>   		break;
>> +#ifdef CONFIG_KSM
>> +	case PR_SET_MEMORY_MERGE:
>
> Looking at some other code (PR_SET_NO_NEW_PRIVS/ PR_SET_THP_DISABLE) I wonder if
> we also want
>
> if (arg3 || arg4 || arg5)
> 	return -EINVAL;
>
I added the above check. It requires that we always specify all
parameters in the test programs. I also changed them accordingly.

> For PR_GET_MEMORY_MERGE it looks good already.
>
>> +		if (mmap_write_lock_killable(me->mm))
>> +			return -EINTR;
>> +
>> +		if (arg2) {
>> +			error = ksm_enable_merge_any(me->mm);
>> +		} else {
>> +			/*
>> +			 * TODO: we might want disable KSM on all VMAs and
>> +			 * trigger unsharing to completely disable KSM.
>> +			 */
>> +			clear_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
>> +			error = 0;
>> +		}
>> +		mmap_write_unlock(me->mm);
>> +		break;
>> +	case PR_GET_MEMORY_MERGE:
>> +		if (arg2 || arg3 || arg4 || arg5)
>> +			return -EINVAL;
>> +
>> +		error = !!test_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
>> +		break;
>> +#endif
>>   	default:
>>   		error = -EINVAL;
>>   		break;
>
> [...]
>
>> +/**
>> + * ksm_enable_merge_any - Add mm to mm ksm list and enable merging on all
>> + *                        compatible VMA's
>> + *
>> + * @mm:  Pointer to mm
>> + *
>> + * Returns 0 on success, otherwise error code
>> + */
>> +int ksm_enable_merge_any(struct mm_struct *mm)
>> +{
>> +	int err;
>> +
>> +	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
>> +		return -EINVAL;
>
>
> I'm curious, why is enabling the prctl() supposed to fail if already enabled?
> (it would not fail if disabling and already disabled)
>

I changed that to not return an error in that case.
>
> For example, PR_SET_THP_DISABLE/PR_SET_NO_NEW_PRIVS doesn't fail if already set.
