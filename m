Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E08D6B1036
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 18:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjCHRaL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 12:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHRaK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 12:30:10 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866BD1F481
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Mar 2023 09:30:08 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c19so18843735qtn.13
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Mar 2023 09:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1678296607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ofryIsss+bbfKW9sRlJ4gUUuHW01b2FzSgIEOep0Fw=;
        b=WTJCKYrlPO+z80Pj0ldUQiPsUhYYM3Lzu1D1J/OSaW7XBqfIxu9QFpb18NqjkIkyoE
         K8hLYPh3wWCXGptcswhGP/YEslOikQirsJ+Cq6byqp68SmOchcJa9Zd6pVt9vB2YS9bV
         Sku9qjINYCyLh1V8Se2D2jNIH3tC4Avf+tseSoUcPRNirfhGvy//ihgHijokpUoyslqJ
         RyDS0BsKyAy5Z1928GgvcS+ORxhj7kmCdI4DrzIbqcc1eOMWqSCedIBxBaMdCt/KM37l
         YE9fsU4HhYLKK6W7NmP8X946Kg+GuUO6ZIMg9MuYmisrru6YdLIWOwJsSnL1D1wP/9Hl
         mmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678296607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ofryIsss+bbfKW9sRlJ4gUUuHW01b2FzSgIEOep0Fw=;
        b=su96o+NKu/C3i2Lx7D43HqYNzNwYmek5iOSx9dlO4uNr+iuovUNRjoUTJpUsUBbuyx
         tepV6pFDw4bc8sF+CLH6vUuIC5SU2xQ7YZmRyw8eTLTqjn8rK3nppkSxIpx/3V73+rlo
         Ijx+OG9TndICHllBjnf+LCJzSoQp2szanX+DLDYy6FavDJiDbpngEmZcGXzGyxBd4via
         F4woE6MhcF5MPh3QruzJkbS7WWVQN6ZvuMVc/THBM5JMw2xuWi2czdO6HJFvFfHGf435
         eSMuOjHMpgrS3cCzL8R8yx1lmbCdHMA1v6TzGSjBWbmHIuBAuKv93XwOZwkmd4btL78k
         btaA==
X-Gm-Message-State: AO0yUKWOgX8JgdyO4lsV9E64rDDS7pg/TmU6Lx1qcX/GP6vFlaI3L+I8
        iUBtgHVd/ElAiBXzVdjvKTVwRg==
X-Google-Smtp-Source: AK7set/8J01RvgfncU4nxvd+VBrZobaqJFtIVM0M54i84BS0aGGdL7XMMjkbFYRNSCsnKxJyTYSiJg==
X-Received: by 2002:a05:622a:1aa4:b0:3bd:156f:6666 with SMTP id s36-20020a05622a1aa400b003bd156f6666mr4748778qtc.26.1678296607609;
        Wed, 08 Mar 2023 09:30:07 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id f13-20020ac87f0d000000b003b9b48cdbe8sm8515424qtk.58.2023.03.08.09.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 09:30:07 -0800 (PST)
Date:   Wed, 8 Mar 2023 12:30:06 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com,
        linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH v3 0/3] mm: process/cgroup ksm support
Message-ID: <20230308173006.GA476158@cmpxchg.org>
References: <20230224044000.3084046-1-shr@devkernel.io>
 <d9727ac4-4976-0de7-2d16-676ad7db5e89@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9727ac4-4976-0de7-2d16-676ad7db5e89@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hey David,

On Wed, Mar 08, 2023 at 06:01:14PM +0100, David Hildenbrand wrote:
> For some reason gmail thought it would be a good ideas to move this into the
> SPAM folder, so I only saw the recent replies just now.
> 
> I'm going to have a look at this soonish.

Thanks! More eyes are always helpful.

> One point that popped up in the past and that I raised on the last RFC: we
> should think about letting processes *opt out/disable* KSM on their own.
> Either completely, or for selected VMAs.
> 
> Reasoning is, that if you have an application that really doesn't want some
> memory regions to be applicable to KSM (memory de-duplication attacks?
> Knowing that KSM on some regions will be counter-productive)
> 
> For example, remembering if MADV_UNMERGEABLE was called and not only
> clearing the VMA flag. So even if KSM would be force-enabled by some tooling
> after the process started, such regions would not get considered for KSM.
> 
> It would a bit like how we handle THP.

I'm not sure the THP comparison is apt. THP is truly a local
optimization that depends on the workload's access patterns. The
environment isn't a true factor. It makes some sense that if there is
a global policy to generally use THP the workload be able to opt out
based on known sparse access patterns. At least until THP allocation
strategy inside the kernel becomes smarter!

Merging opportunities and security questions are trickier. The
application might know which data is sensitive, but it doesn't know
whether its environment is safe or subject do memory attacks, so it
cannot make that decision purely from inside.

There is a conceivable usecase where multiple instances of the same
job are running inside a safe shared security domain and using the
same sensitive data.

There is a conceivable usecase where the system and the workload
collaborate to merge insensitive data across security domains.

I'm honestly not sure which usecase is more likely. My gut feeling is
the first one, simply because of broader concerns of multiple security
domains sharing kernel instances or physical hardware.

> On 24.02.23 05:39, Stefan Roesch wrote:
> > So far KSM can only be enabled by calling madvise for memory regions. To
> > be able to use KSM for more workloads, KSM needs to have the ability to be
> > enabled / disabled at the process / cgroup level.
> > 
> > Use case 1:
> > The madvise call is not available in the programming language. An example for
> > this are programs with forked workloads using a garbage collected language without
> > pointers. In such a language madvise cannot be made available.
> > 
> > In addition the addresses of objects get moved around as they are garbage
> > collected. KSM sharing needs to be enabled "from the outside" for these type of
> > workloads.
> > 
> > Use case 2:
> > The same interpreter can also be used for workloads where KSM brings no
> > benefit or even has overhead. We'd like to be able to enable KSM on a workload
> > by workload basis.
> > 
> > Use case 3:
> > With the madvise call sharing opportunities are only enabled for the current
> > process: it is a workload-local decision. A considerable number of sharing
> > opportuniites may exist across multiple workloads or jobs. Only a higler level
> > entity like a job scheduler or container can know for certain if its running
> > one or more instances of a job. That job scheduler however doesn't have
> > the necessary internal worklaod knowledge to make targeted madvise calls.
> > 
> > Security concerns:
> > In previous discussions security concerns have been brought up. The problem is
> > that an individual workload does not have the knowledge about what else is
> > running on a machine. Therefore it has to be very conservative in what memory
> > areas can be shared or not. However, if the system is dedicated to running
> > multiple jobs within the same security domain, its the job scheduler that has
> > the knowledge that sharing can be safely enabled and is even desirable.
> 
> Note that there are some papers about why limiting memory deduplciation
> attacks to single security domains is not sufficient. Especially, the remote
> deduplication attacks fall into that category IIRC.

I think it would be good to elaborate on that and include any caveats
in the documentation.

Ultimately, the bar isn't whether there are attack vectors on a subset
of possible usecases, but whether there are usecases where this can be
used safely, which is obviously true.
