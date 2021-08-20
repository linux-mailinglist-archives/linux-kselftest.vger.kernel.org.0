Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56893F248A
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Aug 2021 03:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbhHTB7f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Aug 2021 21:59:35 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:39284 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237578AbhHTB7d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Aug 2021 21:59:33 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3APAqhlKijUo54We8URiOYysL+YnBQXuYji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHLoB1/73LJYVkqNk3I5urrBEDtexLhHP1OkOws1NWZLWrbUQ?=
 =?us-ascii?q?KTRekM0WKI+UyDJ8SRzI5g/JYlW61/Jfm1NlJikPv9iTPSL/8QhPWB74Ck7N2z?=
 =?us-ascii?q?80tQ?=
X-IronPort-AV: E=Sophos;i="5.84,336,1620662400"; 
   d="scan'208";a="113155662"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 20 Aug 2021 09:58:54 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 804994D0D4BE;
        Fri, 20 Aug 2021 09:58:50 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 20 Aug 2021 09:58:44 +0800
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 20 Aug 2021 09:58:45 +0800
Received: from FNSTPC.g08.fujitsu.local (10.167.226.45) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 20 Aug 2021 09:58:44 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kafai@fb.com>, <songliubraving@fb.com>, <yhs@fb.com>,
        <kpsingh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <philip.li@intel.com>, <yifeix.zhu@intel.com>,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        "kernel test robot" <lkp@intel.com>
Subject: [PATCH v2 2/5] selftests/bpf: make test_doc_build.sh work from script directory
Date:   Fri, 20 Aug 2021 09:55:54 +0800
Message-ID: <20210820015556.23276-3-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210820015556.23276-1-lizhijian@cn.fujitsu.com>
References: <20210820015556.23276-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 804994D0D4BE.ADBC4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Previously, it fails as below:
-------------
root@lkp-skl-d01 /opt/rootfs/v5.14-rc4/tools/testing/selftests/bpf# ./test_doc_build.sh
++ realpath --relative-to=/opt/rootfs/v5.14-rc4/tools/testing/selftests/bpf ./test_doc_build.sh
+ SCRIPT_REL_PATH=test_doc_build.sh
++ dirname test_doc_build.sh
+ SCRIPT_REL_DIR=.
++ realpath /opt/rootfs/v5.14-rc4/tools/testing/selftests/bpf/./../../../../
+ KDIR_ROOT_DIR=/opt/rootfs/v5.14-rc4
+ cd /opt/rootfs/v5.14-rc4
+ for tgt in docs docs-clean
+ make -s -C /opt/rootfs/v5.14-rc4/. docs
make: *** No rule to make target 'docs'.  Stop.
+ for tgt in docs docs-clean
+ make -s -C /opt/rootfs/v5.14-rc4/. docs-clean
make: *** No rule to make target 'docs-clean'.  Stop.
-----------

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 tools/testing/selftests/bpf/test_doc_build.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_doc_build.sh b/tools/testing/selftests/bpf/test_doc_build.sh
index ed12111cd2f0..d67ced95a6cf 100755
--- a/tools/testing/selftests/bpf/test_doc_build.sh
+++ b/tools/testing/selftests/bpf/test_doc_build.sh
@@ -4,9 +4,10 @@ set -e
 
 # Assume script is located under tools/testing/selftests/bpf/. We want to start
 # build attempts from the top of kernel repository.
-SCRIPT_REL_PATH=$(realpath --relative-to=$PWD $0)
+SCRIPT_REL_PATH=$(realpath $0)
 SCRIPT_REL_DIR=$(dirname $SCRIPT_REL_PATH)
-KDIR_ROOT_DIR=$(realpath $PWD/$SCRIPT_REL_DIR/../../../../)
+KDIR_ROOT_DIR=$(realpath $SCRIPT_REL_DIR/../../../../)
+SCRIPT_REL_DIR=$(dirname $(realpath --relative-to=$KDIR_ROOT_DIR $SCRIPT_REL_PATH))
 cd $KDIR_ROOT_DIR
 
 for tgt in docs docs-clean; do
-- 
2.32.0



