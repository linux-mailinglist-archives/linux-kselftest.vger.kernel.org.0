Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F54C3D990C
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 00:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhG1Wvq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 18:51:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232073AbhG1Wvq (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 18:51:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3E376101B;
        Wed, 28 Jul 2021 22:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627512704;
        bh=HJCA56HhX64aO6/kYtMpnmi2Ouy6Lnw/ykKlCyXXl8s=;
        h=From:To:Cc:Subject:Date:From;
        b=Mui66WZbRkHlpIU0m0qaPITE0IBF1cVbMgOHGK/pW0imiwAYyFXnPPV4dDFBVbeL5
         xbMYtdbbNLBv97V7bM4z5DeX8MQ66awcUsAJZiaxVo4z1dAz1dSI+/KLUQ4CsOVzIM
         L1AgfS1B9CU8FM1Vy5QLAGBfvM74E4Y3hIlHRK/XKkCnw5vsJ3n1adcMtTmgqWhYqk
         WjQ6E5jCs6uzcRPUXe48Y54w16fz1kA+tKjZT53alxskiDgQRYijP5CwlqBFITaD6o
         zL2q/BCV6oxZDxVHsnVhcLA7EQRc2gTjwpnEY5keor6UnSWpeShkrBrxn2pqtRZ0MB
         aNFNc019hV9uQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2 0/4] Swap and fault all the pages of the test enclave binary
Date:   Thu, 29 Jul 2021 01:51:36 +0300
Message-Id: <20210728225140.248408-1-jarkko@kernel.org>
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
  x86/sgx: Add /sys/kernel/debug/x86/sgx_total_mem
  selftests/sgx: Assign source for each segment
  selftests/sgx: Trigger the reclaimer and #PF handler

Tianjia Zhang (1):
  selftests/sgx: Fix calculations for sub-maximum field sizes

 Documentation/x86/sgx.rst               |  6 +++
 arch/x86/kernel/cpu/sgx/main.c          | 10 ++++-
 tools/testing/selftests/sgx/load.c      | 38 ++++++++++++++----
 tools/testing/selftests/sgx/main.c      | 42 +++++++++++++++++++-
 tools/testing/selftests/sgx/main.h      |  4 +-
 tools/testing/selftests/sgx/sigstruct.c | 53 +++++++++++++------------
 6 files changed, 117 insertions(+), 36 deletions(-)

-- 
2.32.0

