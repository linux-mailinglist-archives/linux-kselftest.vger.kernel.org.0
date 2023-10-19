Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410FA7D0265
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Oct 2023 21:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346334AbjJSTX7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Oct 2023 15:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbjJSTX6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Oct 2023 15:23:58 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F781112
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Oct 2023 12:23:56 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so73816276.0
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Oct 2023 12:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697743435; x=1698348235; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5uuyl1yr0QlhVwcr/kFqbwwoVuwQhjrCV37xzZewFRc=;
        b=UrEZKkZWWXlJ75gCppsV/r9DeolapG0AgzSDhmxjoYciCdTf+VyOZkBzooMRli6RTr
         pTVaA3iKJ/6tD+KUG6QV2dUR9lPmMFHpqANh0QPUM/AVbw/w2wJX4th+eQXidEy9mx5D
         AbQhpMneY4L4rKtE42muq/ZTlF7DnNKSCgh3Za6z5FDTmzi7XadPl7hF7TOq/eFlYby7
         ptXHEtnY8g1/n62Bnb1lqt8dz1hgE+OCcPOurxFq6Dl2J+xL7r/HX9QWvOTw/zBWdZyg
         vbng9AgE9l6HHzr2HUcclMfRfzk37Ue9WpFdktIARaQu/ctZKALI6I+b68n5/+znKVym
         dV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697743435; x=1698348235;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5uuyl1yr0QlhVwcr/kFqbwwoVuwQhjrCV37xzZewFRc=;
        b=Auqrv7ww5upHhosont8TTOMb5X/8TL3B/0KEVJPCnMZRopZQ6WTPmAOVhmMs4mLT1A
         zEiAMRKOcERxRozDZAKi3ipIHQ6x0XHfVotdcbMIqb2TdA1GNlS7/gKxHtBObOo0Cw/J
         1qHaWs8zFrf2zek/StLwNvTf0wafcTM84CBUY7YbUUUUmBKj69nHSxL9IX4KsRdGsxDN
         HToCCGCtWofghNz22JcrB1UsddpmcdukLG0Af6dPwRsEYHEgkNGT0OKntthb+3bdg8hb
         7nEe7SfgFWMFOGw8NvaM4FFkFWURA2ivFdBwSixYQWt8csubLuehwz9oI6KWMDWudUHV
         w4cg==
X-Gm-Message-State: AOJu0YxndezczKbTYJ+cLrjno4nl7vnqjLej4fPLSTOQlYKIjM2FwwIa
        tXT77jQhf0iLiZFTgomjp0zZsQ==
X-Google-Smtp-Source: AGHT+IF5RSaxdFZ8Qw7h9TmLML1tBIzoDCSUVaslk5eNl4uxiHalrl0qJkYPCIrJgQLx5qXnJXrtUw==
X-Received: by 2002:a5b:291:0:b0:d9a:c5ac:9a60 with SMTP id x17-20020a5b0291000000b00d9ac5ac9a60mr3055680ybl.1.1697743435190;
        Thu, 19 Oct 2023 12:23:55 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v9-20020a258489000000b00bcd91bb300esm20035ybk.54.2023.10.19.12.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 12:23:54 -0700 (PDT)
Date:   Thu, 19 Oct 2023 12:23:44 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
        hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v3 0/5] workload-specific and memory pressure-driven
 zswap writeback
In-Reply-To: <20231019113627.bca226b1ac17fe9c3beecb21@linux-foundation.org>
Message-ID: <78f9b0da-d69b-d709-946e-f10fec180233@google.com>
References: <20231017232152.2605440-1-nphamcs@gmail.com> <20231019101204.179a9a1d2c7a05b604dad182@linux-foundation.org> <CAJD7tkYZ826ysjnoSbYnTH3h7eWKOE=ObHNCADb78c4x7NBHzg@mail.gmail.com> <CAKEwX=PyoBfaGqH9sb07ZgjLnsGmssCDvWQo34T7brrqfZJAvg@mail.gmail.com>
 <20231019113627.bca226b1ac17fe9c3beecb21@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 19 Oct 2023, Andrew Morton wrote:
> On Thu, 19 Oct 2023 11:31:17 -0700 Nhat Pham <nphamcs@gmail.com> wrote:
> 
> > > There are parts of the code that I would feel more comfortable if
> > > someone took a look at (which I mentioned in individual patches). So
> > > unless this happens in the next few days I wouldn't say so.
> > >
> > 
> > I'm not super familiar with the other series. How big is the dependency?
> > Looks like it's just a small part in the swapcache code right?
> > 
> > If this is the case, I feel like the best course of action is to rebase
> > the mempolicy patch series on top of mm-unstable, and resolve
> > this merge conflict.
> 
> OK, thanks.
> 
> Hugh, do you have time to look at rebasing on the mm-stable which I
> pushed out 15 minutes ago?

Okay, I'm on it - but (unless you insist otherwise) it's only a v3 of
the 10/12 "mempolicy: alloc_pages_mpol() for NUMA policy without vma"
that I'm expecting to send you - the rest should just cherry-pick in
cleanly.  I'll check that of course, but I'm afraid of losing details
(e.g. any Acks you've meanwhile added) if I resend the lot.

Hugh

> 
> > I will then send out v4 of the zswap shrinker,
> > rebased on top of the mempolicy patch series.
> > 
> > If this is not the case, one thing we can do is:
> > 
> > a) Fix bugs (there's one kernel test robot it seems)
> > b) Fix user-visible details (writeback counter for e.g)
> > 
> > and just merge the series for now. FWIW, this is an optional
> > feature and disabled by default. So performance optimization
> > and aesthetics change (list_lru_add() renaming etc.) can wait.
> > 
> > We can push out v4 by the end of today and early tomorrow
> > if all goes well. Then everyone can review and comment on it.
