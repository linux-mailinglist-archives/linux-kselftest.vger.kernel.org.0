Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CAF711A56
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 00:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjEYWza (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 May 2023 18:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjEYWz2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 May 2023 18:55:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24956DF;
        Thu, 25 May 2023 15:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685055327; x=1716591327;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=nNSE7gZD/t2N1lRWvql6XviO837VuUuQllGGpYRQhgM=;
  b=Cv7BMQ+ytcxVxXAzpHRs0wSkoCslA3Knry38Jj4HwaaPpnWCpbe0RdOw
   LkUEYosg1C6lUtYBnAZ/XV942WpuXk0sJ9mQiv0+7N3xKB/Bil4zZKJqy
   M8LTy7jZuGJA45mbeo0yihlvGP/Zz2h/jSuqA73F4D7dJTNsAkLiOGYQF
   r2ri81/Jj/qi+U74O35+BRg3XeUiRL3Ecpdh9U1oIY6mKkT6ckRAptk5M
   pymU1vdG2iGDfxhriJcmChRpNBFVmJ4lh6UDDCOU8nS+2rMzra+J+vi24
   WsKBaP0ie3ptM/s64xBXJl7BNnydVcrOyVt2MOHBoq1jjPZ2weyXvpDpo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="354068214"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="354068214"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 15:55:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="699194720"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="699194720"
Received: from asobhanx-mobl1.amr.corp.intel.com (HELO [10.209.120.148]) ([10.209.120.148])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 15:55:26 -0700
Message-ID: <3c57deb0-a311-2aad-c06b-4938e33491b5@linux.intel.com>
Date:   Thu, 25 May 2023 15:55:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v3 0/3] TDX Guest Quote generation support
To:     Chong Cai <chongc@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CALRH0CjSko=j9w1U6OY6NaZ-jav1t7adxdK40=FV5gbF2yX1PQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALRH0CjSko=j9w1U6OY6NaZ-jav1t7adxdK40=FV5gbF2yX1PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 5/24/23 2:33 PM, Chong Cai wrote:
> Tested-by: Qinkun Bao <qinkun@google.com>
> 
> Thanks Sathyanarayanan for the new patch! This patch is critical for
> our use case.
> We built a guest image with the patch, and verified it works for us,
> when using a host kernel built with https://github.com/intel/tdx repo.

Qinkun Bao/Chong Cai, thanks for testing it. I really appreciate the help.

Dave/Boris, could you please take a look at this patch set?

> 
> On Sun, May 14, 2023 at 12:24 AM Kuppuswamy Sathyanarayanan
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
>>  arch/x86/coco/tdx/tdx.c                      | 194 +++++++++++++++++++
>>  arch/x86/include/asm/tdx.h                   |   8 +
>>  drivers/virt/coco/tdx-guest/tdx-guest.c      | 175 ++++++++++++++++-
>>  include/uapi/linux/tdx-guest.h               |  44 +++++
>>  tools/testing/selftests/tdx/tdx_guest_test.c |  65 ++++++-
>>  6 files changed, 490 insertions(+), 7 deletions(-)
>>
>> --
>> 2.34.1
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
