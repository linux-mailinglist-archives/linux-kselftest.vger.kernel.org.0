Return-Path: <linux-kselftest+bounces-4808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB15856CA3
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 19:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2211F238FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 18:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7221386C5;
	Thu, 15 Feb 2024 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2CQDc5t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDB31386C2
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Feb 2024 18:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021649; cv=none; b=r2N6p+DCx3Dp9iKt9JlNxuHd/tFQ2Is3CMK/uzF38QiG988ZnS9lBHK/4iGPI6kWIn5Uq6S5sH5VY0U4O8Y1w2XPLDB2kiXUx9jklc5ijo4O0+01NqDbyJT7KVVOV0ORH3uFZlh66VAzuPEJOX552l+RVMxnFt3pUfUqk/UwoLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021649; c=relaxed/simple;
	bh=2wCnvjkhvn5BKoVcdNdw7iQW17hpGsSpN4YYTCOKtus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fiD9a+Rxt14ycrDdR2VorHaMbwgG6z7WOTwmZO5ECpkHDgUhRGsTPPfzr64TmuVGIMnQEn7CRWcWoWSY4ylfyJ5Gcue/F3x9ZCfdkzoE6QoWSWykMNErdAkholARneroQTpoVY2nmD8SsEmqSl4T8R6BQ7Ldw+kl03QJKb23ffI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T2CQDc5t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708021647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5rcuei6vVHQzEyNnihSudUV2QF1nleva1UrlbPjP+8U=;
	b=T2CQDc5tUuG5HTg4mjH4gr/uWHtmVEOHskSzQQbBvSD+OKF+tJwkvKrZ5ChbCLZgaxGACU
	C5CBy9X5uRfe8rI8kq7ng6rSzl2iFqFklmOahRIUYjJq+g775cpDiWhPCcOi6fTy/dVJUR
	lj0MHTa+isHf8+Quzz7+srJrcalBSg4=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-f67QIAD8MTaTdNsxGm1T6w-1; Thu, 15 Feb 2024 13:27:25 -0500
X-MC-Unique: f67QIAD8MTaTdNsxGm1T6w-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3bfd890774eso1096189b6e.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Feb 2024 10:27:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708021645; x=1708626445;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rcuei6vVHQzEyNnihSudUV2QF1nleva1UrlbPjP+8U=;
        b=eychF/zt3imGWXxrqTWu6PTYtrxqbD5xpKBPqyEFV61VL4xX0ERskG9Q10pnJj/JoY
         bH+5frn3AHRqx4oebx4L22nIWn63f7kR8ooNq8XhPKxJaNxNh6Aco9tEY1/I1X8sy6Fk
         CCZANvwZPo1gTYEJWw6FZS5ElYGd7wKz8cXtUGblRbDhMm4ufgM1JkXCiWhXE3bvD344
         WBePEVq8aLBPAPDNK5RLX2XsCpvrJ7k7byDedHRNYNYQJOKDXs7ddlgC+KaljeEVCEoG
         K1uEBBNgz7Jtw0YoVR7+qxmtrBeeiC4Sbut8IfZTe1VnvXsr4XJr3kiNThQhHxRkScNJ
         h4YA==
X-Forwarded-Encrypted: i=1; AJvYcCW9rlFyaFaFUEqNvJN28PNr/Cr26aIoBuaEhvtIZloJJ9z8Pd66xdUgEnMEGtiFmSWo56cxqYYms+pefcTEm07gRSptKKl6QzooXeIiRhUX
X-Gm-Message-State: AOJu0Yzv5Pn9kqvn4kDFaAF1ougXVPdkbJiuEDxNCdk0R+rFLs1D055g
	af0RfOoXazoMce6lOCclGeN8ogzA7N2Cb1OVYsdMi2H07PtqgTNNPIq8qKL0usd9D8v2ZRDuhuu
	89UBKsWhxklTMq6QFPBUWFf1UXUfEWXz9ut1dwfc6XnXzimdjEkokoU0jtUaZc6PW7Q==
X-Received: by 2002:aca:1204:0:b0:3c0:4056:a2ed with SMTP id 4-20020aca1204000000b003c04056a2edmr2420200ois.52.1708021644918;
        Thu, 15 Feb 2024 10:27:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZKI2Y5bw/n2gWg9WROC85Pjasnt5QCGU2b+OlWiTw1ItcyAVVMjpne9JYAbwflkR7xSrc1g==
