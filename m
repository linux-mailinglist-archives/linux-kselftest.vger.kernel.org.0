Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EF0364050
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Apr 2021 13:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbhDSLTE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Apr 2021 07:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55056 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234502AbhDSLTB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Apr 2021 07:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618831111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WCzp3qZIdr4u0FyN9JADLtQu47gdCQ0CxNrxY5TVo9Q=;
        b=hqH5z56A+2KAdcG0ulL8wAr6i+LU9GQxwyulGAD2m9k/c4kK0Rn58ugRuSfoAAGXvmj1vI
        FmZyCj265NKhxQ+RWn1NEnIIlB+WJAZMoRYMl3UMO3NdY1u4nvEb3e1BlYshUJ0YJuWwfy
        BhWO8TjSMIElIeRDVHxRc8gPlbFrSeY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-W0R_8vsyN--X9tmVmUZNkQ-1; Mon, 19 Apr 2021 07:18:29 -0400
X-MC-Unique: W0R_8vsyN--X9tmVmUZNkQ-1
Received: by mail-ed1-f72.google.com with SMTP id bf25-20020a0564021a59b0290385169cebf8so3589499edb.8
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Apr 2021 04:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WCzp3qZIdr4u0FyN9JADLtQu47gdCQ0CxNrxY5TVo9Q=;
        b=Doer/eYWbhUmss0Bi5hjsNYvKG7mUT+gHwhAr8dnJo44SW/W4yE3b98yqzptZCH7ij
         aj8OLkXd5Gym1ZzNuOuzw5eOs9Xz4ZTLhPacfHgOS+hf1jhU5DUXweFKHeC0fpAetTGJ
         LQ32JwaR7hRNz0As/YNBcX72uDmTPkVN4vbzVjsWao17qDBgPRtiTxK/6IiMPzdBWhle
         90BGP4RzBhQPLOL/VURtTQ/Y5xN7nyGAV26ovJOj9OCajonSiJdWLVNVBvrEbDl4rY2n
         LFWgNH6TBlhQzLOKQCzuKBvIg7JPKbyQvtSSShF2heYYHX+HV0+3CH1LfbQm3vtMKJbn
         2xYQ==
X-Gm-Message-State: AOAM53130/XMYx4OOZHGvdEkZttvJOuT+a1acWifoTm2Wzh4ZdEwRxLz
        wLPB7VsFYXAFcuGSc/BMJIKuh4VgisBye4Pongr9OWBCDHAeVB5j3Fh1Nizx619zpUHgmTkPuNn
        qTEQg+wNbs0fCYAIhd4CouPjqCuGk
X-Received: by 2002:a17:906:1d0e:: with SMTP id n14mr21657018ejh.97.1618831108547;
        Mon, 19 Apr 2021 04:18:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqu63LOpqckc/b1y9M3cEHioz8UWECwAeoDEKHsVXD1WCUxtmmwnesWctc6sXbp3BngiuQvA==
X-Received: by 2002:a17:906:1d0e:: with SMTP id n14mr21656990ejh.97.1618831108376;
        Mon, 19 Apr 2021 04:18:28 -0700 (PDT)
Received: from localhost.localdomain ([194.230.155.160])
        by smtp.gmail.com with ESMTPSA id ck29sm12468881edb.47.2021.04.19.04.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 04:18:27 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] KVM: selftests: Add selftest for KVM statistics
 data binary interface
To:     Jing Zhang <jingzhangos@google.com>, KVM <kvm@vger.kernel.org>,
        KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>
References: <20210415151741.1607806-1-jingzhangos@google.com>
 <20210415151741.1607806-5-jingzhangos@google.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
Message-ID: <9f2a8873-c2c2-ec84-58b4-7c90c59d1d25@redhat.com>
Date:   Mon, 19 Apr 2021 13:18:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210415151741.1607806-5-jingzhangos@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jing,

> +int vm_stats_test(struct kvm_vm *vm)
> +{
> +	ssize_t ret;
> +	int i, stats_fd, err = -1;
> +	size_t size_desc, size_data = 0;
> +	struct kvm_stats_header header;
> +	struct kvm_stats_desc *stats_desc, *pdesc;
> +	struct kvm_vm_stats_data *stats_data;
> +
> +	// Get fd for VM stats

Another small nitpick: comments should go in /* */ format

Thank you,
Emanuele

