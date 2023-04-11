Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8156DE7C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 01:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjDKXE0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 19:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjDKXEZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 19:04:25 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F7C199D;
        Tue, 11 Apr 2023 16:04:24 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C9F895C018A;
        Tue, 11 Apr 2023 19:04:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 11 Apr 2023 19:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681254260; x=1681340660; bh=gs
        bn2oyKgih4x2C06Ah8fFpl2xaJq27kMcEbABkhWFY=; b=l/tefIBwRsVvQpaogC
        J7B7EnYcAR08db2luxaD81KGRmZrorH9dEFLyi8DKxAgP02/4PbU+IQnY9jJ4joq
        v9uO/V7zHURvxFaXGm1m9fIyCKJioumsRoUOi1gRlih5QSCOmz1tH+RD47HQGQwu
        pTal7H4domS1joO+0DvM3DJp0qzbQBNA7fbhErypCIVPvF5AnZoBqc5OLTma03GN
        4802BP2nVEnRaDuRFh5jOyGOCnVXg+Vz/vv3KcWwQPNVsWePRzLegOuTbTmUFrL8
        WMfxgGVqxCL6375N9L1dynhkOJ6lGAx+AzM56kSqwZggHcTv5aUgqpKZIgejjemS
        Oxcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681254260; x=1681340660; bh=gsbn2oyKgih4x
        2C06Ah8fFpl2xaJq27kMcEbABkhWFY=; b=QbH0rvoGb1hFhDc0ra+rQxrOrh1rv
        KZKjFMrmtl8JEKBghEUqOVY+sSWD67vupdLAU5wi0VFcXZ2AkUrBe9R0d+pjGwyA
        U9+ZAdcat/iojatXAk7BONaf+N74Kv9H4CUvbHVcIv6YtDN6nbj3JAQJkDP4Kl3D
        M+VXL8p5Sd58+Leo1uxObdu3U1FZ43Z84bXnSvHKS/+SN1tumg3cEDMHO7g4vqVD
        lUR6pCUOMYArz46H9Ub9bE4hoX9D0NAE53aUH90lykKxyr7Z9HKdrstihEoxhRxR
        QuhCZTX9ZNv2Hq17KBFqdSwkhi3jD1PEVb0rBRUKA7E2p6LFalN6+xOEQ==
X-ME-Sender: <xms:c-c1ZH4Dmp78sWGgQRHeUsluruv8x2LdSkkl6uOnxthOTML_19rcXg>
    <xme:c-c1ZM7M1KoT94Jdhe_NWkk0yW9LQZ8AR4zpX9Lb19MWoSLhrng59xqBvG9nxYfUX
    yulAIJLf-lmVjWOQDg>
X-ME-Received: <xmr:c-c1ZOef5FXs-hqxFM7uhCCqXXX4RdWJjUf13dL83Ip3CyH6jxBnzgPArvluIkF0jB2U46pacq8DhMkOmLcbeVuKnMsByBat0Uc131jmXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekhedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpehffgfhvfevufffjgfkgggtsehttd
    ertddtredtnecuhfhrohhmpefuthgvfhgrnhcutfhovghstghhuceoshhhrhesuggvvhhk
    vghrnhgvlhdrihhoqeenucggtffrrghtthgvrhhnpeevlefggffhheduiedtheejveehtd
    fhtedvhfeludetvdegieekgeeggfdugeeutdenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:c-c1ZIIL2fmLJ4gKelJRRISmpZeTd__iIwspdhTScTFkw3AlNCklkA>
    <xmx:c-c1ZLJ23PUhuchjRcRijjU3Y7X6QdmCAy1bVh9m_-WyYqnUh_qb6A>
    <xmx:c-c1ZBwSgQrZ_XvcEYn3SCnYvg08ENa8qUvqoXqXXJW9YrHbLDfAlQ>
    <xmx:dOc1ZMUQMDYLyjk_kuZPprkNBEVRnogc3lNMJLp2MjsMP_wB2tUsTA>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Apr 2023 19:04:18 -0400 (EDT)
References: <20230406165339.1017597-1-shr@devkernel.io>
 <20230406165339.1017597-2-shr@devkernel.io>
 <ZDXgmx0xD8ch/Iu5@casper.infradead.org>
User-agent: mu4e 1.6.11; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v5 1/3] mm: add new api to enable ksm per process
Date:   Tue, 11 Apr 2023 16:03:57 -0700
In-reply-to: <ZDXgmx0xD8ch/Iu5@casper.infradead.org>
Message-ID: <qvqw4jpm58cv.fsf@dev0134.prn3.facebook.com>
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


Matthew Wilcox <willy@infradead.org> writes:

> On Thu, Apr 06, 2023 at 09:53:37AM -0700, Stefan Roesch wrote:
>> +	case PR_SET_MEMORY_MERGE:
>> +		if (mmap_write_lock_killable(me->mm))
>> +			return -EINTR;
>> +
>> +		if (arg2) {
>> +			int err = ksm_add_mm(me->mm);
>> +			if (err)
>> +				return err;
>
> You'll return to userspace with the mutex held, no?
>

Thanks for catching this, I'll fix it in the next version.
