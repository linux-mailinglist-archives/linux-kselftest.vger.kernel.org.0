Return-Path: <linux-kselftest+bounces-41326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F04B54B06
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 13:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D7F3AF82C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 11:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A922EE612;
	Fri, 12 Sep 2025 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MH9C2hqE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9784A2701C0
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676834; cv=none; b=IilZd44mvGtfVoUYvlecVyrXcBGmXAwfn9Q80BwbVNEXFs+xjX15uDIFRR7EvEKf55OwbFzQKzmR1IRnldiXNOi1NqRpH5sNzhlfS4p4kFIvUq02mj9G3a2fjDqhx1lrTK18k9ugkT/oCXKyN6ydk7wPXcQPaDTWdIizkh5xICg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676834; c=relaxed/simple;
	bh=XBHAModFzS9RT7TpF2/ykWjDQcNt9+bCE4YK2ZwUuV0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=rtwsR6nkdRNX2mu62IdTqak2j+LpHxMHsQHcY4ShtayQoKz19uxapSte1jVzX75CdT4wPLqZh/JHo61ITxLVLYNycCt0fHXC/CvYI7AQUblD9PP7bEPOAKzV4c0aF/AQZXVbKF1B5mJt38pMnxuO87Stw7eW5yvrFxjlBlvzrSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MH9C2hqE; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-323266d6f57so1925625a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 04:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757676832; x=1758281632; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Me3gQ2+XLChgmuRgGxhLuD7lEdljJYpRCmXxWniexUs=;
        b=MH9C2hqEnNTNu/TciRFE1ayLBu/2QhgDxOnC908dXHqhNJNxIYzEHsvpyJ8s6f8OL1
         lEE5eAdq2YdI5mUxtoo+VS/NuQJokgkNdAPVyXM/Wt5/YINrtvYvGQ/ozDn0j5Ky5rp6
         h61TX1v2V5hV7z7WjWYzUby6xrGAwJ3+QYFth5h2GIuJ0z+mGMoaBHbLnDZVeQ2W/1Bc
         lcPA+WkA7kMEuwrKteRAy9jAY2qq1iivUaa/KVVThTmDc2HZgApdBecuIlUgzY5bfHwW
         h8NladE/4KBqwXgFd1EjZfLfajJBkF4Sl5872VYr2+63wzlYMMCSOttQJ4ve9MRChJrC
         pPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757676832; x=1758281632;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Me3gQ2+XLChgmuRgGxhLuD7lEdljJYpRCmXxWniexUs=;
        b=xGrwkOBPOm7h9pzyzItHsyoHiPnEempjSFGkVL/w0ZC+V4cD0NiEeN0/kEyAZa83A1
         ZaZTeMw3Pp5pQWNVwIoci3r91/BPafGeQvSG9D3FvR/QGWigKfXK+dol/An/FuXrWhWY
         VRktM4KPAeAzJCNN0HdohmtqRqZ3TmrXsPJ541psUxfwS/1EeYZQMUhJVsZa/L6ZIaMe
         JcCO3w4HVbskWcapLuvJtRmdFgj3/3W5pQ6QLdF1JAIF6NKseiJBcqk2Z9uruZH2FE09
         rLb/3myaTmK4itp1c3PjdQxj8VDNUTa7HOTA3oivRbiXQRC8TwENWdM2lz+DGKQzPNJY
         BW3g==
X-Forwarded-Encrypted: i=1; AJvYcCUioGijxQJMWMxzc1ZOWTamE5mE7Q0BviB/t4tqtHtgo+Kjnk5fqRslQivAfFJeGMmZ6Jrv55Pke62v58+HcDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHPV25Wzz94M/okRe2k1VaFp6H8eROhZPLX8DxmpfITEHMD68s
	tZE12uLQJXB6BdAgqrESFqbVxpwECaBGQ3QJ11VEvrTre3ygygnqJegT
X-Gm-Gg: ASbGnculV+pj982r0ItGRcPTxxAwcBxTlNmhGiJI+eu0KL3xJ7ceuBn98Vw84CswMub
	XIpKjDVf4k08fCObgRlgXlXFbDggxjzKXk8grcYlyfBn5s767+8gcxT82KPC2Y5vEeDIiy8DfCU
	Q2jl434+UbOhvGIoRjJvOCJf8sSqIR16akCvfRaqregnXZalqkjl4txAk3f9FQDyv/IyPUX6Bin
	LNzZ/xUz+bpmEi1crVwSbyPTPTBsb007XpO8iaBbY1Mhztg4VB8WWmU8mdUwkQBkzM+WZS7N7kB
	BL1JKOFCByHYRYotKnr02uKx0olZRkIRTZo3noSyjq2MI3hLuIPY68n4x6oyv0aqDreP0fvSH8E
	BgizY3pdqcPevfaRxNeD4n63rIJtidsVAqaP882Ky9b3MQOC2cXLIB2SSeo9ln0sG5XXvcmp1Xa
	1HOJFZgYQ=
