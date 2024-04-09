Return-Path: <linux-kselftest+bounces-7465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D3489D17A
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 06:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A791C239EA
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 04:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372A86BB20;
	Tue,  9 Apr 2024 04:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="chARewx9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AAE6BFA7;
	Tue,  9 Apr 2024 04:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712636615; cv=none; b=oKVi41YEuK5mg31qJk0LJI9OMxndPDSMdiJGNvlBai+ne/jXoPxh2cnfxBGDtPVl1nM60Tfa6EHnBagAZFbGENUwO4vMd2P824oP30SJ5Zz+0kMkG6edZGFXw1tGU33H//1zxTZSiUNpm+KtP+3ukGU/E3zLS8eOrM/jL36+7x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712636615; c=relaxed/simple;
	bh=bpjP5si7Ysqo7FfRwnJbi8i8lfsEW5YFtjjGL9We4sA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jsq+Yc6RdLxPIH99eZ7OyZ21Zc2tpQQOTDZN0GlZNlI82VhXTYjqkEnylN1ygn7+uKkfshsyDl9eKrdj+MbsznzK1ObyV4Ya3jC5PEbehQMYH4FLF+xHSah1GKISHFVYJmTcPEW3nnyHiCoo/Xm/aBdPSWnmzYbPCYbZ1zQgD4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=chARewx9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B5/PI8tpV58jhcHGA5rOawrHTijotyoHKG2Xt2fJP9M=; b=chARewx9tfgDqS/gSKCQUQ82No
	zckPO6ey9PscvAjCJowuUeKVCzSMS37mnhuc54w33MaVqni6wtk9F1tFoSTrfu1prAjt1JsZsn8kI
	d5AzZh7DNqAWX44qKwYHzgkM5cHewAVgXd8kkS7EuDaFl1wWWkieCZyHC4SbfRY6R1eifgvwuCAfI
	rhmRzYunSbpfw3rKCpmgkvsoACI/6jarE0rEEprqr4OioEwTbkCmWiuRBqHuZSQ5ljEpm9GWBNIV1
	Tkio68Mu9N+pXKFDRsSWvR7tBkWHnaSzbuA52Fs7d0TnHP5bkTYMtWgzIHIPIk0HceHJ2K1S6kTpd
	Mj98C21g==;
