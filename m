Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C3F649CD6
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Dec 2022 11:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiLLKnx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Dec 2022 05:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiLLKlj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Dec 2022 05:41:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C110B4BA
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Dec 2022 02:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670841302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KFD4bXF9HfKCTB2bqwvpTx8dBPmnhTdXw6WlgJmCRVE=;
        b=DL7TV2Vw2lDnUZaurH+Mcneo4ZZYgueHH5sKzd24E/gcWlQ5Inf87CfYTcF9lxTt1cSdiq
        BFCc2PlxE8cou+nQlPyYzd5rq3ssdStNd2fGB4NHLG3mdA5U+0ssNenqxPj3PUdXgMKZhf
        b0tI7/I57ZzYOHohGuXPHPIsB+mfluw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-100-pXj-1tPWMrCh9bVC6ltwAA-1; Mon, 12 Dec 2022 05:34:59 -0500
X-MC-Unique: pXj-1tPWMrCh9bVC6ltwAA-1
Received: by mail-wm1-f72.google.com with SMTP id x10-20020a05600c420a00b003cfa33f2e7cso3174882wmh.2
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Dec 2022 02:34:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFD4bXF9HfKCTB2bqwvpTx8dBPmnhTdXw6WlgJmCRVE=;
        b=CpjAftFtzDvnduRxUON8RSu1rT/BfesBKo6ixXWqPUY3EURLRELA0yvkE72W3zfU77
         c9uG4ieojw+xBmtk1UQv2MsoxetRMqaUltECYRAO94xt9lxEVroC16Fwy64po7H8c+nu
         bTBtgZpF6DQMpcre3iFQfRZpefEtYhPQnvQZv9ZBU3l1Fz0UShFfdGp6os3fJvoCsyn+
         NNLd+eyxGVvbvNVOMcNamoxLsKGk436JphUGxqrVJ+k+MBenLXqjqoIfwLD86xy8VOaz
         voEcb60N3OEDTqoNYdEwfzkQ0f3WLRnEsXG/s00rbe9+ErAFpN4EJIw7CD1xV7ThtcVe
         yr6w==
X-Gm-Message-State: ANoB5plDHRuDn3gMgz4PzfUagkRmFJVeXgdTrW+7VzjfDfdeglEgw7XY
        FY5RAFiY1WvGwSg7wGf82oEGiZt1kYUYHVhdp9OXOBWIgrVC+UKQWxSALQKFecERyJI+UlG++TS
        c7+Th8qVtS4/w6uweMNYqk6LI5sKr
X-Received: by 2002:a5d:4888:0:b0:232:be5d:5ecc with SMTP id g8-20020a5d4888000000b00232be5d5eccmr9224033wrq.35.1670841298282;
        Mon, 12 Dec 2022 02:34:58 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7wvWIVuOKysZf5Mx8cCdDopdcGEnGqjatRwKG8EB36UeyRpqDFxHDI9VsIf8PVP5iD55AkPA==
X-Received: by 2002:a5d:4888:0:b0:232:be5d:5ecc with SMTP id g8-20020a5d4888000000b00232be5d5eccmr9224016wrq.35.1670841298004;
        Mon, 12 Dec 2022 02:34:58 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id bn1-20020a056000060100b00242269c8b8esm8603207wrb.25.2022.12.12.02.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 02:34:57 -0800 (PST)
Message-ID: <322454c7-0a3b-e055-2405-f485fa149e7a@redhat.com>
Date:   Mon, 12 Dec 2022 11:34:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 4/7] KVM: selftests: Correctly initialize the VA space
 for TTBR0_EL1
Content-Language: en-US
To:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        Ricardo Koller <ricarkol@google.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221209015307.1781352-1-oliver.upton@linux.dev>
 <20221209015307.1781352-5-oliver.upton@linux.dev>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221209015307.1781352-5-oliver.upton@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/9/22 02:53, Oliver Upton wrote:
> @@ -268,17 +305,17 @@ struct kvm_vm *____vm_create(enum vm_guest_mode mode)
>   #ifdef __aarch64__
>   	if (vm->pa_bits != 40)
>   		vm->type = KVM_VM_TYPE_ARM_IPA_SIZE(vm->pa_bits);
> +
> +	/* selftests use TTBR0 only, meaning there is a single VA region. */
> +	vm->has_split_va_space = false;
> +#else
> +	vm->has_split_va_space = true;
>   #endif
>   

Even though there happens to be already a suitable #ifdef, I don't
really like them and don't think there should be a new bool unless
something else uses it.

However, the new comment is very useful, so I added it to kvm_util.c as
follows:

/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 759a45540108..56d5ea949cbb 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -186,6 +186,15 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
  _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params) == NUM_VM_MODES,
  	       "Missing new mode params?");
  
+/*
+ * Initializes vm->vpages_valid to match the canonical VA space of the
+ * architecture.
+ *
+ * The default implementation is valid for architectures which split the
+ * range addressed by a single page table into a low and high region
+ * based on the MSB of the VA. On architectures with this behavior
+ * the VA region spans [0, 2^(va_bits - 1)), [-(2^(va_bits - 1), -1].
+ */
  __weak void vm_vaddr_populate_bitmap(struct kvm_vm *vm)
  {
  	sparsebit_set_num(vm->vpages_valid,

