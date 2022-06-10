Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3358D545DE4
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jun 2022 09:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbiFJH5j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jun 2022 03:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346874AbiFJH5i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jun 2022 03:57:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60B4C1CB709
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jun 2022 00:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654847855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9JUULinURQIF2agXGFcfqyCBp0u0vC7JiRZXKcJ+ITY=;
        b=QgNPwAfi08MAwUYNoLvIRdGTYqQ3SAmOROjWG23jq35d0pzKu4F4dYhYlP1uQ5hcJB6JQo
        erQKU5lOajgxTw47YS0xxAgjxvGE5U3rzbZSQ8ZPCbCcVvunhQ7K7uHR2ZLUjvtPLrWQkJ
        UwGN5zD7RwFADXWDiKmkDIMtetgQ+Gw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-amK9VkeVPTGqH2MTGcHjiw-1; Fri, 10 Jun 2022 03:57:32 -0400
X-MC-Unique: amK9VkeVPTGqH2MTGcHjiw-1
Received: by mail-wm1-f71.google.com with SMTP id o3-20020a05600c510300b0039743540ac7so9320739wms.5
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jun 2022 00:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9JUULinURQIF2agXGFcfqyCBp0u0vC7JiRZXKcJ+ITY=;
        b=Gl4MW0/MhO8/4+4PwhRfmEtHrArbSddD05Tu5nMqHUajsIwWg+wl4fjqMhknyb7BgD
         PBBv+uxJCgEKwVmJlaDAvqfVlv4+gM3hcWSOyH+kbs055osr2jEE94T/wDeuNkVz1X1Q
         Ur6QgBMu6koy4UVQRWEz11bFUtFAyThlqLTG07X6SVr7zx8ONuVQFA+H5VYTUddqsh90
         5G6ZPFT0HjR8o3kzJUVcaq5k4dUaK7kjBhWqR8Vnrmekjd1S+fApXV5wWDqx34+MoOok
         YLlSly/dlcXchk5Vc4VZFtZNJel8dw27DutiwLSPI/9uQQgzxZe4S1U0SotV7Z2d02Nu
         XpYQ==
X-Gm-Message-State: AOAM533B6YurELWpbdMNz2qq3qwJepUs/9HD+OtjC64xkh3F3uHruvFJ
        pT6WaEFif3TyB71l9U2C/Uvo0ctp4ldqTY6yD2rv7sVan/43hhQWRMMcK14MF0b88bvdgzsqjz1
        5/3w99WdGHl0BnsBhUfzW8g7vVs8y
X-Received: by 2002:a05:600c:4ca7:b0:39c:422a:fc6f with SMTP id g39-20020a05600c4ca700b0039c422afc6fmr7690878wmp.55.1654847850758;
        Fri, 10 Jun 2022 00:57:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9LDf4PbFRTolUMSMcOOuXciMzMVNXsXUGJVvn7HT+K0T/s38fEKlV27tmyea6wC5afDDpQA==
X-Received: by 2002:a05:600c:4ca7:b0:39c:422a:fc6f with SMTP id g39-20020a05600c4ca700b0039c422afc6fmr7690854wmp.55.1654847850457;
        Fri, 10 Jun 2022 00:57:30 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4bc6000000b0020e615bab7bsm26673363wrt.7.2022.06.10.00.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 00:57:29 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Kellner <ckellner@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Peter Jones <pjones@redhat.com>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Carlos Maiolino <cmaiolin@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Alexander Larsson <alexl@redhat.com>,
        Colin Walters <walters@verbum.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v6 0/4] fat: add support for the renameat2 RENAME_EXCHANGE flag
Date:   Fri, 10 Jun 2022 09:57:17 +0200
Message-Id: <20220610075721.1182745-1-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

The series adds support for the renameat2 system call RENAME_EXCHANGE flag
(which allows to atomically replace two paths) to the vfat filesystem code.

There are many use cases for this, but we are particularly interested in
making possible for vfat filesystems to be part of OSTree [0] deployments.

Currently OSTree relies on symbolic links to make the deployment updates
an atomic transactional operation. But RENAME_EXCHANGE could be used [1]
to achieve a similar level of robustness when using a vfat filesystem.

Patch #1 is just a preparatory patch to introduce the RENAME_EXCHANGE
support, patch #2 moves some code blocks in vfat_rename() to a set of
helper functions, that can be reused by tvfat_rename_exchange() that's
added by patch #3 and finally patch #4 adds some kselftests to test it.

This is a v6 that addresses issues pointed out in v5:

https://lkml.org/lkml/2022/6/9/361

[0]: https://github.com/ostreedev/ostree
[1]: https://github.com/ostreedev/ostree/issues/1649

Changes in v6:
- Simplify logic to determine if nlink have to modified (OGAWA Hirofumi).

Changes in v5:
- Only update nlink for different parent dirs and file types (OGAWA Hirofumi).

Changes in v4:
- Add new patch from OGAWA Hirofumi to use the helpers in vfat_rename().
- Rebase the patch on top of OGAWA Hirofumi proposed changes.
- Drop iversion increment for old and new file inodes (OGAWA Hirofumi).
- Add Muhammad Usama Anjum Acked-by tag.

Changes in v3:
- Add a .gitignore for the rename_exchange binary (Muhammad Usama Anjum).
- Include $(KHDR_INCLUDES) instead of hardcoding a relative path in Makefile
  (Muhammad Usama Anjum).

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

OGAWA Hirofumi (1):
  fat: factor out reusable code in vfat_rename() as helper functions

 MAINTAINERS                                   |   1 +
 fs/fat/namei_vfat.c                           | 231 +++++++++++++++---
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/filesystems/fat/.gitignore      |   2 +
 .../selftests/filesystems/fat/Makefile        |   7 +
 .../testing/selftests/filesystems/fat/config  |   2 +
 .../filesystems/fat/rename_exchange.c         |  37 +++
 .../filesystems/fat/run_fat_tests.sh          |  82 +++++++
 8 files changed, 324 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/fat/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/fat/Makefile
 create mode 100644 tools/testing/selftests/filesystems/fat/config
 create mode 100644 tools/testing/selftests/filesystems/fat/rename_exchange.c
 create mode 100755 tools/testing/selftests/filesystems/fat/run_fat_tests.sh

-- 
2.36.1

