Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66D73E9767
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Aug 2021 20:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhHKSQG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Aug 2021 14:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhHKSQF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Aug 2021 14:16:05 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1835BC061765;
        Wed, 11 Aug 2021 11:15:42 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so10920635pji.5;
        Wed, 11 Aug 2021 11:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ym/H6d8WW77SzOZbzzokiM0xg1UPIyiB60qBZGBJt7Y=;
        b=RnEVMsbaVXQl/0zBT1Pq4JA9Akvg664fiiU+SEcDZs6yqp8ZR2/NqgItGTwqC819y8
         zDra0nlCGVmzZTiP159TqJSrdPBdaIykcQ4E/s6RciOVsfc53jD3fq2xgQ7V38AOpck5
         FrZrL2VtgBhRaGiinA1ZlkiQ0PsQftoXTyf+Sjkz7kercQyhq6LsA4OGP/Xsm3YRsevJ
         07RXQ6BQxfga8qV82P97on+PcbzYNsB7c3y3eGthDxlz+w4Euqu9LlQ7I9azElNw3avS
         2enI75z+wQDqdpnwZZwWRHmUKj68vP7LMV/V6Z5+njWj6sPDqUxhHDR5jfJwYTk090Jd
         yi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Ym/H6d8WW77SzOZbzzokiM0xg1UPIyiB60qBZGBJt7Y=;
        b=o//G9JkhW/4+qkhoMrLJDaflq9oR8FoY/f4Lyo0fz0+jFOljCQzRbTDkELg0IwIa+M
         l7MhWjWO9TAlyCNbb/oKuGfYP5Q5gD40D/xBKZOFpnBKtndgIvYCfO+5/P9Dy1U4Qb9S
         HTuE7P00hKxfycfm4zAXO2OvjskxFlggWiWZLrlfJ8z7r+LXj+KJXVIuNGQVWxlA15xB
         b7tz5MiHbSiNC/6LHRBssghXvs0HqOf0u1pyygFQw97GK9a+KOncRZOZDyi//GP8LKRI
         hbAPK/L3ZfX/yjaDB0JFC3iy0Hwo8gQODEKX6ppn6ylCowygp23H1AseMj5x6CiB5nLf
         iOlQ==
X-Gm-Message-State: AOAM532ZuaXdV05pSIZuSkfaIHt9Xl/SyNFDQyrJhkWEorKfQFmwlIYl
        m/qlWLQPtTANsxokf5ZxmbM=
X-Google-Smtp-Source: ABdhPJy1emMxEqZApry6OWaGc6sDga6uHOLTeoOvtQ5GxCZ/YAJOnHc4JomhNpJC0ctUCQRlTyHpZQ==
X-Received: by 2002:aa7:8b07:0:b029:3c7:c29f:9822 with SMTP id f7-20020aa78b070000b02903c7c29f9822mr14988pfd.33.1628705741537;
        Wed, 11 Aug 2021 11:15:41 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id dw15sm105445pjb.42.2021.08.11.11.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 11:15:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 11 Aug 2021 08:15:39 -1000
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
Subject: Re: [PATCH v4 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <YRQTy7eo5jOlHTc6@slm.duckdns.org>
References: <20210811030607.13824-1-longman@redhat.com>
 <20210811030607.13824-6-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811030607.13824-6-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Tue, Aug 10, 2021 at 11:06:06PM -0400, Waiman Long wrote:
> +	Poll and inotify events are triggered whenever the state
> +	of "cpuset.cpus.partition" changes.  That includes changes
> +	caused by write to "cpuset.cpus.partition" and cpu hotplug.
> +	This will allow a user space agent to monitor changes caused
> +	by hotplug events.

It might be useful to emphasize that this is the primary mechanism to
signify errors and thus should always be monitored.

Thanks.

-- 
tejun
