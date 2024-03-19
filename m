Return-Path: <linux-kselftest+bounces-6437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F5F880684
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 22:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1788E1C21E4E
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 21:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386853CF73;
	Tue, 19 Mar 2024 21:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDJCz5Ty"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F483C47C
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Mar 2024 21:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882420; cv=none; b=XF2ttE7ZUHeQEX5YVvRQSiE/lXCcPGxEjfy7gVK0iXH2KH4rz057vfIlkJ3GGX6qc9Rb3fMOk9bZQrvd7DfsnhytqNOFZhRiEqYXw/7t8/w90TRoF8oHJ1B0/EBmfz882pSJPtBFSuPBvrsfvxAWDo5id7IME+2UOmuDT7f1xK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882420; c=relaxed/simple;
	bh=p3CVVv7j8KqfxO3Oc3YIg4XiUxGaF43J1xHbfkpZWUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQG0ibkwNtJmIIFPnhKDxpmmdiGxSC06lEu4WRp294kfoPhRaguqaPpCqoB2WovgmO3kW4wqvnnLQae/1AyUzbLBMZeY3rTeMLhJAY13c3EwaObfmV63bMkWYxuV6mVnq/zecxjgQW4Doe2MyBF6XVFEyD8m3R6DWcoFL8WLs3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VDJCz5Ty; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710882417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7qoGIHh6upwj5gPJ9J4YHu4wJ6ui1GNstsfCG9nUc0E=;
	b=VDJCz5Tynnr2Xh5kNuxMOSfalhvGJ3W3kd5n4gg5Km3HBNVuxmUL9xCIZbL3RNK2wd18hh
	eZioHpnHA9BfGYTcuxW3RbiFRFOIOKmxtcBe4CErce+MvpXFtM6mxgbPsCKzQRzafC/utK
	Pq2q+vQktK8NzqN5H7X8KGg5dkRas/g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-xqXSZVnPMPSWUHjf2nG6Iw-1; Tue, 19 Mar 2024 17:06:56 -0400
X-MC-Unique: xqXSZVnPMPSWUHjf2nG6Iw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33eb8721b64so3251735f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Mar 2024 14:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710882415; x=1711487215;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7qoGIHh6upwj5gPJ9J4YHu4wJ6ui1GNstsfCG9nUc0E=;
        b=XNLytDgc+xArCbArk4AvNOyTXtkjQKBCZ+Jn8VuJIx/x1MEdtn769Jv4Ud+EfNNop+
         gCM2AEI48BaxgwPRLHpCRmyXrWHDdA9Y+I8d6lKQ6T0pBLfvO1JfFNx2eQsY7o/HrP//
         jjyOOKtaYKcyrd6t9FSmNRfi963P/6rQoL2Nk5x2A5veWsY9PUniXydDDAaMRHlu0qgb
         h77he3xjF4oDzHfLF6lPpkhzfeoPLoFQxcMgJAxhWgmtCM/PItUiG9HwPc1j/dxZ2oTn
         JmHQlhgqpxELmFGJ5bQuookk7Ry9hKQzEX/JC9G8Fay77lCZqvY9Cz4WZ1O9hApZq3TY
         HNpw==
X-Forwarded-Encrypted: i=1; AJvYcCV3pwVrXtgyfiUYLWS2EXqW9O3GElx6e6fDsxGyQ5MsX60CxBxsIPlr06o+2I1h8KZHyBCZS1Mn3x8KBQHGKSbn3gD20fJIYTRmFWSxy2SB
X-Gm-Message-State: AOJu0Yw4B3VGN1rZvKJjVT6CDgJqJQiFn+t7mAK84qvm8mBeViwMJlFB
	e62sLZP2JKJAnLcFZGKRHPwf8bS07Dgv/GPyEwOdNV4cHDKbCCBXZCKFi2QRvvOHikgZrDxFiDX
	DSVVVXTCoM17iBtbnUl3FdB4Q73/ZCqxSgjUjk2JRcNJKg+xQqAeSZM6YaRxUrZfh6Q==
X-Received: by 2002:a05:6000:18c5:b0:33e:d865:422 with SMTP id w5-20020a05600018c500b0033ed8650422mr2390556wrq.29.1710882414865;
        Tue, 19 Mar 2024 14:06:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYgibdY4jILLn+6ByyeP7Lg3sS+wv/bar0zDxWizyxRfyam0sxSD5OLYa520B4VKgbg/WBtw==
