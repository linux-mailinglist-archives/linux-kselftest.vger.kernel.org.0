Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1573D69FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jul 2021 01:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhGZW3v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jul 2021 18:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbhGZW3u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jul 2021 18:29:50 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35B5C061757;
        Mon, 26 Jul 2021 16:10:18 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id f13so3055412plj.2;
        Mon, 26 Jul 2021 16:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lGwxyaND0AFp6xjSOU+CS8ALMUm6RpLJV/rJQAwgaMY=;
        b=FI4linOnbFeTgynUKUdl3/vUVKX3cRbtNpKAnixhYKJ47quOI03wHetguN2dJW9MN9
         2RNaBEc+FSEEv7qPVV3tL+r9OpkNZydEbR3oxv/QFVRDpbvAbZQPnIo5fKdZXbgpAdUJ
         jCsYwZKodRp6pEDf74/79+8VeQsw/Wguz1O0u/oIVopDTLYKhhBZkS8bR4BKklZ/lfkN
         2xz3FyahK53ItsEWRnDlEiasq96F4I2mdQE0JPDW3BDoW6+CnxDuj3qOyZ63prmF7pPG
         1peP2KLMKD6Zk1GhKeKwe5eOg+WmVBSNuUZqfLL0sQ11OX33McU/Tajd8kut5ZQqId/o
         2qlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lGwxyaND0AFp6xjSOU+CS8ALMUm6RpLJV/rJQAwgaMY=;
        b=lPC9uM3i8/UoAPrdim01xp1Uisq/BQ5YwjHBUTpCKKTxigzIYSGsjzBdEAoGx0ayS1
         GSeOYI0TG4XorF+qo8uyeFGJhUzqukmuMDu5wr8NoUBA9NQIAyL3mAE97bsiIBAAyuIX
         g6JLO/BKtxAZeT/pVL9aEtoI8dEAj9o62HiVZiC7cMsdOSYZbYSp/YYD4RvDnc3ybLCo
         3mRrm1324d/Z9u8SZX+CeSLziprZ9fBPpJ83KWvqXbaoya2cN+PSY9/69tC1Oo8MS/t/
         6LIUioqhkjOz9fsB167EA43b3Yv4FRtZqMbl3Q1SW+hmIYmfjoX7T2boNpWFKNQnx7se
         xm0g==
X-Gm-Message-State: AOAM533PiT69jjLfSVbLszvy8/mUzP4oXGDxG9peUrZShVP9LxhmzMzF
        RyZjK72vU2lSSCv39KHPwnQ=
X-Google-Smtp-Source: ABdhPJwbc7zcK+b/oi8A8VWQpBSU8Iwv1rvIPdhCEViCl4PjtVnB8x0zjkbguUnDtaY8v2VxM++r4g==
X-Received: by 2002:a17:902:c946:b029:12c:3cf9:36c4 with SMTP id i6-20020a170902c946b029012c3cf936c4mr2473932pla.84.1627341018139;
        Mon, 26 Jul 2021 16:10:18 -0700 (PDT)
Received: from localhost (udp264798uds.hawaiiantel.net. [72.253.242.87])
        by smtp.gmail.com with ESMTPSA id b3sm1149623pfi.179.2021.07.26.16.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:10:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Jul 2021 13:10:16 -1000
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
Subject: Re: [PATCH v3 3/9] cgroup/cpuset: Fix violation of cpuset locking
 rule
Message-ID: <YP9A2Im5r30s58g1@slm.duckdns.org>
References: <20210720141834.10624-1-longman@redhat.com>
 <20210720141834.10624-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720141834.10624-4-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 20, 2021 at 10:18:28AM -0400, Waiman Long wrote:
> The cpuset fields that manage partition root state do not strictly
> follow the cpuset locking rule that update to cpuset has to be done
> with both the callback_lock and cpuset_mutex held. This is now fixed
> by making sure that the locking rule is upheld.
> 
> Fixes: 3881b86128d0 ("cpuset: Add an error state to cpuset.sched.partition")
> Fixes: 4b842da276a8 ("cpuset: Make CPU hotplug work with partition)
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-5.15.

Thanks.

-- 
tejun
