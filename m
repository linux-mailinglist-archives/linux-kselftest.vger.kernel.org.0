Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13279B85DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2019 00:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392228AbfISWZK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Sep 2019 18:25:10 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:50197 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407135AbfISWY2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Sep 2019 18:24:28 -0400
Received: by mail-qt1-f202.google.com with SMTP id x26so5735710qtr.17
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2019 15:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ieJJfZWRKKIX60np7mueb+mmTEbZMC8x8RYuPdA8C20=;
        b=QnOn4cu3RXmIUffEGilk2J2NAOH2uH0HiV7ymdBeadWqAib3RPsOSvnnTZgqcBKPSu
         tnorXppl3gmlwv+V+J3RRaX0IB+7JLz4Xvey54Fvktrgv0Kd6hu84J6pB/eAT7qwIYeX
         LyPrpbWlomgsxsVRoxqPGPXaJXmuMxQ8hmY2sIQWghSi/KMF1qdNnsr4atjr5mG54YrG
         VyOWBlkSBx5UrOvc72t+EfhKNdY7IG/2+AA3mh82ljh0TND7aUV3WHV1idKU7xVhINs3
         Y0gmC9DWzRxFEOMiWah30HYYMQiC0etKCDgP/EOIFUvOwPa2Biu/RDcE4n4hSnepMGAf
         35KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ieJJfZWRKKIX60np7mueb+mmTEbZMC8x8RYuPdA8C20=;
        b=KJfXKpmKP3yv4M1t7VfqrFzQvG3KOZD2R5cik8Ctt8AOyBcdSrzBcYh8ibvEyf526j
         2OF6FzLAzNP2c5UyIlHjpls0WKMTMdgFY4cWmxI4QFy0O/nNjrCh5QpO7lWzYiX+ySRl
         uHfBTnpmJWzqFku1AfoG1cmuFlT5JJ/JaTl3SfzdNuZFcqvhy5xuXg0a7ToE+uP9M/zW
         lfvavnZyBzV1py7QveLppEKX+BVz3w3qWYhtdY7H88i5eCN/JSc0jJu6dgAPpDHnieMO
         mng8SDpr9U/lcDtCjsCJImf0gLMYk5C9BcU/xEHA4T0cyeb5uGplWPwqVfNNF485iKDc
         3XTw==
X-Gm-Message-State: APjAAAXWqHGbLgSAe3Lks2N61mDcWxLYqbF6r5OgK30wwWSBeAFGL6zH
        6ppJ3MMHe3+/iTAjQkYzMIBiX+YH1oig9rky1A==
X-Google-Smtp-Source: APXvYqwXK1WbmT4rAswLs8+X1D8BDR4SwECC8J4GsDv/o8c6p+TW6Y5FUulJqUKIQYym02x92CkFE+kqGy/bVviL2Q==
X-Received: by 2002:a37:2748:: with SMTP id n69mr157636qkn.318.1568931865458;
 Thu, 19 Sep 2019 15:24:25 -0700 (PDT)
Date:   Thu, 19 Sep 2019 15:24:14 -0700
Message-Id: <20190919222421.27408-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v5 0/7] hugetlb_cgroup: Add hugetlb_cgroup reservation limits
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Patch series implements hugetlb_cgroup reservation usage and limits, which
track hugetlb reservations rather than hugetlb memory faulted in. Details of
the approach is 1/7.

Changes in v5:
- Moved the bulk of the description to the first patch in the series.
- Clang formatted the entire series.
- Split off 'hugetlb: remove duplicated code' and 'hugetlb: region_chg provides
  only cache entry' into their own patch series.
- Added comments to HUGETLB_RES enum.
- Fixed bug in 'hugetlb: disable region_add file_region coalescing' calculating
  the wrong number of regions_needed in some cases.
- Changed sleeps in test to proper conditions.
- Misc fixes in test based on shuah@ review.

Changes in v4:
- Split up 'hugetlb_cgroup: add accounting for shared mappings' into 4 patches
  for better isolation and context on the indvidual changes:
  - hugetlb_cgroup: add accounting for shared mappings
  - hugetlb: disable region_add file_region coalescing
  - hugetlb: remove duplicated code
  - hugetlb: region_chg provides only cache entry
- Fixed resv->adds_in_progress accounting.
- Retained behavior that region_add never fails, in earlier patchsets region_add
  could return failure.
- Fixed libhugetlbfs failure.
- Minor fix to the added tests that was preventing them from running on some
  environments.

Changes in v3:
- Addressed comments of Hillf Danton:
  - Added docs.
  - cgroup_files now uses enum.
  - Various readability improvements.
- Addressed comments of Mike Kravetz.
  - region_* functions no longer coalesce file_region entries in the resv_map.
  - region_add() and region_chg() refactored to make them much easier to
    understand and remove duplicated code so this patch doesn't add too much
    complexity.
  - Refactored common functionality into helpers.

Changes in v2:
- Split the patch into a 5 patch series.
- Fixed patch subject.

Mina Almasry (7):
  hugetlb_cgroup: Add hugetlb_cgroup reservation counter
  hugetlb_cgroup: add interface for charge/uncharge hugetlb reservations
  hugetlb_cgroup: add reservation accounting for private mappings
  hugetlb: disable region_add file_region coalescing
  hugetlb_cgroup: add accounting for shared mappings
  hugetlb_cgroup: Add hugetlb_cgroup reservation tests
  hugetlb_cgroup: Add hugetlb_cgroup reservation docs

 .../admin-guide/cgroup-v1/hugetlb.rst         |  85 +++-
 include/linux/hugetlb.h                       |  31 +-
 include/linux/hugetlb_cgroup.h                |  33 +-
 mm/hugetlb.c                                  | 423 +++++++++++-----
 mm/hugetlb_cgroup.c                           | 190 ++++++--
 tools/testing/selftests/vm/.gitignore         |   1 +
 tools/testing/selftests/vm/Makefile           |   1 +
 .../selftests/vm/charge_reserved_hugetlb.sh   | 461 ++++++++++++++++++
 .../selftests/vm/write_hugetlb_memory.sh      |  22 +
 .../testing/selftests/vm/write_to_hugetlbfs.c | 250 ++++++++++
 10 files changed, 1306 insertions(+), 191 deletions(-)
 create mode 100755 tools/testing/selftests/vm/charge_reserved_hugetlb.sh
 create mode 100644 tools/testing/selftests/vm/write_hugetlb_memory.sh
 create mode 100644 tools/testing/selftests/vm/write_to_hugetlbfs.c

--
2.23.0.351.gc4317032e6-goog
