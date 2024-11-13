Return-Path: <linux-kselftest+bounces-21952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDFB9C78CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 17:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7D81F25D32
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 16:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B2517084F;
	Wed, 13 Nov 2024 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hP0YXEQQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A5E166308
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Nov 2024 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515111; cv=none; b=O1DiPdiYmg4KyvwSYQoMAf5AziZ1UrMZnt/CAOCHwvTxPYXlBJ2SN37XAxma425c3yAL8J7iJgIoEG2iTaJHuc+/roTJbp5s2+vNJUgU9jXAnI9EhC+Dr6+Sh1psxoJbIQ90TAro+uFtsuTKwH2yAA919K7us24b9FJ4sLzOVtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515111; c=relaxed/simple;
	bh=y6i/0qTRyMh9lETN4Ye9twvdg8Wxz7dPA6jY3yicqOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afyrGDHF6J+C1n9mOydSWeiu2/ogcYm/Xqxh+9ZnSR/8dERcO/YhPjjmVkM1kJH+hc56aidyMx0H63k2bsMf3TRve5yHdDIG0Qzo/g5P7BWN83lsfeVRvwPZNYZOkYDj29w8LM9No96TTA+DoQCS/tN7B8dVDBJnQTUe3t9daJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hP0YXEQQ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa1e87afd31so222269766b.3
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Nov 2024 08:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731515108; x=1732119908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/M858qlW5NS4hrCv+aGxwOeEcSMA57ZDM8mnHjjY7bM=;
        b=hP0YXEQQC2alHZPIHxUwUMPypr1vE8AimujO96rOxvPDnhPEcQiMyaEiKq63yfpT7n
         zpbSzB/J7mPIAVLeQWMwXciCRwufXQm9HdX5qqtRT8n2YmyMHwZuapsV3LnZGKtj3xE/
         vDJTySZ35AuUqsLOiuy7bFT2zsDnEpm0OU1sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731515108; x=1732119908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/M858qlW5NS4hrCv+aGxwOeEcSMA57ZDM8mnHjjY7bM=;
        b=jiNImPqrZ7LCHKTMwlwJMmDuXaFUdhpUAo4rApiuC4CJjFa6o2ArQdxa5RaWlCREm/
         zL/+9GsBDJF53rbHSwMU3twTBZtchwhWba9fssZo51P5iiFHZYgvUbaIjP9He7u1hSsE
         zsY8jLS5lyPv/TWeAxpvg0kQ8nOY+5jri7bepYyzTExv7UOsVhozZdou/KafbsNa/enU
         FELyAwpl2Yn0J0pu6wFBXHL/IkiIcfDCKRLOZeuFUHuIo94avamz0TVIaCUkGB+a6Zpk
         zxSHdMK6cYgItKWOc45iEqkRUoircsn46UpgPwZB/BAzKk7Gtkklwk0I0zHhbOoNVypv
         jFVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX59DDctrW6SQnDL6M3wIIymnmWkFKlrsszzpC99Mli+ao8YWpVK0sJj7YgI/oTWx4HzECvsFbqGTSosOTnhGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw38JyEP+4iIhBSiqzKeABtauorGAt+lRZFDJe76/9PhQQAYvQG
	hBYy625ej0W/JWyUpxBDkvjFwt7d95F1vVnTLs3a/Tk+Zo9AVZvF7b5nHQ+MhcgkUaSaSYZ+xc4
	KVvpPaJzk3jy65ChsszQ67TWz685FPsSanvp2tgqoSKbwstEnopuXQa28zZszF9j6Q9H6pjnml/
	CL0v3Eko+vhfufzw3rz2Lc4VFf+8JnJQ==
