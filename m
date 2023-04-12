Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4586F6DFF97
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 22:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDLUWb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 16:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjDLUW3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 16:22:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A736EBD;
        Wed, 12 Apr 2023 13:22:25 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-246eebbde1cso345957a91.3;
        Wed, 12 Apr 2023 13:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681330945; x=1683922945;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yu2Dt9jJPuiCFFL8ILGJGVl5zgqQrKcJL03w0OHhJOI=;
        b=Ci8M+KzEkrHqeQxO/tndGcOSzpGiOY1qY8jnZMCv3LEbIRy1ZBZPfioPbFKwOSXfcv
         TF2Q6ICj/3ro+Q+D6DA1OPKj4KFoeAoUDfXnbdmYn6LKKyzYt1tipZlEZkxLysCiteM7
         nGdQPOKFrpEKxt/bL4qceuGyRY1HTfJ5uLQRANULDdPl9MyiAuDKdDHGGgIKkiyhhnxf
         GX0szzqLngq3xUQA90p+LgPLA1BP3pPAE8OKJADsoBs0xIM4OD+ll/C7Xl5bWBvsKba9
         J8FzFgvko4RtmNbuv5DLadsWtravAIywPfnuhYkzP6hTkyzsrJvcyEixc5SE3zDhpnqJ
         MJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681330945; x=1683922945;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yu2Dt9jJPuiCFFL8ILGJGVl5zgqQrKcJL03w0OHhJOI=;
        b=fIfAjN9kkER1fMI2qUNr0ON+5M/tNxJ2alp8MqdD1M0rvsMj91M2GHkMTnudPKe32s
         AtIe+52xrJlwE/ywJuB9D6NPKO6CjC6HBV//zCCgGFrjiRawySTz9uMfjCqUrgJkjs9j
         lxStjXzaJNsMw5Ijl71eV1FDV4vgqjRWDKv4Fon740EKxHRZHZ/Lqspjm/JNcBXR4/Zj
         61Sqb38COnVlpEyNqgTwOEIEDUOa7UqMtVJm1PK1ESXryx+VEn7/7omPpbrXeUXPOiEP
         iDA1dmLqm65dl25C0A7g2m/brgibqLjgUhNVJ+AmwN2bwk0O6uDbKVP8pyW9qHBIJFQ3
         MGOA==
X-Gm-Message-State: AAQBX9cn4fjjRJ1Cykf5MAz3YWM92Q7icc/cuDAGCliqmup2r6OZacTn
        v2rJQScn0En1MSg3P8s8ex4=
X-Google-Smtp-Source: AKy350bccmfO4Ker877oWjdHs101m9jrCp7uZQg4xudB5CoJW4KIGPnkbc4J3H0UQEuN6tJO6e0fSg==
X-Received: by 2002:a05:6a00:1387:b0:632:3ff:b3d7 with SMTP id t7-20020a056a00138700b0063203ffb3d7mr198902pfg.12.1681330945295;
        Wed, 12 Apr 2023 13:22:25 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u20-20020aa78494000000b005a8bf239f5csm5776444pfn.193.2023.04.12.13.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 13:22:24 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Apr 2023 10:22:23 -1000
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
Message-ID: <ZDcS_yVCgh6g1LoM@slm.duckdns.org>
References: <20230412153758.3088111-1-longman@redhat.com>
 <ZDcGVebCpyktxyWh@slm.duckdns.org>
 <1ce6a073-e573-0c32-c3d8-f67f3d389a28@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ce6a073-e573-0c32-c3d8-f67f3d389a28@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello, Waiman.

On Wed, Apr 12, 2023 at 03:52:36PM -0400, Waiman Long wrote:
> There is still a distribution hierarchy as the list of isolation CPUs have
> to be distributed down to the target cgroup through the hierarchy. For
> example,
> 
> cgroup root
>   +- isolcpus  (cpus 8,9; isolcpus)
>   +- user.slice (cpus 1-9; ecpus 1-7; member)
>      +- user-x.slice (cpus 8,9; ecpus 8,9; isolated)
>      +- user-y.slice (cpus 1,2; ecpus 1,2; member)
> 
> OTOH, I do agree that this can be somewhat hacky. That is why I post it as a
> RFC to solicit feedback.

Wouldn't it be possible to make it hierarchical by adding another cpumask to
cpuset which lists the cpus which are allowed in the hierarchy but not used
unless claimed by an isolated domain?

Thanks.

-- 
tejun
