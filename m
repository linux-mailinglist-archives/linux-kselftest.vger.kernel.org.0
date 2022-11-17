Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096A062E68F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 22:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbiKQVOe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 16:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbiKQVOc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 16:14:32 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529AD64540;
        Thu, 17 Nov 2022 13:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668719672; x=1700255672;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cC3iQMztgxw2HXeDyVIeUIc5rQSRnJlPYcLAh0yNS4Y=;
  b=C2l4JXQLQE031ANYqkyan+iX3ExD9Xf9oTG4UzyVP/+2x/Y0RAZPWmai
   E4Vgtt1cA1iKgQJG8ZE53L9bPYHqb83KDl4pNNDvi9rJt5utcf2sbXyA/
   QXgA18B4kGXVun2Gvv8Xnsb5RqCbeLBEjqERbbtv+Z7GRjbxV83tVuxb7
   K1YjgRQ+GUeUAkMWvD7GhLw+qaRG78/PgP9BeG+RPa3zuy53kBBilToMB
   E/DLIeGkXeOzUVdAH5qYFcm8jOIxnPsvkKScdR2HI9bEoN3tyFg2wewaD
   MGMjogI4MDOwOMcKOCtGkW0ZyCGZCyVJBe4/dQsc6ENYajLHKaoPdbf/J
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="293371559"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="293371559"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 13:14:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="634199196"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="634199196"
Received: from wangyi7-mobl3.amr.corp.intel.com (HELO [10.212.182.5]) ([10.212.182.5])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 13:14:30 -0800
Message-ID: <74ecbd03-ec0f-2e15-7ddf-d9c16a9e2978@linux.intel.com>
Date:   Thu, 17 Nov 2022 13:14:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v18 0/3] Add TDX Guest Attestation support
Content-Language: en-US
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
References: <20221116223820.819090-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <c8240766-1537-356a-c219-c9da9626d2a9@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <c8240766-1537-356a-c219-c9da9626d2a9@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 11/17/22 11:07 AM, Dave Hansen wrote:
> Sathya, this conflicts with some fixes Kirill made that got applied in
> 6.1-rc3.  Can you double-check that the result looks right and tests OK,
> please?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/log/?h=tdxreport

It looks fine. Tested it and it works fine.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
