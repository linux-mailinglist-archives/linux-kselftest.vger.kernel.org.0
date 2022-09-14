Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699365B8C0B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Sep 2022 17:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiINPjC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Sep 2022 11:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiINPii (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Sep 2022 11:38:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A5884EC2;
        Wed, 14 Sep 2022 08:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663169795; x=1694705795;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TTSmPWTGTvQ2ubhEdKoOh9dsn95GYUqtSGWPLazI0uU=;
  b=EbbLDdrOlJl73czShs/WEhohAV1aNbqwnwCP/IERWQM3tqjLGq1y0Hdj
   JRuHj11x+JpUswQGc3iyjSvf/MUVYaiiZ26aDLu0S1TU+XUEBwHCTZVbC
   eS1JQAspzQih8kFYTudBlxb9+yfox0XkFlwBRO1HlJ14X4oxvtqyIGmyV
   ekTJ7xbCDaDfSdWK+RLsH7RzynIy7F8LHAdj/U2e7uAmPkYJ/cKqNVvXL
   9dQcDvlI7j2AEWf+Rax9+6aW0FFabWByYYiWNoLfttfstTlvzP85//xKH
   eMwSYujpXNia44m8G/T3ho/CKExB+fInkEyaNmAo/ODmR+oRP5av8cAUL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="285500122"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="285500122"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 08:36:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="759257743"
Received: from mmcgoort-mobl.amr.corp.intel.com (HELO [10.209.54.54]) ([10.209.54.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 08:36:11 -0700
Message-ID: <1182ef92-cae3-b7c1-8339-8e8bfa48f2e3@linux.intel.com>
Date:   Wed, 14 Sep 2022 08:36:10 -0700
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
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <7c3cc265-869b-b2fc-43f2-d2cbd0bc142c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/14/22 4:36 AM, Dave Hansen wrote:
> On 9/9/22 12:27, Kuppuswamy Sathyanarayanan wrote:
>>
>>  arch/x86/coco/tdx/tdx.c         | 115 ++++++++++++++++++++++++++++++++
>>  arch/x86/include/uapi/asm/tdx.h |  56 ++++++++++++++++
>>  2 files changed, 171 insertions(+)
>>  create mode 100644 arch/x86/include/uapi/asm/tdx.h
> 
> The SEV equivalent of this in in:
> 
> 	drivers/virt/coco/sev-guest/sev-guest.c
> 
> right?
> 
> Why did you choose a different location?  Also, can you please study the

When we initially submitted the attestation patches, virt/coco folder
was not created. I initially kept this driver in platform/x86/, but
later moved to arch/x86/coco based on the review comments in v4. There
was a discussion about the need for a new config and the location of
the driver. The outcome of that discussion is, since this is not a
traditional driver, but a basic TDX feature, we don't need a special
config and the code can be maintained in the arch/x86/coco folder.

https://lore.kernel.org/lkml/YmEfgn7fMcZ2oCnr@zn.tnic/

> SEV implementation a bit?  It might help you find problems like the
> ioctl() return code issue.  The SEV driver appears to have gotten that
> right.

Ok.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
