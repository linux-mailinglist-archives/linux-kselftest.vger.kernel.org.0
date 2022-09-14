Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9865B8CE7
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Sep 2022 18:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiINQ04 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Sep 2022 12:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiINQ0v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Sep 2022 12:26:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB6E7E030;
        Wed, 14 Sep 2022 09:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663172810; x=1694708810;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AC4JYbF6AZcpOk2oht7rvIOxqaKfTAvgQo6j8JLFWEE=;
  b=afEnwMN5XozfSm3J9o9LzpNp0aO20MpEYBZDb5MwtdClwihffjuteOo3
   k+Sn47FTPy5VV8q8DsMshWBdwagH60p0LzKc55qrKe/u46QtXy+53FQE4
   gtLh5uEYaJvkNaU3zKkNtz7ycDFwXVaxcZnrAeppgOl74GQ7qL79MKTwY
   3h5nQoZxfmzbF40Wo9WRoh2VHWNbSiKSA+AClqmOeMk3TsjgFrDUvlVV1
   VHbIa6a3NIIAK9Miu8jh00G/v/qwt3HA15ixP9ng97JwluJq3dnPOuK2O
   OPEypocReTAiKMVH6xtW6UTpYuqRpr+5L3TOF4n+SrSwQJmtlVskO8XWN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="278861305"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="278861305"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 09:25:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="759273083"
Received: from mmcgoort-mobl.amr.corp.intel.com (HELO [10.209.54.54]) ([10.209.54.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 09:25:46 -0700
Message-ID: <ae8b76d0-9f1a-d694-8316-d96651b38957@linux.intel.com>
Date:   Wed, 14 Sep 2022 09:25:45 -0700
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

Ok. I will include it in the cover letter.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
