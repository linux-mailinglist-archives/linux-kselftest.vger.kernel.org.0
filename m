Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9056EB1A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 20:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjDUS3O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 14:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjDUS3O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 14:29:14 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F92E1BD5;
        Fri, 21 Apr 2023 11:29:13 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 8C7B35C00C9;
        Fri, 21 Apr 2023 14:29:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 21 Apr 2023 14:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1682101752; x=1682188152; bh=E1
        giA72jTN/HCoY+ZkODXi5a5cgWitw0+lONQS3/t7A=; b=cLCvpeRM5lx2n8YJEv
        ctpJlrZd/cvTHHyzMCqw1BVqTcXVgeLCqb6QV1QZ0tmVSCw9Hokf234+XqSzm4wE
        8ZE2nK2wllZNzlTioQ86W4TDsy24scnOtD3hOgN0i3sihzKtD/okV26x7RMy9Bd0
        2LXLm7wPcpVpII3aB9gwV7jKqUblefDZ83PxTFnb1EHAHQggvFodY38vkpyMRptU
        hl0PYvUz/2O8jpnRSYxgPwgQGxXBJv2NDPISJg1Bh/F/2iUTViHO30IulUGDPCCy
        Z8n7wWABxBx8tPwzyZv+kYdZ3sRfOpFf9kCDyQmAVjQhC3u9TmI3DbQvqjNzdC0x
        g0OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682101752; x=1682188152; bh=E1giA72jTN/HC
        oY+ZkODXi5a5cgWitw0+lONQS3/t7A=; b=XIrOUyfO9vgiYaLiAwjPy6D6dkCoa
        284FdZQk/VS33jzayeoEjODvPto3BtKkfK70YwVOCM2JSOMn75m1dCaqYnLonpC3
        9l5MIAw/lEGNYqSmWOPgvPg7EwkCcuIXJmxOeQUxnkwBVJcgugyAAd1ThFSemUbR
        6Hqy95yY9FGhXXuago4M6ZZKvk2fpnGwEi/ttra1jyu+Z7uefg/A0ULK7lcOcilI
        Kjrwf6Zb16O5X4zZv2iaYMNJbRIC8Oq+agK1Ke/2HXtUuQ2K1gKENt8ONx5a3htl
        nlsAz9A8jPMF8dMPtv/L5qnyuCMMxN8zqAzpb3arJMG4eGGB7CWOIloqQ==
X-ME-Sender: <xms:-NVCZJ1y9aVR_c2-q74uNpgqQQIr4t699w2AZhqOzF6hB3vvFL0Olw>
    <xme:-NVCZAH3LEUyx7er7Xqd1PCEpJqR8mCpiOSdEwl-n_4r8_mSyJvkxUQMe6Rwxk53h
    MynYdHG-vSvBpvUffM>
X-ME-Received: <xmr:-NVCZJ5pXGSRP5sW3a08clyDOmzstPkj0c4movDV16kxcaNiRpHt9YS-2uWnqQ7LkXov430R-wH_h4KRxHv33W4uJ6WOIZi_VRySJQf2VKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtgedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
    geeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:-NVCZG1YyGj4YgZUYhedoOMlBVfL44meJBCxX7zwKb3AwiWd6aQ3qQ>
    <xmx:-NVCZMFYf-PDrJWxacrKl9YQqn1WOtd2h_N3L0Ipw-uFeEQeTgspBg>
    <xmx:-NVCZH_MyPcAEHIY_wVcMcgN6VxV-l6kIJ8aLexBsK6hoJDXrynoRQ>
    <xmx:-NVCZJdmIt5oZlIXlfJZ1g609Ohse9_1NSdEJhW0c04NsWiZWbgJYQ>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Apr 2023 14:29:10 -0400 (EDT)
References: <20230418051342.1919757-1-shr@devkernel.io>
 <20230418152849.505124-1-david@redhat.com>
 <20230418152849.505124-2-david@redhat.com>
 <qvqwr0sei6sl.fsf@devbig1114.prn1.facebook.com>
 <d476d75d-74a8-9cad-a60e-4b5ecb149719@redhat.com>
 <f809162e-4adc-cf9b-35f4-0f1b098ad283@redhat.com>
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
Subject: Re: [PATCH v1 1/3] mm/ksm: unmerge and clear VM_MERGEABLE when
 setting PR_SET_MEMORY_MERGE=0
Date:   Fri, 21 Apr 2023 11:28:49 -0700
In-reply-to: <f809162e-4adc-cf9b-35f4-0f1b098ad283@redhat.com>
Message-ID: <qvqwwn25rswa.fsf@devbig1114.prn1.facebook.com>
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

>>> I understand we want to keep the name "symmetric" with
>>> ksm_enable_merge_any, but it also unmerges the ksm pages. Do we want to
>>> reflect that in the function name?
>> ksm_disable_merge_any_umerge() is suboptimal.
>> As ksm_disable_merge_any() now reverts what ksm_enable_merge_any() ended
>> up doing, I think it's just fine.
>> (it would be a different story if we'd be using "set" / "clear"
>> terminology instead of "enable" / "disable").
>> We can describe that in the comment.
>>
>>>
>>> Can we add a comment for the function?
>> Can do for symmetry with ksm_enable_merge_any().
>>
>
> +/**
> + * ksm_disable_merge_any - Disable merging on all compatible VMA's of the mm,
> + *                        previously enabled via ksm_enable_merge_any().
> + *
> + * Disabling merging implies unmerging any merged pages, like setting
> + * MADV_UNMERGEABLE would. If unmerging fails, the whole operation fails and
> + * merging on all compatible VMA's remains enabled.
> + *
> + * @mm: Pointer to mm
> + *
> + * Returns 0 on success, otherwise error code
> + */


LGTM

Acked-by: Stefan Roesch <shr@devkernel.io>
