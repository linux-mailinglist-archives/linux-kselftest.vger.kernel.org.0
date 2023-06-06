Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F132F724C50
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 21:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239392AbjFFTFo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 15:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239367AbjFFTEu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 15:04:50 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26756173A
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Jun 2023 12:04:35 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-65320a6e90dso1617139b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jun 2023 12:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686078275; x=1688670275;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCnAmjEfrZv4hWergm9cCKqGSfxeJstUIVXgvQlsrbM=;
        b=0RfjN0vYiusk5ioCQS1nAlCQ9SwNbpNkrAGoCc3DzbyiTfogeskfW/k35AUHJjbjvh
         qcmNficgsPHY7IzjLRZ7Fx7yHknnSVBialc9Lm2HDy+G56wJLuQdJfrCE1L/whTYztSX
         0nMD1VG7QI0IeJ7NlJ0RqSFpSkllQWKP+8SH5M4Tworj/X9kHQ6JcXzt+NcdmrYuQcSD
         ftcLroNPDkUfGiCVt5bzuOWxk/1vZL8CVOd3YhjEG4x4yYR8uQvEHMIVWqF9xF36YlZ+
         oP2GU9HlO/y1x/wbpPSXD25KiOaXofjmCzoeXIdkiuAzfcG5mWunKS1qCnW27bnXJIzu
         pIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078275; x=1688670275;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCnAmjEfrZv4hWergm9cCKqGSfxeJstUIVXgvQlsrbM=;
        b=EmAO9NmNkj+9VxKlZDwiEKM3xSY5X9n5vNNNSlt7RvcYHSYkiT1VNiIZd/KPrcdENl
         OsnnUuZOcJuNRfo7/dd3W5IL16nX4fxPPrXXJslP6eO1NA2yF7N+hsB4EbNMH8R356u5
         Cm6Sg1fl2KAxChGxExeAqOOYBWR9vfWvOpac9cVaJ7ZOXJJCIszQcnG+84VrIiMh3Im5
         JPatCtqVtSlVr5xBmyJFi8I73peB+D6p5ihaLmdCGdl0Ewgrp02RCTuiBhssTfr8GsJx
         tDV7Xap+QyAJjiCPUD4b6ZGA084+UT3wnjrr33htaXtt79fw1bQQIH9aDwlT0ub/dYlV
         hKYQ==
X-Gm-Message-State: AC+VfDznf4ch/cKtfxLCXSh9pVK5U4NhjGF9en6XpnRBR8kO0ojUkBDz
        lzLX6wwvMnoOwrSbMD7R+7d9lFHJKXwpB31Bug==
X-Google-Smtp-Source: ACHHUZ7oX0XJdw6EGaS/GrZQZU2JbZA6pR7i2na5qTVNAmby/QbfNP6VXG9VMvls4TqYrSTNJjMknJRBHdMlJ61Amg==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:6a00:148d:b0:63b:234e:d641 with
 SMTP id v13-20020a056a00148d00b0063b234ed641mr1369654pfu.4.1686078275306;
 Tue, 06 Jun 2023 12:04:35 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:03:57 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <0c1144b9c5cd620cd0acf7ee033fef8d311b97ba.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 12/19] mm: truncate: Expose preparation steps for truncate_inode_pages_final
From:   Ackerley Tng <ackerleytng@google.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, pbonzini@redhat.com, seanjc@google.com,
        shuah@kernel.org, willy@infradead.org
Cc:     brauner@kernel.org, chao.p.peng@linux.intel.com,
        coltonlewis@google.com, david@redhat.com, dhildenb@redhat.com,
        dmatlack@google.com, erdemaktas@google.com, hughd@google.com,
        isaku.yamahata@gmail.com, jarkko@kernel.org, jmattson@google.com,
        joro@8bytes.org, jthoughton@google.com, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, liam.merwick@oracle.com,
        mail@maciej.szmigiero.name, mhocko@suse.com, michael.roth@amd.com,
        qperret@google.com, rientjes@google.com, rppt@kernel.org,
        steven.price@arm.com, tabba@google.com, vannapurve@google.com,
        vbabka@suse.cz, vipinsh@google.com, vkuznets@redhat.com,
        wei.w.wang@intel.com, yu.c.zhang@linux.intel.com,
        kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, x86@kernel.org,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This will allow preparation steps to be shared

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/mm.h |  1 +
 mm/truncate.c      | 24 ++++++++++++++----------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1f79667824eb..7a8f6b810de0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3053,6 +3053,7 @@ extern unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info);
 extern void truncate_inode_pages(struct address_space *, loff_t);
 extern void truncate_inode_pages_range(struct address_space *,
 				       loff_t lstart, loff_t lend);
+extern void truncate_inode_pages_final_prepare(struct address_space *mapping);
 extern void truncate_inode_pages_final(struct address_space *);
 
 /* generic vm_area_ops exported for stackable file systems */
diff --git a/mm/truncate.c b/mm/truncate.c
index 7b4ea4c4a46b..4a7ae87e03b5 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -449,16 +449,7 @@ void truncate_inode_pages(struct address_space *mapping, loff_t lstart)
 }
 EXPORT_SYMBOL(truncate_inode_pages);
 
-/**
- * truncate_inode_pages_final - truncate *all* pages before inode dies
- * @mapping: mapping to truncate
- *
- * Called under (and serialized by) inode->i_rwsem.
- *
- * Filesystems have to use this in the .evict_inode path to inform the
- * VM that this is the final truncate and the inode is going away.
- */
-void truncate_inode_pages_final(struct address_space *mapping)
+void truncate_inode_pages_final_prepare(struct address_space *mapping)
 {
 	/*
 	 * Page reclaim can not participate in regular inode lifetime
@@ -479,7 +470,20 @@ void truncate_inode_pages_final(struct address_space *mapping)
 		xa_lock_irq(&mapping->i_pages);
 		xa_unlock_irq(&mapping->i_pages);
 	}
+}
 
+/**
+ * truncate_inode_pages_final - truncate *all* pages before inode dies
+ * @mapping: mapping to truncate
+ *
+ * Called under (and serialized by) inode->i_rwsem.
+ *
+ * Filesystems have to use this in the .evict_inode path to inform the
+ * VM that this is the final truncate and the inode is going away.
+ */
+void truncate_inode_pages_final(struct address_space *mapping)
+{
+	truncate_inode_pages_final_prepare(mapping);
 	truncate_inode_pages(mapping, 0);
 }
 EXPORT_SYMBOL(truncate_inode_pages_final);
-- 
2.41.0.rc0.172.g3f132b7071-goog

