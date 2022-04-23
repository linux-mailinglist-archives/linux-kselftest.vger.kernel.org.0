Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AE550CAA2
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Apr 2022 15:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiDWNdh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 23 Apr 2022 09:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbiDWNdg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 23 Apr 2022 09:33:36 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1943AA58
        for <linux-kselftest@vger.kernel.org>; Sat, 23 Apr 2022 06:30:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2e644c76556so93166917b3.15
        for <linux-kselftest@vger.kernel.org>; Sat, 23 Apr 2022 06:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Aem2PdHshEukZ4FbitCFbjtHLa6kiNwj57G3fxoNlVk=;
        b=XMNhXPfkwDK4e/banSthnWhXs9a5a1aYvMVU0NMfybXNvVEmGdmNtMSK5oZ++QlHWR
         V3ufPwN5hRsYkM5z7ddo0Hd5/C0+X86gdeDg/EcbOv27ChnnE88NajcxBj4l6hUotTKL
         6tfKwnl6G2aAPMEmhO1Yt7R0ge16i+pGXVJ2xPTzPY66OOpXaSAgdxQEYnybzB9GAExs
         VtlV4OYLzO1vWnYGB9iH8I6VOegPQXleK6VLBFgcWRkY7enBxEw+MDSDLoh5bF3WVyfH
         FqpESvZE7ugxZsVz8I+JwrKaWP6J3N54HEMtZksvV6fAOOhKYCeurqhF2C19tTrZ6OiL
         0y0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Aem2PdHshEukZ4FbitCFbjtHLa6kiNwj57G3fxoNlVk=;
        b=P2BHoShUsXzQEZyAE9csxE+HQZrRC7lSCnnNODD5tc1tmfF8SoqeYhuSu6WX8taUSi
         Yr/w7AsnFUNpTa3hkLAW2NZYKdCGzdnPRq/1/uyN70GHEwJEt5o5XV4v66wh/cszHsPA
         gnjIMoxUFRF2Fsove8XtUk3Zqu/k23q6ZZ268EXCia2S+xnx1Tq3WgJEzqYhFWeK8HJ/
         HymvKf7aWjRmaEqK17vZdTkF5j1eCeR9c3GRBzcPJWY3WCtiWYqAhXnUKIVSGp0FxZsY
         6mJ5yMaPbfOt7bUCp/4zdOR5T01Molcw36pOwzj2j+fvVy3pOJrf97L1QDzMGG4Ml+Pi
         Cunw==
X-Gm-Message-State: AOAM532CX/Ezwlqos3KKtIu+/I9O2MfKWzHixyQLR0XS8oDzMG2iBZuq
        rNkzF6e0Ohuy2peRo2lLyShnwH7JeF7TRg==
X-Google-Smtp-Source: ABdhPJx7g+b3t+7TTJeJC7GYl+CeuU3UNtFktcnoCl3pUuWnyLkIOPvBkq8XTsd2INy154YtYRsMI9zJBpyJaA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a05:6902:1349:b0:645:d63b:2751 with SMTP
 id g9-20020a056902134900b00645d63b2751mr6582268ybu.165.1650720637980; Sat, 23
 Apr 2022 06:30:37 -0700 (PDT)
Date:   Sat, 23 Apr 2022 13:30:35 +0000
In-Reply-To: <20220421234426.3494842-2-yosryahmed@google.com>
Message-Id: <20220423133035.b6iz6vzhzlym3m4w@google.com>
Mime-Version: 1.0
References: <20220421234426.3494842-1-yosryahmed@google.com> <20220421234426.3494842-2-yosryahmed@google.com>
Subject: Re: [PATCH v4 1/4] memcg: introduce per-memcg reclaim interface
From:   Shakeel Butt <shakeelb@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 21, 2022 at 11:44:23PM +0000, Yosry Ahmed wrote:
> From: Shakeel Butt <shakeelb@google.com>
[...]
> 
> [yosryahmed@google.com: refreshed to current master, updated commit
> message based on recent discussions and use cases]
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

You should add "Co-developed-by" tag for yourself here.

> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Wei Xu <weixugc@google.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  
[...]
> +static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> +			      size_t nbytes, loff_t off)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> +	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> +	unsigned long nr_to_reclaim, nr_reclaimed = 0;
> +	int err;
> +
> +	buf = strstrip(buf);
> +	err = page_counter_memparse(buf, "", &nr_to_reclaim);
> +	if (err)
> +		return err;
> +
> +	while (nr_reclaimed < nr_to_reclaim) {
> +		unsigned long reclaimed;
> +
> +		if (signal_pending(current))
> +			return -EINTR;
> +
> +		/* This is the final attempt, drain percpu lru caches in the

Fix the comment format. "/*" should be on its own line.

> +		 * hope of introducing more evictable pages for
> +		 * try_to_free_mem_cgroup_pages().
> +		 */

No need to send a new version if Andrew can fix these in the mm tree.
