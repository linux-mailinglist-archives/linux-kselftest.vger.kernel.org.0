Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1666C9807
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Mar 2023 23:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjCZVjH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Mar 2023 17:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCZVjG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Mar 2023 17:39:06 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8854C1C;
        Sun, 26 Mar 2023 14:39:05 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id t13so5610847qvn.2;
        Sun, 26 Mar 2023 14:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679866743;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIQ9eIlSpAA9+1gG0Uwa5651wmcDfg3GdDljDetIFiQ=;
        b=iP5DTRifXkna2xG4BWLYOCPilWOenHcKn8F1BZSaU1GS7Te4U3B+bWKuQv+Q87LOoe
         PYdMvTjfy3+tHC9omeyUbwvp1kLn2IgOhXLUrLduNELj1UqQIsUZBRkkRztl1czE8Hjm
         W/Yfgapi8XT//anxdFk0WxC+4gMdNLVYLqcOIWomBAm1f9UaX/gXT0GSipU/Loa+IMjr
         TzUvhWZvx2G6Dszb20A3jqO4RorhmpjLvOMFMnkJDVeBWSQ1gyZU6I5/DOZndJcIod4u
         1CcALobgmLxOfE3h8pgPD8w2tAFUoDYmf94NMuFIuT/rAu0Rhcp49OQOhpjF4hEUoMsj
         DeMg==
X-Gm-Message-State: AAQBX9fxDNZxYrl7JRBhIr6vkEgzwMXG3FgjcRP9YBaB9MymKYkUna84
        nGv/GxPqSKESfmFn1JGzVvA=
X-Google-Smtp-Source: AKy350Z7u9qMmrS9h4j5TqP1uMWZa6oiBm2m+vreuWKuQd9iOVloKRpZ6D+Ab5O3wvFzZz+hpT3GsQ==
X-Received: by 2002:a05:6214:4114:b0:5aa:fd43:1fbe with SMTP id kc20-20020a056214411400b005aafd431fbemr16826372qvb.46.1679866743277;
        Sun, 26 Mar 2023 14:39:03 -0700 (PDT)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id 75-20020a370a4e000000b006ff8a122a1asm10659270qkk.78.2023.03.26.14.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 14:39:02 -0700 (PDT)
Date:   Sun, 26 Mar 2023 16:39:00 -0500
From:   David Vernet <void@manifault.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Jay Kamat <jgkamat@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests: cgroup: Fix exception handling in
 test_memcg_oom_group_score_events()
Message-ID: <20230326213900.GJ363182@maniforge>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <c383bdca-6f0d-4a75-e788-e1920faa0a62@web.de>
 <fffcd98a-bb73-41cd-8545-0f2c55dd38f9@lucifer.local>
 <5b7921c9-ee5d-c372-b19b-2701bcf33148@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b7921c9-ee5d-c372-b19b-2701bcf33148@web.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 26, 2023 at 10:15:31AM +0200, Markus Elfring wrote:

[...]

> >>
> >> Fixes: a987785dcd6c8ae2915460582aebd6481c81eb67 ("Add tests for memory.oom.group")
> >
> > Fixes what in the what now?
> 
> 1. Check repetition (which can be undesirable)
> 
> 2. Can a cg_destroy() call ever work as expected if a cg_create() call failed?

Perhaps next time you can answer your own question by spending 30
seconds actually reading the code you're "fixing":

int cg_destroy(const char *cgroup)
{
        int ret;

retry:
        ret = rmdir(cgroup);
        if (ret && errno == EBUSY) {
                cg_killall(cgroup);
                usleep(100);
                goto retry;
        }

        if (ret && errno == ENOENT) <<< that case is explicitly handled here
                ret = 0;

        return ret;
}
