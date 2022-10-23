Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC75A609344
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Oct 2022 15:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiJWNKA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Oct 2022 09:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiJWNJ6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Oct 2022 09:09:58 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2E629358;
        Sun, 23 Oct 2022 06:09:52 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id w189so5431754pfw.4;
        Sun, 23 Oct 2022 06:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ruWhG3pscMJsY1n5dAhMLZws4wl2SAzKhmNZ+1gKW8Q=;
        b=M9NaGXRP7iTgMD7mUjaaIotedcQCA3FxyrhHTFd8WnSR72QcxNV04Ts8pfml5F4mhD
         UJaaSWB1zhAsq3uymwNSNMTgBqI8tEMim252SZEwVj/VXyX/GBcprBbI3Kvg4kcF0TfT
         nhKwSaU+fl//786BPX8+9lYwh5VwXMFZRBbGAzj71iEIsns66a0x0QYf9IiOjuDH0XWV
         qbfL0MtzQRWMRxbc+//QBPdDyg9temeOA6PaHRIUG2XadjyjlPolpSjjk4z/1m+ADkbH
         xF0D+7mw5ClQ6Km3N54A06Ksk41WR1lKMaPv4d3R0OgqP3j9kGfMuwbFqpujQO4k/kHb
         WniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ruWhG3pscMJsY1n5dAhMLZws4wl2SAzKhmNZ+1gKW8Q=;
        b=WdyXhVwyIDlyUzk419zL17Q9EJLBRWmCAR/r1wjD/FVFGUjoxj0A+CfeAGDFNbMWu/
         nDMInka6iB/2wQJLsG3/SbMcHwlB58GycQW7D5CYG+9dk/xO/QRP4bV8OFKrkAOdh/ei
         6RMZ0a/T8HAzteWZE2Vma9WGegWDeUVhJleZJDjP7+S0KOkeQkQuPmrBC2VD7XdeUvwm
         t6kTqbbPQT9A7ea+WcmyZSzA7DeIV4mfVyc+p++14zLnIflhf5uWgUL1QP1lF+SVVeit
         8ylWB8VHp/v50eVlsCY3ILbe0vcKSFoV1J3VoIqSlho2B/NqPHzbJoYLBBb6O20MFRTW
         2kfg==
X-Gm-Message-State: ACrzQf0qflOHVq7S/CUjDYqywR+GkWmXKyCsihLAz4OUlxulgiAMKDQH
        mhXvB5yDrIltifhErUf1rL5+EKS3b+OyKA==
X-Google-Smtp-Source: AMsMyM452qeyQqa0kIsDBQ6fpn6S43TauFCzZ9FZedbPaszS3tVUB28/uExQ69Tvwyc269JvMynBDA==
X-Received: by 2002:a65:464b:0:b0:42c:b0:9643 with SMTP id k11-20020a65464b000000b0042c00b09643mr24738940pgr.232.1666530592319;
        Sun, 23 Oct 2022 06:09:52 -0700 (PDT)
Received: from debian.. (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id d5-20020a623605000000b0056b6c7a17c6sm3411713pfa.12.2022.10.23.06.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 06:09:51 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Khalid Masum <khalid.masum.92@gmail.com>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH RESEND 0/7] KUnit documentation rewording
Date:   Sun, 23 Oct 2022 20:08:40 +0700
Message-Id: <20221023130846.63296-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1981; i=bagasdotme@gmail.com; h=from:subject; bh=+vBJ63MqcYarXcaRceaUYiztfMLtg32Q18u0nn6NrdM=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMmhNree51sfsRGZlFnz+KHzbP7PQle2OqytDxecna5jmDZX 3/BKRykLgxgHg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACYSMJ+R4aWnnYOUUobY2QnfHAPW7R PWqop7yxr4eM+C0iWFP9Qm/Gb4X1EiYJy/ss6oasejTflupXvcTr/+tmrGqymc+6f8+7aKiR8A
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi everyone, sorry for quickly resending this patch series due to
duplicated patch [7/7] sent as result of amending the corresponding
commit.

The proses written in KUnit documentation are IMO incomprehensible (my
brain has to process what the meaning of words used) and different from
wordings that I normally read from technical writings. Thus, rewrite these
using clearer words.

Anyway, it's great to see native English speakers help reviewing this
series.

The first two patches are v3 of rewriting "Writing Your First Test"
section of "Getting Started" patch [1], which was submitted about a
month ago. The rest are actual documentation rewriting.

Note that this series only rewrites intro, test writing and running docs.

[1]: https://lore.kernel.org/lkml/20220929132549.56452-1-bagasdotme@gmail.com/


Bagas Sanjaya (7):
  Documentation: kunit: rewrite "Writing Your First Test" section
  Documentation: kunit: align instruction code blocks
  Documentation: kunit: rewrite the rest of "Getting Started"
    documentation
  Documentation: kunit: move introduction to its own document
  Documentation: kunit: rewrite "Running tests with kunit_tool"
  Documentation: kunit: rewrite "Run Tests without kunit_tool"
  Documentation: kunit: rewrite "Writing tests"

 Documentation/admin-guide/README.rst          |   2 +
 Documentation/dev-tools/kunit/index.rst       |  93 +----
 Documentation/dev-tools/kunit/intro.rst       |  61 ++++
 Documentation/dev-tools/kunit/run_manual.rst  |  68 ++--
 Documentation/dev-tools/kunit/run_wrapper.rst | 302 ++++++----------
 Documentation/dev-tools/kunit/start.rst       | 264 +++++++-------
 Documentation/dev-tools/kunit/usage.rst       | 322 ++++++++++--------
 7 files changed, 483 insertions(+), 629 deletions(-)
 create mode 100644 Documentation/dev-tools/kunit/intro.rst


base-commit: de3ee3f63400a23954e7c1ad1cb8c20f29ab6fe3
-- 
An old man doll... just what I always wanted! - Clara

