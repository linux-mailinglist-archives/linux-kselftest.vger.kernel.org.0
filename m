Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0649C62E4F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 20:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240382AbiKQTHa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 14:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240406AbiKQTHa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 14:07:30 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6D27EC8B;
        Thu, 17 Nov 2022 11:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668712049; x=1700248049;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9EfHtP5S2B6wxUeY6vqEwu5VPJ+3h8kafooeBjJT1/8=;
  b=E5pb+8GCZbcvDknyMh7npeyObTNHvzk4jjv90+2qjNYRIQ1hLci7jLyN
   numNfBe1cxycu11jqcyj/vx0DNs8cV3vwg4HsaaltTcVd08C/qh50WqGD
   0YcNmExKUYWtgxH1QbiDPSMRIEHgr+vsS0/6G1yS/j+MZO8dDMG4bPHxY
   ZFlh0bMHZFC/j1br2KdneII87bQ+HBJv03EWxM6a8aSrKEYjs5aEvNCOf
   f85qoXm/UFqD/so1x/Qw83WKcjnmPYEWqV/OpZTCVq+b+QtTcmLfh3+rR
   3aYuF+7Tc1taTl/pQZQS4CRW+L2ZipcSn+zbdgWS4x3fKKdLIo8NRL/PW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="375076916"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="375076916"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 11:07:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="764881694"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="764881694"
Received: from vrgatne-mobl4.amr.corp.intel.com (HELO [10.209.115.197]) ([10.209.115.197])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 11:07:28 -0800
Message-ID: <c8240766-1537-356a-c219-c9da9626d2a9@intel.com>
Date:   Thu, 17 Nov 2022 11:07:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v18 0/3] Add TDX Guest Attestation support
Content-Language: en-US
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221116223820.819090-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sathya, this conflicts with some fixes Kirill made that got applied in
6.1-rc3.  Can you double-check that the result looks right and tests OK,
please?

https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/log/?h=tdxreport
