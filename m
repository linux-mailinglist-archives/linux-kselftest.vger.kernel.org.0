Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40895B2BE3
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 03:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiIIBzz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 21:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiIIBzy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 21:55:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F474F18D;
        Thu,  8 Sep 2022 18:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662688554; x=1694224554;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8ihrEr+mNY0MgHnxmzKiyanf1ZC65fntYv6pqfRRa5o=;
  b=OzbGzywVhIX8p4ZFh+6WPn/YJ+VTvdiPWHCJgR/NDnxP+nbmZnHgKbua
   dCYGuRuXJtNhtEOKyIXaR+PHYRTumyOtWqKcXVE1qyFPcYEAqVqblyND7
   ntgGvUx/sBdflnL5iMAhk1KQ8e241p/cFG7PiqHW6RubAGasnyEaGSlbB
   olFxkZ3dxghlAUjYeuQYDcT4DionREEqb7wmuSQAE1ew07CsYlVgBqwGs
   bqDUOpTWZuvrQsJORJumiGnNEeRSgGYrve5F6sqApMEWqhZsmIyj8axpv
   38hJontYOY0rfkjyfq8/Q5a8sGl4YJD/sIOKZEPfabrb82DQLUm2zePa0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="298710931"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="298710931"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 18:55:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="740892245"
Received: from duttamou-mobl1.amr.corp.intel.com (HELO [10.209.109.184]) ([10.209.109.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 18:55:53 -0700
Message-ID: <e4b6f718-d671-72b3-4c4d-4338feba80a1@linux.intel.com>
Date:   Thu, 8 Sep 2022 18:55:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v12 2/3] selftests: tdx: Test TDX attestation GetReport
 support
Content-Language: en-US
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220908002723.923241-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220908002723.923241-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Yxn5VDzJMUxSKz0Z@fedora>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Yxn5VDzJMUxSKz0Z@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/8/22 7:16 AM, Wander Lairson Costa wrote:
> You can unconditionally define print_array_hex, and
> use `if (DEBUG)` instead of #ifdef `DEBUG here`. The compiler
> will get rid of the unused code when DEBUG is not defined
> as expected, but you get the parser to validate it
> independent of the definition of DEBUG.

To avoid #ifdef DEBUG in multiple places, we can try following
change. Let me know your comments.

--- a/tools/testing/selftests/tdx/tdx_attest_test.c

+++ b/tools/testing/selftests/tdx/tdx_attest_test.c

@@ -21,6 +21,14 @@

 #define HEX_DUMP_SIZE  8

 #define __packed       __attribute__((packed))

 

+static inline int _no_printf(const char *format, ...) { return 0; }

+

+#ifdef DEBUG

+#define pr_debug(...) printf(__VA_ARGS__)

+#else

+#define pr_debug(...) _no_printf(__VA_ARGS__)

+#endif

+

 /*

  * Trusted Execution Environment (TEE) report (TDREPORT_STRUCT) type,

  * sub type and version. More details can be found in TDX v1.0 Module

@@ -90,7 +98,6 @@ struct tdreport {

        struct td_info tdinfo;

 }  __packed;

 

-#ifdef DEBUG

 static void print_array_hex(const char *title, const char *prefix_str,

                const void *buf, int len)

 {

@@ -100,17 +107,16 @@ static void print_array_hex(const char *title, const char *prefix_str,

        if (!len || !buf)

                return;

 

-       printf("\t\t%s", title);

+       pr_debug("\t\t%s", title);

 

        for (i = 0; i < len; i++) {

                if (!(i % rowsize))

-                       printf("\n%s%.8x:", prefix_str, i);

-               printf(" %.2x", ptr[i]);

+                       pr_debug("\n%s%.8x:", prefix_str, i);

+               pr_debug(" %.2x", ptr[i]);

        }

 

-       printf("\n");

+       pr_debug("\n");

 }

-#endif

 

 TEST(verify_report)

 {

@@ -139,13 +145,11 @@ TEST(verify_report)

        /* Get TDREPORT */

        ASSERT_EQ(0, ioctl(devfd, TDX_CMD_GET_REPORT, &req));

 

-#ifdef DEBUG

        print_array_hex("\n\t\tTDX report data\n", "",

                        reportdata, sizeof(reportdata));

 

        print_array_hex("\n\t\tTDX tdreport data\n", "",

                        &tdreport, sizeof(tdreport));

-#endif

 

        /* Make sure TDREPORT data includes the REPORTDATA passed */

        ASSERT_EQ(0, memcmp(&tdreport.reportmac.reportdata[0],



-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
