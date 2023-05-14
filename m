Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD47D701C1B
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 May 2023 09:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjENHYH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 14 May 2023 03:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjENHYF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 14 May 2023 03:24:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A57A19A6;
        Sun, 14 May 2023 00:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684049043; x=1715585043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=It7+hrDdGgiW/UhfIn901YFgwWvU46GKYQaeQEUbiLs=;
  b=h9v+sgHChp1Bx4TwGddAecbs07iEyColAND8XBl2OB48g+hI8JMyOCLU
   yNaliiPNpJ+1OSqLqgLpVNo0SokOJ/AIeXASiLV6iSBMLlpiLoYNukYqn
   Djjmb9uKc1Y+Tcu00XHHfeEQHFYJqvc+ytV/91wO2dzLobIjsDgbJIMV5
   GQdzqey0yfGZTTUcHC8rWInDddg7QHBAc7izmedZZOxc+CMhMTcdxTLuY
   gYabF8MxiaZ1tELqH1oek5UTCFUPUG8nKapNarnKEGCVwCm5ihdFMz3T3
   NfrURUe3TGWrna5LCj2ulbs5RpVFLh3gSgwZKwO0rRS2vT9qek6zgk9I2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="354167306"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="354167306"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 00:24:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="731262953"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="731262953"
Received: from mply-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.212.130.17])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 00:24:01 -0700
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
Subject: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation feature
Date:   Sun, 14 May 2023 00:23:46 -0700
Message-Id: <972e1d5c5ec53e2757fb17a586558c5385e987dd.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In TDX guest, the second stage of the attestation process is Quote
generation. This process is required to convert the locally generated
TDREPORT into a remotely verifiable Quote. It involves sending the
TDREPORT data to a Quoting Enclave (QE) which will verify the
integrity of the TDREPORT and sign it with an attestation key.

Intel's TDX attestation driver exposes TDX_CMD_GET_QUOTE IOCTL to
allow the user agent to get the TD Quote.

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
Reviewed-by: Erdem Aktas <erdemaktas@google.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v2:
 * Adapted to struct tdx_quote_hdr -> struct tdx_quote_buf rename.

 tools/testing/selftests/tdx/tdx_guest_test.c | 65 ++++++++++++++++++--
 1 file changed, 59 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/tdx/tdx_guest_test.c b/tools/testing/selftests/tdx/tdx_guest_test.c
index 81d8cb88ea1a..0b4b4293b9cb 100644
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
@@ -160,4 +169,48 @@ TEST(verify_report)
 	ASSERT_EQ(0, close(devfd));
 }
 
+TEST(verify_quote)
+{
+	struct tdx_quote_buf *quote_buf;
+	struct tdx_report_req rep_req;
+	struct tdx_quote_req req;
+	__u64 quote_buf_size;
+	int devfd;
+
+	/* Open attestation device */
+	devfd = open(TDX_GUEST_DEVNAME, O_RDWR | O_SYNC);
+
+	ASSERT_LT(0, devfd);
+
+	/* Add size for quote header */
+	quote_buf_size = sizeof(*quote_buf) + QUOTE_SIZE;
+
+	/* Allocate quote buffer */
+	quote_buf = (struct tdx_quote_buf *)malloc(quote_buf_size);
+	ASSERT_NE(NULL, quote_buf);
+
+	/* Initialize GetQuote header */
+	quote_buf->version = 1;
+	quote_buf->status  = GET_QUOTE_SUCCESS;
+	quote_buf->in_len  = TDX_REPORT_LEN;
+	quote_buf->out_len = 0;
+
+	/* Get TDREPORT data */
+	ASSERT_EQ(0, get_tdreport0(devfd, &rep_req));
+
+	/* Fill GetQuote request */
+	memcpy(quote_buf->data, rep_req.tdreport, TDX_REPORT_LEN);
+	req.buf	  = (__u64)quote_buf;
+	req.len	  = quote_buf_size;
+
+	ASSERT_EQ(0, ioctl(devfd, TDX_CMD_GET_QUOTE, &req));
+
+	/* Check whether GetQuote request is successful */
+	EXPECT_EQ(0, quote_buf->status);
+
+	free(quote_buf);
+
+	ASSERT_EQ(0, close(devfd));
+}
+
 TEST_HARNESS_MAIN
-- 
2.34.1

