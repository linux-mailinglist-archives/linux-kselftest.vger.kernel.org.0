Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A1B77BD84
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 17:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjHNP6c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 11:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjHNP6S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 11:58:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E5C10CE
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 08:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692028652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7qH/OU93DvHxo0hLIYaxXR0nJoX5oGDzCEQsY4s9O1c=;
        b=A4GFCdphoNmiW7VBWxTZmhLZp2rXPB1LhchwHvY59q+Vdr62Z46lBuXhrpsLgWTFFaQWsT
        NyorszjeYBrs33U1uTMCW/1ZyOA4CqGPfoOo+PsgtrJCz4YmmvYMR33pNp6Xty3N6M6Vkx
        h2AATDaxKpCW7aEyf6SdNDzxQ6M0Qrw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-k9GslaAxOPy2p9_sf3Qx7w-1; Mon, 14 Aug 2023 11:57:31 -0400
X-MC-Unique: k9GslaAxOPy2p9_sf3Qx7w-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-63cceb8c21aso62273496d6.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 08:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692028651; x=1692633451;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qH/OU93DvHxo0hLIYaxXR0nJoX5oGDzCEQsY4s9O1c=;
        b=CyJYb63QHyE68jVWM6z94FKyzIwvU1UCXR6HFPfLdX6KS+HMtEjHzPCHI4Urj6d+YP
         wIqDUc266ndtPqrCSQI7mZA1EHQB4d69sz5yeXkRFq4bdPIwSG0rqRUPv878RoXz6tve
         NxFBjCh9PD4BgvFtkUkPBN5jUn8tIoOQcXxJ9Dx3I/sod0uv3/Z6TQvfaItcTkIv4tN+
         XsOR+YTN1IuQy0yIQ4aFNHeDxzXXYag6B0mGknMnLTpUtDOpXTTNFzkHs679iCUNW7Kr
         S1QiyqC+kkPwnp6F3MfEcKlVdTY8kyXPfvsgSA2fw2JOOUTPXIsTt/KYANUu6TovhksM
         CYPg==
X-Gm-Message-State: AOJu0YxscXXtvDBkjBVMmfd85RBPymc7xA62TXSrA5xOWezkLABiHtPG
        WRte5FGJtjWcyk4fsCTA4uYL9xjrVt2rZr5L+NyCALO3tPw8XceD5kQXEi+4oX6rbzDWrlxBLjn
        rqq3q1gC3vk7GE2Y4BZMKIgkeJhuo
X-Received: by 2002:a0c:8e45:0:b0:63c:fb61:a201 with SMTP id w5-20020a0c8e45000000b0063cfb61a201mr9439838qvb.35.1692028650889;
        Mon, 14 Aug 2023 08:57:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRANvGEcmQZTMaKhUgzhPKVlKrTJYRQomkCbYmgKk3CSjdb0k3TsBz/oJJyzY8rNaOmV349g==
X-Received: by 2002:a0c:8e45:0:b0:63c:fb61:a201 with SMTP id w5-20020a0c8e45000000b0063cfb61a201mr9439829qvb.35.1692028650657;
        Mon, 14 Aug 2023 08:57:30 -0700 (PDT)
Received: from fedora ([174.89.37.104])
        by smtp.gmail.com with ESMTPSA id d11-20020a05620a166b00b00767d00d10e9sm3078589qko.58.2023.08.14.08.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 08:56:18 -0700 (PDT)
Date:   Mon, 14 Aug 2023 11:55:45 -0400
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
Message-ID: <eex2vdlg4ow2j5bybmav73nbfzuspkk4zobnk7svua4jaypqb5@7ie6e4mci43t>
References: <edpx3ejic2cxolhoynxvwal2i4a35akopg6hshcfxker6oxcn7@l32pzfyucgec>
 <20230804163716.GA337691@cmpxchg.org>
 <x2zp6vbr5c3oa3xyfctj66y4ikdxtuo7wsqamkqgyt5ppu6ccb@vwxzimqvrhgk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x2zp6vbr5c3oa3xyfctj66y4ikdxtuo7wsqamkqgyt5ppu6ccb@vwxzimqvrhgk>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 04, 2023 at 02:59:28PM -0400, Lucas Karpinski wrote:
> On Fri, Aug 04, 2023 at 12:37:16PM -0400, Johannes Weiner wrote:
> > On Fri, Aug 04, 2023 at 11:37:33AM -0400, Lucas Karpinski wrote:
> > > The test allocates dcache inside a cgroup, then destroys the cgroups and
> > > then checks the sanity of numbers on the parent level. The reason it
> > > fails is because dentries are freed with an RCU delay - a debugging
> > > sleep shows that usage drops as expected shortly after.
> > > 
> > > Insert a 1s sleep after completing the cgroup creation/deletions. This
> > > should be good enough, assuming that machines running those tests are
> > > otherwise not very busy. This commit is directly inspired by Johannes
> > > over at the link below.
> > > 
> > > Link: https://lore.kernel.org/all/20230801135632.1768830-1-hannes@cmpxchg.org/
> > > 
> > > Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
> > 
> > Maybe I'm missing something, but there isn't a limit set anywhere that
> > would cause the dentries to be reclaimed and freed, no? When the
> > subgroups are deleted, the objects are just moved to the parent. The
> > counters inside the parent (which are hierarchical) shouldn't change.
> > 
> > So this seems to be a different scenario than test_kmem_basic. If the
> > test is failing for you, I can't quite see why.
> >
> You're right, the parent inherited the counters and it should behave
> the same whether I'm directly removing the child or if I was moving it
> under another cgroup. I do see the behaviour you described on my
> x86_64 setup, but the wrong behaviour on my aarch64 dev. platform. I'll
> take a closer look, but just wanted to leave an example here of what I
> see.
> 
> Example of slab size pre/post sleep:
> slab_pre = 18164688, slab_post = 3360000
> 
> Thanks,
> Lucas
Looked into the failures and I do have a proposed solution, just want
some feedback first. With how the kernel entry in memory.stat is 
updated, it takes into account all charged / uncharged pages, it looks 
like it makes more sense to use that single entry rather than `slab + 
anon + file + kernel_stack + pagetables + percpu + sock' as it would
cover all utilization.

Thanks,
Lucas

