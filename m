Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AB139EFC2
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 09:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhFHHje (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 03:39:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:17005 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhFHHjd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 03:39:33 -0400
IronPort-SDR: hQSlXjflZj2dUQeyuOr78YcaRlyXtOXoTRliLJzocdKhD9uMdnnKozB2Gm3m1r0cOR6k51oeMB
 eBccPOvIyShQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="185164399"
X-IronPort-AV: E=Sophos;i="5.83,257,1616482800"; 
   d="scan'208";a="185164399"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 00:37:24 -0700
IronPort-SDR: a3AyfdB1wLTxnGAseGPB/oIrHubuVUcco3zHDuSJtJVc+lGBAhEuHqhvLNoPL3lCrgybyBOefg
 n3eeuzYcZn9w==
X-IronPort-AV: E=Sophos;i="5.83,257,1616482800"; 
   d="scan'208";a="481846532"
Received: from duan-client-optiplex-7080.bj.intel.com ([10.238.156.114])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 00:37:20 -0700
From:   Zhenzhong Duan <zhenzhong.duan@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        maciej.szmigiero@oracle.com, drjones@redhat.com,
        pbonzini@redhat.com, shuah@kernel.org,
        Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 0/3] Restore extra_mem_pages and add slot0_mem_pages
Date:   Wed,  9 Jun 2021 07:38:13 +0800
Message-Id: <20210608233816.423958-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

(39fe2fc96694 "selftests: kvm: make allocation of extra memory take effect")
changed the meaning of extra_mem_pages and treated it as slot0 memory size.

In fact extra_mem_pages is used for non-slot0 memory size, there is no custom
slot0 memory size support. See discuss in https://lkml.org/lkml/2021/6/3/551
for more details.

This patchset restores extra_mem_pages's original meaning and adds support for
custom slot0 memory with a new parameter slot0_mem_pages.

Run below command, all 39 tests passed.
# make -C tools/testing/selftests/ TARGETS=kvm run_tests

Zhenzhong Duan (3):
  Revert "selftests: kvm: make allocation of extra memory take effect"
  Revert "selftests: kvm: fix overlapping addresses in
    memslot_perf_test"
  selftests: kvm: Add support for customized slot0 memory size

 .../testing/selftests/kvm/include/kvm_util.h  |  7 +--
 .../selftests/kvm/kvm_page_table_test.c       |  2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 47 +++++++++++++++----
 .../selftests/kvm/lib/perf_test_util.c        |  2 +-
 .../testing/selftests/kvm/memslot_perf_test.c |  2 +-
 5 files changed, 45 insertions(+), 15 deletions(-)

-- 
2.25.1

