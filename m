Return-Path: <linux-kselftest+bounces-9641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50818BEC52
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 21:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D1C1C24893
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 19:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D4216E872;
	Tue,  7 May 2024 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MdWnk8yo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADB416D9A7;
	Tue,  7 May 2024 19:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108932; cv=none; b=MJ3uZGqN1Z7K9sNdUiA4ygxooirqn4lNl2lxKWhjWgTtojeBCfs5PdmGzh8LobCSJtvljuOspR1fvvn3gYk5sMIzHKOvZEuUzOEK1EEstp79POlAJiHwKbz12Y1OrdlS1mKg1fYsZSwhz6T3t+nV3w4oF2Np131n439tQ7scpcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108932; c=relaxed/simple;
	bh=zBtOdwwtvKm20Q77bQR/mEqpEaFtLymX61Rz+GGBf8I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tjQlz+pTL1MaEB5FkuoJm5HaHkcNpH2SArlLzwIrFvHkWNQJvU7h3pOkGoYVQnA1NXiJqdPUvubgiUuVzvPI1fRpPEiSUstmKRwrVz8SAW1m8pM2F/yyiAlNDTvofggCsP/iaB1QUSYX/9rI/sVwTqJdR0M0fvDv1TmFsLGZB/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MdWnk8yo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zBtOdwwtvKm20Q77bQR/mEqpEaFtLymX61Rz+GGBf8I=; b=MdWnk8yoI2DOelSJXtTlIUSpzj
	IQ3W64s3IyVTPaLMA6DEOtDjKp2/Nx8QfV7Q7H78ngnw0+FpgcJKClmwzFRSP/pdkyoIHmfSUHJR2
	3M028WgCpRtgQELOITgr51x9myAnIGJY0sYy5bQPzHHpGvK+XeKggPfG7l9eyxxcIPEIsrCaE94OB
	tnJwsxryJ3rdnaiyL47JuljvYXR62OJ8FuHg2yFG21qp9xkk1KdOJIOkRyIh4i51efiyypodxn702
	KgQNwzMkoSujXejKdm8LvsJZ5GNVQ1qpQTQK1NxVA+6ZsR6XMo3dYRQOzwTicQWqXDfTzPO5ZH5UL
	pg3GX21Q==;
Received: from [2001:8b0:10b:5::bb3] (helo=u3832b3a9db3152.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4QB7-0000000Dsk7-40yh;
	Tue, 07 May 2024 19:08:42 +0000
Message-ID: <51dea3a632131d9a49af3991a633f26ce8592dd3.camel@infradead.org>
Subject: Re: [PATCH v2 01/15] KVM: x86/xen: Do not corrupt KVM clock in
 kvm_xen_shared_info_init()
From: David Woodhouse <dwmw2@infradead.org>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, Sean Christopherson <seanjc@google.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Paul Durrant
 <paul@xen.org>, Shuah Khan <shuah@kernel.org>,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org, Oliver
 Upton <oliver.upton@linux.dev>,  jalliste@amazon.co.uk, sveith@amazon.de,
 zide.chen@intel.com, Dongli Zhang <dongli.zhang@oracle.com>
Date: Tue, 07 May 2024 20:08:40 +0100
In-Reply-To: <ZjXm9w/y3/NLCxLQ@tpad>
References: <20240427111929.9600-1-dwmw2@infradead.org>
	 <20240427111929.9600-2-dwmw2@infradead.org> <ZjXm9w/y3/NLCxLQ@tpad>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-1MxL1pyflkVSO892kaNk"
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-1MxL1pyflkVSO892kaNk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2024-05-04 at 04:42 -0300, Marcelo Tosatti wrote:
> On Sat, Apr 27, 2024 at 12:04:58PM +0100, David Woodhouse wrote:
> >=20
> > In particular, KVM_REQ_MASTERCLOCK_UPDATE will take a new snapshot of
> > time as the reference in master_kernel_ns and master_cycle_now, yanking
> > the guest's clock back to match definition A at that moment.
>=20
> KVM_REQ_MASTERCLOCK_UPDATE stops the vcpus because:

Took me a while to work that one out, btw. The fact that the=C2=A0
KVM_REQ_MCLOCK_INPROGRESS request is asserted but never actually
*handled*, so all it does is repeatedly kick the vCPU out and make it
spin until the request is cleared is... interesting. Likewise the way
that we set KVM_REQ_MASTERCLOCK_UPDATE on *all* vCPUs, so they *all*
call kvm_update_masterclock(), when only one of them needed to. I may
clean that up a little.

> =C2=A0* To avoid that problem, do not allow visibility of distinct
> =C2=A0* system_timestamp/tsc_timestamp values simultaneously: use a maste=
r
> =C2=A0* copy of host monotonic time values. Update that master copy
> =C2=A0* in lockstep.

Right. That comment is a lot longer than the part you cited here, and
starts with 'assuming a stable TSC across pCPUS, and a stable TSC
across vCPUs'. It's the "if (ka->use_master_clock)" case.

And yes, what it's basically saying is a special case of the fact that
if you let the KVM clock run at its "natural" rate based on the guest
TSC (definition B), but each vCPU runs at that rate from a *different*
point on the line that is definition A (the host CLOCK_MONOTONIC_RAW),
bad things will happen.

I'm OK with it stopping the vCPUs (although I'd like it to do so in a
less implicitly awful way). But when we don't need to update the
reference time at all, let's not do so.

