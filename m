Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE7930A8B8
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Feb 2021 14:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbhBAN3E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Feb 2021 08:29:04 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:36763 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231145AbhBAN27 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Feb 2021 08:28:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0UNbR3Fq_1612186013;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UNbR3Fq_1612186013)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Feb 2021 21:26:53 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v4 0/5] Some optimizations related to sgx
Date:   Mon,  1 Feb 2021 21:26:48 +0800
Message-Id: <20210201132653.35690-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is an optimization of a set of sgx-related codes, each of which
is independent of the patch. Because the second and third patches have
conflicting dependencies, these patches are put together.

---
v4 changes:
  * Improvements suggested by review

v3 changes:
  * split free_cnt count and spin lock optimization into two patches

v2 changes:
  * review suggested changes

Tianjia Zhang (5):
  selftests/x86: Use getauxval() to simplify the code in sgx
  x86/sgx: Reduce the locking range in sgx_sanitize_section()
  x86/sgx: Optimize the free_cnt count in sgx_epc_section
  x86/sgx: Allows ioctl PROVISION to execute before CREATE
  x86/sgx: Remove redundant if conditions in sgx_encl_create

 arch/x86/kernel/cpu/sgx/driver.c   |  1 +
 arch/x86/kernel/cpu/sgx/ioctl.c    |  8 ++++----
 arch/x86/kernel/cpu/sgx/main.c     | 13 +++++--------
 tools/testing/selftests/sgx/main.c | 24 ++++--------------------
 4 files changed, 14 insertions(+), 32 deletions(-)

-- 
2.19.1.3.ge56e4f7

