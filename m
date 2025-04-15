Return-Path: <linux-kselftest+bounces-30893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C94A8A77A
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 21:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A5216E75D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 19:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1213B23D2A5;
	Tue, 15 Apr 2025 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AS9yEFHC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE6A23BF91;
	Tue, 15 Apr 2025 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744131; cv=none; b=p7cvhgvahEe6jZzfe98wtRev97PAHGeULPQpZJyAHVO45E+u2drjOWQegd9TLUp+8DfhBpMO7VJCp5t8w2/X6wpVju/Ab9jyqykHj4jyaxLm5GQKbpB/GBdvRzcOgDAXEqs+4zdsLQLrm2NWrx0IkRaj6plcNVWQHqvFDRMYLjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744131; c=relaxed/simple;
	bh=4eWiV3xFSoCwxXhSUAmK+LTrSgb/zidrUlBszwJv2G8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hb7afgbbjEhWEb0AmUqoz5zWtFpNGLxeALnBXsfP3OOkrHVCvPLY7seb6+/sochTlS4B7ZAqhkgL3iBl0C2zMCi3BQc9gLp3p+syd5qeO+Ib4DwbZbBvm4/9YctXRJgEY26lgn8y6AZv7vMCz0V7eMjRo66bOl9N0YvNr0EMlTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AS9yEFHC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id C6928210C44B;
	Tue, 15 Apr 2025 12:08:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C6928210C44B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744744124;
	bh=BdAKgQD8XvssHU2ejUtRgPSTUQI3oZF7Hbk69mY3whE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AS9yEFHCRtFQdy/Co3VaXp6LM+zR5raFycED9EFImPEQbvThLkYHd3TPauwA8DfN6
	 4+MYqpFx6UrSh/E11pLyX0OFZ9wJmP7h3Vmy18TWalhknx2D+noUDWNvn5ftisxJJF
	 0pDGP7uDpemcGPaz7+EFXOweCPdLu0+b8gWD20LU=
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
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Jarkko Sakkinen
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
In-Reply-To: <87a58hjune.fsf@microsoft.com>
References: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com>
 <20250404215527.1563146-2-bboscaccy@linux.microsoft.com>
 <CAADnVQJyNRZVLPj_nzegCyo+BzM1-whbnajotCXu+GW+5-=P6w@mail.gmail.com>
 <87semdjxcp.fsf@microsoft.com>
 <CAADnVQ+JGfwRgsoe2=EHkXdTyQ8ycn0D9nh1k49am++4oXUPHg@mail.gmail.com>
 <87friajmd5.fsf@microsoft.com>
 <CAADnVQKb3gPBFz+n+GoudxaTrugVegwMb8=kUfxOea5r2NNfUA@mail.gmail.com>
 <87a58hjune.fsf@microsoft.com>
Date: Tue, 15 Apr 2025 12:08:34 -0700
Message-ID: <874iypjl8t.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Blaise Boscaccy <bboscaccy@linux.microsoft.com> writes:

> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
>> On Mon, Apr 14, 2025 at 5:32=E2=80=AFPM Blaise Boscaccy
>> <bboscaccy@linux.microsoft.com> wrote:
>>>
>>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>>
>>> > On Sat, Apr 12, 2025 at 6:58=E2=80=AFAM Blaise Boscaccy
>>> > <bboscaccy@linux.microsoft.com> wrote:
>>> >>
>>> >> TAlexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>> >>
>>> >> > On Fri, Apr 4, 2025 at 2:56=E2=80=AFPM Blaise Boscaccy
>>> >> > <bboscaccy@linux.microsoft.com> wrote:
>>> >> >> +
>>> >> >> +static int hornet_find_maps(struct bpf_prog *prog, struct hornet=
_maps *maps)
>>> >> >> +{
>>> >> >> +       struct bpf_insn *insn =3D prog->insnsi;
>>> >> >> +       int insn_cnt =3D prog->len;
>>> >> >> +       int i;
>>> >> >> +       int err;
>>> >> >> +
>>> >> >> +       for (i =3D 0; i < insn_cnt; i++, insn++) {
>>> >> >> +               if (insn[0].code =3D=3D (BPF_LD | BPF_IMM | BPF_D=
W)) {
>>> >> >> +                       switch (insn[0].src_reg) {
>>> >> >> +                       case BPF_PSEUDO_MAP_IDX_VALUE:
>>> >> >> +                       case BPF_PSEUDO_MAP_IDX:
>>> >> >> +                               err =3D add_used_map(maps, insn[0=
].imm);
>>> >> >> +                               if (err < 0)
>>> >> >> +                                       return err;
>>> >> >> +                               break;
>>> >> >> +                       default:
>>> >> >> +                               break;
>>> >> >> +                       }
>>> >> >> +               }
>>> >> >> +       }
>>> >> >
>>> >> > ...
>>> >> >
>>> >> >> +               if (!map->frozen) {
>>> >> >> +                       attr.map_fd =3D fd;
>>> >> >> +                       err =3D kern_sys_bpf(BPF_MAP_FREEZE, &att=
r, sizeof(attr));
>>> >> >
>>> >> > Sorry for the delay. Still swamped after conferences and the merge=
 window.
>>> >> >
>>> >>
>>> >> No worries.
>>> >>
>>> >> > Above are serious layering violations.
>>> >> > LSMs should not be looking that deep into bpf instructions.
>>> >>
>>> >> These aren't BPF internals; this is data passed in from
>>> >> userspace. Inspecting userspace function inputs is definitely within=
 the
>>> >> purview of an LSM.
>>> >>
>>> >> Lskel signature verification doesn't actually need a full disassembl=
y,
>>> >> but it does need all the maps used by the lskel. Due to API design
>>> >> choices, this unfortunately requires disassembling the program to see
>>> >> which array indexes are being used.
>>> >>
>>> >> > Calling into sys_bpf from LSM is plain nack.
>>> >> >
>>> >>
>>> >> kern_sys_bpf is an EXPORT_SYMBOL, which means that it should be call=
able
>>> >> from a module.
>>> >
>>> > It's a leftover.
>>> > kern_sys_bpf() is not something that arbitrary kernel
>>> > modules should call.
>>> > It was added to work for cases where kernel modules
>>> > carry their own lskels.
>>> > That use case is gone, so EXPORT_SYMBOL will be removed.
>>> >
>>>
>>> I'm not following that at all. You recommended using module-based lskels
>>> to get around code signing requirements at lsfmmbpf and now you want to
>>> nuke that entire feature? And further, skel_internal will no longer be
>>> usable from within the kernel and bpf_preload is no longer going to be
>>> supported?
>
> The eBPF dev community has spent what, 4-5 years on this, with little to
> no progress. I have little faith that this is going to progress on your
> end in a timely manner or at all, and frankly we (and others) needed
> this yesterday. Hornet has zero impact on the bpf subsystem, yet you
> seem viscerally opposed to us doing this. Why are you trying to stop us
> from securing our cloud?
>
>>
>> It was exported to modules to run lskel-s from modules.
>> It's bpf internal api, but seeing how you want to abuse it
>> the feature has to go. Sadly.
>>

In the interest of not harming downstream users that possibly rely on
BPF_PRELOAD, it would be completely fine on our end to not call
kern_sys_bpf since maps can easily be frozen in userspace by the
loader. I'd prefer LSMs to be not mutating things if at all possible as
well.

If we agreed to not call that function so-as you can keep that
feature for everyone, would you be ammenable to a simple patch in
skel_internal.h that freezes maps? e.g


diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 4d5fa079b5d6..51e72dc23062 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -263,6 +263,17 @@ static inline int skel_map_delete_elem(int fd, const v=
oid *key)
        return skel_sys_bpf(BPF_MAP_DELETE_ELEM, &attr, attr_sz);
 }
=20
+static inline int skel_map_freeze(int fd)
+{
+       const size_t attr_sz =3D offsetofend(union bpf_attr, map_fd);
+       union bpf_attr attr;
+
+       memset(&attr, 0, attr_sz);
+       attr.map_fd =3D fd;
+
+       return skel_sys_bpf(BPF_MAP_FREEZE, &attr, attr_sz);
+}
+
 static inline int skel_map_get_fd_by_id(__u32 id)
 {
        const size_t attr_sz =3D offsetofend(union bpf_attr, flags);
@@ -327,6 +338,13 @@ static inline int bpf_load_and_run(struct bpf_load_and=
_run_opts *opts)
                goto out;
        }
=20
+       err =3D skel_map_freeze(map_fd);
+       if (err < 0) {
+               opts->errstr =3D "failed to freeze map";
+               set_err;
+               goto out;
+       }
+
        memset(&attr, 0, prog_load_attr_sz);
        attr.prog_type =3D BPF_PROG_TYPE_SYSCALL;
        attr.insns =3D (long) opts->insns;

>>> >> Lskels without frozen maps are vulnerable to a TOCTOU
>>> >> attack from a sufficiently privileged user. Lskels currently pass
>>> >> unfrozen maps into the kernel, and there is nothing stopping someone
>>> >> from modifying them between BPF_PROG_LOAD and BPF_PROG_RUN.
>>> >>
>>> >> > The verification of module signatures is a job of the module loadi=
ng process.
>>> >> > The same thing should be done by the bpf system.
>>> >> > The signature needs to be passed into sys_bpf syscall
>>> >> > as a part of BPF_PROG_LOAD command.
>>> >> > It probably should be two new fields in union bpf_attr
>>> >> > (signature and length),
>>> >> > and the whole thing should be processed as part of the loading
>>> >> > with human readable error reported back through the verifier log
>>> >> > in case of signature mismatch, etc.
>>> >> >
>>> >>
>>> >> I don't necessarily disagree, but my main concern with this is that
>>> >> previous code signing patchsets seem to get gaslit or have the goalp=
osts
>>> >> moved until they die or are abandoned.
>>> >
>>> > Previous attempts to add signing failed because
>>> > 1. It's a difficult problem to solve
>>> > 2. people only cared about their own narrow use case and not
>>> > considering the needs of bpf ecosystem as a whole.
>>> >
>>> >> Are you saying that at this point, you would be amenable to an in-tr=
ee
>>> >> set of patches that enforce signature verification of lskels during
>>> >> BPF_PROG_LOAD that live in syscall.c,
>>> >
>>> > that's the only way to do it.
>>> >
>>>
>>> So the notion of forcing people into writing bpf-based gatekeeper progr=
ams
>>> is being abandoned? e.g.
>>>
>>> https://lore.kernel.org/bpf/bqxgv2tqk3hp3q3lcdqsw27btmlwqfkhyg6kohsw7lw=
dgbeol7@nkbxnrhpn7qr/#t
>>> https://lore.kernel.org/bpf/61aae2da8c7b0_68de0208dd@john.notmuch/
>>
>> Not abandoned.
>> bpf-based tuning of load conditions is still necessary.
>> The bpf_prog_load command will check the signature only.
>> It won't start rejecting progs that don't have a signature.
>> For that a one liner bpf-lsm or C-based lsm would be needed
>> to address your dont-trust-root use case.
>>
>
> Since this will require an LSM no matter what, there is zero reason for
> us not to proceed with Hornet. If or when you actually figure out how to
> sign an lskel and upstream updated LSM hooks, I can always rework Hornet
> to use that instead.
>
>>>
>>> >> without adding extra non-code
>>> >> signing requirements like attachment point verification, completely
>>> >> eBPF-based solutions, or rich eBPF-based program run-time policy
>>> >> enforcement?
>>> >
>>> > Those are secondary considerations that should also be discussed.
>>> > Not necessarily a blocker.
>>>
>>> Again, I'm confused here since you recently stated this whole thing
>>> was "questionable" without attachment point verification.
>>
>> Correct.
>> For fentry prog type the attachment point is checked during the load,
>> but for tracepoints it's not, and anyone who is claiming that
>> their system is secure because the tracepoint prog was signed
>> is simply clueless in how bpf works.
>
> No one is making that claim, although I do appreciate the lovely
> ad-hominem attack and absolutist standpoint. It's not like we invented
> code signing last week. All we are trying to do is make our cloud
> ever-so-slightly more secure and share the results with the community.
>
> The attack vectors I'm looking at are things like CVE-2021-33200. ACLs
> for attachment points do nothing to stop that whereas code signing is a
> possible countermeasure. This kind of thing is probably a non-issue with
> your private cloud, but it's a very real issue with publicly accessible
> ones.=20=20

