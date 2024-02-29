Return-Path: <linux-kselftest+bounces-5637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AB186C9DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 14:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381F91C20D58
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 13:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE46F7E10E;
	Thu, 29 Feb 2024 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzyuMOsF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835717E108;
	Thu, 29 Feb 2024 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709212326; cv=none; b=oZAduC8aWOUpNIg0XOugUP5lZID5AyzsRjDZtRYd2hzEN98K7TkkJSRlwpSLXn512f8oB7V4iSxwcvu2RV4SGwdv+Fqz9mfnctG192qbhfRGmX1Zd+zjniCXMZcIdh04qJ8l70ajA55xtTI70+KnrE3anZXEgUGKLMqXOyN9yHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709212326; c=relaxed/simple;
	bh=S2JXTl32YEuY1PDCJSwXgJ30YBV0RjOa23Q9t+6tBIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyDV1Vrfz/Fbk2f06M4BnfnaFlwS0Z2NZzy8dbEsQFOwswpMbuZYOJtF1X/vh1twFa75LEZEjgidqcc/s7G74HdZm2QZdFj9D7wmVpY6gvyHDae3WpTjVT/fmuemwFQW5iwRDUJV5JG4ieVLM8X0LdOAMRxEGKFpZla21snWB3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzyuMOsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AFAC433C7;
	Thu, 29 Feb 2024 13:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709212326;
	bh=S2JXTl32YEuY1PDCJSwXgJ30YBV0RjOa23Q9t+6tBIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MzyuMOsFQo69++Xy8sFsWI3XRB2G3WY2jrazH4uGPmS/QzihYQrHiasSVa368Ykfn
	 BswLd97BnvxWkgvjmE9hcFE+IfqaljRrms0g5oLg3EXZkaYA4mE1APc6TssCT7EKoh
	 14RMiEkBG+XvCiRFbHVnluuYknAO3q8hGJxTI48X6vEBFOt7C6JzSV8Q5X9Ye69s4y
	 2KC43y5z/j4XBeBsq5hE5KHzOijVfc26JZP5LYLZdIbcby20pHmXGPyTUAqWfzbtez
	 BAmgaWD5hi5ERHojhek7hhUan/PcLMHgYgF8CNQgLaiOTt0d55QScv8aFNgSY8mLS9
	 6i+MmAxq+ZhLw==
Date: Thu, 29 Feb 2024 13:12:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: Re: [PATCH v3 3/8] KVM: selftests: Move setting a vCPU's entry point
 to a dedicated API
Message-ID: <9de8ab51-48ef-4377-8ae1-d84bc8488747@sirena.org.uk>
References: <20240208204844.119326-1-thuth@redhat.com>
 <20240208204844.119326-4-thuth@redhat.com>
 <501ac94d-11ab-4765-a25d-75013c021be6@sirena.org.uk>
 <Zd-JjBNCpFG5iDul@google.com>
 <Zd-jdAtI_C_d_fp4@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RZvqkvqzp8xe3gFv"
Content-Disposition: inline
In-Reply-To: <Zd-jdAtI_C_d_fp4@google.com>
X-Cookie: Marriage is the sole cause of divorce.


--RZvqkvqzp8xe3gFv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 01:19:48PM -0800, Sean Christopherson wrote:

> @@ -386,6 +386,7 @@ static struct kvm_vcpu *__aarch64_vcpu_add(struct kvm=
_vm *vm, uint32_t vcpu_id,
>         aarch64_vcpu_setup(vcpu, init);
> =20
>         vcpu_set_reg(vcpu, ARM64_CORE_REG(sp_el1), stack_vaddr + stack_si=
ze);
> +       return vcpu;
>  }
> =20
>  struct kvm_vcpu *aarch64_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
>=20
> I'll squash the above and force push.

Confirmed that this fixes the originally reported issue.

--RZvqkvqzp8xe3gFv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXggp8ACgkQJNaLcl1U
h9C6zgf+P8pQLInGOUy0s8LJ/t462LYP5YG9G9fwpErOQMfHbQdbXOvmV6uDSX+y
VTfC3vSh/DclihVoYk2JOzP9HrirYQ6VLiUaEkZ/Yg7+9tADpmkxwrVjjSZcVm65
s7YxCSK8oafLNboCJ62Do6ucUCtXioaDUQTg6DswlCAkBoEWUaywNiwHjJoej/ai
M0zRRq8dGYicuWDJamB7UB7ahlhsd5H9fBHbaCqtzNxt9eFaF0ScKOSS/bFXmxwP
aDQAtqoVnkg+sn7i3wEAHsg5+TplThn03AJ30L+AeuBZrIQBhsujGWi0K2uUSpVL
FzsvwIMz0GkRoBJBxF1KNcxxQZ746A==
=Vvkt
-----END PGP SIGNATURE-----

--RZvqkvqzp8xe3gFv--

