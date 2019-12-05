Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D77F113E08
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2019 10:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfLEJfE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Dec 2019 04:35:04 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:55095 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfLEJfE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Dec 2019 04:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575538503; x=1607074503;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=RxC7Bje5SsNNUuaS5E+bzn4jtQoV6YFXmfP4HzoaOTU=;
  b=a8rHrlmbJBsVBl4sWTBvwsiGicNFTpIJwuJjQzWPwKZl8fBzp5lvGZUU
   di3HVPe+qwNiWNZSyGBLhENu/MnfFMEyLSt3rz3lmMSGaSBTQrGL3jQ+h
   3A9sS2TiJZyG+qSm5slIMyS7CcYEhLyr7vZsmbam45xJm17ppcQjcy6C2
   s=;
IronPort-SDR: V7Mg/SXJ7jkVaG3d9g0hm/B+m3jjIgCdQ1/U2hvisxW6mT3z8WiBz/S87Y3l9BD/mt/ZzgQb9k
 Perbae0UofTg==
X-IronPort-AV: E=Sophos;i="5.69,280,1571702400"; 
   d="scan'208";a="7181310"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 05 Dec 2019 09:35:01 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id BE236A20FE;
        Thu,  5 Dec 2019 09:34:59 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 09:34:59 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.180) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 09:34:55 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <brendanhiggins@google.com>
CC:     <sj38.park@gmail.com>, <corbet@lwn.net>,
        <kunit-dev@googlegroups.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <shuah@kernel.org>, <sjpark@amazon.de>
Subject: [PATCH v5 0/6] Fix nits in the kunit
Date:   Thu, 5 Dec 2019 10:34:34 +0100
Message-ID: <20191205093440.21824-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.180]
X-ClientProxiedBy: EX13D23UWC001.ant.amazon.com (10.43.162.196) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This patchset contains trivial fixes for the kunit documentations and
the wrapper python scripts.

This patchset is based on 'kselftest/test' branch of linux-kselftest[1]
and depends on Heidi's patch[2].  A complete tree is available at my repo:
https://github.com/sjp38/linux/tree/kunit_fix/20191205_v5

Changes from v4
(https://lore.kernel.org/linux-doc/1575490683-13015-1-git-send-email-sj38.park@gmail.com/):
 - Rebased on Heidi Fahim's patch[2]
 - Fix failing kunit_tool_test test
 - Add 'build_dir' option test in 'kunit_tool_test.py'

Changes from v3
(https://lore.kernel.org/linux-kselftest/20191204192141.GA247851@google.com):
 - Fix the 4th patch, "kunit: Place 'test.log' under the 'build_dir'" to
   set default value of 'build_dir' as '' instead of NULL so that kunit
   can run even though '--build_dir' option is not given.

Changes from v2
(https://lore.kernel.org/linux-kselftest/1575361141-6806-1-git-send-email-sj38.park@gmail.com):
 - Make 'build_dir' if not exists (missed from v3 by mistake)

Changes from v1
(https://lore.kernel.org/linux-doc/1575242724-4937-1-git-send-email-sj38.park@gmail.com):
 - Remove "docs/kunit/start: Skip wrapper run command" (A similar
   approach is ongoing)
 - Make 'build_dir' if not exists

SeongJae Park (6):
  docs/kunit/start: Use in-tree 'kunit_defconfig'
  kunit: Remove duplicated defconfig creation
  kunit: Create default config in '--build_dir'
  kunit: Place 'test.log' under the 'build_dir'
  kunit: Rename 'kunitconfig' to '.kunitconfig'
  kunit/kunit_tool_test: Test '--build_dir' option run

 Documentation/dev-tools/kunit/start.rst | 13 +++++--------
 tools/testing/kunit/kunit.py            | 18 +++++++++++-------
 tools/testing/kunit/kunit_kernel.py     | 10 +++++-----
 tools/testing/kunit/kunit_tool_test.py  | 10 +++++++++-
 4 files changed, 30 insertions(+), 21 deletions(-)

-- 

[1] git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
[2] "kunit: testing kunit: Bug fix in test_run_timeout function",
https://lore.kernel.org/linux-kselftest/CAFd5g47a7a8q7by+1ALBtepeegLvfkgwvC3nFd8n8V=hqkV+cg@mail.gmail.com/T/#t)

2.17.1