X-Google-Smtp-Source: AGHT+IHaAsaeYf+CcicKi8+yeSIi5vRKMwifnXXjechN4O8b9oL83Zb7pR8yiHDzcnNh1KI8zX6aMZietLLLD0DRe3E=
X-Received: by 2002:a17:907:94cc:b0:a99:e619:260e with SMTP id
 a640c23a62f3a-a9eeff3775cmr2185139166b.28.1731515107870; Wed, 13 Nov 2024
 08:25:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030033514.1728937-1-zack.rusin@broadcom.com>
 <20241030033514.1728937-3-zack.rusin@broadcom.com> <CABgObfaRP6zKNhrO8_atGDLcHs=uvE0aT8cPKnt_vNHHM+8Nxg@mail.gmail.com>
 <CABQX2QMR=Nsn23zojFdhemR7tvGUz6_UM8Rgf6WLsxwDqoFtxg@mail.gmail.com>
 <Zy0__5YB9F5d0eZn@google.com> <CABQX2QNxFDhH1frsGpSQjSs3AWSdTibkxPrjq1QC7FGZC8Go-Q@mail.gmail.com>
 <e3f943a7-a40a-45cb-b0d9-e3ed58344d8b@redhat.com> <CADH9ctD1uf_yBA3NXNQu7TJa_TPhLRN=0YZ3j2gGhgmaFRdCFg@mail.gmail.com>
 <c3026876-8061-4ab2-9321-97cc05bad510@redhat.com> <CADH9ctBivnvP1tNcatLKzd8EDz8Oo6X65660j8ccxYzk3aFzCA@mail.gmail.com>
 <CABgObfZEyCQMiq6CKBOE7pAVzUDkWjqT2cgfbwjW-RseH8VkLw@mail.gmail.com>
 <CADH9ctA_C1dAOus1K+wOH_SOKTb=-X1sVawt5R=dkH1iGt8QUg@mail.gmail.com> <CABgObfZrTyft-3vqMz5w0ZiAhp-v6c32brgftynZGJO8OafrdA@mail.gmail.com>
In-Reply-To: <CABgObfZrTyft-3vqMz5w0ZiAhp-v6c32brgftynZGJO8OafrdA@mail.gmail.com>
From: Doug Covelli <doug.covelli@broadcom.com>
Date: Wed, 13 Nov 2024 11:24:56 -0500
Message-ID: <CADH9ctBYp-LMbW4hm3+QwNoXvAc5ryVeB0L1jLY0uDWSe3vbag@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: x86: Add support for VMware guest specific hypercalls
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>, Sean Christopherson <seanjc@google.com>, 
	kvm <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "the arch/x86 maintainers" <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Joel Stanley <joel@jms.id.au>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, 
	linux-kselftest <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 2:31=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
>
>
> Il mar 12 nov 2024, 21:44 Doug Covelli <doug.covelli@broadcom.com> ha scr=
itto:
>>
>> > Split irqchip should be the best tradeoff. Without it, moves from cr8
>> > stay in the kernel, but moves to cr8 always go to userspace with a
>> > KVM_EXIT_SET_TPR exit. You also won't be able to use Intel
>> > flexpriority (in-processor accelerated TPR) because KVM does not know
>> > which bits are set in IRR. So it will be *really* every move to cr8
>> > that goes to userspace.
>>
>> Sorry to hijack this thread but is there a technical reason not to allow=
 CR8
>> based accesses to the TPR (not MMIO accesses) when the in-kernel local A=
PIC is
>> not in use?
>
>
> No worries, you're not hijacking :) The only reason is that it would be m=
ore code for a seldom used feature and anyway with worse performance. (To b=
e clear, CR8 based accesses are allowed, but stores cause an exit in order =
to check the new TPR against IRR. That's because KVM's API does not have an=
 equivalent of the TPR threshold as you point out below).

I have not really looked at the code but it seems like it could also
simplify things as CR8 would be handled more uniformly regardless of
who is virtualizing the local APIC.

>> Also I could not find these documented anywhere but with MSFT's APIC our=
 monitor
>> relies on extensions for trapping certain events such as INIT/SIPI plus =
LINT0
>> and SVR writes:
>>
>> UINT64 X64ApicInitSipiExitTrap    : 1; // WHvRunVpExitReasonX64ApicInitS=
ipiTrap
>> UINT64 X64ApicWriteLint0ExitTrap  : 1; // WHvRunVpExitReasonX64ApicWrite=
Trap
>> UINT64 X64ApicWriteLint1ExitTrap  : 1; // WHvRunVpExitReasonX64ApicWrite=
Trap
>> UINT64 X64ApicWriteSvrExitTrap    : 1; // WHvRunVpExitReasonX64ApicWrite=
Trap
>
>
> There's no need for this in KVM's in-kernel APIC model. INIT and SIPI are=
 handled in the hypervisor and you can get the current state of APs via KVM=
