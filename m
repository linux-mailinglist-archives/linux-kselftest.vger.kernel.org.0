Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF2B149429
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2020 10:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgAYJeV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Jan 2020 04:34:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51578 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725710AbgAYJeV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Jan 2020 04:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579944860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=799m6qKMV18ggbdbpJL4lidbUmQPUZ2uqN90WWxnXDE=;
        b=S5AEux1EhbcpuBAEHkgWWnOXSjZ1S6Vgq5x6b/i0bLkzzHismxg6iPkPgUs3dCMMXUPny1
        NKrAfJ3cQcqCBZ6FDEZ1tAZ4bV5mPRkyfqRT+wYTNjRwKyaTEJhRZGRlanxwukeJGQpG4c
        M2QQ+Y6N6RDHxf3pUOTx4+fWglN9pdE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-SwNAjOGDMqCQpeiIl0vtYQ-1; Sat, 25 Jan 2020 04:34:18 -0500
X-MC-Unique: SwNAjOGDMqCQpeiIl0vtYQ-1
Received: by mail-wr1-f71.google.com with SMTP id i9so2763350wru.1
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Jan 2020 01:34:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=799m6qKMV18ggbdbpJL4lidbUmQPUZ2uqN90WWxnXDE=;
        b=hLa9l3RNjgeWunGVR1DCbON7hwX2p+Fb7dkpTP5pxA48rVyu5dtcgsrENmK2VnuUnx
         QvUoESfwp4YXyak2LMc0zlEVHg7Cl55is+SvX83MQggUwliLvhJV33d9d5fOP+yX5Z1f
         sHfu7jAeBClYWpZzV6oPcpf6Cuv4TUC4/hIsq0y1Z1eYRsQDD8Km7eRhVOgikXbeAse+
         o4Hqdes86R6+CGaLTC450s5zg8nzvODALrTe0VBbk7Z7yPJ5P5kyvKN8zZrWWu1gCFWX
         ZYLwGQEV75Yp3eOzGop8pZY/WjZhTiqusu2xpQ1YejXAI87ua/A9TZ/LpsgoheSEekK6
         dcGg==
X-Gm-Message-State: APjAAAXx3/qmcEa3JBhq7ilrdsxgaBOZenR8wlJP/R80F+7zcYDnfeXx
        pd/KrsH8q8FVn/kycozdeD2s3Wj974KhFNDCczT2B03yA2rm47ay419j1VtFFhekIEhAFMZG4OM
        O+XJjuaajduIGU3N247BIn28iNt4B
X-Received: by 2002:adf:f308:: with SMTP id i8mr9489196wro.42.1579944857316;
        Sat, 25 Jan 2020 01:34:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqzV+U0Zk/vBr3PYTOy2NS/UOEJyzbyAI9oNA0HJiFpizgJq7/yGvYaD+zj50Eu2svel6qBslw==
X-Received: by 2002:adf:f308:: with SMTP id i8mr9489175wro.42.1579944857009;
        Sat, 25 Jan 2020 01:34:17 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id f16sm11253860wrm.65.2020.01.25.01.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2020 01:34:16 -0800 (PST)
Subject: Re: [PATCH v4 06/10] KVM: selftests: Add support for vcpu_args_set to
 aarch64 and s390x
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>
References: <20200123180436.99487-1-bgardon@google.com>
 <20200123180436.99487-7-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6061cd22-59bb-c191-bd98-f14d7cd274ae@redhat.com>
Date:   Sat, 25 Jan 2020 10:34:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200123180436.99487-7-bgardon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23/01/20 19:04, Ben Gardon wrote:
> Currently vcpu_args_set is only implemented for x86. This makes writing
> tests with multiple vCPUs difficult as each guest vCPU must either a.)
> do the same thing or b.) derive some kind of unique token from it's
> registers or the architecture. To simplify the process of writing tests
> with multiple vCPUs for s390 and aarch64, add set args functions for
> those architectures.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  .../selftests/kvm/lib/aarch64/processor.c     | 33 +++++++++++++++++
>  .../selftests/kvm/lib/s390x/processor.c       | 35 +++++++++++++++++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> index 86036a59a668e..a2ff90a75f326 100644
> --- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> @@ -333,3 +333,36 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
>  {
>  	aarch64_vcpu_add_default(vm, vcpuid, NULL, guest_code);
>  }
> +
> +/* VM VCPU Args Set
> + *
> + * Input Args:
> + *   vm - Virtual Machine
> + *   vcpuid - VCPU ID
> + *   num - number of arguments
> + *   ... - arguments, each of type uint64_t
> + *
> + * Output Args: None
> + *
> + * Return: None
> + *
> + * Sets the first num function input arguments to the values
> + * given as variable args.  Each of the variable args is expected to
> + * be of type uint64_t. The registers set by this function are r0-r7.
> + */
> +void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
> +{
> +	va_list ap;
> +
> +	TEST_ASSERT(num >= 1 && num <= 8, "Unsupported number of args,\n"
> +		    "  num: %u\n",
> +		    num);
> +
> +	va_start(ap, num);
> +
> +	for (i = 0; i < num; i++)
> +		set_reg(vm, vcpuid, ARM64_CORE_REG(regs.regs[num]),
> +			va_arg(ap, uint64_t));
> +
> +	va_end(ap);
> +}
> diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
> index 32a02360b1eb0..680f37be9dbc9 100644
> --- a/tools/testing/selftests/kvm/lib/s390x/processor.c
> +++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
> @@ -269,6 +269,41 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
>  	run->psw_addr = (uintptr_t)guest_code;
>  }
>  
> +/* VM VCPU Args Set
> + *
> + * Input Args:
> + *   vm - Virtual Machine
> + *   vcpuid - VCPU ID
> + *   num - number of arguments
> + *   ... - arguments, each of type uint64_t
> + *
> + * Output Args: None
> + *
> + * Return: None
> + *
> + * Sets the first num function input arguments to the values
> + * given as variable args.  Each of the variable args is expected to
> + * be of type uint64_t. The registers set by this function are r2-r6.
> + */
> +void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
> +{
> +	va_list ap;
> +	struct kvm_regs regs;
> +
> +	TEST_ASSERT(num >= 1 && num <= 5, "Unsupported number of args,\n"
> +		    "  num: %u\n",
> +		    num);
> +
> +	va_start(ap, num);
> +	vcpu_regs_get(vm, vcpuid, &regs);
> +
> +	for (i = 0; i < num; i++)
> +		regs.gprs[i + 2] = va_arg(ap, uint64_t);
> +
> +	vcpu_regs_set(vm, vcpuid, &regs);
> +	va_end(ap);
> +}
> +
>  void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t indent)
>  {
>  	struct vcpu *vcpu = vm->vcpu_head;
> 

Squashing this:

diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index a2ff90a75f32..839a76c96f01 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -353,6 +353,7 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
 void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
 {
 	va_list ap;
+	int i;
 
 	TEST_ASSERT(num >= 1 && num <= 8, "Unsupported number of args,\n"
 		    "  num: %u\n",
diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
index 680f37be9dbc..a0b84235c848 100644
--- a/tools/testing/selftests/kvm/lib/s390x/processor.c
+++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
@@ -289,6 +289,7 @@ void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
 {
 	va_list ap;
 	struct kvm_regs regs;
+	int i;
 
 	TEST_ASSERT(num >= 1 && num <= 5, "Unsupported number of args,\n"
 		    "  num: %u\n",

Paolo

