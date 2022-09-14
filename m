Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565385B8C98
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Sep 2022 18:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiINQMc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Sep 2022 12:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiINQMa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Sep 2022 12:12:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362FD82D36;
        Wed, 14 Sep 2022 09:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663171945; x=1694707945;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xqwq9WCXxeRuve+N6cmR8jhfeorkJSLMTvaV9AUCJEg=;
  b=eM4lWd45eDP32l9zhsqKITec4B1dpvMuuD3u7M5yxOnPkfsGMGk1RiBa
   REjk+WUdBRB3SA6Lp1EKtDlThU5aHbauSaouCevCvPAo9+6Po2PnlDEt0
   MSDQ3o5DvVZErRhd2N1O1MYg+WYnWtZbn8hpKD7/dfJamX8qKhu8QHLIE
   N6yxF9W0HQYZpPqNllxhYyr15SWiBPpf6+ral2IipbcZ3UhywVMiWU1V8
   ZtA+D1xEIK6bvBIWcW7d5LOfGovX18N4JoI4WGCo7F99VkdL12UnekLjE
   oZZgLp0pP4aCSdraiKzP4uODSKtcDM3LJoPsuxKaFooo8l6a/JVXvzV/a
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="362432263"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="362432263"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 09:12:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="647445252"
Received: from swallace-mobl1.ger.corp.intel.com (HELO [10.213.224.160]) ([10.213.224.160])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 09:12:13 -0700
Message-ID: <d238f235-5623-d152-c0d3-2ef851f88473@intel.com>
Date:   Wed, 14 Sep 2022 09:12:11 -0700
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
 <7c3cc265-869b-b2fc-43f2-d2cbd0bc142c@intel.com>
 <1182ef92-cae3-b7c1-8339-8e8bfa48f2e3@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <1182ef92-cae3-b7c1-8339-8e8bfa48f2e3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/14/22 08:36, Sathyanarayanan Kuppuswamy wrote:
> When we initially submitted the attestation patches, virt/coco folder
> was not created. I initially kept this driver in platform/x86/, but
> later moved to arch/x86/coco based on the review comments in v4. There
> was a discussion about the need for a new config and the location of
> the driver. The outcome of that discussion is, since this is not a
> traditional driver, but a basic TDX feature, we don't need a special
> config and the code can be maintained in the arch/x86/coco folder.

Could you please include the following in this set somewhere:

"The code to do the SEV analog of this TDX functionality is in
___insert_path_here____.   This code is different from that because
______reason______ so it is instead placed in ____other_path____."

?
