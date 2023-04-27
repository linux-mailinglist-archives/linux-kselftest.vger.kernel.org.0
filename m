Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6266F0C61
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Apr 2023 21:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244405AbjD0TKk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Apr 2023 15:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244317AbjD0TKj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Apr 2023 15:10:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99C383;
        Thu, 27 Apr 2023 12:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682622637; x=1714158637;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U11SN9mWGEQdDYTAKbNstXN/CypdmKjslQJG22dkEC0=;
  b=jDeMgHZ8jQTocEZuxrK2oWcHtwv5JVF2dSYEXmx6oztDNvcJF6ygwtdz
   8aBkmN670dBI0EnhyXCJ9/iRc0PoKL1rqz0Zw9fEbsTMmqzrGafRVMFuk
   FG55uTCor49QX9e6nipQqvgFbPO4fRLD36M2GsACLMKs58XuGdaGWatz7
   VTImOJe95DKQ4OAx4iGgU08h45YFVecF3H3jgcB9+MPMEZdxgebfHD8pj
   c1og/NDktQCR9lzIEBBB/kE3Zx97U+Pw4Y7GEToM54mCRqR4ji2wxVwii
   3iyBHzh26sy55jlH3XZQDRJMygXsrdjzMOr8NIX6CzcsjZWtL9qp2l77q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="331831569"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="331831569"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:10:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="727242040"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="727242040"
