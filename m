Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08116FD344
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 May 2023 02:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjEJAOL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 May 2023 20:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjEJAOK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 May 2023 20:14:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DA010D1;
        Tue,  9 May 2023 17:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683677649; x=1715213649;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hulJYVB8DZm3nhi56FEUJQG0G5POBNv9VjOvpsYYdI4=;
  b=UoLFIIBEHebPw4rtV8j6f1zqEF+jMfDNgV1zpN5EagR07QPlKDyj7NAr
   XEpdT3lhc/TBYtBpvR7Z/R51MgBw8AFOMBJwc7Vwj7n+iNFtWZAV5+c4f
   otT8VS5GUw+ThH4SjMrjZ3Glofw2h5SyrYu4AULKNp1pqq1+ZimLXy/7n
   uAY1OnNCOnBEh28Kw3mEw3X63mlO6n/QzP5xYNulMX/nvbmklU6v3B4Lb
   0CKVdAS9qCa9DE16jmRI13Cs4Mr2bHmpe+CqXbf2vt1PBvpNdHqMfHyJh
   Q0afXISK5k15Ldvc+jSKk6Ti/wrGIh4NrZTDavc0NwtVjj+TL5GWOmwpl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="348923935"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="348923935"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 17:14:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="1028998897"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="1028998897"
Received: from kvnguye3-mobl1.amr.corp.intel.com (HELO [10.212.145.31]) ([10.212.145.31])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 17:14:08 -0700
Message-ID: <1a1f1f9e-a13b-3d5f-5b30-944bb108af67@linux.intel.com>
Date:   Tue, 9 May 2023 17:14:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/3] TDX Guest Quote generation support
Content-Language: en-US
To:     Erdem Aktas <erdemaktas@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Chong Cai <chongc@google.com>, Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
References: <20230413034108.1902712-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAAYXXYyfDyXxHH7Rw-iKMdqT+ymSG5vdGMvQKE8Wm3OSwE9E=Q@mail.gmail.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAAYXXYyfDyXxHH7Rw-iKMdqT+ymSG5vdGMvQKE8Wm3OSwE9E=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Erdem,

On 5/9/23 5:10 PM, Erdem Aktas wrote:
> On Wed, Apr 12, 2023 at 8:42 PM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>> Hi All,
>>
>> In TDX guest, the attestation process is used to verify the TDX guest
>> trustworthiness to other entities before provisioning secrets to the
>> guest.
>>
>> The TDX guest attestation process consists of two steps:
>>
>> 1. TDREPORT generation
>> 2. Quote generation.
>>
>> The First step (TDREPORT generation) involves getting the TDX guest
>> measurement data in the format of TDREPORT which is further used to
>> validate the authenticity of the TDX guest. The second step involves
>> sending the TDREPORT to a Quoting Enclave (QE) server to generate a
>> remotely verifiable Quote. TDREPORT by design can only be verified on
>> the local platform. To support remote verification of the TDREPORT,
>> TDX leverages Intel SGX Quoting Enclave to verify the TDREPORT
>> locally and convert it to a remotely verifiable Quote. Although
>> attestation software can use communication methods like TCP/IP or
>> vsock to send the TDREPORT to QE, not all platforms support these
>> communication models. So TDX GHCI specification [1] defines a method
>> for Quote generation via hypercalls. Please check the discussion from
>> Google [2] and Alibaba [3] which clarifies the need for hypercall based
>> Quote generation support. This patch set adds this support.
> 
> 
> Thanks Kuppuswamy for the v2 of this patch set.
> I reviewed all  3 patches and it looks good for me and it covers our use cases.

Thanks for the review. I will address other reviewers comments and resubmit v3
this week. I will include your Reviewed-by in it.

> 
>>
>> Support for TDREPORT generation already exists in the TDX guest driver.
>> This patchset extends the same driver to add the Quote generation
>> support.
>>
>> Following are the details of the patch set:
>>
>> Patch 1/3 -> Adds event notification IRQ support.
>> Patch 2/3 -> Adds Quote generation support.
>> Patch 3/3 -> Adds selftest support for Quote generation feature.
>>
>> [1] https://cdrdv2.intel.com/v1/dl/getContent/726790, section titled "TDG.VP.VMCALL<GetQuote>".
>> [2] https://lore.kernel.org/lkml/CAAYXXYxxs2zy_978GJDwKfX5Hud503gPc8=1kQ-+JwG_kA79mg@mail.gmail.com/
>> [3] https://lore.kernel.org/lkml/a69faebb-11e8-b386-d591-dbd08330b008@linux.alibaba.com/
>>
>> Kuppuswamy Sathyanarayanan (3):
>>   x86/tdx: Add TDX Guest event notify interrupt support
>>   virt: tdx-guest: Add Quote generation support
>>   selftests/tdx: Test GetQuote TDX attestation feature
>>
>>  Documentation/virt/coco/tdx-guest.rst        |  11 ++
>>  arch/x86/coco/tdx/tdx.c                      | 196 +++++++++++++++++++
>>  arch/x86/include/asm/tdx.h                   |   8 +
>>  drivers/virt/coco/tdx-guest/tdx-guest.c      | 168 +++++++++++++++-
>>  include/uapi/linux/tdx-guest.h               |  43 ++++
>>  tools/testing/selftests/tdx/tdx_guest_test.c |  68 ++++++-
>>  6 files changed, 487 insertions(+), 7 deletions(-)
>>
>> --
>> 2.34.1
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
