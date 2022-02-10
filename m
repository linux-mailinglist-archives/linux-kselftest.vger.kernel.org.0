Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D164B1421
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 18:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245190AbiBJRYW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 12:24:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiBJRYV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 12:24:21 -0500
X-Greylist: delayed 259 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 09:24:22 PST
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4ADC2C;
        Thu, 10 Feb 2022 09:24:22 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 30FC31F466D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644513861;
        bh=ALxCZNhUUa/MLQDGtz0GZiz11DXsiOowCf8Tsc6t5l4=;
        h=From:To:Cc:Subject:Date:From;
        b=EtqS5EoOTji9b+9Jc1s93a42qgJoKE8VvsCtatEIpgvgXblqZBqboEVRqgOMQu+IX
         L48WaQIAKWT3MK79MVZR0ojw8CRPRcVwHTSXgL3+vrQG7cHyXAnN1KhGFk2vX7eF2R
         O65JAN1BQn3RSH9p/MhxU8xHmrh8QF46c4C1gdsnZzXEfCXzUiBHSnyEmh0mmSPnNA
         2+IpK+DopLoxhSNf8IR5C7E1nOrdG1lT+medR8UinzszX7zZy0ob6rtz3Vczh7AfLv
         srCUe5HIwvBXIqiQRTedimpCwWa04vByDW/eoUTc+ctiG2do3NQ4YFiKZrNWTkZPlA
         3W7cQVOsWE+Sg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Peter Gonda <pgonda@google.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernelci@groups.io,
        "kernelci.org bot" <bot@kernelci.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] selftests: kvm: Remove absent target file
Date:   Thu, 10 Feb 2022 22:23:51 +0500
Message-Id: <20220210172352.1317554-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is no vmx_pi_mmio_test file. Remove it to get rid of error while
creation of selftest archive:

rsync: [sender] link_stat "/kselftest/kvm/x86_64/vmx_pi_mmio_test" failed: No such file or directory (2)
rsync error: some files/attrs were not transferred (see previous errors) (code 23) at main.c(1333) [sender=3.2.3]

Fixes: 6a58150859fd ("selftest: KVM: Add intra host migration tests")
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes in V2:
Edited the subject line
---
 tools/testing/selftests/kvm/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index d61286208e242..b970397f725c7 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -82,7 +82,6 @@ TEST_GEN_PROGS_x86_64 += x86_64/tsc_msrs_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_pmu_msrs_test
 TEST_GEN_PROGS_x86_64 += x86_64/xen_shinfo_test
 TEST_GEN_PROGS_x86_64 += x86_64/xen_vmcall_test
-TEST_GEN_PROGS_x86_64 += x86_64/vmx_pi_mmio_test
 TEST_GEN_PROGS_x86_64 += x86_64/sev_migrate_tests
 TEST_GEN_PROGS_x86_64 += x86_64/amx_test
 TEST_GEN_PROGS_x86_64 += access_tracking_perf_test
-- 
2.30.2

