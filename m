Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A0249DD67
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 10:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbiA0JLo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 04:11:44 -0500
Received: from mail1.bemta36.messagelabs.com ([85.158.142.2]:41369 "EHLO
        mail1.bemta36.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234720AbiA0JLn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 04:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1643274702; i=@fujitsu.com;
        bh=yLCIJVWEK8KMi/aphBImfyxdrYAmuaGaOGrxx6uxxKs=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=oCw5Wj372eVLndvdQa+PS1n4JPDIgT784pvUDMFZ94mIwwWB5qfAVsLU3v/UNzoMp
         xi+HJXp9SQ+TYEXYIxQ3Y38Dvd2FaNQJM2Ba32rsTz1deW/BWCHEd4lvtiL5+JJ8kn
         XHPaH0R9vdARbnaSQw40XHVtZJ2NHkAiL0o7dJ9ALj6sRG+YTBhmgLrEUpY1FC+2YV
         1UNoL4hKz2h+HXbHsxZaBsAF0oF2zV9bBnsvRH4/AEKj3ro4bsnaUlNmFdtx16oq3L
         UW5LdD72pUuVq/dFZQX1wj3a7QsteiEI4XZZAjnaLn5wbNeF9i6BtOE8i4L7IfkLiA
         PZKWBQAH56oWQ==
Received: from [100.115.65.74] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-central-1.aws.ess.symcld.net id 1A/83-30582-EC162F16; Thu, 27 Jan 2022 09:11:42 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRWlGSWpSXmKPExsViZ8MRons28VO
  iQfsuU4vLu+awWUy/857N4tYnfosft26wWOydvozVgdXjzrU9bB77565h9ziz4Ai7x+dNcgEs
  UayZeUn5FQmsGUefz2QsOMdT8eDrGtYGxlNcXYxcHEICLxkljq9oZ4dw9jBKrJ37j7mLkZODT
  UBT4lnnAjBbRMBJYuPVbkYQm1mgTmLTvs9sILawQLjE32sLWLoYOThYBFQlNuzLAAnzCnhI7H
  nTAFYuIaAgMeXhe7AxnALuEosu/GcCsYUE3CR2zzjJBFEvKHFy5hMWiPESEgdfvGCG6FWUuNT
  xDWpOhcSsWW1MExj5ZyFpmYWkZQEj0ypG26SizPSMktzEzBxdQwMDXUNDU10zE11jE73EKt1E
  vdRS3eTUvJKiRKCsXmJ5sV5qcbFecWVuck6KXl5qySZGYGinFDso7WA82/dT7xCjJAeTkijvE
  vNPiUJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkePNjgXKCRanpqRVpmTnAOINJS3DwKInw+iUApX
  mLCxJzizPTIVKnGBWlxHndQBICIImM0jy4NlhsX2KUlRLmZWRgYBDiKUgtys0sQZV/xSjOwag
  kzJsGMoUnM68EbvoroMVMQIt/n38HsrgkESEl1cCks9jBtuD3uuDYb7y/FCzCF94Ln6X6gcHq
  qeGL8EW3mfiXvtbqajuz4Lve7/pDVdI7Ju6Srzo0LTJfW0H7ef6r/DSuau6qX39epWd/DVM55
  bjN+RVrYVWa6/Wc7eFGWvtNm49fStX98PD1bSHZTy9uzH//a8YEraMpZRVPllYeOrDAfL3H54
  1iHEqCKzo7/mvNNjrbfivUMCkvwztdy+frdcO9Lt63Vhom7eWzOmd2ys5Dbe/0KxYeCY9jRVv
  uO0X4XpS85r/+9/Tv4k+Oz/HdULmjOnJ9GuuKrmCmV7oacgph1XV6si+PcW6vsubbOJNd8MWL
  V8fOcB3RuFvgVOjItJn1t+3TisZQm9bQuB9KLMUZiYZazEXFiQAqu9HFaAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-19.tower-528.messagelabs.com!1643274701!6926!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28026 invoked from network); 27 Jan 2022 09:11:41 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
  by server-19.tower-528.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 27 Jan 2022 09:11:41 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 20R9BXxT019758
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 27 Jan 2022 09:11:35 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Thu, 27 Jan 2022 09:11:30 +0000
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-kselftest@vger.kernel.org>, <skhan@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <naresh.kamboju@linaro.org>,
        <pvorel@suse.cz>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2 1/3] selftests/zram: Skip max_comp_streams interface on newer kernel
Date:   Thu, 27 Jan 2022 17:11:35 +0800
Message-ID: <1643274697-3393-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <590c1f1c-2da1-583a-d055-83c15969cf80@linuxfoundation.org>
References: <590c1f1c-2da1-583a-d055-83c15969cf80@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since commit 43209ea2d17a ("zram: remove max_comp_streams internals"), zram
has switched to per-cpu streams. Even kernel still keep this interface for
some reasons, but writing to max_comp_stream doesn't take any effect. So
skip it on newer kernel ie 4.7.

The code that comparing kernel version is from xfstests testsuite ext4/053.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tools/testing/selftests/zram/zram_lib.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/zram/zram_lib.sh b/tools/testing/selftests/zram/zram_lib.sh
index 6f872f266fd1..f47fc0f27e99 100755
--- a/tools/testing/selftests/zram/zram_lib.sh
+++ b/tools/testing/selftests/zram/zram_lib.sh
@@ -11,6 +11,9 @@ dev_mounted=-1
 
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
+kernel_version=`uname -r | cut -d'.' -f1,2`
+kernel_major=${kernel_version%.*}
+kernel_minor=${kernel_version#*.}
 
 trap INT
 
@@ -25,6 +28,20 @@ check_prereqs()
 	fi
 }
 
+kernel_gte()
+{
+	major=${1%.*}
+	minor=${1#*.}
+
+	if [ $kernel_major -gt $major ]; then
+		return 0
+	elif [[ $kernel_major -eq $major && $kernel_minor -ge $minor ]]; then
+		return 0
+	fi
+
+	return 1
+}
+
 zram_cleanup()
 {
 	echo "zram cleanup"
@@ -86,6 +103,13 @@ zram_max_streams()
 {
 	echo "set max_comp_streams to zram device(s)"
 
+	kernel_gte 4.7
+	if [ $? -eq 0 ]; then
+		echo "The device attribute max_comp_streams was"\
+		               "deprecated in 4.7"
+		return 0
+	fi
+
 	local i=0
 	for max_s in $zram_max_streams; do
 		local sys_path="/sys/block/zram${i}/max_comp_streams"
-- 
2.23.0

