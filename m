Return-Path: <linux-kselftest+bounces-30809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C58EA890B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 02:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD66A3B1B85
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 00:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A8822094;
	Tue, 15 Apr 2025 00:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YfJ5re8I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A19D1F61C;
	Tue, 15 Apr 2025 00:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744677138; cv=none; b=hzlN/+NuY6qSesxM7D1GbiPIaiOJWcla45vgXhNYHQzllY+uNtqIWoH3OhcaUtU3ZfLM5CZ13RNZXYNlhWX2qLtfrm7CrqM6icUIpld1qQ+hM5CBFwNDUyluTtZZONjq6PUpuNa6tnHMWJjyiwAA2mMpUDHBTAU+z/ku7gAEirQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744677138; c=relaxed/simple;
	bh=vI/xD/nrTGecQl3y389fRgZ/tck2vMLKZPV4brJj6LE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GJ/IiZ+dPd8+aLdorGS8dwfCz5pl9SASLdcCCt7jtas5vPvuu6EGBA2MuC2B6acSACuiILYutFhuflavkngTMg0Kc2I7CXahk4VObwoboksv7ZDd5e2zIM/rUVJZMwN0wwWHqJy3qw38596Nczah13+eUZZR0r9mX9UN88vtpa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YfJ5re8I; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id E107E210C430;
	Mon, 14 Apr 2025 17:32:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E107E210C430
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744677136;
	bh=k60Z/kqlCkeZutWGyU4+etQMD6oqlirPCtjxFVZ+g6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YfJ5re8IR3FnKDYCN5qrGYoU/+IkxYxrMaJ0i9vLUi7ndhbq2fgr/SO4ndfNToJwD
	 TawWKs7ImDCktfiL3GpIIffFv8bxMkEymbxUNw7B9OEt1Ju1tLD/et5L71FmUEE1oh
	 u3REw27PIsT0rXMVqc34Syu9qqy0hxmH0FrN5FbY=
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
In-Reply-To: <CAADnVQ+JGfwRgsoe2=EHkXdTyQ8ycn0D9nh1k49am++4oXUPHg@mail.gmail.com>
References: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com>
 <20250404215527.1563146-2-bboscaccy@linux.microsoft.com>
 <CAADnVQJyNRZVLPj_nzegCyo+BzM1-whbnajotCXu+GW+5-=P6w@mail.gmail.com>
 <87semdjxcp.fsf@microsoft.com>
 <CAADnVQ+JGfwRgsoe2=EHkXdTyQ8ycn0D9nh1k49am++4oXUPHg@mail.gmail.com>
Date: Mon, 14 Apr 2025 17:32:06 -0700
Message-ID: <87friajmd5.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Sat, Apr 12, 2025 at 6:58=E2=80=AFAM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
>>
>> TAlexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>> > On Fri, Apr 4, 2025 at 2:56=E2=80=AFPM Blaise Boscaccy
>> > <bboscaccy@linux.microsoft.com> wrote:
>> >> +
>> >> +static int hornet_find_maps(struct bpf_prog *prog, struct hornet_map=
s *maps)
>> >> +{
>> >> +       struct bpf_insn *insn =3D prog->insnsi;
>> >> +       int insn_cnt =3D prog->len;
>> >> +       int i;
>> >> +       int err;
>> >> +
>> >> +       for (i =3D 0; i < insn_cnt; i++, insn++) {
>> >> +               if (insn[0].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW)) {
>> >> +                       switch (insn[0].src_reg) {
>> >> +                       case BPF_PSEUDO_MAP_IDX_VALUE:
>> >> +                       case BPF_PSEUDO_MAP_IDX:
>> >> +                               err =3D add_used_map(maps, insn[0].im=
m);
>> >> +                               if (err < 0)
>> >> +                                       return err;
>> >> +                               break;
>> >> +                       default:
>> >> +                               break;
>> >> +                       }
>> >> +               }
>> >> +       }
>> >
>> > ...
>> >
>> >> +               if (!map->frozen) {
>> >> +                       attr.map_fd =3D fd;
>> >> +                       err =3D kern_sys_bpf(BPF_MAP_FREEZE, &attr, s=
izeof(attr));
>> >
>> > Sorry for the delay. Still swamped after conferences and the merge win=
dow.
>> >
>>
>> No worries.
>>
>> > Above are serious layering violations.
>> > LSMs should not be looking that deep into bpf instructions.
>>
>> These aren't BPF internals; this is data passed in from
>> userspace. Inspecting userspace function inputs is definitely within the
>> purview of an LSM.
>>
>> Lskel signature verification doesn't actually need a full disassembly,
>> but it does need all the maps used by the lskel. Due to API design
>> choices, this unfortunately requires disassembling the program to see
>> which array indexes are being used.
>>
>> > Calling into sys_bpf from LSM is plain nack.
>> >
>>
>> kern_sys_bpf is an EXPORT_SYMBOL, which means that it should be callable
>> from a module.
>
> It's a leftover.
> kern_sys_bpf() is not something that arbitrary kernel
> modules should call.
> It was added to work for cases where kernel modules
> carry their own lskels.
> That use case is gone, so EXPORT_SYMBOL will be removed.
>

I'm not following that at all. You recommended using module-based lskels
to get around code signing requirements at lsfmmbpf and now you want to
nuke that entire feature? And further, skel_internal will no longer be
usable from within the kernel and bpf_preload is no longer going to be
supported?

>> Lskels without frozen maps are vulnerable to a TOCTOU
>> attack from a sufficiently privileged user. Lskels currently pass
>> unfrozen maps into the kernel, and there is nothing stopping someone
>> from modifying them between BPF_PROG_LOAD and BPF_PROG_RUN.
>>
>> > The verification of module signatures is a job of the module loading p=
rocess.
>> > The same thing should be done by the bpf system.
>> > The signature needs to be passed into sys_bpf syscall
>> > as a part of BPF_PROG_LOAD command.
>> > It probably should be two new fields in union bpf_attr
>> > (signature and length),
>> > and the whole thing should be processed as part of the loading
>> > with human readable error reported back through the verifier log
>> > in case of signature mismatch, etc.
>> >
>>
>> I don't necessarily disagree, but my main concern with this is that
>> previous code signing patchsets seem to get gaslit or have the goalposts
>> moved until they die or are abandoned.
>
> Previous attempts to add signing failed because
> 1. It's a difficult problem to solve
> 2. people only cared about their own narrow use case and not
> considering the needs of bpf ecosystem as a whole.
>
>> Are you saying that at this point, you would be amenable to an in-tree
>> set of patches that enforce signature verification of lskels during
>> BPF_PROG_LOAD that live in syscall.c,
>
> that's the only way to do it.
>

So the notion of forcing people into writing bpf-based gatekeeper programs
is being abandoned? e.g.

https://lore.kernel.org/bpf/bqxgv2tqk3hp3q3lcdqsw27btmlwqfkhyg6kohsw7lwdgbe=
ol7@nkbxnrhpn7qr/#t
https://lore.kernel.org/bpf/61aae2da8c7b0_68de0208dd@john.notmuch/


>> without adding extra non-code
>> signing requirements like attachment point verification, completely
>> eBPF-based solutions, or rich eBPF-based program run-time policy
>> enforcement?
>
> Those are secondary considerations that should also be discussed.
> Not necessarily a blocker.

Again, I'm confused here since you recently stated this whole thing
was "questionable" without attachment point verification.

