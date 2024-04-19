Return-Path: <linux-kselftest+bounces-8422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EE68AAED5
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 14:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1241DB219EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 12:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A7E85631;
	Fri, 19 Apr 2024 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b7nsP3Cw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1794D137;
	Fri, 19 Apr 2024 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713531129; cv=none; b=HG7hR8kiL4EtxcvDIpaiehSarx0b7WKqDGGjfCkOfY1yzgto1eB0WMIDkMfZNTqH+nrtIjifU3NC4cX2JWpYPHVt8cmld9yq4vr63fW8AxW/lxljJModIeXP9Z3dYED7RYk2ujDiVSMsObKUxcMSSuW6anTj7LnsFTZAmIbyvVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713531129; c=relaxed/simple;
	bh=Wp6p4pM7sMSjMzfUlyba631lKZP2PLARyhUM0ofGv+U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pItwozFnlOTBFzVj3b4e3K4xJf3na3BpdxGDUnFdaHQqJudBiTXRpRIhJi7lixuapDpzjg5t3/dbtNcgGuR2JhXlUYbLVSiqDgTTHcTXrGTOixQyXieFHvgTEVl+b8FKjea/5aK2702fHEaPwZi1f9uJLcvaACKIiH0JUtBAQl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b7nsP3Cw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sSKFy7D/dmB/oF984z3LfPtEgeoxTcZItiyNrK7PKig=; b=b7nsP3Cw2KRmL4GgsuQx1NHh4F
	ETcewaDmSBMFt6drZ/paozRNyWF7xidCKusY03ynz6AwiiskV1reJqldQ2do2SQwacZvej7QNpgUN
	BwfJXk7LRLeSf8yMvFtTetPTNFhlLBIdHPGeIGJAWoQgl4Jz9Ig53P8iMXzjjEleX2W5qNNPXXCVE
	OAcnZe3cbrWW+cKRE/Mil3cIiipIKM6VSNwYZTqhxoskk/AwfMmeNSRePf5vud5CegxQNXPCFSSin
	aMIPOoF64cmus3FAh+lfGZSOS/yN/G+oAw2owJvwphdMePEmtGEDWZ1J9UCudC5AwX2po6dUu/75H
	RLptfE2A==;
