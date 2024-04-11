Return-Path: <linux-kselftest+bounces-7705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BA98A1587
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 15:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC981F23553
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 13:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E82B14D451;
	Thu, 11 Apr 2024 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J96sxA1S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8945114B088;
	Thu, 11 Apr 2024 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842133; cv=none; b=dtyj3Kx9YONQK4QNdi5MTmVHX9x79uGmVOGnmWKzF6wmGvsmkcgxgV2HVM74bK6OWlGw8wRteXHpsV+hS841xlj+5Ha8rv2ugmWV+klhPhmIlGVfzkaRL3VahtV6EN8jhgyfTWZPR2bx0NirJ367btuvs3VGJg6pqOssAh8rYeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842133; c=relaxed/simple;
	bh=B9lrEy9mhy2sYREGwZD2TBToT5T7/+a7Ol4R4AArnoc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HtztyBA2OnaPj3B8zzDEwZ3fzvPhT01qnhr4VIDTvr+PoSmvbN5F2JjtL1Ccm9qz1isxPBi7ooDkE841yjJtwyofFc+Rd7hlJzLmZg8LlKCtwbL5sTWsWgwq1s7L5VjUmeS3+CTMPEzxvNhNtJ/OZLpfsWhgtEbYP8SJ7sU6jmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J96sxA1S; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B9lrEy9mhy2sYREGwZD2TBToT5T7/+a7Ol4R4AArnoc=; b=J96sxA1SXjfWjSUBUk6WCjnhIo
	gyreybnYXKZ/US9aRDtdxMYfPaIZ3tsR2EMHgydjidVFLGVr2nfF9fKbaem9eLXp9aI/kQI9sgjq+
	b/gk9KSmiuVE3dfYuPPUE2Wj9bWgm72rwueOo7LAa5f7sCfgdz4/nVnHI87OJvkFWZ9r95ln7/WdL
	Wpig7M3kBvj7YtGrhIuAA87uMIXPdtTlQwz0RoGl0AV44rYVskLQjMnhBdEDPWaEubyk5kf4zLOmu
	/YbGcne4+PUan8MmsXj4Y16bTKp6Rb9CkmE++iexhaerNsrc9Kc7wYJaHC5e5DAXZ5HM2m6/jIRWP
	vxfYFU4A==;
