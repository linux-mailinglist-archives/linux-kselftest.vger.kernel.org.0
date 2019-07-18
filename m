Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7B566CDB4
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2019 13:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfGRLzd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Jul 2019 07:55:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfGRLzd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Jul 2019 07:55:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D58080F79;
        Thu, 18 Jul 2019 11:55:33 +0000 (UTC)
Received: from thuth.com (dhcp-200-228.str.redhat.com [10.33.200.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49F0D5D71A;
        Thu, 18 Jul 2019 11:55:32 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc:     trivial@kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] KVM: selftests: Remove superfluous define from vmx.c
Date:   Thu, 18 Jul 2019 13:55:27 +0200
Message-Id: <20190718115527.6996-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 18 Jul 2019 11:55:33 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The code in vmx.c does not use "program_invocation_name", so there
is no need to "#define _GNU_SOURCE" here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/kvm/lib/x86_64/vmx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/vmx.c b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
index fe56d159d65f..204f847bd065 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
@@ -5,8 +5,6 @@
  * Copyright (C) 2018, Google LLC.
  */
 
-#define _GNU_SOURCE /* for program_invocation_name */
-
 #include "test_util.h"
 #include "kvm_util.h"
 #include "processor.h"
-- 
2.21.0

