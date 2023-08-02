Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A21276D6FC
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 20:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjHBSmH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 14:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHBSmG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 14:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095A51BF0
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Aug 2023 11:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691001677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=1UYMawsk0oCgqDs8Xb3YIEArI5yAvmzUq9f9k4hm6BI=;
        b=W9nA/g8AbvhKkRyD8y5SWla6yhuSnSEKfURHKnpY5nnGG3k6i8gTkSITTsvrj7B/IuDUFY
        LyIjkOdl7IPNEF8bcEfcpk8q+oqvDXlf7OnbWjFDr+JNJW25F5rdyPqj2IwU/56kgZBS46
        Jn7YIldr7ekwXnKJv9JVF9W8SXqBXfM=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-6mK1vcyuNNGEdUHqv2yjXA-1; Wed, 02 Aug 2023 14:41:16 -0400
X-MC-Unique: 6mK1vcyuNNGEdUHqv2yjXA-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-56ca7604435so53799eaf.3
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Aug 2023 11:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691001675; x=1691606475;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1UYMawsk0oCgqDs8Xb3YIEArI5yAvmzUq9f9k4hm6BI=;
        b=JR5ys2r7q1eFBJRdVkQRcLDWkwpXlRHVjyDmCdVS1zOs4QYocRvKzAH0yVtjak3xjI
         hdHOshUXPRS9Z9K7RVgBVGlMT4j8QwSpKjXTGcemKhvHNDm/+yOLHr+ILzY3jAkFuBFb
         6l1TZMDfSWeOLSxjYm4olu3kdTA0LWTrGyIMBypRLcZp7yupkcObmfE6bIu2SG8J/sEr
         ajd9/usgXb2uE6EocuWqTdp6BE/FzZ9FzGBvtaUsNPg8U3QpthjY+8dV/UGYdRs/t9u8
         k82k42zEkU2TkTeAt4Pn3+QxkUxzccbDyuXY6pPA4CSPuGhRSEuVRt3tLEN9xDN5PrlE
         pDpw==
X-Gm-Message-State: ABy/qLaz7G6uxsZ+MCWC1r14kQzLNpVJrGA5By9TzGEQg8lVxqWKDY/l
        8wLmu1yumQH+L8JZSQxXUmlC2z4X+ixYfDk2Zdw0Uo1k3Vr+xKlWj6m2zvwrmtaKXwDRy5ursDG
        XqBU7lnBpsFx03lrTw7kYaxsdrceS
X-Received: by 2002:a05:6358:5918:b0:130:e0a9:a7b4 with SMTP id g24-20020a056358591800b00130e0a9a7b4mr7076770rwf.13.1691001675291;
        Wed, 02 Aug 2023 11:41:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF1osoJlfc9v59xe7LwsMDO2S8I2onE4ro0S+jGWhtYYkSU3sePcQ+wmFSxNttOEIGLNBil8w==
X-Received: by 2002:a05:6358:5918:b0:130:e0a9:a7b4 with SMTP id g24-20020a056358591800b00130e0a9a7b4mr7076758rwf.13.1691001674997;
        Wed, 02 Aug 2023 11:41:14 -0700 (PDT)
Received: from fedora ([174.89.37.244])
        by smtp.gmail.com with ESMTPSA id d28-20020a0caa1c000000b006363f2c37f0sm5742380qvb.91.2023.08.02.11.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 11:41:14 -0700 (PDT)
Date:   Wed, 2 Aug 2023 14:41:05 -0400
From:   Lucas Karpinski <lkarpins@redhat.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev, tj@kernel.org,
        lizefan.x@bytedance.com, shuah@kernel.org
Cc:     muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kselftests: cgroup: fix kmem test slab1 check
Message-ID: <m6jbt5hzq27ygt3l4xyiaxxb7i5auvb2lahbcj4yaxxigqzu5e@5rn6s2yjzv7u>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

test_kmem_basic creates 100,000 negative dentries, with each one mapping
to a slab object. After memory.high is set, these are reclaimed through
the shrink_slab function call which reclaims all 100,000 entries. The test
passes the majority of the time because when slab1 is calculated, it is
often above 0, however, 0 is also an acceptable value.

Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
---
 tools/testing/selftests/cgroup/test_kmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index 258ddc565deb..ba0a0bfc5a98 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -71,7 +71,7 @@ static int test_kmem_basic(const char *root)
 
 	cg_write(cg, "memory.high", "1M");
 	slab1 = cg_read_key_long(cg, "memory.stat", "slab ");
-	if (slab1 <= 0)
+	if (slab1 < 0)
 		goto cleanup;
 
 	current = cg_read_long(cg, "memory.current");
-- 
2.41.0

