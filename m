Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844D8569233
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Jul 2022 20:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiGFSxh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jul 2022 14:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiGFSxf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jul 2022 14:53:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED94128E1B
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Jul 2022 11:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657133612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vpKqPCC+dq82KAEepp5QL1jPT12BGJMMiKq0ETkXQgI=;
        b=dc4sCP1eyDEvpMujijc99qA66W6ssHDvhPdYu2UxT/3OraBKl3SxnHvOyMu+KogmPLPh6F
        EbXOa/ZsAipGHC5D+AlQcQW+Fg0bUzQ8BV9+BpLjGeiN/yPqsSneOqiDyYK+H00g+gdHbA
        bt29fMEwzvkB9rQVxe9e6hFXDKIsPPQ=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-guxyVu_rPs-XBccH6jPoSw-1; Wed, 06 Jul 2022 14:53:30 -0400
X-MC-Unique: guxyVu_rPs-XBccH6jPoSw-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-31cd7ade3d6so31872247b3.3
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Jul 2022 11:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vpKqPCC+dq82KAEepp5QL1jPT12BGJMMiKq0ETkXQgI=;
        b=K0Pz+uIkHIyeBPnacKVFHoxh8bk5Cein6LpvORLO46+CbsDfs4edOdRB3CaySlXExh
         EGCP0w5l8mjrRyvALYRQvgdZFwKkV2bQTsesSTqfcXI1Pg/+MfI1P05Nk50Uw/BGTKDn
         ZlFXEj23cd9APfHq+L8oZ+2hc4E0LwzLb8Zisi/rVtstsp9qgNnn4eMgnlbVaDG1ibzP
         oQWJXV0E8KPkCUEgKRJfO8S4wOi+CTqs7hJvG6PG0ojMK74dqcq43KrarokBLKs5HN6y
         gtOWQ9qK8YLCLVPV7xud10pMEl1EIrMuvx87pVPrQIufPbXQUeUZ8kd00OynWO/QHvry
         zZaQ==
X-Gm-Message-State: AJIora8IWU3m4Z0kUGTGgryjk5ws3ZBqyESQ3NT8aPrfBAnssbFJG+ur
        s8G9SRTXuZiGuFrDZiUUFIHwdH/LLKewXcBED9FL8nBscsjoRzSn54pItmXSitbW3Nz0ogOT6h0
        9ERAJKtGGtjVHAo9CRquztw7lTsdcKcmt68wfNU0aWPAD
X-Received: by 2002:a81:315:0:b0:317:6789:a0c1 with SMTP id 21-20020a810315000000b003176789a0c1mr50398784ywd.378.1657133610008;
        Wed, 06 Jul 2022 11:53:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ukESutasOwQQv+z1C+dhV56B10wsDX/hCRqFQDRXmQvGdZRZ/ZCWAmPTwBAQNixjzF7EcmG5m3Mb5/SjaYnJQ=
X-Received: by 2002:a81:315:0:b0:317:6789:a0c1 with SMTP id
 21-20020a810315000000b003176789a0c1mr50398765ywd.378.1657133609825; Wed, 06
 Jul 2022 11:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220705185605.3889110-1-jsavitz@redhat.com> <20220705133456.d5572b2e36ebb36188369988@linux-foundation.org>
 <CAA1CXcAFyMLBEi87A0+pBbUKtzfEeE-5uyqPugmHLmzgH8=w8w@mail.gmail.com> <20220706115031.3c312d9268bf87287be0b8f9@linux-foundation.org>
In-Reply-To: <20220706115031.3c312d9268bf87287be0b8f9@linux-foundation.org>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Wed, 6 Jul 2022 14:53:14 -0400
Message-ID: <CAL1p7m5hSJ87PvQTED0BdP1i43HbnqE1Q1XTqWb9aTrXS2jXmA@mail.gmail.com>
Subject: Re: [PATCH] selftests/vm: enable running select groups of tests
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nico Pache <npache@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thanks for the feedback.

Will rework and send v2.

Best,
Joel Savitz

On Wed, Jul 6, 2022 at 2:50 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 6 Jul 2022 14:38:03 -0400 Nico Pache <npache@redhat.com> wrote:
>
> > On Tue, Jul 5, 2022 at 4:35 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Tue,  5 Jul 2022 14:56:05 -0400 Joel Savitz <jsavitz@redhat.com> wrote:
> > >
> > > > Add the ability to run one or more groups of vm tests (specified
> > > > by the environment variable TEST_ITEMS). Preserve existing default
> > > > behavior of running all tests when TEST_ITEMS is empty or "default".
> > >
> > Hi Andrew,
> >
> > > What is the reason for this?  What's the use case?
> >
> > The current design of vm selftests is all-or-none. We'd like to be
> > able to selectively run these tests (We settled for selective groups
> > of tests rather than individual tests).
> >
> > The main reason for doing this is our efforts to expand RedHats MM CI
> > testing. There are two use cases for these changes that relate to our
> > reasoning:
> > 1) Our current CI has overlapping tests between LTP and vm selftests,
> > so we'd like a way to prevent running the same test in two places.
> > 2) We'd like the ability to skip a test if it is determined to be
> > unstable or requires certain hardware requirements.
> >
> > By adding this functionality we are really expanding what we are able
> > to do with the stock vm-selftests.
>
> OK, please let's get this info into the changelog - it's the most
> important part.
>
> > > And why via the environment rather than via commandline args?
> > Just a design choice I suppose. I'm sure Joel would be willing to
> > implement it as a cmdline arg if you'd prefer that approach.
>
> I think that would be best.
>

