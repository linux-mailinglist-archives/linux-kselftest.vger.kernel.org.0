Return-Path: <linux-kselftest+bounces-30637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8ABA86D67
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Apr 2025 15:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7178A46B4
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Apr 2025 13:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823B91E0DD9;
	Sat, 12 Apr 2025 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ctRJGxUn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DA9142E86;
	Sat, 12 Apr 2025 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744466297; cv=none; b=uxtpnsz0+5+8dekw2y4gv6B3Pwslsplz8f/yIWuzsHc26V5EQhgMS9S4NLj8VYM/o+wr0rBjUzl50hc8fd1XTPqBHPPimsmwYUV1LnIigLCLtqsa+j4yk4KrPQ2cmEmwPSW1zarDP1EhlwBh1mOqfBp07OEDNKxonyEn12KA8x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744466297; c=relaxed/simple;
	bh=ClLf6pd9bTzI1Zy4+TxzeK0uSIR+DiZghc9j4o2x+1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hpb2x9cTH1yObEWkY3L70xyAqfXUz3H1Wgx5Y5lwW/0JtPztVCKdoNZzNReAxJWq0cnTlwKFBYKRP+OFVvQbraTbaG6h7b0hPQa9Hapsx5OW4mpFwENKvbkAVkluAylAnrgWtIgLbKoCW9XWjaSJwIFAB3wzw0iDDTDqJfv9kW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ctRJGxUn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 25D6621165B8;
	Sat, 12 Apr 2025 06:58:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 25D6621165B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744466289;
	bh=zu0xtIux+vB60++y6tlbnAcAeCnE8i9Dvqd2crr17VQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ctRJGxUnarL1x3rwLFV8mBmNc3kTQ8bmhzgl86pwB64rU7x4F0uR0RbSDZRhN8fWK
	 6NogRPkUANeXVftTcHYLC9sqh+m90vMBzrg0ZVAZkdyJn9b+Qn84ZMDf/eNxvrDQZW
	 KQKb2GNF3XL4OSER5Fbnwana9xHXUnJlDRHrDfW4=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
In-Reply-To: <CAADnVQJyNRZVLPj_nzegCyo+BzM1-whbnajotCXu+GW+5-=P6w@mail.gmail.com>
References: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com>
 <20250404215527.1563146-2-bboscaccy@linux.microsoft.com>
 <CAADnVQJyNRZVLPj_nzegCyo+BzM1-whbnajotCXu+GW+5-=P6w@mail.gmail.com>
Date: Sat, 12 Apr 2025 06:57:58 -0700
Message-ID: <87semdjxcp.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

TAlexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Apr 4, 2025 at 2:56=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
>> +
>> +static int hornet_find_maps(struct bpf_prog *prog, struct hornet_maps *=
maps)
>> +{
>> +       struct bpf_insn *insn =3D prog->insnsi;
>> +       int insn_cnt =3D prog->len;
>> +       int i;
>> +       int err;
>> +
>> +       for (i =3D 0; i < insn_cnt; i++, insn++) {
>> +               if (insn[0].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW)) {
>> +                       switch (insn[0].src_reg) {
>> +                       case BPF_PSEUDO_MAP_IDX_VALUE:
>> +                       case BPF_PSEUDO_MAP_IDX:
>> +                               err =3D add_used_map(maps, insn[0].imm);
>> +                               if (err < 0)
>> +                                       return err;
>> +                               break;
>> +                       default:
>> +                               break;
>> +                       }
>> +               }
>> +       }
>
> ...
>
>> +               if (!map->frozen) {
>> +                       attr.map_fd =3D fd;
>> +                       err =3D kern_sys_bpf(BPF_MAP_FREEZE, &attr, size=
of(attr));
>
> Sorry for the delay. Still swamped after conferences and the merge window.
>

No worries.

> Above are serious layering violations.
> LSMs should not be looking that deep into bpf instructions.

These aren't BPF internals; this is data passed in from
userspace. Inspecting userspace function inputs is definitely within the
purview of an LSM.

Lskel signature verification doesn't actually need a full disassembly,
but it does need all the maps used by the lskel. Due to API design
choices, this unfortunately requires disassembling the program to see
which array indexes are being used.

> Calling into sys_bpf from LSM is plain nack.
>

kern_sys_bpf is an EXPORT_SYMBOL, which means that it should be callable
from a module. Lskels without frozen maps are vulnerable to a TOCTOU
attack from a sufficiently privileged user. Lskels currently pass
unfrozen maps into the kernel, and there is nothing stopping someone
from modifying them between BPF_PROG_LOAD and BPF_PROG_RUN.

> The verification of module signatures is a job of the module loading proc=
ess.
> The same thing should be done by the bpf system.
> The signature needs to be passed into sys_bpf syscall
> as a part of BPF_PROG_LOAD command.
> It probably should be two new fields in union bpf_attr
> (signature and length),
> and the whole thing should be processed as part of the loading
> with human readable error reported back through the verifier log
> in case of signature mismatch, etc.
>

I don't necessarily disagree, but my main concern with this is that
previous code signing patchsets seem to get gaslit or have the goalposts
moved until they die or are abandoned.

Are you saying that at this point, you would be amenable to an in-tree
set of patches that enforce signature verification of lskels during
BPF_PROG_LOAD that live in syscall.c, without adding extra non-code
signing requirements like attachment point verification, completely
eBPF-based solutions, or rich eBPF-based program run-time policy
enforcement?

Our entire use case for this is simply "we've signed all code running in
ring 0," nothing more. I'm concerned that code signing may be blocked
forever while eBPF attempts to reinvent its own runtime policy framework
that has absolutely nothing to do with proving code provenance.

> What LSM can do in addition is to say that if the signature is not
> specified in the prog_load command then deny such request outright.
> bpf syscall itself will deny program loading if signature is incorrect.

