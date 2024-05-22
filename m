Return-Path: <linux-kselftest+bounces-10587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7948CC562
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 19:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A60A1F22042
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 17:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA5A1422AE;
	Wed, 22 May 2024 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeFxgPqN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D7C762FF;
	Wed, 22 May 2024 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716398032; cv=none; b=ZJnhnm29EjJS4ub04giVeuC1xYZo9jVd1pEiNVWfH0i8piUii5S2le+NsKsm6Y+IrlcJCMK21QE3YzO5veqEZcSHohR9rBNsE1Omc6lJnUYWzPwFSFiXPRe+hIXUO0Q498Aju8kntYninAUlmBGE+iFgCoANXCxA1MT7tJ535Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716398032; c=relaxed/simple;
	bh=60LHAtzrKidGyWFU1huo2XzSzZXTtfyfRyB9guGBkOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cA002To3Muxf6iKI36/DvuoAI3Xtgx6X966Wxs5qOrGw5o5Xc1X6OBcjgTpRmU/XMLWELmOQIRsOKz241ZaFV5B1xOrx0KEC6Eo9RIyyjnRpeu2YeAoLaObxmEmW4K6iPdFZaE8T+UzkpOJXyiVE09IhAzN7lcDi/AGk2mQLqYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeFxgPqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E92FC2BBFC;
	Wed, 22 May 2024 17:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716398031;
	bh=60LHAtzrKidGyWFU1huo2XzSzZXTtfyfRyB9guGBkOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UeFxgPqNVyEgTI0XJHmMlqgVNwR2qk549KtkKSQj2xn6VpsjZwqC2Lf+iDGZOM5df
	 0pIFB6FedIZ/eSAj34yv1Bx+FunjVdU3oXJTN9JCuPirVygCgAdPEBau4VikcgzwOQ
	 vlGypaEUL6B4MLskgs7u6vTkyDaanEs1bahwrtj9f+XSO7m6MP7DKDlUm+A0438Ht9
	 2a4kdmt1gQm5HYO3RfBeVkC9R256x/7f0QwJz18xlk3m5e89KQ/35CBOktYzcP1rKi
	 EodPgwktvtviUOk0lBkjMML7i2DmwbUNREU03/GeffV5q/eqjOx9u6S0Sn1Z0ZUMco
	 ceoRRyLMbHS3g==
Date: Wed, 22 May 2024 10:13:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Edward Liaw <edliaw@google.com>, shuah@kernel.org, =?UTF-8?B?TWlja2E=?=
 =?UTF-8?B?w6tsIFNhbGHDvG4=?= <mic@digikod.net>, =?UTF-8?B?R8O8bnRoZXI=?=
 Noack <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, Richard
 Cochran <richardcochran@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@android.com,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH v5 00/68] Define _GNU_SOURCE for sources using
Message-ID: <20240522101349.565a745e@kernel.org>
In-Reply-To: <6caf3332-9ed9-4257-9532-4fd71c465c0d@linuxfoundation.org>
References: <20240522005913.3540131-1-edliaw@google.com>
	<6caf3332-9ed9-4257-9532-4fd71c465c0d@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 May 2024 10:19:33 -0600 Shuah Khan wrote:
> On 5/21/24 18:56, Edward Liaw wrote:
> > Centralizes the definition of _GNU_SOURCE into KHDR_INCLUDES and removes
> > redefinitions of _GNU_SOURCE from source code.
> > 
> > 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
> > asprintf into kselftest_harness.h, which is a GNU extension and needs  
> 
> Easier solution to define LINE_MAX locally. In gerenal it is advisable
> to not add local defines, but it is desirable in some cases to avoid
> churn like this one.

Will the patch that Andrew applied:
https://lore.kernel.org/all/20240519213733.2AE81C32781@smtp.kernel.org/
make its way to Linus? As you say that's a much simpler fix.