_GET_MPSTATE. LINT0 and LINT1 are injected with KVM_INTERRUPT and KVM_NMI r=
espectively, and they obey IF/PPR and NMI blocking respectively, plus the i=
nterrupt shadow; so there's no need for userspace to know when LINT0/LINT1 =
themselves change. The spurious interrupt vector register is also handled c=
ompletely in kernel.

I realize that KVM can handle LINT0/SVR updates themselves but our
interrupt subsystem relies on knowing the current values of these
registers even when not virtualizing the local APIC.  I suppose we
could use KVM_GET_LAPIC to sync things up on demand but that seems
like it might nor be great from a performance point of view.

>> I did not see any similar functionality for KVM.  Does anything like tha=
t exist?
>> In any case we would be happy to add support for handling CR8 accesses w=
/o
>> exiting w/o the in-kernel APIC along with some sort of a way to configur=
e the
>> TPR threshold if folks are not opposed to that.
>
>
> As far I know everybody who's using KVM (whether proprietary or open sour=
ce) has had no need for that, so I don't think it's a good idea to make the=
 API more complex. Performance of Windows guests is going to be bad anyway =
with userspace APIC.

From what I have seen the exit cost with KVM is significantly lower
than with WHP/Hyper-V.  I don't think performance of Windows guests
with userspace APIC emulation would be bad if CR8 exits could be
avoided (Linux guests perf isn't bad from what I have observed and the
main difference is the astronomical number of CR8 exits).  It seems
like it would be pretty decent although I agree if you want the
absolute best performance then you would want to use the in kernel
APIC to speed up handling of ICR/EOI writes but those are relatively
infrequent compared to CR8 accesses .

Anyway I just saw Sean's response while writing this and it seems he
is not in favor of avoiding CR8 exits w/o the in kernel APIC either so
I suppose we will have to look into making use of the in kernel APIC.

Doug

> Paolo
>
>> Doug
>>
>> > > For now I think it makes sense to handle BDOOR_CMD_GET_VCPU_INFO at =
userlevel
>> > > like we do on Windows and macOS.
>> > >
>> > > BDOOR_CMD_GETTIME/BDOOR_CMD_GETTIMEFULL are similar with the former =
being
>> > > deprecated in favor of the latter.  Both do essentially the same thi=
ng which is
>> > > to return the host OS's time - on Linux this is obtained via gettime=
ofday.  I
>> > > believe this is mainly used by tools to fix up the VM's time when re=
suming from
>> > > suspend.  I think it is fine to continue handling these at userlevel=
.
>> >
>> > As long as the TSC is not involved it should be okay.
>> >
>> > Paolo
>> >
>> > > > >> Anyway, one question apart from this: is the API the same for t=
he I/O
>> > > > >> port and hypercall backdoors?
>> > > > >
>> > > > > Yeah the calls and arguments are the same.  The hypercall based
>> > > > > interface is an attempt to modernize the backdoor since as you p=
ointed
>> > > > > out the I/O based interface is kind of hacky as it bypasses the =
normal
>> > > > > checks for an I/O port access at CPL3.  It would be nice to get =
rid of
>> > > > > it but unfortunately I don't think that will happen in the fores=
eeable
>> > > > > future as there are a lot of existing VMs out there with older S=
W that
>> > > > > still uses this interface.
>> > > >
>> > > > Yeah, but I think it still justifies that the KVM_ENABLE_CAP API c=
an
>> > > > enable the hypercall but not the I/O port.
>> > > >
>> > > > Paolo
>> >
>>
>> --
>> This electronic communication and the information and any files transmit=
ted
>> with it, or attached to it, are confidential and are intended solely for
>> the use of the individual or entity to whom it is addressed and may cont=
ain
>> information that is confidential, legally privileged, protected by priva=
cy
>> laws, or otherwise restricted from disclosure to anyone else. If you are
>> not the intended recipient or the person responsible for delivering the
>> e-mail to the intended recipient, you are hereby notified that any use,
>> copying, distributing, dissemination, forwarding, printing, or copying o=
f
>> this e-mail is strictly prohibited. If you received this e-mail in error=
,
>> please return the e-mail to the sender, delete it from your computer, an=
d
>> destroy any printed copy of it.
>>

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