X-Google-Smtp-Source: AGHT+IG4CQOrsidgDKZqODfMcOoJgWe/C+OuZOd1ih4oVDYDwhAJqojGn09l0Bnkzu0cbpihXieC8w==
X-Received: by 2002:a17:90b:3889:b0:32d:5721:df96 with SMTP id 98e67ed59e1d1-32de4f808f5mr2582134a91.32.1757676831756;
        Fri, 12 Sep 2025 04:33:51 -0700 (PDT)
Received: from smtpclient.apple (p73a27f58.hyognt01.ap.so-net.ne.jp. [115.162.127.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd7ceecfasm2203933a91.7.2025.09.12.04.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 04:33:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Itaru Kitayama <itaru.kitayama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] PMCR_EL0.N is RAZ/WI. At least a build failes in Ubuntu 22.04 LTS. Remove the set function.
Date: Fri, 12 Sep 2025 20:33:39 +0900
Message-Id: <3FEB4D87-EEAF-4A21-BCBC-291A4A7C2230@gmail.com>
References: <867by4c4v1.wl-maz@kernel.org>
Cc: Itaru Kitayama <itaru.kitayama@linux.dev>,
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
 K Poulose Suzuki <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>
In-Reply-To: <867by4c4v1.wl-maz@kernel.org>
To: Marc Zyngier <maz@kernel.org>
X-Mailer: iPhone Mail (22G100)



> On Sep 12, 2025, at 20:01, Marc Zyngier <maz@kernel.org> wrote:
>=20
> =EF=BB=BFOn Fri, 12 Sep 2025 09:27:40 +0100,
> Itaru Kitayama <itaru.kitayama@linux.dev> wrote:
>>=20
>> Signed-off-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
>=20
> This isn't an acceptable commit message.
>=20
>> ---
>> Seen a build failure with old Ubuntu 22.04 LTS, while the latest release
>> has no build issue, a write to the bit fields is RAZ/WI, remove the
>> function.
>> ---
>> tools/testing/selftests/kvm/arm64/vpmu_counter_access.c | 6 ------
>> 1 file changed, 6 deletions(-)
>>=20
>> diff --git a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c b/to=
ols/testing/selftests/kvm/arm64/vpmu_counter_access.c
>> index f16b3b27e32ed7ca57481f27d689d47783aa0345..56214a4430be90b3e1d840f27=
19b22dd44f0b49b 100644
>> --- a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
>> +++ b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
>> @@ -45,11 +45,6 @@ static uint64_t get_pmcr_n(uint64_t pmcr)
>>    return FIELD_GET(ARMV8_PMU_PMCR_N, pmcr);
>> }
>>=20
>> -static void set_pmcr_n(uint64_t *pmcr, uint64_t pmcr_n)
>> -{
>> -    u64p_replace_bits((__u64 *) pmcr, pmcr_n, ARMV8_PMU_PMCR_N);
>> -}
>> -
>> static uint64_t get_counters_mask(uint64_t n)
>> {
>>    uint64_t mask =3D BIT(ARMV8_PMU_CYCLE_IDX);
>> @@ -490,7 +485,6 @@ static void test_create_vpmu_vm_with_pmcr_n(uint64_t p=
mcr_n, bool expect_fail)
>>     * Setting a larger value of PMCR.N should not modify the field, and
>>     * return a success.
>>     */
>> -    set_pmcr_n(&pmcr, pmcr_n);
>>    vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_PMCR_EL0), pmcr);
>>    pmcr =3D vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_PMCR_EL0));
>>=20
>>=20
>=20
> So what are you fixing here? A build failure? A semantic defect?
> Something else? What makes this a valid change?
>=20
> Frankly, I have no idea.
>=20
> But KVM definitely allows PMCR_EL0.N to be written from userspace, and
> that's not going to change.
>=20

Then I=E2=80=99ll drop this patch.

Thanks,
Itaru.

>    M.
>=20
> --
> Without deviation from the norm, progress is not possible.

