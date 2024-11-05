Return-Path: <linux-kselftest+bounces-21441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E21C9BC47B
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 05:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3035282073
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 04:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6521ADFE4;
	Tue,  5 Nov 2024 04:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CcR8nWKz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF94F18FC92
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Nov 2024 04:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730782792; cv=none; b=cYa30UsbF5T3HvXWEXX97Ul9z+jvHMY0lI3TYitYVRF9AgqjWCiWZhVv+69SHAZNlyDWrpx486CRBEBafHB7cpSyx7G77qA58MuTYdYsPxwS3LY1hpEO82q+KzKbd+YbVbfP5i5BmO1v3OM9BkYKPw798MkKX/PbxzABxbp0I3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730782792; c=relaxed/simple;
	bh=YVMEd5Bsml+OsO+5MopC9gc3upKqeJfn4OD119lwigY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nea/8GwUJdbPNQKw+bOQxm8/p+hae9KJYR6wNZ9DDLMlP7MHYvbWyHPOWSNQAT53Sq4JGaYqH2y1rx/8loSBl3KSOFQyRoEQT3AUgN+TH6eiPRRN01mV9BclXrXet8aqzd4M9w+3+Ag08aYfetq+U+J6Zt5bb/vR/TCvvOI6wvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CcR8nWKz; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e2bd7d8aaf8so4402584276.3
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2024 20:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730782790; x=1731387590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVMEd5Bsml+OsO+5MopC9gc3upKqeJfn4OD119lwigY=;
        b=CcR8nWKzmTLgwzaij9wkO3rPWjrQgk3gV+KJig+MJ7tal5GbFZ/DR+f5cMt10UBWk0
         6GI1P49QsyDNlsouxC4czzPIC1bJH0v1MAT5FGChFDTevS4HyOwRUtHDit2+nmU7TkNl
         VKkCmBOTXmCs6tLxCaXlhTSjFDCcA+4DMH6BY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730782790; x=1731387590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVMEd5Bsml+OsO+5MopC9gc3upKqeJfn4OD119lwigY=;
        b=MMX+bOKWLL1+k42/B2uoOymX6D0MBkTsO8ZgfKU2viq9t/8R6Xvq/P364WHhE/kOQT
         KPtqnVIyBIr727rCvQWM6kOuNiH3Qa9AJNwx5cnFXpyjmSJvt1xq3202kq66Y32yIX4+
         aMsZtNdHTtz1/WuzccYKXgXEE3FPZBp3mJrdGUdbthgmipL68dfHju2yalv2LP9+A8gI
         35miIYVWreQVacVbdnjza5l1nitL1e0GzLsuZSi00N0EUJSQswdDHgd+TjONiAfxCy5u
         5zeKOgwUELmA8RGrz6CpT07UQV1ucxJR/d8TfDr6vrkFs8m63R/atOxlGmhx4WqZoH3f
         PlsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV5PFTcoMe0TubfW5UYyUUJ9IlSxLY0BS+AgitsyO1rrUjq96naPSTi1JzavuBPhYHhUCGoishKiELLolC52k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY+WmkemvzGaAPXunweFO433MdI9pL63vn663lgs1ViD03jDFc
	P6DP8pRwHpbyx0RUJ9ujJWpHdYaNRcXfTaz3b7UCD4nO2+vD/DQ9YpCXAlR0BCsljuWrpnapZPr
	iYUfBaP4ehCUEBFhdrzspW0pIn13Un0u3HEhKe4pURbUJVAH5Zg==
X-Google-Smtp-Source: AGHT+IFgKmFErDrgrMun7jm0xzFOoJNPIm472FsRYzNoUP6jx3xgg38yDzUW9pR5AxcKeYTnZwV9UIznZHOyWzhS85s=
X-Received: by 2002:a05:6902:2b10:b0:e29:1768:8c2e with SMTP id
 3f1490d57ef6-e30e5b3b57dmr16843265276.49.1730782789786; Mon, 04 Nov 2024
 20:59:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030033514.1728937-1-zack.rusin@broadcom.com>
 <20241030033514.1728937-3-zack.rusin@broadcom.com> <CABgObfaRP6zKNhrO8_atGDLcHs=uvE0aT8cPKnt_vNHHM+8Nxg@mail.gmail.com>
In-Reply-To: <CABgObfaRP6zKNhrO8_atGDLcHs=uvE0aT8cPKnt_vNHHM+8Nxg@mail.gmail.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Mon, 4 Nov 2024 23:59:39 -0500
Message-ID: <CABQX2QMR=Nsn23zojFdhemR7tvGUz6_UM8Rgf6WLsxwDqoFtxg@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: x86: Add support for VMware guest specific hypercalls
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Doug Covelli <doug.covelli@broadcom.com>, 
	Jonathan Corbet <corbet@lwn.net>, Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Joel Stanley <joel@jms.id.au>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 5:13=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> On Wed, Oct 30, 2024 at 4:35=E2=80=AFAM Zack Rusin <zack.rusin@broadcom.c=
om> wrote:
> >
> > VMware products handle hypercalls in userspace. Give KVM the ability
> > to run VMware guests unmodified by fowarding all hypercalls to the
> > userspace.
> >
> > Enabling of the KVM_CAP_X86_VMWARE_HYPERCALL_ENABLE capability turns
> > the feature on - it's off by default. This allows vmx's built on top
> > of KVM to support VMware specific hypercalls.
>
> Hi Zack,

Hi, Paolo.

Thank you for looking at this.

> is there a spec of the hypercalls that are supported by userspace? I
> would like to understand if there's anything that's best handled in
> the kernel.

There's no spec but we have open headers listing the hypercalls.
There's about a 100 of them (a few were deprecated), the full
list starts here:
https://github.com/vmware/open-vm-tools/blob/739c5a2f4bfd4cdda491e6a6f6869d=
88c0bd6972/open-vm-tools/lib/include/backdoor_def.h#L97
They're not well documented, but the names are pretty self-explenatory.

> If we allow forwarding _all_ hypercalls to userspace, then people will
> use it for things other than VMware and there goes all hope of
> accelerating stuff in the kernel in the future.
>
> So even having _some_ checks in the kernel before going out to
> userspace would keep that door open, or at least try.

Doug just looked at this and I think I might have an idea on how to
limit the scope at least a bit: if you think it would help we could
limit forwarding of hypercalls to userspace only to those that that
come with a BDOOR_MAGIC (which is 0x564D5868) in eax. Would that help?

> Patch 1 instead looks good from an API point of view.

Ah, great, thanks!

z

