Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DE23BBE47
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jul 2021 16:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhGEOje (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jul 2021 10:39:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhGEOje (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jul 2021 10:39:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2DD261879;
        Mon,  5 Jul 2021 14:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625495817;
        bh=p+2M+R0Bn65IW5IZV4PGTl/+j6Yiaju/yGI3iISfIPQ=;
        h=From:To:Cc:Subject:Date:From;
        b=CNzTtkEnVU1ZdPYy98P+uqq1AAq9wwmSrcmsJx4l3XSJbrGuIl1MuXbyRlJ2Iwc2J
         4tc/gU24C3R4RxuLlvVSPo2c1U5+0lXA79YAlVIuXk6X8N7QhsqYN3ENJBH5Kfssnb
         qhyapGS0LUDGfu5AF4+23Uos5ay3obWSGw4SMNRPaJY0O6Kx06RWbJB78RVFX+QtOj
         a1LM6SYaJVztzKmHlxhC8IL8d0PF/Mx7VWU05JnI5PRXTUbytp/9VuXWRDHbQvMGqi
         wd35Ryi3oCZ6/YW+VPBoiesITX96A99hwQIbdU+1XypieF01G1t8jCG7PjJUzAogJc
         IKBBwvUzUPEng==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 0/4] selftests/sgx: Trigger the page reclaimer and #PF handler
Date:   Mon,  5 Jul 2021 17:36:48 +0300
Message-Id: <20210705143652.116125-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Create a heap for the test enclave, which has the same size as all
available Enclave Page Cache (EPC) pages in the system. This will guarantee
that all test_encl.elf pages *and* SGX Enclave Control Structure (SECS)
have been swapped out by the page reclaimer during the load time. Actually,
this adds a bit more stress than that since part of the EPC gets reserved
for the Version Array (VA) pages.

For each test, the page fault handler gets triggered in two occasions:

- When SGX_IOC_ENCLAVE_INIT is performed, SECS gets swapped in by the
  page fault handler.
- During the execution, each page that is referenced gets swapped in
  by the page fault handler.

Jarkko Sakkinen (3):
  x86/sgx: Add sgx_nr_all_pages to the debugfs
  selftests/sgx: Assign source for each segment
  selftests/sgx: Trigger the reclaimer and #PF handler

Tianjia Zhang (1):
  selftests/sgx: Fix Q1 and Q2 calculation in sigstruct.c

 Documentation/x86/sgx.rst               |  9 +++++
 arch/x86/kernel/cpu/sgx/main.c          | 10 ++++-
 tools/testing/selftests/sgx/load.c      | 38 ++++++++++++++----
 tools/testing/selftests/sgx/main.c      | 42 +++++++++++++++++++-
 tools/testing/selftests/sgx/main.h      |  4 +-
 tools/testing/selftests/sgx/sigstruct.c | 53 +++++++++++++------------
 6 files changed, 120 insertions(+), 36 deletions(-)

-- 
2.32.0

