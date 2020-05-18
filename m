Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1A21D8A81
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 00:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgERWOD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 May 2020 18:14:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:46558 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgERWOD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 May 2020 18:14:03 -0400
IronPort-SDR: H/9UqkEJ5H4zJARwHTFqP3JNMOnlpzjiZM0XHquipkKfjlRgHDe4wKrOgLYynmRPFQMpkbWx7E
 lknYIKzd53kw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 15:14:02 -0700
IronPort-SDR: SWqeXuK/PeRlwSQ43+LrOWEvAGBpp/PO56Wdw7S2jk8xRfXISjz0zqaR25WbowL7OdcBqaZykz
 Gl0jHv36rbYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="411420433"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga004.jf.intel.com with ESMTP; 18 May 2020 15:14:02 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     shuah@kernel.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, reinette.chatre@intel.com, babu.moger@amd.com,
        james.morse@arm.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel,
        dan.carpenter@oracle.com, dcb314@hotmail.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH V2 16/19] selftests/resctrl: Umount resctrl FS only if mounted
Date:   Mon, 18 May 2020 15:08:36 -0700
Message-Id: <f65df6aa5dc5b66ac804389e7859a08101107285.1589835155.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
References: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, umount_resctrlfs() directly attempts to unmount resctrl FS
without checking if resctrl FS is already mounted or not. But, there
could be situations where-in the caller might not know if resctrl FS is
already mounted or not. The caller might want to unmount resctrl FS _only_
if it's already mounted.

Hence, change umount_resctrlfs() such that it now first checks if resctrl
FS is mounted or not and unmounts resctrl FS only if it's already mounted
and does nothing if it's not mounted.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 tools/testing/selftests/resctrl/resctrlfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 83cd3b026c52..ebc8e3b4f7ff 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -92,8 +92,10 @@ int remount_resctrlfs(bool mum_resctrlfs)
 
 void umount_resctrlfs(void)
 {
-	if (umount(RESCTRL_PATH))
-		perror("# Unable to umount resctrl");
+	if (!find_resctrl_mount(NULL)) {
+		if (umount(RESCTRL_PATH))
+			perror("# Unable to umount resctrl");
+	}
 }
 
 /*
-- 
2.19.1

