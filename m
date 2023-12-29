Return-Path: <linux-kselftest+bounces-2519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA0E81FFA4
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 14:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6C61F220E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 13:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79558111BD;
	Fri, 29 Dec 2023 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EloIf3Iu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7101A11702;
	Fri, 29 Dec 2023 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703856324; x=1735392324;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VoKVzeNYvXYdu0nGsITJ3pkd4dyqg9TLeqCKzyy8vGA=;
  b=EloIf3IuP8/CHejNs9jU8kAr0XPWeToOYZpmXxe0qRUjy/eQwioOUXVa
   y/4TdWxmQVKHN8Qtj5BoYfE0OgW/AmJqRT8sXkzVQiAKOY0Z5hd/0UcPt
   PjqZo4qOppiqK8a7VHMu+Qx/+ULJFNKYY5EnNBhVubM7lKMmi2pFt/V/5
   qIno+I50YEU2VN+Bs7MR9KVoOYfEOB+OOUCKPQ17CFmB6SQBlP6GsQt+z
   vSonOhy77cfp0SpWdb1wOYHaTyoD18dpZvhieUF8NL6AZgnrDWBLG7XgX
   WpNPybioCS3S5C4Wix9pVRNvzDIPfHdiFcCRZij9GaEnuP3dYcuW+irDI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="3949087"
X-IronPort-AV: E=Sophos;i="6.04,315,1695711600"; 
   d="scan'208";a="3949087"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 05:23:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="755032593"
X-IronPort-AV: E=Sophos;i="6.04,315,1695711600"; 
   d="scan'208";a="755032593"
Received: from yujie-x299.sh.intel.com ([10.239.159.77])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 05:23:49 -0800
From: Yujie Liu <yujie.liu@intel.com>
To: netdev@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkp@intel.com,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2 net-next] selftests/net: change shebang to bash to support "source"
Date: Fri, 29 Dec 2023 21:19:31 +0800
Message-Id: <20231229131931.3961150-1-yujie.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch set [1] added a general lib.sh in net selftests, and converted
several test scripts to source the lib.sh.

unicast_extensions.sh (converted in [1]) and pmtu.sh (converted in [2])
have a /bin/sh shebang which may point to various shells in different
distributions, but "source" is only available in some of them. For
example, "source" is a built-it function in bash, but it cannot be
used in dash.

Refer to other scripts that were converted together, simply change the
shebang to bash to fix the following issues when the default /bin/sh
points to other shells.

# selftests: net: unicast_extensions.sh
# ./unicast_extensions.sh: 31: source: not found
# ###########################################################################
# Unicast address extensions tests (behavior of reserved IPv4 addresses)
# ###########################################################################
# TEST: assign and ping within 240/4 (1 of 2) (is allowed)            [FAIL]
# TEST: assign and ping within 240/4 (2 of 2) (is allowed)            [FAIL]
# TEST: assign and ping within 0/8 (1 of 2) (is allowed)              [FAIL]
# TEST: assign and ping within 0/8 (2 of 2) (is allowed)              [FAIL]
# TEST: assign and ping inside 255.255/16 (is allowed)                [FAIL]
# TEST: assign and ping inside 255.255.255/24 (is allowed)            [FAIL]
# TEST: route between 240.5.6/24 and 255.1.2/24 (is allowed)          [FAIL]
# TEST: route between 0.200/16 and 245.99/16 (is allowed)             [FAIL]
# TEST: assign and ping lowest address (/24)                          [FAIL]
# TEST: assign and ping lowest address (/26)                          [FAIL]
# TEST: routing using lowest address                                  [FAIL]
# TEST: assigning 0.0.0.0 (is forbidden)                              [ OK ]
# TEST: assigning 255.255.255.255 (is forbidden)                      [ OK ]
# TEST: assign and ping inside 127/8 (is forbidden)                   [ OK ]
# TEST: assign and ping class D address (is forbidden)                [ OK ]
# TEST: routing using class D (is forbidden)                          [ OK ]
# TEST: routing using 127/8 (is forbidden)                            [ OK ]
not ok 51 selftests: net: unicast_extensions.sh # exit=1

v1 -> v2:
  - Fix pmtu.sh which has the same issue as unicast_extensions.sh,
    suggested by Hangbin
  - Change the style of the "source" line to be consistent with other
    tests, suggested by Hangbin

Link: https://lore.kernel.org/all/20231202020110.362433-1-liuhangbin@gmail.com/ [1]
Link: https://lore.kernel.org/all/20231219094856.1740079-1-liuhangbin@gmail.com/ [2]
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Yujie Liu <yujie.liu@intel.com>
---
 tools/testing/selftests/net/pmtu.sh               | 4 ++--
 tools/testing/selftests/net/unicast_extensions.sh | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 175d3d1d773b..f10879788f61 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 #
 # Check that route PMTU values match expectations, and that initial device MTU
@@ -198,7 +198,7 @@
 # - pmtu_ipv6_route_change
 #	Same as above but with IPv6
 
-source ./lib.sh
+source lib.sh
 
 PAUSE_ON_FAIL=no
 VERBOSE=0
diff --git a/tools/testing/selftests/net/unicast_extensions.sh b/tools/testing/selftests/net/unicast_extensions.sh
index b7a2cb9e7477..f52aa5f7da52 100755
--- a/tools/testing/selftests/net/unicast_extensions.sh
+++ b/tools/testing/selftests/net/unicast_extensions.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 #
 # By Seth Schoen (c) 2021, for the IPv4 Unicast Extensions Project
@@ -28,7 +28,7 @@
 # These tests provide an easy way to flip the expected result of any
 # of these behaviors for testing kernel patches that change them.
 
-source ./lib.sh
+source lib.sh
 
 # nettest can be run from PATH or from same directory as this selftest
 if ! which nettest >/dev/null; then

base-commit: cd4d7263d58ab98fd4dee876776e4da6c328faa3
-- 
2.34.1


