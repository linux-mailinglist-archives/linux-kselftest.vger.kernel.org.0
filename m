Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20103E42AD
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Aug 2021 11:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbhHIJby (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Aug 2021 05:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234338AbhHIJby (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Aug 2021 05:31:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A187360EE7;
        Mon,  9 Aug 2021 09:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628501494;
        bh=+KqkAyGByVyyPvBABgZGemTQKNRfitcRyp+gXqI3bgM=;
        h=From:To:Cc:Subject:Date:From;
        b=FJ9EtegxAtLqEQ3eAQIvE2XHdnnV/n62W7eseIeiCBarXeAz95pWmqI2qzxTyGQVw
         woHXWnX9qbCO3qa5oPhsKyS3t0w29MkCoF0HFxTwmZIKRWqKtlxqaFYnc2+AT23d0a
         0CZCTN7p2wX89/sJ51M8nhFyMObk24Y1r/CwWlWYScWdCZW+oLYvkIYTUPQ88woJ+I
         SjKP1dz+sR3x8RKEh31drcwTTAMY997gmisgEJNw2m/YC7l1WGY8A/Zi2U57OzEY0g
         HAsWWqMIh+VRlBrekYht60Eto/0K7gWwpm9q9QIUJYs2orqlE6TgNCHOTz0VGJper3
         x8Izziz9B3Vkw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH v4 0/8] Add an oversubscription test
Date:   Mon,  9 Aug 2021 12:31:19 +0300
Message-Id: <20210809093127.76264-1-jarkko@kernel.org>
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
* Reorganized the patch set into smaller pieces, and refactored the code
  so that the test enclave can be created inside each test case. Added a
  new test case unclobbered_vdso_oversubscribed that creates a large enough
  heap to fill all of the available SGX reserved memory (EPC).

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
 tools/testing/selftests/sgx/main.c      | 123 +++++++++++++++++++-----
 tools/testing/selftests/sgx/main.h      |   7 +-
 tools/testing/selftests/sgx/sigstruct.c |  12 ++-
 6 files changed, 159 insertions(+), 39 deletions(-)

-- 
2.32.0

