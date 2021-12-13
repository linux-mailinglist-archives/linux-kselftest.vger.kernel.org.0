Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3CA473639
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Dec 2021 21:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242356AbhLMUph (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Dec 2021 15:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbhLMUpg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Dec 2021 15:45:36 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235D1C061574;
        Mon, 13 Dec 2021 12:45:36 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b11so12015002pld.12;
        Mon, 13 Dec 2021 12:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+kGkjmCClJZHQUuipZquM0wxRHxRZ1CYDc4rEqsGfmo=;
        b=Dc24nUO7obHKfEHi+3eu4hhPs6pC5ekbvfg6/fWWuMendLFNP/aD3vLwBMsHt2VawN
         65DTUGFRXitGu39c94BMAfKQsI8UfXTySofOZ9aBfUJoCQ9p7VFDtSa15skRYg7omKr5
         KdjwUjY8khI+bAkd1TXtrpsH4ElcQnOCyRGAJ3dzrakcKEw34dsnGuUSxxDFeLak/iq8
         IlvW99cvvRUK7Ok1QKBqJuceEQliZ/A3W1EJEpQYq5lxAljWkERflfsUEhAysxqJMY54
         /zwdsdRHMRP45MEbZ/kXiGH03I5m2CLNYauI4avPu3xs9iECZgOtDZxfKxkl039E39XL
         eLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+kGkjmCClJZHQUuipZquM0wxRHxRZ1CYDc4rEqsGfmo=;
        b=meyl3JoZQNULpNL/Vtmc9ERSTrvHMTOlCLD2CcbwWIRQEZ1V9hERTCF0+RbdstMZm3
         5Tbw/yTM3ykWawlDrO5+o9VdNcQDoi7FtAkY+wiCJUVQF1dhcddw1KOFU/3dqrfgFdM4
         CnwwCzIqIeWCLuDscMs3jl+a5R/A4OW1ofmwRBYxptQZ1/JAkoSAA0XQQpm5DbJS4hbg
         jV7cM9xB/gQH8sUaSMzUgfw0tT3PE7V7Dm9eG95FSrsskuDDqQtpcSOmOFCvX9/0Bshn
         vAKK4r6KMn0nrUJ+AnEECs2jr6J44HgBt3U+7YWK8WX5HtmpCXPNl0oaFqfa/ho/vuvt
         NkLQ==
X-Gm-Message-State: AOAM533gHo+jKrPIblLC6dNDS0bEwSatiAmdvt3d2j9+c3XmC+vWiYUt
        oCTZXSczMgAN8HbUC5fsbAU=
X-Google-Smtp-Source: ABdhPJw9GayFUyCxKUmosgEbKO7MgPcj9+3Aq5Ipt6SL1z0lwWdIaqqlLpt5puwnDyVjjNQgx7Zr5Q==
X-Received: by 2002:a17:90b:4b09:: with SMTP id lx9mr739899pjb.100.1639428335323;
        Mon, 13 Dec 2021 12:45:35 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id f185sm13272776pfg.39.2021.12.13.12.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:45:34 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Dec 2021 10:45:33 -1000
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
Subject: Re: [PATCH v9 2/7] cgroup/cpuset: Allow no-task partition to have
 empty cpuset.cpus.effective
Message-ID: <Ybew7d2oE2gLcLNO@slm.duckdns.org>
References: <20211205183220.818872-1-longman@redhat.com>
 <20211205183220.818872-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205183220.818872-3-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Dec 05, 2021 at 01:32:15PM -0500, Waiman Long wrote:
>  	adding = deleting = false;
>  	old_prs = new_prs = cpuset->partition_root_state;
>  	if (cmd == partcmd_enable) {
> +		/*
> +		 * Enabling partition root is not allowed if not all the CPUs
> +		 * can be granted from parent's effective_cpus.
> +		 */
> +		if (!cpumask_subset(cpuset->cpus_allowed, parent->effective_cpus))
> +			return -EINVAL;
> +
> +		/*
> +		 * A parent can be left with no CPU as long as there is no
> +		 * task directly associated with the parent partition. For
> +		 * such a parent, no new task can be moved into it.
> +		 */
> +		if (partition_is_populated(parent, cpuset) &&
> +		    cpumask_equal(cpuset->cpus_allowed, parent->effective_cpus))
> +			return -EINVAL;

So, given that this only happens with threaded domains, can we just not
allow partitions within threaded domains? The combination doesn't make whole
lot of sense to me anyway.

> +	/*
> +	 * On default hierarchy, task cannot be moved to a cpuset with empty
> +	 * effective cpus.
> +	 */
> +	if (is_in_v2_mode() && cpumask_empty(cs->effective_cpus))
> +		goto out_unlock;

And then we can avoid this extra restriction too, right?

Thanks.

-- 
tejun
