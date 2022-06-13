Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A36549D59
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jun 2022 21:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347001AbiFMTT7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jun 2022 15:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbiFMTQk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jun 2022 15:16:40 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200D3562DA;
        Mon, 13 Jun 2022 10:28:28 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id z17so6331284pff.7;
        Mon, 13 Jun 2022 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yv4/HdDYVjkX/YAztaZebjL1a0eQClbhVe6udK7q55Q=;
        b=R4KQhc65mAGubUVJTJuWOM9bF5a4E4aR2gWSHzop0dE6laiurPYFF44248RO1CN/49
         WGb5A/2tKnAUyTlNMto07nWaja1JSdE0p5FCaIOBCx0GpqRcN6UnwOfVVvtl9+g0krxZ
         UyaGiIURgykSXcIYLf9MJ59TgoMP3BburahgZgyuOCcoEL5Wno83fRLSagiwcmEG8Z7L
         t+D45/nsuHfvfQfooZUVeKI2gOrZlvXwlvj0TJmpMa5ttYI7M3o7z2+dC2wBOYu6NLWy
         f1G3g8SRqYk7jGR6uWZj9DZV2Cm8hnqHoeEfoRwikam2u3kgDwXnQ1m0xEMETKYD9EI3
         X91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=yv4/HdDYVjkX/YAztaZebjL1a0eQClbhVe6udK7q55Q=;
        b=0exH7V8dY+pqJNYT4OggtW+Hh23cXrgGahMb/JlYa3qRTSehwxjPMub0injxdm8cwY
         B/qffLeZ6pWLy8iBIWXUVvYW5Kp/cmrTmlgZuXyqykb5slIdWYgCz+mHqRAtRvGjc1hb
         iSw+L3PGkkAEgSgAmUgvm3a2Ps7uZ21+DZN9aFbjTViJx/AESHWwGFJvYDuFVPhpYE9e
         0ZAd3jIhp8ppxPQx2yNPXP4ePTTonXRdvBqYTqse1p2Gnc6KCtQfvrtfw3lYLKilS2Iz
         1CWcWSivFD3hsxvOPPK10PBC1Yc1jnTdBgmCCziSXC91ZpfHZR3UAVrj2JBaLzXnmvMf
         kYyw==
X-Gm-Message-State: AOAM532V2dYmbTw9meKt93LIHTWvqHUw9tlO+1NtFg2JS63zQNjmtB3u
        XQQ+S2UN3OJLNJtZbY8UYDQ=
X-Google-Smtp-Source: AGRyM1v+z2rPkn1qb0UFNOFd9//S65o7RvxU3mSJDSoDEAw40pCYl1wX79IBkc8c8nQeVnqvpQb2Tg==
X-Received: by 2002:a05:6a00:2392:b0:51b:fe0e:2b8 with SMTP id f18-20020a056a00239200b0051bfe0e02b8mr31643pfc.84.1655141307321;
        Mon, 13 Jun 2022 10:28:27 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b27-20020a63931b000000b003fe22d73d52sm5752410pge.74.2022.06.13.10.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:28:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Jun 2022 07:28:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Waiman Long <longman@redhat.com>,
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
Subject: Re: [PATCH v11 7/8] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <YqdzuSQuAeiPXQvy@slm.duckdns.org>
References: <20220510153413.400020-1-longman@redhat.com>
 <20220510153413.400020-8-longman@redhat.com>
 <YqYnQ4U4t6j/3UaL@slm.duckdns.org>
 <404171dc-0da3-21f2-5003-9718f875e967@redhat.com>
 <YqarMyNo9oHxhZFh@slm.duckdns.org>
 <20220613142452.GB6910@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220613142452.GB6910@blackbody.suse.cz>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Mon, Jun 13, 2022 at 04:24:52PM +0200, Michal Koutný wrote:
> On Sun, Jun 12, 2022 at 05:12:51PM -1000, Tejun Heo <tj@kernel.org> wrote:
> > On Sun, Jun 12, 2022 at 11:02:38PM -0400, Waiman Long wrote:
> > > That is the behavior enforced by setting the CPU_EXCLUSIVE bit in cgroup v1.
> > > I haven't explicitly change it to make it different in cgroup v2. The major
> > > reason is that I don't want change to one cpuset to affect a sibling
> > > partition as it may make the code more complicate to validate if a partition
> > > is valid.
> > 
> > If at all possible, I'd really like to avoid situations where a parent can't
> > withdraw resources due to something that a descendant does.
> 
> My understanding of the discussed paragraph is that the changes are only
> disallowed only among siblings on one level (due to exclusivity rule,
> checked in validate_change()). A change in parent won't affect
> (non)exclusivity of (valid) children so it's simply allowed.
> 
> So the docs (and implementation by a quick look) is sensible.

I see. Is this part even necessary? All the .cpus files of the siblings are
owned by the parent who's responsible for configuring both the mode that the
cgroup subtree is gonna be in and their cpumasks. Given that all the other
errors it can make are notified through "invalid (REASON)" in the mode file,
wouldn't it fit better to notify cpus configuration error the same way too?

Thanks.

-- 
tejun
