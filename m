Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532765FB772
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Oct 2022 17:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiJKPjN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Oct 2022 11:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiJKPir (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Oct 2022 11:38:47 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C84ABE53E;
        Tue, 11 Oct 2022 08:28:10 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 0E0A62B06723;
        Tue, 11 Oct 2022 11:28:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 11 Oct 2022 11:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1665502081; x=1665509281; bh=Ro
        iYjXc5zpBqmqtGTly0dJ5h4knOXCOxvOzprpvvicY=; b=rOqBqfQIR1pyIo2y+Q
        qXCNvR9q1gL4jfix8sxrOkGqGqROiSHyOvWNHIqbLpM5CyKJiTrw9hPly16jMeox
        rCt2x8gcTitVSTlm5hdVJPA2xCT16jAt6cCxOG1KMbwGUcaPcXyFcIU55t18+ek7
        B1riDrIGEzMQqyoNSDOBbpluYItZUW2OpkHp/uLMQKiWM/67u3uiyYw1v4Q7wBg4
        b/69CmAXTR92H1cdjbIYsz9oC6jcyU/+pAgKTaM8hCy+lCsdJ7PY6GoXKMAlC5ES
        ih3OxqqrlFdorAUJMS3+NnphnyXRXwbvsEob/47+qMbONRy9d9cnSLCEtDc3FSlX
        aHvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665502081; x=1665509281; bh=RoiYjXc5zpBqmqtGTly0dJ5h4knO
        XCOxvOzprpvvicY=; b=D7xRYdn00TuXovu4EGPnJfmJV5jcNV/fRMwo9uBTiOHI
        QI/UGUeuHztUjAPISjmnhM60ZbLAVNuFKUhn62xhJeC8AMyO5u5TrjbezEp/ko+2
        Ol2JmAM6dx+n7A3NmNFNzBacE2rMuu7bz+dkGdv5m17HRkHvMkkiuzwlLU3hvKun
        GJwdAKaUXGmigGQPFV8trjtO9IvcNZCQoSaUzm8CHNh/xuHOPSG5ZfbylR42i/Fu
        yamnMsEUW69QlLy7RRw4JnpPlqaGsns3xIidA0z8aUmuvBhS6lozmNnx+VHDKdJe
        iCnhsALrTfAAMfNLGfwzhflmmWhjqN+oqP6Pg2hOgw==
X-ME-Sender: <xms:gItFY844esImGjIls8A7mGNDl_oNFq1crS_T2ia2jAc3FSrcqP1KKQ>
    <xme:gItFY95f8eZP32qu-fw8KEOCIgIKHKfxISBLaxm9g38nYuTxQdtvAE0eCBb8zeCpt
    E7eBOi7mwqlIiA6mU4>
X-ME-Received: <xmr:gItFY7ed7wyvlAV2A-qDjX1iYhXcpMUURxJGGzw8qzTWxCGEFskPlTwzoehVDQ3C2n4qsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejiedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:gItFYxL9TyWUGkkUexRQWqG1dijpGV-qMLjJrOBBuHOdg2NdM4gYXw>
    <xmx:gItFYwKxSOUvJ8x6SawB36EvvRAhb75XA5vK1ynWsVeErq_Hfn5paA>
    <xmx:gItFYyzGuVmV1GLHrEX0MjRoJUIV5ZQ5DJobusi2zP01mKNzpNFL5w>
    <xmx:gYtFY9aWaSwdGibhXLTomCMmmDNUB1d2kM6K6JcClz5fPD5I2JG1-T3cyVI>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Oct 2022 11:28:00 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E4CEC103938; Tue, 11 Oct 2022 18:27:56 +0300 (+03)
Date:   Tue, 11 Oct 2022 18:27:56 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org
Subject: Re: [PATCH v9 2/9] mm/mmzone: Tag pg_data_t with crypto capabilities
Message-ID: <20221011152756.swms64so5q6s4f3j@box.shutemov.name>
References: <20220704135833.1496303-1-martin.fernandez@eclypsium.com>
 <20220704135833.1496303-3-martin.fernandez@eclypsium.com>
 <20221007155323.ue4cdthkilfy4lbd@box.shutemov.name>
 <CAKgze5bRKph0SPOerLDLZb5KckPX5+q0y649XCU4J5HehYVu0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgze5bRKph0SPOerLDLZb5KckPX5+q0y649XCU4J5HehYVu0A@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 11, 2022 at 10:28:44AM -0300, Martin Fernandez wrote:
> On 10/7/22, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > On Mon, Jul 04, 2022 at 10:58:26AM -0300, Martin Fernandez wrote:
> >> Add a new member in the pg_data_t struct to tell whether the node
> >> corresponding to that pg_data_t is able to do hardware memory
> >> encryption.
> >>
> >> This will be read from sysfs.
> >>
> >> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
> >> ---
> >>  include/linux/mmzone.h | 3 +++
> >>  mm/page_alloc.c        | 1 +
> >>  2 files changed, 4 insertions(+)
> >>
> >> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> >> index aab70355d64f..6fd4785f1d05 100644
> >> --- a/include/linux/mmzone.h
> >> +++ b/include/linux/mmzone.h
> >> @@ -883,6 +883,9 @@ typedef struct pglist_data {
> >>  	struct task_struct *kcompactd;
> >>  	bool proactive_compact_trigger;
> >>  #endif
> >> +
> >> +	bool crypto_capable;
> >> +
> >
> > There's already pgdat->flags. Any reason we cannot encode it there?
> 
> Not really a reason, I'll considerate when I send then next version. I
> tried to quickly find for references of what kind of flags does it
> have, I didn't find any. Do you suggest it should work?

Maybe. Or maybe introduce capabilities bitfield and make crypto as one of
them.

We consider to re-use the approach for other cases. Like if the memory in
the node is TDX-compatible (there's more requirements for it than just
encryption).

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
