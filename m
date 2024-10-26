Return-Path: <linux-kselftest+bounces-20758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D69699B165A
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 11:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E62281A54
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 09:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6887713A86C;
	Sat, 26 Oct 2024 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="ZodOO/jd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319DE217F5E;
	Sat, 26 Oct 2024 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729933214; cv=pass; b=r1aSDhAgaEv4RiVDOZhdAb/c4Mqaugq5gTCpMCUa+nYXcc7LNz/USzHWPi8ga8Phle88V9pDdBIGFfW7kTX/XP4kbI8wg/b9LO4mUxwKwNYaqzcpZcHG+rnJ9Uu8nTVV5VOckT5PsX0nGdTe2GaggL7uxFazmR3laAJTvT0ni+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729933214; c=relaxed/simple;
	bh=VlIBS+nNAy0HorlynnDWvaRjFKVn1RwXN1X51HKYC0Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hx91+s0f+5W8JCS39uneK5aH+RLsrG1cecwSnLp4wEm9hrGtK7ZveXgIsTmi6xr3hBWMGyLV4Pm1IlbJvfAPJXHbTeRYmGqkc8aaHAoYghbdjkZMNcdtp8dY6ehz1gJl0QDEFdQthNUK25UBW5jzsLOYGSkLtKOucZJULAEDYrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=ZodOO/jd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1729933195; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kKnaKO2JxRgMWsIUB10et49z4DbpraBF+I0s36LBaGtGH0Xx9hG+tlynPQKB7lkqQ/q/k73CbW5vPgax7JVCSU3Z539eiBg2SLAeUcLI3JAjLOxvv2FQHMx5mSt9Y0vCm5wxYgZQhUvtsPcyKPTRm3gp2cS/npt3TWYeze9ZSOo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729933195; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/ofsZ/KUtINNBgsOkZZ//zyk0Cpy+AIeNIQvPQNbkfU=; 
	b=j7AnVH8OBogh7HZqM0cK32zsGNk8AMqaJCBo2GY7ifFGPoIvSUAcFTHGHtLKTqJ7TOgxiusBpPIDhid+J/yR2lT78oVRauIYiABP9f4I2uHNpQfFVKFMpBgD7rOjXjoJJPY4/GA7Sb0aqJiDCmM+ZxyrnooaFTZqYLHdh6cbO7w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729933195;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/ofsZ/KUtINNBgsOkZZ//zyk0Cpy+AIeNIQvPQNbkfU=;
	b=ZodOO/jdQr/4X0ZpnwTcDD5thEcVtKpklIEZruRBbfRjFF6e4in1JNNNtlsszDSv
	c8FOAE/XjXTXjgtwhNkrEKUoo/+yYImp/9oCKeMshfhNZ5QwWgYNiuvooXw2bEMROu3
	Sv7mFcdN44dkoJUHG5ptVSB1EBgTQCzltNRu/qPU=
Received: by mx.zohomail.com with SMTPS id 1729933192542671.2786862049763;
	Sat, 26 Oct 2024 01:59:52 -0700 (PDT)
Message-ID: <491968e4-ced7-4ee1-a09e-477e30759d10@collabora.com>
Date: Sat, 26 Oct 2024 13:59:43 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, chao.p.peng@linux.intel.com,
 ackerleytng@google.com, seanjc@google.com, graf@amazon.com,
 jgowans@amazon.com
Subject: Re: [PATCH] kvm: selftest: fix noop test in guest_memfd_test.c
To: Patrick Roy <roypat@amazon.co.uk>, pbonzini@redhat.com, shuah@kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241024095956.3668818-1-roypat@amazon.co.uk>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241024095956.3668818-1-roypat@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/24/24 2:59 PM, Patrick Roy wrote:
> The loop in test_create_guest_memfd_invalid that is supposed to test
> that nothing is accepted as a valid flag to KVM_CREATE_GUEST_MEMFD was
> initializing `flag` as 0 instead of BIT(0). This caused the loop to
> immediately exit instead of iterating over BIT(0), BIT(1), ... .
> 
> Fixes: 8a89efd43423 ("KVM: selftests: Add basic selftest for guest_memfd()")
> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
> ---
>  tools/testing/selftests/kvm/guest_memfd_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
> index ba0c8e9960358..ce687f8d248fc 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -134,7 +134,7 @@ static void test_create_guest_memfd_invalid(struct kvm_vm *vm)
>  			    size);
>  	}
>  
> -	for (flag = 0; flag; flag <<= 1) {
> +	for (flag = BIT(0); flag; flag <<= 1) {
>  		fd = __vm_create_guest_memfd(vm, page_size, flag);
>  		TEST_ASSERT(fd == -1 && errno == EINVAL,
>  			    "guest_memfd() with flag '0x%lx' should fail with EINVAL",
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

-- 
BR,
Muhammad Usama Anjum


