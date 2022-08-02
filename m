Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C7E5884B1
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Aug 2022 01:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbiHBXIg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Aug 2022 19:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbiHBXIT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Aug 2022 19:08:19 -0400
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [IPv6:2a0c:5a00:149::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BEC56B91;
        Tue,  2 Aug 2022 16:08:04 -0700 (PDT)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mhal@rbox.co>)
        id 1oJ0zX-00FE56-Tu; Wed, 03 Aug 2022 01:07:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
        s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
        Cc:To:Subject:From:MIME-Version:Date:Message-ID;
        bh=x49fAc268tlpuw1XluflDWncJ+4FstdBuY+I7rVJPPM=; b=o7cSUUuv2zKE4ad7W/HVjS26VR
        s7m/rQOYHv2cbOmw0L/W6fxjJm/p5b4pvMESow57E7AgOcMpDy9omlhU1jnrdsLODO/QRC6HDGvxi
        FO6oP69ke7VnDpcKJMChw/o4zeLpUbtVFmxw4Y5/Pa0rRh9/MKrMDsIAXCFgSISTB61Y+MYDXioxV
        wdlogPzUZvzSopDjkQkYmMLNUSqRcR32VSJhvqhmhcfpf0DpZ+5Tk7PSD8DQhs9H4KQ8AsvN5FYRa
        FdTorJIJ1uhQywY1hLlubUz1Ky5HR0dTBo6mpb9aVDxqwRlz4kuiwLodAYGEWQs37chJQImdkYzKK
        hgJ2K7MQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <mhal@rbox.co>)
        id 1oJ0zX-00028W-Hf; Wed, 03 Aug 2022 01:07:59 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1oJ0zP-0006qc-BD; Wed, 03 Aug 2022 01:07:51 +0200
Message-ID: <c2001bfa-7602-e99a-dc41-1d9d993581ac@rbox.co>
Date:   Wed, 3 Aug 2022 01:07:50 +0200
MIME-Version: 1.0
User-Agent: Thunderbird
From:   Michal Luczaj <mhal@rbox.co>
Subject: Re: [kvm-unit-tests PATCH v2] x86: Test illegal LEA handling
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
References: <YuQQiv862oWDpgt5@google.com> <20220731204653.2516-1-mhal@rbox.co>
 <YugC4rUvdbroNk3M@google.com>
Content-Language: pl-PL
In-Reply-To: <YugC4rUvdbroNk3M@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/1/22 18:44, Sean Christopherson wrote:
> On Sun, Jul 31, 2022, Michal Luczaj wrote:
>> +{
>> +	exceptions = 0;
>> +	handle_exception(UD_VECTOR, illegal_lea_handler);
> 
> No need to use a custom handler (ignore any patterns in emulator.c that suggest
> it's "mandatory", emulator is one of the oldest test).  ASM_TRY() can handle all
> of this without any globals.
> ...
> static void test_illegal_lea(void)
> {
> 	unsigned int vector;
> 
> 	asm volatile (ASM_TRY("1f")
> 		      KVM_FEP ".byte 0x8d; .byte 0xc0\n\t"
> 		      "1:"
> 		      : : : "memory", "eax");
> 
> 	vector = exception_vector();
> 	report(vector == UD_VECTOR,
> 	       "Wanted #UD on LEA with /reg, got vector = %d", vector);
> }

I must be missing something important. There is
`handle_exception(UD_VECTOR, 0)` early in `main()` which simply undoes
`handle_exception(6, check_exception_table)` set by `setup_idt()`. If
there's no more exception table walk for #UD, `ASM_TRY` alone can't
possibly work, am I corrent?

If so, am I supposed to restore the `check_exception_table()` handler? Or
maybe using `test_for_exception()` would be more elegant:

static void illegal_lea(void *unused)
{
	asm volatile(KVM_FEP ".byte 0x8d, 0xc0" : : : "memory", "eax");
}

static void test_illegal_lea(void)
{
	bool fault;

	fault = test_for_exception(UD_VECTOR, &illegal_lea, NULL);
	report(fault, "Wanted #UD on LEA with /reg");
}

Thanks for hints,
Michal
