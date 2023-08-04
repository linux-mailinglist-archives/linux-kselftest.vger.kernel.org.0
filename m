Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C726077091B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 21:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjHDTgm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 15:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjHDTgk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 15:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED04E7
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Aug 2023 12:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691177753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=/fEGLQTPa3ePRn0SUruCR/akdAF06PibGk+SoDw6oqs=;
        b=EKepgm59iEW0B4OmUB2n2dIYEg80eS9pWxANbLzawBzMWgFpg6+l4s5Ruko2L5Ly5/KabE
        KasgEN0ynKNy8fxLQDBeP7t3iisxryDBy6YvUmnFIr1vCi6Kz3ob9aVvxsa7cmmIMULOFc
        NmCw4HnM4J3dxnEklTAxl+oVQ9xWBlM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-_riD2ztuNEm9K1gKjvzraw-1; Fri, 04 Aug 2023 15:35:51 -0400
X-MC-Unique: _riD2ztuNEm9K1gKjvzraw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7659c6caeaeso319686385a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Aug 2023 12:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691177751; x=1691782551;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fEGLQTPa3ePRn0SUruCR/akdAF06PibGk+SoDw6oqs=;
        b=c+DBjkRuu7E7Awm5xmrewU0fjB+9YdBOM6ffH7uL+ouBLYmeWQ/xcoOnDGxZdMgTXk
         2mBP1jsKGQPOq327eR1UfrEeLyys2jkF9REzDgp5l/uRIym4oeH6wZuMWYfVolAPmDcN
         sYXP32lMkv6RjKE8FAhOQLmxWSdJkwHNhR5A4GAY9uRQ+BJ1nHmzj1Od7BtOLDo363hX
         i6lJs1dTE8ZLCxzPZaaXT4VMxjbhe0ixP8eJeM+uCBekCg2Qj2k+IHMyB3dp9unZDcfv
         GTDPxwP8oX7GlJfRlL5f60sTx/LJCmek0k52FdU8TV9/oRHSxsjA96qt00wyG7NReyxk
         XubA==
X-Gm-Message-State: AOJu0YyZO1+hjBqLG8HWVTPRKCWFDIR+/g6O/gpdfnpynHzxCRNb2q4o
        8vTVDVEtULbkd0keeKHBmYNVvBca7wmsAaBES2ns+SQFSH/xc3hw4kbD5Wo4QDflLlue+pzbo4t
        P6bJguDkEBNH1o8nltrorJhvfgNDmfPA4iMfmzuq0Og==
X-Received: by 2002:a05:620a:4456:b0:76c:b476:f712 with SMTP id w22-20020a05620a445600b0076cb476f712mr3876344qkp.51.1691177751274;
        Fri, 04 Aug 2023 12:35:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+9eMVqPJLY6YIUSKa4NNv1paAfI3JX7M2BAluopih9iKnho0rRGuzu78ZOQHGnUECV5Khzw==
X-Received: by 2002:a05:620a:4456:b0:76c:b476:f712 with SMTP id w22-20020a05620a445600b0076cb476f712mr3876330qkp.51.1691177751036;
        Fri, 04 Aug 2023 12:35:51 -0700 (PDT)
Received: from fedora ([174.89.37.244])
        by smtp.gmail.com with ESMTPSA id 4-20020a05620a070400b0076745f352adsm847974qkc.59.2023.08.04.12.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 12:35:45 -0700 (PDT)
Date:   Fri, 4 Aug 2023 15:35:29 -0400
From:   Lucas Karpinski <lkarpins@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] selftests: cgroup: fix test_kmem_basic less than error
Message-ID: <7d6gcuyzdjcice6qbphrmpmv5skr5jtglg375unnjxqhstvhxc@qkn6dw6bao6v>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

test_kmem_basic creates 100,000 negative dentries, with each one mapping
to a slab object. After memory.high is set, these are reclaimed through
the shrink_slab function call which reclaims all 100,000 entries. The
test passes the majority of the time because when slab1 or current is
calculated, it is often above 0, however, 0 is also an acceptable value.

Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
---
In the previous patch, I missed a change to the variable 'current' even
after some testing as the issue was so sporadic. Current takes the slab
size into account and can also face the same issue where it fails since
the reported value is 0, which is an acceptable value.

Drop: b4abfc19 in mm-unstable
V2: https://lore.kernel.org/all/ix6vzgjqay2x7bskle7pypoint4nj66fwq7odvd5hektatvp2l@kukoifnfj3dr/

 tools/testing/selftests/cgroup/test_kmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index 1b2cec9d18a4..ed2e50bb1e76 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -75,11 +75,11 @@ static int test_kmem_basic(const char *root)
 	sleep(1);
 
 	slab1 = cg_read_key_long(cg, "memory.stat", "slab ");
-	if (slab1 <= 0)
+	if (slab1 < 0)
 		goto cleanup;
 
 	current = cg_read_long(cg, "memory.current");
-	if (current <= 0)
+	if (current < 0)
 		goto cleanup;
 
 	if (slab1 < slab0 / 2 && current < slab0 / 2)
-- 
2.41.0

