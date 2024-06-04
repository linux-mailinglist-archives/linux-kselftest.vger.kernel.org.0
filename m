Return-Path: <linux-kselftest+bounces-11172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFE48FAD3D
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 10:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8171F22817
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 08:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5E61422B7;
	Tue,  4 Jun 2024 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XM/Poj30"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1083F1420C4;
	Tue,  4 Jun 2024 08:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717488868; cv=none; b=jp8AGm7V6g+Bzp5sRmx44DY0M4oY820LwvwAq3o4WbMRjT+AAWj0N3GwEy8snQVsBhrY1EoQyyfnOblU94fcUukyNEVc0C8KkecxbvAfQqSefOnwOGXD+pb3L1AGWR9hDQqA7RIQHuK4sFH3eNY2bnfekJw3N1O/Vxy/OHpRkM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717488868; c=relaxed/simple;
	bh=joAVenAxN13C55NLARYN11/9fHBvAfySGAsGpcf3tEg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fM45GdAnNXPu4WpxDea5bBmYufhegpFdWZzWd8IVXLl55vSXteciYGF3YbniRB5d/k8h+Vwafw/czMKDVtfwMBz8wOmoIh7IVCQpC/3mPdiubjosNI24NtISNY3yLTLZZSZ+Yjrwh0SWvdQtIaNSRqVumPraxAgwr7VUjMwE9sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XM/Poj30; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717488865;
	bh=joAVenAxN13C55NLARYN11/9fHBvAfySGAsGpcf3tEg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=XM/Poj30EtOAaH9LN67fNc03QWKNL2hlYhAuC0ZeSna3A3o1uxS0UTVE9gSmxRL6Z
	 Z8cNmDJns+Lra5ahgBah+sVJeY86eZVD0ZE1xaJkInfnrUOOT1f69AsJnNfjwT8DBI
	 021Hs8uL8Zz2gtkzBcnH81uC+wc7/3+2WY5+ihIzZoIH1JePtz2d81poTybiWNH7hs
	 ZIE54RACaOIe7uQ5K5vL4n0lueRS3pd6/PqESyutGsX1/42kCo5SSLNrXcL56Sidr2
	 5rRz2LERta35aTZpqDNGvDI1NwbrYiOJQ7Z24bXJV6M7Ba44M4xxkRx7Opm8E2qcAc
	 tTQvJaPlw7kBw==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9ABFA37821A5;
	Tue,  4 Jun 2024 08:14:20 +0000 (UTC)
Message-ID: <8e1e2f1d-a578-43c0-ad55-fb593967ac5e@collabora.com>
Date: Tue, 4 Jun 2024 13:13:45 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Bug Report] selftests: arm64: build errors
To: Mark Brown <broonie@kernel.org>
References: <5ec0f2f3-5259-41a9-a25d-5baf1680dd10@collabora.com>
 <7b7f4dd1-bc13-4827-84d6-20ebed7119b6@sirena.org.uk>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <7b7f4dd1-bc13-4827-84d6-20ebed7119b6@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/3/24 6:31 PM, Mark Brown wrote:
> On Mon, Jun 03, 2024 at 06:28:16PM +0500, Muhammad Usama Anjum wrote:
> 
>> gcc pac.c /pauth/pac_corruptor.o /pauth/helper.o -o /pauth/pac -Wall -O2 -g
>> -I/linux_mainline/tools/testing/selftests/  -I/linux_mainline/tools/include
>> -mbranch-protection=pac-ret  -march=armv8.2-a
>> In file included from pac.c:13:
>> ../../kselftest_harness.h: In function ‘clone3_vfork’:
>> ../../kselftest_harness.h:88:9: error: variable ‘args’ has initializer but
>> incomplete type
>>    88 |  struct clone_args args = {
> 
> This is in the generic code.
> 
>>   CC       check_prctl
>> check_prctl.c: In function ‘set_tagged_addr_ctrl’:
>> check_prctl.c:19:14: error: ‘PR_SET_TAGGED_ADDR_CTRL’ undeclared (first use
>> in this function)
>>    19 |  ret = prctl(PR_SET_TAGGED_ADDR_CTRL, val, 0, 0, 0);
>>
>> gcc -mbranch-protection=standard -DBTI=1 -ffreestanding -Wall -Wextra -Wall
>> -O2 -g -I/linux_mainline/tools/testing/selftests/
>> -I/linux_mainline/tools/include  -c -o /bti/test-bti.o test.c
>> test.c: In function ‘handler’:
>> test.c:85:50: error: ‘PSR_BTYPE_MASK’ undeclared (first use in this
>> function); did you mean ‘PSR_MODE_MASK’?
>>    85 |  write(1, &"00011011"[((uc->uc_mcontext.pstate & PSR_BTYPE_MASK)
> 
>> I've GCC 8 installed. I'm not expecting the errors because of a little
>> older compiler. Any more ideas about the failures?
> 
> You need to run headers_install IIRC.
I'm running:
make headers && make -C tools/testing/selftests

I've tried gcc 12 as well.


-- 
BR,
Muhammad Usama Anjum

