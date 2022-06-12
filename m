Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E143C547B40
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Jun 2022 19:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiFLRlV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Jun 2022 13:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiFLRlQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Jun 2022 13:41:16 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC46C5DA6C;
        Sun, 12 Jun 2022 10:41:15 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a10so3698656pju.3;
        Sun, 12 Jun 2022 10:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X6BJIvmW0nAM/rdDTrxImV1gJDMQBIx+HHhMyoZbXj0=;
        b=VePaCp4WTk52eQPlsdGdj1sEDkrzFDEkktTLgnzTAUURmN5dzumLqNzKwcRyno9pe5
         R6uBdesg/HyOjALj1N4q5Swbx8MCK6m4oNXcrgj5Roy9AJ0JLzYbxXz2FImMdHTI6LMj
         YEaSj4RW/x41CQcePmC7BDegynpKSQdHW4hIiSgJlRQ1A6uhMTh/989NOlO24IW9Q4T3
         uGDDPJdrVezaC8CcdStqLRbb9sjYIJtvpFpLdqCBj3XGkfloa212yArOs52hvS/4ULw2
         wCjeFFj5FlGFBu4IlEOBnXS2gTjd4BrYn3CVNY8i9vTl3yIhcVBSyqJ6Whas/i608wIv
         WnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=X6BJIvmW0nAM/rdDTrxImV1gJDMQBIx+HHhMyoZbXj0=;
        b=oZgLIRWUTE7vL7ceCAUJurNuPuPlKENDzgpVfazdGsKJvTOG3vW2Jf9M20V5wa7YL+
         UlcnCQdooIReSyEMW7Mn6FCO2sETj5G/oTkhG3AODX9zYzU+F//434cAcXA5177XlbNK
         ASt5Al0oZdRqQXqJj0e0aCwEuL3/crPLYZt+ZC7g8tbJ7/h8gVrU6DQFELKdAQnE6IbV
         A/yqYSmcOQHg1DrBomF2kOo0B46ON63DVusRzZaz/Ih+6noCze+F9J+9dAxMVVXaiab7
         ooNFxABI0PcSNB+qcrLfykLmf9isjdWIiT8EEhO/HG3AlfWK3iRu1vvxk4ogQyMq7RYP
         re7Q==
X-Gm-Message-State: AOAM532rC2L23oFkyjrzsoO5p2M/lOR9hwE6Cs+fxlRxIjf5GBJPFgM9
        sQGP39TPhAbCd7Y/dg/+iyY=
X-Google-Smtp-Source: ABdhPJzBosxXhKrvrzX2QKVBSw1ncXUS2xzRvYGYYn1HUUFZZjRpHFAXUpJBCyp7VuGguxOQyA9x9A==
X-Received: by 2002:a17:902:ea08:b0:163:ec68:ae08 with SMTP id s8-20020a170902ea0800b00163ec68ae08mr24218342plg.52.1655055675292;
        Sun, 12 Jun 2022 10:41:15 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id iz4-20020a170902ef8400b00162037fbb68sm3312522plb.215.2022.06.12.10.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 10:41:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 12 Jun 2022 07:41:13 -1000
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
Message-ID: <YqYlOQjKtQCBsQuT@slm.duckdns.org>
References: <20220510153413.400020-1-longman@redhat.com>
 <20220510153413.400020-4-longman@redhat.com>
 <YqYlCRywdgSYtwKk@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqYlCRywdgSYtwKk@slm.duckdns.org>
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

On Sun, Jun 12, 2022 at 07:40:25AM -1000, Tejun Heo wrote:
> Hello,
> 
> Sorry about the long delay.
> 
> On Tue, May 10, 2022 at 11:34:08AM -0400, Waiman Long wrote:
> > Once a partition with empty "cpuset.cpus.effective" is formed, no
> > new task can be moved into it until "cpuset.cpus.effective" becomes
> > non-empty.
> 
> This is always true due to no-tasks-in-intermediate-cgroups requirement,
> right?

or rather, I should have asked, why does this need an explicit check?

Thanks.

-- 
tejun