Received: from [2001:8b0:10b:5:2f81:68c0:d3e5:5a65] (helo=u3832b3a9db3152.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ru30y-00000001KQv-313V;
	Tue, 09 Apr 2024 04:23:20 +0000
Message-ID: <c12959cf6ca372569b4df10b2f9e272db1114ad1.camel@infradead.org>
Subject: Re: [PATCH 2/2] KVM: selftests: Add KVM/PV clock selftest to prove
 timer drift correction
From: David Woodhouse <dwmw2@infradead.org>
To: Dongli Zhang <dongli.zhang@oracle.com>, Jack Allister
 <jalliste@amazon.com>,  Paolo Bonzini <pbonzini@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, Sean Christopherson <seanjc@google.com>,  Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,  Shuah Khan
 <shuah@kernel.org>
Cc: Paul Durrant <paul@xen.org>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Tue, 09 Apr 2024 05:23:19 +0100
In-Reply-To: <9377995a-26a4-2523-e421-be1cd92bdc34@oracle.com>
References: <20240408220705.7637-1-jalliste@amazon.com>
	 <20240408220705.7637-3-jalliste@amazon.com>
	 <9377995a-26a4-2523-e421-be1cd92bdc34@oracle.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-lYNBFWCqfsCzhD3ipbEa"
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-lYNBFWCqfsCzhD3ipbEa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-04-08 at 17:43 -0700, Dongli Zhang wrote:
> Hi Jack,
>=20
> On 4/8/24 15:07, Jack Allister wrote:
> > This test proves that there is an inherent KVM/PV clock drift away from=
 the
> > guest TSC when KVM decides to update the PV time information structure =
due
> > to a KVM_REQ_MASTERCLOCK_UPDATE. This drift is exascerbated when a gues=
t is
>=20
> Typo: exacerbated
>=20
> > using TSC scaling and running at a different frequency to the host TSC =
[1].
> > It also proves that KVM_[GS]ET_CLOCK_GUEST API is working to mitigate t=
he
> > drift from TSC to within =C2=B11ns.

No, the KVM_[GS}ET_CLOCK_GUEST API is not about mitigating kernel bugs.

We *fix* kernel bugs, we don't make userspace work around them.

The KVM_[GS}ET_CLOCK_GUEST API allows userspace to perform accurate
live update and live migration without disrupting the relationship
between guest TSC and KVM clock.

Since a bombing run on KVM_REQ_MASTERCLOCK_UPDATE users is on my TODO
list, it's worth noting the *reason* that switching to the obsolete
MSR_KVM_SYSTEM_TIME forces ka->use_master_clock mode off.=20

It's not documented at all as far as I can tell, but in commit
54750f2cf042 (=E2=80=9CKVM: x86: workaround SuSE's 2.6.16 pvclock vs
masterclock issue=E2=80=9C)=EF=BB=BF in 2015, it was done to work around a =
guest bug
where the guest *expected* the reference point to keep being updated
and never be too far in the past.


> Is configure_scaled_tsc() anecessary? Or how about to make it an
> option/arg?
> Then I will be able to test it on a VM/server without TSC scaling.

As discussed, TSC scaling shouldn't be needed. It *should* be part of
the unit test if possible, because there is a class of bugs it'll
trigger, but it should be optional.

In particular, the existing KVM_GET_CLOCK will return extra-wrong
results if TSC scaling is in force. But that isn't being tested here
yet because we haven't *fixed* it yet :)

For reference, here's my TODO list which Jack is working from...

 =E2=80=A2 Add KVM unit test to validate that KVM clock does not change whe=
n
   provoked (including by simulated live update).
   It=E2=80=99s OK for the reference point at { tsc_timestamp, system_time =
} in
   the pvclock structure to change, but only such that it gives the
   same results for a given guest TSC =E2=80=94 that is, if system_time
   changes, then tsc_timestamp must change by a delta which precisely
   corresponds in terms of the advertised guest TSC frequency. Perhaps
    allow a slop of 1ns for rounding, but no more.

 =E2=80=A2 Audit and fix (i.e. remove) KVM_REQ_MASTERCLOCK_UPDATE usage,
   starting with kvm_xen_shared_info_init(). And work out whether it
   should be sent to all vCPUs, as some call sites do, or just one?

 =E2=80=A2 Add KVM_VCPU_TSC_SCALE attribute to allow userspace to know the
   precise host=E2=86=92guest TSC scaling.
   (cf. https://lore.kernel.org/all/13f256ad95de186e3b6bcfcc1f88da5d0ad0cb7=
1.camel@infradead.org/)

 =E2=80=A2 Expose guest=E2=80=99s view of KVM clock to userspace via KVM_GE=
T_CLOCK_GUEST
   ioctl. Perhaps also a memory-mapped version, as the gfn_to_pfn_cache
   allows writing to userspace HVAs. With this, userspace has fast and
   accurate way to calculate the KVM clock at any given moment in time.
  =C2=A0(Currently, userspace calls the KVM_GET_CLOCK ioctl which is slow
   and returns inaccurate results). Then userspace can base other
   things like PIT and HPET emulation on the KVM clock and simplify
   timekeeping over migration for those too.

 =E2=80=A2 Add a KVM_SET_CLOCK_GUEST ioctl which consumes the pvclock
   information back again. This should not only set the kvmclock_offset
=C2=A0  field, but also set the reference point { master_cycle_now,
   master_kernel_ns } as follows:
     =E2=80=A2 Sample the kernel=E2=80=99s CLOCK_MONOTONIC_RAW to create a =
new
       master_kernel_ns and master_cycle_now.
     =E2=80=A2 Convert the new master_cycle_now to a guest TSC.
     =E2=80=A2 Calculate the intended KVM clock with that guest TSC from th=
e
       provided pvclock information.
     =E2=80=A2 Calculate the current KVM clock with that guest TSC using th=
e
       new master_cycle_now and master_kernel_ns and kvmclock_offset as
       usual.
     =E2=80=A2 Adjust kvmclock_offset to correct for the delta between curr=
ent
       and intended values.
     =E2=80=A2 Raise KVM_REQ_CLOCK_UPDATE on all vCPUs.

 =E2=80=A2 Fix the broken __get_kvmclock() function to scale via the guest=
=E2=80=99s
   TSC frequency as it should. There isn=E2=80=99t necessarily a vCPU to us=
e
   for this, so it=E2=80=99s OK for this to work only when the frequency ha=
s
   been set of the whole VM rather than only for individual vCPUs.
   Likewise kvm_get_wall_clock_epoch() which has the same bug.

 =E2=80=A2 Fix all other cases where KVM reads the time in two places
   separately and then treats them as simultaneous.

 =E2=80=A2 Fix the discontinuities in KVM_REQ_MASTERCLOCK_UPDATE by allowin=
g
   kvmclock_offset to vary while the VM is running in master clock
   mode. Perhaps every call to pvclock_update_vm_gtod_copy() which
   starts in master clock mode should follow the same process as the
   proposed KVM_SET_CLOCK_GUEST to adjust the kvmclock_offset value
   which corresponds with the new reference point. As long as we don=E2=80=
=99t
   break in the case where something weird (host hibernation, etc.)
   happened to the TSC, and we actually want to trust kvmclock_offset.
   Maybe we should have a periodic work queue which keeps
   kvmclock_offset in sync with the KVM clock while the VM is in master
   clock mode?=20

 =E2=80=A2 Correct the KVM =EF=BB=BFdocumentation =EF=BB=BFfor TSC migratio=
n to take TSC
scaling
   into account. Something like...

   (SOURCE)
    =E2=80=A2 Sample both TAI and the (source) host TSC at an arbitrary tim=
e we
=C2=A0     shall call Tsrc:
      =E2=80=A2 Use adjtimex() to obtain tai_offset.
      =E2=80=A2 Use KVM_GET_CLOCK to read UTC time and host TSC (ignoring t=
he
        actual kvm clock). These represent time Tsrc.
      =E2=80=A2 Use adjtimex() to obtain tai_offset again, looping back to =
the
        beginning if it changes.
      =E2=80=A2 Convert the UTC time to TAI by adding the tai_offset.

    =E2=80=A2 =E2=88=80 vCPU:
      =E2=80=A2 Read the scaling information with the KVM_CPU_TSC_SCALE
        attribute.
      =E2=80=A2 Read the offset with the KVM_CPU_TSC_OFFSET attribute.
      =E2=80=A2 Calculate this vCPU=E2=80=99s TSC at time Tsrc, from the ho=
st TSC
        value.

    =E2=80=A2 Use KVM_GET_CLOCK_GUEST to read the KVM clock (on vCPU0).

   (DESTINATION)
    =E2=80=A2 Sample both TAI and the (destination) host TSC at a time we s=
hall
      call Tdst:
      =E2=80=A2 Use adjtimex() to obtain tai_offset.
      =E2=80=A2 Use KVM_GET_CLOCK to read UTC time and host TSC.
      =E2=80=A2 Use adjtimex() to obtain tai_offset again, looping back to =
the
        beginning if it changes.
      =E2=80=A2 Convert the UTC time to TAI by adding the tai_offset.

    =E2=80=A2 Calculate the time (in the TAI clock) elapsed between Tsrc an=
d
      Tdst. Call this =CE=94T.

    =E2=80=A2 =E2=88=80 vCPU:
      =E2=80=A2 Calculate this vCPU=E2=80=99s intended TSC value at time Td=
st:
        =E2=80=A2 Given this vCPU=E2=80=99s TSC frequency, calculate the nu=
mber of TSC
          ticks correponding to =CE=94T.
        =E2=80=A2 Add this to the vCPU TSC value calculated on the source
        =E2=80=A2 Read the scaling information on the current host with the
          KVM_CPU_TSC_SCALE attribute
        =E2=80=A2 Calculate this vCPU=E2=80=99s scaled TSC value correspond=
ing to the
          host TSC at time Tdst without taking offsetting into account.
        =E2=80=A2 Set KVM_CPU_TSC_OFFSET to the delta between that and the
          intended TSC value.

    =E2=80=A2 Use KVM_SET_CLOCK_GUEST to set the KVM clock (on vCPU0).





--=-lYNBFWCqfsCzhD3ipbEa
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQwNDA5MDQyMzE5WjAvBgkqhkiG9w0BCQQxIgQgtjUW+Fc+
0DLIFJUa9viG2sTJTeTH1VYsMYe2JPjpnhowgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgClBtiXEl5QkDg0CLbrby0z1YA5HqrVt/aQ
l/ARkZ4ZUyex3cAswUh+d7r5PKO+047f/+66B1+mPuy2FgawjbrhUBNitZkT94RxBpa+Mttql1rA
PYUSkpWDmE3BV6jF2QFDGmLiVULVMhIGMbhYwZv00VLlLCrbbmn628t1SdL0fgfG55ElHzT9uT1T
1FqGCeC84A8aJSXM7nPZV/eogfwQG/YH4TC77RvjJBgVrMtS5O+OY3ND9Cp+EPhbAf4GNQ2lkoq9
uZ+j7j+JgqOHII5wMdrvIsvW7N669IpIAZ/JpIvN3g+QMNhyjAXo9bSNWdzhaKF/S8jceRQ2YFIk
hjLjxh4dKas7ATsqNPdq/EmnGE1qahLRWbcJ+Wxp9pBFzY7jn4+gpAUnrq08WaRsPeb5igY2KwzS
TOjlN5k4gIzyLO/0nxbdBmRk5/BMZQL9uO22PgHzwnRW4DYtuSlhl/XBwhO1xMqL8sU6yfUZpkVd
HYv9lZ6J0vIATGVAl4DpHWRyQFIfuf9ltIMzUIKTioGedlijj0GohnEFdlipl2YuJhww91AF8NYO
FoZmYd6HrWyaFcye8Xris+66nGjR1by7VKxZ+aCVyqKaVGw1477Uqom5XfZ6FE49M0Pe8sWV2mS/
Xl5DUXJYMUfYFNzSOy6RDAy2cZoYTPiIGojuEfrIeAAAAAAAAA==


--=-lYNBFWCqfsCzhD3ipbEa--

