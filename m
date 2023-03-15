Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5456BBEE2
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 22:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjCOVUG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 17:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbjCOVT5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 17:19:57 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71F7A591B
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 14:19:29 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id h19so1646583qtn.1
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 14:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1678915168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NwsJ4+G5J9g17XC5Oega2fzdoX3R4HN5m00Gv1AGrio=;
        b=J4hENgr34NSGF6vyf2nmvDcQD6/muv0hdsHy09NIXn8lT7gniI+nN3rrtoNFk2ZMYA
         8mmGoYBT75II1U4TG76NhTKQsb3gLBT3EbgmxXUGlLgMEhbQ67fPeCid7JCLAx3Zz7+7
         omxNSH9aY6vY8KsFROJMmgxX+C+9yhSUFhpqknE2oyhNlQbkxezDB7Z92jO2lMaASCN/
         lDHVA2APnVRLBvUKkcqHvurw7dD7ZMiJfaPF+ubWv3hC26Seao9b8uMeNX3tBAUVfq0K
         tgr3+qb8BmYcHsrz1fw4ll4Fa4vur9uUTcdR0x58449+V5TSWSCUsMKioHvbW/SBQsYV
         pS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678915168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwsJ4+G5J9g17XC5Oega2fzdoX3R4HN5m00Gv1AGrio=;
        b=Ms0saxrzTZmjlf+/MrzKIXkHa1ahiE+S8OLChfxSNvBcjUjIK+fTpNwkkAKWTjnari
         C/1puXJU8Qo94mrHYOiTjNyN2m2VtXuqZThE3GtvxIRsYiXGj81BlY1nI93Y9gliev78
         us5caf00OYLnWriowt1NnnBewgBLV+c9t34sWAogp0Ni/kEh0xajAX9Ci0mRSq1qp4Ok
         OLksJos7vaHOKeaeRGGDAnkEpkZPaFotEozTHQ47WQ2wgqwwATB+QR5RKa7uDWPnKMN0
         YVcv8Zf1eN9MV/7DJLFuldXRIqkO2RdcbJzVSqL241XPr+0EiNib90XZoSNco+ZEqP69
         MQVA==
X-Gm-Message-State: AO0yUKW/PLMmayhks4y7YBK72SoD1DGDH2a8SLe8TwHrQrgvlRvEypZS
        XRKe3EOIbAG9uL2raQmsn//oVr5w7RI3aLHxtvw=
X-Google-Smtp-Source: AK7set++jBmiiVxJ+t5MUOdawKP8WhjMZoYTetmJpxQaUcMEPqlctXi+QbRMbsaCZFI2F1xv+M2Vtw==
X-Received: by 2002:ac8:5a0a:0:b0:3bb:7603:d68e with SMTP id n10-20020ac85a0a000000b003bb7603d68emr2513487qta.10.1678915168453;
        Wed, 15 Mar 2023 14:19:28 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:62db])
        by smtp.gmail.com with ESMTPSA id 64-20020a370343000000b00729a26e836esm4488474qkd.84.2023.03.15.14.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 14:19:28 -0700 (PDT)
Date:   Wed, 15 Mar 2023 17:19:27 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com,
        linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v4 0/3] mm: process/cgroup ksm support
Message-ID: <20230315211927.GB116016@cmpxchg.org>
References: <20230310182851.2579138-1-shr@devkernel.io>
 <273a2f82-928f-5ad1-0988-1a886d169e83@redhat.com>
 <20230315210545.GA116016@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315210545.GA116016@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 15, 2023 at 05:05:47PM -0400, Johannes Weiner wrote:
> On Wed, Mar 15, 2023 at 09:03:57PM +0100, David Hildenbrand wrote:
> > On 10.03.23 19:28, Stefan Roesch wrote:
> > > So far KSM can only be enabled by calling madvise for memory regions. To
> > > be able to use KSM for more workloads, KSM needs to have the ability to be
> > > enabled / disabled at the process / cgroup level.
> > > 
> > > Use case 1:
> > > The madvise call is not available in the programming language. An example for
> > > this are programs with forked workloads using a garbage collected language without
> > > pointers. In such a language madvise cannot be made available.
> > > 
> > > In addition the addresses of objects get moved around as they are garbage
> > > collected. KSM sharing needs to be enabled "from the outside" for these type of
> > > workloads.
> > > 
> > > Use case 2:
> > > The same interpreter can also be used for workloads where KSM brings no
> > > benefit or even has overhead. We'd like to be able to enable KSM on a workload
> > > by workload basis.
> > > 
> > > Use case 3:
> > > With the madvise call sharing opportunities are only enabled for the current
> > > process: it is a workload-local decision. A considerable number of sharing
> > > opportuniites may exist across multiple workloads or jobs. Only a higler level
> > > entity like a job scheduler or container can know for certain if its running
> > > one or more instances of a job. That job scheduler however doesn't have
> > > the necessary internal worklaod knowledge to make targeted madvise calls.
> > > 
> > > Security concerns:
> > > In previous discussions security concerns have been brought up. The problem is
> > > that an individual workload does not have the knowledge about what else is
> > > running on a machine. Therefore it has to be very conservative in what memory
> > > areas can be shared or not. However, if the system is dedicated to running
> > > multiple jobs within the same security domain, its the job scheduler that has
> > > the knowledge that sharing can be safely enabled and is even desirable.
> > > 
> > > Performance:
> > > Experiments with using UKSM have shown a capacity increase of around 20%.
> > 
> > Stefan, can you do me a favor and investigate which pages we end up
> > deduplicating -- especially if it's mostly only the zeropage and if it's
> > still that significant when disabling THP?
> > 
> > 
> > I'm currently investigating with some engineers on playing with enabling KSM
> > on some selected processes (enabling it blindly on all VMAs of that process
> > via madvise() ).
> > 
> > One thing we noticed is that such (~50 times) 20MiB processes end up saving
> > ~2MiB of memory per process. That made me suspicious, because it's the THP
> > size.
> > 
> > What I think happens is that we have a 2 MiB area (stack?) and only touch a
> > single page. We get a whole 2 MiB THP populated. Most of that THP is zeroes.
> > 
> > KSM somehow ends up splitting that THP and deduplicates all resulting
> > zeropages. Thus, we "save" 2 MiB. Actually, it's more like we no longer
> > "waste" 2 MiB. I think the processes with KSM have less (none) THP than the
> > processes with THP enabled, but I only took a look at a sample of the
> > process' smaps so far.
> 
> THP and KSM is indeed an interesting problem. Better TLB hits with
> THPs, but reduced chance of deduplicating memory - which may or may
> not result in more IO that outweighs any THP benefits.
> 
> That said, the service in the experiment referenced above has swap
> turned on and is under significant memory pressure. Unused splitpages
> would get swapped out. The difference from KSM was from deduplicating
> pages that were in active use, not internal THP fragmentation.

Brainfart, my apologies. It could have been the ksm-induced splits
themselves that allowed the unused subpages to get swapped out in the
first place.

But no, I double checked that workload just now. On a weekly average,
it has about 50 anon THPs and 12 million regular anon. THP is not a
factor in the reduction results.
