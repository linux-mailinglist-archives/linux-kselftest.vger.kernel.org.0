Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7BB7C4E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2019 16:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfGaO24 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Jul 2019 10:28:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50186 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfGaO24 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Jul 2019 10:28:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 87BA4550CF;
        Wed, 31 Jul 2019 14:28:56 +0000 (UTC)
Received: from thuth.com (dhcp-200-228.str.redhat.com [10.33.200.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C8A860BEC;
        Wed, 31 Jul 2019 14:28:55 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: Update gitignore file for latest changes
Date:   Wed, 31 Jul 2019 16:28:51 +0200
Message-Id: <20190731142851.9793-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 31 Jul 2019 14:28:56 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kvm_create_max_vcpus test has been moved to the main directory,
and sync_regs_test is now available on s390x, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/kvm/.gitignore | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 41266af0d3dc..b35da375530a 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -1,7 +1,7 @@
+/s390x/sync_regs_test
 /x86_64/cr4_cpuid_sync_test
 /x86_64/evmcs_test
 /x86_64/hyperv_cpuid
-/x86_64/kvm_create_max_vcpus
 /x86_64/mmio_warning_test
 /x86_64/platform_info_test
 /x86_64/set_sregs_test
@@ -13,3 +13,4 @@
 /x86_64/vmx_tsc_adjust_test
 /clear_dirty_log_test
 /dirty_log_test
+/kvm_create_max_vcpus
-- 
2.21.0

