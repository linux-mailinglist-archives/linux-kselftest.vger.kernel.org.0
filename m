Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5958176EEF0
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 18:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbjHCQCL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 12:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237330AbjHCQB6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 12:01:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC91D3C21
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 09:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691078466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=cwXRj1KBICVmDyXNwF6/K1df3vGE/T6x9GRpnMzQtuM=;
        b=N7cPTW7PELdCNR7kAvryNsreyMdVf3rfOHCmOnpbcwBCJlH+uj0Y5891GnSeKmn2iL2wUM
        2ZqsbNFr4GHIHbcNtuV3KsvbQWBjTAvuUclG4hlkIcE2Tc0C3gDM+vAlWuOMG5EWunhgHW
        T1QPSGrN/f0CYbiFcTuluUeGZ6KaJE8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-EiJFcPc9Mly3YhvZ1ULh6g-1; Thu, 03 Aug 2023 12:01:01 -0400
X-MC-Unique: EiJFcPc9Mly3YhvZ1ULh6g-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-63d245b67abso11438136d6.3
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Aug 2023 09:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691078458; x=1691683258;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwXRj1KBICVmDyXNwF6/K1df3vGE/T6x9GRpnMzQtuM=;
        b=WW9IID73Sb/Qk5ugxlcY42pV2buaoH28rmkcV/dqeY66HFW/W1ZxzBozCRmoR2kpNI
         Mi+3k6WLbNeZRovjwHlixohypSPlFRHgUTMPuw/lrwZlcP31iwStuicO6GdBiV50OUD+
         o/rRCWs3H95UOuv3gYocBgjxXxGSR/IVEDLsNMDF2SvpR+sGDMsjfanqvea8jR5YPk1x
         Wqrz5O/BNv52psawMfrxIrA58Jj0jNvOePi08Xq2WZcTUc+e6fcsCvqKgD2DVczZWtaV
         gmu/LSIZTY/+I8uUnSUtrtqOaT2j1kZx3p8dT7uoxNyG3LsnebUFH/8EoY/utcyX3a9I
         vG7w==
X-Gm-Message-State: ABy/qLZJgIIxUKOrfjgt1uuaW5tYnybWeWfSJQj6+Z3QSxKmSl+fTsya
        hWKoPAjLpGlRLgLfqAGfj1N/HubQeYgUDshc/mmQrXAeojDDTKIBaWP/nzlVAwhKHOKdpRcaLi3
        Tk6qcg6IwSuBdteBFJQo/GWX0rBUi
X-Received: by 2002:a0c:cb86:0:b0:63d:b75:c971 with SMTP id p6-20020a0ccb86000000b0063d0b75c971mr19142302qvk.15.1691078457937;
        Thu, 03 Aug 2023 09:00:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFCc7WuuoDe+WhLh9WzsibbctR6fIN91ahYBGVYqFqyM7r8CuW7h/Cye78YzhzmJhvadLpnLg==
X-Received: by 2002:a0c:cb86:0:b0:63d:b75:c971 with SMTP id p6-20020a0ccb86000000b0063d0b75c971mr19142272qvk.15.1691078457517;
        Thu, 03 Aug 2023 09:00:57 -0700 (PDT)
Received: from fedora ([174.89.37.244])
        by smtp.gmail.com with ESMTPSA id w19-20020a0cdf93000000b0062de6537febsm2729qvl.58.2023.08.03.09.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:00:57 -0700 (PDT)
Date:   Thu, 3 Aug 2023 12:00:47 -0400
From:   Lucas Karpinski <lkarpins@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: cgroup: fix test_kmem_basic slab1 check
Message-ID: <ix6vzgjqay2x7bskle7pypoint4nj66fwq7odvd5hektatvp2l@kukoifnfj3dr>
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
https://lore.kernel.org/all/m6jbt5hzq27ygt3l4xyiaxxb7i5auvb2lahbcj4yaxxigqzu5e@5rn6s2yjzv7u/
V2: Corrected title

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

