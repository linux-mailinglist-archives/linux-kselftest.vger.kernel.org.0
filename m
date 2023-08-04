Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9208D77061A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 18:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjHDQhW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 12:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjHDQhV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 12:37:21 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1842BE7
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Aug 2023 09:37:19 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-63cfd6e3835so13645916d6.3
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Aug 2023 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1691167038; x=1691771838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iUJy9CxyJyDezGa57jwVulgOP6Mhmh9lxMHoUFNxQOg=;
        b=N8zywGIpRTGhPC/hd5Uaa9XnP65QfObz3MOaQDHYBSgg96x0lu4ubKHgZyvQjRg+92
         VimNYt6Qi+T2OSX2whxjKdAwU5/KjPFJAJ8FQDdIS6jXwklryXprXrKQGXj9+OlCaDkz
         3BPikSVV1zG++16OImjNF+EnR6jfDlpZjFzRRbEI2TKM1ALXkZgWSYisS9iRkCf9uPpL
         wBCvyMsghryoppGBxdYYnIv8JITuv327O30KANkFj9SkQRGLPKdUnIYxkMPnuCb+6MV2
         utPvzU/Zd0n7b7YmTIV2gNEhgfjpPjenS3EcryRbLfQHd44dgYs/kyhVn6CXzmHTcpuN
         jP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691167038; x=1691771838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUJy9CxyJyDezGa57jwVulgOP6Mhmh9lxMHoUFNxQOg=;
        b=GI4jcG2ulejJjFDX0LtDK4i9ZaHzmQYRXwBKzfZgDfGncCkG4g1pSHrcuQk501MObm
         6Z0qgV323khZFBz1pqWJP3j9DUZSCHU/axioVwc2XxVNXGr4guUjzvUl46DGTxWsOvTS
         Tc/NfPWEaUP/aI6bOthCu55k4zygpL+FaTU9rke/HOYRO2GachwunsXOQp+ER8Y9TGtB
         cN9d0QRn2abHLNDG03SvtHJvaSGcnIGxN5ZAd4/lvMCMs8+1D+h4msi22ZuJlKPPdgui
         Fp+UPDOhN/Auz6I7S6CmkFu23SotB6eYLVWcEdYKVz9Q5RkfND41lzBDVfzEmaq9VfPB
         Nskw==
X-Gm-Message-State: AOJu0Yx35OITHUhrq+mAcQSgfyIQww2WUaB5yIU2v+0jDWINy+nPowes
        fVWIkXRyB2kkjt3ttSUmTbVmjg==
X-Google-Smtp-Source: AGHT+IGvEQu5HgCOytuEIOWYX6CR56Y/2e5JSlxsagFnROkz1i4u6xSjaOns8WHVi48AGsOpTahDqQ==
X-Received: by 2002:a0c:e10a:0:b0:62d:f806:7f80 with SMTP id w10-20020a0ce10a000000b0062df8067f80mr2235164qvk.13.1691167038197;
        Fri, 04 Aug 2023 09:37:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:9910])
        by smtp.gmail.com with ESMTPSA id e29-20020a0cb45d000000b00632266b569esm782221qvf.87.2023.08.04.09.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 09:37:17 -0700 (PDT)
Date:   Fri, 4 Aug 2023 12:37:16 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Lucas Karpinski <lkarpins@redhat.com>
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
Message-ID: <20230804163716.GA337691@cmpxchg.org>
References: <edpx3ejic2cxolhoynxvwal2i4a35akopg6hshcfxker6oxcn7@l32pzfyucgec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edpx3ejic2cxolhoynxvwal2i4a35akopg6hshcfxker6oxcn7@l32pzfyucgec>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 04, 2023 at 11:37:33AM -0400, Lucas Karpinski wrote:
> The test allocates dcache inside a cgroup, then destroys the cgroups and
> then checks the sanity of numbers on the parent level. The reason it
> fails is because dentries are freed with an RCU delay - a debugging
> sleep shows that usage drops as expected shortly after.
> 
> Insert a 1s sleep after completing the cgroup creation/deletions. This
> should be good enough, assuming that machines running those tests are
> otherwise not very busy. This commit is directly inspired by Johannes
> over at the link below.
> 
> Link: https://lore.kernel.org/all/20230801135632.1768830-1-hannes@cmpxchg.org/
> 
> Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>

Maybe I'm missing something, but there isn't a limit set anywhere that
would cause the dentries to be reclaimed and freed, no? When the
subgroups are deleted, the objects are just moved to the parent. The
counters inside the parent (which are hierarchical) shouldn't change.

So this seems to be a different scenario than test_kmem_basic. If the
test is failing for you, I can't quite see why.
