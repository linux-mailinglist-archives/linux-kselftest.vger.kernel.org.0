Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087BF5B8751
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Sep 2022 13:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiINLgM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Sep 2022 07:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiINLgL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Sep 2022 07:36:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AC07C1A3;
        Wed, 14 Sep 2022 04:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663155370; x=1694691370;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/UyNS1z5553flzYh+TOYHe0+TXBOSWmCkQFcTXHq+KU=;
  b=Asx85HhUSGiNp8TarWw2oAUHa1WpfTULFz/rezyFT+ZCHij8Wx0RXsbk
   +DZRHSnZrgPrV/zZLMhPukPqHeQPoi78LWpgbmSr07rKOsmxfXAuY+/IX
   noqlNoGveEOwy7Q8iQwpWJGZ+zAwEHNby0d55fU7uKiY67c3NkNdWphn9
   078GSi8yeebA/GozuCr0NTT1VJIc6SVxUCjzJ0TdHNb7Zhr5XhCDobvU/
   aXxt3rROrlYp64T8/MjM5lCsFZOgcFENkQ4/zxjo/EnyEgKOn7e0onkvU
   qkS5VOjl35P2C+v5YpRXCCWmA+shvyxm/UYr57cTq/yD7nrii8ijpeHXp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="278133852"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="278133852"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 04:36:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="567978194"
Received: from rwathan-mobl1.ger.corp.intel.com (HELO [10.213.220.95]) ([10.213.220.95])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 04:36:04 -0700
Message-ID: <7c3cc265-869b-b2fc-43f2-d2cbd0bc142c@intel.com>
Date:   Wed, 14 Sep 2022 04:36:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v13 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220909192708.1113126-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/9/22 12:27, Kuppuswamy Sathyanarayanan wrote:
> 
>  arch/x86/coco/tdx/tdx.c         | 115 ++++++++++++++++++++++++++++++++
>  arch/x86/include/uapi/asm/tdx.h |  56 ++++++++++++++++
>  2 files changed, 171 insertions(+)
>  create mode 100644 arch/x86/include/uapi/asm/tdx.h

The SEV equivalent of this in in:

	drivers/virt/coco/sev-guest/sev-guest.c

right?

Why did you choose a different location?  Also, can you please study the
SEV implementation a bit?  It might help you find problems like the
ioctl() return code issue.  The SEV driver appears to have gotten that
right.
