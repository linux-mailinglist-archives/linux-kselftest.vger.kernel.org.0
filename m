Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8DE3CBE51
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jul 2021 23:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbhGPVVm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Jul 2021 17:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbhGPVVl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Jul 2021 17:21:41 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFFEC06175F;
        Fri, 16 Jul 2021 14:18:46 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id u14so11169461pga.11;
        Fri, 16 Jul 2021 14:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ATw9tZdhYF/626TCmJT2xXOkMuRTkYsc1yKjcQyVFP0=;
        b=IypbT7+Y0NaY7r9Dz97O68Ntezw/INbqU4XXy8HH/13CPcy3JWupvvny1EdiU3s5qO
         FZghZX/FF33NOXDSqw9xOVT5LrWy+YP1ewjsl0FSO8Y8quMKMO0KHnMcZ190oPP7vEoH
         E10fYtWDnV1+jt6RpDepRL9GRku98ELwqAYWrpOzugyFLn5qd7PiE4DAIWROZWa9G8cJ
         0kgj18ee0JcqJv/OlEu3eD6cPTuWgodRad+mgW7a7LYA0mluYalnPz2fK0b9hC8b/9EA
         S1VcjFT+P1+Zhq947Ax0zHHnXemfiCIu/j7G7ZZU4FBXoS3tq49QCnDs537UxFpynhYk
         di+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ATw9tZdhYF/626TCmJT2xXOkMuRTkYsc1yKjcQyVFP0=;
        b=JTRhYh+JKp1E/OM96JAgg70Mlj63qRT7Ik/XRabARjGQV1nI/F5/nmMNcP93W99oOX
         AUV07Rh7LbcKwhXPJYNG38r6oDWLW5sPbzr1T/I0Pql3Xk9aMfUgor2H8K5ukgJJhhK/
         HhagzCofZr4Gqy1hDHhHKuTLY/232zUewmnbQvMb3Fd9uFVi4qt+NaGRM8bhglMDl3Bl
         zxZbjpyrq6YMTpXLoiz+IDb5rYh3QmxyNxu3coi+N3zXzUgLo1N9OLpbgiHqcO8MocWc
         77deH48i+aMBDSr7b2eN+oy72dJ7IgWWAYZt9Zi7GUb78SNpHQOEv2H/hZBndsa4ZMNM
         NL+w==
X-Gm-Message-State: AOAM533dyWPN/x6Uar2/I4iE5KNr83DNBb5wm8iM6IQBkvWd5LF/ZDIN
        1XmE5SxuuLS8dL+jIslZGo0=
X-Google-Smtp-Source: ABdhPJxBJnGBmALISX7yiIhHV0cYBl6F4OU7VPtCLDSod3PkmvDILpAJcLCFb/6x/qGi8vkrdj148Q==
X-Received: by 2002:a63:170a:: with SMTP id x10mr11539130pgl.305.1626470325782;
        Fri, 16 Jul 2021 14:18:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:37b9])
        by smtp.gmail.com with ESMTPSA id j21sm8994763pjz.26.2021.07.16.14.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 14:18:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 16 Jul 2021 11:18:40 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <llong@redhat.com>
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
Subject: Re: [PATCH v2 2/6] cgroup/cpuset: Clarify the use of invalid
 partition root
Message-ID: <YPH3sF56gK71CxXY@mtj.duckdns.org>
References: <20210621184924.27493-1-longman@redhat.com>
 <20210621184924.27493-3-longman@redhat.com>
 <YNcHOe3o//pIiByh@mtj.duckdns.org>
 <6ea1ac38-73e1-3f78-a5d2-a4c23bcd8dd1@redhat.com>
 <YONGk3iw/zrNzwLK@mtj.duckdns.org>
 <c6ae2d9b-ad6e-9bbd-b25c-f52b0ff6fb9b@redhat.com>
 <1bb119a1-d94a-6707-beac-e3ae5c03fae5@redhat.com>
 <8c44b659-3fe4-b14f-fac1-cbd5b23010c3@redhat.com>
 <YPHwG61qGDa3h6Wg@mtj.duckdns.org>
 <e8c538a8-bf5c-b04c-1b21-ac22cd158dd1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8c538a8-bf5c-b04c-1b21-ac22cd158dd1@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Fri, Jul 16, 2021 at 05:12:17PM -0400, Waiman Long wrote:
> Are you suggesting that we add a cpuset.cpus.events file that allows
> processes to be notified if an event (e.g. hotplug) that changes a partition
> root to invalid partition happens or when explicit change to a partition
> root fails? Will that be enough to satisfy your requirement?

Yeah, something like that or make the current state file generate events on
state transitions.

Thanks.

-- 
tejun
