Return-Path: <linux-kselftest+bounces-21733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 306C39C2F9C
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 22:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509171C21047
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 21:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BB51A2846;
	Sat,  9 Nov 2024 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Epr4fNIs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C30019D064
	for <linux-kselftest@vger.kernel.org>; Sat,  9 Nov 2024 21:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731186712; cv=none; b=gIICowo5TtxTyvhcfkL+s/P3DK2Tvgn79S+XSybMpkOqe8JNCPNy44YMn8lKBFn0I9r0N99DWQXem+jFShF0qJTfULlK8XVxpp3AH9OQUpxbVTHIKqN3qr94SfaippsviQ4KIkmJvvsG1sEV+1eqYk24HbgBVuYda59C+E4+MCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731186712; c=relaxed/simple;
	bh=ABgMM+icK5ddNiMD+2j3K13rmHK3dfBaOBo3S2H0nVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inS/jljXMn4givKBmXdEg7qh0443LlhlRdr5yRCvlkd1pcaVTUyEaZkyQatLDha2ikUp7c5AIH2wT1qylBov5PLEK2fJfPXs4Zo0MODivvBbCFdFjIAEk8BXl8yIBvexbqIKlCi7Skfbw+S7d5z32+CACj2bqerM6b7ozCfOpLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Epr4fNIs; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9ed49ec0f1so574897066b.1
        for <linux-kselftest@vger.kernel.org>; Sat, 09 Nov 2024 13:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731186708; x=1731791508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzaEFRktAkP/klNBiZ+4cVbDvhXpkICC/aLo7wIIblk=;
        b=Epr4fNIsLr/Q9A6X3OKNfK8yFo+m/Y7wl0fw6/tY2f01yP2pkpodl1OcCHHueGTN5B
         xPt69W1enLtqw+iTDE0v4F9zk7AY8RteyJnfQX2Ux0nOYqWIa5cc97YDBwGZK5wncQvE
         phZOz+iR1X5Z9GrS6ITFoSy44N2Jb6vroIGSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731186708; x=1731791508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzaEFRktAkP/klNBiZ+4cVbDvhXpkICC/aLo7wIIblk=;
        b=enFlAG/226SwKVVqngyuuF+IDVjydRxDEsqoKHXvGWeCrh/VEw0HzcAkoZ95hCtuHO
         8bQg5qSedVFMM40stGDW/vGGMvpIY3D9C+CwUitMMLbejbnaCtrnTGbVTQWOL6cJIIbP
         pH09uI3iEYULBYUGENd4Nkk0Mtk2tFDF/prO9nTMSbBCdzkaUWeVlIb+N8khFLvy9R0F
         MWBVuzz35RWwLM+7V9aTu+bEkXka1zxkNHREql8SMRElb0JT5dH90fUtv23ig1LIbPup
         Uol6MxmOsOfpqP/6TkwUe0zgxRCG8R5bGoOUQxZdE1PIauaiRVMoe4O/sOXL3m43LbZc
         fkTA==
X-Forwarded-Encrypted: i=1; AJvYcCW5uisT3DhWpoQmb12Hy9QmPz7Ka7b9AaCvSGpJvHqU1/2GPSJ+vresjg5Lqu+l0JyyMh5f4jYxKRM12GaSPuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNvOxQWwEzELQN0atTscH0k4sYZHWnQ+/PUT9uA09ENh/KMWhv
	Ho+/eMyI7Qxpq0Krp2Bjhe3liCUWYO60PBmQgkkqdMLxsbZJYPSDIMtUCHVg+p9Enq/4LZZkHOn
	LQw+Tz+WY3L3JcXZ1qEMFDdJ56CBitY2pCP4UtdcNmPnn+RzZ/27Kr0I2PrV1qVBmjPpolezWgO
	GANwQHxIJq2fPlWTvP+T/wkqVX49rb4Q==
X-Google-Smtp-Source: AGHT+IFPcoJr8nElnRzhiZR4oQp1IJiFbpTh6X8yXbkRXn/08dHID1yw3BffYyZCmclFQvK6f6wwrWN6dDpKgJ1VYG8=
X-Received: by 2002:a17:907:8693:b0:a9a:1b32:5aa8 with SMTP id
 a640c23a62f3a-a9eefebd42dmr758229066b.4.1731186707577; Sat, 09 Nov 2024
 13:11:47 -0800 (PST)
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
 <e3f943a7-a40a-45cb-b0d9-e3ed58344d8b@redhat.com>
