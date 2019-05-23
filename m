Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2D4728D1D
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 00:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388675AbfEWWbi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 18:31:38 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59980 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388510AbfEWWbM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 18:31:12 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hTwEs-00062U-Et; Thu, 23 May 2019 16:31:10 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hTwEq-0001SN-Eg; Thu, 23 May 2019 16:31:04 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 23 May 2019 16:30:58 -0600
Message-Id: <20190523223100.5526-9-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523223100.5526-1-logang@deltatee.com>
References: <20190523223100.5526-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, jdmason@kudzu.us, joro@8bytes.org, bhelgaas@google.com, dave.jiang@intel.com, allenbh@gmail.com, fancer.lancer@gmail.com, epilmore@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5 08/10] NTB: Add ntb_msi_test support to ntb_test
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When the ntb_msi_test module is available, the test code will trigger
each of the interrupts and ensure the corresponding occurrences files
gets incremented.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
---
 tools/testing/selftests/ntb/ntb_test.sh | 54 ++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ntb/ntb_test.sh b/tools/testing/selftests/ntb/ntb_test.sh
index 17ca36403d04..1a10b8f67727 100755
--- a/tools/testing/selftests/ntb/ntb_test.sh
+++ b/tools/testing/selftests/ntb/ntb_test.sh
@@ -87,10 +87,10 @@ set -e
 
 function _modprobe()
 {
-	modprobe "$@"
+	modprobe "$@" || return 1
 
 	if [[ "$REMOTE_HOST" != "" ]]; then
-		ssh "$REMOTE_HOST" modprobe "$@"
+		ssh "$REMOTE_HOST" modprobe "$@" || return 1
 	fi
 }
 
@@ -451,6 +451,30 @@ function pingpong_test()
 	echo "  Passed"
 }
 
+function msi_test()
+{
+	LOC=$1
+	REM=$2
+
+	write_file 1 $LOC/ready
+
+	echo "Running MSI interrupt tests on: $(subdirname $LOC) / $(subdirname $REM)"
+
+	CNT=$(read_file "$LOC/count")
+	for ((i = 0; i < $CNT; i++)); do
+		START=$(read_file $REM/../irq${i}_occurrences)
+		write_file $i $LOC/trigger
+		END=$(read_file $REM/../irq${i}_occurrences)
+
+		if [[ $(($END - $START)) != 1 ]]; then
+			echo "MSI did not trigger the interrupt on the remote side!" >&2
+			exit 1
+		fi
+	done
+
+	echo "  Passed"
+}
+
 function perf_test()
 {
 	USE_DMA=$1
@@ -529,6 +553,29 @@ function ntb_pingpong_tests()
 	_modprobe -r ntb_pingpong
 }
 
+function ntb_msi_tests()
+{
+	LOCAL_MSI="$DEBUGFS/ntb_msi_test/$LOCAL_DEV"
+	REMOTE_MSI="$REMOTE_HOST:$DEBUGFS/ntb_msi_test/$REMOTE_DEV"
+
+	echo "Starting ntb_msi_test tests..."
+
+	if ! _modprobe ntb_msi_test 2> /dev/null; then
+		echo "  Not doing MSI tests seeing the module is not available."
+		return
+	fi
+
+	port_test $LOCAL_MSI $REMOTE_MSI
+
+	LOCAL_PEER="$LOCAL_MSI/peer$LOCAL_PIDX"
+	REMOTE_PEER="$REMOTE_MSI/peer$REMOTE_PIDX"
+
+	msi_test $LOCAL_PEER $REMOTE_PEER
+	msi_test $REMOTE_PEER $LOCAL_PEER
+
+	_modprobe -r ntb_msi_test
+}
+
 function ntb_perf_tests()
 {
 	LOCAL_PERF="$DEBUGFS/ntb_perf/$LOCAL_DEV"
@@ -550,6 +597,7 @@ function cleanup()
 	_modprobe -r ntb_perf 2> /dev/null
 	_modprobe -r ntb_pingpong 2> /dev/null
 	_modprobe -r ntb_transport 2> /dev/null
+	_modprobe -r ntb_msi_test 2> /dev/null
 	set -e
 }
 
@@ -586,5 +634,7 @@ ntb_tool_tests
 echo
 ntb_pingpong_tests
 echo
+ntb_msi_tests
+echo
 ntb_perf_tests
 echo
-- 
2.20.1

