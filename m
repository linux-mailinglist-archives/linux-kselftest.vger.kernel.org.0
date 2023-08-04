Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25426770863
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 21:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjHDTAf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 15:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjHDTAd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 15:00:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C7B46BD
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Aug 2023 11:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691175582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8TRlrLFCMco4XO+xD44hANqOAJKBhYI/ogDyetWODDc=;
        b=DkvzRZsw6AnsiH0hnBoIaVgjbubMegcslV/GzKI/nS1/+WQ3Nb+5nSACkOhQ3PUEOzV+vb
        UJF094doG/8mjk2AH7HAnyaYODadgRJXJnHi0E1tUEkPvRQmRzVgzsohm/Blc9w3q/zBYi
        nv6SODTQGM7fRUsMPA/tyGKJ+omCs8c=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-VuLlMn8vOieANp3nYhzUsA-1; Fri, 04 Aug 2023 14:59:40 -0400
X-MC-Unique: VuLlMn8vOieANp3nYhzUsA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7659924cf20so256459585a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Aug 2023 11:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691175580; x=1691780380;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TRlrLFCMco4XO+xD44hANqOAJKBhYI/ogDyetWODDc=;
        b=Uujah9El8f0NTOoqBGke4UfDBtdw+52dtnYg1GIAbdJC5CE7JNJEUw/specrYybm3J
         NlxyzXfK52+/cyN8eDdhMiODE4Do5rYq5cuiYHaBkmrLIi0PpLppEq6/0s+AnlUn72sM
         rXy7rrP7781QkpEioqU0LCUhFfTbe7Fdl88dTFj1/TmDugNSlmrnbqNeEtyDaoZhWUTL
         RFBHBPi9vN3m4Cme7xbMnCaI4tqsfpxjr+vcaKtPGfJ/3w/pYwoMUghm0o1DEVPlMBMq
         U+CWSzExadvshAi722x81wrPSbdKy77f+2yhJVkgdTkkwPHD+On++HqteqJduFAqY1Rz
         gkXQ==
X-Gm-Message-State: AOJu0YzfLt32Nfgmz4lEysHqKCuIU5qkSnEiL4LJJAL67vrzgtPB9HtH
        hYTVcqUEWmXxluzXAx0lIpq7sC80sFfu0Vbte9ZVM00R+FArKerg1ynToygKc6UaTq5Geh+4for
        hqwwCwqIt2OiIq1+GJ9rtAjdFMWEX
X-Received: by 2002:a0c:eb02:0:b0:63c:d901:d5d5 with SMTP id j2-20020a0ceb02000000b0063cd901d5d5mr2546173qvp.34.1691175579970;
        Fri, 04 Aug 2023 11:59:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd/MtSKV8LZK8i31DkhA+HpBPtfBIuzuujDU0hnNApM9DNuN22ObPimY7Yz0Q78IzG0Slmcw==
X-Received: by 2002:a0c:eb02:0:b0:63c:d901:d5d5 with SMTP id j2-20020a0ceb02000000b0063cd901d5d5mr2546163qvp.34.1691175579724;
        Fri, 04 Aug 2023 11:59:39 -0700 (PDT)
Received: from fedora ([174.89.37.244])
        by smtp.gmail.com with ESMTPSA id y14-20020a0ce04e000000b0063f7a2847bcsm32703qvk.51.2023.08.04.11.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 11:59:38 -0700 (PDT)
Date:   Fri, 4 Aug 2023 14:59:28 -0400
From:   Lucas Karpinski <lkarpins@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: cgroup: fix test_kmem_memcg_deletion false
 positives
Message-ID: <x2zp6vbr5c3oa3xyfctj66y4ikdxtuo7wsqamkqgyt5ppu6ccb@vwxzimqvrhgk>
References: <edpx3ejic2cxolhoynxvwal2i4a35akopg6hshcfxker6oxcn7@l32pzfyucgec>
 <20230804163716.GA337691@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804163716.GA337691@cmpxchg.org>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 04, 2023 at 12:37:16PM -0400, Johannes Weiner wrote:
> On Fri, Aug 04, 2023 at 11:37:33AM -0400, Lucas Karpinski wrote:
> > The test allocates dcache inside a cgroup, then destroys the cgroups and
> > then checks the sanity of numbers on the parent level. The reason it
> > fails is because dentries are freed with an RCU delay - a debugging
> > sleep shows that usage drops as expected shortly after.
> > 
> > Insert a 1s sleep after completing the cgroup creation/deletions. This
> > should be good enough, assuming that machines running those tests are
> > otherwise not very busy. This commit is directly inspired by Johannes
> > over at the link below.
> > 
> > Link: https://lore.kernel.org/all/20230801135632.1768830-1-hannes@cmpxchg.org/
> > 
> > Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
> 
> Maybe I'm missing something, but there isn't a limit set anywhere that
> would cause the dentries to be reclaimed and freed, no? When the
> subgroups are deleted, the objects are just moved to the parent. The
> counters inside the parent (which are hierarchical) shouldn't change.
> 
> So this seems to be a different scenario than test_kmem_basic. If the
> test is failing for you, I can't quite see why.
>
You're right, the parent inherited the counters and it should behave
the same whether I'm directly removing the child or if I was moving it
under another cgroup. I do see the behaviour you described on my
x86_64 setup, but the wrong behaviour on my aarch64 dev. platform. I'll
take a closer look, but just wanted to leave an example here of what I
see.

Example of slab size pre/post sleep:
slab_pre = 18164688, slab_post = 3360000

Thanks,
Lucas

