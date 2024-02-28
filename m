Return-Path: <linux-kselftest+bounces-5549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B8986B7E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 20:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BCEE289A0B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 19:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AE77440C;
	Wed, 28 Feb 2024 19:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/AGlZl5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8144771ECC;
	Wed, 28 Feb 2024 19:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709147069; cv=none; b=LY0HCsGrYzecBEbKlFONcbhP5c5pNf4gtCDcutjwZW0UEV9h5Vj/t+rATKX+9vtTSIs8xrezIRPw6c2+hjvcK2IO0ZzpLd3/atghBxjbx/C/ibYtg/hWTtR3I/Guw6OV2Ry6om29U3OyM9TyEqcR5M2CX7uEW8CYIh5Hdyq5x34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709147069; c=relaxed/simple;
	bh=Tt4tghtFS6vjGrQ4TxKi2XT7FT/6Ku6rhZMm4HtUGwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQbeFNrImQx/t6POzBcNRs06BrUoT737VVIeJvjLY9ZcvlUtRJi9rXGO6N8WsUPsX3UKPJ1JOSHSP+3MR57ZzzbktMkxN4QL73WeDFqFbqgF6IDNbktxHUEZJoxXxBeRgdFEAosuJ2RIKgDs82GZdnA19n3JXdkiFND6ec6SbmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/AGlZl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04C4C433C7;
	Wed, 28 Feb 2024 19:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709147069;
	bh=Tt4tghtFS6vjGrQ4TxKi2XT7FT/6Ku6rhZMm4HtUGwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s/AGlZl5JhRukE9TyV6i5vLNsWB75qwo68klK/5o55vhevIIcpAhbd6gvYQACI3SQ
	 Ms9PM6llnT1qwnGf4FMmKoIdDBPOzogJhxsDKslt+eQrLEVFHpJGtcHmRQMkPWWzU/
	 K6ZYZFsYYlNGTLDBSS/ClUP4Ow8t86SVQv24RtPJIzg79AfxUecWkrdDe04ZDgS7GY
	 cYK6po5VNXpu0aki5NuY7KELFTjwPBe+jswAE3XbVHEQ096cD55Aiv3HlRvvYoBise
	 SSQujK87gX+GuipuTpph135hRS2BvorSS260fan4w3+VSxptxxHBFE6HXG8s3kZA8V
	 MiZTyyL+bTXeQ==
Date: Wed, 28 Feb 2024 19:04:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: Re: [PATCH v3 3/8] KVM: selftests: Move setting a vCPU's entry point
 to a dedicated API
Message-ID: <501ac94d-11ab-4765-a25d-75013c021be6@sirena.org.uk>
References: <20240208204844.119326-1-thuth@redhat.com>
 <20240208204844.119326-4-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+gdo+b6it/tdjUCH"
Content-Disposition: inline
In-Reply-To: <20240208204844.119326-4-thuth@redhat.com>
X-Cookie: I'm having an emotional outburst!!


--+gdo+b6it/tdjUCH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 09:48:39PM +0100, Thomas Huth wrote:
> From: Sean Christopherson <seanjc@google.com>
>=20
> Extract the code to set a vCPU's entry point out of vm_arch_vcpu_add() and
> into a new API, vcpu_arch_set_entry_point().  Providing a separate API
> will allow creating a KVM selftests hardness that can handle tests that
> use different entry points for sub-tests, whereas *requiring* the entry
> point to be specified at vCPU creation makes it difficult to create a
> generic harness, e.g. the boilerplate setup/teardown can't easily create
> and destroy the VM and vCPUs.

With today's -next I'm seeing most of the KVM selftests failing on an
arm64 defconfig with:

# =3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D
#   include/kvm_util_base.h:677: !ret
#   pid=3D735 tid=3D735 errno=3D9 - Bad file descriptor
#      1	0x0000000000410937: vcpu_set_reg at kvm_util_base.h:677 (discrimin=
ator 4)
#      2	 (inlined by) vcpu_arch_set_entry_point at processor.c:370 (discri=
minator 4)
#      3	0x0000000000407bab: vm_vcpu_add at kvm_util_base.h:981
#      4	 (inlined by) __vm_create_with_vcpus at kvm_util.c:419
#      5	 (inlined by) __vm_create_shape_with_one_vcpu at kvm_util.c:432
#      6	0x000000000040187b: __vm_create_with_one_vcpu at kvm_util_base.h:8=
92
#      7	 (inlined by) vm_create_with_one_vcpu at kvm_util_base.h:899
#      8	 (inlined by) main at aarch32_id_regs.c:158
#      9	0x0000007fbcbe6dc3: ?? ??:0
#     10	0x0000007fbcbe6e97: ?? ??:0
#     11	0x0000000000401f2f: _start at ??:?
#   KVM_SET_ONE_REG failed, rc: -1 errno: 9 (Bad file descriptor)

and a bisect pointed to this commit which does look plausibly relevant.

