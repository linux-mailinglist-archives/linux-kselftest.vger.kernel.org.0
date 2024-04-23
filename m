Return-Path: <linux-kselftest+bounces-8731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6638AF8B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 23:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C96628DFB3
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 21:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACE1142E90;
	Tue, 23 Apr 2024 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="glaQdr8G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A2C20B3E;
	Tue, 23 Apr 2024 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713906207; cv=none; b=kB/P2xCUmpnd9JQ2tIP5PzsS7525yQIjebJ2P0zfHyQDAJ4hyk7fWyvug/NGvEipw6W3Tosxb/zJPzPKz+PAUSUetWprXa+eyBdcZ3IwIpYITLdYDyMTmiDaw4FsLyfb6h5ITqfPluoPuGMxR8AWKOTFPeHPHigHB/+7+VNDX6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713906207; c=relaxed/simple;
	bh=LWHJaT9ULgmFemasW8hgm+EMXbfzWFdJb6VuWLCVjcA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=h+2pAz6e1269wHiDNcWEGbL+Awpq009zSTxjnGklA0hPDmwbbVXZaFi4rMbf6Yom1MfKnN7oGLzEFx4m87S0xC0JEsHyRPlr+bH10/llK1nbZP2JjegmZEOVWPi8T1GGqNmergEOqrjSEiu/A993N1oDPw3fxNGJhUKq+RqIQpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=glaQdr8G; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=tm6Oa9JrF8vq5JJCyPEdQCE1KB7eUtQwFdacLQMRUU4=; b=glaQdr8GIBbuFASx3fr/TrxaAR
	kIOAFOr2dmnrg0LXJ1uopS2+bQiNO4/ejMmf+KQQ3EFvS150PyqGycOl1fr89QK0vrR02vl/SZA+2
	RywBqYpUXeIahUWsNTeeaZ7fV1ICmNHzcm/ehJ6+o7VLFPyd7Gvl5UqevLVu1crxX1CCBk5FNMOC6
	XuYdUufhzLGRAIRq7sEll2u2TBBC1hiWCpaNgSln9xrB4VT9g0hhtVcfOpFkQZ6S6qJhmGR357L7l
	0VmBfNFwnSM72UFXfu6YQNG40DPz4U1GEze6G0BFIdevFkDupHrTiQCSKSiLqrvx3wVPzVccIT++W
	WpzvdZTw==;
Received: from [2001:8b0:10b:5:2012:a1ec:9b77:d880] (helo=[IPv6:::1])
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzNHj-0000000EA4L-37FM;
	Tue, 23 Apr 2024 21:02:41 +0000
Date: Tue, 23 Apr 2024 22:02:40 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: "Chen, Zide" <zide.chen@intel.com>, Jack Allister <jalliste@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Sean Christopherson <seanjc@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>
CC: Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_KVM=3A_selftests=3A_Add_KVM/PV_c?=
 =?US-ASCII?Q?lock_selftest_to_prove_timer_drift_correction?=
User-Agent: K-9 Mail for Android
In-Reply-To: <cdc6c880-c666-4ff2-99f3-56c6b4f7576d@intel.com>
References: <20240408220705.7637-1-jalliste@amazon.com> <20240408220705.7637-3-jalliste@amazon.com> <3664e8ec-1fa1-48c0-a80d-546b7f6cd671@intel.com> <17F1A2E9-6BAD-40E7-ACDD-B110CFC124B3@infradead.org> <65FF4D51-05A8-42E0-9D07-6E42913CC75E@infradead.org> <6dca783b-6532-4fa7-9e04-1c0a382a00b0@intel.com> <c863ffcfd4edda9a1a46e3351766a655c5523f7d.camel@infradead.org> <71260288-3666-4419-8283-6565e91aaba4@intel.com> <06864883c53cc4042e1939c04ecbd5ef0f8acf3b.camel@infradead.org> <cdc6c880-c666-4ff2-99f3-56c6b4f7576d@intel.com>
Message-ID: <D71A6400-F236-4FC4-8D0F-0EA9EA92D48E@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

On 23 April 2024 18:59:21 BST, "Chen, Zide" <zide=2Echen@intel=2Ecom> wrote=
:
>
>
>On 4/23/2024 12:49 AM, David Woodhouse wrote:
>>> If I restored the KVM_REQ_GLOBAL_CLOCK_UPDATE request from
>>> kvm_arch_vcpu_load(), the selftest works for me, and I ran the test fo=
r
>>> 1000+ iterations, w/ or w/o TSC scaling, the TEST_ASSERT(delta_correct=
ed
>>> =C2=A0<=3D =C2=B11) never got hit=2E This is awesome!
>>>
>>> However, without KVM_REQ_GLOBAL_CLOCK_UPDATE, it still fails on creati=
ng
>>> a VM=2E Maybe the init sequence sill needs some rework=2E
>>=20
>> That one confuses me=2E The crash is actually in debugfs, as it's
>> registering the per-vm or per-vcpu stats=2E I can't imagine *how* that'=
s
>> occurring=2E Or see why the availability of TSC scaling would cause it =
to
>> show up for you and not me=2E Can I have your =2Econfig please?
>>=20
>> First thought would be that there's some change in the KVM structures
>> and you have some stale object files using the old struct, but then I
>> realise I forgot to actually *remove* the now-unused
>> kvmclock_update_work from x86's struct kvm_arch anyway=2E
>>=20
>> I'll try to reproduce, as I think I want to *know* what's going on
>> here, even if I am going to drop that patch as mentioned in=C2=A0
>> https://lore=2Ekernel=2Eorg/kvm/a6723ac9e0169839cb33e8022a47c2de213866a=
c=2Ecamel@infradead=2Eorg
>>=20
>> Are you able to load that vmlinux in gdb and
>> (gdb) list *start_creating+0x80
>> (gdb) list *kvm_create_vm_debugfs+0x28b
>>=20
>> Thanks again=2E
>
>My apologies, it turns out the KVM_REQ_GLOBAL_CLOCK_UPDATE is not
>needed=2E Today I can't reproduce the issue after removing it=2E  Yesterd=
ay
>I thought it may miss something related to pfncache=2E
>
>To be clear, with the above mentioned change to
>kvm_scale_tsc(master_tsc_scaling_ratio), the selftest runs reliably
>regardless TSC scaling is enabled or not=2E

Thanks=2E That version is now in my git tree and I have tested it myself o=
n Skylake=2E Then I got distracted by reverse-engineering kvm_get_time_scal=
e() so I could actually add some comments to it=2E

I'm still going to have to put the clock updates back though, for the non-=
masterclock case=2E

While I'm ripping all this up I guess I ought to rename it to "reference c=
lock" too?

