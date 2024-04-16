Return-Path: <linux-kselftest+bounces-8159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761978A6E1F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A603A1C223CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A73012FB39;
	Tue, 16 Apr 2024 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqDr96a+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A434128805;
	Tue, 16 Apr 2024 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277399; cv=none; b=ZxLT2ZlXb763qxbrvA6py5mqqUVnNoUzR+D0Mjnrh1gciBfqWU3C1hNtMYlJNS2aZ+aVHXMZr4znG5RcgOl8BksV0n4v9sZrGq0aB27STz1G1KmbptrFoxIdq05rEKzyPZEEF7oiD7oNUSnmZ1sNGi4JgkI7QrhpbiKufxuGaAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277399; c=relaxed/simple;
	bh=ehDmFxuzMc0GABhu9Np0Q5YsywD0jqWWuiNwfGgzy7Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Qc8SwEezAXpF9ji40lDQhcS4ioykpT5JdPgkcUonCeZvNQNSuDselS4RUfCuiLhuW0fgmqA5gRR3vjTC05XuJhSvtR/uwGBKDAwsw1wp97uev+D/OvdCeA7bwCVgWZRVrIxtQzQcwoZHIAC387bWdGJznK/QHmToVofdDRtmDHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqDr96a+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F67DC2BD10;
	Tue, 16 Apr 2024 14:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713277399;
	bh=ehDmFxuzMc0GABhu9Np0Q5YsywD0jqWWuiNwfGgzy7Y=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=kqDr96a+/EJLMGuxGhyn7HPaDovtgGPCfVn3A8iRwpoRF+dWD3mgbIj3UY4hSvYfo
	 NFt34q7YXC5XQxqtIpgKYYDnXon0jFDN33kRrsQdqlwIvudhe0V29TxoEUKJuGJ6az
	 tzE7Xdkra2kIZ+p6LSI6J3pDsd+dkboMo9LwilVhY8TlPY27f2ZVLw5R8fC4L8VbA0
	 7urXrm8UItbRGNb7UFPSnxt/OyYLFP3Z8wvoBZBcq/tbHeTUXvaBW1Pcl3Y28IMOCJ
	 dad87sgoJqYCWh2s5JhWG0T9hGsS/WG4hOet6yuKtJTmqgFcMxFDakskBbt0e0wT21
	 GKslGlHo4IftQ==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Apr 2024 17:23:10 +0300
Message-Id: <D0LM5BP1D90R.2OLRV9OQG5596@kernel.org>
Subject: Re: [PATCH v4 01/14] lib: Add TLV parser
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Randy Dunlap" <rdunlap@infradead.org>, "Roberto Sassu"
 <roberto.sassu@huaweicloud.com>, <corbet@lwn.net>, <paul@paul-moore.com>,
 <jmorris@namei.org>, <serge@hallyn.com>, <akpm@linux-foundation.org>,
 <shuah@kernel.org>, <mcoquelin.stm32@gmail.com>,
 <alexandre.torgue@foss.st.com>, <mic@digikod.net>
Cc: <linux-security-module@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <bpf@vger.kernel.org>, <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
 <linux-integrity@vger.kernel.org>, <wufan@linux.microsoft.com>,
 <pbrobinson@gmail.com>, <zbyszek@in.waw.pl>, <hch@lst.de>,
 <mjg59@srcf.ucam.org>, <pmatilai@redhat.com>, <jannh@google.com>,
 <dhowells@redhat.com>, <jikos@kernel.org>, <mkoutny@suse.com>,
 <ppavlu@suse.com>, <petr.vorel@gmail.com>, <mzerqung@0pointer.de>,
 <kgold@linux.ibm.com>, "Roberto Sassu" <roberto.sassu@huawei.com>
X-Mailer: aerc 0.17.0
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
 <20240415142436.2545003-2-roberto.sassu@huaweicloud.com>
 <D0KXTHHYLSX6.1IDLSEIVS9PA5@kernel.org>
 <805af99c-4c78-4f2c-a15b-de69a4b8da99@infradead.org>
In-Reply-To: <805af99c-4c78-4f2c-a15b-de69a4b8da99@infradead.org>

On Tue Apr 16, 2024 at 12:07 AM EEST, Randy Dunlap wrote:
>
>
> On 4/15/24 12:19 PM, Jarkko Sakkinen wrote:
> > On Mon Apr 15, 2024 at 5:24 PM EEST, Roberto Sassu wrote:
> >> From: Roberto Sassu <roberto.sassu@huawei.com>
> >>
> >> Add a parser of a generic TLV format:
> >=20
> > What is TLV?
>
> type-length-value
>
> i.e., a descriptor that contains a value.
>
> IIUC.

Thanks Randy. If it had been "time-length-value (TLV)" then it would
have been obvious :-)

BR, Jarkko

