Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789D1724D97
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 21:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239596AbjFFT6m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 15:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjFFT6l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 15:58:41 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB2583;
        Tue,  6 Jun 2023 12:58:40 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-55554c33bf3so4788563eaf.2;
        Tue, 06 Jun 2023 12:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686081519; x=1688673519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fzXlbPINbB7MLh0jxJ+Y5UChf2gkHO8C34dmKugRUg=;
        b=S03UnzPuSlaqndpGm3fYnzSEuVrAJXVaDyv5zhRB0i5qOf5lMwHRzbOjDYKhZQ3YSo
         K6JFXzTmnc5Eo0jMOnKFw9HQej3OKTiE/yaKVmk6JZ6cXrcoQ9HDNrj6Ulu/ThSN+8zH
         XELNofQ9A4CjY/LWiTTYEyPJ0ej0qw0h/zran7xqQiuRfvTLultwGtjYlcq8sS4ed+sK
         8hQjSnUD1/E3QK+CRaXt8pS2dKD7rK+nMC/dWUUVKcU5y9DBDO6YlOV/O/PkkLmBRN4X
         sBGC4cB3XiFMOmPvIfiknCyFlxijBSnkSJdGYSFYSDsdnyHBdclop9rTWD/UjH1tKS26
         2GMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686081519; x=1688673519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fzXlbPINbB7MLh0jxJ+Y5UChf2gkHO8C34dmKugRUg=;
        b=I65QxiSV57kpPiSj8434muByZR8CMhPa9Vq8u5Sc0fvz9vLTxJCVhY9PlUCGVYSU3L
         AAOEx0kIYNTi5l8QNmLjx7IHHzUCPTqaDDw3s5Yuu+ZJjS9VnNOGQ5/Bno0WWFlrGaIW
         urDJ0Ga0JLsF0cCJ2MRG3dBD3/ZhHK9ZV6rGGBa3rJ5L3l/hr8ST/XJCx4A0/zvpUsIp
         sg6hz80cRgVZq8mRRrtOmdpTSC9DsOtLfSSljoSm6QPDFGiqBekQyGeZH3MHJuy6YNOi
         ttzjMUj31vQcfqzHs+N+IcvZPjdrtkLIItgyt7u9Z8gwXxBWH9MbGyvSL0Vsqsy5Z5Fu
         YCww==
X-Gm-Message-State: AC+VfDwjwgF87b5TgvqcxsCq0K6CYkzfmxyWqG2ej8O+D+CSjUuaNavV
        VFCjdoo450es5MJPrfM49+A=
X-Google-Smtp-Source: ACHHUZ42dMHLfPyqDY8aY4eB6lc3Uaa0wqGPVYy7FN7kzsPrKQYtfFllGNzJqCzN0j4iAu3TvEb9ZA==
X-Received: by 2002:a05:6359:2a0:b0:129:cc43:2ebd with SMTP id ek32-20020a05635902a000b00129cc432ebdmr929433rwb.23.1686081519068;
        Tue, 06 Jun 2023 12:58:39 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id fe19-20020a056a002f1300b0065055ad5754sm7196408pfb.64.2023.06.06.12.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 12:58:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 6 Jun 2023 09:58:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Zefan Li <lizefan.x@bytedance.com>,
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
Subject: Re: [RFC PATCH 0/5] cgroup/cpuset: A new "isolcpus" paritition
Message-ID: <ZH-P7X_yjnVfhy7b@slm.duckdns.org>
References: <deb7b684-3d7c-b3ae-7b36-5b7ba2dd8001@redhat.com>
 <ZFUo5IYAIwTEKR4_@slm.duckdns.org>
 <759603dd-7538-54ad-e63d-bb827b618ae3@redhat.com>
 <405b2805-538c-790b-5bf8-e90d3660f116@redhat.com>
 <ZGvHUjOCjwat91Gq@slm.duckdns.org>
 <18793f4a-fd39-2e71-0b77-856afb01547b@redhat.com>
 <ZH4jfmypOXGJPu0D@slm.duckdns.org>
 <be64a569-4388-9dd9-3e06-36d716a54f6c@redhat.com>
 <ZH5FNc6wjlGPsaaO@slm.duckdns.org>
 <a2220c9f-7a8d-da82-ecc0-b39f3807408c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2220c9f-7a8d-da82-ecc0-b39f3807408c@redhat.com>
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

Hello, Waiman.

On Mon, Jun 05, 2023 at 10:47:08PM -0400, Waiman Long wrote:
...
> I had a different idea on the semantics of the cpuset.cpus.exclusive at the
> beginning. My original thinking is that it was the actual exclusive CPUs
> that are allocated to the cgroup. Now if we treat this as a hint of what
> exclusive CPUs should be used and it becomes valid only if the cgroup can

I wouldn't call it a hint. It's still hard allocation of the CPUs to the
cgroups that own them. Setting up a partition requires exclusive CPUs and
thus would depend on exclusive allocations set up accordingly.

> become a valid partition. I can see it as a value that can be hierarchically
> set throughout the whole cpuset hierarchy.
> 
> So a transition to a valid partition is possible iff
> 
> 1) cpuset.cpus.exclusive is a subset of cpuset.cpus and is a subset of
> cpuset.cpus.exclusive of all its ancestors.

Yes.

> 2) If its parent is not a partition root, none of the CPUs in
> cpuset.cpus.exclusive are currently allocated to other partitions. This the

Not just that, the CPUs aren't available to cgroups which don't have them
set in the .exclusive file. IOW, if a CPU is in cpus.exclusive of some
cgroups, it shouldn't appear in cpus.effective of cgroups which don't have
the CPU in their cpus.exclusive.

So, .exclusive explicitly establishes exclusive ownership of CPUs and
partitions depend on that with an implicit "turn CPUs exclusive" behavior in
case the parent is a partition root for backward compatibility.

> same remote partition concept in my v2 patch. If its parent is a partition
> root, part of its exclusive CPUs will be distributed to this child partition
> like the current behavior of cpuset partition.

Yes, similar in a sense. Please do away with the "once .reserve is used, the
behavior is switched" part. Instead, it can be sth like "if the parent is a
partition root, cpuset implicitly tries to set all CPUs in its cpus file in
its cpus.exclusive file" so that user-visible behavior stays unchanged
depending on past history.

Thanks.

-- 
tejun
