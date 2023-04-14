Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1B16E28BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 18:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjDNQyL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 12:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDNQyL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 12:54:11 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB4A3A8D;
        Fri, 14 Apr 2023 09:54:08 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a6670671e3so7021315ad.0;
        Fri, 14 Apr 2023 09:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681491248; x=1684083248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZAvqYOYWKaKZx+hMdeSRvFQw5l3f6+NXzgHNVGxyZc=;
        b=OfVaK49qpidMI4dngUHtYirJkn7oUxSdbRfakMpgbgn1EFE3V1SYLnsMiNawY5+rO8
         RSz6N22SGnArcSiCFDiDDF8y0Mg0rksJp6GEeqz4JCmOGYqPgTBU4DjnYzHkVJtnjfbs
         7M6o0fyvoZAa764vAUL+5wWCmydHepII7odqZRhxbPgswGcuJLGCb33m//yqFG51bGfd
         EuZchA48GyJDKBZFZBQz8/ubKoIpi6QR7p2vFeaq8xIxPzym+vxjvt+3fBHgCGQoGciR
         d+wDMNjSb7n0YwP2P3v8pIMdRq4upNL7fPmC5l6PUNGZPadQDMFZSkNyK/qtJpT0U7l1
         8/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681491248; x=1684083248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZAvqYOYWKaKZx+hMdeSRvFQw5l3f6+NXzgHNVGxyZc=;
        b=cTtoNR50dwW+BzS8o1cGFoWR5DeCxOgydloh7nnRAEoX202vSHbVBjsXqisWY9QGwu
         3oh0dGx02385hEUc+z0GlvYhzyX6goT5Pn0Qf77qlUj7FPqFHIMt8zMXeQDJo8ZBJriW
         yZOlWJzQpXMx92TOYjhkJF1bSGOBxFh9Kgj55ruHZLHPZuWFq7E+O4mKse7joAiGCCMW
         aOMIC9F79lW++OOh+nQnmG+0owkYggNRkYgDzA+jJXfCSZnfGlw+EsmYfT1JgzQFY+7E
         BW9mzyZ9o9GfvHoIm4lhqrQVZdBCGp6+Ah9f15B4qz1aWJ/zmFnzWQ1VwHH2vAwc9ZP8
         AyHg==
X-Gm-Message-State: AAQBX9fA8kBIkG9KAoGEQLQ0XOOZums1Rwy85hhzqoY2iqbn8ocT0k7U
        eQc8BydylW9IBAY9y6o3dPrG3Uii8mc=
X-Google-Smtp-Source: AKy350YUW8tdWpk3MzDYQnAIYJwxPe47Jerfv2Tk35H6paSNTQHJ+AdGjSP+u4D2yUOoVrFHtpcLZA==
X-Received: by 2002:a05:6a00:ccc:b0:634:c780:5bb8 with SMTP id b12-20020a056a000ccc00b00634c7805bb8mr11011340pfv.17.1681491247683;
        Fri, 14 Apr 2023 09:54:07 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id g21-20020aa78195000000b00625d84a0194sm3252020pfi.107.2023.04.14.09.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 09:54:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 14 Apr 2023 06:54:05 -1000
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
Message-ID: <ZDmFLfII8EUX_ocY@slm.duckdns.org>
References: <1ce6a073-e573-0c32-c3d8-f67f3d389a28@redhat.com>
 <ZDcS_yVCgh6g1LoM@slm.duckdns.org>
 <e38f72aa-9705-cf0c-a565-fb790f16c53e@redhat.com>
 <ZDdG1K0kTETZMTCu@slm.duckdns.org>
 <cd4c3f92-4a01-e636-7390-8c6a3d0cfe6c@redhat.com>
 <ZDdNy2NAfj2_1CbW@slm.duckdns.org>
 <1b8d9128-d076-7d37-767d-11d6af314662@redhat.com>
 <ZDdYOI9LB87ra2t_@slm.duckdns.org>
 <9862da55-5f41-24c3-f3bb-4045ccf24b2e@redhat.com>
 <226cb2da-e800-6531-4e57-cbf991022477@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <226cb2da-e800-6531-4e57-cbf991022477@redhat.com>
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

On Thu, Apr 13, 2023 at 09:22:19PM -0400, Waiman Long wrote:
> I now have a slightly different idea of how to do that. We already have an
> internal cpumask for partitioning - subparts_cpus. I am thinking about
> exposing it as cpuset.cpus.reserve. The current way of creating
> subpartitions will be called automatic reservation and require a direct
> parent/child partition relationship. But as soon as a user write anything to
> it, it will break automatic reservation and require manual reservation going
> forward.
> 
> In that way, we can keep the old behavior, but also support new use cases. I
> am going to work on that.

I'm not sure I fully understand the proposed behavior but it does sound more
quirky.

Thanks.

-- 
tejun
