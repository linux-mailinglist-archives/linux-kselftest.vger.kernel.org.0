Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEAC547DC3
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jun 2022 04:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbiFMCzR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Jun 2022 22:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbiFMCzQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Jun 2022 22:55:16 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C91C3A191;
        Sun, 12 Jun 2022 19:55:16 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so4676243pjb.3;
        Sun, 12 Jun 2022 19:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t63caDtqr0AA//ZoM6eXOV7nTgEroVQihZDmmTAtOVw=;
        b=SpagrkUXR/0al8kxNb16RlzUwSttPdjODwumZyEug/IOxk77Wn3Mi8YIPGQuBDv6L+
         lPnw5bIkZo9WIWVuvxnsjSvVEt0o/w2h1Keu5u96Alig1OhlrcF+ojdSI/rJ18fPQlY6
         j5580adTKoAazBnfc3pCQ9rgnGTtlEdteIEGIZrm9GX6xEnTDiJ/eXt83zzXQibzkvFB
         iVt8NUhYWbVqXm5CBAzcjQOHnnkhQa/50EzdPjrJu9q50uv7ZO6g1v9JwyNxeq4cJaNE
         9obhx4drondnrlUNw+oYqt7+JVVSuSIhjwy/DN5JzDKAMdIvNGfsXGytooH4DpRDAQP1
         kFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=t63caDtqr0AA//ZoM6eXOV7nTgEroVQihZDmmTAtOVw=;
        b=4Ly7QcP2WTbojCxpdhE0q4Ha6zaWLbQmLWz3W9wzCi4ldGwijVjtNoSo+q+rqd0lhp
         XtgDeMr4xyWAKr37VyjTtHe+8qwJxdvBpJx9Dh8n+qW0EHFxTVeeGvgYRVpISeUPmPfu
         Gtj5KSDvxBJYe9YvudrQvmxvodIV+HxFYyTYAgtSK8Hfy5F20kHVpj/aWS6Lx+PGD6uK
         DUB4m+w71v58KRa2FTQHM7xhy7Dio3kkiN/vPfAQr9lYv7m10smpKICkZpUql1Uty1hB
         0R5M107mNZ1K2MiaVEQm8pOzU+6Lt+i6YKjX9h9YMS8xqiExO361f+kDCjd9hXX3y3uO
         eQqA==
X-Gm-Message-State: AOAM533NGpfaC2sVJMq0mWjQNZjy3UQajzGU/nZsHabhP8/30buOekV3
        YUZpcLryZnWn0xWFS7Df6SE=
X-Google-Smtp-Source: ABdhPJwiUya3EKqMLlP/HHRgy3rdluqQnxbx6tfBKcnyVjxv2c61PgpP3hdOjzmg/SN7/VLEj/BMDw==
X-Received: by 2002:a17:902:e80a:b0:166:3a24:4572 with SMTP id u10-20020a170902e80a00b001663a244572mr56258220plg.30.1655088915565;
        Sun, 12 Jun 2022 19:55:15 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id ft23-20020a17090b0f9700b001e2bd411079sm6065972pjb.20.2022.06.12.19.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 19:55:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 12 Jun 2022 16:55:13 -1000
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
Subject: Re: [PATCH v11 3/8] cgroup/cpuset: Allow no-task partition to have
 empty cpuset.cpus.effective
Message-ID: <YqanEZZooeZwtutA@slm.duckdns.org>
References: <20220510153413.400020-1-longman@redhat.com>
 <20220510153413.400020-4-longman@redhat.com>
 <YqYlCRywdgSYtwKk@slm.duckdns.org>
 <YqYlOQjKtQCBsQuT@slm.duckdns.org>
 <ce3106c1-a3c4-b449-bafc-6940d672bd94@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce3106c1-a3c4-b449-bafc-6940d672bd94@redhat.com>
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

On Sun, Jun 12, 2022 at 10:53:53PM -0400, Waiman Long wrote:
> Without this patch, cpus.effective will never be empty. It just falls back
> to its parent if it becomes empty. Now with an empty cpus.effective, I am

Yeah, that part is fine.

> afraid that if a task is somehow moved to such a cpuset, something bad may
> happen. So I add this check as a safeguard.

But how would that happen? A lot of other things would break too if that
were to happen.

Thanks.

-- 
tejun
