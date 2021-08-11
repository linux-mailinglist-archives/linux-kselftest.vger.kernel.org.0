Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EE73E975F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Aug 2021 20:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhHKSOA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Aug 2021 14:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhHKSOA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Aug 2021 14:14:00 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9D7C061765;
        Wed, 11 Aug 2021 11:13:36 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f3so3756638plg.3;
        Wed, 11 Aug 2021 11:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oxQKOHGye+MyhmSjAPDSxHRbSa9bCfsfF6Mw0U8AVzM=;
        b=PseIk0/DWf35agIBKnWlLhgPHqav/JgKG0k5s8EiUzzgeCwLBb2m1Sn/lvtUuH5hme
         WjEEyGzn9WUHoqahMfHQD95qt2HFXeHe+lGjo4+TQhLZ8x2eLz07CU5wOQN7N7FDf4Tx
         Q5gKASNRyhA5zirkx0pRzoLGzJV4xnF1foLzOV3FwlUmOCXcEkphiyuyiWuurTv7gHbm
         XsQfx+X11Ur+n5nlIGSa1ECsQz2W6k4oR66x7IL+ka3iA/RoVr9TSJHHBGqPVzE3y+xP
         XniI+cAeiv6YVDTTOOvzabO4VImKBRCNru81vDbxzRulUMBRKAjfFTRU4q8pDsZPeIxg
         WLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=oxQKOHGye+MyhmSjAPDSxHRbSa9bCfsfF6Mw0U8AVzM=;
        b=S8PnXy3J4wgFnZIpGkcRnp/cWQIm872G5doB2vRSdANXhTJYo3tC3D1i1oNdXn7Cvu
         y6FLmGBHPh/cMnCD3tKl02qsfgyUBWN4djvRzgLKnHmQLGYnBS2EBNM9lNtjIRzeAuv1
         syEo01IISy3BTZfhKBqyV7DJHGSbnKxF9iNrpHceTNcq2sCOMWZE0ztYOWq2ddUp28pi
         pv7CGxdp1JPnpUqwm0ogAwWiQ7lXSM8WX75QT2wFHeYTkjBdrocasgGsttfCcMEgbcyB
         x3c+YKMyn5Fb1F7F2HwSE1my2zjVucUN7KGWjEUf2GfY8JqYglKWSA2mM8Kryy6ao5aH
         KwLw==
X-Gm-Message-State: AOAM530Oge8OT2cUeb/r6+FiF6R92fAfOvJK3mOajiL8NtwzmNwYpimr
        wlaX0Df4KWj+uRVyTGLlU+M=
X-Google-Smtp-Source: ABdhPJwk1TPFEEpuKKrS5l5cezCV9nWXtRHpdlb7TFOp4+AIVmPEGM8AP0GQYkwhcXYZ01gQusgnHQ==
X-Received: by 2002:a65:690c:: with SMTP id s12mr277948pgq.401.1628705615778;
        Wed, 11 Aug 2021 11:13:35 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id d17sm188447pfn.110.2021.08.11.11.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 11:13:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 11 Aug 2021 08:13:33 -1000
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
Subject: Re: [PATCH v4 4/6] cgroup/cpuset: Allow non-top parent partition
 root to distribute out all CPUs
Message-ID: <YRQTTf+bJZ8f3O3+@slm.duckdns.org>
References: <20210811030607.13824-1-longman@redhat.com>
 <20210811030607.13824-5-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811030607.13824-5-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 10, 2021 at 11:06:05PM -0400, Waiman Long wrote:
> Currently, a parent partition root cannot distribute all its CPUs to
> child partition roots with no CPUs left. However in some use cases,
> a management application may want to create a parent partition root as
> a management unit with no task associated with it and has all its CPUs
> distributed to various child partition roots dynamically according to
> their needs. Leaving a cpu in the parent partition root in such a case is
> now a waste.
> 
> To accommodate such use cases, a parent partition root can now have
> all its CPUs distributed to its child partition roots as long as:
>  1) it is not the top cpuset; and

>  2) there is no task directly associated with the parent.
> 
> Once an empty parent partition root is formed, no new task can be moved
> into it.

The above are already enforced by cgroup2 core, right? No intermediate
cgroup with controllers enabled can have processes. From controllers' POV,
only leaves can have processes.

Thanks.

-- 
tejun
