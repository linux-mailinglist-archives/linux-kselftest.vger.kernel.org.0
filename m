Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EC874E000
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 23:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjGJVIf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 17:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjGJVIe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 17:08:34 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E5CC4;
        Mon, 10 Jul 2023 14:08:32 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-676f16e0bc4so2246502b3a.0;
        Mon, 10 Jul 2023 14:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689023312; x=1691615312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2WumLpz2xEP5+8PT8olwpPEOtDAiclqdr88UfJwne5c=;
        b=OhfDziLrK2LihIMSV6Z5P3zQNZYTDuSYuR8reJ6mavc6O7MDoHRKA37qk5HQD1rPhV
         GMX25JEahad1Ok1SEOZx1cHicb1IDroG39pagy2/Iic6K5MpsmwB5YxGzB11o0SixbS7
         wZwZgDiKPWl0PdZFMh+yU0+2rVPvzI5y2LLoekGFF27w7Kd59mgZ996dPc/NKNnvra1u
         klwVwjPUt+5La3erZOgYk6H1rkrMWsPghzZTGFHHQRwaex8geYy/fp/P5OHXO7ByuyzQ
         hytxk+WWevZj71KI0BUNYig41ytJDNHpcw1qJ1zelX7bzxhPIKNW4EiL8+AtK17SvzWF
         rcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689023312; x=1691615312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WumLpz2xEP5+8PT8olwpPEOtDAiclqdr88UfJwne5c=;
        b=Hk8o6HQVP0u+S0docObHYIKxg9dDTbJC1DZ9s3BzrjkNIS6bI/HRQVbjj/f2CEAAB+
         O6xJmfaljuyotatJCaFKPOwYjAnxygFW08y4yCDUqfnsy2wbEGI+2C7Byc/3qCBNb8b2
         OgPsAYpqoBgTTn3SBiic/V1fGq0AfocCgmRRXV0nG36BiYva/IhvtR3nIOFzJcOZJsU3
         2X3uGnXrBuYx6ntctrWC8Sqn7f/qtacSNsH5l9ZJmM5+fEsT/eQDJ83nCyQ7PPr0ub0o
         71ncnv6jmg2esjwxk+DD3g+GFS+SGkAIWf+y+paq1SNQHD74K6+1n15KEgM6Zke+SZQX
         y7Dg==
X-Gm-Message-State: ABy/qLb9JRM+x424q9Xc6cjYoQXuuSped3492U9J7gzTqL7+NA+wFUc6
        2zOlMzphf1wxoLPpw3WA6yU=
X-Google-Smtp-Source: APBJJlGeFt6GMCGjdaMKt5d41LWI4LQWVcLwpw65y2/arY7Uv1RBV/p6xWHLRuRpRIU6rzLCuzd+sg==
X-Received: by 2002:a05:6a20:3d10:b0:130:bdc8:2294 with SMTP id y16-20020a056a203d1000b00130bdc82294mr9911426pzi.17.1689023311897;
        Mon, 10 Jul 2023 14:08:31 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id iy12-20020a170903130c00b001b243a20f26sm309068plb.273.2023.07.10.14.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 14:08:31 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Jul 2023 11:08:30 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mrunal Patel <mpatel@redhat.com>,
        Ryan Phillips <rphillips@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v4 0/9] cgroup/cpuset: Support remote partitions
Message-ID: <ZKxzTrN2yiKfXndI@slm.duckdns.org>
References: <20230627143508.1576882-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627143508.1576882-1-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello, Waiman.

I applied the prep patches. They look good on their own.

On Tue, Jun 27, 2023 at 10:34:59AM -0400, Waiman Long wrote:
...
> cpuset. Unlike "cpuset.cpus", invalid input to "cpuset.cpus.exclusive"
> will be rejected with an error. This new control file has no effect on

We cannot maintain this as an invariant tho, right? For example, what
happens when a parent cgroup later wants to withdraw a CPU from its
cpuset.cpus which should always be allowed regardless of what its
descendants are doing? Even with cpus.exclusive itself, I think it'd be
important to always allow ancestors to be able to withdraw from the
commitment as with other resources. I suppose one can argue that giving
exclusive access to CPUs is a special case which doesn't follow this rule
but cpus.exclusive having to be nested inside cpus which is subject to that
rule makes that combination too contorted.

Would it be difficult to follow how isolation modes behave when the target
configuration can't be achieved?

Thanks.

-- 
tejun
