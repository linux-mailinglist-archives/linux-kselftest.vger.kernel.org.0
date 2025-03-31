Return-Path: <linux-kselftest+bounces-29963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DFEA76DF4
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 22:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16E1D7A4270
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 20:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C37A215F4A;
	Mon, 31 Mar 2025 20:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MoaImwsj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819E418BBBB;
	Mon, 31 Mar 2025 20:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743451797; cv=none; b=DSqDon6MWNssbR6pGMVpgb0QDcgcZbUATH6W6oDl2Ezj6yWFMHIGMiqCdgjNGfLsgYLIB0idW3HNkx/hKkFdZVfAX3YJXSchAP9w7P2/b0gchDBlL446XQbBlChsMFYTchz+FC0m+GoAhtKJkYMjZeFjKOWNVrMTTbR29hu+J8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743451797; c=relaxed/simple;
	bh=SUjN1fXZmPO+4wQ5IRPnLqyQNV1W24RxEWdffl0oD+8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pZZVEsC1lYYtmJwwKM+OrQf9RtEp71gnskMRSFJRzMqGJXmvRAmrGVrJQtzT3XJC/gUmko9jtxSs6LKgDXcRxaOf7mr2oc/+KSd9pzLDQq5/JmKfYN6RfyHfqANzwDIx+9grE/KWjitJj9ZDITDH1eW0EFSkjkhqLSLTd0/SWic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MoaImwsj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id C9D71210237D;
	Mon, 31 Mar 2025 13:09:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C9D71210237D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743451795;
	bh=ssME+pbJ+oVtKydIuNRLX638d5Z4zg+HsBKaQBu0NhY=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=MoaImwsjPspShh4Gs1war4lg9WGKeAQEW5nRI2hedV0oTE5iSWza056H2bQedwuHx
	 vKmZKuMfgni2U17IdRVzSpxiKaLtaMa1RYSogkkXGG4RplA+UcWo0iujq4CYdojjfx
	 dt/i+e6wmL+MfkSa3c2Rpet4T5LYBglbLz/9ksBU=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, "David S.
 Miller" <davem@davemloft.net>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Masahiro
 Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>,
 =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BC?=
 =?utf-8?Q?nther?= Noack <gnoack@google.com>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Jarkko Sakkinen
 <jarkko@kernel.org>, Jan
 Stancek <jstancek@redhat.com>, Neal Gompa <neal@gompa.dev>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 llvm@lists.linux.dev, nkapron@google.com, teknoraver@meta.com,
 roberto.sassu@huawei.com, xiyou.wangcong@gmail.com
Subject: Re: [RFC PATCH security-next 1/4] security: Hornet LSM
In-Reply-To: <87frj6l26a.fsf@trenco.lwn.net>
References: <20250321164537.16719-1-bboscaccy@linux.microsoft.com>
 <20250321164537.16719-2-bboscaccy@linux.microsoft.com>
 <87frj6l26a.fsf@trenco.lwn.net>
Date: Mon, 31 Mar 2025 13:09:44 -0700
Message-ID: <874iz96jxz.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Corbet <corbet@lwn.net> writes:

> Blaise Boscaccy <bboscaccy@linux.microsoft.com> writes:
>
>> This adds the Hornet Linux Security Module which provides signature
>> verification of eBPF programs.
>>
>> Hornet uses a similar signature verification scheme similar to that of
>> kernel modules. A pkcs#7 signature is appended to the end of an
>> executable file. During an invocation of bpf_prog_load, the signature
>> is fetched from the current task's executable file. That signature is
>> used to verify the integrity of the bpf instructions and maps which
>> where passed into the kernel. Additionally, Hornet implicitly trusts any
>> programs which where loaded from inside kernel rather than userspace,
>> which allows BPF_PRELOAD programs along with outputs for BPF_SYSCALL
>> programs to run.
>>
>> Hornet allows users to continue to maintain an invariant that all code
>> running inside of the kernel has been signed and works well with
>> light-skeleton based loaders, or any statically generated program that
>> doesn't require userspace instruction rewriting.
>>
>> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
>> ---
>>  Documentation/admin-guide/LSM/Hornet.rst |  51 +++++
>
> You will need to add that file to .../index.rst, or it won't be included
> in the docs build.
>
> Thanks,
>
> jon

Good catch, will get that fixed. Thanks Jon. 

