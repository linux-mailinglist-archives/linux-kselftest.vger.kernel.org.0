Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C062F623A93
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Nov 2022 04:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiKJDlj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Nov 2022 22:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKJDli (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Nov 2022 22:41:38 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B452F38F;
        Wed,  9 Nov 2022 19:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668051697; x=1699587697;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LmO3L26v183LdE2NCJXBTWeXsl9P82maSCwMJZ8wdqE=;
  b=M/DasHoieyOildnL6D8NyoB7oAg7w9P0BG3PiLrBptCsmNG+K1f6cVQ5
   atdNXlJibJ0jA8iJWPcDYRyd//A5/bXtXffxPS87+QXa4NLeLb2IwiprC
   OSR+wK76Gzo0ccHRBoO6sFQNe7CFPvPTfrU7JTlD4GVvZaci9uD40YYlg
   YPzoSuUPYjVgqt3uWU/WdKy4IfbcWO9eWa3Lu80pO+FTbKVw9h6uj/Gbi
   5U6DSLVoBP/A1ZfPopRZoOutEbrfix3n5c23bXIjzCnzNgvkTUZItz/7s
   t5OwjccpofyuHoi8HKFsrGiLRxaCPPjVOGoplRAZjjr9T5QRbe3Rb/Czd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="312969584"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="312969584"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 19:41:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="588016264"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="588016264"
Received: from bchobbs-mobl1.amr.corp.intel.com (HELO [10.212.157.64]) ([10.212.157.64])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 19:41:36 -0800
Message-ID: <4d7da783-f01e-504c-f40a-a5aed9a185bb@linux.intel.com>
Date:   Wed, 9 Nov 2022 19:41:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v17 0/3] Add TDX Guest Attestation support
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
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
References: <20221104032355.227814-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20221104032355.227814-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

Hi Boris/Dave,

On 11/3/22 8:23 PM, Kuppuswamy Sathyanarayanan wrote:
> Hi All,
> 
> Intel's Trust Domain Extensions (TDX) protect guest VMs from malicious
> hosts and some physical attacks. VM guest with TDX support is called
> as a TDX Guest.
> 
> In TDX guest, attestation process is used to verify the TDX guest
> trustworthiness to other entities before provisioning secrets to the
> guest. For example, a key server may request for attestation before
> releasing the encryption keys to mount the encrypted rootfs or
> secondary drive.
> 
> This patch set adds attestation support for the TDX guest. Details
> about the TDX attestation process and the steps involved are explained
> in Documentation/x86/tdx.rst (added by patch 2/3).
> 
> Following are the details of the patch set:
> 
> Patch 1/3 -> Preparatory patch for adding attestation support.
> Patch 2/3 -> Adds user interface driver to support attestation.
> Patch 3/3 -> Adds selftest support for TDREPORT feature.
> 
> Commit log history is maintained in the individual patches.
> 
> Current overall status of this series is, it has no pending issues
> and can be considered for the upcoming merge cycle.
> 

Any comments on this series? If you are fine with the current version,
I'm wondering if this can be considered for the upcoming merge window.
Please let me know what you think.

> Kuppuswamy Sathyanarayanan (3):
>   x86/tdx: Add a wrapper to get TDREPORT from the TDX Module
>   virt: Add TDX guest driver
>   selftests: tdx: Test TDX attestation GetReport support
> 
>  Documentation/virt/coco/tdx-guest.rst        |  42 +++++
>  Documentation/virt/index.rst                 |   1 +
>  Documentation/x86/tdx.rst                    |  43 +++++
>  arch/x86/coco/tdx/tdx.c                      |  38 +++++
>  arch/x86/include/asm/tdx.h                   |   2 +
>  drivers/virt/Kconfig                         |   2 +
>  drivers/virt/Makefile                        |   1 +
>  drivers/virt/coco/tdx-guest/Kconfig          |  10 ++
>  drivers/virt/coco/tdx-guest/Makefile         |   2 +
>  drivers/virt/coco/tdx-guest/tdx-guest.c      | 102 ++++++++++++
>  include/uapi/linux/tdx-guest.h               |  41 +++++
>  tools/testing/selftests/Makefile             |   1 +
>  tools/testing/selftests/tdx/Makefile         |   7 +
>  tools/testing/selftests/tdx/config           |   1 +
>  tools/testing/selftests/tdx/tdx_guest_test.c | 163 +++++++++++++++++++
>  15 files changed, 456 insertions(+)
>  create mode 100644 Documentation/virt/coco/tdx-guest.rst
>  create mode 100644 drivers/virt/coco/tdx-guest/Kconfig
>  create mode 100644 drivers/virt/coco/tdx-guest/Makefile
>  create mode 100644 drivers/virt/coco/tdx-guest/tdx-guest.c
>  create mode 100644 include/uapi/linux/tdx-guest.h
>  create mode 100644 tools/testing/selftests/tdx/Makefile
>  create mode 100644 tools/testing/selftests/tdx/config
>  create mode 100644 tools/testing/selftests/tdx/tdx_guest_test.c
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
