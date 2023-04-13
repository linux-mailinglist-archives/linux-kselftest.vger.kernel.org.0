Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798126E0393
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 03:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDMBRx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 21:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjDMBRu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 21:17:50 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5567F65AB;
        Wed, 12 Apr 2023 18:17:47 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id c10-20020a17090abf0a00b0023d1bbd9f9eso16579775pjs.0;
        Wed, 12 Apr 2023 18:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681348667; x=1683940667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aicWCnIBboKYj1UbmrIfysKq+w2Fw/6QRrG0gA3j6sY=;
        b=gYjjpD3JLH90EnGPJ9RcpcnDr0n4+5DTGSITYkHo/YynUUF6qZzpx0oGXdeF8F7Xjg
         AfXieG0P88XI6Nzkz1BFcevqb5GLWXPeccE5IJJamDBYFjnkb7Axu61u/6VjRPGr4EPZ
         SpaOxhK7cWQeH9785nGjVxI3aDbmLIPcUpoGn6/YUyrNDAxcPayfy632I/kFjQlNGZ9h
         wQ884KystVfhyecLHxVtIzMtMN6TwQ/C3+wN5tyZTC9lEbWTt3mZCbzrt1ix7k9RQlaI
         em+DSJHooOoW+JhPsh1zOeS/ubqfeFOiyJp3P+gqlAPWLyl8zClupd7ddpGci462z9Dy
         Uz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681348667; x=1683940667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aicWCnIBboKYj1UbmrIfysKq+w2Fw/6QRrG0gA3j6sY=;
        b=UHw29F6Bw1xD8j6Ilfg9EcT7p16sO074IIQUsAAIVxlPZNHXz1YMIUHL+zIPg2QsZ8
         I2CtX6U5gaK44ArWmGvwRCutg7YGofIOschfDWl0np+pBq9UmokUyzOC2feHaNuookQj
         0I3VKkmEXwHrK/M3Q2P1tWWJIvKilbcoybgn7CMgUDCtCGyMYtka8xi/xM9be4juPmsc
         rRNeSj9vHr84x8HykA6XOR3LK9X9ayS+xu7Le6rw3StbaOK2SeMlog87/9ezFlwmyzET
         yWUygkIVaOf7sDS76dTv2t9VedFQ+wYKDrVXtRlCxju46ggt3bvKUYSkMtx7zICyEKMT
         bDcA==
X-Gm-Message-State: AAQBX9dtaBuk8eKmczAwF39VA6Y7xfC2K2ixnMZJgNYCe5ngIHnsAqAs
        Mf+joGQRNSI2JUsTOkBl/AM=
X-Google-Smtp-Source: AKy350a/jiXR/DITr89ik4jDNgNrPJf/RV36bugcrUsjN8kViaL9JrLCgTKL85oOd7tFrlD7UM7llA==
X-Received: by 2002:a17:90a:f83:b0:23d:1aae:29e5 with SMTP id 3-20020a17090a0f8300b0023d1aae29e5mr84436pjz.20.1681348666504;
        Wed, 12 Apr 2023 18:17:46 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id cs19-20020a17090af51300b002367325203fsm2055992pjb.50.2023.04.12.18.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 18:17:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Apr 2023 15:17:44 -1000
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
Message-ID: <ZDdYOI9LB87ra2t_@slm.duckdns.org>
References: <20230412153758.3088111-1-longman@redhat.com>
 <ZDcGVebCpyktxyWh@slm.duckdns.org>
 <1ce6a073-e573-0c32-c3d8-f67f3d389a28@redhat.com>
 <ZDcS_yVCgh6g1LoM@slm.duckdns.org>
 <e38f72aa-9705-cf0c-a565-fb790f16c53e@redhat.com>
 <ZDdG1K0kTETZMTCu@slm.duckdns.org>
 <cd4c3f92-4a01-e636-7390-8c6a3d0cfe6c@redhat.com>
 <ZDdNy2NAfj2_1CbW@slm.duckdns.org>
 <1b8d9128-d076-7d37-767d-11d6af314662@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b8d9128-d076-7d37-767d-11d6af314662@redhat.com>
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

On Wed, Apr 12, 2023 at 08:55:55PM -0400, Waiman Long wrote:
> > Sounds a bit contrived. Does it need to be something defined in the root
> > cgroup?
> 
> Yes, because we need to take away the isolated CPUs from the effective cpus
> of the root cgroup. So it needs to start from the root. That is also why we
> have the partition rule that the parent of a partition has to be a partition
> root itself. With the new scheme, we don't need a special cgroup to hold the

I'm following. The root is already a partition root and the cgroupfs control
knobs are owned by the parent, so the root cgroup would own the first level
cgroups' cpuset.cpus.reserve knobs. If the root cgroup wants to assign some
CPUs exclusively to a first level cgroup, it can then set that cgroup's
reserve knob accordingly (or maybe the better name is
cpuset.cpus.exclusive), which will take those CPUs out of the root cgroup's
partition and give them to the first level cgroup. The first level cgroup
then is free to do whatever with those CPUs that now belong exclusively to
the cgroup subtree.

> isolated CPUs. The new root cgroup file will be enough to inform the system
> what CPUs will have to be isolated.
> 
> My current thinking is that the root's "cpuset.cpus.isolated" will start
> with whatever have been set in the "isolcpus" or "nohz_full" boot command
> line and can be extended from there but not shrank below that as there can
> be additional isolation attributes with those isolated CPUs.

I'm not sure we wanna tie with those automatically. I think it'd be
confusing than helpful.

Thanks.

-- 
tejun
