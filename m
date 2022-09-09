Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009DA5B4016
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 21:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiIITqW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 15:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiIITps (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 15:45:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB4910FC7;
        Fri,  9 Sep 2022 12:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662752556; x=1694288556;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+/1qN74VTzXrOaU2w2PUWN7E8sji2DXVrWuidjxRfvQ=;
  b=DW8MG5l130abbkagfcYolgjzpBKYvVe/YJ77X1l9Ul/P9jJI1VR+rMfO
   NLj/GipBqShA49sUL8YhrargDgmKKey4O77SH2W49bQK433qwvZBal1Us
   McDetZp0Toxq+FSeLnO3LmYg9kHc/AD/PgFs86Hgml1siPUKbE6hsh64V
   j04xb5GAcXyhauG/GKjbvQ2o0u/Pm+3UX4EY6jgNma6nL7hxDV+p7dKsF
   gD0DkzQk5KSs873wCJpA1Bu5gFxjb/i6sGA6ONk62NSXqrfn9ckm+aKME
   e5B+XJXS0n4/4cAuQbrGWPqMnUFIOu5Bu682u2mAdiC7iOU7LWaWRNNXn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298357746"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="298357746"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 12:41:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="566476659"
Received: from omeier-mobl1.ger.corp.intel.com (HELO [10.209.54.138]) ([10.209.54.138])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 12:41:04 -0700
Message-ID: <1942be91-ec18-5fb3-9fcd-6ffcfaf9f36c@intel.com>
Date:   Fri, 9 Sep 2022 12:41:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v13 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
References: <20220909192708.1113126-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220909192708.1113126-2-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220909192708.1113126-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/9/22 12:27, Kuppuswamy Sathyanarayanan wrote:
> +	u8 reserved[7] = {0};
...
> +	if (!req.reportdata || !req.tdreport || req.subtype ||
> +		req.rpd_len != TDX_REPORTDATA_LEN ||
> +		req.tdr_len != TDX_REPORT_LEN ||
> +		memcmp(req.reserved, reserved, 7))
> +		return -EINVAL;

Huh, so to look for 0's, you:

1. Declare an on-stack structure with a hard coded, magic numbered field
   that has to be zeroed.
2. memcmp() that structure
3. Feed memcmp() with another hard coded magic number

I've gotta ask: did you have any reservations writing this code?  Were
there any alarm bells going off saying that something might be wrong?

Using memcmp() itself is probably forgivable.  But, the two magic
numbers are pretty mortal sins in my book.  What's going to happen the
first moment someone wants to repurpose a reserved byte?  They're going
to do:

-	__u8 reserved[7];
+	__u8 my_new_byte;
+	__u8 reserved[6];

What's going to happen to the code you wrote?  Will it continue to work?
 Or will the memcmp() silently start doing crazy stuff as it overruns
the structure into garbage land?

What's wrong with:

	memchr_inv(&req.reserved, sizeof(req.reserved), 0)
