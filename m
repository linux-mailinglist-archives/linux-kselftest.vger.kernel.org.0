Return-Path: <linux-kselftest+bounces-29579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1A4A6C191
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 18:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 009A07A6668
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 17:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B0122D4D8;
	Fri, 21 Mar 2025 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="js9XcrS6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFB7150980;
	Fri, 21 Mar 2025 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578369; cv=none; b=nLtDkIVWoupZBlene+yo425nuReD9Yfcf4BeOOyfc9YCii5l/bGQeDD4WMfmu4yIHX5hfGgMWfhiMu3FB1XZjHixAlN8ok7TGcEyqPmieLYLpM3HAzZXP4lSRxD7IxPue9W8tYtxJdVPNyThLJVm625PGOCZ1QJ8ZA0VOy3XPco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578369; c=relaxed/simple;
	bh=ylazAiId8B+tXX/5u3yopnZM1vrUb4IkzGMknQShfq8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jMwf3mcx37kodmm3gpQFbUNj7YwcOFF7LnpgCOnDYAbP4jHKdhxltd00ZSGKL521J0QOEoX8vRl3t1EV0+feRoFEn3MJeHmCJjVdvLm7vsj/aeSzbs7HO+aEbPikVqfGXJX30EnqEV7sGdueOtW03j38ob2uSZ5CaAStSbXZAJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=js9XcrS6; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D0FF741061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1742578367; bh=e8LnavV6SlTbyQVO8z9IZ0GGY7kUoVlnZAAZGa1WgGY=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=js9XcrS6T1hU9105EYTWYu8QHp3SNxGbUpoLpab9Trijr4b0fesgpaniwQWJfswlh
	 ATPI9S0oPNQlRiMt/7T6OWkafx8InYbdl0QfVKu54wTi7xwYHBClpJNe4IoP9ylwMP
	 u3e1fJie/f4Az/VmsumaL5+OQ3pCvYh07XbrS3INkKg36etVNNpcqGwjUaEU/tE368
	 psPv+vn1tLmkpGJwmZQt9u7FbgBq08sjXUGShJL+ykeWs4mCvk9U5qrPxmvQGpGYRd
	 Faurwchzh6Jow6jkU10g6YSpsNJprVUCpYFanKdZXtGl9dnZaoFMjTFso0dT/pPV9b
	 qDt4mgKUSeKuw==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D0FF741061;
	Fri, 21 Mar 2025 17:32:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, David Howells
 <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S.
 Miller" <davem@davemloft.net>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Masahiro
 Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>,
 =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BC?=
 =?utf-8?Q?nther?= Noack <gnoack@google.com>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Blaise Boscaccy
 <bboscaccy@linux.microsoft.com>, Jarkko Sakkinen <jarkko@kernel.org>, Jan
 Stancek <jstancek@redhat.com>, Neal Gompa <neal@gompa.dev>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 llvm@lists.linux.dev, nkapron@google.com, teknoraver@meta.com,
 roberto.sassu@huawei.com, xiyou.wangcong@gmail.com
Subject: Re: [RFC PATCH security-next 1/4] security: Hornet LSM
In-Reply-To: <20250321164537.16719-2-bboscaccy@linux.microsoft.com>
References: <20250321164537.16719-1-bboscaccy@linux.microsoft.com>
 <20250321164537.16719-2-bboscaccy@linux.microsoft.com>
Date: Fri, 21 Mar 2025 11:32:45 -0600
Message-ID: <87frj6l26a.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Blaise Boscaccy <bboscaccy@linux.microsoft.com> writes:

> This adds the Hornet Linux Security Module which provides signature
> verification of eBPF programs.
>
> Hornet uses a similar signature verification scheme similar to that of
> kernel modules. A pkcs#7 signature is appended to the end of an
> executable file. During an invocation of bpf_prog_load, the signature
> is fetched from the current task's executable file. That signature is
> used to verify the integrity of the bpf instructions and maps which
> where passed into the kernel. Additionally, Hornet implicitly trusts any
> programs which where loaded from inside kernel rather than userspace,
> which allows BPF_PRELOAD programs along with outputs for BPF_SYSCALL
> programs to run.
>
> Hornet allows users to continue to maintain an invariant that all code
> running inside of the kernel has been signed and works well with
> light-skeleton based loaders, or any statically generated program that
> doesn't require userspace instruction rewriting.
>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  Documentation/admin-guide/LSM/Hornet.rst |  51 +++++

You will need to add that file to .../index.rst, or it won't be included
in the docs build.

Thanks,

jon

