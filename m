Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96236E2984
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 19:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjDNReg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 13:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjDNRef (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 13:34:35 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD9F7ED2;
        Fri, 14 Apr 2023 10:34:11 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b73203e0aso684086b3a.1;
        Fri, 14 Apr 2023 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681493647; x=1684085647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dG7apmRM3yhNuDvjT8hFfLfoQEI3ny9KJqTDvMmgXGo=;
        b=AX5OheJ6KNfyM3K9opcvdfBav2CGjPcxmDkXPNcSoXNVzf/5Cr3QkXedJn1avHZ7J9
         MXCeIyUxmvqQWhNz6e/1pYgD8M0MXfnab7qPP8FOGAwbnT9GyN3U+d6S+O4rIry0Ul9Z
         AyW5Ps9Qwh0KwbKaxaJQ+E47gPxiMk7zKTddk8MSZTNefHNANE5m5/EQq5nUG5ICmfT/
         3IEUZX59/5bnSrse5aFuxFKp5Z5RN3neHIQ45Vao2oT99n0swkJ5FPNvhPFEEAJvifiA
         q2jRbLcYm9cNqCyD7X/wquvcfsSAuf8a77Ujpk47PWLTAVJeHgxE5koW1tqX6xp9uM7c
         b1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681493647; x=1684085647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dG7apmRM3yhNuDvjT8hFfLfoQEI3ny9KJqTDvMmgXGo=;
        b=UbGVbU1tdYNk7293TMBY2vD6AD0BJMzsCVjRAd04+st0L1hBwvzxI6dqGXProDWUjv
         GMF3Rs5dUCa6nT5siYZFkMr+aZDDPx5Dky4VVxCtWOtjJilq6AtX6OIJSWI9W654Z6A7
         P5Txykiv39dyViYVHsGVtKnJ0PbPwf4/rrH3+jpA8c6TXBXx2OdGFJCuIkAqGbjcW4Qm
         6GhagIwijJmyIec37Sl+20c+qhHolV0RB52HGrKvAnV2dnR+6uHvmCrK2XAOy5gl2GRs
         I72eyaxKvAccl0PnZC7sNKSo/tlG972RbaflizlZXV9ZGV9IRqNFWReQwk9Oe0jfNFHR
         b7eQ==
X-Gm-Message-State: AAQBX9eQGabn1XIm3Mff18yw/QRE+71er2dthNXl8dvycQDf/ZgrFRJa
        cNUNzT3jA6iaZXySMDML7FCbnttmpHE=
X-Google-Smtp-Source: AKy350Zw01YkPPvz6a+slxPluZg+5dR1OyjVY2sBGnURNDS7i5o7q/M2CGya86v1OM674JjP/EsK4g==
X-Received: by 2002:a05:6a00:80f:b0:633:8cc7:bbd5 with SMTP id m15-20020a056a00080f00b006338cc7bbd5mr7400127pfk.11.1681493647169;
        Fri, 14 Apr 2023 10:34:07 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id u23-20020a62ed17000000b0062d7c0dc4f4sm3272612pfh.80.2023.04.14.10.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 10:34:06 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 14 Apr 2023 07:34:05 -1000
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
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [RFC PATCH 0/5] cgroup/cpuset: A new "isolcpus" paritition
Message-ID: <ZDmOjeBVsIcgSLIV@slm.duckdns.org>
References: <e38f72aa-9705-cf0c-a565-fb790f16c53e@redhat.com>
 <ZDdG1K0kTETZMTCu@slm.duckdns.org>
 <cd4c3f92-4a01-e636-7390-8c6a3d0cfe6c@redhat.com>
 <ZDdNy2NAfj2_1CbW@slm.duckdns.org>
 <1b8d9128-d076-7d37-767d-11d6af314662@redhat.com>
 <ZDdYOI9LB87ra2t_@slm.duckdns.org>
 <9862da55-5f41-24c3-f3bb-4045ccf24b2e@redhat.com>
 <226cb2da-e800-6531-4e57-cbf991022477@redhat.com>
 <ZDmFLfII8EUX_ocY@slm.duckdns.org>
 <c61ca9d0-c514-fb07-c2f2-3629e8898984@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c61ca9d0-c514-fb07-c2f2-3629e8898984@redhat.com>
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

On Fri, Apr 14, 2023 at 01:29:25PM -0400, Waiman Long wrote:
> 
> On 4/14/23 12:54, Tejun Heo wrote:
> > On Thu, Apr 13, 2023 at 09:22:19PM -0400, Waiman Long wrote:
> > > I now have a slightly different idea of how to do that. We already have an
> > > internal cpumask for partitioning - subparts_cpus. I am thinking about
> > > exposing it as cpuset.cpus.reserve. The current way of creating
> > > subpartitions will be called automatic reservation and require a direct
> > > parent/child partition relationship. But as soon as a user write anything to
> > > it, it will break automatic reservation and require manual reservation going
> > > forward.
> > > 
> > > In that way, we can keep the old behavior, but also support new use cases. I
> > > am going to work on that.
> > I'm not sure I fully understand the proposed behavior but it does sound more
> > quirky.
> 
> The idea is to use the existing subparts_cpus for cpu reservation instead of
> adding a new cpumask for that purpose. The current way of partition creation
> does cpus reservation (setting subparts_cpus) automatically with the
> constraint that the parent of a partition must be a partition root itself.
> One way to relax this constraint is to allow a new manual reservation mode
> where users can set reserve cpus manually and distribute them down the
> hierarchy before activating a partition to use those cpus.
> 
> Now the question is how to enable this new manual reservation mode. One way
> to do it is to enable it whenever the new cpuset.cpus.reserve file is
> modified. Alternatively, we may enable it by a cgroupfs mount option or a
> boot command line option.

It'd probably be best if we can keep the behavior within cgroupfs if
possible. Would you mind writing up the documentation section describing the
behavior beforehand? I think things would be clearer if we look at it from
the interface documentation side.

Thanks.

-- 
tejun
