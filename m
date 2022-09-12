Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D045D5B5C09
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Sep 2022 16:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiILOPx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Sep 2022 10:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiILOPu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Sep 2022 10:15:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C055622BC2;
        Mon, 12 Sep 2022 07:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662992141; x=1694528141;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6psuZt3LL48N+MNUEJzImROgem6VBVvCU+SupMM9vD8=;
  b=mcr8OeG8tn8LXMiODvOvJ5AVAWW8tDyt73y6dINwe22KkB2fA4GuWCbB
   WoLD9VDBHP9O/dZ9HKJGxjlatxnNaoBCnlxvd+jcTODboLCYE+6+GCuot
   RovDCf2/DjxRNb57Giel9SfutzHcvbhDwHD7UZdjIdBQfsCMCzV3XshzY
   0ZXkrRDa/LfaR3aCqh/0kwX+DD9VdmuSaKuRDKKxkHUJ6YM72rtwkJEVH
   qDIGG1jaDKQ6XVqCznRFWDbWSGRbDnzzN112uMntdCvlVDuMsFNGC2FI2
   g3zITKkyTG0Db9gWYHTzBxzlGlpqVabHiMQaZHf7cFPDNZHHq8fXUtJNM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="298674803"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="298674803"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 07:15:41 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="616064415"
Received: from snehate-mobl.amr.corp.intel.com (HELO [10.212.195.232]) ([10.212.195.232])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 07:15:41 -0700
Message-ID: <8c699191-a424-32a1-8434-7b9b706ed6a4@linux.intel.com>
Date:   Mon, 12 Sep 2022 07:15:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v13 3/3] Documentation/x86: Document TDX attestation
 process
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
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
 <20220909192708.1113126-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <8cb035b4e2cb1e5a49bab23ca7d06920e1585ec8.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <8cb035b4e2cb1e5a49bab23ca7d06920e1585ec8.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/12/22 12:04 AM, Huang, Kai wrote:
>> +
>> +TDX Guest driver
>> +================
>> +
>> +The TDX guest driver exposes IOCTL interfaces via /dev/tdx-guest misc
>> +device to allow user space to get certain TDX guest specific details
>> +(like attestation report, attestation quote or storage keys, etc).
> Only TDX_CMD_GET_REPORT is supported now.  Whether GetQuote TDVMCALL should be
> supported, or how should it be supported is unknown now.  Not to mention "get
> the storage keys".

The reason for adding them is to give an idea that this driver in future could
be used for use cases other than GetReport. Query about possible use cases came up
in a previous review about /dev/tdx-guest device name usage. So I thought it is
better to give a clear idea on how this device may be used in the future.

Maybe I can add a note that currently only attestation report is supported.

> 
> I don't think you should put anything here now except "allow userspace to get
> TDREPORT".
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
