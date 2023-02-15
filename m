Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A5469886F
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Feb 2023 00:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjBOXAk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 18:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBOXAj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 18:00:39 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF50955A9;
        Wed, 15 Feb 2023 15:00:37 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DBDA45C0179;
        Wed, 15 Feb 2023 18:00:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 15 Feb 2023 18:00:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1676502034; x=1676588434; bh=MrWeqROBy7
        8sov0ovwkYg7pAjNANSucFXmXbGwmSYkQ=; b=mgmKMDn4/TElWl/eOWdhxAuGrR
        BgGmw6BMGSW6v8BLSEw+nYeu3dWps3yIwPfkg6KNcvFHQBQBKkPELgWH3MnDoYl7
        LghpnTRdRLuzMVg4+TLA33cBOVKiLVGi8+przHq9FWg8tEzBSmTlrWKZkjc554ZK
        FrZaKjnAyXDhpdOqTBWYKLOksJZreurAAJoz91LK9TPOypPRseywLhEcq0+6vE/r
        b7zXyu0qzlrZjcP3Iy0NO/V85fHoR5YN4yXRkK6I24IzhGCxaPhTQeEa4/WrOsiN
        IMklQDbtO5zwKZ9b5I9hFOZw65CH1sYtuXSEBxYedNbDrfB+yU4MYMxqjtqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676502034; x=1676588434; bh=MrWeqROBy78sov0ovwkYg7pAjNAN
        SucFXmXbGwmSYkQ=; b=CHVUbv05PgEWr/kLEYBI1bK6yhdn+/uQSD2ZjDj14yNk
        T2kI0ClE/wWQbBXgMAj1idVQEz+r5E7abJDt9BYvg63wB3zwKBK88W03ZyT7VvyN
        6fJIKNNw4rQh6lZGO8MQLPTA9E+C6dQUniXgDLZvwQCDBQpN1DzmdCATqFfAe5Hf
        LZsldOJYyciu7qIvLF/dx0xf+8S0gNkJBPQ1T+hEhencimh7Z40Qs3bqvs7cEJwT
        gSe+hYCHNkvC1oCUYLXrUCT9qk/zdQ18XqOV3ZgQGj+V5sSQTGAUgMMiVMJjf/6p
        Q40qvZhsnb2nTfZiyDKLSiyHbWaIj05lWXuRs4B07A==
X-ME-Sender: <xms:EmTtYybW82PCizasVT-2WY5Oo6K9Agc54W4oeowBsyr-cpDRFsY8_Q>
    <xme:EmTtY1ZuNkjkY3jr-jGOvCg8-ahS1GL0QUwOBHWRSC4ZsGzR3S5tPh-QILppjYgC_
    1jVzWxqjlPbnC-dhBA>
X-ME-Received: <xmr:EmTtY8-W9uguZlB81QotrhckdJhS3xP_YpPYtI1pYaVOmUPozFY8C53PvQmWY9gKG-Zp5L58Pt0Uw59Lwt05r1fZk6ibvU4wuwFEZ6s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeiiedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpehffgfhvfevufffjgfkgggtsehttd
    ertddtredtnecuhfhrohhmpefuthgvfhgrnhcutfhovghstghhuceoshhhrhesuggvvhhk
    vghrnhgvlhdrihhoqeenucggtffrrghtthgvrhhnpeevlefggffhheduiedtheejveehtd
    fhtedvhfeludetvdegieekgeeggfdugeeutdenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:EmTtY0qcM4rkKPUikdxB4VLRnGCNrN00GvUCAZ8nrpO3SXtPbMj-LA>
    <xmx:EmTtY9rL37JoO-mSdj3SvLOIyFwgIGBtKzeTM2k4GXlxdATSv34mnA>
    <xmx:EmTtYyRETrQmUpi9P59Hlw-F9BCbuE9ndM8uwf0srzT03wj90CSQDQ>
    <xmx:EmTtYxI6EPRAq9B9aPINwLE20_23Fdoujhx3_6HojWAubhAwgLCcHg>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Feb 2023 18:00:33 -0500 (EST)
References: <20230210215023.2740545-1-shr@devkernel.io>
 <20230210215023.2740545-10-shr@devkernel.io>
 <e373069e-b68a-a924-d4be-742f7040a7e1@gmail.com>
User-agent: mu4e 1.6.11; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [RFC PATCH v2 09/19] docs: document general_profit sysfs knob
Date:   Wed, 15 Feb 2023 15:00:15 -0800
In-reply-to: <e373069e-b68a-a924-d4be-742f7040a7e1@gmail.com>
Message-ID: <qvqw8rgyfsab.fsf@dev0134.prn3.facebook.com>
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


Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 2/11/23 04:50, Stefan Roesch wrote:
>> Document general_progit knob.
>
> Book about Git :); it should have been general_profit.
>

Thanks, Fixed.

>> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-ksm b/Documentation/ABI/testing/sysfs-kernel-mm-ksm
>> index d244674a9480..7768e90f7a8f 100644
>> --- a/Documentation/ABI/testing/sysfs-kernel-mm-ksm
>> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-ksm
>> @@ -51,3 +51,11 @@ Description:	Control merging pages across different NUMA nodes.
>>
>>  		When it is set to 0 only pages from the same node are merged,
>>  		otherwise pages from all nodes can be merged together (default).
>> +
>> +What:		/sys/kernel/mm/ksm/general_profit
>> +Date:		January 2023
>> +KernelVersion:  6.1
>> +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
>> +Description:	Measure how effective KSM is.
>> +		general_profit: how effective is KSM. The formula for the
>> +		calculation is in Documentation/admin-guide/mm/ksm.rst.
>> diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
>> index f160f9487a90..5c4daf44d79d 100644
>> --- a/Documentation/admin-guide/mm/ksm.rst
>> +++ b/Documentation/admin-guide/mm/ksm.rst
>> @@ -159,6 +159,8 @@ stable_node_chains_prune_millisecs
>>
>>  The effectiveness of KSM and MADV_MERGEABLE is shown in ``/sys/kernel/mm/ksm/``:
>>
>> +general_profit
>> +        how effective is KSM. The calculation is explained below.
>>  pages_shared
>>          how many shared pages are being used
>>  pages_sharing
>
> LGTM, thanks!
>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
