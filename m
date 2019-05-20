Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E52C5231D3
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2019 12:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbfETKzZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 May 2019 06:55:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfETKzZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 May 2019 06:55:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6572630842B0;
        Mon, 20 May 2019 10:55:25 +0000 (UTC)
Received: from thuth.com (ovpn-117-9.ams2.redhat.com [10.36.117.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 964CA5D967;
        Mon, 20 May 2019 10:55:22 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: Remove duplicated TEST_ASSERT in hyperv_cpuid.c
Date:   Mon, 20 May 2019 12:55:11 +0200
Message-Id: <20190520105511.12471-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 20 May 2019 10:55:25 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The check for entry->index == 0 is done twice. One time should
be sufficient.

Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Vitaly already noticed this in his review to the "Fix a condition
 in test_hv_cpuid()" patch a couple of days ago, but so far I haven't
 seen any patch yet on the list that fixes this ... if I missed it
 instead, please simply ignore this patch.

 tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
index 9a21e912097c..8bdf1e7da6cc 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
@@ -52,9 +52,6 @@ static void test_hv_cpuid(struct kvm_cpuid2 *hv_cpuid_entries,
 		TEST_ASSERT(entry->index == 0,
 			    ".index field should be zero");
 
-		TEST_ASSERT(entry->index == 0,
-			    ".index field should be zero");
-
 		TEST_ASSERT(entry->flags == 0,
 			    ".flags field should be zero");
 
-- 
2.21.0

