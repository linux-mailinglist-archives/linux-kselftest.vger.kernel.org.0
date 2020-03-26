Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3181936D5
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 04:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgCZDZb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 23:25:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:53303 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbgCZDZa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 23:25:30 -0400
IronPort-SDR: s4UQgJmIejk3VLJLH41WWRqHY0jdBHvZcXuQMm9HI86DWyarjKvVIbWB3R2cF9iRyDytmI2Eoy
 DhUE5XtXE57g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 20:25:29 -0700
IronPort-SDR: TQP58wxqJHStCgf82omJMZzoodNQcpnqWADTBT0t3RDce8k4I2RL+UXv8iUUV8eyogYjZXR+oE
 pJrP3oPHtEYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,306,1580803200"; 
   d="scan'208";a="446842797"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.39])
  by fmsmga005.fm.intel.com with ESMTP; 25 Mar 2020 20:25:27 -0700
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [RFC v3 0/3] Fix errors when try to build kvm selftests on specified output
Date:   Thu, 26 Mar 2020 11:07:47 +0800
Message-Id: <20200326030750.173972-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

Hope you're happy with this version that I only touch KVM's Makefile.

I attempted to build KVM selftests on a specified dir, unfortunately
neither	"make O=/path/to/mydir TARGETS=kvm" in tools/testing/selftests, nor
"make OUTPUT=/path/to/mydir" in tools/testing/selftests/kvm work.

This series aims to fix them.

Patch 1 and Patch 3 are the fix patch, please see the seperate for details.
While Patch 2 is more or less an fix for the future issue, since it works
without Patch 2 currently.

Changes in v3:
 - Drop all the patches that touch things out of KVM
 - Create OUTPUT dir in KVM's Makefile
 - Correct the INSTALL_HDR_PATH in KVM's Makefile

Changes in v2:
https://lore.kernel.org/kvm/20200325140133.103236-1-xiaoyao.li@intel.com/
 - fix the no directory issue in lib.mk
 - make kvm fixes seperate patch
 - Add the patch to fix linux src tree not clean issue

v1:
https://lore.kernel.org/kvm/20200315093425.33600-1-xiaoyao.li@intel.com/

Xiaoyao Li (3):
  kvm: selftests: Fix no directory error when OUTPUT specified
  kvm: selftests: Use the right INSTALL_HDR_PATH when OUTPUT specified
    and MAKELEVEL is 0
  kvm: selftests: Fix header path when built from parent level with O
    specified

 tools/testing/selftests/kvm/Makefile | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

-- 
2.20.1

