Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2437526A6C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 May 2022 21:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357966AbiEMTeQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 May 2022 15:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348000AbiEMTeO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 May 2022 15:34:14 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456152AC40;
        Fri, 13 May 2022 12:34:13 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id a191so8396953pge.2;
        Fri, 13 May 2022 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7BSLd/9FfqODWm0XMu152wdT1waWblg0wKPb9L2tj+0=;
        b=pmakHJ5ObblxYg6DTbIX+0AwpSDprJ9K8Ncuq6QLao0GXk4/q16Voz3zpKXpb0W2u6
         Pu5NbuNDkxRvOS18/sNZpwZB19RXH9FGnf0Sm4Q6sGhFZTXCWDhRGujVu5yKBPEPfxj6
         qKdUBcFxZhLw7gw5O8SVi3TjHjuCxnLpTosqA8Yyyob1/KHvdjkTRbW1pBrXHRpOLVXD
         vxmiofElROpWqRQ3t7pPuAuebzYFlIs7lUIqwebZqCz2b9ehrNtPB2KHc5uJZW8TVSq4
         vD3MP5l0axv6GrIlB2jK0WgZkMCBotNKjrwiw89UmaKN+qydKWEYQ2Y79Mel44fCxSo6
         6+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7BSLd/9FfqODWm0XMu152wdT1waWblg0wKPb9L2tj+0=;
        b=bjsm3/ljChKks5MBJmnYKGe/cqHuyrlJpaDrt0sncA/SsPuWEtbtVI+bJDugVsmS+W
         8JxjzBZE2A889AvntyNYHiufCX+p9pjB8ntpbxCfZaESlwX4Dvk0jwuFAE2vg0V5obbW
         t8ML4+WWIBauhQGG/lECIF2GX9n1e6tnwiF/V/7L9HccFatZn1RYxqFEySVuvgmyFL1r
         vQm+ATxUGoUhDWrjWyawmPQeZgvl55Z2jJXZ7p31jI2M9OSU5FcijkqGNkfHKKKMaWzI
         DNMHx4UIQpb9IwYMRSmVROfHgDAFE0vj+fcUxmYvFJ7aAiauxG8uuzBCqzx/LrygpW+2
         FdBw==
X-Gm-Message-State: AOAM530WeKwBF6Oep6ads1I8JxytFyJBUYj55k/Pl7KAdMAnP1nxh2+/
        mYQl6Cvl65WbmanjV5P+muc=
X-Google-Smtp-Source: ABdhPJzK53CSyFzzrLjQU1NOR9Uf8WFEPe1N+qwKAynVypKETcB7QpRgkVm3zeVCjjuq3E9XRgE3hQ==
X-Received: by 2002:a63:5d1c:0:b0:39c:c5d7:ebbb with SMTP id r28-20020a635d1c000000b0039cc5d7ebbbmr5196110pgb.54.1652470452660;
        Fri, 13 May 2022 12:34:12 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:5607])
        by smtp.gmail.com with ESMTPSA id ij9-20020a170902ab4900b0015e8d4eb1e3sm2208726plb.45.2022.05.13.12.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 12:34:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 13 May 2022 09:34:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Phil Auld <pauld@redhat.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH] kseltest/cgroup: Make test_stress.sh work if run
 interactively
Message-ID: <Yn6ysifWwBF6xVTa@slm.duckdns.org>
References: <20220513190928.676841-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513190928.676841-1-longman@redhat.com>
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

On Fri, May 13, 2022 at 03:09:28PM -0400, Waiman Long wrote:
> Commit 54de76c01239 ("kselftest/cgroup: fix test_stress.sh to use OUTPUT
> dir") changes the test_core command path from . to $OUTPUT. However,
> variable OUTPUT may not be defined if the command is run interactively.
> Fix that by using ${OUTPUT:-.} to cover both cases.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-5.19.

Thanks, much appreciated.

-- 
tejun
