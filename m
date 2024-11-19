Return-Path: <linux-kselftest+bounces-22300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5EC9D2C53
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 18:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91D99B36711
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 16:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA571D88A6;
	Tue, 19 Nov 2024 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O+E3gYjx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4571D86C6;
	Tue, 19 Nov 2024 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034829; cv=none; b=eKFtQT2r3ElW6SY4OBxB5gqtrPUvw+V1WZCoCgo/+lRJZNwWQN949xpYSvCDyNkXUk4XfMo2AzQURz5suyoXjsUJMu8Dfi+pnQJgM5YRyjkqR6a0SuGd0MH3+vF37H3Hm3eoaB/aTf/FxxKcy353Z3YRLYKuOW9BHypHo+yQwbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034829; c=relaxed/simple;
	bh=hbYPm9XsuKyIbmWlphbpd1znuk0eRhzgeiaJBSGeF2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5624FhwR74WHNy/4cKt8m7iUUIpVsOU78UJIO56WzS7VLp0REV5cbU4Ec7k2K0mcg0gxLQO7wWa2Y+yHWIMarmpzklDNjeojJqSKNuO3RWrIXKxZMnWNs9jo+Iu+4N0LshXo9jXSaMmDdtSWEoBSKLsVOjO6KxQlSNPY1BX65g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O+E3gYjx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=j5HkeQ7LapR4JelfU34fBoWz02L4bp7WV6Brj5s7Vzw=; b=O+E3gYjxUOEg+XxfLfoyz3Zf4l
	hukz49f9FjVRjzqd3YNlvnNh9gkWpa4FfxRr2YVzJlLJNY/8NU8khP0KVysEHteyaWy/lTan8HO3p
	8UYsk74aD1Ly5522kLb2KiaHUi1e18xoJb+lJeJAsGPaAauMVgS65MwnJrhkxFpxNDPyzTV3lBZWF
	EQCKxZJoXhdX7EHN1gRkpurfE6iiqIFqW3cTsfFzunWAJGlURXd3s5BOTwXJdVEWE6rqlkMC5ualM
	tO2dD0IGuA+b0sWxv2XPKISOWWpMLooC49NT4C/+EdUVPkaKlMTIucQo5/RUhO6ssLJOPmHlc770+
	LBA870bw==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDRNF-00000004JIr-2DOw;
	Tue, 19 Nov 2024 16:46:47 +0000
Message-ID: <c6a7b5eb-d2ec-45e5-8a9b-a91f9c0cec78@infradead.org>
Date: Tue, 19 Nov 2024 08:46:35 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/15] digest_cache: Allow registration of digest list
 parsers
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, corbet@lwn.net,
 mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com,
 da.gomez@samsung.com, akpm@linux-foundation.org, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, shuah@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Cc: linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kselftest@vger.kernel.org, wufan@linux.microsoft.com,
 pbrobinson@gmail.com, zbyszek@in.waw.pl, hch@lst.de, mjg59@srcf.ucam.org,
 pmatilai@redhat.com, jannh@google.com, dhowells@redhat.com,
 jikos@kernel.org, mkoutny@suse.com, ppavlu@suse.com, petr.vorel@gmail.com,
 mzerqung@0pointer.de, kgold@linux.ibm.com,
 Roberto Sassu <roberto.sassu@huawei.com>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
 <20241119104922.2772571-8-roberto.sassu@huaweicloud.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241119104922.2772571-8-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 11/19/24 2:49 AM, Roberto Sassu wrote:
> +/**
> + * struct parser - Structure to store a function pointer to parse digest list
> + * @list: Linked list
> + * @owner: Kernel module owning the parser
> + * @name: Parser name (must match the format in the digest list file name)
> + * @func: Function pointer for parsing
> + *
> + * This structure stores a function pointer to parse a digest list.
> + */
> +struct parser {
> +	struct list_head list;
> +	struct module *owner;
> +	const char name[NAME_MAX + 1];
> +	parser_func func;
> +};

I would make the struct name not so generic -- maybe digest_parser ...

thanks.
-- 
~Randy


