Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67303559284
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jun 2022 07:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiFXFtF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jun 2022 01:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiFXFtD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jun 2022 01:49:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FBA50B1E;
        Thu, 23 Jun 2022 22:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656049742; x=1687585742;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9HfUsBq3ow5/28zKvcKy8jGmFbJ1EBnpo+WJYBmHK3E=;
  b=TRKPcgL4WZ5Fn+zHiZoylruNUsT3k/iTYFHrE5GYVX7MeooompF3TNPS
   v426j1cls49hXdkd4VssTdkEFww9U+YgLdStGU0HDgYV+xD+Gk1ej5odT
   4KWBL7AG3xV/L075JUy2U6aUH4bwsmCKHqIAojGgCLxOtRT+UmVWdZ+Bf
   PlCLeQ2CTF3e5jbmbHRy3feVPFQKH/BljnWUCq7GusvgmKxt2an9mnHYY
   X0Yhb1MYF6W4A2Nc4fFIj5xzGmJKytEyYHN0NwvX+0eVe5ftsp5W7Y4BM
   j9vR9Adj4k2mMGuyFX6ajPSwumTqqbpcrIiqOPsiZkfFc0PK5HL4jOjkE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="280972593"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="280972593"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 22:49:02 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="593072503"
Received: from gao-cwp.sh.intel.com (HELO gao-cwp) ([10.239.159.23])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 22:49:00 -0700
Date:   Fri, 24 Jun 2022 13:48:46 +0800
From:   Chao Gao <chao.gao@intel.com>
To:     Zeng Guang <guang.zeng@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] KVM: selftest: Enhance handling WRMSR ICR register in
 x2APIC mode
Message-ID: <20220624054840.GA26311@gao-cwp>
References: <20220623094511.26066-1-guang.zeng@intel.com>
 <20220623103314.GA14006@gao-cwp>
 <fc6c4f6e-07c6-2d16-5457-dbe03ceb1bee@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc6c4f6e-07c6-2d16-5457-dbe03ceb1bee@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 24, 2022 at 12:28:38PM +0800, Zeng Guang wrote:
>
>On 6/23/2022 6:33 PM, Gao, Chao wrote:
>> On Thu, Jun 23, 2022 at 05:45:11PM +0800, Zeng Guang wrote:
>> 
>> > +		ASSERT_EQ(icr & ~APIC_ICR_BUSY, val & ~APIC_ICR_BUSY);
>> Probably add a comment for it would be better. E.g.,
>> 
>> APIC_ICR_BUSY is removed and not used when CPU is in x2APIC mode.
>> It is undefined whether write 1 to this bit will be preserved. So,
>> even KVM keeps this bit cleared in some cases even in x2apic mode,
>> no guarantee that hardware (specifically, CPU ucode when Intel IPI
>> virtualization enabled) will clear the bit. So, skip checking this
>> bit.
>Hardware won't touch APIC_ICR_BUSY in x2apic mode.

IMO, SDM doesn't say how the processor deals with this bit in x2apic
mode. Even if SPR behaves like this, the behavior isn't architectural.
Otherwise, KVM shouldn't touch this bit and we can add a test to verify
that the bit won't be changed by CPU (or KVM) in x2apic mode.

>It totally depends on KVM to clear it or not if set for test purpose.
>While in Intel IPI virtualization case, KVM doesn't take care of this
>bit in vICR writes.

I don't think KVM behavior is the key problem here. If an IPI is
virtualized by ucode, KVM isn't involved in processing the IPI.
It means KVM has no chance to clear the APIC_ICR_BUSY bit.
