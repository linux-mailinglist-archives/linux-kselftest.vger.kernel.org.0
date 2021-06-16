Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998153AA5C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jun 2021 22:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbhFPU76 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Jun 2021 16:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbhFPU76 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Jun 2021 16:59:58 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188ADC061574;
        Wed, 16 Jun 2021 13:57:51 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id u20so3043347qtx.1;
        Wed, 16 Jun 2021 13:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0iilFTHgmXaTXAf6PQ61qLrXDecfzvIQCA1PI6ZGIUk=;
        b=oyRewv+gWuxpGQqbIhsiFhNSMFx6Xkb/xzs5BOkb6l2nIp9JNBfojd/BzYFbariNjU
         VrAVVfRYwnapm+gqPr9j190GX/pRQrtENyn+vfWbzcuC/H+E4DuhyU25h2vW0cfZFsmO
         C+5XADaN8bc1nLLsL+rmeWvciuy42OJwFRC9cKoPDgRfF55b4v51bi7tivO3FyFRqvhJ
         EpfIhumP5stdswSGz6ZQcou99fKE6MAqohAMMDUJMlslhnAZZnihoSYx34VcBPB/dKf6
         BzGvgnP7+BujnS2mL/lHYx6axjpjgFjXX7UEB9Ur4M0YsellXNx1AvuKz/pDjscG7wyu
         Reyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0iilFTHgmXaTXAf6PQ61qLrXDecfzvIQCA1PI6ZGIUk=;
        b=aKz8XMft8YTkaQLPanRRnRTfYvpUoaaNHEoccePH/YndBVSySPi7Do1QnuKpC2zJH2
         XHXEHfV6u/giKBiVcPsC6fz7T6nJifHCfBUfymzhlOUZGRdvQAvEGIC9f5XdhiYYH6HL
         4H5dyiZqub6TLukSOLNSQTG3H9yxbz+kpkplXHXOViJCE/Zd0hcgmc119NQe2fvdf/4J
         ZJohV1+LMeHCjcSY0/qp2d9+PmHPA2iLhRxc5SOBKbNwj8OLYgVMAoNtthervCm6aMdz
         bXiBo8Bfaz6E95HbLSBT3YR2ZYfHJl0Ztz77XGp0mt/1ilaG0tj5/+0hPdwEJv/FZMSx
         /VoA==
X-Gm-Message-State: AOAM530KxQDBO/WttkZfCBMLpP6sbNxA9s83AUTJveXGm/+xDcIlgBKp
        4JSSRD+SKj1ScvAQ72vt4Ck=
X-Google-Smtp-Source: ABdhPJz91zoIoDlN1Hg7r1LlZ/SPcwrLhUJ1/5TZnr7SE6bXr14GfG9kzeOXitdJ+oY4z5xqxHuX0g==
X-Received: by 2002:ac8:dc9:: with SMTP id t9mr1694199qti.293.1623877069261;
        Wed, 16 Jun 2021 13:57:49 -0700 (PDT)
Received: from localhost ([199.192.137.73])
        by smtp.gmail.com with ESMTPSA id p199sm294606qka.128.2021.06.16.13.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 13:57:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 16 Jun 2021 16:57:48 -0400
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
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 3/5] cgroup/cpuset: Allow non-top parent partition root
 to distribute out all CPUs
Message-ID: <YMplzNzg7mMCU4JJ@slm.duckdns.org>
References: <20210603212416.25934-1-longman@redhat.com>
 <20210603212416.25934-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603212416.25934-4-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Thu, Jun 03, 2021 at 05:24:14PM -0400, Waiman Long wrote:
> @@ -2181,6 +2192,13 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>  	    (cpumask_empty(cs->cpus_allowed) || nodes_empty(cs->mems_allowed)))
>  		goto out_unlock;
>  
> +	/*
> +	 * On default hierarchy, task cannot be moved to a cpuset with empty
> +	 * effective cpus.
> +	 */
> +	if (is_in_v2_mode() && cpumask_empty(cs->effective_cpus))
> +		goto out_unlock;
> +

This is inconsistent with how other events which leave a root partition
empty is handled. Woudln't it be more consistent to switch the parent to
PRS_ERROR and behave accordingly but allow it to have valid child roots?

Thanks.

-- 
tejun