In-Reply-To: <e3f943a7-a40a-45cb-b0d9-e3ed58344d8b@redhat.com>
From: Doug Covelli <doug.covelli@broadcom.com>
Date: Sat, 9 Nov 2024 16:11:36 -0500
Message-ID: <CADH9ctD1uf_yBA3NXNQu7TJa_TPhLRN=0YZ3j2gGhgmaFRdCFg@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: x86: Add support for VMware guest specific hypercalls
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>, Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Joel Stanley <joel@jms.id.au>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 1:20=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> On 11/8/24 06:03, Zack Rusin wrote:
> >>> There's no spec but we have open headers listing the hypercalls.
> >>> There's about a 100 of them (a few were deprecated), the full
> >>> list starts here:
> >>> https://github.com/vmware/open-vm-tools/blob/739c5a2f4bfd4cdda491e6a6=
f6869d88c0bd6972/open-vm-tools/lib/include/backdoor_def.h#L97
> >>> They're not well documented, but the names are pretty self-explenator=
y.
> >>
> >> At a quick glance, this one needs to be handled in KVM:
> >>
> >>    BDOOR_CMD_VCPU_MMIO_HONORS_PAT
> >>
> >> and these probably should be in KVM:
> >>
> >>    BDOOR_CMD_GETTIME
> >>    BDOOR_CMD_SIDT
> >>    BDOOR_CMD_SGDT
> >>    BDOOR_CMD_SLDT_STR
> >>    BDOOR_CMD_GETTIMEFULL
> >>    BDOOR_CMD_VCPU_LEGACY_X2APIC_OK
> >>    BDOOR_CMD_STEALCLOCK
> >
> > I'm not sure if there's any value in implementing a few of them.
>
> The value is that some of these depend on what the hypervisor does, not
> on what userspace does.  For Hypervisor.framework you have a lot of
> leeway, for KVM and Hyper-V less so.
>
> Please understand that adding support for a closed spec is already a bit
> of a tall ask.  We can meet in the middle and make up for the
> closedness, but the way to do it is not technical; it's essentially
> trust.  You are the guys that know the spec and the userspace code best,
> so we trust you to make choices that make technical sense for both KVM
> and VMware.  But without a spec we even have to trust you on what makes
> sense or not to have in the kernel, so we ask you to be... honest about
> that.
>
> One important point is that from the KVM maintainers' point of view, the
> feature you're adding might be used by others and not just VMware
> Workstation.  Microsoft and Apple might see things differently (Apple in
> particular has a much thinner wrapper around the processor's
> virtualization capbilities).
>
> > iirc
> > there's 101 of them (as I mentioned a lot have been deprecated but
> > that's for userspace, on the host we still have to do something for
> > old guests using them) and, if out of those 101 we implement 100 in
> > the kernel then, as far as this patch is concerned, it's no different
> > than if we had 0 out of 101 because we're still going to have to exit
> > to userspace to handle that 1 remaining.
> >
> > Unless you're saying that those would be useful to you. In which case
> > I'd be glad to implement them for you, but I'd put them behind some
> > kind of a cap or a kernel config because we wouldn't be using them -
>
> Actually we'd ask you to _not_ put them behind a cap, and live with the
> kernel implementation.  Obviously that's not a requirement for all the
> 100+ hypercalls, only for those where it makes sense.
>
> > besides what Doug mentioned - we already maintain the shared code for
> > them that's used on Windows, MacOS, ESX and Linux so even if we had
> > them in the Linux kernel it would still make more sense to use the
> > code that's shared with the other OSes to lessen the maintenance
> > burden (so that changing anything within that code consistently
> > changes across all the OSes).
>
> If some of them can have shared code across all OSes, then that's a good
> sign that they do not belong in the kernel.  On the other hand, if the
> code is specific to Windows/macOS/ESX/Linux, and maybe it even calls
> into low-level Hypervisor.framework APIs on macOS, then it's possible or
> even likely that the best implementation for Linux is "just assume that
> KVM will do it" and assert(0).
>
> In yet other cases (maybe those SGDT/SLDT/STR/SIDT ones??), if the code
> that you have for Linux is "just do this KVM ioctl to do it", it may
> provide better performance if you save the roundtrip to userspace and
> back.  If KVM is the best performing hypervisor for VMware Workstation,
> then we're happy, :) and if you have some performance issue we want to
> help you too.

