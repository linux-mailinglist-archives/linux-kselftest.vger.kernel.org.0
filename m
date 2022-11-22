Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B7C634812
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 21:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbiKVU0O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 15:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiKVU0N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 15:26:13 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8448827DFF;
        Tue, 22 Nov 2022 12:26:12 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so15356593pjl.3;
        Tue, 22 Nov 2022 12:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ql2FYZtChC8kHpVI2e9mEHckclAXpvmwn/fO5tPh578=;
        b=elh+z0q1qqevOLCYpwBkrBAb6yjmtaCYgataLx2FY3l8CrqJmnwjYJWWkb5XE113YF
         wt+kf4HIRlorudrICrtnK9/H2DPLaZSXNrbpt8G62NLJIKN8sfcQUFdKwfg06jc0C5+p
         8Gtx4MymzEdA0l8pyQ1Cf2LPpu2Wp+22iPTyGXFjEnggAQxp1UPsc++daU16duq13EKY
         a2VTX51iWrP73LKhnvgT0RVcYOFWdyJDccZ5b8xGiTGmp43Ls+jmMr1jHEkDDh3SyE1e
         x8u9Div/D2HUKk1ec770Bu2vK+iXmlPe3ItbyjMQdRWapEXVc54OAKYChtCcD2e+K3ke
         q0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ql2FYZtChC8kHpVI2e9mEHckclAXpvmwn/fO5tPh578=;
        b=gIYWqxh7EllkvI87XOFlwLSmIeriqzWfpu4BIGUyHEdSNj1JtcAxcqFWZT29iYZvCo
         j+mHnEpVqub2wSmKr3+UyLKZ3EFMTlM04/wsXHEl9o03hHF4EUX38fqfc5fvvOJwZCSf
         9yXDXVufuOHnev+ijO7Yr/9SC/7QKshIczxi0ZlM914dIpujX7KNBjuuMfjDPlinV9dQ
         CgXJsd6Jw+J6VmZEtkTNvIpzgDzPrGvS6e6pqAKNkvAMLvu6eGX9f4ofPQRpE+TjBssZ
         prECv+5W653qsjJ3Z/88T44zeaRqVQXzlBYz9vfl+DBKRkvthxDiQjetLeSq301ttCXg
         XpiA==
X-Gm-Message-State: ANoB5pmEc9g8U0mUYRd+KRe1AEb4MpwT8xYYUEUuDP6KMteOQMJHDqFb
        NfhGKcmC+DWT8HW3W+9ouFo=
X-Google-Smtp-Source: AA0mqf5oGIFMVmy9BowMY5qnMQENYrRn8wXpwe2NFMB9qFE6FmgU4Tc323G37NWDBgbwSvOoByvZwg==
X-Received: by 2002:a17:90a:8a03:b0:218:9f92:d1a0 with SMTP id w3-20020a17090a8a0300b002189f92d1a0mr16072431pjn.53.1669148771369;
        Tue, 22 Nov 2022 12:26:11 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:bb3])
        by smtp.gmail.com with ESMTPSA id y10-20020a1709027c8a00b00186cf82717fsm12407693pll.165.2022.11.22.12.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 12:26:11 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Nov 2022 10:26:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kamalesh Babulal <kamalesh.babulal@oracle.com>
Cc:     Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/cgroup: Add cleanup() to test_cpuset_prs.sh
Message-ID: <Y30wYVzuCGK/0Zxp@slm.duckdns.org>
References: <20221118101330.251332-1-kamalesh.babulal@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118101330.251332-1-kamalesh.babulal@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 18, 2022 at 03:43:30PM +0530, Kamalesh Babulal wrote:
> Install a cleanup function using the trap command for signals EXIT,
> SIGINT, SIGQUIT and SIGABRT.  The cleanup function will perform:
> 1. Online the CPUs that were made offline during the test.
> 2. Removing the cgroups created.
> 3. Restoring the original /sys/kernel/debug/sched/verbose value,
>    currently it's left turned on, irrespective of the original
>    configuration value.
> 
> the test performs steps 1 and 2, on the successful runs, but not during
> all of the failed runs.  With the cleanup(), the system will perform all
> three steps during failed/passed test runs.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>

Applied cgroup/for-6.2.

Thanks.

-- 
tejun
