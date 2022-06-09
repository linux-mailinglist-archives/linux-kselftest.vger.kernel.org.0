Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F04E5447AF
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jun 2022 11:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242531AbiFIJg5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Jun 2022 05:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242482AbiFIJgz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Jun 2022 05:36:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4ADE022BEE
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Jun 2022 02:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654767412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/OByrRXmDTIXHhVMaR8PwxE73rUJySQV3skcisuRFW4=;
        b=NbLHW3KzgcdOZatpJOl2Ak/tJW8ww0vC59suiP9DZ2HM9NVhweWB7j9up4ul9TTZDucKWa
        4syAK+2KB6C6HhISYimd4cfokxWjhg5tnbjJXF81vZiU2niDgjvyK4kaQmusB393M2we6q
        hbr1fB9utMPlNp2uq2/TWo65tlL1hXc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581--JGqLtffM_SvVs12XdOmOQ-1; Thu, 09 Jun 2022 05:36:51 -0400
X-MC-Unique: -JGqLtffM_SvVs12XdOmOQ-1
Received: by mail-wm1-f72.google.com with SMTP id k15-20020a7bc40f000000b0039c4b7f7d09so5362010wmi.8
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Jun 2022 02:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/OByrRXmDTIXHhVMaR8PwxE73rUJySQV3skcisuRFW4=;
        b=iazrLWgUSESt/CNujqZFh315I2CFVM8Czxy2EVX+yHh8/2iMNKWAnS8xJhKFDL+PZW
         NY69yKVwi6/HOMtP5/roSe3oso/ekTtprCqKaV9V+Sh3dC+19lKoAijwOINxQ6HVI/2R
         HJSUF3F7HvTRN2x/7a9kCEXQHVhYUEXfLgqDEwhOjBiMvuEvX534A4DdrFo32YxHHDZ+
         s2fm/iXpPvus6Dseg19yP9bFyAuANhA5J5UfAgEaGJN+JSfj3vAHp/VJKsp7kbhKcXNu
         vcq1icUBZpbZiOlfxSiBp6aAqqohHJr+LKn+pbcYxF5uVFcnU2Tlw+SC4QceKzyAM9Fy
         g70w==
X-Gm-Message-State: AOAM530swNXB/Il3kL2KLJi7wKLHoJz2m11TWJiv8qsBcF2xG9sRBhtU
        JLmSybmJwCLUHX0l/ldCOyGGHuomodSNEcPmZpdjJoAtAqxyGV2VYhEp2pQfyJ1r5aom+xapLaV
        QjuaDmY3io3oNVPWCJ1Dw2of3oV6Z
X-Received: by 2002:a05:600c:35d4:b0:39c:2541:7571 with SMTP id r20-20020a05600c35d400b0039c25417571mr2416241wmq.33.1654767409874;
        Thu, 09 Jun 2022 02:36:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxagyxXmNQ+1mS5Njzg5qZw4m+MOCfmM5s7ZpgXcjOQTicyuD9GsAuwHJBY1jTTuq6vvVGW4g==
X-Received: by 2002:a05:600c:35d4:b0:39c:2541:7571 with SMTP id r20-20020a05600c35d400b0039c25417571mr2416215wmq.33.1654767409553;
        Thu, 09 Jun 2022 02:36:49 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c3b1200b00397122e63b6sm27385580wms.29.2022.06.09.02.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 02:36:49 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Colin Walters <walters@verbum.org>,
        Alberto Ruiz <aruiz@redhat.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Lennart Poettering <lennart@poettering.net>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Christian Kellner <ckellner@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Carlos Maiolino <cmaiolin@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v5 0/4] fat: add support for the renameat2 RENAME_EXCHANGE flag
Date:   Thu,  9 Jun 2022 11:36:33 +0200
Message-Id: <20220609093638.664034-1-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

This is a v5 that addresses issues pointed out in v4:

https://lore.kernel.org/lkml/18d9e587-b4f7-6ee7-185a-af0e667e0ec5@redhat.com/

[0]: https://github.com/ostreedev/ostree
[1]: https://github.com/ostreedev/ostree/issues/1649

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
 fs/fat/namei_vfat.c                           | 232 +++++++++++++++---
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/filesystems/fat/.gitignore      |   2 +
 .../selftests/filesystems/fat/Makefile        |   7 +
 .../testing/selftests/filesystems/fat/config  |   2 +
 .../filesystems/fat/rename_exchange.c         |  37 +++
 .../filesystems/fat/run_fat_tests.sh          |  82 +++++++
 8 files changed, 325 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/fat/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/fat/Makefile
 create mode 100644 tools/testing/selftests/filesystems/fat/config
 create mode 100644 tools/testing/selftests/filesystems/fat/rename_exchange.c
 create mode 100755 tools/testing/selftests/filesystems/fat/run_fat_tests.sh

-- 
2.36.1

