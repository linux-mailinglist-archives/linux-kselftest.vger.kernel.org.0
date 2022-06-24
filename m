Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E6D558D93
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jun 2022 04:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiFXCzT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jun 2022 22:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiFXCzS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jun 2022 22:55:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3108A56C11;
        Thu, 23 Jun 2022 19:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656039317; x=1687575317;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/RpUXBE79sOfJCoREkZTGBnBsiJrvEg8tSgxFL3GhL4=;
  b=jqYiRP5dejHC1UMDPRGzBB6W4/AglmRwVk54O/e9G6ZcATK4GSXgyp7w
   5pmQjcSqQixEv8MXp5dNHOorQvEBmsklZ9ie2HSbm0+F+ykfZ/3qHU9CK
   Zeq2+CieHD5dDyrNZE9cA6dcccQaHPe+r6/cLG5wtD3o1dYfDKTF1+glV
   jG+tENaAG+dKGCu5a2Iw/2Hh3g2y25/O8bVKH9631+4QVMJ9CwSSlLZk2
   BiaBI/AuAvlTRVCZhwuKw/KkBuT7UIezAJaQsp8ezR71vuF1k0WjggxU+
   fGDwMvXswIM6htKsc9w7ILCr9xvKy+nS2521lFPkAXY7I68kt44ywdHRH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="306371577"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="306371577"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:55:16 -0700
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="645066685"
Received: from zengguan-mobl1.ccr.corp.intel.com (HELO [10.255.31.117]) ([10.255.31.117])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:55:15 -0700
Message-ID: <63401e6e-76b0-264f-be99-ac60aa60c023@intel.com>
Date:   Fri, 24 Jun 2022 10:55:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] KVM: selftest: Enhance handling WRMSR ICR register in
 x2APIC mode
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        "Gao, Chao" <chao.gao@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Venkatesh Srinivas <venkateshs@chromium.org>
References: <20220623094511.26066-1-guang.zeng@intel.com>
 <20220623103314.GA14006@gao-cwp> <YrTOU1QHHpGpe0ym@google.com>
From:   Zeng Guang <guang.zeng@intel.com>
In-Reply-To: <YrTOU1QHHpGpe0ym@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 6/24/2022 4:34 AM, Sean Christopherson wrote:
> +Venkatesh
>
> On Thu, Jun 23, 2022, Chao Gao wrote:
>> On Thu, Jun 23, 2022 at 05:45:11PM +0800, Zeng Guang wrote:
>>> Hardware would directly write x2APIC ICR register instead of software
>>> emulation in some circumstances, e.g when Intel IPI virtualization is
>>> enabled. This behavior requires normal reserved bits checking to ensure
>>> them input as zero, otherwise it will cause #GP. So we need mask out
>>> those reserved bits from the data written to vICR register.
>> OK. One open is:
>>
>> Current KVM doesn't emulate this #GP. Is there any historical reason?
>> if no, we will fix KVM and add some tests to verify this #GP is
>> correctly emulated.
> It's a bug.  There are patches posted[*], but they need to be refreshed to fix a
> rebase goof.
>
> Venkatesh, are you planning on sending a v3 soonish?
>
> [*] https://lore.kernel.org/all/20220525173933.1611076-1-venkateshs@chromium.org

This patch set doesn't emulate hardware behavior precisely . Actually 
#GP will
happen only if any of reserved bit ( bit[31:20],bit[17:16],bit[13]) is 
1-setting
in x2apic mode. Other bits including bit[12] won't have any impact. For 
xapic
mode, it doesn't have this restriction.

