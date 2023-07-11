Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3060074E2EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 03:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjGKBHT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 21:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGKBHS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 21:07:18 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D362DE9;
        Mon, 10 Jul 2023 18:07:13 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8ad356f03so33054425ad.1;
        Mon, 10 Jul 2023 18:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689037633; x=1691629633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IxBIJVCy8BSte3A+R6dkOVqHWVmw7XdfvWAKQ51rWXE=;
        b=iUPgdvmc76GAhsSeiyKt1afxZwczuvHmWhxciN5pTKOMxs8Y6qHZv4aZJbyiAzs3MD
         RpkVN7uTX+lmBkUSEyYUbdaVf1vk0iM3HfaqNO4w/1mNhQKjaqiwLi/4PyhJwpHBJIuw
         T0wCBhqgpCS3FVuvNRx1TMtnTitnxGOe6tsgtvkwFNxWh4qdRlW98ezZ3UUnz2VRikUG
         2Y0UIlrr3dF5gX8jbIozxxXvoqmlZj6F0X0FFA7yipiYTTgK78q7cTJmoXfWGkQ8DAZg
         shoKh0pYE4emU7FwZD909nkygrIJ/F72a3z6F+k3Nds1p0lLqUs25ELUCUVpRxdPUk2D
         sEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689037633; x=1691629633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxBIJVCy8BSte3A+R6dkOVqHWVmw7XdfvWAKQ51rWXE=;
        b=cC1A86PxIEtTL77tjnZPDVxikcMcJpOy4o0dStIOjA7IeNrKxjOKaYz0TTApwjHkqh
         htNpSpYL9UyZF3cATOtYfnJQBJg0qqrJMkJozVGaZGv/CeuX9BOGPa3nZbpc9t/6okI4
         fQWgRw1ckjXe6a6IW0SBnjcsnh4Y2xE1VRUYG5IKB+HtyoUuXqiEAGo141h4GRuMB2uw
         FNeh0Lc6uQ/vOwK7LpAJJgTMsZYLrei8mn4Iesk0fs+bs3EFpHaVX0Dk+fuuplFfJB2C
         W7kgsXUQOyCJDcF88wrQKlV3T5PBElwXpS2cD+VcGzGWGtUcQEmgU9ZI9sosAgSJ5bZB
         7z1g==
X-Gm-Message-State: ABy/qLZmh4mvNVXhNnSVYAeM+IfpCRMfJA/eGeRVQG7bzKSrFur+ToSH
        BrU6Gsmyqj8Qn22zlCDE8MVfsiIbxcYDRA==
X-Google-Smtp-Source: APBJJlH2W63t5F+9E31N010LmiQJn2T65kJKJjz90m9QZ2Wv9mVwJZoaJBnqB1WyJi0fRqrCnjwhkw==
X-Received: by 2002:a17:902:8308:b0:1b8:9044:9ede with SMTP id bd8-20020a170902830800b001b890449edemr12013743plb.62.1689037633174;
        Mon, 10 Jul 2023 18:07:13 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id iy14-20020a170903130e00b001b895a17429sm489274plb.280.2023.07.10.18.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:07:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Jul 2023 15:07:11 -1000
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
Subject: Re: [PATCH v4 8/9] cgroup/cpuset: Documentation update for partition
Message-ID: <ZKyrP74UzVb4Ltwi@slm.duckdns.org>
References: <20230627143508.1576882-1-longman@redhat.com>
 <20230627143508.1576882-9-longman@redhat.com>
 <ZKx4ZJowRhRtjZxB@slm.duckdns.org>
 <6d5aee58-f558-868c-76e0-0b58f8332110@redhat.com>
 <ZKyljsbJgLNpsBLI@slm.duckdns.org>
 <a429e60a-fc4f-60b0-3978-71596fed9542@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a429e60a-fc4f-60b0-3978-71596fed9542@redhat.com>
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

Hello,

On Mon, Jul 10, 2023 at 08:53:18PM -0400, Waiman Long wrote:
> For local partition, it doesn't make sense to have a cpust.cpus.exclusive
> that is not the same as cpuset.cpus as it artificially reduce the set of
> CPUs that can be used in a partition. In the case of a remote partition, the

Yeah, I was wondering about local partitions. "Automatic but can be
overridden" behavior becomes confusing if it's difficult for the user to
easily tell which part is automatic when. I wonder whether it'd be better to
make the condition static - e.g. for a partition cgroup, cpus.exclusive
always contains all bits in cpus no matter what value is written to it. Or,
if we separate out cpus.exclusive and cpus.exclusive.effective, no matter
what cpus.exclusive is set, a partition root's cpus.exclusive.effective
always includes all bits in cpus.effective.

Thanks.

-- 
tejun
