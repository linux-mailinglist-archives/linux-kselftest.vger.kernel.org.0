Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1963D69DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jul 2021 01:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhGZWTf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jul 2021 18:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhGZWTc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jul 2021 18:19:32 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF180C061757;
        Mon, 26 Jul 2021 15:59:59 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id i10so10422413pla.3;
        Mon, 26 Jul 2021 15:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IgP1YWplDp3/09cvQQ0d2eAW1JPxMRhx9Jd4cef5V3E=;
        b=eQAl1RXPI6I/QPb5dmHK3sSJfrW/33/Xd+Kq+ZHhRC+jWg/KgNZOApZ/JQhK/b4tcM
         f1qBS4uW84HHhnxyahQnwsnOk6TeV1HVmF0yO6oZ898KgpEahR5N+sdrg+X1+VfFCl0K
         qwC+oGx/hc4Ck8IVbvOMLHUMwUeIXgYaFT+Oj+zLZblC7w0Y6qY1rgcMgZq4uzSLRKTW
         +awoE5DdCCWXlu137dLx92EfC9UDM3iU0vEUXbRGBxKjwCmO1pt/lsISLS2SSKvf5sYx
         0I3neM8nIcFOXM3f1BOqwuSINJnC+K0ue18tjWWsOWYzDdX7vRJXkfsSFZ4ZrwcVQgCb
         1iwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=IgP1YWplDp3/09cvQQ0d2eAW1JPxMRhx9Jd4cef5V3E=;
        b=Qgh963A+bS1UjCsI6OktP/9yPMPEQTDLyiqjkU3hmHeqLiBzX/iEaLluk5N8vAaHDl
         9ZVlKqpOz5NHC/wu7ojSVHq1YCweO2weqWbLU/taavDeYIixl/yFAJhmYb/8MSv6ZEeJ
         7sZOiq19tGDQiCxZ1fqhdsobV2sHbncILU3YT1kk/w70RQRneHFKWN4vACd1mrmMxpun
         TSR32q0iF5x68z6ctuAvsSkpwkZV/EpvgJ2671MeDRPwxLz90bC9e1I1L7nwU112LoG2
         4a5IzzAkaFf/RfRgcMq73WWZSPr15SCnwEWT8U2JdYTXwHrtjjUz36jiBBfhQrvmcSR2
         AisQ==
X-Gm-Message-State: AOAM532WB6vNHxrDaXTK5QwKndkwxyGcU3Nw04lrnYs6EmkO3DFfnpms
        uVFkU6cFC888IRLbr1pO590=
X-Google-Smtp-Source: ABdhPJwW8ATQZ6+Bf0S14txqUH98V65/ygNpd2J5d3lf04ZO1JKEUx+F6lWKfQhfzUPrM3K3PBl2Ug==
X-Received: by 2002:a63:1755:: with SMTP id 21mr20445764pgx.435.1627340399214;
        Mon, 26 Jul 2021 15:59:59 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:428])
        by smtp.gmail.com with ESMTPSA id a22sm1046354pfv.113.2021.07.26.15.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 15:59:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Jul 2021 12:59:54 -1000
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
Subject: Re: [PATCH v3 2/9] cgroup/cpuset: Fix a partition bug with hotplug
Message-ID: <YP8+ajTnvrha+0O6@mtj.duckdns.org>
References: <20210720141834.10624-1-longman@redhat.com>
 <20210720141834.10624-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720141834.10624-3-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 20, 2021 at 10:18:27AM -0400, Waiman Long wrote:
> In cpuset_hotplug_workfn(), the detection of whether the cpu list
> has been changed is done by comparing the effective cpus of the top
> cpuset with the cpu_active_mask. However, in the rare case that just
> all the CPUs in the subparts_cpus are offlined, the detection fails
> and the partition states are not updated correctly. Fix it by forcing
> the cpus_updated flag to true in this particular case.
> 
> Fixes: 4b842da276a8 ("cpuset: Make CPU hotplug work with partition")
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-5.15 w/ a minor update to the comment (I dropped
"just" before "all". It read weird to me.)

Thanks.

-- 
tejun
