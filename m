Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6D55B91A3
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Sep 2022 02:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiIOAau (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Sep 2022 20:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIOAat (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Sep 2022 20:30:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53D886FF7;
        Wed, 14 Sep 2022 17:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663201848; x=1694737848;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f3arqoM1mTN79PR584P6N+hqC5q/kwp/eTlHzWZFjgw=;
  b=nu+7lIo2ischnxQEON7BpILh6o9oA8NALaem6kJUdoIX1d5qlu4NRQGV
   BeDKghTR0Vq8gvIlnC0utiAlRWZ4yISYUdEZe7FXcSIeJioxRgl95R+KJ
   Cxfxq0ASnI6Il9iRx8gu4LrReBADKTzDh41zK9UIvQkSIi9ZS1C0SzD2D
   eD6RQBvbqCXV4OXhJ1c3pVFqnJoAUgVbuc4AOyGgEfJGgn2GAJSH85eO9
   UMYgdFSRM05V4pKS70rf8VzyVrs2nekVFWapND0vzs20Kf2wuH/Ir+Dqo
   ewIqUUEIHqZBJxJnsq6oso0UUQ9r/nisb+6iyX9+BvzUh+4adjrGNT1I4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="362536145"
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="362536145"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 17:30:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="759418141"
Received: from mmcgoort-mobl.amr.corp.intel.com (HELO [10.209.54.54]) ([10.209.54.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 17:30:46 -0700
Message-ID: <d5b54f8c-2e03-4ac8-8b8a-605c7f0f601b@linux.intel.com>
Date:   Wed, 14 Sep 2022 17:30:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v13 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
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
 <7c3cc265-869b-b2fc-43f2-d2cbd0bc142c@intel.com>
 <1182ef92-cae3-b7c1-8339-8e8bfa48f2e3@linux.intel.com>
 <d238f235-5623-d152-c0d3-2ef851f88473@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <d238f235-5623-d152-c0d3-2ef851f88473@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/14/22 9:12 AM, Dave Hansen wrote:
> On 9/14/22 08:36, Sathyanarayanan Kuppuswamy wrote:
>> When we initially submitted the attestation patches, virt/coco folder
>> was not created. I initially kept this driver in platform/x86/, but
>> later moved to arch/x86/coco based on the review comments in v4. There
>> was a discussion about the need for a new config and the location of
>> the driver. The outcome of that discussion is, since this is not a
>> traditional driver, but a basic TDX feature, we don't need a special
>> config and the code can be maintained in the arch/x86/coco folder.
> 
> Could you please include the following in this set somewhere:
> 
> "The code to do the SEV analog of this TDX functionality is in
> ___insert_path_here____.   This code is different from that because
> ______reason______ so it is instead placed in ____other_path____."
> 
> ?

I have also included info about why we don't use a separate config
option for it.

The code for the SEV equivalent of this TDX attestation functionality
can be found in drivers/virt/coco/sev-guest/. It is implemented as a
platform module driver, and it can be enabled using the CONFIG_SEV_GUEST
config option. However, in the case of TDX, it is implemented as a
built-in driver in the arch/x86/coco/tdx/tdx.c because of the following
reasons:

1. Attestation is expected to be needed by all distributions that support
   TDX. Therefore, using a separate configuration option is not necessary.
   With TDX support, it can be enabled by default, and a built-in driver
   model will work better in this use case.
2. Since it is not a conventional device driver and the code is very simple,
   creating an individual driver for it may be an overkill.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
