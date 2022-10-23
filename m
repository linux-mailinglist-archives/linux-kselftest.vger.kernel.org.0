Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4926094A2
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Oct 2022 18:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiJWQJr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Oct 2022 12:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiJWQJp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Oct 2022 12:09:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06F713DF4;
        Sun, 23 Oct 2022 09:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666541381; x=1698077381;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=5sJjgPYURVkJ7M7Maes4lTmD0dci9fN0izGbeTfmFjU=;
  b=QH/eohGO2V3eifAeOeblyl8vHXNJMw3uaMPHN+GgNqBsvLmygZ9V6JHO
   QTVSxfiwd5yFvTduB6Jwf02HqNqH1fXXmPUTc6nxYtIgPmL0I1bdVJZJ5
   qURJH3ttj8XyWt3No0eekpvA59WiB6s50zijHF87USUUSkcKihQLgmkdf
   n/hYIX8G1AhYHDog7519RCRLvDg3eh90IiLBbbE0CkiZaz8Om3TkchcBW
   BgoMe2r8YizkUxRJetwmAuonGWucdleXdF1lmj36sK0ztdkW8bm9z2t4n
   DrBCTHLvorJ13uLFtbSIonIGNXIzb8FndYDuq3HqZXer01u0yVaeNJqzv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="286998045"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="286998045"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 09:09:41 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="720250850"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="720250850"
Received: from supriya-m-ravichandran.amr.corp.intel.com (HELO [10.212.253.138]) ([10.212.253.138])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 09:09:40 -0700
Message-ID: <5868a82b-aeba-d465-2471-b8058c7afed0@linux.intel.com>
Date:   Sun, 23 Oct 2022 09:09:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v15 0/3]] Add TDX Guest Attestation support
To:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20221020045828.2354731-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <95240a74-0c49-d051-a609-775c48b22bf5@intel.com>
Content-Language: en-US
In-Reply-To: <95240a74-0c49-d051-a609-775c48b22bf5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dave,

On 10/20/22 10:08 AM, Dave Hansen wrote:
> On 10/19/22 21:58, Kuppuswamy Sathyanarayanan wrote:
>> Following are the details of the patch set:
>>
>> Patch 1/3 -> Preparatory patch for adding attestation support.
>> Patch 2/3 -> Adds user interface driver to support attestation.
>> Patch 3/3 -> Adds selftest support for TDREPORT feature.
>>
>> Commit log history is maintained in the individual patches.
> 
> I really appreciate when folks come out and say what they think should
> be done with the series.  Is this ready to be applied?  Or, is it just

There are some minor changes suggested by Greg in this version. I will
address them in the next version. IMO, the next version can be considered
for the merge.

> being thrown over the fence in the general direction of the maintainers
> with the hope that they'll divine its true purpose?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
