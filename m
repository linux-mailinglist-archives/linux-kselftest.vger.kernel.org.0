Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6A0185BAE
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Mar 2020 10:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgCOJwR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Mar 2020 05:52:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:35235 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728108AbgCOJwR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Mar 2020 05:52:17 -0400
IronPort-SDR: HChpFelIJng41hdn2vxch5buzBS3a9o6bVvl3+U2mcGDDvesItcWJkwaWkQ4yoC8aTkzjMIBHy
 /3BMTf11vVgA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2020 02:52:16 -0700
IronPort-SDR: cuxcG9ERSYwCjvd61maY4zMtxSP5zttqBeHAybX768mImW+t4oxgyWF4bz4w1dRLN2ujMXQQnc
 l5XF4a8P1Abg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,556,1574150400"; 
   d="scan'208";a="416800326"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.160])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2020 02:52:15 -0700
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 0/2] Fix errors when try to build kvm selftests on
Date:   Sun, 15 Mar 2020 17:34:23 +0800
Message-Id: <20200315093425.33600-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I attempted to build KVM selftests on a specified dir, unfortunately
neither	"make O=~/mydir TARGETS=kvm" in tools/testing/selftests, nor
"make OUTPUT=~/mydir" in tools/testing/selftests/kvm work.

This series aims to make both work.

Xiaoyao Li (2):
  kvm: selftests: Fix no directory error when OUTPUT specified
  selftests: export INSTALL_HDR_PATH if using "O" to specify output dir

 tools/testing/selftests/Makefile     | 6 +++++-
 tools/testing/selftests/kvm/Makefile | 3 ++-
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.20.1

