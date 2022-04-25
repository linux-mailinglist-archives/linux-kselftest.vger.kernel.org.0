Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E1B50E95E
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 21:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238736AbiDYTVf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 15:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbiDYTVf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 15:21:35 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718CA12C8C1
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 12:18:29 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id p6so198965plf.9
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 12:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=EGrHpQVhbDy5vwZTzhNYK8llc1wnwOLu4wV+jMnBYL4=;
        b=CaYfhw1w1zCr1TOBWVJ1EiBOGCE0EIxtakImw+XtoEW5vt84RvGptzaYqbrW+innlW
         +Ku88xj7fg/qsjLAFb4N18ZNeray/Se5SHppUK9OjBl0eB9PHNzoDM2LRPg44ycpi2SJ
         bjNRJBVIyxkZFe/hZdtOD8UmyZHIiFgfVHm/j3HrJhsuwLJY0Ai5lzZzWklY6oXEwfoZ
         X7ZFQXszl2q6IOU7xV6dHIkOdnvDUSnutDtxLMhn9QduayUHVDPPQG/uD1X4QAkQnYHM
         EQ8yY7q6UexyNDJjNR/gFIP/T28r2m2aPkka5RBsU4xqbdHtPNIkvuAc9lKgiFIULCS0
         BWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=EGrHpQVhbDy5vwZTzhNYK8llc1wnwOLu4wV+jMnBYL4=;
        b=zE1krKKuRORxq07ktW32d5UUdXwjHmJaO2kRCyxg59IEUQJx0Hjr9P5MXcPaP1ksfw
         c1FJkkyiKa74GWoA4AzmUdZQWEK7hiIqRpW2OLGKu9Z2v8inIA81PsSQdy4ReR78Mtu2
         +D95G8x9pWMdwQxYYVRG79Gvecr4cN0MrFLaswybMgjuUjhG+McixazbtPpBZgF95LYU
         dAKzENlrnKRTbST/EdKjMfex+TyQgzoCbIQTbt7n1yJj8Fxn4mcdJepE/YOrLJEXATlD
         9qgXPjs1HelfiM6jPcmmPesp33P3YA+I0rUPk9UajU0WHrvAz/gXd6LLqEYHXWbZ6BZD
         IqFA==
X-Gm-Message-State: AOAM530kNru/b/acG4ybQ3KfK0fgj9DqBkVc7XxhJoy8M+qB+tafHRI6
        p7O7WXWzZuqxGSWh+rb26kHTeQ==
X-Google-Smtp-Source: ABdhPJxe80YjpMyc42uGIuBN4k1cDxK/sBI8c3/84Wz3/UZEwe35L5kGW2HFgSQ97+l0cr2C45Zhpw==
X-Received: by 2002:a17:902:7244:b0:158:41d3:b79b with SMTP id c4-20020a170902724400b0015841d3b79bmr19870661pll.50.1650914309214;
        Mon, 25 Apr 2022 12:18:29 -0700 (PDT)
Received: from [2620:15c:29:204:185b:8dcc:84d4:fb71] ([2620:15c:29:204:185b:8dcc:84d4:fb71])
        by smtp.gmail.com with ESMTPSA id x1-20020a17090a970100b001cd4989ff41sm97989pjo.8.2022.04.25.12.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 12:18:28 -0700 (PDT)
Date:   Mon, 25 Apr 2022 12:18:28 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 3/4] selftests: cgroup: fix alloc_anon_noexit()
 instantly freeing memory
In-Reply-To: <20220425190040.2475377-4-yosryahmed@google.com>
Message-ID: <f4aee758-c3b6-5ecb-a6e-10854a6490c4@google.com>
References: <20220425190040.2475377-1-yosryahmed@google.com> <20220425190040.2475377-4-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 25 Apr 2022, Yosry Ahmed wrote:

> Currently, alloc_anon_noexit() calls alloc_anon() which instantly frees
> the allocated memory. alloc_anon_noexit() is usually used with
> cg_run_nowait() to run a process in the background that allocates
> memory. It makes sense for the background process to keep the memory
> allocated and not instantly free it (otherwise there is no point of
> running it in the background).
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Shakeel Butt <shakeelb@google.com>

Acked-by: David Rientjes <rientjes@google.com>
