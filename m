Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7B67CD7DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 11:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjJRJYf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 05:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjJRJYd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 05:24:33 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEA1FD;
        Wed, 18 Oct 2023 02:24:32 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so5062178b3a.2;
        Wed, 18 Oct 2023 02:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697621071; x=1698225871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNODfCJOfjqEYgALnWtSMFHwQkcZjrciucUthP4q5zM=;
        b=EPTayhges6SubgIe2UQDVS+32aO3vGkKFe8kbYt7WgY5hcH5IN/IBe/xetyAZOouIf
         LlNPKD+MK9kw0S1G9cJ46hqP5ipBjihPkUBJpN2h+tbZEZ0V6MIV3sY+bFu7VOcXgreS
         IEee3cTr0iXdPN8+GmJUXgkwuCG3P05MGw4+vBL9al7KKq3AFkwSMQrO2cX2/Jk2Y+CE
         mO1ehOBR0Fov9pdAkkmrnoZEY1+LqyCH/cho/jihaKRnRtl2iBKGU+2kNuevdoiB/s7N
         1RAAdxgwIlbRZjJV2utvoYfz9HtlGmncc/Lli+GPOHffEiZrOW2LyRnuqHlN+MQIEK3P
         uriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697621071; x=1698225871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNODfCJOfjqEYgALnWtSMFHwQkcZjrciucUthP4q5zM=;
        b=gmPPd5L32wREBlfvqCWqx2hUcUS07EvK7InIZKtmWAAzN7nrHQXnnylzuz/tMJfhSG
         NhzhK0rLiE4GGsReWVqjeV4j2M57jCA9fW/Zc8tYpwFarzyTw4RdUw3sIB9BRM9jyhzj
         5JWJaXbN9P5dfmKPTVa54uuOAj2n7r/ptPeDvee7e47cQG+tv9oPeVVSDWCiBAHYIJDI
         su5/VmNrpP2c91NSnyWS+vhJTPn02Ni8TcEapWccFqlZAYPTTn2PUoUrsVernBw1s8wi
         5leIY77do2xS085li/KKnMXFLj3Wa6ae8R1gro0z7Ej10XZu5t7o+ylItPoWVuLzqAmq
         1aeA==
X-Gm-Message-State: AOJu0Yw2u5JyP5V//GH0hPovQW7y6+SVdTs0wY0oL8UcVeAjwkH8Rkj2
        IHwesTqlm6R/Yj3lfQ9bVsw=
X-Google-Smtp-Source: AGHT+IHMtkomy48m2lIkAxF4mw34c4FzfowG/XQaP/plDDeQIwFErlB+vSFZKCbh1uGV3u+wOayZ5g==
X-Received: by 2002:a05:6a00:218f:b0:68a:54e5:24e6 with SMTP id h15-20020a056a00218f00b0068a54e524e6mr5142412pfi.8.1697621071197;
        Wed, 18 Oct 2023 02:24:31 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id n8-20020aa79848000000b00689f5940061sm2945737pfq.17.2023.10.18.02.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 02:24:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 17 Oct 2023 23:24:29 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH-cgroup 1/4] workqueue: Add
 workqueue_unbound_exclude_cpumask() to exclude CPUs from wq_unbound_cpumask
Message-ID: <ZS-kTXgSZoc985ul@slm.duckdns.org>
References: <20231013181122.3518610-1-longman@redhat.com>
 <20231013181122.3518610-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013181122.3518610-2-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Fri, Oct 13, 2023 at 02:11:19PM -0400, Waiman Long wrote:
> When the "isolcpus" boot command line option is used to add a set
> of isolated CPUs, those CPUs will be excluded automatically from
> wq_unbound_cpumask to avoid running work functions from unbound
> workqueues.
> 
> Recently cpuset has been extended to allow the creation of partitions
> of isolated CPUs dynamically. To make it closer to the "isolcpus"
> in functionality, the CPUs in those isolated cpuset partitions should be
> excluded from wq_unbound_cpumask as well. This can be done currently by
> explicitly writing to the workqueue's cpumask sysfs file after creating
> the isolated partitions. However, this process can be error prone.
> Ideally, the cpuset code should be allowed to request the workqueue code
> to exclude those isolated CPUs from wq_unbound_cpumask so that this
> operation can be done automatically and the isolated CPUs will be returned
> back to wq_unbound_cpumask after the destructions of the isolated
> cpuset partitions.
> 
> This patch adds a new workqueue_unbound_exclude_cpumask() to enable
> that. This new function will exclude the specified isolated CPUs
> from wq_unbound_cpumask. To be able to restore those isolated CPUs
> back after the destruction of isolated cpuset partitions, a new
> wq_user_unbound_cpumask is added to store the user provided unbound
> cpumask either from the boot command line options or from writing to
> the cpumask sysfs file. This new cpumask provides the basis for CPU
> exclusion.

The behaviors around wq_unbound_cpumask is getting pretty inconsistent:

1. Housekeeping excludes isolated CPUs on boot but allows user to override
   it to include isolated CPUs afterwards.

2. If an unbound wq's cpumask doesn't have any intersection with
   wq_unbound_cpumask we ignore the per-wq cpumask and falls back to
   wq_unbound_cpumask.

3. You're adding a masking layer on top with exclude which fails to set if
   the intersection is empty.

Can we do the followings for consistency?

1. User's requested_unbound_cpumask is stored separately (as in this patch).

2. The effect wq_unbound_cpumask is determined by requested_unbound_cpumask
   & housekeeping_cpumask & cpuset_allowed_cpumask. The operation order
   matters. When an & operation yields an cpumask, the cpumask from the
   previous step is the effective one.

3. Expose these cpumasks in sysfs so that what's happening is obvious.

> +int workqueue_unbound_exclude_cpumask(cpumask_var_t exclude_cpumask)
> +{
> +	cpumask_var_t cpumask;
> +	int ret = 0;
> +
> +	if (!zalloc_cpumask_var(&cpumask, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	/*
> +	 * The caller of this function may have called cpus_read_lock(),
> +	 * use cpus_read_trylock() to avoid potential deadlock.
> +	 */
> +	if (!cpus_read_trylock())
> +		return -EBUSY;

This means that a completely unrelated cpus_write_lock() can fail this
operation and thus cpuset config writes. Let's please not do this. Can't we
just make sure that the caller holds the lock?

> +	mutex_lock(&wq_pool_mutex);
> +
> +	if (!cpumask_andnot(cpumask, wq_user_unbound_cpumask, exclude_cpumask))
> +		ret = -EINVAL;	/* The new cpumask can't be empty */

For better or worse, the usual mode-of-failure for "no usable CPU" is just
falling back to something which works rather than failing the operation.
Let's follow that.

Thanks.

-- 
tejun