Received: from mhammon-mobl.amr.corp.intel.com (HELO [10.212.181.179]) ([10.212.181.179])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:10:36 -0700
Message-ID: <a418c2d3-e333-fe3d-63a5-c6e555f81fc7@linux.intel.com>
Date:   Thu, 27 Apr 2023 12:10:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Content-Language: en-US
To:     Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Chong Cai <chongc@google.com>, Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
References: <20230413034108.1902712-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20230413034108.1902712-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAAH4kHb_PAhR5jLFi2KsGku9ALNtjtxb-JO-k1ULK-Mj5mi=pw@mail.gmail.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAAH4kHb_PAhR5jLFi2KsGku9ALNtjtxb-JO-k1ULK-Mj5mi=pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 4/26/23 8:47 AM, Dionna Amalie Glaze wrote:
> On Wed, Apr 12, 2023 at 8:42 PM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>> In TDX guest, the second stage of the attestation process is Quote
>> generation. This process is required to convert the locally generated
>> TDREPORT into a remotely verifiable Quote. It involves sending the
>> TDREPORT data to a Quoting Enclave (QE) which will verify the
>> integerity of the TDREPORT and sign it with an attestation key.
> 
> nit: integrity
> 
>>
>> Intel's TDX attestation driver exposes TDX_CMD_GET_QUOTE IOCTL to
>> allow user agent get the TD Quote.
> 
> nit: to get
>>
>> Add a kernel selftest module to verify the Quote generation feature.
>>
>> TD Quote generation involves following steps:
>>
>> * Get the TDREPORT data using TDX_CMD_GET_REPORT IOCTL.
>> * Embed the TDREPORT data in quote buffer and request for quote
>>   generation via TDX_CMD_GET_QUOTE IOCTL request.
>> * Upon completion of the GetQuote request, check for non zero value
>>   in the status field of Quote header to make sure the generated
>>   quote is valid.
>>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>  tools/testing/selftests/tdx/tdx_guest_test.c | 68 ++++++++++++++++++--
>>  1 file changed, 62 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/testing/selftests/tdx/tdx_guest_test.c b/tools/testing/selftests/tdx/tdx_guest_test.c
>> index 81d8cb88ea1a..2eccde54185b 100644
>> --- a/tools/testing/selftests/tdx/tdx_guest_test.c
>> +++ b/tools/testing/selftests/tdx/tdx_guest_test.c
>> @@ -18,6 +18,7 @@
>>  #define TDX_GUEST_DEVNAME "/dev/tdx_guest"
>>  #define HEX_DUMP_SIZE 8
>>  #define DEBUG 0
>> +#define QUOTE_SIZE 8192
>>
>>  /**
>>   * struct tdreport_type - Type header of TDREPORT_STRUCT.
>> @@ -128,21 +129,29 @@ static void print_array_hex(const char *title, const char *prefix_str,
>>         printf("\n");
>>  }
>>
>> +/* Helper function to get TDREPORT */
>> +long get_tdreport0(int devfd, struct tdx_report_req *req)
>> +{
>> +       int i;
>> +
>> +       /* Generate sample report data */
>> +       for (i = 0; i < TDX_REPORTDATA_LEN; i++)
>> +               req->reportdata[i] = i;
>> +
> 
> Shouldn't req be zeroed before populating reportdata? We wouldn't want
> uninitialized memory to leave the guest. I know this is just a test,

There are only two members in struct tdx_report_req (reportdata and tdreport).
The reportdata has already been updated here, and the tdreport will be updated
by the kernel on output. Since TDX_CMD_GET_REPORT0 IOCTL handler uses an
intermediate kernel buffer to the TDREPORT and copies the generated report back
to this user buffer, this uninitialized tdreport data never leaves the guest.

IMO, we don't need to zero it. However, because it is harmless, I am fine with
including it.

> but it's best to model good practices for anyone that might
> copy/paste.


> 
>> +       return ioctl(devfd, TDX_CMD_GET_REPORT0, req);
>> +}
>> +
>>  TEST(verify_report)
>>  {
>>         struct tdx_report_req req;
>>         struct tdreport *tdreport;
>> -       int devfd, i;
>> +       int devfd;
>>
>>         devfd = open(TDX_GUEST_DEVNAME, O_RDWR | O_SYNC);
>>         ASSERT_LT(0, devfd);
>>
>> -       /* Generate sample report data */
>> -       for (i = 0; i < TDX_REPORTDATA_LEN; i++)
>> -               req.reportdata[i] = i;
>> -
>>         /* Get TDREPORT */
>> -       ASSERT_EQ(0, ioctl(devfd, TDX_CMD_GET_REPORT0, &req));
>> +       ASSERT_EQ(0, get_tdreport0(devfd, &req));
>>
>>         if (DEBUG) {
>>                 print_array_hex("\n\t\tTDX report data\n", "",
>> @@ -160,4 +169,51 @@ TEST(verify_report)
>>         ASSERT_EQ(0, close(devfd));
>>  }
>>
>> +TEST(verify_quote)
>> +{
>> +       struct tdx_quote_hdr *quote_hdr;
>> +       struct tdx_report_req rep_req;
>> +       struct tdx_quote_req req;
>> +       __u64 quote_buf_size;
>> +       __u8 *quote_buf;
>> +       int devfd;
>> +
>> +       /* Open attestation device */
>> +       devfd = open(TDX_GUEST_DEVNAME, O_RDWR | O_SYNC);
>> +
>> +       ASSERT_LT(0, devfd);
>> +
>> +       /* Add size for quote header */
>> +       quote_buf_size = sizeof(*quote_hdr) + QUOTE_SIZE;
>> +
>> +       /* Allocate quote buffer */
>> +       quote_buf = malloc(quote_buf_size);
>> +       ASSERT_NE(NULL, quote_buf);
>> +
>> +       quote_hdr = (struct tdx_quote_hdr *)quote_buf;
>> +
>> +       /* Initialize GetQuote header */
>> +       quote_hdr->version = 1;
>> +       quote_hdr->status  = GET_QUOTE_SUCCESS;
>> +       quote_hdr->in_len  = TDX_REPORT_LEN;
>> +       quote_hdr->out_len = 0;
>> +
>> +       /* Get TDREPORT data */
>> +       ASSERT_EQ(0, get_tdreport0(devfd, &rep_req));
>> +
>> +       /* Fill GetQuote request */
>> +       memcpy(quote_hdr->data, rep_req.tdreport, TDX_REPORT_LEN);
>> +       req.buf   = (__u64)quote_buf;
>> +       req.len   = quote_buf_size;
>> +
>> +       ASSERT_EQ(0, ioctl(devfd, TDX_CMD_GET_QUOTE, &req));
>> +
>> +       /* Check whether GetQuote request is successful */
>> +       EXPECT_EQ(0, quote_hdr->status);
>> +
>> +       free(quote_buf);
>> +
>> +       ASSERT_EQ(0, close(devfd));
>> +}
>> +
>>  TEST_HARNESS_MAIN
>> --
>> 2.34.1
>>
> 
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
