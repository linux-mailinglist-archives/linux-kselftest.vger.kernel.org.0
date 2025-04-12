Return-Path: <linux-kselftest+bounces-30638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E69BA86D8A
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Apr 2025 16:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765ED8C73B8
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Apr 2025 14:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295391EA7D8;
	Sat, 12 Apr 2025 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RRMoS31T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CBE2367BC;
	Sat, 12 Apr 2025 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744467074; cv=none; b=W7BH6fFZOgcfNbI1ndf/3zugZ6EhMUopAgK/C2X1aSFcFm0E2nAhzAJOiyviArFV+FoQsAwvSIJzDXMEaV+Hf5j4m06fmXLGi+oE0d3VtFzi7nB0o8zKvqLlzsdhiZgWvRIDcsgLw9qCoOPNgA8PmOHFJQeIKI41XdcL8JE9wqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744467074; c=relaxed/simple;
	bh=6UupgWJqX74K4rb42t9zk7pR4gsrJNFwzwL4a7gqYCw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QuxKJC1Xd2yQsgMJrPOGmEo9tG5LWJvaXQiBz0b04jfWf0tyf6x7Y+LPP37ST3J3BCD9f4IlrPUll69/aBq7MkLvk+l66OCoLF7p2Cf1kggENjqnYyjafcl3Cm/QyxNruWpyIcRpfU+BD0vrko2iw4+IEJX/1cEOCGspRZZPnmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RRMoS31T; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7A2A321165B8;
	Sat, 12 Apr 2025 07:11:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A2A321165B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744467072;
	bh=pTnd2Oc8i8/ma8A52qza9zwPziCRMHwOGThxeMcufiE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RRMoS31T422OQGTx+ALxBabnWUobD2SGOF9kKhtax/Q9kNBsnMTF30iIo6s62oUcd
	 9hayyqT4XBOzTiMuXmDqpBpb3kjYL34C0pagTkdwl+BsCNobtK8HIYmwSTpnWM72sc
	 7MbXa9/e4EXJcrbLuqpTIOI03a2CVhMn3o5hgH1k=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Matteo Croce
 <technoboy85@gmail.com>
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
 Justin Stitt <justinstitt@google.com>, Jarkko Sakkinen
 <jarkko@kernel.org>, Jan Stancek <jstancek@redhat.com>, Neal Gompa
 <neal@gompa.dev>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, keyrings@vger.kernel.org, Linux
 Crypto Mailing List <linux-crypto@vger.kernel.org>, LSM List
 <linux-security-module@vger.kernel.org>, Linux Kbuild mailing list
 <linux-kbuild@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 clang-built-linux <llvm@lists.linux.dev>, nkapron@google.com, Matteo Croce
 <teknoraver@meta.com>, Roberto Sassu <roberto.sassu@huawei.com>, Cong Wang
 <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH v2 security-next 1/4] security: Hornet LSM
In-Reply-To: <CAADnVQJ5VaXVN=L+0ygEWJkMtPZnqAVEoeFiLBvikntX0zD49w@mail.gmail.com>
References: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com>
 <20250404215527.1563146-2-bboscaccy@linux.microsoft.com>
 <CAADnVQJyNRZVLPj_nzegCyo+BzM1-whbnajotCXu+GW+5-=P6w@mail.gmail.com>
 <CAFnufp1erGboUtRaqLoKC48c+9jmqzEfFW8W46xt77JMC0PFpQ@mail.gmail.com>
 <CAADnVQJ5VaXVN=L+0ygEWJkMtPZnqAVEoeFiLBvikntX0zD49w@mail.gmail.com>
Date: Sat, 12 Apr 2025 07:11:01 -0700
Message-ID: <87plhhjwqy.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Apr 11, 2025 at 5:30=E2=80=AFPM Matteo Croce <technoboy85@gmail.c=
om> wrote:
>>
>> Il giorno sab 12 apr 2025 alle ore 02:19 Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> ha scritto:
>>
>> Similar to what I proposed here?
>>
>> https://lore.kernel.org/bpf/20211203191844.69709-2-mcroce@linux.microsof=
t.com/
> ...
>> @@ -1346,6 +1346,8 @@ union bpf_attr {
>>   __aligned_u64 fd_array; /* array of FDs */
>>   __aligned_u64 core_relos;
>>   __u32 core_relo_rec_size; /* sizeof(struct bpf_core_relo) */
>> + __aligned_u64 signature; /* instruction's signature */
>> + __u32 sig_len; /* signature size */
>
> Well, yeah, two fields are obvious.
> But not like that link from 2021.
> KP proposed them a year later in 2022 on top of lskel
> which was much closer to be acceptable.
> We need to think it through and complete the work,
> since there are various ways to do it.
> For example, lskel has a map and a prog.
> A signature in a prog may cover both, but
> not necessary it's a good design.
> A signature for the map plus a signature for the prog
> that is tied to a map might be a better option.
> At map creation time the contents can be checked,
> the map is frozen, and then the verifier can proceed
> with prog's signature checking.
> lskel doesn't support all the bpf feature yet, so we need
> to make sure that the signature verification process
> is extensible when lskel gains new features.
>
> Attaching was also brought up at lsfmm.
> Without checking the attach point the whole thing is quite
> questionable from security pov.

That statement is quite questionable. Yes, IIRC you brought that up. And
again, runtime policy enforcement has nothing to do with proving code
provenance. They are completely independent concerns.

That would be akin to saying that having locks on a door is questionable
without having surveillance cameras installed.

