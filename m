Return-Path: <linux-kselftest+bounces-12794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C16939182A3
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 15:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FCD91F26015
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 13:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B4D1836D0;
	Wed, 26 Jun 2024 13:37:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0787181BB8;
	Wed, 26 Jun 2024 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409026; cv=none; b=II371zNbzx9Ow6QzqHSLhD/0gUzfBD2SKbgjAGY8jsdhL9v0DTfJdVq6rwSgAuw5b404ecSkJi/qNeINXaW10er2GffJKDg8EejX33/uNUxComBhFiKPWUrdM+c7VUy9v00Gd1uZAow1rrigzHpM2YYf+W9swYZ8o4D/SMf5YEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409026; c=relaxed/simple;
	bh=X12RbHoxP9jbZfCWKOU7ejTpCDFLpnqDMFHO42Ory5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2nOKs/eKDN2eUqeEYLPxQv+E05WIiyJb3Ddjb7dInAvE9F3vu6LU80ISo3Yb/sGjD6aMGgOjZg7F+SoYZ40DIQ3sre8yhmYbHMbdGrUFCDQlp8UCtaiRESHAN+dewxH5vvHbclR9hxIqjPePgNw6X6oawVAOKHJqHqtODZ8dlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D87CF367;
	Wed, 26 Jun 2024 06:37:28 -0700 (PDT)
Received: from [10.162.42.14] (e116581.arm.com [10.162.42.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADDEE3F73B;
	Wed, 26 Jun 2024 06:36:59 -0700 (PDT)
Message-ID: <cfc06689-70a6-45e0-aab7-424da468f8c9@arm.com>
Date: Wed, 26 Jun 2024 19:06:50 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] selftests: Add a test mangling with uc_sigmask
To: Oleg Nesterov <oleg@redhat.com>
Cc: shuah@kernel.org, mingo@kernel.org, tglx@linutronix.de,
 mark.rutland@arm.com, ryan.roberts@arm.com, broonie@kernel.org,
 suzuki.poulose@arm.com, Anshuman.Khandual@arm.com,
 DeepakKumar.Mishra@arm.com, aneesh.kumar@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240626054847.1463889-1-dev.jain@arm.com>
 <20240626054847.1463889-3-dev.jain@arm.com>
 <20240626115410.GA27271@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20240626115410.GA27271@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/26/24 17:24, Oleg Nesterov wrote:
> On 06/26, Dev Jain wrote:
>> +int main(int argc, char *argv[])
>> +{
>> +	struct sigaction act, act2;
>> +	sigset_t *set, *oldset;
> ...
>
>> +	set = malloc(sizeof(sigset_t *));
>> +	if (!set)
>> +		ksft_exit_fail_perror("malloc");
>> +
>> +	oldset = malloc(sizeof(sigset_t *));
> Why malloc() ?
>
> Can't you simply do
>
> 	sigset_t set, oldset;
>
> and then use sigemptyset(&set) / etc ?
>
> Oleg.


Ah yes, let us allocate it on the stack. I shall change it.

>

