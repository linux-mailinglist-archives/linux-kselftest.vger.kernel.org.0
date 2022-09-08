Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BC25B27C9
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Sep 2022 22:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiIHUgF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 16:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiIHUgE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 16:36:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D41A926F;
        Thu,  8 Sep 2022 13:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662669362; x=1694205362;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m6CZNX2aXbq9rsJJYxU4jwyWhzwBiPojrlK/DZM6cxU=;
  b=jGh9LAZ1M9EtYHA1TVpZpO1MC2rUfeWSVed7spVN9MxcrzMuyrLlaKD1
   o599vt0bi/nZQX4UxQZLJkAamZQpLYLWHssNCx45dJoS0MoRr9eK4kCS9
   DME/bE6FXAoHp8cbCgC/yjbTOEjy8VLDuUMqypOu2kn5baa4temC/Hb9N
   GZhfGm5H5ezpj58G3OqNmjRf8NUm+aLiHLeckFF0EpMBnlAtWpqlZ7HHu
   QSJ4dRqdjotFmSTAkGAY1JtnCLQ7nK51+tx5DFy6jkZ6GmI8yU7yQZA8k
   S7WVQCAV2ChvlACdgA5ZYjIWS4EzMmnsDyFiHMWHT6o+Iw+upLqsw40vM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="359047820"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="359047820"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 13:36:02 -0700
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="860180227"
Received: from jkdavis-mobl.amr.corp.intel.com (HELO [10.212.157.35]) ([10.212.157.35])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 13:36:00 -0700
Message-ID: <ac10ec37-91c8-031e-b3d3-843eaf28f0ee@intel.com>
Date:   Thu, 8 Sep 2022 13:36:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v12 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
References: <20220908002723.923241-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220908002723.923241-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Yxl+PE4A+WUfQ7bl@kroah.com>
 <6cf407ed-95c7-0db4-d581-b85efad13239@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <6cf407ed-95c7-0db4-d581-b85efad13239@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/8/22 12:07, Sathyanarayanan Kuppuswamy wrote:
> On 9/7/22 10:31 PM, Greg Kroah-Hartman wrote:
>> On Wed, Sep 07, 2022 at 05:27:20PM -0700, Kuppuswamy Sathyanarayanan wrote:
>>> +	/*
>>> +	 * Per TDX Module 1.0 specification, section titled
>>> +	 * "TDG.MR.REPORT", REPORTDATA length is fixed as
>>> +	 * TDX_REPORTDATA_LEN, TDREPORT length is fixed as
>>> +	 * TDX_REPORT_LEN, and TDREPORT subtype is fixed as
>>> +	 * 0. Also check for valid user pointers.
>>> +	 */
>>> +	if (!req.reportdata || !req.tdreport || req.subtype ||
>>> +		req.rpd_len != TDX_REPORTDATA_LEN ||
>>> +		req.tdr_len != TDX_REPORT_LEN)
>>> +		return -EINVAL;
>> You never verify that your reserved[7] fields are actually set to 0,
>> which means you can never use them in the future :(
> Currently, we don't use those fields in our code. Why do we have to
> make sure they are set to zero?

Yes.

> Can't we add checks when we really use them in future?

No.

This has been a hard learned lesson both by people writing software and
designing hardware interfaces: if you _let_ folks pass garbage you have
to _keep_ letting them pass garbage forever.  It becomes part of the ABI.

I'm sorry you missed the memo on this one.  But, this is one million
percent a best practice across the industry.  Please do it.
