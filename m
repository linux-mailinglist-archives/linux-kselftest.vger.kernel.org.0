Return-Path: <linux-kselftest+bounces-4483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E3D85008D
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Feb 2024 00:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47A321C21B7C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 23:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D620737149;
	Fri,  9 Feb 2024 23:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OXm3sJna"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD119364AE;
	Fri,  9 Feb 2024 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707519667; cv=none; b=nlvQOW3B+PScDSdCq9vHqu3nMxQW9YT6+X3dM/aSuBI9JeQ1L67JSCrrPRl2rGI31UIYLBVJ9GEhxz04Q9HMNupA1Dmy/8Kg6cy9yGN8kB45tNp95tT9eWldQg4uU9gpsm0dw8TowQoaQl/mTK8b9tMQDDadXZWowdKla129i2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707519667; c=relaxed/simple;
	bh=f/s6qNu01ILKzMwDnVjntUiAteO3NPuo/Rty/dlQ9Ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLdxlF7FqNPiul8BD/xz20fnB9ef3xU3ky1ZeRvuxWOI/i2f/HUiengzF3DOMPrq3CKnJ3oGbuNxlMg9IAn5qnbOUV7YHDKOyRhU0nWIa5arwXO7lUHRWPsYmtsnnHC086+reZNDb9Y9vyKdhoXxQq3JGZg+IjXyFTE6R/Fvsos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OXm3sJna; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=gmacEVrfRMHpA0+533PB1RmxTePlSp6iAq0RpqSnWnI=; b=OXm3sJna4lSQPcZxFk6OnEORw7
	xT+pdCOtmocB7lgsq4fifo8HXHZCM8MB77iHgPvVkyATuK93E6oOup88vp/vYGj24EmkolGCdMg+A
	8V/G/i+lZ2Ei9z4IKebndbi3DfKbVEqxKJ3ndMQEA5N/VaZmh6D55toso81e4e0+5EJpbVpam2j39
	u0jMvJAlwqS71Z8YXCp8TW8VfWLZmx/Rsm400tn2seunqlz3Xu2+3xgyuAemKuw9n/8qi+51o2VgK
	0IKdoaxBYR8J3qJm1olZsBLRVJckwgsZ1vlGeTMnpTBT0aqGnl8Coytb/zwqGDHY8iqwfhISg79YB
	DiQknORQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYZrU-00000000q1k-1hGw;
	Fri, 09 Feb 2024 23:00:48 +0000
Message-ID: <e8378ba2-ccd1-48fe-973d-38986fc0716d@infradead.org>
Date: Fri, 9 Feb 2024 15:00:44 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/13] security: Introduce the digest_cache LSM
Content-Language: en-US
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, shuah@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, mic@digikod.net
Cc: linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 linux-integrity@vger.kernel.org, wufan@linux.microsoft.com,
 pbrobinson@gmail.com, zbyszek@in.waw.pl, hch@lst.de, mjg59@srcf.ucam.org,
 pmatilai@redhat.com, jannh@google.com, dhowells@redhat.com,
 jikos@kernel.org, mkoutny@suse.com, ppavlu@suse.com, petr.vorel@gmail.com,
 petrtesarik@huaweicloud.com, Roberto Sassu <roberto.sassu@huawei.com>
References: <20240209140917.846878-1-roberto.sassu@huaweicloud.com>
 <20240209140917.846878-3-roberto.sassu@huaweicloud.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240209140917.846878-3-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 2/9/24 06:09, Roberto Sassu wrote:
> diff --git a/security/digest_cache/Kconfig b/security/digest_cache/Kconfig
> new file mode 100644
> index 000000000000..0c47d5151f07
> --- /dev/null
> +++ b/security/digest_cache/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config SECURITY_DIGEST_CACHE
> +	bool "Digest_cache LSM"
> +	default n
> +	help
> +	   This option enables an LSM maintaining a cache of digests
> +	   (e.g. of file content or metadata).
> +
> +	   This LSM can support other kernel components in making access
> +	   control decisions.
> +

nit:  -ESTYLE.
coding-style.rst says:

Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.

> +config DIGEST_LIST_DEFAULT_PATH
> +	string
> +	default "/etc/digest_lists"
> +	help
> +	   Default directory where digest_cache LSM expects to find digest
> +	   lists.

Same comment for patch 03/13.
Same comment for patch 04/13.

-- 
#Randy