> > When invoked from in 'use_master_clock' mode, kvm_update_masterclock()
> > should probably *adjust* kvm->arch.kvmclock_offset to account for the
> > drift, instead of yanking the clock back to defintion A.
>=20
> You are likely correct...
>=20
> > But in the meantime there are a bunch of places where it just doesn't n=
eed to be
> > invoked at all.
> >=20
> > To start with: there is no need to do such an update when a Xen guest
> > populates the shared_info page. This seems to have been a hangover from
> > the very first implementation of shared_info which automatically
> > populated the vcpu_info structures at their default locations, but even
> > then it should just have raised KVM_REQ_CLOCK_UPDATE on each vCPU
> > instead of using KVM_REQ_MASTERCLOCK_UPDATE. And now that userspace is
> > expected to explicitly set the vcpu_info even in its default locations,
> > there's not even any need for that either.
> >=20
> > Fixes: 629b5348841a1 ("KVM: x86/xen: update wallclock region")
> > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > Reviewed-by: Paul Durrant <paul@xen.org>
> > ---
> > =C2=A0arch/x86/kvm/xen.c | 2 --
> > =C2=A01 file changed, 2 deletions(-)
> >=20
> > diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> > index f65b35a05d91..5a83a8154b79 100644
> > --- a/arch/x86/kvm/xen.c
> > +++ b/arch/x86/kvm/xen.c
> > @@ -98,8 +98,6 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wc->version =3D wc_vers=
ion + 1;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0read_unlock_irq(&gpc->l=
ock);
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kvm_make_all_cpus_request(kv=
m, KVM_REQ_MASTERCLOCK_UPDATE);
> > -
> > =C2=A0out:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0srcu_read_unlock(&kvm->=
srcu, idx);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> > --=20
> > 2.44.0
>=20
> So KVM_REQ_MASTERCLOCK_UPDATE is to avoid the race above.
>=20
> In what contexes is kvm_xen_shared_info_init called from again?
>=20
> Not clear to me KVM_REQ_MASTERCLOCK_UPDATE is not needed (or that is
> needed, for that matter...).

We cal kvm_xen_shared_info_init() when the Xen "shared info" page is
set up. The only interesting part of that is the *wallclock* epoch.

The wallclock (just like KSR_KVM_WALL_CLOCK{,_NEW}) is *entirely* hosed
ever since the KVM clock stopped being based on CLOCK_MONOTONIC, since
that means that the value of "wallclock time minus KVM clock time"
actually *changes* as the KVM clock runs at a different rate to
wallclock time.=20

I'm looking at a replacement for that which uses the gtod information
to give the guest a direct mapping of guest TSC to host CLOCK_TAI. And
in doing so we can *also* indicate when live migration has potentially
disrupted the guest TSC, so any further NTP/PTP refinement that the
guest may have done for itself needs to be thrown away.


--=-1MxL1pyflkVSO892kaNk
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQwNTA3MTkwODQwWjAvBgkqhkiG9w0BCQQxIgQgHVmiWasw
frgDY5E3eFn0b2+Z8rpbfP6rB7OVXKnqfWgwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgChZ/FYOFQZZOOYZG05b4wiJdTD0tZ47wKq
LYyo2tJiF2gtDaUDWztKlqtXJIhy1EHqLJkXexeS+G2NXJKc5m0GZfapeKEKDnlr4m7T6SSisSPl
ou2+ZtAwIvnQg22lFFbDKBrzpKCvR2TPAhnbFEck/sUzmostgvzLgc4q76A16HYZ9dYLqShXGJoa
gUOMidK1fOFrWC/36QjUDNB0JEHPDBYxvq4hSLlmMI81AxZ0+xCSOHOeTNHM7yqOJEGKJlTqgtx7
UzSkB/W+uOs6re+XgyHZegmMukZyWEKHEZXo44gYfx4QZUUMi0pmOU8NC27TwLpD9N6mMvOsmkGo
iUP8ZcTnNGjjFJKqfpEVeOymeGkPJxFBPfccQdc/WaPht2IDVnKiIDYc2Sw5QggL54iU4uwUKFay
rXpzuMXRdJmfIyAQQIOIZokQJ0TLFJNW4q1gfulgO7HK48CRDxaceSbxHMBjwVfx9Zf5e8zfYFJC
UT/pNvdY4RdfDUUMf+tzUyLKbE7XbrT5FvNCWlNyZgyTJgleGDKTj7KV0fCVQM/mqmwHipQo45fh
4DFMfwa2FF045ZXH0ICN6ovrfYbjmcjMdPWQFvxCFX09dwPFYfmWvgBVdqJJi8EVHUTepQytBUqd
Y2ueJkoJdXRulF3xvCQ006bk3AcMevjRqueyVfTXFAAAAAAAAA==


--=-1MxL1pyflkVSO892kaNk--

