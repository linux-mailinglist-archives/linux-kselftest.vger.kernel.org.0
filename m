Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141365A554F
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 22:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiH2UJj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 16:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiH2UJi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 16:09:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E399915D6;
        Mon, 29 Aug 2022 13:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661803777; x=1693339777;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4fOyKN+oJCqnDjdQygiqlfxvFPX6MNaZinYDHZZyt+0=;
  b=mJbM17t2NX+x+LVkjGzP6xcsqnXk7vvPDy1GWwheAPVZSHktP5iL2o4g
   PKOAA9e1noF94eGw0Ku9McBbexhXM0WW7iWKK8DsAjJ1QdHf3c7KR8L+D
   pDq4kZQezba8tb1731E0z1PlrpZ+LJg7dK4tj2JVHTM2rhxnf6aZIuezR
   JPZtFhG/QwuMzEyks3EvnAGbMxoxRojISRzF/7ryCQtCx5TAhPeYWK9Dy
   oXgWX6kALl5fiK5QgCB9i+aAc6R/cYY2ajvu0wBy858xdNvLnnIvGRlPr
   nLjBhgpmhKuLUDbKZ3ps3BcMptCctgEQtypN+R23lhMAPu431lYAX2ixU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="294992934"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="294992934"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 13:09:37 -0700
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="679753559"
Received: from sbhansal-mobl1.amr.corp.intel.com (HELO [10.251.30.71]) ([10.251.30.71])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 13:09:36 -0700
Message-ID: <73b375c3-97a7-5f25-5abf-48d9ec6be2db@linux.intel.com>
Date:   Mon, 29 Aug 2022 13:09:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v11 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220826150638.2397576-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <dcf53e6b-d60f-5d6b-029a-38df68d66302@intel.com>
 <c6ccbcac-c5b1-f460-01e2-e1b6684b6e65@linux.intel.com>
 <YwxO2L/MtCw/OHGB@kroah.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <YwxO2L/MtCw/OHGB@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 8/28/22 10:30 PM, Greg Kroah-Hartman wrote:
>> struct tdx_report_req {
>>         __u64 reportdata;;
>>         __u64 tdreport;
>>         __u32 rpd_len
>>         __u32 tdr_len;
>>         __u8 subtype;
>> };
> That's better, but again, please use pahole.

Following are the pahole dump of both formats.

With previous format, compiler adds 11 bytes in holes and 4 bytes of
padding.

Total size of struct is 40 bytes.

struct tdx_report_req {
	__u8                       subtype;              /*     0     1 */

	/* XXX 7 bytes hole, try to pack */

	__u64                      reportdata;           /*     8     8 */
	__u32                      rpd_len;              /*    16     4 */

	/* XXX 4 bytes hole, try to pack */

	__u64                      tdreport;             /*    24     8 */
	__u32                      tdr_len;              /*    32     4 */

	/* size: 40, cachelines: 1, members: 5 */
	/* sum members: 25, holes: 2, sum holes: 11 */
	/* padding: 4 */
	/* last cacheline: 40 bytes */
};

With the changed format, we avoided the holes, but it still adds 7 bytes of padding.

Total size of struct is 32 bytes.

struct tdx_report_req {
	__u64                      reportdata;           /*     0     8 */
	__u64                      tdreport;             /*     8     8 */
	__u32                      rpd_len;              /*    16     4 */
	__u32                      tdr_len;              /*    20     4 */
	__u8                       subtype;              /*    24     1 */

	/* size: 32, cachelines: 1, members: 5 */
	/* padding: 7 */
	/* last cacheline: 32 bytes */
};



-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
