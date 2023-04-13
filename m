Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA4D6E1256
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 18:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjDMQda (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 12:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDMQd3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 12:33:29 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C973AAD;
        Thu, 13 Apr 2023 09:33:28 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 261CA5C00D1;
        Thu, 13 Apr 2023 12:33:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 13 Apr 2023 12:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1681403607; x=1681490007; bh=E7
        v8GvR/BA8ZybVtwk1BgUR7UNaro8OfYXIZQ2El7BY=; b=ViQZJZIU22yTNfIXLP
        xff30J2t4m8/W4Cxx+Uv32Zj6vz41yqCPEbVWpXv1gvmj1lPhh5ikKTe0F5NBrPX
        07Kw9by1MdmhjEixCyCg3c4a7j38kyNG5wJoWTdEDoVOZHleD2CNnE+kh5b9E6ze
        vuSTwIBiV2diADtLTlPRyWmIGYie5u/WuM8/vDpMBWxZAm0X463lzuklBNMOsZc2
        p6L/39L43RxMkGdkVZsI8dO2ADwLBOpf69aUjIBdiiT/ecOGEok5hSoGetFQmH9G
        vABt4czEa++k/9PZ0P0G8ywTStOJqWaLgq2ZRVARy9GgZwmjap01zXFth/kwj2Z4
        Fi/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681403607; x=1681490007; bh=E7v8GvR/BA8Zy
        bVtwk1BgUR7UNaro8OfYXIZQ2El7BY=; b=GO3ith22DKwoVSWx9DMWTK5XCro1D
        EZlVCZ5TANUiZreKwDmm8WsGdVvrv98eXVLItMdzSK8R/4+bn+1krYW8uY5lg66U
        Qb/tMzIh/0T/z+cO/rQMHBQ7HSjXV47XpFWtSN2YfSBeYiQtIk+qoCtGWuHiDGJQ
        va9xYVjR8OaYOtYiE0eRxe+CgoWkG26AOdWemJ88sHoxztzkhw+u0NQgx4P7P+yR
        0eDV2YWP+P0+b83JKsdcbEfdGX7UZZ+xQ8XGXstsoMOoezsFeClj/QNOPO8H/9kg
        7Rrh5DSSRYHDa0OFGr6SVf0/YjOZjQJTPUxrgmjifORYZmds16ZfWrdYQ==
X-ME-Sender: <xms:1i44ZLLwPpC7pfQnl9snOxcBI0uWqRURu5vbloAl0qFwOb3u7P1fmA>
    <xme:1i44ZPKDGn8ScwgZauMFTHFojElFJuaE7sYyNU9d0f-KkuJJcX4R6eKCitzjg5px2
    vn5YypNOuK05AwnP5w>
X-ME-Received: <xmr:1i44ZDvyTWf2CtQnEdUC7WC7R8LVKTAos5WRYQHGIIMZTi5uc5FrAcmKLfvD1xO37UsURJQvBGAUzId6SGIJSac44U_BN-w-J50QwNaNIKI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekkedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpedttdevfffgudeujefffeeutdekvddtffefleellefgfefgleejteeffedu
    geduteenucffohhmrghinhepthgvshhtshdrthhoohhlshenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehshhhrseguvghvkhgvrhhnvghlrdhi
    oh
X-ME-Proxy: <xmx:1i44ZEaRGMFDbi6mcrtyICuUrVCweEurHu0RxZT82UL4G3Zt4fdx5A>
    <xmx:1i44ZCaDxibspyokOSr1sxgvMDarZAq6ul_x4kiz7_zUtULY6lPbqQ>
    <xmx:1i44ZICXSDiex0DDslZ88ERmPrXokxI5RdNs9dIlAPOzqut9xWVoMg>
    <xmx:1y44ZImPLGl_eRuWkJVVDZB1pG6E7LNBuH4f1aUoo_CG5ZHj4ET3jg>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Apr 2023 12:33:25 -0400 (EDT)
References: <20230412031648.2206875-1-shr@devkernel.io>
 <20230412031648.2206875-4-shr@devkernel.io>
 <7c5606cc-ca58-c505-b0d3-2eec29fe606a@redhat.com>
 <190bed16-7b7b-a880-9793-cdeb1baef29d@redhat.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, willy@infradead.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v6 3/3] selftests/mm: add new selftests for KSM
Date:   Thu, 13 Apr 2023 09:32:21 -0700
In-reply-to: <190bed16-7b7b-a880-9793-cdeb1baef29d@redhat.com>
Message-ID: <qvqwfs93yc6m.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> On 13.04.23 15:07, David Hildenbrand wrote:
>> On 12.04.23 05:16, Stefan Roesch wrote:
>>> This adds three new tests to the selftests for KSM.  These tests use the
>>> new prctl API's to enable and disable KSM.
>>>
>>> 1) add new prctl flags to prctl header file in tools dir
>>>
>>>      This adds the new prctl flags to the include file prct.h in the
>>>      tools directory.  This makes sure they are available for testing.
>>>
>>> 2) add KSM prctl merge test
>>>
>>>      This adds the -t option to the ksm_tests program.  The -t flag
>>>      allows to specify if it should use madvise or prctl ksm merging.
>>>
>>> 3) add KSM get merge type test
>>>
>>>      This adds the -G flag to the ksm_tests program to query the KSM
>>>      status with prctl after KSM has been enabled with prctl.
>>>
>>> 4) add KSM fork test
>>>
>>>      Add fork test to verify that the MMF_VM_MERGE_ANY flag is inherited
>>>      by the child process.
>>>
>>> 5) add two functions for debugging merge outcome
>>>
>>>      This adds two functions to report the metrics in /proc/self/ksm_stat
>>>      and /sys/kernel/debug/mm/ksm.
>>>
>>> The debugging can be enabled with the following command line:
>>> make -C tools/testing/selftests TARGETS="mm" --keep-going \
>>>           EXTRA_CFLAGS=-DDEBUG=1
>> Would it make sense to instead have a "-D" (if still unused) runtime
>> options to print this data? Dead code that's not compiled is a bit
>> unfortunate as it can easily bit-rot.
>> This patch essentially does two things
>> 1) Add the option to run all tests/benchmarks with the PRCTL instead of
>> MADVISE
>> 2) Add some functional KSM tests for the new PRCTL (fork, enabling
>> works, disabling works).
>> The latter should rather go into ksm_functional_tests().
>
>
> "tools/testing/selftests/mm/ksm_functional_tests.c" is what I wanted to say.

I understood. I'll look into moving the fork check and the disabling
into the functional tests for the next version.
