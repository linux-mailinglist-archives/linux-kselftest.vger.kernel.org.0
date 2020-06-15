Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565CA1F8E64
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jun 2020 08:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgFOGtJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jun 2020 02:49:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbgFOGrN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jun 2020 02:47:13 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BF52208B3;
        Mon, 15 Jun 2020 06:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203632;
        bh=sTFjDVFNxvaxYL1XIBkVBYNkDxJgnmCW7W2tRtvvhLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ICoImG8MfZOxFPF4J9t5PiRfFS02yMYiYen8UYtYGTH/6L+bBsLSvJ57bf3MBjHVp
         Sqw/BUN+7pWxD2uMhLQg+R5NO9c/+0XeHuc0baGjOvfeaofkbPrlNjvLyIhxC7eOBT
         f993jZxvSg8IZTHnBu0AQJOhbhZBhrRpWf3wfRjM=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkith-009nn5-To; Mon, 15 Jun 2020 08:47:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 16/29] selftests/vm/keys: fix a broken reference at protection_keys.c
Date:   Mon, 15 Jun 2020 08:46:55 +0200
Message-Id: <8f0e19f790d5ac3beeea2b77f14f3afe538f7708.1592203542.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203542.git.mchehab+huawei@kernel.org>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changeset 1eecbcdca2bd ("docs: move protection-keys.rst to the core-api book")
from Jun 7, 2019 converted protection-keys.txt file to ReST.

A recent change at protection_keys.c partially reverted such
changeset, causing it to point to a non-existing file:

	- * Tests x86 Memory Protection Keys (see Documentation/core-api/protection-keys.rst)
	+ * Tests Memory Protection Keys (see Documentation/vm/protection-keys.txt)

It sounds to me that the changeset that introduced such change
4645e3563673 ("selftests/vm/pkeys: rename all references to pkru to a generic name")
could also have other side effects, as it sounds that it was not
generated against uptream code, but, instead, against a version
older than Jun 7, 2019.

Fixes: 4645e3563673 ("selftests/vm/pkeys: rename all references to pkru to a generic name")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/testing/selftests/vm/protection_keys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index fc19addcb5c8..fdbb602ecf32 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Tests Memory Protection Keys (see Documentation/vm/protection-keys.txt)
+ * Tests Memory Protection Keys (see Documentation/core-api/protection-keys.rst)
  *
  * There are examples in here of:
  *  * how to set protection keys on memory
-- 
2.26.2

