Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EEE6D9962
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 16:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239055AbjDFOQk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 10:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239074AbjDFOQh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 10:16:37 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975E19000
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Apr 2023 07:16:23 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id cr18so34324582qtb.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Apr 2023 07:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680790582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/keXUwxyyyhEmE55ekm1FOCQVlxKlIBEPyFrxNy9+U8=;
        b=yMgxS62CvuVWs51H3j8VhZZqIn+Cxgamg4MbN38plY1EHsc+48o/I2AU+AL+IrLGyb
         2FQPJBrBUfPODEdPgg3Cs8bERKQ8L0drmuknQiejJ1OX5SgINjFOVIRScBqH+2G6tfKz
         UO9iQ4OkJCRftY92TR3n8hbAi45WxIx43oy9C9NVUE94NNJhL9wVyWMOBI+kGQXkMxWp
         pFvXpOOfzOVXCB6GmFyiFM9LrIUUQCFvrbgkT4nVWvY6y043YqaOrSy095TBohrzhtDh
         4pjKCjdLwRPqUL1UDC7+YaUp7gjIrS2XXSvQH+FO30nS9mfbWYHaorWMJK8x2hMP8vV2
         DZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680790582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/keXUwxyyyhEmE55ekm1FOCQVlxKlIBEPyFrxNy9+U8=;
        b=sj3Dj6s3HTP808kQgIsjFnyLkdlTi1EShXvaLvcdkEPk1j4KLGFqgoOa2Mj89SyDH3
         Qy4zvC2pgJzfa066OEcg5YsYTkhFsYwNyNhqt/TVIloopf8mJ9Aki9ev7LlA4wrjiy5u
         tZunBmAuLchS+KOMsCjCWux6KOJ3+gj1Qq/PzqSBB0Q6uBl/hemY05H29nrn/qwW62WO
         6xokULT7QVJePa0jwQkRjRPp7MJ/uZP8JmQN69rE6Zway41SqUw59GYOIDVlWDd0Bebd
         4x65qBGxs8gnRsWH792MqDFgmnSLlmTozVqqOwCxjVBwG73CgL7gyfrg6gfn9wJwcPt3
         T9+w==
X-Gm-Message-State: AAQBX9emQzaPjZSGapLtYTK89vES8RIbpIKUizsIoF+NK5kXw1fHYf8B
        x4vTljQz1bzgu0Kcxsk3oj+Xvw==
X-Google-Smtp-Source: AKy350aHGbMuHwfg10eLISdaNmwzT6KQ08KKQI4+CJ4NG36CU3mo9lXcmtYbtUWWQpn3yduoT2tNeg==
X-Received: by 2002:a05:622a:118d:b0:3b9:b2ba:9b3d with SMTP id m13-20020a05622a118d00b003b9b2ba9b3dmr11399480qtk.54.1680790582613;
        Thu, 06 Apr 2023 07:16:22 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id d7-20020ac85347000000b003e3982a6f2bsm450114qto.18.2023.04.06.07.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:16:22 -0700 (PDT)
Date:   Thu, 6 Apr 2023 10:16:19 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com,
        linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v4 2/3] mm: add new KSM process and sysfs knobs
Message-ID: <20230406141619.GB35884@cmpxchg.org>
References: <20230310182851.2579138-1-shr@devkernel.io>
 <20230310182851.2579138-3-shr@devkernel.io>
 <ce494e5a-3540-d6ad-4e9c-0bb49c7e1e1b@redhat.com>
 <qvqw8rf6uicf.fsf@dev0134.prn3.facebook.com>
 <e7a930f6-feba-29a4-7c48-ae7d8108c7dc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7a930f6-feba-29a4-7c48-ae7d8108c7dc@redhat.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 06, 2023 at 03:23:11PM +0200, David Hildenbrand wrote:
> > > 
> > > Often, when you have to start making a list of things that a patch does, it
> > > might make sense to split some of the items into separate patches such that you
> > > can avoid lists and just explain in list-free text how the pieces in the patch
> > > fit together.
> > > 
> > > I'd suggest splitting this patch into logical pieces. For example, separating
> > > the general profit calculation/exposure from the per-mm profit and the per-mm
> > > ksm type indication.
> > > 
> > 
> > Originally these were individual patches. If I recall correctly Johannes
> > Weiner wanted them as one patch. I can certainly split them again.
> 
> That's why I remember that v1 contained more patches :)
> 
> Again, just my opinion on patches that require a description in form of a
> list ...

My concern was the initial splitting of patch 1. I found it easier to
review with the new prctl() being one logical change, and fully
implemented in one go. The changelog is still in the form of a list,
but it essentially enumerates diff hunks that make up the interface.

No objection to splitting out the multiple sysfs knobs, though!

The strategy I usually follow is this:

1. Split out changes based on user-visible behavior (new prctl(), new
   sysfs knob)

2. Extract changes made along the way that have stand-alone value in
   existing code (bug fixes, simplifying/documenting tricky sections,
   cleanups).

3. Split out noisy prep work such as renames and refactors that make
   the user-visible functional changes more difficult to understand.

and then order the series into sections 2, 3, and 1.
