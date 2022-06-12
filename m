Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33250547B38
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Jun 2022 19:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiFLRk3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Jun 2022 13:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiFLRk2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Jun 2022 13:40:28 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04DA32071;
        Sun, 12 Jun 2022 10:40:27 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cx11so3714156pjb.1;
        Sun, 12 Jun 2022 10:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fCsuCKlg/4qaHi+wkVJiXx2JwHlxDYcAa4PfTMau5mk=;
        b=cgMM1H8/meNhom7TYkhnUbO7+ywI9qaWn0+oUXBXhwoqJdb5n6GMPVtq+V1AzVQj0v
         C54qYNCyOrZJROCG4BURbeDLwKAaZ7n2TlA0xUeK+urGdBztW8H90itoP1WMHAEGsnZS
         gtWyWD1zJwXj3GoUvkdTENQ7R1bR7fAPk9QfEsrsC2e/irIa0up3k38Q7qEb0Vt1l9a+
         iQgH9mVmXnI/n/+7jFz9sGr0tWi9NZ4nkTZ8iS3v1RvwG2cpHWsCgU632IAgo332SX/z
         YVEyoDs9+iOaeJHGsiOEbj1VrEv/oVXCnCUqDLxX3PrRu5ujfoxfn7mLs4O2xwjxG8Y4
         8kKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fCsuCKlg/4qaHi+wkVJiXx2JwHlxDYcAa4PfTMau5mk=;
        b=5QaASoRKDRPDvUR2P1oM114R84rJAUkX9TWzc0+kdy1u630VT2t9esXyb5rjoV3jjY
         eK6shqJ1hvBkbhJXKUibqeWfe/tDOfCP+RUnRB+bz14r5/eqdcc4KcABbJOvvbSFLgVV
         x8xABoUQEYV/8KF4+GXOTv3Gq4KKSkXvyuAPpkKvSD6hIDl9fERFvgwxRv/soKEDuaZF
         Rzaw9WwLLsRCRNcP7TmrO+p33umlrYTfLD+yIhmM2GNL6MzNGvxc9A7ajQf1/q+1qcJp
         8mUUm+fC21lHDKHrJolgGtLfYtP2tllmBB8VzQAVYpagqTRAJaT5pUuc+XgkL828yC4K
         bfnA==
X-Gm-Message-State: AOAM531PFz3ejX8S+yDQ5Bm2nEZ0G/f/t3QLwzjVIzBumr5jyZhC5FvU
        rToojSTGGKh4K+S6uuRyUO0=
X-Google-Smtp-Source: ABdhPJzdweqstewCDngP00z7oI9hGdqh8D6I3pnY5yzrhhWR8eTCzP4Tzm38/TsZY1+BARi2JYR9kA==
X-Received: by 2002:a17:90b:3591:b0:1e3:25d3:e78e with SMTP id mm17-20020a17090b359100b001e325d3e78emr11277198pjb.29.1655055627157;
        Sun, 12 Jun 2022 10:40:27 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id m3-20020a17090a858300b001e307d66123sm3429941pjn.25.2022.06.12.10.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 10:40:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 12 Jun 2022 07:40:25 -1000
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
Message-ID: <YqYlCRywdgSYtwKk@slm.duckdns.org>
References: <20220510153413.400020-1-longman@redhat.com>
 <20220510153413.400020-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510153413.400020-4-longman@redhat.com>
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

Sorry about the long delay.

On Tue, May 10, 2022 at 11:34:08AM -0400, Waiman Long wrote:
> Once a partition with empty "cpuset.cpus.effective" is formed, no
> new task can be moved into it until "cpuset.cpus.effective" becomes
> non-empty.

This is always true due to no-tasks-in-intermediate-cgroups requirement,
right?

Thanks.

-- 
tejun
