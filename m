Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47114750AFE
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 16:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjGLO3I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 10:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjGLO3D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 10:29:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78111BE2;
        Wed, 12 Jul 2023 07:29:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69F776181D;
        Wed, 12 Jul 2023 14:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7056C433CA;
        Wed, 12 Jul 2023 14:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689172140;
        bh=HQ7aGbV4C7uaZAHLezNUkQSJsAkwtDjgQS3l2fLDv8g=;
        h=From:To:Cc:Subject:Date:From;
        b=uRpRe2FBwR2ytkiG/aO3Bgltf6Rdz5u2Hx/03RuV00p8Npi4EuH/K0928b5lJ9oF2
         RmzOqo+2LMt6zjoDLTjyEwk3SHpJSSq/K4PwkpYk8GRpw2p6oBBeaya0FEt0YM7OXu
         OKltFvcyQrcfuXzCbVYENGQQvcDJvO8idxR92BNmXt50jz/lHK34Tu2IKAbfo31pG7
         h5itJpBHiK+TzHHO2zuHsylG65j9wV7cpHkqW7IeFs58fSIuH6nKcuhMew8FdnSWax
         jUbccFbSCDs6uTd8yLMxYeN+UFu4JFntosz8h7ij9pKeF7lLgDQoQkgQ+FUL2IDcYU
         QHQH2PQWCwQsA==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1qJapt-003bek-1S;
        Wed, 12 Jul 2023 16:28:57 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Nikolai Kondrashov <spbnick@gmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        mauro.chehab@intel.com, linux-doc@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmoar@google.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/2] Add support for inlined documentation for kunit and kselftests
Date:   Wed, 12 Jul 2023 16:28:53 +0200
Message-Id: <cover.1689171160.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This RFC is a follow-up of the discussions taken here:

   https://lore.kernel.org/linux-doc/20230704132812.02ba97ba@maurocar-mobl2/T/#t

It adds a new extension that allows documenting tests using the same tool we're
using for DRM unit tests at IGT GPU tools: https://gitlab.freedesktop.org/drm/igt-gpu-tools.

While kernel-doc has provided documentation for in-lined functions/struct comments,
it was not meant to document tests.

Tests need to be grouped by the test functions. It should also be possible to produce
other outputs from the documentation, to integrate it with test suites. For instance, 
Internally at Intel, we use the comments to generate DOT files hierarchically grouped
per feature categories.

This is just an initial RFC to start discussions around the solution. Before being merged
upstream, we need to define what tags will be used to identify test markups and add
a simple change at kernel-doc to let it ignore such markups.

On this series, we have:

- patch 1:
  adding test_list.py as present at the IGT tree, after a patch series to make it
  more generic: https://patchwork.freedesktop.org/series/120622/
- patch 2:
  adds an example about how tests could be documented. This is a really simple
  example, just to test the feature, specially designed to make easy to build just
  the test documentation from a single DRM kunit file.

After discussions, my plan is to send a new version addressing the issues, and add
some documentation for DRM and/or i915 kunit tests.

Mauro Carvalho Chehab (2):
  docs: add support for documenting kUnit and kSelftests
  drm: add documentation for drm_buddy_test kUnit test

 Documentation/conf.py                  |    2 +-
 Documentation/index.rst                |    2 +-
 Documentation/sphinx/test_kdoc.py      |  108 ++
 Documentation/sphinx/test_list.py      | 1288 ++++++++++++++++++++++++
 Documentation/tests/index.rst          |    6 +
 Documentation/tests/kunit.rst          |    5 +
 drivers/gpu/drm/tests/drm_buddy_test.c |   12 +
 7 files changed, 1421 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/sphinx/test_kdoc.py
 create mode 100644 Documentation/sphinx/test_list.py
 create mode 100644 Documentation/tests/index.rst
 create mode 100644 Documentation/tests/kunit.rst

-- 
2.40.1


