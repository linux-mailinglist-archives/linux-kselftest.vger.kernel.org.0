Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E0B5B2DF2
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 07:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiIIFIj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 01:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiIIFIi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 01:08:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE5512518F;
        Thu,  8 Sep 2022 22:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662700116; x=1694236116;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3Z5IUwtXOaJd3WLXidp69Z38tSz9CI8nL8eloIE3i/A=;
  b=JGJK+l6RsdTYKsNm+36UgMhwc2tAljYRIddNyHJNJ8olfDGN7dXd6l9C
   nnh0ymdOF9Y437nfbh5jzm27R2/MROp9a9e3IKmdZheduuu8HaJ2nEfu9
   z8BCfvQigt11EUmYNR/9ya5hH7q1V9tgQJij+WyxPr05wBPYi1HkQbYi8
   IPQt6LSqSZL67Tv991qwE8Pa1y1nBNgKZd/IeQdF/4EC187vh7XJU24wn
   guDvoRTw/63qgVAw0zRiE/AaZUBjEXGHCw7TFA2PIgZjSWiyjb+gYj6rV
   yiW8FeNzsiQf2/ARE9wc1pt4kdZoXsqXU1OMhhBFKazXmrqaMKINmF2c4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="277131593"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="277131593"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 22:08:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="740932401"
Received: from duttamou-mobl1.amr.corp.intel.com (HELO [10.209.109.184]) ([10.209.109.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 22:08:35 -0700
Message-ID: <68cbcde7-7ae5-32ba-05c2-7ffec11be385@linux.intel.com>
Date:   Thu, 8 Sep 2022 22:08:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v12 2/3] selftests: tdx: Test TDX attestation GetReport
 support
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "khalid.elmously@canonical.com" <khalid.elmously@canonical.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Cox, Philip" <philip.cox@canonical.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20220908002723.923241-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220908002723.923241-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <449b29a40dcbafc9c0b81d19ed5c377b290b0ab5.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <449b29a40dcbafc9c0b81d19ed5c377b290b0ab5.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/8/22 8:48 PM, Huang, Kai wrote:
> On Wed, 2022-09-07 at 17:27 -0700, Kuppuswamy Sathyanarayanan wrote:
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
>> +	req.subtype     = 0;
>> +	req.reportdata  = (__u64)reportdata;
>> +	req.rpd_len     = TDX_REPORTDATA_LEN;
>> +	req.tdreport    = (__u64)&tdreport;
>> +	req.tdr_len     = sizeof(tdreport);
>> +
> 
> 'req' is a local variable, which isn't guaranteed to be zero. Looks you need to
> explicitly clear 'req' otherwise the req.reserved[7] may not be zero.

In the next version, I explicitly set it to 0. I could initialize the struct to
0. But doing it explicitly will show the expected values clearly.

memset(req.reserved, 0, sizeof(req.reserved));

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
