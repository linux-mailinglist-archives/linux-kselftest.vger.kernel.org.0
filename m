Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCE95B6A34
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Sep 2022 11:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiIMJCl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Sep 2022 05:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiIMJCI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Sep 2022 05:02:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FA95C955;
        Tue, 13 Sep 2022 02:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663059700; x=1694595700;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MQLvPvSmi5l1/oQ588bxZkJ8HGx1AWb6oknroVfrx08=;
  b=itfQsbOjPORrhRUFn1PasTqK5kkjPE9rUspVsNTmoBeyX8gaDhIh21kC
   c5a3Sh7zlWPXt5zhpVrUGM0x860aicRu/GLhBhbWKa2/ofGrTbSKTvHTm
   SNbPsWIJFABn7fZopyRcnM+PVl34a9w2/8uxPaix9bLUdFBHLlvr8mCUY
   ZlvrmuVZ14apAcv1Um2UsfS3uITQd2Ie6fa1PrqrQgD4JM8n8lk3nH1XT
   Dp+zfYiCOm79y7mn3y00hBecsVSJvhCOD07rMsX8WstXq0NFFkOu7fEIb
   p3O23TD/TYwSRroqaYfL6aDXOwnKOjhRSXlMwcNxFyMRgvlAt0GItHFSW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="362036070"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="362036070"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 02:01:39 -0700
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="616384388"
Received: from bsalunkh-mobl.ger.corp.intel.com (HELO [10.213.238.99]) ([10.213.238.99])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 02:01:35 -0700
Message-ID: <4a4ed638-d505-6f30-bf0f-a16a32d494a4@intel.com>
Date:   Tue, 13 Sep 2022 02:01:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v13 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "khalid.elmously@canonical.com" <khalid.elmously@canonical.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Cox, Philip" <philip.cox@canonical.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20220909192708.1113126-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220909192708.1113126-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <f85dbb3636ad199ff5f6ea9bdf5e17261f66945d.camel@intel.com>
 <d67b4273-e0a6-6b24-b96c-7a3193ae52f9@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <d67b4273-e0a6-6b24-b96c-7a3193ae52f9@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/12/22 19:44, Sathyanarayanan Kuppuswamy wrote:
>> and include the header (<linux/string.h> ?) for memchr_inv()?
> One of the previous headers includes linux/string.h (I am not sure which one).
> So why include it explicitly?

Because it's a best practice.  What happens is that you ride along on
the coat tails of another #include, someone sees that include is no
longer used and removes it.  Then, your code is busted on some weird
.config.

*OR*, the header itself changes and doesn't #include the dependency you
need.

I guess you can go add this advice to Documentation/ if it's not there
already somewhere.
