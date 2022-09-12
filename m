Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B215B62DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Sep 2022 23:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiILViq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Sep 2022 17:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiILVip (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Sep 2022 17:38:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBF14BD33;
        Mon, 12 Sep 2022 14:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663018724; x=1694554724;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YlAnYfErS6+t38OX2ZEcrlgXeg8UJVYQ3pX9p7Bh35U=;
  b=EXnWQ3SEPMv9amXgxMSA/juyQrbRANBT2qwRmn5cFEJDWKs2boEfWipU
   zovIkwVsQWNLFBPfvq3bgo5UPU82f+yp+PmX4MgvmDn0Fxfi1BGKd3Hpy
   NbWBXTJNctrH3NL39IZ7eazfXcu14IOCT7gjSvimSsm3HFPcaLSYfZuaB
   VBx90GKu6IkHv8ZO9cNGKyZuW04JhZOI0bZMDIDKZLMZBun/qh7737m17
   r3D8EiympYs5FzDC6urXxtGuH3h1zf/tvbW/l2PwRxfd+NlYmZaNBMhFI
   mWyb7Ti6Z/bPAmch3L2nojKlOOZKG33emnkl4wE7ExUF27GJLTabWT/Sv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="324215589"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="324215589"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 14:38:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="618695458"
Received: from mdejong-mobl.amr.corp.intel.com (HELO [10.209.13.71]) ([10.209.13.71])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 14:38:43 -0700
Message-ID: <1cef159a-7827-47bc-639a-209521a337bf@linux.intel.com>
Date:   Mon, 12 Sep 2022 14:38:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v13 2/3] selftests: tdx: Test TDX attestation GetReport
 support
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
 <20220909192708.1113126-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <9983d33b59668cfa3bc1d36beaf13f5a4180bad3.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <9983d33b59668cfa3bc1d36beaf13f5a4180bad3.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/12/22 12:21 AM, Huang, Kai wrote:
> On Fri, 2022-09-09 at 12:27 -0700, Kuppuswamy Sathyanarayanan wrote:
>> Intel's TDX guest driver exposes TDX_CMD_GET_REPORT IOCTL interface to
>> get the TDREPORT from the user space.
> 
> (Sorry missed this one in previous reply).
> 
> Also, the IOCTL is to return the TDREPORT _to_ userspace, but not get the
> TDREPORT _from_ userspace.

How about following?

Intel's TDX guest driver exposes TDX_CMD_GET_REPORT IOCTL interface to

enable guest user space get the TDREPORT.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
