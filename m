Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F973767702
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 22:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjG1Uez (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 16:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjG1Uey (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 16:34:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75924497;
        Fri, 28 Jul 2023 13:34:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BE3F62202;
        Fri, 28 Jul 2023 20:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96AEC433C8;
        Fri, 28 Jul 2023 20:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690576488;
        bh=tjC+t1JVwwxq1scLPA5k2+mNVlIe2UmfsNt2gxgEsnM=;
        h=From:To:Cc:Subject:Date:From;
        b=aGso/o3OKHGpXF3mWTBc9SGewTCa94We1PMmqibntTGcbh/vbZ01JHpu50/O5ZXca
         cFpSVC/oKArONAo8Oa0b1bO79wK/fskqVInSV1cT/Uo/oUdnDagJ4Xsa8O4aa4TEax
         viFYwF+YGG6eXxvu9/AtIcVGiAl3u3poFYAvT/S0eO3ocVGkIEWddv+o1iuYJuVFAg
         R1uoOcVfgn0ODALY+sQzrJmsB1IkZwRf6RdbXzwHZpKJ++nrofK/AY1fC+XV3kq44w
         a3W/13TitbiQG8m65JEx8oz0gTzQz5QTRJ2TDql8XLEnmt8aPse6xTWFjusstCugie
         +TDfZ8+i/p6ZA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        damon@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-mm@kvack.org
Subject: [RFC PATCH 00/13] Extedn DAMOS filters for address ranges and
Date:   Fri, 28 Jul 2023 20:34:31 +0000
Message-Id: <20230728203444.70703-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are use cases that need to apply DAMOS schemes to specific address
ranges or DAMON monitoring targets.  NUMA nodes in the physical address
space, special memory objects in the virtual address space, and
monitoring target specific efficient monitoring results snapshot
retrieval could be examples of such use cases.  This patchset extends
DAMOS filters feature for such cases, by implementing two more filter
types, namely address ranges and DAMON monitoring types.

Patches sequence
----------------

The first seven patches are for the address ranges based DAMOS filter.
The first patch implements the filter feature and expose it via DAMON
kernel API.  The second patch further expose the feature to users via
DAMON sysfs interface.  The third and fourth patches implement unit
tests and selftests for the feature.  Three patches (fifth to seventh)
updating the documents follow.

The following six patches are for the DAMON monitoring target based
DAMOS filter.  The eighth patch implements the feature in the core layer
and expose it via DAMON's kernel API.  The ninth patch further expose it
to users via DAMON sysfs interface.  Tenth patch add a selftest, and two
patches (eleventh and twelfth) update documents.

SeongJae Park (13):
  mm/damon/core: introduce address range type damos filter
  mm/damon/sysfs-schemes: support address range type DAMOS filter
  mm/damon/core-test: add a unit test for __damos_filter_out()
  selftests/damon/sysfs: test address range damos filter
  Docs/mm/damon/design: update for address range filters
  Docs/ABI/damon: update for address range DAMOS filter
  Docs/admin-guide/mm/damon/usage: update for address range type DAMOS
    filter
  mm/damon/core: implement target type damos filter
  mm/damon/sysfs-schemes: support target damos filter
  selftests/damon/sysfs: test damon_target filter
  Docs/mm/damon/design: update for DAMON monitoring target type DAMOS
    filter
  Docs/ABI/damon: update for DAMON monitoring target type DAMOS filter
  Docs/admin-guide/mm/damon/usage: update for DAMON monitoring target
    type DAMOS filter

 .../ABI/testing/sysfs-kernel-mm-damon         | 27 +++++-
 Documentation/admin-guide/mm/damon/usage.rst  | 34 +++++---
 Documentation/mm/damon/design.rst             | 24 ++++--
 include/linux/damon.h                         | 28 +++++--
 mm/damon/core-test.h                          | 61 ++++++++++++++
 mm/damon/core.c                               | 62 ++++++++++++++
 mm/damon/sysfs-schemes.c                      | 83 +++++++++++++++++++
 tools/testing/selftests/damon/sysfs.sh        |  5 ++
 8 files changed, 299 insertions(+), 25 deletions(-)

-- 
2.25.1

