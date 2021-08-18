Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83AC3F0854
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Aug 2021 17:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239987AbhHRPro (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Aug 2021 11:47:44 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:46658 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238689AbhHRPrn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Aug 2021 11:47:43 -0400
Received: by mail-lj1-f182.google.com with SMTP id w4so4429212ljh.13;
        Wed, 18 Aug 2021 08:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mHbP3ABUJl2fRmSfnSzcJy4bszTULYmLIBF16edHZtQ=;
        b=c2Hx/f7SpHM30ip3mLjrdlN7oM8SvDEg3yz7Ah1i1Qx1ol10DbtcLf4IusfFGPxR2Z
         rRfFd0w+0fUGRGBsEvHFhLWs/911uJqDE4dXrdzYLWo2uGugVltUkMJDAZFqQMrkRzDb
         jQXwobnWF1XsQii1f6LEuBHVwgzkk4H2EpbTFCagyv+p+mhnGdHYLM3QQ459MYR95RyG
         /99PM6Ju8iG5n/hL8uKV0kPHE0md5PgLCmEWtt+cvfIhbchNSVQs87Gt4MEdEIaYtMiE
         wloWl71FR1FthhGh5akLDsdALmuWGdgXyNTTALOJNBGKwi2Gcqj+kX1NVbMk6tfp+LPx
         2bWg==
X-Gm-Message-State: AOAM533ie4idy4dwUMKpTqLYZe855SRjh+3jnaDCuDD6VSCDGq2J/160
        goxr8r6/aC68nfSA6YG/zCEcYr07+yIGhnPE
X-Google-Smtp-Source: ABdhPJyB5ToTInt2FJ82VXAP/Gb6bcHEMZKkgcVjy/UeoaZC9vRABZgjzP85t6vm97XQKegkUlD++Q==
X-Received: by 2002:a2e:2a46:: with SMTP id q67mr7062904ljq.286.1629301626215;
        Wed, 18 Aug 2021 08:47:06 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id j4sm23808ljh.120.2021.08.18.08.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 08:47:05 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jiri Kosina <jkosina@suse.cz>, Willy Tarreau <w@1wt.eu>
Subject: [RFC PATCH 0/5] selftests: floppy: basic tests
Date:   Wed, 18 Aug 2021 18:46:41 +0300
Message-Id: <20210818154646.925351-1-efremov@linux.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add basic tests to cover some regressions that we had.
It's hard to test floppy because some tests require
presence or absense of a diskette in a drive. To simulate
test conditions and automate the testing I added
"run_*.sh" wrapper scripts that run tests in QEMU.

The first patch just improves check for reverted commits
in a commit message. The second patch is required to
generate a minimal initrd used in next commits. Rest of
commits are basic floppy tests.

Please, comment the approach, selftests integration
and suggest tests that you would like to add.

I thought about adding a possibility to remove/insert
diskettes inside a test. This is possible if we give
the guest an access to the QEMU monitor (eject/change cmds).
But I didn't find a better way to do it than to map a
monitor to an external port:
  -monitor tcp:<ip>:<port>,server,nowait
  and access this ip from the guest.
Maybe it's also possible to do with virtserialport.

Denis Efremov (5):
  checkpatch: improve handling of revert commits
  gen_initramfs.sh: use absolute path for gen_init_cpio
  selftests: floppy: add basic tests for opening an empty device
  selftests: floppy: add basic tests for a readonly disk
  selftests: floppy: add basic rdwr tests

 MAINTAINERS                                  |  1 +
 scripts/checkpatch.pl                        | 12 +--
 tools/testing/selftests/floppy/.gitignore    |  8 ++
 tools/testing/selftests/floppy/Makefile      | 10 ++
 tools/testing/selftests/floppy/config        |  1 +
 tools/testing/selftests/floppy/empty.c       | 58 ++++++++++++
 tools/testing/selftests/floppy/init.c        | 43 +++++++++
 tools/testing/selftests/floppy/lib.sh        | 67 +++++++++++++
 tools/testing/selftests/floppy/rdonly.c      | 99 ++++++++++++++++++++
 tools/testing/selftests/floppy/rdwr.c        | 67 +++++++++++++
 tools/testing/selftests/floppy/run_empty.sh  | 16 ++++
 tools/testing/selftests/floppy/run_rdonly.sh | 22 +++++
 tools/testing/selftests/floppy/run_rdwr.sh   | 22 +++++
 usr/gen_initramfs.sh                         |  2 +-
 14 files changed, 421 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/floppy/.gitignore
 create mode 100644 tools/testing/selftests/floppy/Makefile
 create mode 100644 tools/testing/selftests/floppy/config
 create mode 100644 tools/testing/selftests/floppy/empty.c
 create mode 100644 tools/testing/selftests/floppy/init.c
 create mode 100644 tools/testing/selftests/floppy/lib.sh
 create mode 100644 tools/testing/selftests/floppy/rdonly.c
 create mode 100644 tools/testing/selftests/floppy/rdwr.c
 create mode 100755 tools/testing/selftests/floppy/run_empty.sh
 create mode 100755 tools/testing/selftests/floppy/run_rdonly.sh
 create mode 100755 tools/testing/selftests/floppy/run_rdwr.sh

-- 
2.31.1

