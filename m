Return-Path: <linux-kselftest+bounces-10477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133208CAE9A
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 14:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1D51C21B7D
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 12:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A3C74E0A;
	Tue, 21 May 2024 12:52:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F83B770EE;
	Tue, 21 May 2024 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716295949; cv=none; b=cCAfpS69msKtyimylnwmCe9EMlpMOJi/nY1g9+Dq7oSki4XZv77Er1ny1PkR5NhQ77Kr+/TuQ2awuXF7a53zl3akGb7zskkMYO616FZWaSXEoUsBXGFxTB84z8Jc0gEkCf2eorhxZVIwCZlBsfH7y+Us2nBIhcYJ6cSEWLf6TR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716295949; c=relaxed/simple;
	bh=ifL5qqatoD5N2y90qXOKpNzdYIhiR/PXfQCB5KoW+TE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evwDE2yZUC1+cx4dCOM3E409Is64I99+aVE4YeNWjaOKAqXx3h5huyXq/0B4Y1Lvj6IAYB0U/m4IfEEsbbbn3b8S9W636QwgB9xCvceWIuXUo8EjpK5eiVuF/aZJZnujGKEPiUjbZMKay7yy4bltx7tDKHVsEmvu93xGLfJMkMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4878EDA7;
	Tue, 21 May 2024 05:52:50 -0700 (PDT)
Received: from [10.162.42.16] (e116581.arm.com [10.162.42.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE2EC3F641;
	Tue, 21 May 2024 05:52:23 -0700 (PDT)
Message-ID: <ab1939d8-1913-4b26-a2a2-3b49efb62e97@arm.com>
Date: Tue, 21 May 2024 18:22:20 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: va_high_addr_switch: Do not skip test and
 give warning message post FEAT_LPA2
To: Andrew Morton <akpm@linux-foundation.org>
Cc: shuah@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com,
 kirill.shutemov@linux.intel.com, AneeshKumar.KizhakeVeetil@arm.com
References: <20240516035633.143793-1-dev.jain@arm.com>
 <20240519164823.8e21acfd2bf9ad13f7798f1a@linux-foundation.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20240519164823.8e21acfd2bf9ad13f7798f1a@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/20/24 05:18, Andrew Morton wrote:
> On Thu, 16 May 2024 09:26:33 +0530 Dev Jain <dev.jain@arm.com> wrote:
>
>> Post FEAT_LPA2, Aarch64 extends the 4KB and 16KB translation granule to
>> large virtual addresses. Currently, the test is being skipped for said
>> granule sizes, because the page sizes have been statically defined; to
>> work around that would mean breaking the nice array of structs used for
>> adding testcases.
> Which array is that?  testcases[]?  If so, we could keep if fairly nice
> by doing the array population at runtime.  Something like:
>
> static struct testcase *testcases;
>
> static void init_thing()
> {
> 	struct testcase t[] = {
> 		...
> 	};
>
> 	testcases = malloc(sizeof(t));
> 	memcpy(testcases, t, sizeof(t));
> }


Great idea! This should work. I shall implement it.


