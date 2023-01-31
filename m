Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D15B683941
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 23:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjAaWWN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 17:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjAaWWM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 17:22:12 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A6A5AB75;
        Tue, 31 Jan 2023 14:21:38 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id h9so7973374plf.9;
        Tue, 31 Jan 2023 14:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ZnMNTNoXOmaGSq2MU9iWJuW3qH7F1Tm7PkorK2d7rA=;
        b=HiHAGDju3Xjyz1jNGsC+PEn/3kaBnTTCUXPnV4kiqQLzMXAiFDCg59wVh1JdDG2m1Q
         oUkmbvwIw5N9kn3zynuIPTrCsOydyyjtwwS0jG1BJkXoVGd1kyRXajjGlMX5Dzk1hZDC
         qzfcY/tUf2GnwP+yLK2jBt343L2Y93l6ecpycpnnmhV4ukJlwbJKmzXeFdHu0MtUnl3q
         mm98BKdprBgGW72wB+YE8bebOdgZ95CHTCfkBYZbX5WVZ0yrGoqdfK9DLtuuStFRB5ko
         JzyTgRUckBpz+dtdBZBhlMYe+FbybhZyUE+RCosRACCoYpZWZbxr+sKYYg0I7j3+t760
         kVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZnMNTNoXOmaGSq2MU9iWJuW3qH7F1Tm7PkorK2d7rA=;
        b=unutMzBNJPh0iPBT5D6AKmQm2h8PTHBzKJFTTHH369oICh3X8BZyzWD4RcS80oDoAz
         Ej1tywQXvhkDNW8Ny9paZMYi8OFlzhjJyPkys5qCTcRwhmZTzxX4aSoRJY+7F1IGpI3x
         TB6P1Sg3Rq71i5r8Z9M6RGiGi9DJwkd+dhtvwaHCVC7tohreNY3hBUx+5OOyX6HYr/68
         FVrd7JOOmSTFUOpAtgAOcbmhU8s9eE0Oj0I4Uhm8zwDioG+I6RpnRuk3Q36VIsl3wAhM
         wrrDr5p8CICKQZ2Db/bDGFu7m36kd3onreWALpGo1czSb6Ac4avC+/fH8uSo3xWkX5k6
         8atg==
X-Gm-Message-State: AO0yUKXsZ0vjLbvHy9KrXvt/C1aVs0bUZSPOtjLzfDbt5qjG27A3lYcK
        WSTzH50rhnbddDzz+Khh6yk=
X-Google-Smtp-Source: AK7set+E72Bq2oXbHOH2+MCfUs5Qtpp+22Q1cZnIND1QfM+2G5pv77PF2xZXLA/FsDODoyj/FVn5QA==
X-Received: by 2002:a17:903:24d:b0:193:38ce:7bb8 with SMTP id j13-20020a170903024d00b0019338ce7bb8mr13876610plh.37.1675203697568;
        Tue, 31 Jan 2023 14:21:37 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:1ad6])
        by smtp.gmail.com with ESMTPSA id o7-20020a170902bcc700b0017f73dc1549sm10197072pls.263.2023.01.31.14.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 14:21:37 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 31 Jan 2023 12:21:35 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH] cgroup/cpuset: Fix wrong check in
 update_parent_subparts_cpumask()
Message-ID: <Y9mUb22hOY9CmEIt@slm.duckdns.org>
References: <20230131154803.192530-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131154803.192530-1-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 31, 2023 at 10:48:03AM -0500, Waiman Long wrote:
> It was found that the check to see if a partition could use up all
> the cpus from the parent cpuset in update_parent_subparts_cpumask()
> was incorrect. As a result, it is possible to leave parent with no
> effective cpu left even if there are tasks in the parent cpuset. This
> can lead to system panic as reported in [1].
> 
> Fix this probem by updating the check to fail the enabling the partition
> if parent's effective_cpus is a subset of the child's cpus_allowed.
> 
> Also record the error code when an error happens in update_prstate()
> and add a test case where parent partition and child have the same cpu
> list and parent has task. Enabling partition in the child will fail in
> this case.
> 
> [1] https://www.spinics.net/lists/cgroups/msg36254.html
> 
> Fixes: f0af1bfc27b5 ("cgroup/cpuset: Relax constraints to partition & cpus changes")
> Reported-by: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.2-fixes w/ stable cc added.

Thanks.

-- 
tejun
