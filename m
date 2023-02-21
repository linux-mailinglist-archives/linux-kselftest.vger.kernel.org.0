Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CA569E444
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Feb 2023 17:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjBUQKu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Feb 2023 11:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjBUQKt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Feb 2023 11:10:49 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F251CACE
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Feb 2023 08:10:47 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d5so4650989qtn.13
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Feb 2023 08:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hOLB/HnML99ya6804mbfQSmZBEApjV83G7ETjQ04VsU=;
        b=yDl2F+bJ2ER+JfnGjFqIXfhCtD2SJ6l/O6+O3fI/Sq+ptsvezNMgriS6S5JZkhOi7j
         Cpz27bf5cwgllWWelIJa9jIsb6Xv+AOUjWGRf7DqkBVnA41mUuBr5/NdP8xpqWCBG9qE
         s5pDYuCj2uLijFydwVKxfaDe39x0bAV1M8x4VqFO/AYJPqz56VCO8u6R1EM74IFKnJz2
         3eUYgOXY90HKc6EQCEre/kS2O1Ay+CyqUTXYhxN+hoPX+uKZoXSQKXhRkhNahkqL2k0v
         9xTKmSgeTWdw4pgV8kBuvWvRrRTqJICyj13L0RZhGEqWOh/xlVL3BWfuy3oY1XLu7pa3
         N+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOLB/HnML99ya6804mbfQSmZBEApjV83G7ETjQ04VsU=;
        b=OIJIFgymkmpCsf9x7YXOP6VVNOKbFigEhx9O4SVSyuVseq7JCUd4eFK9J4H+QwbgTi
         ubnyj8HbZ843QMZXxxTNtfARiHllzwrFLdQ+AgPz4pSg8rm7q63M+tEgVBiSc0ssqcau
         HAga8hEHEVLP932Z6FasrA/WBY3I7O/mYpDtfuzVS3dar6MHpoTg1DOjGWrpamNvOZ6z
         D1yK2h6wM2o6APpQFjevCSJx/NcJDt5a3hGobjr3mi7SOkB63aP7FEml9R+MXDwxIrWw
         wS1k5jTNwncHcdx3Og/VIT02aowlLFqurtAzJLPJs0xGSFTqiQz0mvZ4E4uEbVkf8qvQ
         j6aQ==
X-Gm-Message-State: AO0yUKWVVsHgixqcoy4bVEe6YVU9J/EwnCGzM9THbPtl6xCjf1WYiJyS
        pK9TllE/ZYVWCfxRDDtfepihbg==
X-Google-Smtp-Source: AK7set/d87HCAHTcDyiftivrBKW2GCwl+NkEApnd4V3/UrHDLxxuTFB2tkatAEs/5lqrJXY8eYeXCg==
X-Received: by 2002:ac8:5f10:0:b0:3bf:a545:cffa with SMTP id x16-20020ac85f10000000b003bfa545cffamr2863338qta.23.1676995846477;
        Tue, 21 Feb 2023 08:10:46 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:5e17])
        by smtp.gmail.com with ESMTPSA id f23-20020ac84657000000b003b9a6d54b6csm952844qto.59.2023.02.21.08.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 08:10:46 -0800 (PST)
Date:   Tue, 21 Feb 2023 11:10:45 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [RFC PATCH v2 00/19] mm: process/cgroup ksm support
Message-ID: <Y/TtBc9DAkUKRHnV@cmpxchg.org>
References: <20230210215023.2740545-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210215023.2740545-1-shr@devkernel.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Stefan,

On Fri, Feb 10, 2023 at 01:50:04PM -0800, Stefan Roesch wrote:
> So far KSM can only be enabled by calling madvise for memory regions. What is
> required to enable KSM for more workloads is to enable / disable it at the
> process / cgroup level.
> 
> Use case:
> The madvise call is not available in the programming language. An example for
> this are programs with forked workloads using a garbage collected language without
> pointers. In such a language madvise cannot be made available.
> 
> In addition the addresses of objects get moved around as they are garbage
> collected. KSM sharing needs to be enabled "from the outside" for these type of
> workloads.

It would be good to expand on the argument that Rik made about the
interpreter being used for things were there are no merging
opportunities, and the KSM scanning overhead isn't amortized.

There is a fundamental mismatch in scopes. madvise() is a
workload-local decision, whereas sizable sharing opportunities may or
may not exist across multiple workloads. Only a higher-level entity
like a job scheduler can know for certain whether it's running one or
more instances of a job. That job scheduler in turn doesn't have the
necessary knowledge of the workload's internals to make targeted and
well-timed advise calls with, say, process_madvise().

This also applies to the security concerns brought up in previous
threads. An individual workload doesn't know what else is running on
the machine, so it needs to be highly conservative about what it can
give up for system-wide merging. However, if the system is dedicated
to running multiple jobs within the same security domain, it's the job
scheduler that knows that sharing isn't a problem, and even desirable.

So I think this series makes sense, but it would be good to expand a
bit on the reasoning and address the security aspect in the cover/doc.

> Stefan Roesch (19):
>   mm: add new flag to enable ksm per process
>   mm: add flag to __ksm_enter
>   mm: add flag to __ksm_exit call
>   mm: invoke madvise for all vmas in scan_get_next_rmap_item
>   mm: support disabling of ksm for a process
>   mm: add new prctl option to get and set ksm for a process

The implementation looks sound to me as well.

I think it would be a bit easier to review if you folded these ^^^
patches, the tools patch below, and the prctl selftests, all into one
single commit. It's one logical change. This way the new flags and
helper functions can be reviewed against the new users and callsites
without having to jump back and forth between emails.

>   mm: split off pages_volatile function
>   mm: expose general_profit metric
>   docs: document general_profit sysfs knob
>   mm: calculate ksm process profit metric
>   mm: add ksm_merge_type() function
>   mm: expose ksm process profit metric in ksm_stat
>   mm: expose ksm merge type in ksm_stat
>   docs: document new procfs ksm knobs

Same with the new knobs/stats and their documentation.

Logical splitting is easier to follow than geographical splitting.

Thanks!
