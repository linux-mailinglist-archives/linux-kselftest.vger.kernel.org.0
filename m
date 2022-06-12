Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAFA547B4C
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Jun 2022 19:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbiFLRuC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Jun 2022 13:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbiFLRt6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Jun 2022 13:49:58 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A9D13F95;
        Sun, 12 Jun 2022 10:49:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso898450pjg.1;
        Sun, 12 Jun 2022 10:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cX/8ziMeK45ox+UcvZwAkANNXl3ViVJCTAY7BoIDC9g=;
        b=ZNHpDRCIVg04yWKFQl5Us2As61s+pXeR4lsY92xVrDkk6imXnuwyuIisMOGvIeIGxd
         UvUQVa4cGrHsfK+hrkzKtoYgoFEOSIxRsMURxjDSRjGACqfWn7/dvweFPJsMOkrPBRpR
         iA5XsNAId11fOFa4E2cR+sKI30/M/jtzbtHiYNrYgi9ZhzrWPAyQdnFgV5ZMdLVoLnwa
         FDDQgbhlu8/E64e1QdJtdDKu4xmWBiHVWN7oTvvkD7FBAGPnbKjZ77qy09wvbncWw1rH
         W4PWLjJkm1uMXK8esCcS1J5utUQ1jjSpSeAhAj8FyImJCUY97wQRjpr9Xw6bHfpGujvB
         h1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cX/8ziMeK45ox+UcvZwAkANNXl3ViVJCTAY7BoIDC9g=;
        b=w1eMr4vsA+26tf+t/6LsqkWw96dTgavHWtuGKUGxJPb+IUeSkGBax94OVZueTa34t3
         C7+rFSmGmnufwZVDi+2heQOHnCYvKcO7/O7ppsoVKZDGEkekjRL7zYiTr4E2wJ1HlSFM
         ap91lkBWztIXUdo+c5o40lVFSQvNeSbxhLFtiU7z9JtyjZG1KiSmaCL283Q877vT8+ON
         rjI5cSSVftl8mu5qGw7iZXYnIsxlewO5Yv48/nT0AsNivkZTewrsGs4BOP6diuXVGDW+
         Yb9pFd6vspCH6aQMCeUa4dJzLp5Ns+umn2kiN+uizeWM6vvqZ1q4dzYLaWgkaZV5FlI8
         xNrw==
X-Gm-Message-State: AOAM531z4L/iq6xhjIx84gsegpDt8GiBj+K7mMsmZftoVBDGRbrt4R3k
        rlKkS6JYMbsDSiHnrpyumRU=
X-Google-Smtp-Source: ABdhPJxe4U/h6/4hb1steSvpD1cv7v94zKtcqGJ9I3Q5qaJHTtMkECTh2aJT9D0ZtBy8Qxfk9gxLeg==
X-Received: by 2002:a17:90b:3e85:b0:1e8:8e0c:88de with SMTP id rj5-20020a17090b3e8500b001e88e0c88demr11290004pjb.151.1655056197208;
        Sun, 12 Jun 2022 10:49:57 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id w6-20020a639346000000b003fdc7e490a6sm3653286pgm.20.2022.06.12.10.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 10:49:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 12 Jun 2022 07:49:55 -1000
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
Message-ID: <YqYnQ4U4t6j/3UaL@slm.duckdns.org>
References: <20220510153413.400020-1-longman@redhat.com>
 <20220510153413.400020-8-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510153413.400020-8-longman@redhat.com>
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

On Tue, May 10, 2022 at 11:34:12AM -0400, Waiman Long wrote:
> +	External events like hotplug or changes to "cpuset.cpus" can
> +	cause a valid partition root to become invalid and vice versa.
> +	Note that a task cannot be moved to a cgroup with empty
> +	"cpuset.cpus.effective".
> +
> +	For a valid partition root or an invalid partition root with
> +	the exclusivity rule enabled, changes made to "cpuset.cpus"
> +	that violate the exclusivity rule will not be allowed.

My memory is failing but this is the same thing that we were discussing
before, right? The point was that the different behaviors re. system events
and config actions seemed unncessary and IIRC Michal was of the same opinion
(please correct me if I'm misremembering).

> +	A valid non-root parent partition may distribute out all its CPUs
> +	to its child partitions when there is no task associated with it.

I'm probably forgetting something. Was this necessary because of threaded
cgroup support because otherwise the above condition is superflous?

Thanks.

-- 
tejun
