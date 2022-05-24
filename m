Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABB653242D
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 May 2022 09:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbiEXHgd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 May 2022 03:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbiEXHgb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 May 2022 03:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 636F15001F
        for <linux-kselftest@vger.kernel.org>; Tue, 24 May 2022 00:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653377787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uosxK4cQkjZjNxJr746xjmTAMJsu6zGR2xaVMuHwMwY=;
        b=Qt1iBhOsZNcAsFMZbNB4VuLDJlvi/hl1gaXSms6RS/1z22oCqQRgEg5QC5ODww4s7I2REK
        H00RD9N8XXi6V6RJfvZ+GgOHc2NAe+6lHs08x+ZFnaOcVxc5bmEe9ASm/txiuwvIYWTtuy
        8HllEr1mLBzoVk5Nqsuhl1tZ6psYgwU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-XvqnotQjPuCn0hxlqa2RMA-1; Tue, 24 May 2022 03:36:24 -0400
X-MC-Unique: XvqnotQjPuCn0hxlqa2RMA-1
Received: by mail-wr1-f69.google.com with SMTP id r25-20020adfb1d9000000b0020fc56e3f67so1644761wra.2
        for <linux-kselftest@vger.kernel.org>; Tue, 24 May 2022 00:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uosxK4cQkjZjNxJr746xjmTAMJsu6zGR2xaVMuHwMwY=;
        b=vio1XQdcNzkZbjUAgCGLQtASahIH1eueYm9tRHNcEC+fnb96tpE0KC2meJxSjY8dWQ
         sQXN8PtS3E1O19uDZt4oCjoWrZ5N5kq90Fgr0GYGs0j2XrPT3LuI3a6kirtxNcccl9FK
         xGKcjG7oW2wf8RqDaGMPqXaXLZ1a4MTOTJvFQ6IadT9pyAhxFntrsC/0qHiHWuMNv394
         SvIOFj8aho4kuujxtDwQI9I1Jouy65MqZZNJrfwN6X+7nGZpMrUvEbD6Z7h7riEh2seJ
         pPO/Hjyi+nyEy3VWeLOx2TOIysSKEZjFBqCoKnPyx0UWB9X23v1Ca8YyqnNi93wHqzQq
         hu7A==
X-Gm-Message-State: AOAM533fT85PbBxzk9omZ7mFu3yKHqHc1cpd22GTLkFfccNNMhDXt9hF
        eWMQkbzXdRft4LqGxWgl988UMmma1NDKbuMMVq1hcT/34Z70BTeCxUJAAmUKQa7gM1rMrphZeye
        Kg7bKGMr/gFz9t802V0ruk0vljuZ9
X-Received: by 2002:a7b:c2a9:0:b0:397:9a4:f66b with SMTP id c9-20020a7bc2a9000000b0039709a4f66bmr2454147wmk.128.1653377783434;
        Tue, 24 May 2022 00:36:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/Cwz5jOogKed9CA8JaKkoHRc42pmAwU1T7LN2zbNsfSba8Fm0H5+hJzMmRKFlhnD9ie+/vQ==
X-Received: by 2002:a7b:c2a9:0:b0:397:9a4:f66b with SMTP id c9-20020a7bc2a9000000b0039709a4f66bmr2454124wmk.128.1653377783103;
        Tue, 24 May 2022 00:36:23 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f2-20020adfc982000000b0020c5253d927sm12202174wrh.115.2022.05.24.00.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 00:36:22 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        Lennart Poettering <lennart@poettering.net>,
        Colin Walters <walters@verbum.org>,
        Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/3] fat: add support for the renameat2 RENAME_EXCHANGE flag
Date:   Tue, 24 May 2022 09:36:01 +0200
Message-Id: <20220524073604.247790-1-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

This series add support for the renameat2 system call RENAME_EXCHANGE flag
(which allows to atomically replace two paths) to the vfat filesystem code.

There are many use cases for this, but we are particularly interested in
making possible for vfat filesystems to be part of OSTree [0] deployments.

Currently OSTree relies on symbolic links to make the deployment updates
an atomic transactional operation. But RENAME_EXCHANGE could be used [1]
to achieve a similar level of robustness when using a vfat filesystem.

Patch #1 is just a preparatory patch to introduce the RENAME_EXCHANGE
support in patch #2 and finally patch #3 adds some kselftests to test it.

This is a v2 that addresses issues pointed out in the first version that
was posted as an RFC:

https://lore.kernel.org/lkml/20220519092343.2776414-1-javierm@redhat.com/

[0]: https://github.com/ostreedev/ostree
[1]: https://github.com/ostreedev/ostree/issues/1649

Changes in v2:
- Only update the new_dir inode version and timestamps if != old_dir
  (Alex Larsson).
- Add some helper functions to avoid duplicating code (OGAWA Hirofumi).
- Use braces for multi-lines blocks even if are one statement (OGAWA Hirofumi).
- Mention in commit message that the operation is as transactional as possible
  but within the vfat limitations of not having a journal (Colin Walters).
- Call sync to flush the page cache before checking the file contents
  (Alex Larsson).
- Drop RFC prefix since the patches already got some review.

Javier Martinez Canillas (3):
  fat: add a vfat_rename2() and make existing .rename callback a helper
  fat: add renameat2 RENAME_EXCHANGE flag support
  selftests/filesystems: add a vfat RENAME_EXCHANGE test

 MAINTAINERS                                   |   1 +
 fs/fat/namei_vfat.c                           | 193 +++++++++++++++++-
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/filesystems/fat/Makefile        |   7 +
 .../testing/selftests/filesystems/fat/config  |   2 +
 .../filesystems/fat/rename_exchange.c         |  37 ++++
 .../filesystems/fat/run_fat_tests.sh          |  82 ++++++++
 7 files changed, 316 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/fat/Makefile
 create mode 100644 tools/testing/selftests/filesystems/fat/config
 create mode 100644 tools/testing/selftests/filesystems/fat/rename_exchange.c
 create mode 100755 tools/testing/selftests/filesystems/fat/run_fat_tests.sh

-- 
2.36.1

