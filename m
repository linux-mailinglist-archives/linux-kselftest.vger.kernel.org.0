Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BF75A3AD1
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Aug 2022 03:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiH1BwH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Aug 2022 21:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiH1BwG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Aug 2022 21:52:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8902F33A28;
        Sat, 27 Aug 2022 18:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661651525; x=1693187525;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ne3nEz71NKc6j+jY6Tq2S4t2Ce1gq8lxkVFxivrtjQk=;
  b=hS5NJY0WCvr6L069LhZKOiEixSoeaEQCA/MQ8Z6IuKI8ylMUkZJu/BK7
   ricICevuEyenxicfZRi9dib4EY9t0y8mA2OEaVek+lnrd6ecb0RM2drd7
   0kiW1LfGMTmzqvwTKMPNM8eK08cQ3cIONx+0TNbWjZ5Zg9pDNelIL0D33
   pI68bv4ofS8U0Bl9frA/AgrYoFNWSMui7KWJ3625gqICxjm8iU6t60RTz
   OP2HCFoxcbx8GnAmHkGslaYWbo2puCDj8yiNJZctyElJNchyQACVqVL0A
   qq8WEq0FszjmerlJN1IQyMe8TCCRJcaX7U0dsS2gcjdckJ9LWnropx+t4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10452"; a="358669625"
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="358669625"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 18:52:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="671940970"
Received: from wongryan-mobl.amr.corp.intel.com (HELO [10.251.3.182]) ([10.251.3.182])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 18:52:03 -0700
Message-ID: <165d4c4b-6987-363d-aebb-a25b1db0f8c2@linux.intel.com>
Date:   Sat, 27 Aug 2022 18:52:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v11 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
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
References: <20220826150638.2397576-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <a1ec9c94-e69b-78c0-ea0f-31cceee8452a@gmail.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <a1ec9c94-e69b-78c0-ea0f-31cceee8452a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 8/27/22 12:45 AM, Bagas Sanjaya wrote:
> On what tree this patch series is based on?

It is based on v6.0-rc1.

> 
> And as this series is multi-patch, it's customary to have cover letter
> (or [PATCH 0/?]).

Although it is multi-patch, all it does is to add user interface support
to get the TDREPORT. I have split the documentation and testing parts into
separate patches. Since commit log of this patch has all the required
details about the TDREPORT support, I thought a cover letter would be
redundant.  If it is really required, I can add it from the next version.


> 
> Thanks.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
