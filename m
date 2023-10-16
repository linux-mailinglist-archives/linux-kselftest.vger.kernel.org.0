Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0355B7CABB0
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 16:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjJPOjG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 10:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjJPOjE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 10:39:04 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335BAA2
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 07:39:03 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5859d13f73dso2770751a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 07:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697467142; x=1698071942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ousg6g8beQYrtnIXHdPl+6es+qhdKBwPjUl+0WcHVK4=;
        b=Dn7INWNQd11NxXeBEcslakTeZYKSjZ65GFePmvMWfc9Iua9BL8GGSyI5XPqIZEpUMc
         ieH3GDthP1TkPwazQSkrtzTShl1TskQ808Tbpxc+gixrQ1kmyJmboHOSmOqC9qg6bv1c
         7MpfWFY4W0LYN5P7lclIvJn58df4F6m+1KrFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697467142; x=1698071942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ousg6g8beQYrtnIXHdPl+6es+qhdKBwPjUl+0WcHVK4=;
        b=hkLhT+y174PWH3Dba31tJ86YfL3JdO5JHFZ7IJuiIbz26XO7HvudMaQqwPhTprYG7c
         dYH5XnJxz0JOQBYQBdc0KyVkpAcZqBwzGJdkunub52N75kgyUWPaG1CGIYkMkPZQOWza
         R5m2AHRWBrIq6Oi6Nltfgn3+x8iwl2FG3yc7GgLinHmnpXtyDR5I7+zpZFa2LF1xSdmE
         kwuPJzArVwZS4thckHys8pLrYG2R7AO9eADZUvN3SefF9bI+Aq7dlGsiN/xRmWgPi5Tx
         43AbiGBIABcTpUNg0dDVeCN4+mbTF+ESX47UCBDGFNf5BZiKbMTJlnGHzK90rzAjmwf/
         bArA==
X-Gm-Message-State: AOJu0YxEMVUl3CCP3QvhOYGaHjSU0fcJlxEJXWJpvdj0B9nBRKZ48R6K
        m10VRKAIbKPm+myuYmHWmrPOcg==
X-Google-Smtp-Source: AGHT+IGuDFDSElhARtpju/2TKNXZCv0dyrbDcGQSiLi1n6XeXR2D8iMicnP3qR+LojeqcMvPGZ4Uig==
X-Received: by 2002:a05:6a21:789c:b0:14b:8b82:867f with SMTP id bf28-20020a056a21789c00b0014b8b82867fmr34279713pzc.50.1697467142619;
        Mon, 16 Oct 2023 07:39:02 -0700 (PDT)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id jn21-20020a170903051500b001c726147a45sm8599282plb.190.2023.10.16.07.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 07:39:02 -0700 (PDT)
From:   jeffxu@chromium.org
To:     akpm@linux-foundation.org, keescook@chromium.org,
        sroettger@google.com
Cc:     jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com, surenb@google.com,
        alex.sierra@amd.com, apopple@nvidia.com,
        aneesh.kumar@linux.ibm.com, axelrasmussen@google.com,
        ben@decadent.org.uk, catalin.marinas@arm.com, david@redhat.com,
        dwmw@amazon.co.uk, ying.huang@intel.com, hughd@google.com,
        joey.gouly@arm.com, corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, torvalds@linux-foundation.org,
        lstoakes@gmail.com, willy@infradead.org, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Subject: [RFC PATCH v1 4/8] mseal: seal mprotect
Date:   Mon, 16 Oct 2023 14:38:23 +0000
Message-ID: <20231016143828.647848-5-jeffxu@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016143828.647848-1-jeffxu@chromium.org>
References: <20231016143828.647848-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

check sealing for mprotect(2).

Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 mm/mprotect.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 130db91d3a8c..5b67c66d55f7 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -753,6 +753,12 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		}
 	}
 
+	if (!can_modify_mm(current->mm, start, end, MM_ACTION_MPROTECT,
+			   ON_BEHALF_OF_USERSPACE)) {
+		error = -EACCES;
+		goto out;
+	}
+
 	prev = vma_prev(&vmi);
 	if (start > vma->vm_start)
 		prev = vma;
-- 
2.42.0.609.gbb76f46606-goog

