Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF54F6CF265
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 20:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjC2SnP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 14:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjC2SnO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 14:43:14 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42382133;
        Wed, 29 Mar 2023 11:43:13 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso19502958pjb.3;
        Wed, 29 Mar 2023 11:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680115393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cm0O3mZAnzYDE3YblEoiVSRTHdbnazflMNNUfEvhAAA=;
        b=PDF80dUbKgdMlNmNe/WmOHssgAIRXS/Sj0NJnb29a8Noce+C0wRj7eGsS2P7i9cgR9
         6BmursKNdQyAYfDPu6uWeimwZ3q23ydPk7Yrv/d72j7MGtAFYci5mDSSkoOFXua6EsE8
         LXk9i1M5jTtOTGyuo/zhyvRknUOOkid5S37+zU5yCcRJhZfNNMpDNjkRaRIa/wtr7gfk
         t/q2tOdR2CHCVdIuTw6w6uNUQ+eSYiUqbuNAwNUvQ4x+iBhsT9yNcgLc/DjZe/fj2+g7
         b2EohJSjU6/FOQXMXLIM+nUpybsfQhohYFT34yLJIWuNlEo5xcnm2DXLIn89P6ttkACW
         UfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680115393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cm0O3mZAnzYDE3YblEoiVSRTHdbnazflMNNUfEvhAAA=;
        b=HDOvLubyViRZUAihA+cWE3w6e3pZNTa5ewEdJXW1QWG7xXah+XCt1NEPZBD/g6pxvf
         /ImeMbESW3qdtipB6G4vFhCRXHyHTRaOErpXU49Kquq5QQXNbaUlY2Q8A4QJ1MiLhRlE
         /w8xgGGliToeoHyZQnNOsR9GbhZvKJP948nE40iKE7A+yexBXF7df10qPGkAfwZndi22
         ISeE5Dw3VaBaefyxBGWGdjYNxL2yNR764IlUnpfLfoJr9LETmkJfQoltYyabFZMf889Y
         VB5CDIvqf1xnZj+FdA7AXgaVPEdEGhdsjeiwdjQtyYsGsiLJLd89UP9f6kGf3/tmOW6k
         D4AQ==
X-Gm-Message-State: AAQBX9fual2mdKCU676SL94gi9Vc3Iwmlg6t7NWAice8mfB5ehURCrTd
        uDsHVlVc4sL4qDLC3tk3avs=
X-Google-Smtp-Source: AKy350Z8ldOXTVa4hx1pP7vdHsS/Ckqx9P48f8CEZsU8qNxSmh8kCgwjdomuPgRZWCeauVG7C7Q8Zw==
X-Received: by 2002:a17:902:f34c:b0:19c:fbdb:43cb with SMTP id q12-20020a170902f34c00b0019cfbdb43cbmr15673121ple.51.1680115392862;
        Wed, 29 Mar 2023 11:43:12 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x13-20020a1709027c0d00b001a212a93295sm11131409pll.189.2023.03.29.11.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:43:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 29 Mar 2023 08:43:11 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v2 4/4] cgroup/cpuset: Minor updates to test_cpuset_prs.sh
Message-ID: <ZCSGv6PIfpvvWmxd@slm.duckdns.org>
References: <20230317151508.1225282-1-longman@redhat.com>
 <20230317151508.1225282-5-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317151508.1225282-5-longman@redhat.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 17, 2023 at 11:15:08AM -0400, Waiman Long wrote:
> This patch makes the following minor updates to the cpuset partition
> testing script test_cpuset_prs.sh.
> 
>  - Remove online_cpus function call as it will be called anyway on exit
>    in cleanup.
>  - Make the enabling of sched/verbose debugfs flag conditional on the
>    "-v" verbose option and set DELAY_FACTOR to 2 in this case as cpuset
>    partition operations are likely to be slowed down by enabling that.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied 2-4 to cgroup/for-6.4.

Thanks.

-- 
tejun
