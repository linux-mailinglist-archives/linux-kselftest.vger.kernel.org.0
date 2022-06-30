Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73428562644
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Jul 2022 00:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiF3WyB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Jun 2022 18:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiF3WyA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Jun 2022 18:54:00 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0E451B0E;
        Thu, 30 Jun 2022 15:54:00 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g7so887350pjj.2;
        Thu, 30 Jun 2022 15:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ywGXGSeAdHaxOG0hHw1tcJMSEkflmye5hh+2B4JWTp0=;
        b=mNLr4nkPZCDYuI2fSYGchP6gg6SX6mc4w6ytuuvcRaoApa6emQ7mzzj6Thc0PX2xjP
         5T20a8tNMdamJX78/HhIM+zs5fa6Sf4Z3eSCkhjArJSzl6mCGuicVAyrUpiIxC3WXyla
         HRNIlPRXxR1PaF6qZe2t4b/ZgygdqNI/KLflZGCJFfRCZnVIXU+74OCV19a4/JeCs8AF
         uWx7283rnfiPKAB/NTQLC0CPPqMpQ6uQSHJH/TCadJV/frfEIidBAI/UqsA5oRhHb8et
         R/8g3HAEmIz0tlGqHjiFSQxNcyvAgyO9T0QcwI+OTs0N8iGMSFt58HKXjRM6EDmaepP0
         0hVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=ywGXGSeAdHaxOG0hHw1tcJMSEkflmye5hh+2B4JWTp0=;
        b=LWpo20NQ4u8HJjhqsNX/m8BCFOhT7fc7fAwI5PaGZSQ+Uh8EGdsGqpDI63Brms9q2I
         q8fh/S6jE85Cw0cf+uV1MrTFDVJXLI3FwGXvRSpDsI9oNMr/UPUvNXXX4gd4DivQL5vI
         HVOfCHTXeMZ4A25QbzLSMjLE2nh1WDDIByXRUYBXDNQYCmXeC+ex/z8HZsEuFKigyYdc
         kNdVceB4dXqxbQjrdKjbKz5pTeAF8za6baGzp3RxikTvXZsTtyCPi3+nqZoA0dmC/ZJJ
         8VvbVOFC9uh4bUCf021k/vbXL8/40zxJmTv1lVZMmF3cBnAHNxrIdx3j3pJdM6BZ76Zh
         mAug==
X-Gm-Message-State: AJIora8mRIUbchF1oKXLuSwYLjAnoY+lJZjFf/H+fX1m/z/3y8Rl1SW8
        +4aH3NHOap3nGlfbHbLIKyA=
X-Google-Smtp-Source: AGRyM1vTcdnL+mv4xgwGoljun+ricETJIRKKHlIxUwZckSI+Q7oNOn3fqJfsc769rfCzEoAYnKiIRw==
X-Received: by 2002:a17:902:da87:b0:16a:54e1:3426 with SMTP id j7-20020a170902da8700b0016a54e13426mr16388696plx.157.1656629639274;
        Thu, 30 Jun 2022 15:53:59 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:4f4a])
        by smtp.gmail.com with ESMTPSA id 11-20020a63164b000000b0040d4c8e335csm13848116pgw.75.2022.06.30.15.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 15:53:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 1 Jul 2022 07:53:55 +0900
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
Message-ID: <Yr4pgxUTmg+UN35F@mtj.duckdns.org>
References: <YqYnQ4U4t6j/3UaL@slm.duckdns.org>
 <404171dc-0da3-21f2-5003-9718f875e967@redhat.com>
 <YqarMyNo9oHxhZFh@slm.duckdns.org>
 <20220613142452.GB6910@blackbody.suse.cz>
 <YqdzuSQuAeiPXQvy@slm.duckdns.org>
 <20220613175548.GB21665@blackbody.suse.cz>
 <Yqd7WMFj6AEyV3Cy@slm.duckdns.org>
 <20220614115345.GA6771@blackbody.suse.cz>
 <YroApRMPV/6zO5I8@mtj.duckdns.org>
 <20220630143211.GA22105@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220630143211.GA22105@blackbody.suse.cz>
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

On Thu, Jun 30, 2022 at 04:32:11PM +0200, Michal Koutný wrote:
> file				owner
> parent/				user (mkdir)
> `- cpuset.cpus			root
> `- cpuset.cpus.partition	root	(P)
> `- child_1/			user
>   ` cpuset.cpus			user	(*)
> `- child_2/			user
>   ` cpuset.cpus			user	(*)
> 
> The writes to child cpuset.cpus may/may not invalidate parent's (P)
> partition validity (whether a cpu is left to it to host possible tasks).
> child_1 vs child_2 overlap affects only whether the children cgroups are
> a valid partition.
> 
> I think you mean: writes to children cpuset.cpus should be allowed,
> possible exclusivity violation should be reported in
> parent/cpuset.cpus.partition.

I see.

> What I thought was OK: prevent (fail) writes to children cpuset.cpus
> that'd violate the exclusivity (or would take the last cpu from parent
> if it's necessary to host a task).
> IMO, it's similar to failed writes to parent/cgroup.subtree_control in a
> delegated subtree if the parent still has some tasks (that'd violate
> internal node constraint).
> 
> What I think might still be OK: allow writes to children cpuset.cpus
> that violate exclusivity and report that in children's
> cpuset.cpus.partition. Writes that'd take last cpu from parent should
> still fail (similar to the failing subtree_control writes above).

Yeah, this one.

So, here, one important question is who owns cpuset.cpus.partition
file - is it a konb which is owned by the parent like other resource
control knobs including cpuset.cpus or is it a knob which is owned by
the cgroup itself for selecting its own operation like cgroup.procs or
cgroup.subtree_control.

In the former case, the parent being able to say that "my children
can't overlap" makes sense although I'm not a big fan of the current
interface (again, who owns that knob?). In the latter case, it doesn't
really make sense cuz it'd be declaring "I can't make my children
overlap" - well, then, don't.

Thanks.

-- 
tejun
