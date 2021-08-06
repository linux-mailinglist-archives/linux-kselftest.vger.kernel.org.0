Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443323E1FD4
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Aug 2021 02:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhHFARZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Aug 2021 20:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhHFARZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Aug 2021 20:17:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A3AB60F70;
        Fri,  6 Aug 2021 00:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628209030;
        bh=3+LLU1pJoS49U9BXbYP836d9dFvYM6TuxF/wC9dTFNE=;
        h=From:To:Cc:Subject:Date:From;
        b=qIwxqe1OMSqSHzEoEj7Goq6oW1XmbSV14jsKYAuiei4GYjvNJVJRTb3F4SnihxKxa
         oMsXjSiwtSv5Lc7+ROwaMM+pP4ZDbNag5PPBSXndzxPzJly9GJSCx/rutPElmE7jDW
         rltw5nyyvKQaBWQIklkxgPx77xrSZcyt6kjhXIgaAZc3OOu4mGWB9F9y1AYS9Yvraz
         qWimW8RsT+Z1/d3AAoOM6AX/vCKcd9b2CqNDWlGCTZZ7ZfIkeZdgWzSjgNHB6m2F+8
         oBIcVrtkBGm159rwTBj0yztU5QS81zYxseVitrKVM80GgiR2pI4ViQas5iTZCTRn+J
         snlnQQ6FmOXrA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH v3 0/8] Add an oversubscription test
Date:   Fri,  6 Aug 2021 03:16:56 +0300
Message-Id: <20210806001704.667889-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The goal of these patches is to add a test case for a SGX reserved
memory oversubscription, i.e. make sure that the page reclaimer and
and the page fault handler are working correctly.

Change Log
==========

v3:
* Reorganized the patch set into smaller pieces, and refactored the code so that
  the test enclave can be created inside each test case. Added a new test case
  unclobbered_vdso_oversubscribed that creates a large enough heap to
  fill all of the available SGX reserved memory (EPC).

Jarkko Sakkinen (8):
  x86/sgx: Add /sys/kernel/debug/x86/sgx_total_mem
  selftests/sgx: Assign source for each segment
  selftests/sgx: Make data measurement for an enclave segment optional
  selftests/sgx: Create a heap for the test enclave
  selftests/sgx: Dump segments and /proc/self/maps only on failure
  selftests/sgx: Encpsulate the test enclave creation
  selftests/sgx: Move setup_test_encl() to each TEST_F()
  selftests/sgx: Add a new kselftest: unclobbered_vdso_oversubscribed

 Documentation/x86/sgx.rst               |   6 ++
 arch/x86/kernel/cpu/sgx/main.c          |  10 +-
 tools/testing/selftests/sgx/load.c      |  40 ++++++--
 tools/testing/selftests/sgx/main.c      | 129 ++++++++++++++++++++----
 tools/testing/selftests/sgx/main.h      |   7 +-
 tools/testing/selftests/sgx/sigstruct.c |  12 ++-
 6 files changed, 165 insertions(+), 39 deletions(-)

-- 
2.32.0

