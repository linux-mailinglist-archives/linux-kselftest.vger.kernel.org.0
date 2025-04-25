Return-Path: <linux-kselftest+bounces-31665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F458A9D469
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 23:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F7D3B7464
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 21:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EC1226161;
	Fri, 25 Apr 2025 21:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VVfli0Z9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68EA21CC49;
	Fri, 25 Apr 2025 21:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617494; cv=none; b=k2ztJtthrrQ3Yi64HfONB9zPZI93wrf6STc5TQeFMsmLVFGVc3oaeMnD49dx+anpzYyJ9+BRrOsCfG3NYJOL7P7YyokhjhKOXomdbEuQpc6RGTVMyQMEC1G6tzGcw0KEO8j0+au+azMErLBleISUnP+SDuje9dQrMuNXb+O0MU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617494; c=relaxed/simple;
	bh=1vYY0G6paJDxqTAFql3Fe/ZoYlYAWMsKFG17ZpHlpB4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=usXlNaPpU+GGl3BJAqPCxJek93fQharcQEjuc5B6y8OY6sujyw4qgEffhQiS0vXtI4FqWJ0V9pQWMvmDK1R3A0eAWBtgRQ9pB5mYhQtSn8Ewp4izbXJ54NygdB0nayp1QJIapjLrccSyMIIF8wI4plnRx3jrrhx6aqEVsWqIt4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VVfli0Z9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [172.172.34.12])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0FD7420BCAD1;
	Fri, 25 Apr 2025 14:44:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0FD7420BCAD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745617492;
	bh=RLcGrvY/Ji6RfwBGa0SDop5ZSdaFF8Vony2mUDrwhz8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VVfli0Z9/uOSWmD2zYfgd/ELGgJQhQObtxaSQgX4AL7uZlqTSEwxa/QkcFRUrFG4L
	 KJe067jmKGvAEhgwx3y2k+RRnXnuiRFkSXZNrkzp+VuQoskURv0DCiZeNXTaiElj12
	 7XOVymm5fhm6nTTtITxxB973eE6OhvwrFoFeXnVA=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Alexei
 Starovoitov <alexei.starovoitov@gmail.com>, KP Singh <kpsingh@google.com>,
 Paul Moore <paul@paul-moore.com>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
 <davem@davemloft.net>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 Shuah Khan <shuah@kernel.org>, =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther?=
 Noack <gnoack@google.com>, Nick Desaulniers
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
In-Reply-To: <6e086e29d258839e42ef7a83b38571d1882eb77d.camel@HansenPartnership.com>
References: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com>
 <20250404215527.1563146-2-bboscaccy@linux.microsoft.com>
 <CAADnVQJyNRZVLPj_nzegCyo+BzM1-whbnajotCXu+GW+5-=P6w@mail.gmail.com>
 <87semdjxcp.fsf@microsoft.com>
 <CAADnVQ+JGfwRgsoe2=EHkXdTyQ8ycn0D9nh1k49am++4oXUPHg@mail.gmail.com>
 <87friajmd5.fsf@microsoft.com>
 <CAADnVQKb3gPBFz+n+GoudxaTrugVegwMb8=kUfxOea5r2NNfUA@mail.gmail.com>
 <87a58hjune.fsf@microsoft.com>
 <CAADnVQ+LMAnyT4yV5iuJ=vswgtUu97cHKnvysipc6o7HZfEbUA@mail.gmail.com>
 <87y0w0hv2x.fsf@microsoft.com>
 <CAADnVQKF+B_YYwOCFsPBbrTBGKe4b22WVJFb8C0PHGmRAjbusQ@mail.gmail.com>
 <2bd95ca78e836db0775da8237792e8448b8eec62.camel@HansenPartnership.com>
 <CAADnVQJ6SRePz7yc5x3BAz7q-e8DVYq=vRdahxCZ4XzpWtnYpQ@mail.gmail.com>
 <6e086e29d258839e42ef7a83b38571d1882eb77d.camel@HansenPartnership.com>
