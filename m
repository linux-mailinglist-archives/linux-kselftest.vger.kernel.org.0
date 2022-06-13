Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96850549DD4
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jun 2022 21:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344411AbiFMThk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jun 2022 15:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241414AbiFMThU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jun 2022 15:37:20 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C89369CF0;
        Mon, 13 Jun 2022 11:00:59 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 15so6419932pfy.3;
        Mon, 13 Jun 2022 11:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jM/lvPuhC14LsEb9ZlEVVzCAu03nvQX/OUwWLzY69FM=;
        b=RYsqMVjNGft/mA4IooAZRbob/vH4Mo9pz2WNFRyPqpKB7ZI7v1N453mnVzkf2rwPf1
         2DsXUtAIOlbcJLG3RIesO2Cdl6+9dakwiWAYxMykcvkwKXxD2WESsQkWF+1tQYobZWhk
         k4A5cBm4QluwxzMC9yB+NGTJm+pGk1ifFlSqDfI+Nrc66JDGkXlKEWLsX3IbUIMsiBii
         uv55sk99KqDJPXyni0G8/7szT3++WIpQUjJPWsSMB182M/JK5oeX9kXYbLI8LD0qJB1n
         eusYcktRqkfvzZvIuxjXerxetX1ofNtrhkAYkRsKWPYwOEROIbU39S1v7uNxwOoVg8Zx
         GhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=jM/lvPuhC14LsEb9ZlEVVzCAu03nvQX/OUwWLzY69FM=;
        b=zZ9jgZWWRoawinuCLRu9Dxn0H/CdBjfJwbx/CoGM16pjTe84glaoustppoPr0BJSuG
         Th28WK/fRl0C3x7VF0b4MqgsMTxMi9OLJviBj5hFomGt/P/3HLDcIslx0iIVVupiLQcx
         TwFnRB8RLkXL+hvCrBEyiZOxqIPryc1l8q52nPBe4RfrStY55g7L384mUy/AAq7fMohw
         Z6hx+UcMUylXTiMsl87RwgEMy5CiEBuknz8XcYYJ/yc58WrLtEPTy7Lo1I/xlL2Vkw9X
         LvZ1kQ7q7MAOHdT7y3Id2WQ8kg4nz/sShtyn/XKBoogPQ2v9sadknWEeU9Q7z5S5Dp6Z
         wL3g==
X-Gm-Message-State: AOAM532uOC5O248vZ1Ra7J49twFE/iY23ryV26zlabDYekLfUmTmXC+z
        /yatT9wZOz+k8i5W9d0asEA=
X-Google-Smtp-Source: ABdhPJzerRW5ZLwEcw3NkTOtUV9s/7qCL1sJwajuU3wrEwAlOqfrERwaZSOCvxbElHBNWiAPADzfaw==
X-Received: by 2002:a63:5b42:0:b0:408:8710:13b0 with SMTP id l2-20020a635b42000000b00408871013b0mr710348pgm.584.1655143258429;
        Mon, 13 Jun 2022 11:00:58 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:b964])
        by smtp.gmail.com with ESMTPSA id q18-20020a63bc12000000b004088f213f68sm1802955pge.56.2022.06.13.11.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 11:00:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Jun 2022 08:00:56 -1000
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
Message-ID: <Yqd7WMFj6AEyV3Cy@slm.duckdns.org>
References: <20220510153413.400020-1-longman@redhat.com>
 <20220510153413.400020-8-longman@redhat.com>
 <YqYnQ4U4t6j/3UaL@slm.duckdns.org>
 <404171dc-0da3-21f2-5003-9718f875e967@redhat.com>
 <YqarMyNo9oHxhZFh@slm.duckdns.org>
 <20220613142452.GB6910@blackbody.suse.cz>
 <YqdzuSQuAeiPXQvy@slm.duckdns.org>
 <20220613175548.GB21665@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220613175548.GB21665@blackbody.suse.cz>
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

On Mon, Jun 13, 2022 at 07:55:49PM +0200, Michal Koutný wrote:
> On Mon, Jun 13, 2022 at 07:28:25AM -1000, Tejun Heo <tj@kernel.org> wrote:
> > I see. Is this part even necessary? All the .cpus files of the siblings are
> > owned by the parent who's responsible for configuring both the mode that the
> > cgroup subtree is gonna be in and their cpumasks. 
> 
> Do you mean such an example:
> 
>     parent	cpuset.cpus=SET (root)	cpuset.cpus.partition=isolated 
>     `- child_1	cpuset.cpus=partition_of(SET) (root)	cpuset.cpus.partition=isolated
>     `- ...
>     `- child_n	cpuset.cpus=partition_of(SET) (root)	cpuset.cpus.partition=isolated
> ?
> 
> I don't think child_*/cpuset.cpus must be owned by root.

I meant the parent.

> Actually, the root would only configure the parent, i.e.
> parent/cpuset.cpus (whose changes would be disallowed to the
> unprivileged tasks) and the distribution among siblings would up to the
> whatever runs below.
> 
> > Given that all the other errors it can make are notified through
> > "invalid (REASON)" in the mode file, wouldn't it fit better to notify
> > cpus configuration error the same way too?
> 
> Do you suggest that a write into child_*/cpuset.cpus that'd not be
> exclusive wrt a sibling would result in an error string in
> parent/cpuset.cpus.partition?

Yeah, I don't know why this part is different from any other errors that the
parent can make.

Thanks.

-- 
tejun
