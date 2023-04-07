Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51666DA82C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Apr 2023 06:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjDGELQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Apr 2023 00:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjDGELP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Apr 2023 00:11:15 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FF2658B;
        Thu,  6 Apr 2023 21:11:13 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A59405C039E;
        Fri,  7 Apr 2023 00:11:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 07 Apr 2023 00:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1680840672; x=1680927072; bh=E3
        JXUV5UUgPlKf5dpq97quPJmII3uTDXsdz2sFl5eaI=; b=bfiG8qa/vSe0uR3INz
        6onmEZ/D3PSpSmoUw1TiNuvi4HIewyrANpL3fGS8fGGWNQDJA202R0jw1bsOotId
        ME2wkoHQn+LHNcbnCmDozma3czMtI4ATCBafIa/zVXDdoHYLlyEi0Wgsy5s2ayjo
        JTT8Dam7ZdmC4EVgzlkgmmx4xFUzL1MKUQCX6tHK3WB68cgPliKGSeM/qSFtB4X+
        2fyCeWAiUuEiByYjBP/udswJwIg4lPQHb6+vYUk9yOarSnJneazdZ0nIyNKk4f+l
        3EOc87eqnVDWyn/7VMuaobsIsysxTNds/c7Cg3sXXaLJp644zuBx3+xJLmevs57S
        ORJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680840672; x=1680927072; bh=E3JXUV5UUgPlK
        f5dpq97quPJmII3uTDXsdz2sFl5eaI=; b=pV8cz3kW7TxJd9suysUA02sEzDpXd
        ULPmkh3DWcFL7dTvwDNcGO88T9/rwsnP+j56ykxoMVrDe3J1bQ7++YqvXKCX4FTF
        XxK01E6ITmddJelnCAfJANiU6SZZGzo8bMbJ48a3WcpK9dP20ULxB6thL0HQD5KD
        p2DFLsQClqIM44ECWl1iQf21q3NypvGGguFAj1ZEqw61BY3n/osMqxkXypUfQWdB
        MRBaUj0jBKbV50kKBY5NfC9wGCKb9ZnY7EATf8GOj3Kx8y2RTu6eRvCy2R7LpTt/
        yUruCdf45LRq6+DUsTAaS3qWYUffmIO8PeAXC7C7jO2VFi4LWLAt7e8Cg==
X-ME-Sender: <xms:35cvZM8FETD-oKZVDnWPh7dYuAi5gO17HF8sbM_6FQKA0l_a5HWoMQ>
    <xme:35cvZEuPQeebvbFvK00GXQpeFdWsYw09LqoGvAXEbRCj_5f5eYqDk9KkZ9qry1Ixc
    jMq1WpKCOT74OopIe8>
X-ME-Received: <xmr:35cvZCC9K3iBNSsA6TT5H0-3u2RML-YBFkKGwQIcCXA6fAgG2emNMQjnA81XbSbrqkmxnUQadBUiLW7vTO-Dn_MaVsK-8oCZIHLpFdFm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejgedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpehffgfhvfevufffjgfkgggtsehttd
    ertddtredtnecuhfhrohhmpefuthgvfhgrnhcutfhovghstghhuceoshhhrhesuggvvhhk
    vghrnhgvlhdrihhoqeenucggtffrrghtthgvrhhnpeevlefggffhheduiedtheejveehtd
    fhtedvhfeludetvdegieekgeeggfdugeeutdenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:4JcvZMey7dQGLDudmUT_8Qg6juN_y2z3PM0ipo0uGiRqQUcZDYXShA>
    <xmx:4JcvZBOti9UdE5dIcKbV748LntyLunaLMfnoCjLFe8aGfNrkQTgtlA>
    <xmx:4JcvZGlfYvK1zNeRgazrptbH9vooI7Ubqf3hK86dCMIkxKs_RdqILQ>
    <xmx:4JcvZKgtxMRPYgtoeaEmAKJJeSWLqoli1ft8ZTncdyhqK-mQlW2aXg>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Apr 2023 00:11:10 -0400 (EDT)
References: <20230406165339.1017597-1-shr@devkernel.io>
 <20230406165339.1017597-2-shr@devkernel.io>
 <20230406162957.57fa69a46691a97d4600f444@linux-foundation.org>
User-agent: mu4e 1.6.11; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, hannes@cmpxchg.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v5 1/3] mm: add new api to enable ksm per process
Date:   Thu, 06 Apr 2023 21:09:23 -0700
In-reply-to: <20230406162957.57fa69a46691a97d4600f444@linux-foundation.org>
Message-ID: <qvqw5ya8bacn.fsf@dev0134.prn3.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Andrew Morton <akpm@linux-foundation.org> writes:

> On Thu,  6 Apr 2023 09:53:37 -0700 Stefan Roesch <shr@devkernel.io> wrote:
>
>> So far KSM can only be enabled by calling madvise for memory regions.  To
>> be able to use KSM for more workloads, KSM needs to have the ability to be
>> enabled / disabled at the process / cgroup level.
>>
>> ...
>>
>> @@ -53,6 +62,18 @@ void folio_migrate_ksm(struct folio *newfolio, struct folio *folio);
>>
>>  #else  /* !CONFIG_KSM */
>>
>> +static inline int ksm_add_mm(struct mm_struct *mm)
>> +{
>> +}
>
> The compiler doesn't like the lack of a return value.
>
> I queued up a patch to simply delete the above function - seems that
> ksm_add_mm() has no callers if CONFIG_KSM=n.
>
> The same might be true of the ksm_add_vma()...ksm_exit() stubs also,
> Perhaps some kind soul could take a look at whether we can simply clean
> those out.

ksm_add_mm() and ksm_add_vmas() is not needed.
However ksm_add_vma() is required. It is called from mm/mmap.c
