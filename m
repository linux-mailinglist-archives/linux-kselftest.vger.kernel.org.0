Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50563AA56C
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jun 2021 22:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhFPUln (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Jun 2021 16:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbhFPUln (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Jun 2021 16:41:43 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B87AC061574;
        Wed, 16 Jun 2021 13:39:35 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id r20so2980549qtp.3;
        Wed, 16 Jun 2021 13:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w2FBfLaBcwWiXuuQkiw+TKxNhLLyk0+UoFjg+2c9KWs=;
        b=BqBhOjMwogf4k3blz8IAL4WznI6LikA5MM6wtvdt54OjlMTQ/hGLAM476ovh8+O353
         rcDqAUKKfNsblRHU2SVTlhQwfloN8u0hu+w0LiTH+Tia01Gkw4fSBkLWyNLyJfM+n4oL
         fXL0blwAjsHNAx6D/kmfSebvzy5pTvr1zwUiheCDJmbSiGGiavFdxKJDZQb2GMcmyVEc
         h8SWGqakfPRb8QUBkKTK0rTCq6vaXPkrjWvudCqX3OWKPJI6qJuX/Rxo093xzbXye5yS
         RKxsZlzvsABLEIvIVTqJl2q95sY12+mQpCfVtM2pTFJww7wQiU6JQYLFu8KjPFsnsSjE
         L2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=w2FBfLaBcwWiXuuQkiw+TKxNhLLyk0+UoFjg+2c9KWs=;
        b=eTjR2sN/Xbmf4MQEYkoqFoAWY+kZBD8SYs5J/Bd7IZmHt41wpCjx+wIIfQPvnFqPpn
         4npSVYCvkRxPqRakWjXfDT1nU1OXCpAyfVrOf6N3yv5v8YPVDoOGBv3nBpx3TRv2dzI+
         6OQ2y8pNzT/so4qaJM7GqCp9QJk24jTomSqGJx2q2GlKO+SLI7Lsr5FaBHUOsytipH2D
         ZY/XwQ/Awgt1enOyi4IqQ2+9OK8AuoNM6X1UgAZztIKCAIs1Isj7kQaGdnS5WuEdVXRP
         W8EPX6fjre8vMA8YJBAuYFj1Lcn1c91NRFCzmIoWXfMg2AOmdboyxSlRs6GfYMuR64Hh
         t6fw==
X-Gm-Message-State: AOAM5300R12YjE54WaL2nN+Q5oNGpN8+Ss/Oy3kp8Cu/GnSIzEiJvoSL
        ABf3N/3QwjO83EitQrnymcI=
X-Google-Smtp-Source: ABdhPJyfuhLloMr2jD5atgcSjc7s9SBwOGa3zson1CdRWwIRQt+pLlNuk+DW2fOkVzkB46PeGLmTMw==
X-Received: by 2002:ac8:1285:: with SMTP id y5mr1712954qti.322.1623875974081;
        Wed, 16 Jun 2021 13:39:34 -0700 (PDT)
Received: from localhost ([199.192.137.73])
        by smtp.gmail.com with ESMTPSA id k9sm1693776qtq.30.2021.06.16.13.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 13:39:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 16 Jun 2021 16:39:32 -0400
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
Subject: Re: [PATCH 1/5] cgroup/cpuset: Don't call validate_change() for some
 flag changes
Message-ID: <YMphhLAzmRRyD+cm@slm.duckdns.org>
References: <20210603212416.25934-1-longman@redhat.com>
 <20210603212416.25934-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603212416.25934-2-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Thu, Jun 03, 2021 at 05:24:12PM -0400, Waiman Long wrote:
> The update_flag() is called with one flag bit change and without change
> in the various cpumasks in the cpuset. Moreover, not all changes in the
> flag bits are validated in validate_change().  In particular, the load
> balance flag and the two spread flags are not checked there. So there
> is no point in calling validate_change() if those flag bits change.

The fact that it's escaping validation conditionally from caller side is
bothersome given that the idea is to have self-contained verifier to ensure
correctness. I'd prefer to make the validation more complete and optimized
(ie. detect or keep track of what changed) if really necessary rather than
escaping partially because certain conditions aren't checked.

Thanks.

-- 
tejun
