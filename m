Return-Path: <linux-kselftest+bounces-8033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3178A5CA8
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 23:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA321F23898
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 21:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BEC156992;
	Mon, 15 Apr 2024 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gIQ+xICP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210D6823CE;
	Mon, 15 Apr 2024 21:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215282; cv=none; b=U5Tw0PakOdzk5FYRso9Q83sh9T+TmgbJ6ukC6mSGI1a5pf/56HpmjSNLHplAlns5WEslIXqvXcCm6EirczlLAQZkpzNSLY6m0IIGidwyw433JjSKd00mgFCoX+TFWz5laf1y7+ru9b5PD9MKCypEVV5lSf/6+U526R5Fwb9bHEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215282; c=relaxed/simple;
	bh=TJCFkjZfjstSqTosq2ofApmwxwcsMnKCELg9tffipXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B82P15maPpSE57AzApg6QAC6Fbab0j2ozNqXxsE8D4OpysdbEynggBmo3Ny5vIfrgRRf5VIDyEOnMb/IryKCfJy6YIaYereH3ShBDC2XagYc1vjv4goLUy+L+vkxlRuAGf9Ruk+qVSPz9CpZDHJkf9jEBDNdxcRNo9ISmbb/fVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gIQ+xICP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=7+q5a4BFZOQ0nlwK9E3zO3DsPMAmGY9bri/gwPhuncQ=; b=gIQ+xICPtGPVXjX3/kXMEd3bNj
	/YeR1j2Gj3QOsMBAqM9PLeuQnZVGqdwqlpSlIpfGUnx68Cywwdd04syLRbWGXZlHLsfdIu1EeLU7H
	9YDDhNW15+gcofUs2psqkJaJdUarmJuAtcKaYHn3fAWYOfK3YwVu6WGQW2xPJObiwaqZ718LKlh9v
	N07yL1LzBZzTW9NwAdCNFDW/A/Ye1fSf/onmNDQR52y85OsOG/kRWuhVbajPUx8NnQGSoLEEdoXRC
	jwooLpl7PRhgSFwfuE1JxjYd8ua8dy1v5OF28kcJWNvVDDO8GVi8lV8uHqCYj8W7+no8qJUujWD5C
	B/cTLbOA==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwTYH-00000009v3H-3nHt;
	Mon, 15 Apr 2024 21:07:47 +0000
Message-ID: <805af99c-4c78-4f2c-a15b-de69a4b8da99@infradead.org>
Date: Mon, 15 Apr 2024 14:07:42 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] lib: Add TLV parser
To: Jarkko Sakkinen <jarkko@kernel.org>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 akpm@linux-foundation.org, shuah@kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, mic@digikod.net
Cc: linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 linux-integrity@vger.kernel.org, wufan@linux.microsoft.com,
 pbrobinson@gmail.com, zbyszek@in.waw.pl, hch@lst.de, mjg59@srcf.ucam.org,
 pmatilai@redhat.com, jannh@google.com, dhowells@redhat.com,
 jikos@kernel.org, mkoutny@suse.com, ppavlu@suse.com, petr.vorel@gmail.com,
 mzerqung@0pointer.de, kgold@linux.ibm.com,
 Roberto Sassu <roberto.sassu@huawei.com>
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
 <20240415142436.2545003-2-roberto.sassu@huaweicloud.com>
 <D0KXTHHYLSX6.1IDLSEIVS9PA5@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <D0KXTHHYLSX6.1IDLSEIVS9PA5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/15/24 12:19 PM, Jarkko Sakkinen wrote:
> On Mon Apr 15, 2024 at 5:24 PM EEST, Roberto Sassu wrote:
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> Add a parser of a generic TLV format:
> 
> What is TLV?

type-length-value

i.e., a descriptor that contains a value.

IIUC.

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

