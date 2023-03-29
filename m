Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDF96CF240
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 20:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjC2SiB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 14:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjC2Shz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 14:37:55 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3796A5FE1;
        Wed, 29 Mar 2023 11:37:51 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id r7-20020a17090b050700b002404be7920aso15472217pjz.5;
        Wed, 29 Mar 2023 11:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680115070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uzLVbqgNBGN+xgE2Mcn5+0Hj/oLlv/psLQjcDCgpQr8=;
        b=kI+OaINANyKsiK+EWK5+yOqs4+8ljyMo3j6zqxxM9CNCGiuVso5j4vGdrojGjNs0yY
         0bWcLXqZlHNd5KEaFaq42TZPydl8CX+VZaczevLdxTDrOS+bRtk1uU3ldZcJ5GOoafYt
         EfJ3UBHdLiykj7ApCxebT76Fae/+kGPt8b03FuNjlP2cQ+kDqjpxVP30APPgIeDDwUAK
         JUwZpewbV42SJXpI7IZJO7GrUs0qCUeGrPItHGrUZVp9xHlP0F0DVVVfimp2uH4A+9XJ
         cvYw6G7wBHW7jwMokNIetOkS2+pSnTcBC41bJiINKqOlqkpoX06t8GHNFjgmTOmqgrdj
         y52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680115070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzLVbqgNBGN+xgE2Mcn5+0Hj/oLlv/psLQjcDCgpQr8=;
        b=L6fhGbg9CLSQSu6g4jTsUMeukkwe8nfdTKy9YoI4OeizMFiDaprw71uD18gU5fmdV0
         oPanxmUMEvbtvjewhzGYJoX/QLC2Lw/wVUGj8h9SKdj0eqrb4hvoJrUGAwA4WouEYc2+
         1Kv1C3aXA2iWDr2c/ZGuSrY3wpM0RdCrxkwTAFLOmrtPmpKAFdTy5sH51lvXFkCANMKg
         3GYXmlSXb6F7oBm+12Kz0whRbVGz4XQuzag1ZkUFEAcKwvFQzm53nbJEddOczneqeWh7
         7zO1bvDHynMOXkj9+01CIaStGDIzVbJ+mu2KeaYY/tNMSBWqlYSqVLVgm372a5E+PvJD
         SwSw==
X-Gm-Message-State: AAQBX9eM5FG6Pf92rGlZ8esrPgXmI6lOrkC+aLaOoNXDmBtWTC+0WVtC
        zu0+yAdVfM8BabwuT2hqVgl+xOxYzRs=
X-Google-Smtp-Source: AKy350ZCdGEv1x3AcKjBXJ46+u7JThYANyD1DbTn65Mw87/MICbj1baTbv665VxjBhy7AVYPa5cehg==
X-Received: by 2002:a17:90a:4bca:b0:23f:6830:568e with SMTP id u10-20020a17090a4bca00b0023f6830568emr20245502pjl.8.1680115070400;
        Wed, 29 Mar 2023 11:37:50 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id bf8-20020a170902b90800b001a27ea5cb94sm487166plb.87.2023.03.29.11.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:37:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 29 Mar 2023 08:37:48 -1000
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
Subject: Re: [PATCH v2 1/4] cgroup/cpuset: Fix partition root's cpuset.cpus
 update bug
Message-ID: <ZCSFfMeKRNERIBu6@slm.duckdns.org>
References: <20230317151508.1225282-1-longman@redhat.com>
 <20230317151508.1225282-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317151508.1225282-2-longman@redhat.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 17, 2023 at 11:15:05AM -0400, Waiman Long wrote:
> It was found that commit 7a2127e66a00 ("cpuset: Call
> set_cpus_allowed_ptr() with appropriate mask for task") introduced a bug
> that corrupted "cpuset.cpus" of a partition root when it was updated.
> 
> It is because the tmp->new_cpus field of the passed tmp parameter
> of update_parent_subparts_cpumask() should not be used at all as
> it contains important cpumask data that should not be overwritten.
> Fix it by using tmp->addmask instead.
> 
> Also update update_cpumask() to make sure that trialcs->cpu_allowed
> will not be corrupted until it is no longer needed.
> 
> Fixes: 7a2127e66a00 ("cpuset: Call set_cpus_allowed_ptr() with appropriate mask for task")
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.3-fixes w/ stable cc'd.

Thanks.

-- 
tejun
