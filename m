Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EB36A479C
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 18:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjB0ROA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 12:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjB0RN7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 12:13:59 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32E81F5D7;
        Mon, 27 Feb 2023 09:13:50 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8CC785C00C3;
        Mon, 27 Feb 2023 12:13:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 27 Feb 2023 12:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1677518027; x=1677604427; bh=LUVpbkbOVV
        hJGvh6tlAUfxtvsyg93Gkmc0ZZJNQ8gNo=; b=NobaauCzbV+4wwx7Su2f2k/Cqd
        LOqeAlTxHMOpEQ85svqRd/f0Q0OpMWGz+4zSvmzjfyuAHezIaXqRB6OaBbiEcubc
        HsdsBAqHNJfFe2gBLZBY5tPaHR34zyye0OI4FrxcAwIOwyMGVPTd6ghw+BS20vgg
        mfB4gNrjKkgTsrrsBJkD6SiV9zIt3bG4X6j73GjcAYjDJGVvEO6SFJiHDFFJYmQ7
        vGkmZZuTN48rnAw1VULPsGPCSBfHJXwMVhddIPeuzk8HJ3waZT9a+UNxMQVdIDBT
        ZSLtMoxmzoYD9/zyezg6EH2MQLogojXqYoZoHVmETWoIAYK1aSe4xc86CFkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677518027; x=1677604427; bh=LUVpbkbOVVhJGvh6tlAUfxtvsyg9
        3Gkmc0ZZJNQ8gNo=; b=n+arKDeylN3OwjK3v3Y8rayX3lqYWJEfre8CoOGQMuzZ
        KQaI4OjS1EWu6J5fTl2yBHnFuSTXjhLrAQE1FBcICYDE/XNV8CxLdcIH7Q22ca1L
        laR79WR+y1u1ZJrAGhkf+07RBBeGqLRYXqtC4F7LZmuGOlTTYurOQ7RexKHhU6vM
        +gsol63AcwiokZc7K5hlKSpIXtQmZmSsbN3lG7Imua7+d6M3LyHgMzPPU/to/kps
        0aBJwZSPklBHnPRb9aksvaPxXypppfHX5dFynF7+UXq23FF3eZBJd5qsE/DdzJPV
        BbXyHVyv3QsiAozJ72uRbkDJZJLIPG6xk4XEyesgLg==
X-ME-Sender: <xms:y-T8Y8AmstmAj3v1FCo36tet2j_4ekT3urf2LZ0nexuHDOP1vPwDTg>
    <xme:y-T8Y-gboUABrHuCbQ9UzUha_lav46J7RotUKuwxFgPyjLZ4SfA9GYVTJZR2uJCce
    xjiY7uMuCRvyW3bfCQ>
X-ME-Received: <xmr:y-T8Y_mp6ySD11K5eVACbFO9JXz1YiR0RxOcBqAtf3dSvbV6mDFiHcwRTqLPw8QHIE-V3kyIYg0iRH6HNevXHM-3uehRzidAtQOD3WZo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeltddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpehffgfhvfevufffjgfkgggtsehttd
    ertddtredtnecuhfhrohhmpefuthgvfhgrnhcutfhovghstghhuceoshhhrhesuggvvhhk
    vghrnhgvlhdrihhoqeenucggtffrrghtthgvrhhnpeevlefggffhheduiedtheejveehtd
    fhtedvhfeludetvdegieekgeeggfdugeeutdenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:y-T8YyyBfFd1UYPVcs58R5oZntN7FC9w_nFhOJNbWFGSHC7eeoGH2Q>
    <xmx:y-T8YxRM5JQZgOwGCWdm4WC4MAOOdfpZqsDRQtiJG1-PKbeNy0oS0w>
    <xmx:y-T8Y9b45Hy7wMo_7qhdfFJ0tFJ6FxpEOZ45k3pKnaYZT2VcSqRQJg>
    <xmx:y-T8YyRwqUJxXuCnT2QRsGScW0m-BL7WYNNWb4rnwW750DIPQgPU1g>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Feb 2023 12:13:46 -0500 (EST)
References: <20230224044000.3084046-1-shr@devkernel.io>
 <20230225210854.25e93b1d94666aa13c269104@linux-foundation.org>
User-agent: mu4e 1.6.11; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, hannes@cmpxchg.org
Subject: Re: [PATCH v3 0/3] mm: process/cgroup ksm support
Date:   Mon, 27 Feb 2023 09:13:19 -0800
In-reply-to: <20230225210854.25e93b1d94666aa13c269104@linux-foundation.org>
Message-ID: <qvqwbklfm3p8.fsf@dev0134.prn3.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Andrew Morton <akpm@linux-foundation.org> writes:

> On Thu, 23 Feb 2023 20:39:57 -0800 Stefan Roesch <shr@devkernel.io> wrote:
>
>> So far KSM can only be enabled by calling madvise for memory regions. To
>> be able to use KSM for more workloads, KSM needs to have the ability to be
>> enabled / disabled at the process / cgroup level.
>
> I'll toss this in for integration and testing, but I'd like to see
> reviewer input before proceeding further.
>
> Please plan on adding suitable user-facing documentation?  Presumably a
> patch for the prctl manpage?

I'll work on a patch for the prctl manpage.
