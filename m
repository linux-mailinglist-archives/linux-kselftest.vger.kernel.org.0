Return-Path: <linux-kselftest+bounces-8767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB898B0A37
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 14:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162E528399C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 12:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB9A15B133;
	Wed, 24 Apr 2024 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QAQnZZZD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E80142E70;
	Wed, 24 Apr 2024 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963536; cv=none; b=eiIrI3+X7xtP/4VgIGFeBiyQWjamrkoeuzekWsR4slV4J9XEm2QFnPxq/Ec0AMznyOYeW6HrB1CsLXevacSHne1D5mvgTBencnE4fd4CgmchLjTj9hzNVVX0hExjvb7bMbz/vV34j3+ZwD4tSnxIGE2Jfzn/iPk1PQjqFr2DOfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963536; c=relaxed/simple;
	bh=c9RreOvvgjKo465NP2jeeUIux9VWDQP4D1wGlxLC+Iw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=POCTSxRp+eQ4jlcE0ixl0R8tX+0OWJCvKG6BfYM4VqKqYVk0cvVNw/FaVwJmV0lCWObaoIelHBvUaYlW4XSLWEl+SArAA/QECcCWXrmyH/wE8meEQXwfZv3CTNl12pftYT6OqAnrISqR5B+6qwYjihQu0fFNtwIIJE0BMJrf9Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QAQnZZZD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KRH1XQ4li10cH7uqk/vSuNXotg9b5T8OyHlR8OT7SIU=; b=QAQnZZZDTXOBrn6cF4YKUX3ngr
	6QBUVtemehUj+9x0rl0ZDDI30JQusexfSKR+O70wSbKauZkD3/nK8odgWhhmTIX1hZgrQ3jfmKl/l
	Wxp1bYc22XGc4fCkafFpPR1ZzJdC6sZrM7bx2tYk3x6XEJRfwvZYJXyJZwJKY7lLQlo25FrS9bZaq
	9aJ3ER9oNvo5S+7agRI7O3MxfbXhFMeXYgq6a2brjaRjjMBKP1YCajApOc7lrikHuES20rN80oZ0B
	wMugUvXufaUUJ9zKsevd0O16JZKLb+1hJ2bMKCek3gm/yfebgisNLx5Sc31vxFlQqK8quAGm1158Z
	9PWNH4gg==;
