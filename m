Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE2448CDAC
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jan 2022 22:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiALVVW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jan 2022 16:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiALVVC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jan 2022 16:21:02 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DCFC061751;
        Wed, 12 Jan 2022 13:21:02 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so7525589pjp.0;
        Wed, 12 Jan 2022 13:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rMcwZZyzD4aLSfK+vIDiFeDvvWtNOlRHmP8s8YMbIOw=;
        b=cFPRS+JHB1Ou8jEaT14elVfUqR6AB4wKvYBEFO27k2tF4/lrAdI4f0HyAhDpya/8aq
         SrxqhX8tP4MI5XV07OmN2PrmxE6y7yWDkS4TX2B1INkQeStdjgsMy5W0OXIFVNWGT+gu
         +e3d0s49VBZnfheeE9DgxcL43vHldgvfMEoYrGz21MXCYL7qgfpt56PSaDwqjGYHwSZu
         NEd6rDSnG7qTwCZ/rOefH96fXbEToEeEUu174yrHx/F4pPyEXUUwfrDSJy9lYYawK/TL
         7+VcwPqszEk03hVL1tXf4YEaW2ESnnOW9ZhGRWWDqjasA64N3q3tQZ9PdCxJl+AKvKIr
         bvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rMcwZZyzD4aLSfK+vIDiFeDvvWtNOlRHmP8s8YMbIOw=;
        b=wUW9zmYr3S4d9sQ7rwy+B6zWnSyrDO0htNDvZkAeJL4vppjb+7Lc1/UoBbuPRsxbNI
         4jyfNDdiPJgXCcSbxN2+/2Lb0OOAEYwAHxvpE8wps+uBL35pnB/lF5lRh/LkfMp++fBO
         OQDN5gJ5IeiPk9vSMdUzANhUoyF1kqi44J9PzahFFJeRPqOYbc8eZeuuZBx4hqgYx1sa
         oAkDQGj776ByhRXY95ITG0JIGU7S6eUS5zujWw76Ue6w4JpwAMxlm3A8UKXjDzvjlrre
         q4XdWbKrJfON3VeQnxHtGFMdB/reDgw9txbgjVMIbzSL1i9zAHmUVTW7DSZzin8hkNZA
         q5ZA==
X-Gm-Message-State: AOAM532jwBYTkKVl1Aiba2KW3hN2xxQ2iga0+/wOwxVAvWL3eZ7pHWPu
        oUOGtCORK9A/UKcv2uuDSHI=
X-Google-Smtp-Source: ABdhPJyAf1N23q1Z+y569d/oGHSUMK3ZqiDI1J0ppOHjHBz1ppS+GNRHMMUILf7nso6azh/5JAiElQ==
X-Received: by 2002:a17:90b:1651:: with SMTP id il17mr10096286pjb.151.1642022462103;
        Wed, 12 Jan 2022 13:21:02 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id q18sm519156pfn.50.2022.01.12.13.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 13:21:01 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Jan 2022 11:21:00 -1000
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
Message-ID: <Yd9GPLytGQ6XpYK6@slm.duckdns.org>
References: <20211205183220.818872-1-longman@redhat.com>
 <20211205183220.818872-7-longman@redhat.com>
 <Ybe0YWEo7Wp7wib9@slm.duckdns.org>
 <20211215144450.GC25459@blackbody.suse.cz>
 <96018978-6b7f-1e7f-1012-9df7f7996ec5@redhat.com>
 <Ybo1jmNvM6sblcJq@slm.duckdns.org>
 <58c06961-ffc4-27d7-01d2-4c91b0c9161d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58c06961-ffc4-27d7-01d2-4c91b0c9161d@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Wed, Dec 15, 2021 at 01:55:05PM -0500, Waiman Long wrote:
> How about we allow transition to an invalid partition state but still return
> an error?

Like -EAGAIN as Michal suggested? I don't know. I understand the motivation
but one problem is that error return usually means that the operation didn't
change the state of the system and that holds even for -EAGAIN. So, we'd be
trading one locally jarring thing (this thing is asynchrnous and the actual
state transitions should be monitored separately) to another one which is
jarring in a wider context (this thing returned error but the system state
changed anyway). To me, the latter seems noticeably worse given how common
the assumption that an error return indicate that nothing actually happened.

We have other cases where we split operation submissions and completions
(aios being the obvious one) but I don't think we have any where -EAGAIN
indicates successful initiation of an operation. At least I hope not.

Thanks.

-- 
tejun
