Return-Path: <linux-kselftest+bounces-29997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56474A78286
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 20:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0311886AB7
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 18:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440EE211282;
	Tue,  1 Apr 2025 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QapRp3OK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920F51F09B8;
	Tue,  1 Apr 2025 18:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743533812; cv=none; b=ri6zdFOCHpaGek3SCddGsZNG+a2z73I2YAqhS7AsBSZfZx4rF2pcdtSPTCkc4iPfuIa2hi5+eUWCNvk+hjrOyyJ5x4fQO02TY5XVUA4zPmNTKPLp3MS7QRqYnOEzPNL69NveDvFrGSSL6mzy4uZi0UhIuHTJCCbpMv7PskZ/6Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743533812; c=relaxed/simple;
	bh=bzA5yQlxM5CYAzByNShEGHGrcQhOK5tsk1smItcbPvw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dRbhQBPZItq3GylKxd8EgGzKQD3OzKY/Fcui8lYvjJuiju3N/RLPacnpOAdnsTfdICJFCI1yNGvEA4byZBlVRYpYU6+IuRVbQvQswQl8oDz2OHvq/LZPs/9BsOaXaiyMlJWJSPiu3abQLir5Yy1o1tXKConZbAx1YoRJpGq6SLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QapRp3OK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id DE23920412F8;
	Tue,  1 Apr 2025 11:56:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DE23920412F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743533810;
	bh=nghUxCgd3Rj3zORPScI3SKHVRg60ZkC2fKZvDytP/2E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QapRp3OKW3zygfnH/WRQRfu0u/vCRTJXMpGbSZvyiA818p11IAQoJN61iog+1P/sm
	 gCtLH8qYoJ9tTiU7yIgFxpeZVYM05PLTHgDXbzkOmyZI4Tp/r5hR1VF4NeerLlWozD
	 qUVTlal3A+XPQ8mlFolSwwPpKu7U/qXbdRRRDGhs=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
 <davem@davemloft.net>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Masahiro Yamada
 <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas
 Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, =?utf-8?Q?Mick?=
 =?utf-8?Q?a=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Nick
 Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Jan Stancek <jstancek@redhat.com>,
 Neal Gompa <neal@gompa.dev>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, llvm@lists.linux.dev, nkapron@google.com,
 teknoraver@meta.com, roberto.sassu@huawei.com, xiyou.wangcong@gmail.com
Subject: Re: [RFC PATCH security-next 0/4] Introducing Hornet LSM
In-Reply-To: <Z-wLKhlfJ5EQqvJC@kernel.org>
References: <20250321164537.16719-1-bboscaccy@linux.microsoft.com>
 <Z97xvUul1ObkmulE@kernel.org> <871puc7wb8.fsf@microsoft.com>
 <Z-wLKhlfJ5EQqvJC@kernel.org>
Date: Tue, 01 Apr 2025 11:56:40 -0700
Message-ID: <87friru2vr.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jarkko Sakkinen <jarkko@kernel.org> writes:

> On Mon, Mar 31, 2025 at 01:57:15PM -0700, Blaise Boscaccy wrote:
>> There are two flavors of skeletons, normal skeletons, and light
>> skeletons. Normal skeletons utilize relocation logic that lives in
>> libbpf, and the relocations/instruction rewriting happen in userspace.
>> The second flavor, light skeletons, uses a small eBPF program that
>> contains the relocation lookup logic. As it's running in in the kernel,
>> it unpacks the target program, peforms the instruction rewriting, and
>> loads the target program. Light skeletons are currently utilized for
>> some drivers, and BPF_PRELOAD functionionality since they can operate
>> without userspace.
>> 
>> Light skeletons were recommended on various mailing list discussions as
>> the preffered path to performing signature verification. There are some
>> PoCs floating around that used light-skeletons in concert with
>> fs-verity/IMA and eBPF LSMs. We took a slightly different approach to
>> Hornet, by utilizing the existing PCKS#7 signing scheme that is used for
>> kernel modules.
>
> Right, because in the normal skeletons relocation logic remains
> unsigned?
>

Yup, Exactly. 

> I have to admit I don't fully cope how the relocation process translates
> into eBPF program but I do get how it is better for signatures if it
> does :-)
>
>> 
>> >> verification. Signature data can be easily generated for the binary
>> >
>> > s/easily//
>> >
>> > Useless word having no measure.
>> >
>> 
>> Ack, thanks.
>> 
>> 
>> >> data that is generated via bpftool gen -L. This signature can be
>> >
>> > I have no idea what that command does.
>> >
>> > "Signature data can be generated for the binary data as follows:
>> >
>> > bpftool gen -L
>> >
>> > <explanation>"
>> >
>> > Here you'd need to answer to couple of unknowns:
>> >
>> > 1. What is in exact terms "signature data"?
>> 
>> That is a PKCS#7 signature of a data buffer containing the raw
>> instructions of an eBPF program, followed by the initial values of any
>> maps used by the program. 
>
> Got it, thanks. This motivates to refine my TPM2 asymmetric keys
> series so that TPM2 could anchor these :-)
>
> https://lore.kernel.org/linux-integrity/20240528210823.28798-1-jarkko@kernel.org/
>
>

Oooh. That would be very nice :) 

>> 
>> > 2. What does "bpftool gen -L" do?
>> >
>> 
>> eBPF programs often have 2 parts. An orchestrator/loader program that
>> provides load -> attach/run -> i/o -> teardown logic and the in-kernel
>> program.
>> 
>> That command is used to generate a skeleton which can be used by the
>> orchestrator prgoram. Skeletons get generated as a C header file, that
>> contains various autogenerated functions that open and load bpf programs
>> as decribed above. That header file ends up being included in a
>> userspace orchestrator program or possibly a kernel module.
>
> I did read the man page now too, but thanks for the commentary!
>
>> 
>> > This feedback maps to other examples too in the cover letter.
>> >
>> > BR, Jarkko
>> 
>> 
>> I'll rework this with some definitions of the eBPF subsystem jargon
>> along with your suggestions.
>
> Yeah, you should be able to put the gist a factor better to nutshell :-)
>
>> 
>> -blaise
>
> BR, Jarkko

