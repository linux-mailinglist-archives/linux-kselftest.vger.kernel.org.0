Return-Path: <linux-kselftest+bounces-22302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A724A9D2BDB
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 17:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F6F1F21B68
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 16:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9AB1D318B;
	Tue, 19 Nov 2024 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d/eSyR6O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882AF1D2F56;
	Tue, 19 Nov 2024 16:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035139; cv=none; b=IAbMunLz8uJpKC/GFsjsj6JbUHy5YdaMOsAhzNmzP1LNOys7LQrFFH5sqIvH2O8elMsd5knTQpSVEA2ZlDwek2+QyyJYnGC0S5Fbx7FNEAv1TA5ic4+ZbsuSON7woo0wS9yUpMdm6y4Exwu/m0kjp+c4Mb/VOAOwry454Wjgfco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035139; c=relaxed/simple;
	bh=G0sGcIirrAQif+7K+ojYepQ7+x0l+SMBvQKWQ11nSuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUvWDAzcOczbuyeJRiva5oc6c2IHWMGj3PBnz9pFcxAVczVfYwZ62symKU4ZssWxC7suhXzXWsjgX0Ga6pzPCnddiGpfHevl7mlcxaruNr5IPYIUvt2Ez0R425DmUKDMl74cdbXDulTWZSpnJv100LZVevK3KQs2KzCUNJ70lFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d/eSyR6O; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=lmBjchKB9uAfbJVAGrRIHNf3bHKMKgL84Ei1RY/LBH4=; b=d/eSyR6OejkmnvtirxS5k9PHet
	Y0o4/LvCcJgSTgNrIIipjyJIcQ3f6I9oDtEQWxtyUiGTJhweLzQDlx0aEoUcrQL2V/z2wFWxIqzVH
	18KjOPKR3h8cPAC505puyoQmEOkd/p6ZyFP0QLf6j7GUPy5NNw+qBvacg4PnSci3mUdgD7jJWXNUp
	3LpOdJ87lqBf1vZ9CzN9vto8x6Mp8M3cmjqpkpab68d9bUjegT7Uo67g8a4O8DuGqTjfcS35SqnFE
	kW/rSbAYlz6pvuSDjNqx45WCm7L/Szw/RP4mc34vrPyFLtIoojXL2SGL2YovIhS4U9SPjzzsj8ceP
	Z1U0OS8g==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDRSQ-00000004Jbj-094Z;
	Tue, 19 Nov 2024 16:52:07 +0000
Message-ID: <d8b1fb69-ac58-47a5-a2df-26a88894a6ea@infradead.org>
Date: Tue, 19 Nov 2024 08:51:57 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/15] lib: Add TLV parser
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
 <20241119104922.2772571-2-roberto.sassu@huaweicloud.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241119104922.2772571-2-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 11/19/24 2:49 AM, Roberto Sassu wrote:
> +/**
> + * typedef callback - Callback after parsing TLV entry

Same as my other naming comment -- too generic.
Maybe tlv_callback...

Thanks.

> + * @callback_data: Opaque data to supply to the callback function
> + * @field: Field identifier
> + * @field_data: Field data
> + * @field_len: Length of @field_data
> + *
> + * This callback is invoked after a TLV entry is parsed.
> + *
> + * Return: Zero on success, a negative value on error.
> + */
> +typedef int (*callback)(void *callback_data, __u16 field,
> +			const __u8 *field_data, __u32 field_len);

-- 
~Randy


