Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940735B2A86
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 01:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiIHXpM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 19:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiIHXpF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 19:45:05 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF4E5C979;
        Thu,  8 Sep 2022 16:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662680704; x=1694216704;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uiG/vE4cpWuT3MewnkVW7e+A3u9o70Dk3fzCkQBC5F4=;
  b=Jcj4LIDjgDUbrK9Td7ZB5Z2btcuThIFthrMAEXz9FevMleqgKfKRAYms
   zTkKbPKHHHdIr4yrfp1PJ3s0zgwz1+RBkqcVUv3uEsoGaJSGt2gMcn4ws
   U9Cs7d7X9JMyu6fWpV7CNq3U/hsIFS6J3ApJbvm2lGVT9BFkBvjgJ09ON
   Q+MLjCGQgss5luuszTBlGsUI7ab9PnlZX1T9HBuQc7GbGeS/A/kX3qcAP
   85fICgRSXrab9E44Z7cyGqJ5Idw35IupwmOzjPWRE5Jm/GNQbAW1ne6bn
   6oHbDLF4k0mNAVHMM3y3l40maGi9wNOxjVJ5wVv3+baydPb6gGEIOQkbg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="323552699"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="323552699"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 16:45:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="740861110"
Received: from duttamou-mobl1.amr.corp.intel.com (HELO [10.209.109.184]) ([10.209.109.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 16:45:02 -0700
Message-ID: <23a76ce3-d568-3c73-eecc-fa499aeecfcd@linux.intel.com>
Date:   Thu, 8 Sep 2022 16:45:02 -0700
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
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/8/22 7:16 AM, Wander Lairson Costa wrote:
>> +#ifdef DEBUG
>> +static void print_array_hex(const char *title, const char *prefix_str,
>> +		const void *buf, int len)
>> +{
>> +	const __u8 *ptr = buf;
>> +	int i, rowsize = HEX_DUMP_SIZE;
>> +
>> +	if (!len || !buf)
>> +		return;
>> +
>> +	printf("\t\t%s", title);
>> +
>> +	for (i = 0; i < len; i++) {
>> +		if (!(i % rowsize))
>> +			printf("\n%s%.8x:", prefix_str, i);
>> +		printf(" %.2x", ptr[i]);
>> +	}
>> +
>> +	printf("\n");
>> +}
>> +#endif
>> +
>> +TEST(verify_report)
>> +{
>> +	__u8 reportdata[TDX_REPORTDATA_LEN];
>> +	struct tdreport tdreport;
>> +	struct tdx_report_req req;
>> +	int devfd, i;
>> +
>> +	devfd = open(TDX_GUEST_DEVNAME, O_RDWR | O_SYNC);
>> +
>> +	ASSERT_LT(0, devfd);
>> +
>> +	/* Generate sample report data */
>> +	for (i = 0; i < TDX_REPORTDATA_LEN; i++)
>> +		reportdata[i] = i;
>> +
>> +	/* Initialize IOCTL request */
>> +	req.subtype     = 0;
>> +	req.reportdata  = (__u64)reportdata;
>> +	req.rpd_len     = TDX_REPORTDATA_LEN;
>> +	req.tdreport    = (__u64)&tdreport;
>> +	req.tdr_len     = sizeof(tdreport);
>> +
>> +	/* Get TDREPORT */
>> +	ASSERT_EQ(0, ioctl(devfd, TDX_CMD_GET_REPORT, &req));
>> +
>> +#ifdef DEBUG
>> +	print_array_hex("\n\t\tTDX report data\n", "",
>> +			reportdata, sizeof(reportdata));
>> +
>> +	print_array_hex("\n\t\tTDX tdreport data\n", "",
>> +			&tdreport, sizeof(tdreport));
>> +#endif
> You can unconditionally define print_array_hex, and
> use `if (DEBUG)` instead of #ifdef `DEBUG here`. The compiler
> will get rid of the unused code when DEBUG is not defined
> as expected, but you get the parser to validate it
> independent of the definition of DEBUG.

Currently, DEBUG is a macro, so we cannot use if (DEBUG) directly.
You are suggesting to change DEBUG to a variable? Any reason to
make this change? I think both changes are functionally similar.
So I am wondering why to make this change?

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
