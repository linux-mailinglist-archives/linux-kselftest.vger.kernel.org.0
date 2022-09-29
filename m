Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C565E5EFCBB
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Sep 2022 20:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbiI2SLv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Sep 2022 14:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiI2SLt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Sep 2022 14:11:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2286E1E459B;
        Thu, 29 Sep 2022 11:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664475109; x=1696011109;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hi2tz7dvkDqO9KGRG9jxKLr4Lwuxpc+amCA8E8qTyfY=;
  b=kwPk69LahIVQbrC99oxQrpOzjYJoVLsqqPHRMWUraRrs+JBrGm5T/wYG
   HM6O/V+wvryih12fDRrWPzFQT+5kvJSOkgGplSxNTHkJQ4v6km+6i1w4q
   IMAVt0POwyGP4drlI9gQO17qT0LDfQlElLGQAe2z/pX53Z0B5UiV+zP6F
   sVLcm6WKMPjvnjbXVa3NFfFPHCvy37ytMdD2WrckbCoKBzrYuZHozNChA
   /PaPXET/KhdFTVSxcTpjWsR6tRhsXUNbeqhtieYx80lNX03JUf4r7ZaR4
   uQ7cuD3FZD3a+DaqU13cx7czs5+DQ5N/3lfEhx1hq1UUkrxLFMiEw+Rb7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="282347587"
X-IronPort-AV: E=Sophos;i="5.93,355,1654585200"; 
   d="scan'208";a="282347587"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 11:11:48 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="600106659"
X-IronPort-AV: E=Sophos;i="5.93,355,1654585200"; 
   d="scan'208";a="600106659"
Received: from tjthomps-mobl.amr.corp.intel.com (HELO [10.252.139.94]) ([10.252.139.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 11:11:48 -0700
Message-ID: <665a4db2-a342-43ba-38a0-715c34709729@linux.intel.com>
Date:   Thu, 29 Sep 2022 11:11:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v14 2/3] virt: Add TDX guest driver
Content-Language: en-US
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220928215535.26527-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220928215535.26527-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YzXduIn83E1oood8@fedora>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <YzXduIn83E1oood8@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/29/22 11:02 AM, Wander Lairson Costa wrote:
>> +#define TDX_GUEST_DEVICE                "tdx-guest"
> nit: I think now we can use KBUILD_MODNAME, can't we?
> 

Yes. We can use it. But I thought user can use this macro
and avoid hard coding the device name.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
