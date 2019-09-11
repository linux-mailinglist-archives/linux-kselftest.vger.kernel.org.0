Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8EDAF902
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2019 11:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfIKJex (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Sep 2019 05:34:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:45394 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725616AbfIKJex (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Sep 2019 05:34:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 537DAAEA4;
        Wed, 11 Sep 2019 09:34:51 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-kselftest@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-integrity@vger.kernel.org
Subject: [PATCH] selftests/tpm2: Add log and *.pyc to .gitignore
Date:   Wed, 11 Sep 2019 11:34:42 +0200
Message-Id: <20190911093442.13412-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fixes: 6ea3dfe1e073 ("selftests: add TPM 2.0 tests")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 tools/testing/selftests/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/.gitignore b/tools/testing/selftests/.gitignore
index 8059ce834247..61df01cdf0b2 100644
--- a/tools/testing/selftests/.gitignore
+++ b/tools/testing/selftests/.gitignore
@@ -2,3 +2,5 @@ gpiogpio-event-mon
 gpiogpio-hammer
 gpioinclude/
 gpiolsgpio
+tpm2/SpaceTest.log
+tpm2/*.pyc
-- 
2.22.1

