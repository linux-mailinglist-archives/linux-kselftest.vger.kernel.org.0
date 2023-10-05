Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082B77BAB6A
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 22:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjJEUZJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 16:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjJEUZJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 16:25:09 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0EC93;
        Thu,  5 Oct 2023 13:25:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9b2f73e3af3so244795666b.3;
        Thu, 05 Oct 2023 13:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696537506; x=1697142306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EORYdYRX/JTnSaEVrtfXCtgRXALsCRav/4X7zISoiUk=;
        b=jdQXfinYMSKHBtT8lzxRP9izf/vqD6bFmE2Fm8l+ODEN1tySYjZnrtX86rWlXbgjFl
         HFZK26/R/roxn6L1Jcjg2CU34gZvzUCkDXYWkV1Jwr1Opkkaf+3AWENodsmGNIqVtg/4
         q3ZXWRLQ1eAp+GK/YDjl+it5hhMp/f+oJUQ7Tm/FyRl3v0ORJ14Mg5fICvM8XPeB540W
         0B8wxcY/2VDJtSw4TbqTcWlVRS2+trJG62BPT4w6AIJ8ONX+Vyb6pYIQH7lOC6sx7LxU
         c39TnxeV1+i4WpMtUvvUTuQ9pjgg6CLX5pmajhqeSIIV+Zg7I3K32uZDPpoCeFEJ1fPL
         SIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696537506; x=1697142306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EORYdYRX/JTnSaEVrtfXCtgRXALsCRav/4X7zISoiUk=;
        b=EL+HE6/Gh5mO1E/FPTtZnroin5u3OzddlRZaETO+d/K+mv1EkL0IZIhUanD20hQZx+
         5XfPrN7Ip82nkkMsjMxW1pk/GJwcd5UiEjaBsmeo68bX/5l2HTWDWx5A+WvIC6/Gg0yp
         hyRgtZ4AoiUli/KITYjUlY/zVdM60h/T0x88/gLy1CJgXJztdHVMIEA9dZPSbqbz9hZ2
         VyTSXr+CkrcnMUNMf7BH2vWJXsbHYv9KHD7ZtsahbIWzhfFnIBz8ASOeq0tXAzJ2Ml0u
         9L/wpaN1FnvDA3sG04PdKee3vW37QZT064uTiisAsGXDTPg5YX7RqNSepPQh8qZO+2BI
         cVHw==
X-Gm-Message-State: AOJu0YyRLBPVKRW/IQ7wkWQdrV4AptrX6ukcWB9ERFWRSav8zninMykl
        eicuZiTTeezweBgxZGczg4A=
X-Google-Smtp-Source: AGHT+IFyAxqoz8J0hULZYn3nhcRDJnm/wfuQPF9QsNUKR5ot3ZLP61hz+DMOvNKFcKftnj45ewyybA==
X-Received: by 2002:a17:906:53d2:b0:9b2:c1bb:a695 with SMTP id p18-20020a17090653d200b009b2c1bba695mr5588533ejo.13.1696537505921;
        Thu, 05 Oct 2023 13:25:05 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id a9-20020a170906244900b0099bd86f9248sm1708486ejb.63.2023.10.05.13.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 13:25:05 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 5 Oct 2023 22:25:03 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 6/6] selftests: futex: remove duplicate unneeded defines
Message-ID: <ZR8bn/UDLypbUhJT@gmail.com>
References: <20230805073809.1753462-1-usama.anjum@collabora.com>
 <20230805073809.1753462-6-usama.anjum@collabora.com>
 <ZRvU8DXRWL9sgKug@gmail.com>
 <51273ffa-e323-44e8-8a93-bc04ee356df0@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51273ffa-e323-44e8-8a93-bc04ee356df0@collabora.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


* Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:

> On 10/3/23 1:46 PM, Ingo Molnar wrote:
> > 
> > * Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
> > 
> >> Kselftests are kernel tests and must be build with kernel headers from
> >> same source version. These duplicate defines should automatically
> >> picked up from kernel headers. Use KHDR_INCLUDES to add kernel header
> >> files.
> >>
> >> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >> ---
> >>  .../selftests/futex/include/futextest.h       | 22 -------------------
> >>  1 file changed, 22 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testing/selftests/futex/include/futextest.h
> >> index ddbcfc9b7bac4..59f66af3a6d10 100644
> >> --- a/tools/testing/selftests/futex/include/futextest.h
> >> +++ b/tools/testing/selftests/futex/include/futextest.h
> >> @@ -25,28 +25,6 @@
> >>  typedef volatile u_int32_t futex_t;
> >>  #define FUTEX_INITIALIZER 0
> >>  
> >> -/* Define the newer op codes if the system header file is not up to date. */
> >> -#ifndef FUTEX_WAIT_BITSET
> >> -#define FUTEX_WAIT_BITSET		9
> >> -#endif
> >> -#ifndef FUTEX_WAKE_BITSET
> >> -#define FUTEX_WAKE_BITSET		10
> >> -#endif
> >> -#ifndef FUTEX_WAIT_REQUEUE_PI
> >> -#define FUTEX_WAIT_REQUEUE_PI		11
> >> -#endif
> >> -#ifndef FUTEX_CMP_REQUEUE_PI
> >> -#define FUTEX_CMP_REQUEUE_PI		12
> >> -#endif
> >> -#ifndef FUTEX_WAIT_REQUEUE_PI_PRIVATE
> >> -#define FUTEX_WAIT_REQUEUE_PI_PRIVATE	(FUTEX_WAIT_REQUEUE_PI | \
> >> -					 FUTEX_PRIVATE_FLAG)
> >> -#endif
> >> -#ifndef FUTEX_REQUEUE_PI_PRIVATE
> >> -#define FUTEX_CMP_REQUEUE_PI_PRIVATE	(FUTEX_CMP_REQUEUE_PI | \
> >> -					 FUTEX_PRIVATE_FLAG)
> >> -#endif
> > 
> > AFAICT I cannot really pick this up into the locking tree as-is, as this patch
> > relies on the KHDR_INCLUDES change in patch #1, so that all self-tests get the
> > kernel headers included, correct?
> No this patch is self contained and doesn't depend on the patch #1.
> KHDR_INCLUDES was included several releases back in kselftest's Makefile
> and in kselftests of futex. Correct headers are being included already. In
> this patch, I'm removing just the un-needed dead code. Other patches were
> already picked up by other maintainers.

So the changelog does not match that characterization, it talks about 
KHDR_INCLUDES in the present tense, and patch #1 adds the KHDR_INCLUDES, 
which further suggested a dependency to me:

> >> Kselftests are kernel tests and must be build with kernel headers from
> >> same source version. These duplicate defines should automatically
> >> picked up from kernel headers. Use KHDR_INCLUDES to add kernel header
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >> files.
     ^^^^^^

Could you please re-send it with the changelog updated that makes it clear 
that this patch works fine standalone against current mainline kernels?

Thanks,

	Ingo
