Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B316E4E5B
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Apr 2023 18:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjDQQhf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Apr 2023 12:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDQQhe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Apr 2023 12:37:34 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F65D6A7C;
        Mon, 17 Apr 2023 09:37:33 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C9F1C5C01C0;
        Mon, 17 Apr 2023 12:37:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Apr 2023 12:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1681749452; x=1681835852; bh=v1
        qN0g4dtsVGZPafBKFaoMbrRN/kATZVzGtNJlDrMfg=; b=FJPeon0owpc1wVZTT5
        Uddxuj7DlNy0Xmm0JzR0rN5sTubjR33v5M8C/00sxwcQ2+ozIHvV6vDXWj+irx1o
        +mPqUq3wblpJCU39382uT41/VpK2QVSaypiYNZRHG9j0AxIA8OMgJROqx6j2jAop
        ivbUYG8zUyNNKM0k5oo5PxjzAxCiGrde4MbI9hJ+mMIFPBLRjxkXPIKP/+OI7A7D
        q3npHLte+yhmFpAoS1t4kk9Q2PfA9cN14Lp3MBmT5M9+eqij++XxrvfzUVRjxCwk
        09HQaOBQo8DsKCRUp+u91gdNoKAtBKURcphjqP0X2mFZF1FQ5efnm6wxt08xA3MG
        Hg5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681749452; x=1681835852; bh=v1qN0g4dtsVGZ
        PafBKFaoMbrRN/kATZVzGtNJlDrMfg=; b=Wt7BDW2hAaSJcxIAKkiWwC195nljq
        e3m8PxuhjGikDlIKvOXA2SlIcEAb90DkuomYCCP93lAvxvebbyzakOuM0KseNLSE
        Ca8ltlzbNQw6ZPrVDRaGlSSVoNcDOCNeqvwXvZysQP2vyopGtTkTmlg0VI3fUY0L
        uDNHxlCgPprGald32urVBpGvGfTs9QcWsScJ6FJFIDLX6SN2G8EqRGABe+GFLp1J
        NeaYbnPQmIoPIpQBnoSHq8E75ieLs9I/SlSw7cmt7o+zPYrkDd9APSiF9GNkbYVw
        xINhQGgn1DS/6n2X9nrbFEP4h1S59eIXPa2fL2To6wYHCq9FK/Ba/gVyA==
X-ME-Sender: <xms:y3U9ZBN2rt1QunQbx5gMh828WUsTbdPTbWapLkhxz8PcQ4IrG6BG8A>
    <xme:y3U9ZD9017z1OT8cr_QcGLm9lWqFWz6URYAgoMW1SeuHx6Vt23WWUGMNyF8tw106S
    TxlR-ZArQyTLx0s0Zg>
X-ME-Received: <xmr:y3U9ZARxob3A73TT69esO8Sn0UWFo4BELenPaCldEvpx-k7WAU5czyJb7S6_5AQGANb20B8A5hWdCKWWIqPm30TBNTGJyTSu8wLdMs2IYPob>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeliedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
    geeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:zHU9ZNsi2rWPzjd744cRooDsNB5_5in3TtevpaJN6Mn09-2AlUCQfA>
    <xmx:zHU9ZJddWbG2k1qgEvCyOY-1lLmEruS_DFrNurSHH95vTs1W8NxFpA>
    <xmx:zHU9ZJ0fPYejG6WuTLgEioCdMxlJcHWIfmKyXb6b-BalvMNLYoLbBw>
    <xmx:zHU9ZF6w-eg7YAKlaUnmVMpocd-lR5eJ1buXvzJwTRc20BcsqEuxAw>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Apr 2023 12:37:30 -0400 (EDT)
References: <20230415225913.3206647-1-shr@devkernel.io>
 <20230415225913.3206647-2-shr@devkernel.io>
 <b9f1fd7f-e362-8f6c-21db-e84dd82fdd00@redhat.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, willy@infradead.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v8 1/3] mm: add new api to enable ksm per process
Date:   Mon, 17 Apr 2023 09:36:58 -0700
In-reply-to: <b9f1fd7f-e362-8f6c-21db-e84dd82fdd00@redhat.com>
Message-ID: <qvqwa5z6bh2x.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

>> +static void __ksm_add_vma(struct vm_area_struct *vma)
>> +{
>> +	unsigned long vm_flags = vma->vm_flags;
>> +
>> +	if (vm_flags & VM_MERGEABLE)
>> +		return;
>> +
>> +	if (vma_ksm_compatible(vma)) {
>> +		vm_flags |= VM_MERGEABLE;
>> +		vm_flags_reset(vma, vm_flags);
>> +	}
>> +}
>
> We can do the following simplification on top:
>
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 905c8edce5cf..26e7f585d65d 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2511,15 +2511,11 @@ static int ksm_scan_thread(void *nothing)
>
>  static void __ksm_add_vma(struct vm_area_struct *vma)
>  {
> -	unsigned long vm_flags = vma->vm_flags;
> -
> -	if (vm_flags & VM_MERGEABLE)
> +	if (vma->vm_flags & VM_MERGEABLE)
>  		return;
>
> -	if (vma_ksm_compatible(vma)) {
> -		vm_flags |= VM_MERGEABLE;
> -		vm_flags_reset(vma, vm_flags);
> -	}
> +	if (vma_ksm_compatible(vma))
> +		vm_flags_set(vma, VM_MERGEABLE);
>  }
>
>  /**
> --
> 2.39.2
>
>

The next version has the above change.

> I have some patches based on your patch set (handling/testing unmerging whens
> setting PR_SET_MEMORY_MERGE=0. Will send out once you changes are queued.
