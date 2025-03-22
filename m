Return-Path: <linux-kselftest+bounces-29610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C26BA6CB9B
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 18:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1334D18958B3
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 17:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA6915855C;
	Sat, 22 Mar 2025 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+mw4Xjm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A32642AB0;
	Sat, 22 Mar 2025 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742664130; cv=none; b=ANGfP2Xo4Coo3y015aLSn2OXfW/xx5xT6DpFJeW83fOu0HL31AlkTbDRq/dmaO2limBdrRputwz7TizBuMTvO04+zp2Fq2e3AjAfRxbStBlIQYsOr6FgvRXuwQV6icm2CGoFqdb++CvR9dwJ8qlidr1q/eevbdE0UKjAWyzv6iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742664130; c=relaxed/simple;
	bh=AEjZNS6nIZ7hhnu6lMixBJVfFla5acmxyBZrFBrcxC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I573FbOxjq8yTwy+kIMwRIbgejQuVwt0nQQOIcLP+o+lr459GHW72khHRlKq/ke0fhY4JPd76f2FuTLQbPRDpD1Pl1sKN7KY3JaPVXPRIdzkSCyNdLS6vxQJd3HBVe43hMH6xsVD8ByAP18uc8fFUhRS3g3NmjF4V5hOJCpeO+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+mw4Xjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEE1C4CEEC;
	Sat, 22 Mar 2025 17:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742664129;
	bh=AEjZNS6nIZ7hhnu6lMixBJVfFla5acmxyBZrFBrcxC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+mw4XjmovYmbMRL07ViC5rSmSoJGh2BR60s3oVNSJJWnUcLgEzcSRz2JM0+87K7I
	 7e/80pd+9FyNxjgz/cfkfgxuTxhbVBKvHrUy9844htcl1gURvy5wFDkNlAXP3Zw/25
	 VGEiV84C6cpsId0vccpO8ma07XRw54XmqHyF++rutKalQC8ZsBnRX87iun7CBu5N1s
	 kMCj7BWr5/1b2a4Fo2RjzFH3TtOnNkNLde8f6hOsyM0XQ5gtlf7IRtfC5HCiwwQ9Rs
	 5gB5E7xCHyFXrlGjgAd6bBefhws1dkXzWSvUu1yNvY+dzW5Aa2pHxLebH8bl2DJKtk
	 C+vTe5Vrg1Pbg==
Date: Sat, 22 Mar 2025 19:22:05 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jan Stancek <jstancek@redhat.com>, Neal Gompa <neal@gompa.dev>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev, nkapron@google.com, teknoraver@meta.com,
	roberto.sassu@huawei.com, xiyou.wangcong@gmail.com
Subject: Re: [RFC PATCH security-next 0/4] Introducing Hornet LSM
Message-ID: <Z97xvUul1ObkmulE@kernel.org>
References: <20250321164537.16719-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321164537.16719-1-bboscaccy@linux.microsoft.com>

On Fri, Mar 21, 2025 at 09:45:02AM -0700, Blaise Boscaccy wrote:
> This patch series introduces the Hornet LSM.
> 
> Hornet takes a simple approach to light-skeleton-based eBPF signature

Can you define "light-skeleton-based" before using the term.

This is the first time in my life when I hear about it.

> verification. Signature data can be easily generated for the binary

s/easily//

Useless word having no measure.

> data that is generated via bpftool gen -L. This signature can be

I have no idea what that command does.

"Signature data can be generated for the binary data as follows:

bpftool gen -L

<explanation>"

Here you'd need to answer to couple of unknowns:

1. What is in exact terms "signature data"?
2. What does "bpftool gen -L" do?

This feedback maps to other examples too in the cover letter.

BR, Jarkko 

