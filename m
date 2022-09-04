Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF8D5AC684
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Sep 2022 22:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiIDUso (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Sep 2022 16:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiIDUsm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Sep 2022 16:48:42 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A612ED65;
        Sun,  4 Sep 2022 13:48:41 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 72so6882934pfx.9;
        Sun, 04 Sep 2022 13:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=l3XlvtUxRBxEdbMEdKHUlRAxmIFOa1PhP6QcRf9whvo=;
        b=CTdZcGNlqVJCtE/o2YQJgHj2u1letdzly71G8AwP+23usqZVUHLIE4Oz3/6KDs4S/k
         xDVHrwKau2bdDO3p+4GJEE4K7QECOh3FVRneojsgcLqQYwzUA5pvl4Yvan5dpVZbzmnj
         zEwEP/xpz/w8QJ1Xp4WhhURNX3I5WhNWJivedm5ORPCrVqUmrPIKRy1zFldhV5dNTRoq
         V23Zef6lxQSydwiS4VjveXx6w3ImkA3qsLIQevMCoDrtHryqAG0gDcf7EhpcC4gyjlsD
         XzkCRIGAwLFS1oyrxeott3phfyF91tvQ/Ujs2x48XZwLbJcl0iw4nXvv9FP/95crcZo6
         nckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=l3XlvtUxRBxEdbMEdKHUlRAxmIFOa1PhP6QcRf9whvo=;
        b=ZZJZygjwsotbatM4dXu6QoQFFBQu59FfySlY0bYYT7RA04BfH9dAlzxA7mFzwvLh3f
         SGtFaKUuquELYi08tASJqRpagxjhkENSXN+EoBS9mj+z5+Fvoed+uHRAc2BmNshbbgFx
         ggnuppWt+lddsZY8tznGW7AjXeab9Ja8RydTQhj6/WLoVpmBGA3JwljPArnACFH79H/t
         fqZJpE7t8zTWR9tAbqx2KcxFlvz81+eev6YTu0x3u4jbR+ErtjheCTjZvj2LvQ3OCBrt
         piWo64d+T4QRDeX5fBQ0aF5dTC8gEqXYe7jZxmItBZZiTxU2T9E2sRS4PjonXwGpROoW
         Tp1Q==
X-Gm-Message-State: ACgBeo2jbWVjVMYX5N0eJNlIeyPZyVI/yHhCihtDxv4LbyaK+FalfQLm
        u3BG6As+Gmgg+j/7eEprfh3+APox1Ro=
X-Google-Smtp-Source: AA6agR5fTjM5aOjIQNIvJoMbCufh+V86U4zOLIq1jJ4Ofug6Sl8MxWFCI17WLwd+dHmRMlh2PyDbGQ==
X-Received: by 2002:a63:a541:0:b0:432:6d53:9870 with SMTP id r1-20020a63a541000000b004326d539870mr9143304pgu.382.1662324520564;
        Sun, 04 Sep 2022 13:48:40 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:291b])
        by smtp.gmail.com with ESMTPSA id c3-20020aa79523000000b0053813de1fdasm6087063pfp.28.2022.09.04.13.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:48:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 4 Sep 2022 10:48:38 -1000
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
Subject: Re: [PATCH v12 00/10] cgroup/cpuset: cpu partition code fixes &
 enhancements
Message-ID: <YxUPJqrsWvZoXXhZ@slm.duckdns.org>
References: <20220901205745.323326-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901205745.323326-1-longman@redhat.com>
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

On Thu, Sep 01, 2022 at 04:57:35PM -0400, Waiman Long wrote:
> v12:
>  - Change patch 1 to enable update_tasks_cpumask() for top_cpuset except
>    for percpu kthreads.
>  - Add 2 more patches to make exclusivity rule violations invalidate the
>    partition and its siblings instead of failing the change to make it
>    consistent with other cpuset changes.
>  - Update documentation and test script accordingly.

Applied to cgroup/for-6.1 with the doc tables fixed.

Thanks a lot for sticking with it. This looks great.

-- 
tejun