Received: from [2001:8b0:10b:5:c08e:a4fc:45a2:fa90] (helo=u3832b3a9db3152.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxnig-00000007g89-3PVk;
	Fri, 19 Apr 2024 12:51:59 +0000
Message-ID: <4cb5e38cfce2dbd73635177842e79d479fc2942f.camel@infradead.org>
Subject: [PATCH 11/10] KVM: x86: Fix software TSC upscaling in
 kvm_update_guest_time()
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org, Dongli Zhang <dongli.zhang@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,  Paul Durrant <paul@xen.org>, Shuah Khan
 <shuah@kernel.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Oliver Upton
 <oliver.upton@linux.dev>, Marcelo Tosatti <mtosatti@redhat.com>, 
 jalliste@amazon.co.uk, sveith@amazon.de
Date: Fri, 19 Apr 2024 13:51:58 +0100
In-Reply-To: <20240418193528.41780-1-dwmw2@infradead.org>
References: <20240418193528.41780-1-dwmw2@infradead.org>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-9m/obiVYTdW3eVni6Ppk"
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-9m/obiVYTdW3eVni6Ppk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

There was some confusion in kvm_update_guest_time() when software needs
to advance the guest TSC.

In master clock mode, there are two points of time which need to be taken
into account. First there is the master clock reference point, stored in
kvm->arch.master_kernel_ns (and associated host TSC ->master_cycle_now).
Secondly, there is the time *now*, at the point kvm_update_guest_time()
is being called.

With software TSC upscaling, the guest TSC is getting further and further
ahead of the host TSC as time elapses. So at time "now", the guest TSC
should be further ahead of the host, than it was at master_kernel_ns.

The adjustment in kvm_update_guest_time() was not taking that into
account, and was only advancing the guest TSC by the appropriate amount
for master_kernel_ns, *not* the current time.

Fix it to calculate them both correctly.

Since the KVM clock reference point in master_kernel_ns might actually
be *earlier* than the reference point used for the guest TSC
(vcpu->last_tsc_nsec), this might lead to a negative delta. Fix the
compute_guest_tsc() function to cope with negative numbers, which
then means there is no need to force a master clock update when the
guest TSC is written.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
Untested. Thrown on the pile at
https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/clocks
which we'll be testing more next week...

 arch/x86/kvm/x86.c | 61 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5cd92f4b4c97..a78adef698bd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2488,10 +2488,19 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u=
32 user_tsc_khz)
=20
 static u64 compute_guest_tsc(struct kvm_vcpu *vcpu, s64 kernel_ns)
 {
-	u64 tsc =3D pvclock_scale_delta(kernel_ns-vcpu->arch.this_tsc_nsec,
-				      vcpu->arch.virtual_tsc_mult,
-				      vcpu->arch.virtual_tsc_shift);
-	tsc +=3D vcpu->arch.this_tsc_write;
+	s64 delta =3D kernel_ns - vcpu->arch.this_tsc_nsec;
+	u64 tsc =3D vcpu->arch.this_tsc_write;
+
+	/* pvclock_scale_delta cannot cope with negative deltas */
+	if (delta >=3D 0)
+		tsc +=3D pvclock_scale_delta(delta,
+					   vcpu->arch.virtual_tsc_mult,
+					   vcpu->arch.virtual_tsc_shift);
+	else
+		tsc -=3D pvclock_scale_delta(-delta,
+					   vcpu->arch.virtual_tsc_mult,
+					   vcpu->arch.virtual_tsc_shift);
+
 	return tsc;
 }
=20
@@ -2502,7 +2511,7 @@ static inline bool gtod_is_based_on_tsc(int mode)
 }
 #endif
=20
-static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool new_generat=
ion)
+static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu)
 {
 #ifdef CONFIG_X86_64
 	struct kvm_arch *ka =3D &vcpu->kvm->arch;
@@ -2519,12 +2528,9 @@ static void kvm_track_tsc_matching(struct kvm_vcpu *=
vcpu, bool new_generation)
=20
 	/*
 	 * Request a masterclock update if the masterclock needs to be toggled
-	 * on/off, or when starting a new generation and the masterclock is
-	 * enabled (compute_guest_tsc() requires the masterclock snapshot to be
-	 * taken _after_ the new generation is created).
+	 * on/off.
 	 */
-	if ((ka->use_master_clock && new_generation) ||
-	    (ka->use_master_clock !=3D use_master_clock))
+	if ((ka->use_master_clock !=3D use_master_clock))
 		kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);
=20
 	trace_kvm_track_tsc(vcpu->vcpu_id, ka->nr_vcpus_matched_tsc,
@@ -2702,7 +2708,7 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vc=
pu, u64 offset, u64 tsc,
 	vcpu->arch.this_tsc_nsec =3D kvm->arch.cur_tsc_nsec;
 	vcpu->arch.this_tsc_write =3D kvm->arch.cur_tsc_write;
=20
-	kvm_track_tsc_matching(vcpu, !matched);
+	kvm_track_tsc_matching(vcpu);
 }
=20
 static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
@@ -3296,8 +3302,6 @@ static int kvm_guest_time_update(struct kvm_vcpu *v)
 		kernel_ns =3D get_kvmclock_base_ns();
 	}