X-Received: by 2002:aca:1204:0:b0:3c0:4056:a2ed with SMTP id 4-20020aca1204000000b003c04056a2edmr2420190ois.52.1708021644653;
        Thu, 15 Feb 2024 10:27:24 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id q15-20020a05622a030f00b0042c7f028606sm795543qtw.32.2024.02.15.10.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 10:27:24 -0800 (PST)
Message-ID: <94ae4343-487a-4782-8b15-6f1201eed882@redhat.com>
Date: Thu, 15 Feb 2024 19:27:20 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] KVM: selftests: aarch64: Add invalid filter test
 in pmu_event_filter_test
Content-Language: en-US
To: Shaoqin Huang <shahuang@redhat.com>, Oliver Upton
 <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>,
 kvmarm@lists.linux.dev
Cc: James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240202025659.5065-1-shahuang@redhat.com>
 <20240202025659.5065-6-shahuang@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240202025659.5065-6-shahuang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shaoqin,

On 2/2/24 03:56, Shaoqin Huang wrote:
> Add the invalid filter test includes sets the filter beyond the event
s/includes/which
> space and sets the invalid action to double check if the
> KVM_ARM_VCPU_PMU_V3_FILTER will return the expected error.
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  .../kvm/aarch64/pmu_event_filter_test.c       | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
> index d280382f362f..68e1f2003312 100644
> --- a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
> +++ b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
> @@ -7,6 +7,7 @@
>   * This test checks if the guest only see the limited pmu event that userspace
>   * sets, if the guest can use those events which user allow, and if the guest
>   * can't use those events which user deny.
> + * It also checks that setting invalid filter ranges return the expected error.
>   * This test runs only when KVM_CAP_ARM_PMU_V3, KVM_ARM_VCPU_PMU_V3_FILTER
>   * is supported on the host.
>   */
> @@ -183,6 +184,39 @@ static void for_each_test(void)
>  		run_test(t);
>  }
>  
> +static void set_invalid_filter(struct vpmu_vm *vm, void *arg)
> +{
> +	struct kvm_pmu_event_filter invalid;
> +	struct kvm_device_attr attr = {
> +		.group	= KVM_ARM_VCPU_PMU_V3_CTRL,
> +		.attr	= KVM_ARM_VCPU_PMU_V3_FILTER,
> +		.addr	= (uint64_t)&invalid,
> +	};
> +	int ret = 0;
> +
> +	/* The max event number is (1 << 16), set a range largeer than it. */
in  practice it is 16b on ARMv8.1 and 10b on ARMv8.0 but obvioulsy the
check below works for both ;-)

larger typ
> +	invalid = __DEFINE_FILTER(BIT(15), BIT(15)+1, 0);
space between "+"
> +	ret = __vcpu_ioctl(vm->vcpu, KVM_SET_DEVICE_ATTR, &attr);
kvm_device_attr_set() as commented by Oliver
> +	TEST_ASSERT(ret && errno == EINVAL, "Set Invalid filter range "
> +		    "ret = %d, errno = %d (expected ret = -1, errno = EINVAL)",
> +		    ret, errno);
> +
> +	ret = 0;
> +
> +	/* Set the Invalid action. */
> +	invalid = __DEFINE_FILTER(0, 1, 3);
> +	ret = __vcpu_ioctl(vm->vcpu, KVM_SET_DEVICE_ATTR, &attr);
> +	TEST_ASSERT(ret && errno == EINVAL, "Set Invalid filter action "
> +		    "ret = %d, errno = %d (expected ret = -1, errno = EINVAL)",
> +		    ret, errno);
> +}
> +
> +static void test_invalid_filter(void)
> +{
> +	vpmu_vm = __create_vpmu_vm(guest_code, set_invalid_filter, NULL);
> +	destroy_vpmu_vm(vpmu_vm);
> +}
> +
>  static bool kvm_supports_pmu_event_filter(void)
>  {
>  	int r;
> @@ -216,4 +250,6 @@ int main(void)
>  	TEST_REQUIRE(host_pmu_supports_events());
>  
>  	for_each_test();
> +
> +	test_invalid_filter();
>  }
Thanks

Eric


