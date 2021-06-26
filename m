Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05D93B4E45
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Jun 2021 12:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFZK4L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 26 Jun 2021 06:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZK4L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 26 Jun 2021 06:56:11 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFA3C061574;
        Sat, 26 Jun 2021 03:53:48 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id j6so6009826qvp.3;
        Sat, 26 Jun 2021 03:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5IakmMrURhycOrgMfR07LYIjzM4DIOC86+dJLV+QXtE=;
        b=tJM12ZzFZGep9dgrfo5utS8xjiFj8xNgXdKhGD3A9SmaJVv55z2dbAFR71Tbmn6Sea
         IygyNuEsD+k0js/M1w4rmHPEwGAIilhGD+DNFHa8L+iIXBZipBJ9EHHHqNYTIXeg4Fex
         1EG9vUpbZN5Quo1q3/NZTu9X6LlyML8XgkDM1Ubf3CVPwWLHNe1HfkCnMVt449oWv9zB
         ei8oGQnjwQ3R4FpWQKR9KiXEY+NSGqxidKhNSsGscePbTanOWZrgBfdBgs9Ls2RuMv7Z
         qg7pkDppgBYjycxMvMR5DhVz7Fk/CB+AT5rvnP0oGp3kI/M7eHMhvJS8OX7yYZPQDhsr
         CAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5IakmMrURhycOrgMfR07LYIjzM4DIOC86+dJLV+QXtE=;
        b=fqwK3xMRHPj0p1gJUnEp7UPn3xII2DpJ6RCjPbUlqp0lb8Os9fTBcE70BTEOF2nNZu
         lKmtbB+6BgnAPV+9icpN82lBkZ96XFsfxDSFQ08ldXfyBKYMmC0eHtFmcb+ueAzqf8j/
         yYkF4O73JLKZFCCZJs2q/5S5lSE0cxJcY/TjhFpB9XsNcY+90Jzs/Db2MCyz5UrYH1Rn
         ojOTIQjhqtovick9gM8A/2O19Noo+Hgr0DorHNQs0pejx7UCIj/XUc1t0MxiyGqKxXiL
         F9EuzoXaIvEeRgVck85ZdmZ5AogGokHo59l6CLcHtkBd/81z3srvOh27foo5fwmao0qz
         qHVQ==
X-Gm-Message-State: AOAM532E/+c8Jxw/ano0SF0fIDY993JvDd8yaY7o9S3aeYWc3L/QnUg/
        aiF1HVDj5riIIRoojlvjAis=
X-Google-Smtp-Source: ABdhPJxAO5H8E1B0+d8SzThxc1r9kU7/5m1zewXew59PcHar/YlNWyF8Ut7yR+4xSgYn0Oo3jNv58A==
X-Received: by 2002:a0c:f543:: with SMTP id p3mr12291007qvm.58.1624704827706;
        Sat, 26 Jun 2021 03:53:47 -0700 (PDT)
Received: from localhost ([199.192.137.73])
        by smtp.gmail.com with ESMTPSA id i3sm5365745qtp.2.2021.06.26.03.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 03:53:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 26 Jun 2021 06:53:45 -0400
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
Subject: Re: [PATCH v2 2/6] cgroup/cpuset: Clarify the use of invalid
 partition root
Message-ID: <YNcHOe3o//pIiByh@mtj.duckdns.org>
References: <20210621184924.27493-1-longman@redhat.com>
 <20210621184924.27493-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621184924.27493-3-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello, Waiman.

On Mon, Jun 21, 2021 at 02:49:20PM -0400, Waiman Long wrote:
>  1) A partition root can't be changed to member if it has child partition
>     roots.
>  2) Removing CPUs from cpuset.cpus that causes it to become invalid is
>     not allowed.

I'm not a fan of this approach. No matter what we have to be able to handle
CPU removals which are user-iniated operations anyway, so I don't see why
we're adding a different way of handling a different set of operations. Just
handle them the same?

Thanks.

-- 
tejun