=20
-	tsc_timestamp =3D kvm_read_l1_tsc(v, host_tsc);
-
 	/*
 	 * We may have to catch up the TSC to match elapsed wall clock
 	 * time for two reasons, even if kvmclock is used.
@@ -3309,11 +3313,34 @@ static int kvm_guest_time_update(struct kvm_vcpu *v=
)
 	 *	very slowly.
 	 */
 	if (vcpu->tsc_catchup) {
-		u64 tsc =3D compute_guest_tsc(v, kernel_ns);
-		if (tsc > tsc_timestamp) {
-			adjust_tsc_offset_guest(v, tsc - tsc_timestamp);
-			tsc_timestamp =3D tsc;
+		uint64_t now_guest_tsc_adjusted;
+		uint64_t now_guest_tsc_unadjusted;
+		int64_t now_guest_tsc_delta;
+
+		tsc_timestamp =3D compute_guest_tsc(v, kernel_ns);
+
+		if (use_master_clock) {
+			uint64_t now_host_tsc;
+			int64_t now_kernel_ns;
+
+			if (!kvm_get_time_and_clockread(&now_kernel_ns, &now_host_tsc)) {
+				now_kernel_ns =3D get_kvmclock_base_ns();
+				now_host_tsc =3D rdtsc();
+			}
+			now_guest_tsc_adjusted =3D compute_guest_tsc(v, now_kernel_ns);
+			now_guest_tsc_unadjusted =3D kvm_read_l1_tsc(v, now_host_tsc);
+		} else {
+			now_guest_tsc_adjusted =3D tsc_timestamp;
+			now_guest_tsc_unadjusted =3D kvm_read_l1_tsc(v, kernel_ns);
 		}
+
+		now_guest_tsc_delta =3D now_guest_tsc_adjusted -
+			now_guest_tsc_unadjusted;
+
+		if (now_guest_tsc_delta > 0)
+			adjust_tsc_offset_guest(v, now_guest_tsc_delta);
+	} else {
+		tsc_timestamp =3D kvm_read_l1_tsc(v, host_tsc);
 	}
=20
 	local_irq_restore(flags);
--=20
2.34.1



--=-9m/obiVYTdW3eVni6Ppk
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQwNDE5MTI1MTU4WjAvBgkqhkiG9w0BCQQxIgQgrGapJ0XE
BffyDPmd8OPbqHwsNxa/b8SLDOWHAgjtMtowgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgCoT3r/PEj2UdGaDt+eMmxe4C6sPkatiZjO
UBmPpNGuFW4MY4mpICVoGjEs/acDaz3h4sD8PsJ/+5B1OwTYgJ4IIECPq6WlvfOn6ku0plaSzk/B
98iKrZbvEdoWh627bLRhpqljKfEsOTjPhL1pAQuDucd7380oRGbNnQE50ftfDzrq1kBw/g/3E++7
qd9tswY/lyaqGAi68ACuD6QDw2JvuF5gg2rwirT+An/cLL5dgorem7YyG4IZbdb9XbIRkJNtGyzK
R7cd295fw7DdjcoKj5+TIeIsWQnZJJMdfpdIPsRHoQrWggN+B0qoQpXldM644nvszKJRC9MGwEtH
w20GZB6R9mkZsnxWuLCD+suGbkEy0AlSyMEbeWl/tcjKKGgFl5xyGz3RVwPlLkKzQH6tHtVHHB5O
jY7WY7Djs7y7CEL6WLnzv5CPrM4apyeo/7m322ED8/nCX1zwpcC1C5sfjC8ZYe3IApwOJYOt/jSM
IUUXTeJbJL4duX7pfhK9myouwBsWa0j9+qvcb5andztpRr2k/MCovltAuhhcaY7WwIUUpUP+2Q5G
gC7hGbQysDQRcSIhTAxOCKemQxnqjgFUgWFctB0RgY0jpYwHua5L5Rh38AQFtCDnVAc2e6cAM39k
hirdaTJc7b+Ee/HkFV7SdEODEQ7lF7Gf+Tyy1NR+7AAAAAAAAA==


--=-9m/obiVYTdW3eVni6Ppk--

