Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858343AA58E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jun 2021 22:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhFPUtt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Jun 2021 16:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbhFPUtt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Jun 2021 16:49:49 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF28FC061574;
        Wed, 16 Jun 2021 13:47:42 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id f70so853015qke.13;
        Wed, 16 Jun 2021 13:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hsHB5m77MIVRrUwCHcRGhZDai+vzsMMYW8wAwWykDx0=;
        b=CeHzZu1qNvVzLHiwRr09PcbJ2FXOFkn3h4H4zk5Lr4sOgvjZTBM1CbbnsmSyjAgpcd
         HIYQNcZdYumMOPW7O5/hMqw6lqFgw57+yAL7bm2+CXXEQszbcZSdOQ2qhHB4wC0f7iv9
         Zh2hOG3W6RF8Lw8MCCoQQfi/VYZOMbhTwpMDxVp/hhqaILJnn96p/AULQOeyibkUQfwg
         QyS5MfUD/H6vyfOFJHvQRWNxfZEdq5nT4XPhsQ7PGmQALBer36I0gtBtaCyg8pnfv4Z6
         O4J7sl4DtmofagCfny86mI1bvuutN1bmqWA7/KXBzvWNBnQu4DCrYIV8w74+iVBWe5QZ
         fdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=hsHB5m77MIVRrUwCHcRGhZDai+vzsMMYW8wAwWykDx0=;
        b=DcaMOOsXXngZVEwzEF10GcMISeN7d0riNrDIFUNy/JNiHMtdAslGO6uwg8kh0q7L8K
         fa3tdQRdvaKFrivVH4sD2XF9qyjhbFTta7AvYhzizE436d7b3jAIMxBmtGmxcTTUN/RJ
         KD6V6Am3eEmrXmX0r5IFGC4i0eu6Q+C2uTAJ9cSm2zu5Tlvy0Qu2Vnx9kROZE7rKmV72
         MSRS0m51+AZ96tQoH5iSNMGkCjLhWyTstVRorhJVTTZ6nsMGTeo5UNHCpBXSrdkEq6BI
         WxTTa07Fmtgif8EMBg2Cd9xamC97kFK34t8xlGhu60xDYUCR2FeY8yeZNOjZSM/M20Jo
         q/Zw==
X-Gm-Message-State: AOAM533BQSSYXp2nXDAITGxGLdhmCyrPhZKPIUZmh1b8qfocka6s95gC
        /jJFM5ONFF9qnA5F1NIyJLmpBJ7aHbxtfw==
X-Google-Smtp-Source: ABdhPJw+685aFCRA1rly0WpaManCHavhY0sH+eDHQwYOJrI81s/7oP9RN6MJfpOFw+wC8Qm5YVIcRg==
X-Received: by 2002:ae9:efd5:: with SMTP id d204mr220095qkg.415.1623876461964;
        Wed, 16 Jun 2021 13:47:41 -0700 (PDT)
Received: from localhost ([199.192.137.73])
        by smtp.gmail.com with ESMTPSA id a5sm306072qkd.93.2021.06.16.13.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 13:47:41 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 16 Jun 2021 16:47:40 -0400
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
Subject: Re: [PATCH 2/5] cgroup/cpuset: Add new cpus.partition type with no
 load balancing
Message-ID: <YMpjbCWpSDIz4bHt@slm.duckdns.org>
References: <20210603212416.25934-1-longman@redhat.com>
 <20210603212416.25934-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603212416.25934-3-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

Generally looks fine to me.

On Thu, Jun 03, 2021 at 05:24:13PM -0400, Waiman Long wrote:
> @@ -1984,12 +1987,31 @@ static int update_prstate(struct cpuset *cs, int val)
>  			goto out;
>  
>  		err = update_parent_subparts_cpumask(cs, partcmd_enable,
> -						     NULL, &tmp);
> +						     NULL, &tmpmask);
> +
>  		if (err) {
>  			update_flag(CS_CPU_EXCLUSIVE, cs, 0);
>  			goto out;
> +		} else if (new_prs == PRS_ENABLED_NOLB) {
> +			/*
> +			 * Disable the load balance flag should not return an

                                 ^ing

and "else if" after "if (err) goto out" block is weird. The two conditions
don't need to be tied together.

> @@ -2518,6 +2547,9 @@ static int sched_partition_show(struct seq_file *seq, void *v)
>  	case PRS_ENABLED:
>  		seq_puts(seq, "root\n");
>  		break;
> +	case PRS_ENABLED_NOLB:
> +		seq_puts(seq, "root-nolb\n");
> +		break;
>  	case PRS_DISABLED:
>  		seq_puts(seq, "member\n");
>  		break;
> @@ -2544,6 +2576,8 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
>  		val = PRS_ENABLED;
>  	else if (!strcmp(buf, "member"))
>  		val = PRS_DISABLED;
> +	else if (!strcmp(buf, "root-nolb"))
> +		val = PRS_ENABLED_NOLB;
>  	else
>  		return -EINVAL;

I wonder whether there's a better name than "root-nolb" because nolb isn't
the most readable and we are using space as the delimiter for other names.
Would something like "isolated" work?

Thanks.

-- 
tejun