Note that while this was bisected with plain arm64 defconfig and the KVM
selftests fragment was not enabled, but enabling the KVM fragment gave
the same result as would be expected based on the options enabled by the
fragment.  We're also seeing an alternative failure pattern where the
tests segfault when run in a different environment, I'm also tracking
that down but I suspect these are the same issue.

A full log from a sample failing run can be seen here.

   https://lava.sirena.org.uk/scheduler/job/645026#L1581

Bisect log:

git bisect start
# good: [75d8cf735082728a5dfb7e46926ee184851cc519] Merge branch 'for-linux-=
next-fixes' of git://anongit.freedesktop.org/drm/drm-misc
git bisect good 75d8cf735082728a5dfb7e46926ee184851cc519
# bad: [20af1ca418d2c0b11bc2a1fe8c0c88f67bcc2a7e] Add linux-next specific f=
iles for 20240228
git bisect bad 20af1ca418d2c0b11bc2a1fe8c0c88f67bcc2a7e
# good: [1322f1801e59dddce10591d602d246c1bf49990c] Merge branch 'main' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect good 1322f1801e59dddce10591d602d246c1bf49990c
# good: [f996a1cab1c3547a0bd2edf0daa7a71eddec9b58] Merge branch 'next' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
git bisect good f996a1cab1c3547a0bd2edf0daa7a71eddec9b58
# bad: [22e19d7b30a88dc9e7b315935f44fb2a6c6bf7bf] Merge branch 'next' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git
git bisect bad 22e19d7b30a88dc9e7b315935f44fb2a6c6bf7bf
# good: [f9ad77051d5d45000848e87650a382995adf7e50] Merge branch 'master' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
git bisect good f9ad77051d5d45000848e87650a382995adf7e50
# bad: [6e9a1d8a249374b0c8ff9472f30f160c98881519] Merge branch 'next' of ht=
tps://github.com/kvm-x86/linux.git
git bisect bad 6e9a1d8a249374b0c8ff9472f30f160c98881519
# bad: [f3ac6b5aec49c3f8ced623802ee9efa6484263eb] Merge branch 'xen'
git bisect bad f3ac6b5aec49c3f8ced623802ee9efa6484263eb
# good: [938ccbf4327f38cec365986136e349486ddbb005] Merge branch 'pmu'
git bisect good 938ccbf4327f38cec365986136e349486ddbb005
# bad: [f3750b0c7f6e48b0adfb9bd2419de4a3c604ca68] KVM: selftests: Add a bas=
ic SEV-ES smoke test
git bisect bad f3750b0c7f6e48b0adfb9bd2419de4a3c604ca68
# bad: [992178c7219caa0bcdaa5c0ce59615b12da21662] KVM: selftests: Add a mac=
ro to define a test with one vcpu
git bisect bad 992178c7219caa0bcdaa5c0ce59615b12da21662
# good: [71cd774ad2f98d4c78bc868e7e55397810be3540] KVM: s390: move s390-spe=
cific structs to uapi/asm/kvm.h
git bisect good 71cd774ad2f98d4c78bc868e7e55397810be3540
# good: [db7d6fbc10447090bab8691a907a7c383ec66f58] KVM: remove unnecessary =
#ifdef
git bisect good db7d6fbc10447090bab8691a907a7c383ec66f58
# good: [221d65449453846bbf6801d0ecf7dfdf4f413ad9] KVM: selftests: x86: syn=
c_regs_test: Get regs structure before modifying it
git bisect good 221d65449453846bbf6801d0ecf7dfdf4f413ad9
# bad: [8ef192609f14272b7bd6fc3a553ebe02d1133cd0] KVM: selftests: Move sett=
ing a vCPU's entry point to a dedicated API
git bisect bad 8ef192609f14272b7bd6fc3a553ebe02d1133cd0
# first bad commit: [8ef192609f14272b7bd6fc3a553ebe02d1133cd0] KVM: selftes=
ts: Move setting a vCPU's entry point to a dedicated API

--+gdo+b6it/tdjUCH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXfg7cACgkQJNaLcl1U
h9A+swf/W0Ger/NXYEpo1VxIufRs9krwNwW08zQqutjTuJ1kcl3YN3uekj9HIjFc
2PwYj/41lgr2nwwS95WyouUadiQBPm3KltH3YBaXmpMhOSVFSBa77tHqduKfWOYS
P+wKJB6nYfOq8+XZG7ouYvhWVCPXCJZVqd/NcDDMbN0jEd/XXr/6gsqrkbG6GIa8
AeDLgNNiPiiNsoOqhcQ9D3kuP/yjhGE+unRje8PMohiwCscbjME5UjrH21C62N6R
LLvKUviQHaEOWTDEyDrpD50n+KHf/gbLHXcwV4BQFvzgshNetzQYv8r7Ika+yuvt
9EvQ4s3r2gUdzJhYl11dHTRKpcrC7g==
=eXpm
-----END PGP SIGNATURE-----

--+gdo+b6it/tdjUCH--

