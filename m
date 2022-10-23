Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1BC609307
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Oct 2022 14:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiJWMzT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Oct 2022 08:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJWMzS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Oct 2022 08:55:18 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B735240B3;
        Sun, 23 Oct 2022 05:55:17 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id 4so431895pli.0;
        Sun, 23 Oct 2022 05:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uiLHH4HmmDSJ4LoQq8jN2oE3+rIP/zMvk55vgBOOIY4=;
        b=d8v3eJTEVqCuE1QUxaY+QcoCte4KoXhLMhKc2Ejku84o4osZANd8HOHHw+3CsZhULf
         5Df3REzFQebxzvJ7XIbT4RJInW2G1KnPkaVAN0LmGT/D6yw0VuFhtSWnkcZviv252L5o
         Xx8hV4TptLwiSbsVvl8X+E+kKRkjbhbQEBEXCreMDnDTplxFGqYBIlvrjEdebqAEP9ue
         404swaQDhw6zaWbNT2LSOUCIPU4YboL1utpKC8idBuCUkk7GYeJpoLgt/kFC6gIazl/X
         Df7lvGCcj82cMjaau9e03Ex0DrglOXt/JgoYI9DERAFN7mwz77arpT81/vQEv3JKK5do
         yYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uiLHH4HmmDSJ4LoQq8jN2oE3+rIP/zMvk55vgBOOIY4=;
        b=jEkGt60DJ3ONdINQPW25Guq2O87RnJ70nUQRRsA+0RIn+XGrJtPVFwclCo2oQTCLGD
         Q0d7QweIpqAgTRuUm3eRHnZBEGQqdg7RIka7kQAy9wQNnBGhA2g7wX2HxcYQH/BsSlk0
         rA/bx7SR0xra1ACb1iM5PK4GZUI1wn7QUGG6y4hMGrqG8IOABsZh3Ix9/cS31FJlU0W9
         sqNa3vvkANYQ4ztWI0kUqEtDhW4OXeZpFgpMpEEh0Dbv5Et9GQcm8XBeZcDvH7YXk7Lf
         6PJB+nVYmka5qPs9YTTEibw9gqN1jUk5RWKSNbLq+yazT0tW5N83Wd75H6YIDIokwVH7
         KBzw==
X-Gm-Message-State: ACrzQf3Z/d2ofLIPpRyziNkDi/eX0UmR6wI3mKvjuigj64xFdTvTLLV6
        wegwH4yEa1wmDLevgdoj+5Ff8gHUfnhlQg==
X-Google-Smtp-Source: AMsMyM6rUwktSUfv180VhKrLW7U7jefGkFrGuD3K+t0SCmJyI2cNWlxWN6shCcec5Ifo8SS8VbSBgA==
X-Received: by 2002:a17:902:c643:b0:186:9efc:67a1 with SMTP id s3-20020a170902c64300b001869efc67a1mr2641162pls.30.1666529716450;
        Sun, 23 Oct 2022 05:55:16 -0700 (PDT)
Received: from debian.. (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id om10-20020a17090b3a8a00b00212daa68b7csm2670639pjb.44.2022.10.23.05.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 05:55:16 -0700 (PDT)
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
Subject: [PATCH 0/7] KUnit documentation rewording
Date:   Sun, 23 Oct 2022 19:54:07 +0700
Message-Id: <20221023125414.60961-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1832; i=bagasdotme@gmail.com; h=from:subject; bh=920H77gA/3sst95b5QYKX9NICudXq9PBuoArUOb1oP4=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMmhlmnKvRsCGTbWSKSGTknL9t3V/8D3XmVXQ62YjL2AKjtn 5++OUhYGMQ4GWTFFlkmJfE2ndxmJXGhf6wgzh5UJZAgDF6cATGTbUob/4U3ltxaf0F44p4lF1Hr7gm 9d6o2RDMqu165fWhnoHfRvI8P/Uk2Hv2/t70znsKicdHpBWl1uVuDJucbi6tzS1vf2CR/kBgA=
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

