Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0324D6E0560
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 05:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjDMDmG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 23:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjDMDmD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 23:42:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD8B26B3;
        Wed, 12 Apr 2023 20:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681357322; x=1712893322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JX88hhsS2KW2V7rBG3yf8RrisVNrFnqE6hp/x0xTETo=;
  b=M9wc3r5/ctgNYiPMRERTBSyI84kXSHOXoXDuH28tygnVz3SLy127jdR0
   YKTrO9I2Dei1kPBTPb64zhjQUVE0LVqV2e/hq3CNSG//0jhKzEn6Ks9gP
   zYDK02KT9LrwP39x1I5G07Gz1xWcyPyXyr3YSVY3cLrVgwsGArk+XypbN
   Mc5FQOlK6MMfcLqwLYruqGxorIiOGUIo9Vcij7n/UdTqS/nkydE2Eb19O
   rwAWj/b0gbzrS/RpIqedyno9BT8Sc6OaaJP0R2KdCL+cDAMdCbHmCaAz/
   V/3Lsw37rvGwzOThdLytpd3gktpUfa+yQoPMIBjZ8cKM8oa/AI2lYqLkn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323699380"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="323699380"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 20:42:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="813222568"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="813222568"
Received: from dayerton-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.52.214])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 20:42:00 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Chong Cai <chongc@google.com>, Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v2 3/3] selftests/tdx: Test GetQuote TDX attestation feature
Date:   Wed, 12 Apr 2023 20:41:08 -0700
Message-Id: <20230413034108.1902712-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413034108.1902712-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20230413034108.1902712-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In TDX guest, the second stage of the attestation process is Quote
generation. This process is required to convert the locally generated
TDREPORT into a remotely verifiable Quote. It involves sending the
TDREPORT data to a Quoting Enclave (QE) which will verify the
integerity of the TDREPORT and sign it with an attestation key.

Intel's TDX attestation driver exposes TDX_CMD_GET_QUOTE IOCTL to
allow user agent get the TD Quote.

Add a kernel selftest module to verify the Quote generation feature.

TD Quote generation involves following steps:

* Get the TDREPORT data using TDX_CMD_GET_REPORT IOCTL.
* Embed the TDREPORT data in quote buffer and request for quote
  generation via TDX_CMD_GET_QUOTE IOCTL request.
* Upon completion of the GetQuote request, check for non zero value
  in the status field of Quote header to make sure the generated
  quote is valid.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 tools/testing/selftests/tdx/tdx_guest_test.c | 68 ++++++++++++++++++--
 1 file changed, 62 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/tdx/tdx_guest_test.c b/tools/testing/selftests/tdx/tdx_guest_test.c
index 81d8cb88ea1a..2eccde54185b 100644
--- a/tools/testing/selftests/tdx/tdx_guest_test.c
+++ b/tools/testing/selftests/tdx/tdx_guest_test.c
@@ -18,6 +18,7 @@
 #define TDX_GUEST_DEVNAME "/dev/tdx_guest"
 #define HEX_DUMP_SIZE 8
 #define DEBUG 0
+#define QUOTE_SIZE 8192
 
 /**
  * struct tdreport_type - Type header of TDREPORT_STRUCT.
@@ -128,21 +129,29 @@ static void print_array_hex(const char *title, const char *prefix_str,
 	printf("\n");
 }
 
+/* Helper function to get TDREPORT */
+long get_tdreport0(int devfd, struct tdx_report_req *req)
+{
+	int i;
+
+	/* Generate sample report data */
+	for (i = 0; i < TDX_REPORTDATA_LEN; i++)
+		req->reportdata[i] = i;
+
+	return ioctl(devfd, TDX_CMD_GET_REPORT0, req);
+}
+
 TEST(verify_report)
 {
 	struct tdx_report_req req;
 	struct tdreport *tdreport;
-	int devfd, i;
+	int devfd;
 
 	devfd = open(TDX_GUEST_DEVNAME, O_RDWR | O_SYNC);
 	ASSERT_LT(0, devfd);
 
-	/* Generate sample report data */
-	for (i = 0; i < TDX_REPORTDATA_LEN; i++)
-		req.reportdata[i] = i;
-
 	/* Get TDREPORT */
-	ASSERT_EQ(0, ioctl(devfd, TDX_CMD_GET_REPORT0, &req));
+	ASSERT_EQ(0, get_tdreport0(devfd, &req));
 
 	if (DEBUG) {
 		print_array_hex("\n\t\tTDX report data\n", "",
@@ -160,4 +169,51 @@ TEST(verify_report)
 	ASSERT_EQ(0, close(devfd));
 }
 
+TEST(verify_quote)
+{
+	struct tdx_quote_hdr *quote_hdr;
+	struct tdx_report_req rep_req;
+	struct tdx_quote_req req;
+	__u64 quote_buf_size;
+	__u8 *quote_buf;
+	int devfd;
+
+	/* Open attestation device */
+	devfd = open(TDX_GUEST_DEVNAME, O_RDWR | O_SYNC);
+
+	ASSERT_LT(0, devfd);
+
+	/* Add size for quote header */
+	quote_buf_size = sizeof(*quote_hdr) + QUOTE_SIZE;
+
+	/* Allocate quote buffer */
+	quote_buf = malloc(quote_buf_size);
+	ASSERT_NE(NULL, quote_buf);
+
+	quote_hdr = (struct tdx_quote_hdr *)quote_buf;
+
+	/* Initialize GetQuote header */
+	quote_hdr->version = 1;
+	quote_hdr->status  = GET_QUOTE_SUCCESS;
+	quote_hdr->in_len  = TDX_REPORT_LEN;
+	quote_hdr->out_len = 0;
+
+	/* Get TDREPORT data */
+	ASSERT_EQ(0, get_tdreport0(devfd, &rep_req));
+
+	/* Fill GetQuote request */
+	memcpy(quote_hdr->data, rep_req.tdreport, TDX_REPORT_LEN);
+	req.buf	  = (__u64)quote_buf;
+	req.len	  = quote_buf_size;
+
+	ASSERT_EQ(0, ioctl(devfd, TDX_CMD_GET_QUOTE, &req));
+
+	/* Check whether GetQuote request is successful */
+	EXPECT_EQ(0, quote_hdr->status);
+
+	free(quote_buf);
+
+	ASSERT_EQ(0, close(devfd));
+}
+
 TEST_HARNESS_MAIN
-- 
2.34.1

