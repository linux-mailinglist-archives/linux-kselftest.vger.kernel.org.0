Return-Path: <linux-kselftest+bounces-8661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 562D78ADE8F
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 09:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF38B1F227E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 07:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A9747F58;
	Tue, 23 Apr 2024 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UWN5m8UG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330D046522;
	Tue, 23 Apr 2024 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713858592; cv=none; b=X72czAVgCyvq3JbGK1C5vOaQ6AoRtGfQk9HvJ0/9QNVLffsvam2h1DvU4adMYTHAl6vttROtsWlDBm2LNKr8SWCrWaml1W76mBhkbDdn1btaeZBbIxU730gOUYZC/5BUgIffwHbOMA7T3ewX3NnDE34DMzMo9S2Bu3A6jRENfm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713858592; c=relaxed/simple;
	bh=8qNuSQG0eqrhGvsgB1xiQ6DyiE62cFHbBbi+ZT2IGag=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nT8W1DwD8O8IRlbn2S/FuXFNsZ/d1iNzyiEr35x/C3ly3lzj7S+lAKhLsCvtybXucldloGi7lbXRjo0PUt9vWoOFBXN13JRWnYoTEgMqQITkz64Fyjox3nC5BwvuArTAkPuNlr4M2b17BjvkzIkEhRCg7vaUfQfhss5uc7WFpQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UWN5m8UG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8qNuSQG0eqrhGvsgB1xiQ6DyiE62cFHbBbi+ZT2IGag=; b=UWN5m8UGA/6urtUA2PBFQPAcqF
	LANnEcDAqB0GYONyFuQCE4rCa5TphnITPncoYkCeeOqMWIDTkpOa2Laf2aI6wAAQ93GUC7OAAlz0D
	eOHvr6j0sGIsiAr+OGabdpld0OeUpASjgR6m6I8TapMD6AN8o9NCkpNmmZMTYlIcWyPq3TVZxgxzd
	Be8QOz2wSpuU6tVvISG8sx7+IOBJKPO9o5jLwhf4bo2ZdhF1sTkgYhiL17IrTvWRyckotaAakLxtd
	av54I4tVBq6Cd9Ob69F5ZYa7EZ3PIZlnGwUszdbqFy7N6/5G6igN6PlC0SbtiFcCXTVJR7dobx9aU
	JXxfW28w==;
