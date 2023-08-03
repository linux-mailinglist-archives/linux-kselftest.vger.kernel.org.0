Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3B576F1CB
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 20:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjHCSZ6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 14:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjHCSZ5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 14:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC0F115
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 11:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691087112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Bg75TmGjdsFOEFOAfLLtRHbxB/2lhyot0KBO00fo9Xg=;
        b=ThP0J0aiU3n3zcBF3JH6Os/gpwh4SnKcVlIqbsrJ+i6/zT0Lv93NEwx/MWAh+2jvZV0e+E
        1zGp51Rg3opxUIeqjRqnQ7k2inBxbRw+bSiylvuozMcwzdCDFw/+81nPYmbFOwckqm+vnH
        zLH1OxvmnUyP/TLuhYXXJ3AjLVQGA+M=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-yDp3XKj7Ngy5fyIdJg0SGw-1; Thu, 03 Aug 2023 14:25:11 -0400
X-MC-Unique: yDp3XKj7Ngy5fyIdJg0SGw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76cbb1e9420so119709085a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Aug 2023 11:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691087110; x=1691691910;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bg75TmGjdsFOEFOAfLLtRHbxB/2lhyot0KBO00fo9Xg=;
        b=BF1fZiYKyEdkoWRkpPt4Y80rR0A+ruV/MgGgg4SwCT4vd3Jmr0T8/d3kQ1xQOdy9RU
         NPl8hKuja4N/HwFEouXrF+j/PINvmja1jT/L60nR8/ytC3G+eKUOq0GWBKvHZjWcfOkY
         jjMYrWg5+qNJX0DLJodFUF1M72lOBR28crcYXMmFa9QhTJIH/+FjmgEB8LMt4YSqdTD0
         LQ4pNNTZhj+Vh9DjXHVYNuqGDy3nkA9xMeEoeWmP8F23otjzGfBf0BcZDM7kINuj0drN
         odiUbYP3dNu7kdtNGwDLz7BD5m2FnV01dJagHcmjFGKLa6qvxuWhOFp0s0ZQm65EsekR
         VURQ==
X-Gm-Message-State: ABy/qLZIsyc9uDtEDRblF7FdcLbA79Rd/HrqTZUUIDb7UAVwL8cA5QyG
        CEhkRLw18tnPmaUB+IqJbMrfa6FbSp9a5exQTWH9SPwXwBqXalkd6XZpHfDoSuHX0thi70hqfYJ
        ddBiVQT247/z3zLChq0fq3Fi0MvTN
X-Received: by 2002:a05:620a:2411:b0:767:e993:5702 with SMTP id d17-20020a05620a241100b00767e9935702mr19254477qkn.35.1691087110597;
        Thu, 03 Aug 2023 11:25:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG8u1dArhCtl/gFW5cvCnwFM7M0fcDbBkzHRi/22XXRQTF7dNuPgLM+jSKKGLekwW/FPx8bXA==
X-Received: by 2002:a05:620a:2411:b0:767:e993:5702 with SMTP id d17-20020a05620a241100b00767e9935702mr19254462qkn.35.1691087110340;
        Thu, 03 Aug 2023 11:25:10 -0700 (PDT)
Received: from fedora ([174.89.37.244])
        by smtp.gmail.com with ESMTPSA id dq15-20020a05622a520f00b0040c72cae9f9sm105382qtb.93.2023.08.03.11.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 11:25:09 -0700 (PDT)
Date:   Thu, 3 Aug 2023 14:25:00 -0400
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
Subject: [PATCH v3] selftests: cgroup: fix test_kmem_basic slab1 check
Message-ID: <zff2gqiy4cggy4px2hbcyna6eipy56qc4itx5cx5agtxlzdxt7@dvfdarqkucac>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

test_kmem_basic creates 100,000 negative dentries, with each one mapping
to a slab object. After memory.high is set, these are reclaimed through
the shrink_slab function call which reclaims all 100,000 entries. The
test passes the majority of the time because when slab1 is calculated,
it is often above 0, however, 0 is also an acceptable value.

Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
---
 v3: rebased on mm-unstable

 tools/testing/selftests/cgroup/test_kmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index 1b2cec9d18a4..67cc0182058d 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -75,7 +75,7 @@ static int test_kmem_basic(const char *root)
 	sleep(1);
 
 	slab1 = cg_read_key_long(cg, "memory.stat", "slab ");
-	if (slab1 <= 0)
+	if (slab1 < 0)
 		goto cleanup;
 
 	current = cg_read_long(cg, "memory.current");
-- 
2.41.0

