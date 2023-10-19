Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BF77D01C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Oct 2023 20:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346509AbjJSSge (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Oct 2023 14:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346493AbjJSSgb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Oct 2023 14:36:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35CA189;
        Thu, 19 Oct 2023 11:36:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1524C433C8;
        Thu, 19 Oct 2023 18:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1697740589;
        bh=N5tbmRas55JfDzqhMXJ+i0cestblFrOR68Qefmyv6Js=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LGlDCYd4Nntn7LhHdPQuYjW/eGfDfTuVBVSCrJlDqDeOF/YO+GnAdgUvf9jSv4You
         NMKgzBNirl/kQp/oEaeVXfXQ6Bq5IblCnq7A1ftavZtS/XiG/8RgNOXGbgzjBiHkVt
         ve0G4xUTvQ7Q1kV3o3fhddvZ3BoAXxcf2XNu3hfM=
Date:   Thu, 19 Oct 2023 11:36:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v3 0/5] workload-specific and memory pressure-driven
 zswap writeback
Message-Id: <20231019113627.bca226b1ac17fe9c3beecb21@linux-foundation.org>
In-Reply-To: <CAKEwX=PyoBfaGqH9sb07ZgjLnsGmssCDvWQo34T7brrqfZJAvg@mail.gmail.com>
References: <20231017232152.2605440-1-nphamcs@gmail.com>
        <20231019101204.179a9a1d2c7a05b604dad182@linux-foundation.org>
        <CAJD7tkYZ826ysjnoSbYnTH3h7eWKOE=ObHNCADb78c4x7NBHzg@mail.gmail.com>
        <CAKEwX=PyoBfaGqH9sb07ZgjLnsGmssCDvWQo34T7brrqfZJAvg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 19 Oct 2023 11:31:17 -0700 Nhat Pham <nphamcs@gmail.com> wrote:

> > There are parts of the code that I would feel more comfortable if
> > someone took a look at (which I mentioned in individual patches). So
> > unless this happens in the next few days I wouldn't say so.
> >
> 
> I'm not super familiar with the other series. How big is the dependency?
> Looks like it's just a small part in the swapcache code right?
> 
> If this is the case, I feel like the best course of action is to rebase
> the mempolicy patch series on top of mm-unstable, and resolve
> this merge conflict.

OK, thanks.

Hugh, do you have time to look at rebasing on the mm-stable which I
pushed out 15 minutes ago?

> I will then send out v4 of the zswap shrinker,
> rebased on top of the mempolicy patch series.
> 
> If this is not the case, one thing we can do is:
> 
> a) Fix bugs (there's one kernel test robot it seems)
> b) Fix user-visible details (writeback counter for e.g)
> 
> and just merge the series for now. FWIW, this is an optional
> feature and disabled by default. So performance optimization
> and aesthetics change (list_lru_add() renaming etc.) can wait.
> 
> We can push out v4 by the end of today and early tomorrow
> if all goes well. Then everyone can review and comment on it.
> 
