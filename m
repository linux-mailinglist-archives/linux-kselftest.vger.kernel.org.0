Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12128706B9B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 16:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjEQOv7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 10:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjEQOv6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 10:51:58 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF912D7E;
        Wed, 17 May 2023 07:51:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 10A63320030E;
        Wed, 17 May 2023 10:51:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 17 May 2023 10:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684335110; x=1684421510; bh=U9
        81mgJN5ZcIFGHHfNRtTYm9tIIshD/j5t+czAqBesk=; b=Ca9f/D4SJr14QvZGkc
        +q7KTRGXT7JBFRrs75d+HJ2OHOSFueAY0un/ZGcKbVEoscZFW6SjqbiPXereZTY1
        4lcT5rbc2J//JZIJSnLiqFoKjl+7sEm3mRPxHdA8kVhx6i+8Gv6Gs3tgeghB9AVx
        tiFExJee1gfnnXfCGEqrMCOAyztqrVmVbbh4Vx8kBzBcchhCWGq9jE4AWpdrn/zc
        KlbDH9cn2VZKKpo3BlHq2vmDVsjsuLASyEKUhF08I7lpQUUHqQi2ze3FpKl0U9IV
        yp0n5gg/GsUfq8IoMt1JUB+wlGdGrbDiz4LfVQ/hM2UiQ/AKZgZzMrsWIQF+mwUG
        o5Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684335110; x=1684421510; bh=U981mgJN5ZcIF
        GHHfNRtTYm9tIIshD/j5t+czAqBesk=; b=EMWrwTfyiN4WwFm97r9VWWS6w2uAq
        LgvmOB2bNzX3Nj1iJRBecCwthhPNqACErPlWa7ntFlYoaEwBhGN78KcLN3yBTNyu
        Aqk3H67Dg6iVzIE2eoyn3hmWBvqBblRgzb3TZygGJHtSCh3YrmYDvNM1AlrxXI+/
        YZMWcHS8mskGNb1OcG10Hh5tBRVj/WtG2lS25NQwWzGjSsjt1yoy6lceEwD7hdEp
        ICxlryjGqFpBvOblk/or/mLmEinMRAIO7vCr/4QUi2/F6B8hv2rXwNtgp21zzcmi
        W3WRrfgi52k7r9ApnTs4X2/2idzkX3KZD72Lp+8DQ9oBBrfMF6Te9k6Qg==
X-ME-Sender: <xms:BOpkZAX-ah2gC9qXHRhxL9Jdqt9kqu-VKcGSuWg1GW_5ZN0t_KBOcg>
    <xme:BOpkZEnCWHECQenDSE928iVzgjeKtfqwlYib_ujabtOEKkQ-iVrevetsmAAqV2PXz
    oO1vUF8ZrqpGe5ciQc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:BOpkZEanBGI8-zi50JEHLFiN5OCN7u3f1N-fS6wbkXOhNFZcQlB9RQ>
    <xmx:BOpkZPWIrxfeze0hM1uxKpTiRjSQF0E2dM8RjNSgq_9LgDgcz5l8Gg>
    <xmx:BOpkZKky6b4GKmAWHHstx-M_Q2MTJ0Mg84yM6a-OyBPfxMEqp1e5aA>
    <xmx:BupkZNFPTGYv1tkCdtIpLzc7PK5bJcAAEF0LFfyPqwuQNavihPAm3g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9F93DB60086; Wed, 17 May 2023 10:51:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <83422cf8-5d77-4e2f-a854-c2b9a9a94d75@app.fastmail.com>
In-Reply-To: <e1a07eed22cb33af2733bdffe42b09f0.paul@paul-moore.com>
References: <20230517131102.934196-5-arnd@kernel.org>
 <e1a07eed22cb33af2733bdffe42b09f0.paul@paul-moore.com>
Date:   Wed, 17 May 2023 16:51:28 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Paul Moore" <paul@paul-moore.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, "Russell King" <linux@armlinux.org.uk>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, "Michal Simek" <monstr@monstr.eu>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Helge Deller" <deller@gmx.de>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, x86@kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Eric Paris" <eparis@redhat.com>,
        "Dennis Zhou" <dennis@kernel.org>, "Tejun Heo" <tj@kernel.org>,
        "Christoph Lameter" <cl@linux.com>, "Pavel Machek" <pavel@ucw.cz>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Waiman Long" <longman@redhat.com>,
        "Boqun Feng" <boqun.feng@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        audit@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 4/14] audit: avoid missing-prototype warnings
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 17, 2023, at 16:33, Paul Moore wrote:
> On May 17, 2023 Arnd Bergmann <arnd@kernel.org> wrote:

> We probably should move the audit_serial() and auditsc_get_stamp()
> away from the watch/mark/tree functions, but that isn't your problem.
>
> Anyway, this looks okay to me; do you have a problem if I merge this
> via the audit/next branch or were you hoping to have this go in
> through a different tree?

Merging it through your tree is probably best, Andrew can either
pick the ones that nobody else took, or I can resend the rest.


    Arnd
