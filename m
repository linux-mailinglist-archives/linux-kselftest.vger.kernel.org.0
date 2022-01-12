Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7A648CDB9
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jan 2022 22:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiALVXq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jan 2022 16:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiALVXl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jan 2022 16:23:41 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B24AC061756;
        Wed, 12 Jan 2022 13:23:41 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id pf13so7721119pjb.0;
        Wed, 12 Jan 2022 13:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=joW7LRyJxGU+ls3GDExQALSF8Ajn8PPvcP34cp5s5X8=;
        b=AdyXG9XI9slk2xLabffbB7kjFOKzRJMJTMAGCvwXu48pDzBggUTt0o3eO/hAcVCXtd
         p/Y1IgkWZ2FRoLx6EkgKcAAk7LFaeTGnNLq8TipYkngOeSOLrsPxoPCx5cMUMGakQxBw
         GqeQnKVGrpzeNrzEuSOuzgzCdxT4ncFxjS8BaZl9wb4MJyXnWcR0YqeSiXbxkwlnTSHB
         fVgDmk2Os6dZor4FJaLs/UpXlZof3KgvtyBNwa+d/2tftO5OJmz5mzAOnDE5obSm2vbU
         Nv/GbGdmatRVy2iXezqSL8kahPc5KR3T56uHfwJUro8mi4x+i9fsKPzczZTkYipP9ovc
         waMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=joW7LRyJxGU+ls3GDExQALSF8Ajn8PPvcP34cp5s5X8=;
        b=RUTKk/2wd35jBhxPL9QJbOJ9kkob+bsmGeqe0OUAk4aKXPHoM6Fk4DsKdZU/8jAV/v
         f+8utyrKiZ6HtSw5cogJ6T25NeZLj+3ZoxuVJn2h/EOipV/B3dc4S7OQBGvpgCTkQE0q
         1K+Nb60cl/0DW3blesMuWfurQd4NyTJ7aVua3Ph18GIOSKlWYjaMsTDVVqaUR967oGdt
         ROcu0R3/Xe22rzqek9X1DoJ4go0tL20+V8Rh1yV3adGZUUln2dHh4sbMkxSoA/Hmc9ox
         4NsIOUbDDAnZ/ZQStRF4a55MF8JwWmi7uhxOwv7h6Ki6keBRSFW1FiyheDDwwviXEYSF
         XuhQ==
X-Gm-Message-State: AOAM530/7DrhwQU0w8fFpoMq31Uwjmc1kGJ0sI2D+snz845eU2b1YfrA
        AhgzJR1G6h+McDeUkf5QilM=
X-Google-Smtp-Source: ABdhPJwhDy7ijJT6+Rg9hLNDsv9V+TeE0bosq0apnwgqBwJe6vUtOZp9fhaD9YHLC9OTWlpi93ReHg==
X-Received: by 2002:a17:902:7102:b0:149:af86:c1f4 with SMTP id a2-20020a170902710200b00149af86c1f4mr1278973pll.19.1642022620787;
        Wed, 12 Jan 2022 13:23:40 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id y9sm481525pfm.140.2022.01.12.13.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 13:23:40 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Jan 2022 11:23:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH v9 4/7] cgroup/cpuset: Add a new isolated cpus.partition
 type
Message-ID: <Yd9G27Jhn6XpCArg@slm.duckdns.org>
References: <20211205183220.818872-1-longman@redhat.com>
 <20211205183220.818872-5-longman@redhat.com>
 <Yd7x3P+wGCVfYtza@hirez.programming.kicks-ass.net>
 <0cf37ac0-69c7-2da4-22a6-58e78dc35cef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cf37ac0-69c7-2da4-22a6-58e78dc35cef@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 12, 2022 at 10:40:01AM -0500, Waiman Long wrote:
> Yes, that is a possible workaround. However, it makes cgroup management much
> harder especially in the cgroup v2 environment where multiple controllers
> are likely to be enabled in the same cgroup.

In most cases, cgroup2 shouldn't be a problem here given that controllers
can be enabled selectively and this 1-cpu cgroups will most likely be
leaves. But yeah, not super convenient.

Thanks.

-- 
tejun
