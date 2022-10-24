Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031D260C059
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 03:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiJYBDQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Oct 2022 21:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiJYBCs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Oct 2022 21:02:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECDE459AE;
        Mon, 24 Oct 2022 16:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666655991; x=1698191991;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=hdZaNs5iMO5JH6LtUCsAkiAuMuGiiXGD8WqtALn07oE=;
  b=JchifkzTYgeQcrxlxtKgNUQrif/YHJ1AEQksVNF9WMMfjQ/XvbtulXmF
   oumyvuPUx7/nQPjdnIAMyB+fUo2pDOc8UQlskX6wp3lhrBUkHOFDbezhl
   VwrepPVwH5953R5XVc/aJbeTNUiU0fbix22nZtjSaEhrcDm2C96h9nlp9
   KmN6byn3xkFRck3qOomN0S1ce7bSLtXDdcOgetEJMgzri4Sx9FLVRl0Sg
   bQ2WloY3usRvcMFhGq/ubWHZol6/Xw2CvEDx9dYYr+vg75q5Yi5yZ40pr
   flcP+uxXBphUlSUh7XC0wncl1h96ocqAKWsmiremRC7r1IFwNRGZykn1O
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="305160854"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="305160854"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 16:59:50 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="694746317"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="694746317"
Received: from bmahadev-mobl.amr.corp.intel.com (HELO [10.212.216.245]) ([10.212.216.245])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 16:59:49 -0700
Message-ID: <91db431a-36ab-c833-1068-536695981d45@linux.intel.com>
Date:   Mon, 24 Oct 2022 16:59:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v15 2/3] virt: Add TDX guest driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wander Lairson Costa <wander@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20221020045828.2354731-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20221020045828.2354731-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Y1De4IyAB6n2qs4V@kroah.com>
 <34ef18d6-69f8-853a-d1ba-7023822e17ff@linux.intel.com>
 <Y1Iimg0WItgIGq6/@kroah.com>
 <c09184e3-ac15-b230-6dea-d6718f6f0ab0@linux.intel.com>
 <CAAq0SU=w-upGGstmQgTh63zGqLZnEy1OpF+9FwAjSWMuyYyXTg@mail.gmail.com>
 <Y1aY/4SWwuDENigJ@kroah.com>
Content-Language: en-US
In-Reply-To: <Y1aY/4SWwuDENigJ@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/24/22 6:54 AM, Greg Kroah-Hartman wrote:
>>>>>> You are allowing userspace to spam the kernel logs, please do not do
>>>>>> that.
>>>>> Added it to help userspace understand the reason for the failure (only for
>>>>> the cases like request param issues and TDCALL failure). Boris recommended
>>>>> adding it in the previous review.
>>>> Again, you just created a vector for userspace to spam the kernel log.
>>>> No kernel driver should ever do that.
>>>>
>>> Brois, any comments? Do you also agree?
>>>
>> Maybe dev_err_once() does the job?
> That does not make any sense when the userspace input can be different
> each time.
> 
> This is just yet-another-ioctl, there's nothing special about it.
> Return an error for invalid input and don't log anything.  Worst case,
> make it a dev_dbg() call if you really really really want to see it.

It is a nice to have debug info, but not very important. So I will remove it.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
