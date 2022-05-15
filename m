Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECBD527715
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 May 2022 12:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbiEOKkH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 May 2022 06:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiEOKkG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 May 2022 06:40:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6871D32E;
        Sun, 15 May 2022 03:40:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16CDC60F27;
        Sun, 15 May 2022 10:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6653DC385B8;
        Sun, 15 May 2022 10:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652611203;
        bh=724eTmZLQCkMZqxbg8w9wSa28+2siNjvrzvYcImWISo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Civ013UXfcbnIinMDINQ7M8bBOYYfAhRF7mJRAwfxMO+4o1ffyMrSB3Zl2fq3hBV+
         B6CV+DN3eQ/tB9Hd2CeXKQlomZax+UIDWaLX3GV7P7rfcaeyDyiFeYItEpqFnbpBN2
         xvHmrw7/qGllgA47o8oMrLk4cBM9w5eYIT1pavMXkshzzFV3EQyywVi1aiq/im0+wD
         ff03HdK7mXgyLMKrpPd8pxGX16GJKqOPa+DsToLeLzYkfbF16WvcztcbNz7BfHv6lR
         xCFGVpdnV9QwtKVTIsdKHHW0K4ZoG7SMg18GS5uxqV+Xs4z0WIIf8yxnLN+G1i++k5
         W5kVd0c5OTj8Q==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nqBfM-00BPhw-Hy; Sun, 15 May 2022 11:40:00 +0100
MIME-Version: 1.0
Date:   Sun, 15 May 2022 11:40:00 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Oliver Upton <oupton@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: KVM: aarch64: Let hypercalls use UAPI
 *_BIT_COUNT
In-Reply-To: <688a817f-b2e2-4620-ef4b-f3c5f73ae34d@redhat.com>
References: <20220504184415.1905224-1-rananta@google.com>
 <YnLa8uH55/epyjlS@google.com> <87zgjw6v9k.wl-maz@kernel.org>
 <688a817f-b2e2-4620-ef4b-f3c5f73ae34d@redhat.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <3015731497c79a051779ce531155e5b5@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, oupton@google.com, rananta@google.com, drjones@redhat.com, james.morse@arm.com, alexandru.elisei@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, pshier@google.com, ricarkol@google.com, reijiw@google.com, jingzhangos@google.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022-05-05 14:32, Paolo Bonzini wrote:
> On 5/5/22 14:04, Marc Zyngier wrote:
>> diff --git a/arch/arm64/include/uapi/asm/kvm.h 
>> b/arch/arm64/include/uapi/asm/kvm.h
>> index e523bb6eac67..3cde9f958eee 100644
>> --- a/arch/arm64/include/uapi/asm/kvm.h
>> +++ b/arch/arm64/include/uapi/asm/kvm.h
>> @@ -342,6 +342,10 @@ struct kvm_arm_copy_mte_tags {
>>     enum {
>>   	KVM_REG_ARM_STD_BIT_TRNG_V1_0	= 0,
>> +	/*
>> +	 * KVM_REG_ARM_STD_BMAP_BIT_COUNT will vary as new services
>> +	 * are added, and is explicitely not part of the ABI.
>> +	 */
>>   	KVM_REG_ARM_STD_BMAP_BIT_COUNT,
>>   };
> 
> That seems like a bad idea.  Perhaps you can wrap it in #ifdef
> __KERNEL_OR_SELFTESTS__?  I can't find any prior art.

Yeah. I've dropped this patch and sprinkled a bunch of
'#ifdef __KERNEL__' instead. We can revisit this later,
or hack the test to temporarily define __KERNEL__, which
is just as bad...

         M.
-- 
Jazz is not dead. It just smells funny...
