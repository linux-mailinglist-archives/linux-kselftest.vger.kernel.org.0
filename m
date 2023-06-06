Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39067724DC7
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 22:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239606AbjFFUNf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 16:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbjFFUNe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 16:13:34 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB1EB0;
        Tue,  6 Jun 2023 13:13:33 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b28fc460bcso1592212a34.1;
        Tue, 06 Jun 2023 13:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686082412; x=1688674412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fV7Pb5i2MwRKtXI+L72eacF/AO/0yqXx0MJ01SSud0=;
        b=pDP+yL9WN+pff/JjCduS7JvbmoHcUSbG+eB9kCz+wqvdammYyaHY7+8vJHuvMS2fq/
         wiDeLf7KOGZcqtQNbGAEc8cfZqZ03MuVCAWl7EFXiUe4r2M3mpMpPBs3vzm9/Bo/75Lx
         9BQjCpEmrUs9QbozWlAryEHce3fGTg8unUtkNcIsLsEbC87BqGdI/b2EUZjbVWjLf58a
         zelXaH1SDbvnKF5pNVwCS69lLvPBQLsjYLmUOVlxC0+SblWdlOdmN5POjSpacS5wXzdW
         kKAwGzBoG4g4vye8rCXAQcekBLgJRqhfL3YzPy42XeTh0addYmx2XSyBsIhIO743iW5y
         8a9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686082412; x=1688674412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fV7Pb5i2MwRKtXI+L72eacF/AO/0yqXx0MJ01SSud0=;
        b=LiXBXWZAkDuB65ntKty2uYqsaNFN7VsRIyHigLqWCwqhUUzXQkgmnFHIxPr9zMsvOw
         cN5gNRD0hN+HPs0hR7IIWhCFNGdXFtQDTXor33VvPFwPESgL/UOplRG239EVE6mSwElh
         3pAfMpFu4MnIxP+fcoCttZF/mzQptGjM2FObXj5xuswV21nBodiyGUyGPOmcGbFiKsEo
         QN9dKL+urjAHA7GLCME3DclckjcPpJVlsP7Kx26LZteorVMp20mIQwfwNp1uvDdirqcD
         V4QtYF4UTVEwvb6arQ3IgkiwRZW3yQ7xwvWeGxtG6N9F8HjwDXB5+rCsnacDvX4ouydr
         gYgA==
X-Gm-Message-State: AC+VfDy3Q9lJjyY+4Kl8yw2pALOrlbRwqwlOQmYvMgaYFWBIM60suz0N
        Pos4oDjDMh86NYCEtMHptUy1F8i8+t4=
X-Google-Smtp-Source: ACHHUZ4iLr+olIDpe6s8ZRWHjb0zuQyQc8mlYCwoYHuAuIvcatBpGiqxjkl/qs78RZxnA9Jw8tY6zg==
X-Received: by 2002:a9d:6253:0:b0:6af:9eb0:5de1 with SMTP id i19-20020a9d6253000000b006af9eb05de1mr3007443otk.36.1686082412201;
        Tue, 06 Jun 2023 13:13:32 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id b16-20020aa78710000000b00646e7d2b5a7sm7157908pfo.112.2023.06.06.13.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 13:13:31 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 6 Jun 2023 10:13:31 -1000
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
Message-ID: <ZH-Ta7jDozegNo3o@slm.duckdns.org>
References: <759603dd-7538-54ad-e63d-bb827b618ae3@redhat.com>
 <405b2805-538c-790b-5bf8-e90d3660f116@redhat.com>
 <ZGvHUjOCjwat91Gq@slm.duckdns.org>
 <18793f4a-fd39-2e71-0b77-856afb01547b@redhat.com>
 <ZH4jfmypOXGJPu0D@slm.duckdns.org>
 <be64a569-4388-9dd9-3e06-36d716a54f6c@redhat.com>
 <ZH5FNc6wjlGPsaaO@slm.duckdns.org>
 <a2220c9f-7a8d-da82-ecc0-b39f3807408c@redhat.com>
 <ZH-P7X_yjnVfhy7b@slm.duckdns.org>
 <563fd5e1-650a-e329-8aab-2fa1953a9f49@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <563fd5e1-650a-e329-8aab-2fa1953a9f49@redhat.com>
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

Hello,

On Tue, Jun 06, 2023 at 04:11:02PM -0400, Waiman Long wrote:
...
> The current CPU exclusive behavior is limited to sibling cgroups only.
> Because of the hierarchical nature of cpu distribution, the set of exclusive
> CPUs have to appear in all its ancestors. When partition is enabled, we do a
> sibling exclusivity test at that point to verify that it is exclusive. It
> looks like you want to do an exclusivity test even when the partition isn't
> active. I can certainly do that when the file is being updated. However, it
> will fail the write if the exclusivity test fails just like the v1
> cpuset.cpus.exclusive flag if you are OK with that.

Yeah, doesn't look like there's a way around it if we want to make
.exclusive a feature which is useful on its own.

> > Instead, it can be sth like "if the parent is a
> > partition root, cpuset implicitly tries to set all CPUs in its cpus file in
> > its cpus.exclusive file" so that user-visible behavior stays unchanged
> > depending on past history.
> 
> If parent is a partition root, auto reservation will be done and
> cpus.exclusive will be set automatically just like before. So existing
> applications using partition will not be affected.

Sounds great.

Thanks.

-- 
tejun
