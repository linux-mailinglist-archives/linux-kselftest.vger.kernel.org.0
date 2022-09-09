Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003295B4116
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 22:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiIIUyc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 16:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiIIUyb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 16:54:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB05BF4;
        Fri,  9 Sep 2022 13:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662756869; x=1694292869;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ROjuV4CqzT86ZTJF04fmVbf2WhqVLX3ZkCVgsyHl1rY=;
  b=Virz7ZNEpOYCIACYzqTAHLLhprV9jAwEsvb7WaDVLbNsOs4XrlEU95OM
   es4oe4/QasOFxoe1QgD/IF22dknmmx/mQ8B5cmRJ7QUg4wVMjcXgnZa/f
   O9CNa+T696Wja91vIMAYkZ0HwTKkXGg9arWOc4MUjyqyPqyqb2zE154N/
   l3KfanOs1LUbxyAO6Du696b8U1u64MVujV8teE6ABbvu8uQgjHKsWuY84
   s8BHPrKs60J1KE/Lz6XA+cf3OjrqXJpxXgpRhaHRBF2sOaWm3O8cTA7Ch
   jIihw2fXtQKysG8oR9CXxNFii+L9WCEwI0wDDQ05PqB44l/YXcJKUYJt/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="295150924"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="295150924"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 13:54:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="566494911"
Received: from omeier-mobl1.ger.corp.intel.com (HELO [10.209.54.138]) ([10.209.54.138])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 13:54:27 -0700
Message-ID: <bc3b0fbc-3b5d-7dec-609b-37bc7a643d83@intel.com>
Date:   Fri, 9 Sep 2022 13:54:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v13 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
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
 <1942be91-ec18-5fb3-9fcd-6ffcfaf9f36c@intel.com>
 <c289f18c-1276-eaa8-739e-4fb530eace91@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <c289f18c-1276-eaa8-739e-4fb530eace91@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/9/22 13:07, Sathyanarayanan Kuppuswamy wrote:
>> What's wrong with:
>>
>> 	memchr_inv(&req.reserved, sizeof(req.reserved), 0)
> I did not consider the hard coding issue. It is a mistake. Your suggestion
> looks better. I will use it.

BTW...  Please look at how memchr_inv() gets used in the kernel.  Don't
copy my nonsense too exactly.