Appreciate the concern about performance however I don't think it is
something we should worry about.  Even with our existing VMM, which
runs at CPL0, all of these backdoor calls are handled by userspace
which means they are very slow (~28K cycles overhead on my Zen2) and
are not used in any perf critical code (if they were we would have
handled them at CPL0). Running on KVM the overhead is significantly
less.

As for the SGDT/SLDT/STR/SIDT backdoor calls these were added > 20
years ago for SW that used these instructions from CPL3 which did not
work well before VT/SVM were introduced.  These are really of no use
on modern CPUs and will be blocked if the guest OS has enabled UMIP.
Adding support for these to the KVM code would be a bit of a waste
IMHO  I have no objection to adding support for handling some backdoor
calls in the kernel if we find ones where it would be advantageous to
do so I'm just not aware of any where this would be the caase..

> A related topic is that a good implementation, equivalent to what the
> proprietary hypervisor implemented, might require adding a ioctl to
> query something that KVM currently does not provide (maybe the current
> steal clock? IIRC it's only available via a Xen ioctl, not a generic
> one).  In that case you'd need to contribute that extra API.  Doing that
> now is easier for both you guys and the KVM maintainers, so that's
> another reason to go through the list and share your findings.

For stolen time the backdoor call is used to enable the functionality
not to get/set the stolen time.  I agree that we would probably want
to do something KVM specific for this one however this is currently
really only supported by ESX (and only currently used by Photon OS) so
I don't think adding that support to KVM is critical.

> Anyway, one question apart from this: is the API the same for the I/O
> port and hypercall backdoors?

Yeah the calls and arguments are the same.  The hypercall based
interface is an attempt to modernize the backdoor since as you pointed
out the I/O based interface is kind of hacky as it bypasses the normal
checks for an I/O port access at CPL3.  It would be nice to get rid of
it but unfortunately I don't think that will happen in the foreseeable
future as there are a lot of existing VMs out there with older SW that
still uses this interface.

> >> I don't think it addresses Paolo's concern (if I understood Paolo's co=
ncern
> >> correctly), but it would help from the perspective of allowing KVM to =
support
> >> VMware hypercalls and Xen/Hyper-V/KVM hypercalls in the same VM.
> >
> > Yea, I just don't think there's any realistic way we could handle all
> > of those hypercalls in the kernel so I'm trying to offer some ideas on
> > how to lessen the scope to make it as painless as possible. Unless you
> > think we could somehow parlay my piercing blue eyes into getting those
> > patches in as is, in which case let's do that ;)
>
> Unlikely :) but it's not in bad shape at all!  The main remaining
> discussion point is the subset of hypercalls that need support in the
> kernel (either as a kernel implementation, or as a new ioctl).
> Hopefully the above guidelines will help you.
>
> >> I also think we should add CONFIG_KVM_VMWARE from the get-go, and if w=
e're feeling
> >> lucky, maybe even retroactively bury KVM_CAP_X86_VMWARE_BACKDOOR behin=
d that
> >> Kconfig.  That would allow limiting the exposure to VMware specific co=
de, e.g. if
> >> KVM does end up handling hypercalls in-kernel.  And it might deter abu=
se to some
> >> extent.
> >
> > I thought about that too. I was worried that even if we make it on by
> > default it will require quite a bit of handholding to make sure all
> > the distros include it, or otherwise on desktops Workstation still
> > wouldn't work with KVM by default, I also felt a little silly trying
> > to add a kernel config for those few lines that would be on pretty
> > much everywhere and since we didn't implement the vmware backdoor
> > functionality I didn't want to presume and try to shield a feature
> > that might be in production by others with a new kernel config.
> We don't have a huge number of such knobs but based on experience I
> expect that it will be turned off only by cloud providers or appliance
> manufacturers that want to reduce the attack surface.  If it's enabled
> by default, distros will generally leave it on.  You can also add "If
> unsure, say Y" to the help message as we already do in several cases.(*)
>
> In fact, if someone wants to turn it off, they will send the patch
> themselves to add CONFIG_KVM_VMWARE and it will be accepted.  So we
> might as well ask for it from the start. :)
>
> Thanks,
>
> Paolo
>
> (*) In fact I am wondering if we should flip the default for Xen, in the
> beginning it was just an Amazon thing but since then David has
> contributed support in QEMU and CI.  To be clear, I am *not* asking
> VMware for anything but selftests to make CONFIG_KVM_VMWARE default to
> enabled.
>

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

