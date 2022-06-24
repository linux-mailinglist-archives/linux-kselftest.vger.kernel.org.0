Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6390E558FF3
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jun 2022 06:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiFXE2v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jun 2022 00:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXE2v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jun 2022 00:28:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98AE506CA;
        Thu, 23 Jun 2022 21:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656044929; x=1687580929;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QH5uBpNzzzCen9Zs76R2e80kGV9JSlE7H9DNbONwgs4=;
  b=kncBKnBQWDvYnUP21CL2lmooN/GD963maksO3YKeMrXKBbZG7kWojqWt
   pYt/b2QixyVheaJGdQQwWbMmw+rWRq18R2zfSbpQM5g9+awyyXECztAT2
   y2ZoXrxUp3zCeVIv+5VI78MY4+wCtakItWMIkh5f7FcGXpKolwwwfnsXK
   HYJbd2cS5FEjr005okUszBZbFx1KgEBomfEb0wJu/wZyyBK4e99AZlmEj
   VIlrOrq2tp1qZZP1hhXMPgD/dSrcg2hGTPdqxo+S+1x7LUlHGp/uXDKzY
   w6QRVz8QMW3BqL+X3GT0O+LbiKs014CItY4Kh1qJ/wuqo2XFvwEADvN9J
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="342607051"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="342607051"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:28:49 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="645095406"
Received: from zengguan-mobl1.ccr.corp.intel.com (HELO [10.255.31.117]) ([10.255.31.117])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:28:47 -0700
Message-ID: <fc6c4f6e-07c6-2d16-5457-dbe03ceb1bee@intel.com>
Date:   Fri, 24 Jun 2022 12:28:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] KVM: selftest: Enhance handling WRMSR ICR register in
 x2APIC mode
Content-Language: en-US
To:     "Gao, Chao" <chao.gao@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220623094511.26066-1-guang.zeng@intel.com>
 <20220623103314.GA14006@gao-cwp>
From:   Zeng Guang <guang.zeng@intel.com>
In-Reply-To: <20220623103314.GA14006@gao-cwp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 6/23/2022 6:33 PM, Gao, Chao wrote:
> On Thu, Jun 23, 2022 at 05:45:11PM +0800, Zeng Guang wrote:
>
>> +		ASSERT_EQ(icr & ~APIC_ICR_BUSY, val & ~APIC_ICR_BUSY);
> Probably add a comment for it would be better. E.g.,
>
> APIC_ICR_BUSY is removed and not used when CPU is in x2APIC mode.
> It is undefined whether write 1 to this bit will be preserved. So,
> even KVM keeps this bit cleared in some cases even in x2apic mode,
> no guarantee that hardware (specifically, CPU ucode when Intel IPI
> virtualization enabled) will clear the bit. So, skip checking this
> bit.
Hardware won't touch APIC_ICR_BUSY in x2apic mode. It totally depends on 
KVM to
clear it or not if set for test purpose. While in Intel IPI 
virtualization case,
KVM doesn't take care of this bit in vICR writes. So how about the 
comments as
below:

APIC_ICR_BUSY is removed and not used when CPU is in x2APIC mode.
KVM doesn't guarantee to clear this bit in some cases e.g. When
Intel IPI virtualization enabled, if it's set for test purpose.
So, skip checking this bit.

Thanks.
Zeng Guang

