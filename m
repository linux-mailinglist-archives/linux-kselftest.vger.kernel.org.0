Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1999E4760D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Dec 2021 19:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238823AbhLOSgB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Dec 2021 13:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbhLOSgA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Dec 2021 13:36:00 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D416C061574;
        Wed, 15 Dec 2021 10:36:00 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id k4so17230280plx.8;
        Wed, 15 Dec 2021 10:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sphiaH5KnmKIhXvaCjxOtnGbcU9KdLom7iLRZ9t9/OM=;
        b=OXZjFnMocX9uFmrlxixUhWGpHHaV1MbVgChhnY+iiHKbnMpZ0x8KzP0FsxC/s3DdzE
         87++rrRG6KT0U4LWdkSCOtxJM2j7wSBBmHZ0+K0xnPSB5OHqh2JPdigZr/qy9dtPzF4B
         pInBtHxZRy3a1+i8e8PAXoKVzDnPlgpSk+yt+TNL6jo1J15RfbGN/iCT6JhBEgiNclJO
         lTltrL5JttU8S/fKw10ua4K2exbyUUK9nf7jI95EVoSTx3yrW7RJ2rjgjZCpDLquVgfr
         G3EcqsbIAMBt5nVaGPyof3u5uwik8+RkIw5Rlk8q/CaO1/9ZmU9k7aJHOWcpyhqZwccf
         J9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=sphiaH5KnmKIhXvaCjxOtnGbcU9KdLom7iLRZ9t9/OM=;
        b=uSK/ECtNbgsp4IW9GfBqiAIKGmLXel5yD28l4bduANcFRSnWmTHaCQ2E5QbesEHMCX
         WIbeuews4FadEUpwTvDC4zrDI5UaSfcAS+GdBD1ytygGObTfuJnVckP0/YLLz3bhI/cW
         9APq+r/owdduzmfRFeLkfNKiRMB9LCPW5ZJF08Sxp+upD4oYFLfmjvRV7ydvEoyi4Ba3
         dulRUn6CaJFl4FobKwWemxKR2Md1i9Cb0tFxklvmS7ipK5ERbAFYh99+siJGUmiUIoXQ
         sQZgWodj/XwMzGeJxoUu8kHz+g13cZVu6UHC6lF7PWP2vjkxtOaYYVk0+HcrM9Zx6cQU
         JGtg==
X-Gm-Message-State: AOAM531Pa/i2U5SPKa4nbUB3W8gRNSoNniSqtX3RxKkqtJDEcIkoSyo2
        kasz45+d3/5f7V9bcght7MQ=
X-Google-Smtp-Source: ABdhPJyL6Wkm4KA6qbSocm0ua0cPJ9+qzrvLwZOXFLvtrd9hkLMwJtTDyqJpalhD0xhoGuErm7IOig==
X-Received: by 2002:a17:90b:798:: with SMTP id l24mr1215540pjz.122.1639593359900;
        Wed, 15 Dec 2021 10:35:59 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id nv17sm6501515pjb.55.2021.12.15.10.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 10:35:59 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 15 Dec 2021 08:35:58 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v9 6/7] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <Ybo1jmNvM6sblcJq@slm.duckdns.org>
References: <20211205183220.818872-1-longman@redhat.com>
 <20211205183220.818872-7-longman@redhat.com>
 <Ybe0YWEo7Wp7wib9@slm.duckdns.org>
 <20211215144450.GC25459@blackbody.suse.cz>
 <96018978-6b7f-1e7f-1012-9df7f7996ec5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96018978-6b7f-1e7f-1012-9df7f7996ec5@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello, Waiman.

On Wed, Dec 15, 2021 at 01:16:43PM -0500, Waiman Long wrote:
> Allowing direct transition from member to invalid partition doesn't feel
> right for me. A casual user may assume a partition is correctly formed
> without double checking the "cpuset.partition" value. Returning an error
> will prevent this kind of issue. If returning more information about the
> failure is the main reason for allowing the invalid partition transition, we
> can extend the "cpuset.partition" read syntax to also show the reason for
> the previous failure.

I don't think it's a good idea to display error messages without a way to
link the error to the one who triggered it. This is the same problem we had
with resettable counters. It only works for scenarios where one guy is
sitting in front of the computer but gets nastry for more complex scnearios
and automation.

I understand that allowing transitions to invalid state can feel jarring.
There are pros and cons to both approaches. It's similar dynamics tho.
Erroring out may be more intuitive for a casual user but makes it harder for
more complex scenarios because whether a given operation errors or not is
dependent on external asynchronous states, there's no good way of reporting
the exact nature of the error or detecting when the operation would succeed
in the future, and the error conditions are rather arbitrary.

Thanks.

-- 
tejun
