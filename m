Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425A75B3EF1
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 20:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiIISkT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 14:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiIISkR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 14:40:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ED57FE6A;
        Fri,  9 Sep 2022 11:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662748816; x=1694284816;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RuWWql8NdeIBQV13hvoz6HJI9WRtLwnwR+Z0ibAu/b8=;
  b=Rj9GcD+2NmBWKH2Q/5WL/VId1A1ZFXiRYiyPlfl6IlkDGLW8qgqUZyq4
   3XOJtijUnwJAyqHYXc11RHB139q/fOQg0fot3WYTsZ8CLWTlO7mdIk2np
   7hcIb3PGN5RCpGLtQr5l/XDVHTO6h7oDpMBxuDxezxfOcifWoRm+JSqIF
   CIt8I/ssKcG8W7lpM4OIEc7ikycea+izE3qK9UjZQjc72fxVmgVajEztM
   HIlhl8RYADthF4SqQhWleDT1Qb5z2NTfZ8GfLV6guublUFUyqx66B2yLL
   8keluoahlcC4gP6aw0drC1acHhISYqfNZnZwOpstMuB3/3ZDBHezJoRl/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298347056"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="298347056"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 11:40:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="592707394"
Received: from hmadupal-mobl1.amr.corp.intel.com (HELO [10.251.6.204]) ([10.251.6.204])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 11:40:14 -0700
Message-ID: <379acbc9-dd7d-f52b-b4d5-da5dac065891@linux.intel.com>
Date:   Fri, 9 Sep 2022 11:40:14 -0700
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
 <23a76ce3-d568-3c73-eecc-fa499aeecfcd@linux.intel.com>
 <CAAq0SUk9_DS4T5_uAg+3re7=wrGXMkiXgw_oPsWfrmgY79P=2g@mail.gmail.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAAq0SUk9_DS4T5_uAg+3re7=wrGXMkiXgw_oPsWfrmgY79P=2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/9/22 6:36 AM, Wander Lairson Costa wrote:
> On Thu, Sep 8, 2022 at 8:45 PM Sathyanarayanan Kuppuswamy
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>>
>>
>> On 9/8/22 7:16 AM, Wander Lairson Costa wrote:
>>>> +#ifdef DEBUG
>>>> +static void print_array_hex(const char *title, const char *prefix_str,
>>>> +            const void *buf, int len)
>>>> +{
>>>> +    const __u8 *ptr = buf;
>>>> +    int i, rowsize = HEX_DUMP_SIZE;
>>>> +
>>>> +    if (!len || !buf)
>>>> +            return;
>>>> +
>>>> +    printf("\t\t%s", title);
>>>> +
>>>> +    for (i = 0; i < len; i++) {
>>>> +            if (!(i % rowsize))
>>>> +                    printf("\n%s%.8x:", prefix_str, i);
>>>> +            printf(" %.2x", ptr[i]);
>>>> +    }
>>>> +
>>>> +    printf("\n");
>>>> +}
>>>> +#endif
>>>> +
>>>> +TEST(verify_report)
>>>> +{
>>>> +    __u8 reportdata[TDX_REPORTDATA_LEN];
>>>> +    struct tdreport tdreport;
>>>> +    struct tdx_report_req req;
>>>> +    int devfd, i;
>>>> +
>>>> +    devfd = open(TDX_GUEST_DEVNAME, O_RDWR | O_SYNC);
>>>> +
>>>> +    ASSERT_LT(0, devfd);
>>>> +
>>>> +    /* Generate sample report data */
>>>> +    for (i = 0; i < TDX_REPORTDATA_LEN; i++)
>>>> +            reportdata[i] = i;
>>>> +
>>>> +    /* Initialize IOCTL request */
>>>> +    req.subtype     = 0;
>>>> +    req.reportdata  = (__u64)reportdata;
>>>> +    req.rpd_len     = TDX_REPORTDATA_LEN;
>>>> +    req.tdreport    = (__u64)&tdreport;
>>>> +    req.tdr_len     = sizeof(tdreport);
>>>> +
>>>> +    /* Get TDREPORT */
>>>> +    ASSERT_EQ(0, ioctl(devfd, TDX_CMD_GET_REPORT, &req));
>>>> +
>>>> +#ifdef DEBUG
>>>> +    print_array_hex("\n\t\tTDX report data\n", "",
>>>> +                    reportdata, sizeof(reportdata));
>>>> +
>>>> +    print_array_hex("\n\t\tTDX tdreport data\n", "",
>>>> +                    &tdreport, sizeof(tdreport));
>>>> +#endif
>>> You can unconditionally define print_array_hex, and
>>> use `if (DEBUG)` instead of #ifdef `DEBUG here`. The compiler
>>> will get rid of the unused code when DEBUG is not defined
>>> as expected, but you get the parser to validate it
>>> independent of the definition of DEBUG.
>>
>> Currently, DEBUG is a macro, so we cannot use if (DEBUG) directly.
>> You are suggesting to change DEBUG to a variable? Any reason to
>> make this change? I think both changes are functionally similar.
>> So I am wondering why to make this change?
>>
> 
> My thought is always to define DEBUG. If in debug mode it is defined
> to 1; otherwise to 0.
> Then, you can use `if (DEBUG)` instead of `#ifdef DEBUG`. But the
> former will always check the syntax of the debug code,
> independent of the value of DEBUG, and the compiler will generate the
> same code. The GNU coding standard [1] explains that
> better than I do.
> 
> [1] https://www.gnu.org/prep/standards/standards.html#Conditional-Compilation

Got it. I will use if (DEBUG).

> 
>>>
>>
>> --
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer
>>
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
