Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9033F2478
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Aug 2021 03:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbhHTB7P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Aug 2021 21:59:15 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41738 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234428AbhHTB7P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Aug 2021 21:59:15 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Akw+xbamDvtd26P+Sn+GA+fpoPEPpDfIQ3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fw9vre+MjzsCWYtN9/Yh8dcK+7UpVoLUm8yXcX2/h1AV7BZniEhI?=
 =?us-ascii?q?LAFugLgrcKqAeQeREWmNQ86Y5QN4B6CPDVSWNxlNvG5mCDeOoI8Z2q97+JiI7l?=
 =?us-ascii?q?o0tQcQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,336,1620662400"; 
   d="scan'208";a="113155626"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 20 Aug 2021 09:58:35 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id B5CF14D0D4BE;
        Fri, 20 Aug 2021 09:58:31 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 20 Aug 2021 09:58:32 +0800
Received: from FNSTPC.g08.fujitsu.local (10.167.226.45) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 20 Aug 2021 09:58:10 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kafai@fb.com>, <songliubraving@fb.com>, <yhs@fb.com>,
        <kpsingh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <philip.li@intel.com>, <yifeix.zhu@intel.com>,
        Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [PATCH v2 0/5] selftests/bpf: minor fixups
Date:   Fri, 20 Aug 2021 09:55:52 +0800
Message-ID: <20210820015556.23276-1-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: B5CF14D0D4BE.A1391
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix a few issues reported by 0Day/LKP during runing selftests/bpf.

Changelog:
V2:
- folded previous similar standalone patch to [1/5], and add acked tag
  from Song Liu
- add acked tag to [2/5], [3/5] from Song Liu
- [4/5]: move test_bpftool.py to TEST_PROGS_EXTENDED, files in TEST_GEN_PROGS_EXTENDED
are generated by make. Otherwise, it will break out-of-tree install:
'make O=/kselftest-build SKIP_TARGETS= V=1 -C tools/testing/selftests install INSTALL_PATH=/kselftest-install'
- [5/5]: new patch


Li Zhijian (5):
  selftests/bpf: enlarge select() timeout for test_maps
  selftests/bpf: make test_doc_build.sh work from script directory
  selftests/bpf: add default bpftool built by selftests to PATH
  selftests/bpf: add missing files required by test_bpftool.sh for
    installing
  selftests/bpf: exit with KSFT_SKIP if no Makefile found

 tools/testing/selftests/bpf/Makefile              |  4 +++-
 tools/testing/selftests/bpf/test_bpftool.sh       |  6 ++++++
 tools/testing/selftests/bpf/test_bpftool_build.sh |  2 +-
 tools/testing/selftests/bpf/test_doc_build.sh     | 10 ++++++++--
 tools/testing/selftests/bpf/test_maps.c           |  2 +-
 5 files changed, 19 insertions(+), 5 deletions(-)

-- 
2.32.0



