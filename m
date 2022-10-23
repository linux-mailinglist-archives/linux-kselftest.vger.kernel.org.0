Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C696094A8
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Oct 2022 18:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiJWQNR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Oct 2022 12:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiJWQNO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Oct 2022 12:13:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6F26FA2C;
        Sun, 23 Oct 2022 09:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666541592; x=1698077592;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Dx/eyFHeXeUFZ0jVshCZRF81EMBFVHHeyq+Bgt9BlYE=;
  b=QkyJTeuRqOFmhhG80A25Nzj4g1sEgU+xH9tr0dllJ9kqIyM6A+q9pEzr
   bH/f/y7DMdA15iwHXkWiTndnAomhpGUpFgGPFLs9zO8EDyr4mL4c1M6mg
   4X435kBydKgoQRUVAEOCiXKbx1RqPGNqzmf3qw+eP3BN2iGy14yCbtwgq
   xH6Bsf5+d5hXfW7wCbQboQjU3qbXMdjdUL32wwrPCPriEjwlwfIVy06HQ
   p82dzN9QTGR+v6KI5sZBNpm60uqGkRv6QXoV4T3iCBu1EQkF/UMcWAiFD
   BensBIpu3kHlNoTJuZEElXxU+IIgFct6LMpSfqIMKfCGMMaGfZLM9Y/fy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="307271592"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="307271592"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 09:13:12 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="631031587"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="631031587"
Received: from supriya-m-ravichandran.amr.corp.intel.com (HELO [10.212.253.138]) ([10.212.253.138])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 09:13:11 -0700
Message-ID: <c09184e3-ac15-b230-6dea-d6718f6f0ab0@linux.intel.com>
Date:   Sun, 23 Oct 2022 09:13:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v15 2/3] virt: Add TDX guest driver
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20221020045828.2354731-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20221020045828.2354731-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Y1De4IyAB6n2qs4V@kroah.com>
 <34ef18d6-69f8-853a-d1ba-7023822e17ff@linux.intel.com>
 <Y1Iimg0WItgIGq6/@kroah.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Y1Iimg0WItgIGq6/@kroah.com>
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



On 10/20/22 9:39 PM, Greg Kroah-Hartman wrote:
>>> You are allowing userspace to spam the kernel logs, please do not do
>>> that.
>> Added it to help userspace understand the reason for the failure (only for
>> the cases like request param issues and TDCALL failure). Boris recommended
>> adding it in the previous review.
> Again, you just created a vector for userspace to spam the kernel log.
> No kernel driver should ever do that.
> 

Brois, any comments? Do you also agree?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