Date: Fri, 25 Apr 2025 14:44:10 -0700
Message-ID: <87bjsjlxw5.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> On Thu, 2025-04-24 at 16:41 -0700, Alexei Starovoitov wrote:
>> On Wed, Apr 23, 2025 at 7:12=E2=80=AFAM James Bottomley
>> <James.Bottomley@hansenpartnership.com> wrote:
>> > On Mon, 2025-04-21 at 13:12 -0700, Alexei Starovoitov wrote:
>> > [...]
>> > > Calling bpf_map_get() and
>> > > map->ops->map_lookup_elem() from a module is not ok either.
>> >=20
>> > I don't understand this objection.
>>=20
>> Consider an LSM that hooks into security_bprm_*(bprm),
>> parses something in linux_binprm, then
>> struct file *file =3D
>> fd_file(fdget(some_random_file_descriptor_in_current));
>> file->f_op->read(..);
>>=20
>> Would VFS maintainers approve such usage ?
>
> This is a bit off topic from the request for clarification but:
>
> It's somewhat standard operating procedure for LSMs.  Some do make
> decisions entirely within the data provided by the hook, but some need
> to take external readings, like selinux or IMA consulting the policy in
> the xattr or apparmor the one in the tree etc.
>
> Incidentally, none of them directly does a file->f_op->read(); they all
> use the kernel_read_file() API which is exported from the vfs for that
> purpose.
>
>> More so, your LSM does
>> file =3D get_task_exe_file(current);
>> kernel_read_file(file, ...);
>>=20
>> This is even worse.
>> You've corrupted the ELF binary with extra garbage at the end.
>> objdump/elfutils will choke on it and you're lucky that binfmt_elf
>> still loads it.
>> The whole approach is a non-starter.
>
> It's the same approach we use to create kernel modules: ELF with an
> appended signature.  If you recall the kernel summit discussions about
> it, the reason that was chosen for modules is because it's easy and the
> ELF processor simply ignores any data in the file that's not described
> by the header (which means the ELF tools you refer to above are fine
> with this if you actually try them).
>
> But it you really want the signature to be part of the ELF,  then the
> patch set can do what David Howells first suggested for modules: it can
> simply put the appended signature into an unloaded ELF section.
>
>> > The program just got passed in to bpf_prog_load() as a set of
>> > attributes which, for a light skeleton, directly contain the code
>> > as a blob and have the various BTF relocations as a blob in a
>> > single element array map.=C2=A0 I think everyone agrees that the
>> > integrity of the program would be compromised by modifications to
>> > the relocations, so the security_bpf_prog_load() hook can't make an
>> > integrity determination without examining both.=C2=A0 If the hook can't
>> > use the bpf_maps.. APIs directly is there some other API it should
>> > be using to get the relocations, or are you saying that the
>> > security_bpf_prog_load() hook isn't fit for purpose and it should
>> > be called after the bpf core has loaded the relocations so they can
>> > be provided to the hook as an argument?
>>=20
>> No. As I said twice already the only place to verify program
>> signature is a bpf subsystem itself.
>
> The above argument is actually independent of signing.  However,
> although we have plenty of subsystems that verify their own signatures,
> it's perfectly valid for a LSM to do it as well: IMA is one of the
> oldest LSMs and it's been verifying signatures over binaries and text
> files since it was first created.
>
>> Hacking into bpf internals from LSM, BPF-LSM program,
>> or any other kernel subsystem is a no go.
>
> All LSMs depend to some extent on the internals of the subsystem where
> the hook is ... the very structures passed into them are often internal
> to that subsystem.  The problem you didn't address was that some of the
> information necessary to determine the integrity properties in the bpf
> hook is in a map file descriptor.  Since the map merely wraps a single
> blob of data, that could easily be passed in to the hook instead of
> having the LSM extract it from the map.  How the hook gets the data is
> an internal implementation detail of the kernel that can be updated
> later.
>
>> > The above, by the way, is independent of signing, because it
>> > applies to any determination that might be made in the
>> > security_bpf_prog_load() hook regardless of purpose.
>>=20
>> security_bpf_prog_load() should not access bpf internals.
>> That LSM hook sees the following:
>> security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bpf_tok=
en *token, bool kernel);
>>=20
>> LSM can look into uapi things there.
>
> Is that the misunderstanding? That's not how LSMs work: they are not
> bound by only the UAPI, they are in kernel and have full access to the
> kernel API so they can introspect stuff and make proper determinations.
>
>> Like prog->sleepable, prog->tag, prog->aux->name,
>> but things like prog->aux->jit_data or prog->aux->used_maps
>> are not ok to access.
>> If in doubt, ask on the mailing list.
>
> I am aren't I? At least the bpf is one of the lists cc'd on this.
>
> Regards,
>
> James

I think we may be in the weeds here a bit and starting to get a little
off-topic. Let's try to back up some and take a different tack. We are
going to rework this effort into a set of patches that target the bpf
subsystem and it's tooling directly, performing optional signature
verification of the inputs to bpf_prog_load, using signature data
passed in via bpf_attr, which should enough provide metadata so that it
can be consumed by interested parties to enforce policy decisions around
code signing and data integrity.

-blaise

