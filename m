Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6325D547DDD
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jun 2022 05:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238296AbiFMDM6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Jun 2022 23:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238293AbiFMDMz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Jun 2022 23:12:55 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982E2DFCE;
        Sun, 12 Jun 2022 20:12:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id f8so3988538plo.9;
        Sun, 12 Jun 2022 20:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q0gGWcWV/COJT901q1rc8QzcrP5DaNECZkTvshE+F+Q=;
        b=KyQJjJ5e7Nsc4ypOYCGc1PPbWbAidU7McvnzqEwhmXBSKGt+XA+UKo4C0rStxYLtJ6
         rzzT7/GhMYx3yzArDjKvdHv48bl1IH5UTHIo6z8v3HO0+YiK0Ouxtqo8iVvuBkoJpNUj
         Xw49TN+kG5PMWL7Zmdq/LcnxdEME5yBFZzB5+q2WmWf9oibGDOHANnGUF0XVZr1TDpAT
         OGPBKSva3rbfUUvwOG56eu3S0Eal0dSMaPyP8UCn0t556oli2wM6QdU6PfNuhaRUeetW
         PDazGjTXbMEwdTPjrNC1IfAHzRwTtJU7evS9DKVtupE8v9qPoM++WUb2O4s5v7QxmPal
         tDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=q0gGWcWV/COJT901q1rc8QzcrP5DaNECZkTvshE+F+Q=;
        b=KQDoAaYeTFuAa5+S0U1mKvyLYF2VKqKVuKru9kvKPrEGHaoOS/f6nd43haDlPXGP+s
         Q6rufbISwuKciiWXTGY3tgqOFBqGBwHzpzWyiqj+5CE6PtPTmQCP1ZE0O3gPXervnNfM
         bUuTQA8c58eK/RPFEIjQq0PtPnMZIi3tTZH51z/WjzbfkiYuTX9bK0GcF9VseO+J7eNe
         KEi9QYoy2yE4bsxgGm2ypiXD2MV8MOr/nHEzlaC7lb9gKRFi4UKD2DM5n5Ij0klndiws
         gEYGPqWF4xWiMh1pAVJoWpA6aIogi9wR6S/9w08BirOtIBfXX75IXv/vpZme9kyZACs1
         Cqrw==
X-Gm-Message-State: AOAM531f71unLdESh36gmpp8wZhJRdeFBDHljrShjE7iqctv+KQxH+U5
        nsH8o4+CzVurzhiWsltCM9k=
X-Google-Smtp-Source: ABdhPJxhWu5uQt6Se6MpSnQ4Yq2wcgiALwT33Ycu65UT8s52QfSmAr2EACBf0v+/7oDFaCHYncX6eA==
X-Received: by 2002:a17:902:f646:b0:168:e2da:8931 with SMTP id m6-20020a170902f64600b00168e2da8931mr1018319plg.84.1655089973994;
        Sun, 12 Jun 2022 20:12:53 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b11-20020a1709027e0b00b0015ed003552fsm3737642plm.293.2022.06.12.20.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 20:12:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 12 Jun 2022 17:12:51 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
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
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH v11 7/8] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <YqarMyNo9oHxhZFh@slm.duckdns.org>
References: <20220510153413.400020-1-longman@redhat.com>
 <20220510153413.400020-8-longman@redhat.com>
 <YqYnQ4U4t6j/3UaL@slm.duckdns.org>
 <404171dc-0da3-21f2-5003-9718f875e967@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404171dc-0da3-21f2-5003-9718f875e967@redhat.com>
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

On Sun, Jun 12, 2022 at 11:02:38PM -0400, Waiman Long wrote:
> That is the behavior enforced by setting the CPU_EXCLUSIVE bit in cgroup v1.
> I haven't explicitly change it to make it different in cgroup v2. The major
> reason is that I don't want change to one cpuset to affect a sibling
> partition as it may make the code more complicate to validate if a partition
> is valid.

If at all possible, I'd really like to avoid situations where a parent can't
withdraw resources due to something that a descendant does.

Thanks.

-- 
tejun