X-Received: by 2002:a05:6000:18c5:b0:33e:d865:422 with SMTP id w5-20020a05600018c500b0033ed8650422mr2390545wrq.29.1710882414365;
        Tue, 19 Mar 2024 14:06:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d6608000000b0033e45930f35sm13213779wru.6.2024.03.19.14.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 14:06:53 -0700 (PDT)
Message-ID: <a60e1025-f093-4285-9d27-dab48bb64bcd@redhat.com>
Date: Tue, 19 Mar 2024 22:06:50 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] KVM: selftests: aarch64: Add invalid filter test
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
References: <20240229065625.114207-1-shahuang@redhat.com>
 <20240229065625.114207-4-shahuang@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240229065625.114207-4-shahuang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/29/24 07:56, Shaoqin Huang wrote:
> Add the invalid filter test which sets the filter beyond the event
> space and sets the invalid action to double check if the
> KVM_ARM_VCPU_PMU_V3_FILTER will return the expected error.
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  .../kvm/aarch64/pmu_event_filter_test.c       | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
> index 2dd8ea418f47..86714345ee97 100644
> --- a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
> +++ b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
> @@ -8,6 +8,7 @@
>   * This test checks if the guest only see the limited pmu event that userspace
>   * sets, if the guest can use those events which user allow, and if the guest
>   * can't use those events which user deny.
> + * It also checks that setting invalid filter ranges return the expected error.
>   * This test runs only when KVM_CAP_ARM_PMU_V3, KVM_ARM_VCPU_PMU_V3_FILTER
>   * is supported on the host.
>   */
> @@ -262,6 +263,41 @@ static void run_tests(void)
>  		run_test(t);
>  }
>  
> +static void test_invalid_filter(void)
> +{
> +	struct kvm_pmu_event_filter invalid;
> +	int ret;
> +
> +	pr_info("Test: test_invalid_filter\n");
> +
> +	memset(&vpmu_vm, 0, sizeof(vpmu_vm));
> +
> +	vpmu_vm.vm = vm_create(1);
> +	vpmu_vm.vcpu = vm_vcpu_add_with_vpmu(vpmu_vm.vm, 0, guest_code);
> +	vpmu_vm.gic_fd = vgic_v3_setup(vpmu_vm.vm, 1, 64,
> +					GICD_BASE_GPA, GICR_BASE_GPA);
> +	__TEST_REQUIRE(vpmu_vm.gic_fd >= 0,
> +		       "Failed to create vgic-v3, skipping");
> +
> +	/* The max event number is (1 << 16), set a range largeer than it. */the event space is 16b on ARMv8.1 and 10b on ARMv8.0, set a range larger
than 16
s/largeer/larger
> +	invalid = __DEFINE_FILTER(BIT(15), BIT(15) + 1, 0);
> +	ret = __kvm_device_attr_set(vpmu_vm.vcpu->fd, KVM_ARM_VCPU_PMU_V3_CTRL,
> +				    KVM_ARM_VCPU_PMU_V3_FILTER, &invalid);
> +	TEST_ASSERT(ret && errno == EINVAL, "Set Invalid filter range "
> +		    "ret = %d, errno = %d (expected ret = -1, errno = EINVAL)",
> +		    ret, errno);
> +
> +	/* Set the Invalid action. */
s/the/an
> +	invalid = __DEFINE_FILTER(0, 1, 3);
> +	ret = __kvm_device_attr_set(vpmu_vm.vcpu->fd, KVM_ARM_VCPU_PMU_V3_CTRL,
> +				    KVM_ARM_VCPU_PMU_V3_FILTER, &invalid);
> +	TEST_ASSERT(ret && errno == EINVAL, "Set Invalid filter action "
> +		    "ret = %d, errno = %d (expected ret = -1, errno = EINVAL)",
> +		    ret, errno);
> +
> +	destroy_vpmu_vm();
> +}
> +
>  static bool kvm_pmu_support_events(void)
>  {
>  	create_vpmu_vm(guest_get_pmceid);
> @@ -284,4 +320,6 @@ int main(void)
>  	TEST_REQUIRE(kvm_pmu_support_events());
>  
>  	run_tests();
> +
> +	test_invalid_filter();
>  }
Besides Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