Received: from [2001:8b0:10b:5:c773:ea0d:c499:f0f9] (helo=u3832b3a9db3152.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzcCf-00000000voV-14iU;
	Wed, 24 Apr 2024 12:58:25 +0000
Message-ID: <c8dca08bf848e663f192de6705bf04aa3966e856.camel@infradead.org>
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
Date: Wed, 24 Apr 2024 13:58:24 +0100
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
	boundary="=-qp+7JygYuSqAXLWFq+00"
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-qp+7JygYuSqAXLWFq+00
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-04-22 at 15:02 -0700, Chen, Zide wrote:
> the selftest works for me, and I ran the test for 1000+ iterations,
> w/ or w/o TSC scaling, the TEST_ASSERT(delta_corrected=C2=A0<=3D =C2=B11)=
 never
> got hit. This is awesome!

I think that with further care we can get even better than that.

Let's look at where that =C2=B11ns tolerance comes from.

Consider a 3GHz TSC. That gives us three ticks per nanosecond. Each TSC
value can be seen as (3n) (3n+1) or (3n+2) for a given nanosecond n.

If we take a new reference point at a (3n+2) TSC value and calculate
the KVM clock from that, we *know* we're going to round down and lose
two-thirds of a nanosecond.

So then we set the new KVM clock parameters to use that new reference
point, and that's why we have to allow a disruption of up to a single
nanosecond. In fact, I don't think it's =C2=B11 ns, is it? It'll only ever
be in the same direction (rounding down)?

But if we're careful which *which* TSC value we use as the reference
point, we can reduce that error.

The TSC value we use should be *around* the current time, but what if
we were to evaluate maybe the previous 100 TSC values. Pass *each* of
them through the conversion to nanoseconds and use the one that comes
*closest* to a precise nanosecond (nnnnnnnn.000).

It's even fairly easy to calculate those, because of the way the KVM
clock ABI has us multiply and then shift right by 32 bits. We just need
to look at those low 32 bits (the fractional nanosecond) *before*
shifting them out of existence. Something like...

   uint64_t tsc_candidate, tsc_candidate_last, best_tsc;
   uint32_t frac_ns_min =3D 0xffffffff;
   uint64_t frac_ns;

   best_tsc =3D tsc_candidate =3D rdtsc();
   tsc_candidate_last =3D=C2=A0tsc_candidate - 100;

   while (tsc_candidate-- > tsc_candidate_last) {
      uint64_t guest_tsc =3D kvm_scale_tsc(tsc_candidate, ...);
      frac_ns =3D guest_tsc * hvclock->tsc_to_system_mul;
      /* Shift *after* multiplication, not before as pvclock_scale_cycles()=
 does. */
      if (hvclock->tsc_shift < 0)
          frac_ns >>=3D -hvclock->tsc_shift;
      else
          frac_ns <<=3D hvclock->tsc_shift;

      if ( (uint32_t)frac_ns <=3D frac_ns_min ) {
          frac_ns_min =3D frac_ns;
          best_tsc =3D tsc_candidate;
      }
   }
   printk("Best TSC to use for reference point is %lld", best_tsc);

And then you calculate your CLOCK_MONOTONIC_RAW and guest KVM clock
from *that* host TSC value, and thus minimise the discrepancies due to
rounding down?

Aside from the fact that I literally just typed that into email and
it's barely even thought through let alone entirely untested... I'm
just not sure it's even worth the runtime cost, for that =C2=B11 ns on a
rare case.

A slop of =C2=B11ns is probably sufficient because over the past few years
we've already shifted the definition of the KVM clock to *not* be NTP-
corrected, and we leave guests to do fine-grained synchronization
through other means anyway.

But I see talk of people offering a PPS signal to *hundreds* of guests
on the same host simultaneously, just for them all to use it to
calibrate the same underlying oscillator. Which is a little bit insane.

We *should* have a way for the host to do that once and then expose the
precise time to its guests, in a much saner way than the KVM clock
does. I'll look at adding something along those lines to this series
too, which can be driven from the host's adjtimex() adjustments (which
KVM already consumes), and fed into each guest's timekeeping as a
PTP/PPS device or something.



--=-qp+7JygYuSqAXLWFq+00
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQwNDI0MTI1ODI0WjAvBgkqhkiG9w0BCQQxIgQghevfWqeT
OJ5b4l9YTMCxE29xDm+k3iOCcgUm3R48DiAwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgB9TabPYtOjHzlcya67H67rlTSLY2pt1GjT
1R4K2bcrJVn4EnGY7lwWJMyhjhTPtw6bNOGSZCH4dlYMjIIfLNzP/kgSS1ADWCNQBPzzU/Z7csOR
/Nf/sUV6zugRYlTtdugVYTVSmUBDu2AwqdDCdQVXlKN15IjgwvniVnXRJPt0z3n8rB9cFvj88+0l
J0G6Fwo7eUEZQGOqstcGnXJWCxFukBCOrzdcuWfQrvxxBVsfw+p9cqnocTO55U9cgbq1s5EDec1d
iyJLHbusnvdG4yebFwv0lZtWBk7MDWyOAelykdnYzEKsHJMfRgToYP5F06bG9eYCs1knA+4i6k3S
J+q0J0c36aIztju6mcTa6QATM8aT5X12k82KPmFiQvAD0xmHslDFMfqnSiN64KjqGP2UpFnoWBYz
oE2xbe4TkxSuzUsvlY8IjXRuuJCEW1zCfeLYQAEGo3SHJXrefAjPg8dArEebDiJlr99aOFUZSBMf
ymLiJtq4hGgtaTv/otmmWZT6hYV3qQsbUZdHEsnIAKO67N8X+2e8LnUok9GCuUt8XyVlJlEeLOuf
dcVNBquHsRRch1fZYpzQBGe8CxcC8BxKWZdc9mtt27A+Dzh0LCqqS9NdNJi//CGtO5eg+pA5Tos5
mofleBBSE1UbrJ2SgY7LkdPvM2c/fuireQe0qBDVMQAAAAAAAA==


--=-qp+7JygYuSqAXLWFq+00--

