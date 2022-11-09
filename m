Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34BB622F3E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Nov 2022 16:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiKIPmf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Nov 2022 10:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiKIPme (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Nov 2022 10:42:34 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75A412602;
        Wed,  9 Nov 2022 07:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668008553; x=1699544553;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=sjfgAx2A7yyUe7NUZRr+6n5cM7pYtAKei3pTqp588Xs=;
  b=YFzpgE6WYSbvyrvrMzBHU32Rs5KTFv9xZ6OJtLSY4w5dIV0l0Vtyc9iI
   R/+eEVvTb1gk5dQlAMBN2AxKWicMGxSD9lmCs8xxCTw80bKz5q7zCc4cp
   +Eax4jpVVlze6XZCoCfOTJsundn2ZZA8CHORKnBV89kaW7CuwDExIh5T/
   v8PumwCOPx4AvTplkBkPp4SgUHIgATXzD07j4QacPzQHCL/cJXBmiXLWn
   hOqQ4DXoWcx4l5Gtc0rlgW23m/ZS7MvqdfodXn69nrnWBv56CNOKPhmYG
   9feq83QlnodIpIXiTgJL9qexs7GT6wWxTGk1x2vwBNNF5Dcx8WZcowRR4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="311005406"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="311005406"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 07:37:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="742439702"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="742439702"
Received: from dmurray1-mobl1.amr.corp.intel.com (HELO [10.209.100.117]) ([10.209.100.117])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 07:37:30 -0800
Message-ID: <6cab73d3-4d56-8069-f0f1-d47346c7bd15@linux.intel.com>
Date:   Wed, 9 Nov 2022 07:37:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v17 2/3] virt: Add TDX guest driver
Content-Language: en-US
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20221104032355.227814-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20221104032355.227814-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20221109142431.ffkhouuxewjajp6g@fedora>
 <ccbbb331-80c5-75bf-cd5d-82748ad63a60@linux.intel.com>
In-Reply-To: <ccbbb331-80c5-75bf-cd5d-82748ad63a60@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 11/9/22 7:36 AM, Sathyanarayanan Kuppuswamy wrote:
> TDG.MR.TDCALL expects reportdata and tdreport buffers to be size aligned. So,
> allocating them together with sizeof(struct tdx report req) will not work. We
> can get around this by allocating a slightly larger buffer size. However, because
> it is not a time-critical path, I believe that allocating two separate buffers
> for input/output is simpler.

I mean't TDG.MR.REPORT TDCALL.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
