Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2E47CBE87
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 11:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbjJQJIl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 05:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbjJQJI1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 05:08:27 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BC08E
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 02:08:25 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c9fa869a63so21563405ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 02:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697533705; x=1698138505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViNyz7MVEy68sAHHL0LA4TbUsB4+tEyuC2ph9hmOQwY=;
        b=eUt6x8c7KkXZ6wN1e7NR9BuLhPGz14nQ98uqvgdiAE5956JN2tlMEA/Ra7D3QOs6ZG
         EBqemBDAwsmpjH2KdA4kA3VrQe/qchiL/lq99AZFosULW+7TkUlEO/lEnfkRMOiID13G
         OGiAWRfOdVM4TNRhDpDdXH3MMNqF6qJ4TcbSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697533705; x=1698138505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ViNyz7MVEy68sAHHL0LA4TbUsB4+tEyuC2ph9hmOQwY=;
        b=NzOotPVMPity391QM34l3ZCyij9l9J5myiX8+UCRWDO+V0vJnQpoeH9TmSTNcuLoUD
         SCNLvb75yhK/Yc38nfgElR+BrNM/XQRcZTvW4bQp4w/tjhchVCdePV4lX/SpsB5HbMzz
         xoTHKnzF1u68x2RNcWgNqM/XxYkTuTQK1Vc29SwtCYMN7hMprolZ2ntC/7+xhInGf7Rz
         Uo2Jwn4vRs977Mok/DpcgSWg8N7eCwrAvadQtaBBP4D88dm90uwMI6jlektqlqszlYxk
         Z4HSTBe0ViCq1Mo1aC27zkSurGyPRmqNJ2gTh8MCflbSowSSPCIN/CWVy7wUx9/H/zeK
         Kgsg==
X-Gm-Message-State: AOJu0Yy+OwEHWFhdOmoIC8iFw/TRV8AWOD1gGDtGf+S5pyg4mF3dEnWD
        7Tx4Y8wy9uonKO5DbzLOD93Y5A==
X-Google-Smtp-Source: AGHT+IHMQjs3CP1M6u0EHjQpywUiPuYTFdj8fIiwHgzFn3k/gAIRbOULG1q5OcNoW72tl/neYPQw3A==
X-Received: by 2002:a17:902:e749:b0:1c9:b187:4d84 with SMTP id p9-20020a170902e74900b001c9b1874d84mr2075293plf.14.1697533704959;
        Tue, 17 Oct 2023 02:08:24 -0700 (PDT)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id ij25-20020a170902ab5900b001b890b3bbb1sm1019372plb.211.2023.10.17.02.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:08:24 -0700 (PDT)
From:   jeffxu@chromium.org
To:     akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        sroettger@google.com, willy@infradead.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org
Cc:     jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, surenb@google.com, alex.sierra@amd.com,
        apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
        axelrasmussen@google.com, ben@decadent.org.uk,
        catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
        ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
        corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Subject: [RFC PATCH v2 6/8] mseal: Check seal flag for mremap(2)
Date:   Tue, 17 Oct 2023 09:08:13 +0000
Message-ID: <20231017090815.1067790-7-jeffxu@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231017090815.1067790-1-jeffxu@chromium.org>
References: <20231017090815.1067790-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

mremap(2) can shrink/expand a VMA, or move a VMA to a fixed
address and overwriting or existing VMA. Sealing will
prevent unintended mremap(2) call.

What this patch does:
When a mremap(2) is invoked, if one of its VMAs has MM_SEAL_MREMAP
set from previous mseal(2) call, this mremap(2) will fail, without
any VMA modified.

This patch is based on following:
1. At syscall entry point: SYSCALL_DEFINE5(mremap,...)
There are two cases:
a. going into mremap_to().
b. not going into mremap_to().

2. For mremap_to() case.
Since mremap_to() is called only from SYSCALL_DEFINE5(mremap,..),
omit changing signature of mremap_to(), i.e. not passing
checkSeals flag.
In mremap_to(), it calls can_modify_mm() for src address and
dst address (when MREMAP_FIXED is used), before any update is
made to the VMAs.

3. For non mremap_to() case.
It is still part of SYSCALL_DEFINE5(mremap,...).
It calls can_modify_mm() to check sealing in the src address,
before any update is made to src VMAs.
Check for dest address is not needed, because dest memory is
allocated in current mremap(2) call.

Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 mm/mremap.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/mm/mremap.c b/mm/mremap.c
index ac363937f8c4..691fc32d37e4 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -836,7 +836,27 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 	if ((mm->map_count + 2) >= sysctl_max_map_count - 3)
 		return -ENOMEM;
 
+	/*
+	 * Check src address for sealing.
+	 *
+	 * Note: mremap_to() currently called from one place:
+	 * SYSCALL_DEFINE4(pkey_mprotect, ...)
+	 * and not in any other places.
+	 * Therefore, omit changing the signature of mremap_to()
+	 * Otherwise, we might need to add checkSeals and pass it
+	 * from all callers of mremap_to().
+	 */
+	if (!can_modify_mm(mm, addr, addr + old_len, MM_SEAL_MREMAP))
+		return -EACCES;
+
 	if (flags & MREMAP_FIXED) {
+		/*
+		 * Check dest address for sealing.
+		 */
+		if (!can_modify_mm(mm, new_addr, new_addr + new_len,
+				   MM_SEAL_MREMAP))
+			return -EACCES;
+
 		ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
 		if (ret)
 			goto out;
@@ -995,6 +1015,11 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		goto out;
 	}
 
+	if (!can_modify_mm(mm, addr, addr + old_len, MM_SEAL_MREMAP)) {
+		ret = -EACCES;
+		goto out;
+	}
+
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
-- 
2.42.0.655.g421f12c284-goog

