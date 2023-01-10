Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0455664BE4
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 20:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbjAJTEH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 14:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239663AbjAJTEG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 14:04:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB8CC2C;
        Tue, 10 Jan 2023 11:04:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B61B61866;
        Tue, 10 Jan 2023 19:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFDBC433EF;
        Tue, 10 Jan 2023 19:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673377444;
        bh=cMloBfgRXcPaivDxBGV45/PyJEpmffBJWfiRdIAMdCU=;
        h=From:To:Cc:Subject:Date:From;
        b=fys4UPeZcW4izhx0mZgQ1PCbzZt6jepaHXFAtoLEQs89oOmk2vLAVFtddnsKwxI4t
         +AMfSBQZk/zCA2ti229JqsdbQ3nvnXrAIuXJE8gzw9iwWEkMuI+m6EaInONFuAszm6
         UkkEQ4P4manxdf0QPiF9htrVPPqcQ9WS4oxfrRe5SBAoqMPKkM6Qgzqs2uLhtle5T3
         ujGNazYNSpsSiR/EAXQ25c1y25/XsmGBlEgEJ0OUmHEQpw8Pm1jcEw/BoOBGuvfpAq
         +rkxFPkQlWCF/FiF0+M6kh4OziuHTDkfsswT8liRrUrpaJb0sdFv7On+BHtfeDcSPm
         eDxURokTs+u1A==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] mm/damon: trivial fixups
Date:   Tue, 10 Jan 2023 19:03:52 +0000
Message-Id: <20230110190400.119388-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patchset contains patches for trivial fixups of DAMON's
documentation, MAINTAINERS section, and selftests.

SeongJae Park (8):
  mm/damon/core: update kernel-doc comments for DAMOS action supports of
    each DAMON operations set
  mm/damon/core: update kernel-doc comments for DAMOS filters supports
    of each DAMON operations set
  Docs/mm/damon/index: mention DAMOS on the intro
  Docs/admin-guide/mm/damon/usage: update DAMOS actions/filters supports
    of each DAMON operations set
  Docs/mm/damon: add a maintainer-profile for DAMON
  MAINTAINERS/DAMON: link maintainer profile, git trees, and website
  selftests/damon/sysfs: hide expected write failures
  selftests/damon/debugfs_rm_non_contexts: hide expected write error
    messages

 Documentation/admin-guide/mm/damon/usage.rst  | 41 ++++++++----
 Documentation/mm/damon/index.rst              | 22 ++++---
 Documentation/mm/damon/maintainer-profile.rst | 62 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 include/linux/damon.h                         | 11 ++++
 .../damon/debugfs_rm_non_contexts.sh          |  2 +-
 tools/testing/selftests/damon/sysfs.sh        |  2 +-
 7 files changed, 122 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/mm/damon/maintainer-profile.rst

-- 
2.25.1