Received: from [2001:8b0:10b:5:585d:a26c:db22:46e5] (helo=u3832b3a9db3152.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruuTm-000000071sd-3h50;
	Thu, 11 Apr 2024 13:28:38 +0000
Message-ID: <f6c9c757a1f4eb2d3c7ce06d27827e099923ef6b.camel@infradead.org>
Subject: Re: [PATCH 2/2] KVM: selftests: Add KVM/PV clock selftest to prove
 timer drift correction
From: David Woodhouse <dwmw2@infradead.org>
To: "9377995a-26a4-2523-e421-be1cd92bdc34@oracle.com"
 <9377995a-26a4-2523-e421-be1cd92bdc34@oracle.com>,
 "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "shuah@kernel.org" <shuah@kernel.org>, 
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "seanjc@google.com" <seanjc@google.com>,  "mingo@redhat.com"
 <mingo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
 "tglx@linutronix.de" <tglx@linutronix.de>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>,  "hpa@zytor.com" <hpa@zytor.com>,
 "paul@xen.org" <paul@xen.org>, "bp@alien8.de" <bp@alien8.de>, 
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "Allister, Jack" <jalliste@amazon.co.uk>,  "x86@kernel.org" <x86@kernel.org>
Date: Thu, 11 Apr 2024 14:28:37 +0100
In-Reply-To: <4f1ca4e1a8a9a31eae8057f9a813fc13d3172f77.camel@amazon.co.uk>
References: <4f1ca4e1a8a9a31eae8057f9a813fc13d3172f77.camel@amazon.co.uk>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-OO7M3RmA0rYarTLMgT6+"
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-OO7M3RmA0rYarTLMgT6+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-04-10 at 10:15 +0000, Allister, Jack wrote:
> > AFAIR, I copied check_clocksource() from existing code during that >
> time.
>=20
> > The commit e440c5f2e ("KVM: selftests: Generalize check_clocksource()
> > from kvm_clock_test") has introduced sys_clocksource_is_tsc(). Later
> > it is renamed to sys_clocksource_is_based_on_tsc().
> > Any chance to re-use sys_clocksource_is_based_on_tsc()?
>=20
> Yes I'm more than happy to change it to that. I was using your original
> mail as a reference and did not realise there was a utility present for
> this.
>=20
> > Is configure_scaled_tsc() anecessary? Or how about to make it an=C2=A0 =
>
> option/arg?
> > Then I will be able to test it on a VM/server without TSC scaling.
>=20
> So if TSC scaling from 3GHz (host) -> 1.5GHz (guest) I do see a skew of
> ~3500ns after the update. Where as without scaling a delta can be seen
> but is roughly ~180ns.

I don't think it's as simple as "TSC scaling makes the drift larger".
I suspect that's just the way the arithmetic precision works out for
those frequencies. With other frequencies of host and guest you might
find that it works out closer *with* the scaling.

Consider a graph of "time" in the Y axis, against the host TSC as the X
axis. As an example, let's assume the host has a TSC frequency of 3GHz.

Each of the three definitions of the KVM clock (A based on
CLOCK_MONOTONIC_RAW, B based on the guest TSC, C based directly on the
host TSC) will have a gradient of *roughly* 1 ns per three ticks.

Due to arithmetic precision, the gradient of each is going to vary
slightly. We hope that CLOCK_MONOTONIC_RAW is going to do the best, as=20
the other two are limited by the precision of the pvclock ABI that's
exposed to the guest. You can use http://david.woodhou.se/tsdrift.c to
see where the latter two land, for different TSC frequencies.

 $ ./tsdrift 2500000000 3000000000 | tail -1
TSC 259200000000000, guest TSC 215999999979883, guest ns 86399999971836 hos=
t ns 86399999979883 (delta -8047)
 $ ./tsdrift 2700000000 3000000000 | tail -1
TSC 259200000000000, guest TSC 233279999975860, guest ns 86399999983012 hos=
t ns 86399999979883 (delta 3129)

So after a day, let's assume CLOCK_MONOTONIC_RAW will have advanced by
86400 seconds. The KVM clock based on the host TSC will be 20=C2=B5s slow,
while a KVM clock based on a guest TSC frequency of 2.5GHz would be an
*additional* 8=C2=B5s slower. But a guest TSC frequency of 2.7GHz would
actually run *faster* than the host-based one, and would only be 17=C2=B5s
behind reality.

Your test is measuring how *much* the host CLOCK_MONOTONIC_RAW (my
definition A) drifts from definition B which is derived from the guest
TSC.

It demonstrates the discontinuity that KVM_REQ_MASTERCLOCK_UPDATE
introduces, by clamping the KVM clock back to the 'definition A' line.

Fixing that is in the TODO list I shared. Basically it involves
realising that in use_master_clock mode, the delta between the KVM
clock and CLOCK_MONOTONIC_RAW (ka->kvmclock_offset) is *varying* over
time. So instead of just blindly using kvmclock_offset, we should
*recalculate* it in precisely the way that your KVM_SET_CLOCK_GUEST
does.

Having said all that... scaling from 3GHz to 1.5GHz *doesn't* lose any
precision; it shouldn't make any difference. But I guess your host TSC
isn't *really* 3GHz, it's measured against the PIT or something awful,
and comes out at a shade above or below 3GHz, leading to a more
interesting scaling factor?

> In V2 I've adjusted the test so that now by default scaling won't take
> place, however if someone wants to test with it enabled they can pass
> "-s/--scale-tsc" to induce the greater delta.

Please do it automatically based on the availability of the feature.


--=-OO7M3RmA0rYarTLMgT6+
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQwNDExMTMyODM3WjAvBgkqhkiG9w0BCQQxIgQgy0tx3tHa
X/CuppcXAcioDknx35r8YAUFkLa4ZC/b1lIwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgAKP6SnRPluyZ0P294Xx3kTefWmh0kPGNAV
AI06rovgesa2xPcNu4Tn829ajNiWEQ8TBKfLYzTdN3g/W/RQ4x+Ng2fmghniKreMcqRXpQ1r9W9d
XKy9fNEewsOyFRA5KqLiVZ/+Gi1ZYhxNDwgzsQ7IgtWTm5QMC4vmBorbnVEAG7z2e7owa65XSJ0i
lRrBf3UXqqwEJIUBTPWEufBC/8yE6+xtqf5gtw2dGQ0ElQdhVlvqBSYZWXGipkm+8Bt19wY69Tzi
co2lY7vohSE1E5NS4W6jEu/2CFNyS062VqJvxGRK1QTQfaHwOVnFreaeXm6r+sdTNkFTpH+nSzV1
h+aeN5bRFbbQ3wksch7sb5zA8ZrKiPJ8xafqdAQpAhqSJ3IW/gyapkdJowsrjFU7RfVkyQb90QgM
ImSsT4HHhRG7V3qDzIBfBL/+CERXiuKf/sI0Zwp3K2WT1P2xoUIW1i3gnbJEjAYaGTGy9tyrlG1l
OOQj0RrfvKaN2Z77kPdGKP6i9jMIq9Hj8/T4kLyOKuNMcYkG06XLjhSY6MbvutRC+couSrUITZEl
cN1xTiS1sw6Bf3OkbcZSYTtC/LDivf2slxaZebLEMQTvz7i5s75iMIv+irdUVbIWUlXMDRmLk0J6
w7gYqMSa55k8fpku4/NyNLhkwA9IjsfRyViu3afbtAAAAAAAAA==


--=-OO7M3RmA0rYarTLMgT6+--

