Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80A0713915D
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2020 13:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgAMMtL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 07:49:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:44084 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgAMMtL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 07:49:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DCBFEAF84;
        Mon, 13 Jan 2020 12:49:09 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        joe.lawrence@redhat.com, shuah@kernel.org
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 1/2] selftests/livepatch: Replace set_dynamic_debug() with setup_config() in README
Date:   Mon, 13 Jan 2020 13:49:06 +0100
Message-Id: <20200113124907.11086-2-mbenes@suse.cz>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200113124907.11086-1-mbenes@suse.cz>
References: <20200113124907.11086-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 35c9e74cff4c ("selftests/livepatch: Make dynamic debug setup and
restore generic") introduced setup_config() to set up the environment
for each test. It superseded set_dynamic_debug().  README still mentions
set_dynamic_debug(), so update it to setup_config() which should be used
now in every test.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 tools/testing/selftests/livepatch/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/livepatch/README b/tools/testing/selftests/livepatch/README
index b73cd0e2dd51..621d325425c2 100644
--- a/tools/testing/selftests/livepatch/README
+++ b/tools/testing/selftests/livepatch/README
@@ -35,7 +35,7 @@ Adding tests
 ------------
 
 See the common functions.sh file for the existing collection of utility
-functions, most importantly set_dynamic_debug() and check_result().  The
+functions, most importantly setup_config() and check_result().  The
 latter function greps the kernel's ring buffer for "livepatch:" and
 "test_klp" strings, so tests be sure to include one of those strings for
 result comparison.  Other utility functions include general module
-- 
2.24.1

