Return-Path: <linux-kselftest+bounces-2417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB2481DED0
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Dec 2023 08:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54F01F21C73
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Dec 2023 07:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CDE139E;
	Mon, 25 Dec 2023 07:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JgoUNfS1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E77A15AF;
	Mon, 25 Dec 2023 07:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703489133; x=1735025133;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BfzAFQ9bC5PkBKJdRJQbLjw96vqNP/rj3JExPsy7EoM=;
  b=JgoUNfS1oW6VgTwlt4lQA1i0B5GmzaOA6wg5QyW7Gl9h2xwiunv7EJrZ
   hLOBWrXrcKPWzEBYrkp+Rf3bx5haa3ki5Khu3qmi1Osbr30EpYBQ71HYA
   iXq/Q/vkAvQvzGJ0Li0E8fGK3xCtziC6BC8dEUHh3lZnU0cpyifGHTxP0
   kbV1ZG1IdEad1JWiBrn5YdBBw5mozmFUPsE04LdbSldJMoNacUYBOPaQE
   0IQD1RBlheaedlPYtHJ3MKFZZTpJG89AN67fHbBdQss9A5Dip5kNpdpFz
   YJUbVU9tKqbem/VaRHjdDP+7b9vTOARB2uOddzIq88pHP0xCire+L4Mab
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="375764978"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="375764978"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 23:25:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="727467086"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="727467086"
Received: from yujie-x299.sh.intel.com ([10.239.159.77])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 23:25:29 -0800
From: Yujie Liu <yujie.liu@intel.com>
To: netdev@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkp@intel.com,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH net-next] selftests/net: change the shebang of unicast_extensions.sh to bash
Date: Mon, 25 Dec 2023 15:21:09 +0800
Message-Id: <20231225072109.3835503-1-yujie.liu@intel.com>
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

The shebang of unicast_extensions.sh is /bin/sh which may point to various
shells in different distributions, but "source" is only available in some
of them. For example, "source" is a built-it function in bash, but it
cannot be used in dash.

Refer to other scripts that were converted together, simply change the
shebang to bash to suppress the following errors when the default /bin/sh
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

Link: https://lore.kernel.org/all/20231202020110.362433-1-liuhangbin@gmail.com/ [1]
Fixes: 0f4765d0b48d ("selftests/net: convert unicast_extensions.sh to run it in unique namespace")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Yujie Liu <yujie.liu@intel.com>
---
 tools/testing/selftests/net/unicast_extensions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/unicast_extensions.sh b/tools/testing/selftests/net/unicast_extensions.sh
index b7a2cb9e7477..2766990c2b78 100755
--- a/tools/testing/selftests/net/unicast_extensions.sh
+++ b/tools/testing/selftests/net/unicast_extensions.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 #
 # By Seth Schoen (c) 2021, for the IPv4 Unicast Extensions Project
-- 
2.34.1


