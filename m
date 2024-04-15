Return-Path: <linux-kselftest+bounces-8020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9511C8A5A77
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 21:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA55281443
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 19:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D087155A57;
	Mon, 15 Apr 2024 19:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/IedQxl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9D7B656;
	Mon, 15 Apr 2024 19:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713208696; cv=none; b=KDizSGK2SFePO6fxJKBqAukjTTQ9C42ca4qRkkmoiXxg8P/qV2UOY4O+4A2XuzoEiN+KwfgRY0dUQlP1P+RZBYnlyrMv+T/EZPHdrluxSDZIUNTyJ0lXOMgaaBnE75OaAMB4RQMUscQLoFLeXcN7Csl1+tMAT+nQaxBCDZiHk8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713208696; c=relaxed/simple;
	bh=l43s5enpTB78eTa8KUqaYnEl1V9huOL5aW+sGjjMR8E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=a57ZbtIeHb0zGJGvqmQ4RHEDuWJ6qlSYvhYus6l2RAOmElx8InHWwXeaIWYjYdVVJ84NTSCCEmlDJJrtef77Z42EUBD0rS+321NIs7bDDTc5Otef1D1kkv+C8dp871726WlNVTiveFznDkCatcchOrPRfxr6jFVKfsksj4hmXCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/IedQxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0808BC113CC;
	Mon, 15 Apr 2024 19:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713208695;
	bh=l43s5enpTB78eTa8KUqaYnEl1V9huOL5aW+sGjjMR8E=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=G/IedQxlmWRW3pj5FjO/T1SOt970IN5oEjjT6VSSR1V3p8jpZ0D9eqI8IZeiz8UWo
	 kDLKUbiDP/V3kEl0bDRMXCK7XmHRe7pUNf+8t2WxbaIbYkUngaw+D6NQ7qpaq3x93f
	 KZY0MvcDM0qWXQOFTUUy7KlNSMJe13GkuP0GE4v5HyAPagwVRIywv/cEPgHZQBre8T
	 zt+tV4dJiuNXxiIFYMmY5o1E3POqSgQOIwdb98pC97ujJg6DNKNCg3CQRJAADXDktq
	 3C9BQrQFV35BgTpkOjpdf5qFiwzQub3MTcKUtOnmhlZrM4HdmgSaQZWSuZ5G5m34ms
	 LSAzjj0nXB9qA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Apr 2024 22:18:07 +0300
Message-Id: <D0KXSLRDNSGJ.2EIFU7NWC20DI@kernel.org>
Cc: <linux-security-module@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <bpf@vger.kernel.org>, <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
 <linux-integrity@vger.kernel.org>, <wufan@linux.microsoft.com>,
 <pbrobinson@gmail.com>, <zbyszek@in.waw.pl>, <hch@lst.de>,
 <mjg59@srcf.ucam.org>, <pmatilai@redhat.com>, <jannh@google.com>,
 <dhowells@redhat.com>, <jikos@kernel.org>, <mkoutny@suse.com>,
 <ppavlu@suse.com>, <petr.vorel@gmail.com>, <mzerqung@0pointer.de>,
 <kgold@linux.ibm.com>, "Roberto Sassu" <roberto.sassu@huawei.com>
Subject: Re: [PATCH v4 00/14] security: digest_cache LSM
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, <corbet@lwn.net>,
 <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
 <akpm@linux-foundation.org>, <shuah@kernel.org>,
 <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
 <mic@digikod.net>
X-Mailer: aerc 0.17.0
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>

On Mon Apr 15, 2024 at 5:24 PM EEST, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Integrity detection and protection has long been a desirable feature, to
> reach a large user base and mitigate the risk of flaws in the software
> and attacks.
>
> However, while solutions exist, they struggle to reach the large user
> base, due to requiring higher than desired constraints on performance,
> flexibility and configurability, that only security conscious people are
> willing to accept.
>
> This is where the new digest_cache LSM comes into play, it offers
> additional support for new and existing integrity solutions, to make
> them faster and easier to deploy.

Sorry for nitpicking but what are the existing integrity solutions,=20
and how does it help with this struggle? I.e. what is the gist here?

BR, Jarkko