Received: from [2001:8b0:10b:5:5d7f:4c4c:4f30:75bb] (helo=u3832b3a9db3152.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzAuB-0000000FuF5-06X1;
	Tue, 23 Apr 2024 07:49:31 +0000
Message-ID: <06864883c53cc4042e1939c04ecbd5ef0f8acf3b.camel@infradead.org>
Subject: Re: [PATCH 2/2] KVM: selftests: Add KVM/PV clock selftest to prove
 timer drift correction
From: David Woodhouse <dwmw2@infradead.org>
To: "Chen, Zide" <zide.chen@intel.com>, Jack Allister <jalliste@amazon.com>,
  Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Sean Christopherson <seanjc@google.com>,  Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,  Shuah Khan <shuah@kernel.org>
Cc: Paul Durrant <paul@xen.org>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Tue, 23 Apr 2024 08:49:30 +0100
In-Reply-To: <71260288-3666-4419-8283-6565e91aaba4@intel.com>
References: <20240408220705.7637-1-jalliste@amazon.com>
	 <20240408220705.7637-3-jalliste@amazon.com>
	 <3664e8ec-1fa1-48c0-a80d-546b7f6cd671@intel.com>
	 <17F1A2E9-6BAD-40E7-ACDD-B110CFC124B3@infradead.org>
	 <65FF4D51-05A8-42E0-9D07-6E42913CC75E@infradead.org>
	 <6dca783b-6532-4fa7-9e04-1c0a382a00b0@intel.com>
	 <c863ffcfd4edda9a1a46e3351766a655c5523f7d.camel@infradead.org>
	 <71260288-3666-4419-8283-6565e91aaba4@intel.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-2WChFcBpSBowkOXpvu2e"
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-2WChFcBpSBowkOXpvu2e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-04-22 at 15:02 -0700, Chen, Zide wrote:
>=20
>=20
> On 4/20/2024 9:03 AM, David Woodhouse wrote:
> > On Fri, 2024-04-19 at 16:54 -0700, Chen, Zide wrote:
> > >=20
> > > However, the selftest hangs:
> > >=20
> > > [Apr19 16:15] kselftest: Running tests in kvm
> > > [Apr19 16:16] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > [=C2=A0 +0.000628] rcu:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 78-...0: (1 GPs=
 behind) idle=3D3c8c/1/0x4000000000000000 softirq=3D5908/5913 fqs=3D14025
> > > [=C2=A0 +0.000468] rcu:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (detected by 10=
4, t=3D60003 jiffies, g=3D60073, q=3D3100 ncpus=3D128)
> > > [=C2=A0 +0.000389] Sending NMI from CPU 104 to CPUs 78:
> > > [=C2=A0 +0.000360] NMI backtrace for cpu 78
> > > [=C2=A0 +0.000004] CPU: 78 PID: 33515 Comm: pvclock_test Tainted: G O=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.9.0-rc1zide-l0+ #194
> > > [=C2=A0 +0.000003] Hardware name: Inspur NF5280M7/NF5280M7, BIOS 05.0=
8.01 08/18/2023
> > > [=C2=A0 +0.000002] RIP: 0010:pvclock_update_vm_gtod_copy+0xb5/0x200 [=
kvm]
> >=20
> > Ah, kvm_get_time_scale() doesn't much like being asked to scale to zero=
.
> >=20
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index a07b60351894..45fb99986cf9 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -3046,7 +3046,8 @@ static void pvclock_update_vm_gtod_copy(struct kv=
m *kvm)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Copy from the field protected solely by ka->t=
sc_write_lock,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * to the field protected by the ka->pvclock_sc =
seqlock.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ka->master_tsc_scaling_ratio =3D ka->last_tsc_scaling_=
ratio;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ka->master_tsc_scaling_ratio =3D ka->last_tsc_scaling_=
ratio ? :
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kvm_ca=
ps.default_tsc_scaling_ratio;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Calculate the scaling factors precisely the s=
ame way
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * that kvm_guest_time_update() does.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0last_tsc_hz =3D kvm_scale_tsc(tsc_khz * 1000,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ka->last_tsc_scaling_ratio);
>=20
> Should be ka->master_tsc_scaling_ratio?

Oops, yes. I'll actually do some proper testing on a host with TSC
scaling this week. Thanks.

> If I restored the KVM_REQ_GLOBAL_CLOCK_UPDATE request from
> kvm_arch_vcpu_load(), the selftest works for me, and I ran the test for
> 1000+ iterations, w/ or w/o TSC scaling, the TEST_ASSERT(delta_corrected
> =C2=A0<=3D =C2=B11) never got hit. This is awesome!
>
> However, without KVM_REQ_GLOBAL_CLOCK_UPDATE, it still fails on creating
> a VM. Maybe the init sequence sill needs some rework.

That one confuses me. The crash is actually in debugfs, as it's
registering the per-vm or per-vcpu stats. I can't imagine *how* that's
occurring. Or see why the availability of TSC scaling would cause it to
show up for you and not me. Can I have your .config please?

First thought would be that there's some change in the KVM structures
and you have some stale object files using the old struct, but then I
realise I forgot to actually *remove* the now-unused
kvmclock_update_work from x86's struct kvm_arch anyway.

I'll try to reproduce, as I think I want to *know* what's going on
here, even if I am going to drop that patch as mentioned in=C2=A0
https://lore.kernel.org/kvm/a6723ac9e0169839cb33e8022a47c2de213866ac.camel@=
infradead.org

Are you able to load that vmlinux in gdb and
(gdb) list *start_creating+0x80
(gdb) list *kvm_create_vm_debugfs+0x28b

Thanks again.

> =C2=A0BUG: unable to handle page fault for address: 005b29e3f221ccf0
> =C2=A0#PF: supervisor read access in kernel mode
> =C2=A0#PF: error_code(0x0000) - not-present page
> =C2=A0PGD 0
> =C2=A0Oops: 0000 [#1] PREEMPT SMP NOPTI
> =C2=A0CPU: 86 PID: 4118 Comm: pvclock_test Tainted
> =C2=A0Hardware name: Inspur NF5280M7/NF5280M7, BIOS 05.08.01 08/18/2023
> =C2=A0RIP: 0010:start_creating+0x80/0x190
> =C2=A0Code: ce ad 48 c7 c6 70 a1 ce ad 48 c7 c7 80 1c 9b ab e8 b5 10 d5 f=
f 4c
> 63 e0 45 85 e4 0f 85 cd 00 00 00 48 85 db 0f 84 b5 00 00 00 <48> 8b 43
> 30 48 8d b8 b8 >
> =C2=A0RSP: 0018:ff786eaacf3cfdd0 EFLAGS: 00010206
> =C2=A0RAX: 0000000000000000 RBX: 005b29e3f221ccc0 RCX: 0000000000000000
> =C2=A0RDX: 0000000000000001 RSI: ffffffffadcea170 RDI: 0000000000000000
> =C2=A0RBP: ffffffffc06ac8cf R08: ffffffffa6ea0fe0 R09: ffffffffc06a5940
> =C2=A0R10: ff786eaacf3cfe30 R11: 00000013a7b5feaa R12: 0000000000000000
> =C2=A0R13: 0000000000000124 R14: ff786eaacfa11000 R15: 00000000000081a4
> =C2=A0FS:=C2=A0 00007f0837c89740(0000) GS:ff4f44b6bfd80000(0000)
> knlGS:0000000000000000
> =C2=A0CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0
> =C2=A0CR2: 005b29e3f221ccf0 CR3: 000000014bdf8002 CR4: 0000000000f73ef0
> =C2=A0DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> =C2=A0DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> =C2=A0PKRU: 55555554
> =C2=A0Call Trace:
> =C2=A0 <TASK>
> =C2=A0 ? __die+0x24/0x70
> =C2=A0 ? page_fault_oops+0x81/0x150
> =C2=A0 ? do_user_addr_fault+0x64/0x6c0
> =C2=A0 ? exc_page_fault+0x8a/0x1a0
> =C2=A0 ? asm_exc_page_fault+0x26/0x30
> =C2=A0 ? start_creating+0x80/0x190
> =C2=A0 __debugfs_create_file+0x43/0x1f0
> =C2=A0 kvm_create_vm_debugfs+0x28b/0x2d0 [kvm]
> =C2=A0 kvm_create_vm+0x457/0x650 [kvm]
> =C2=A0 kvm_dev_ioctl+0x88/0x180 [kvm]
> =C2=A0 __x64_sys_ioctl+0x8e/0xd0
> =C2=A0 do_syscall_64+0x5b/0x120
> =C2=A0 entry_SYSCALL_64_after_hwframe+0x71/0x79
> =C2=A0RIP: 0033:0x7f0837b1a94f
> =C2=A0Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 4=
8 89
> 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <41> 89 c0
> 3d 00 f0 ff ff >
> =C2=A0RSP: 002b:00007ffe01be3fc0 EFLAGS: 00000246 ORIG_RAX
> =C2=A0RAX: ffffffffffffffda RBX: 0000000000434480 RCX: 00007f0837b1a94f
> =C2=A0RDX: 0000000000000000 RSI: 000000000000ae01 RDI: 0000000000000005
> =C2=A0RBP: 0000000000000009 R08: 000000000041b1a0 R09: 000000000041bfcf
> =C2=A0R10: 00007f0837bd8882 R11: 0000000000000246 R12: 0000000000434480
> =C2=A0R13: 000000000041e0f0 R14: 0000000000001000 R15: 0000000000000207
> =C2=A0 </TASK>
> =C2=A0Modules linked in: kvm_intel(O) kvm(O) [last unloaded: kvm(O)]
> =C2=A0CR2: 005b29e3f221ccf0


--=-2WChFcBpSBowkOXpvu2e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQwNDIzMDc0OTMwWjAvBgkqhkiG9w0BCQQxIgQgQzq/QVQe
Pdn5l59bzt9WefNsymJiX9cpOvOQI4YdAwIwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgAXJfl3oQe7tm6TtqAsNnQdX2ecNeSlufX/
jmrWci1FNMrbFzjN/g7zu3D2CXMIFAgZLm+Pi+9Fs7a8SArfWekZ5d/Bgd2krkVLbwCNpf/hfABk
6MyVsWzR/37/6P9WhW6FKqf98qbIjVYO+GRtP0mlIzqA0PqF4Wz14Oa+hxFker4CmoAeRHJ0CQ0t
Oti/5ALkQGpsNDcmqkpjXGFNyg7A62K2gI+ryqN+P5U4ThpM0nQ+09li5TlTN/jocAU81WC0I6xT
ed5YINyowYatW0vKh84Hlo386inRME1X/bw0h9GlM1OMVrM94m19yIaCH06yFAtt7M2rPTCmvLKf
ERvAiv9l85QIR6eDQp5QFaKIQLWkcf1ChuATz7/181hlyvVbnfrdlVUZWi8BiZa9/dQNM+uR6W+j
pKjpnzVv3ndfoXwCrtCNW9cAPawixGv0f2pICawwStZqOREhWn7RLYgKkG85nRdQ8sxQsDGej6HY
4+BpjB+mn1le23Ce3LkMYoMzN0GQjdFbieWPLFyyKVvL6GUwV/UB2zaE/eKmCXcemV9TK7At76O3
VKOupNLAlOeWEKZmYUB5Mb65jTBLWzhrEQ3t/7Lhh4TiUm2iurd3Epxf4nvSHEwnZlRGiFqxMlMW
P/sV7hlZmaeS6LZiPTDXFGEx4mBjLXj1oZBStvJWEwAAAAAAAA==


--=-2WChFcBpSBowkOXpvu2e--

