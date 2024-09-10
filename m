Return-Path: <linux-kselftest+bounces-17570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C0B97292D
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 08:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD22287237
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 06:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D9F175D36;
	Tue, 10 Sep 2024 06:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G78PQbOR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AFB1CD1F;
	Tue, 10 Sep 2024 06:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725948010; cv=none; b=cgqUiqAMKGMpci3Qo1DW60b1gHx4dKNnmGnQNYptBdLeAq1YIfJ3AapkjOY55pB2wr+7m7ay8Zjtf3kWQh7q7SoV7fFzuWFVv+AO2aA5N5ekzHbL8LW1YF2eHpoxkTJgRWUIwH95GSUcJz3yg8m/aoh/WcF4cHlIVt4vWlEHr7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725948010; c=relaxed/simple;
	bh=YKlFgKmNBL+UvTbDp6vo7VzFbHN0vj4I0Lmh1OIQjck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ss0VyhTAj6d4UX58Nh7bjBV+5Uaxf4bNmSdKsaTFhZqLVWof3SROF6xYOBXuAZwrCiDftDlCgTmaMFc+21ULsREzus3bMWvpdPKbLP1MQKNa6GQyzLgAiBLn886a/TMnF4O1m0F0mJjaphXm+qCwMR/vaqr6+sn8B4uVcBLhYPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G78PQbOR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725948009; x=1757484009;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=YKlFgKmNBL+UvTbDp6vo7VzFbHN0vj4I0Lmh1OIQjck=;
  b=G78PQbORDUnXdqNj8nbJ/yWasNjBizLa2DTQAEnSLut1ooOsGDHCd/Ij
   5BSGhbEM8tdck2SciqeOkBvfpVtD8elKA3DOMxKimbuwq+cYLqoFcH6VE
   MQQKOaMjcW2kCEwqqnKEJik5G6eYiGiK6PAF55b2z8mS1oXVjo8VuO97R
   8XjmGKvKNvN6AyQpbzj4Fc64APIF9T8UxNcYxGfsqo/DGuY5WRy87JblO
   jRcfMncBHpC2AVoQj7K0menMUUdHX7/Jl7WWbSxo9t8TgvMBY6Kxb+W9r
   4IYLP8PQFQBieXjgVcF/3tRv3tH0pstFeniS7rJzIRz+OW7YX9DCIF2QK
   g==;
X-CSE-ConnectionGUID: Gx3ScJpIQG2vZeABnWn+Uw==
X-CSE-MsgGUID: NoJc+xReS1+Btu8DqZOnng==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24553392"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="asc'?scan'208";a="24553392"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 23:00:08 -0700
X-CSE-ConnectionGUID: cVZNg4DfS0CKoDo3SzGu4w==
X-CSE-MsgGUID: P+pOe+qSRKqfhQlgP2iybA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="asc'?scan'208";a="66967552"
Received: from debian-skl.sh.intel.com (HELO debian-skl) ([10.239.160.45])
  by fmviesa008.fm.intel.com with ESMTP; 09 Sep 2024 23:00:03 -0700
Date: Tue, 10 Sep 2024 14:02:28 +0800
From: Zhenyu Wang <zhenyuw@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Zhenyu Wang <zhenyuw@linux.intel.com>, kvm@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	H Peter Anvin <hpa@zytor.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH 0/3] KVM: x86: Fix Intel PT Host/Guest mode when host
 tracing also
Message-ID: <Zt/g9Cpix06Ccg4z@debian-scheme>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20240906130026.10705-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l5QniXQFWRwHsHV7"
Content-Disposition: inline
In-Reply-To: <20240906130026.10705-1-adrian.hunter@intel.com>


--l5QniXQFWRwHsHV7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Add Mingwei.

On 2024.09.06 16:00:23 +0300, Adrian Hunter wrote:
> Hi
>=20
> There is a long-standing problem whereby running Intel PT on host and gue=
st
> in Host/Guest mode, causes VM-Entry failure.
>=20
> The motivation for this patch set is to provide a fix for stable kernels
> prior to the advent of the "Mediated Passthrough vPMU" patch set:
>=20
> 	https://lore.kernel.org/kvm/20240801045907.4010984-1-mizhang@google.com/
>=20
> which would render a large part of the fix unnecessary but likely not be
> suitable for backport to stable due to its size and complexity.
>=20
> Ideally, this patch set would be applied before "Mediated Passthrough vPM=
U"
>=20
> Note that the fix does not conflict with "Mediated Passthrough vPMU", it
> is just that "Mediated Passthrough vPMU" will make the code to stop and
> restart Intel PT unnecessary.
>

With mediated passthrough vPMU, we could enable PT pmu's PERF_PMU_CAP_PASST=
HROUGH_VPMU
capability like core pmu, then perf guest helper could handle any host PT e=
vents
during VM entry/exit as well like core perf events. The benefit is general =
perf interface
to handle like others. But it would be sure to depend on passthrough vPMU b=
e enabled,
not as this to fix in case w/o that.

I have local patches to work against passthrough vPMU, but like passthrough=
 vPMU
to be settled down first. With Adrian's change, it could be also possible t=
o decouple
the dependency, so may support in both cases with or w/o passthrough vPMU e=
nabled.=20

>=20
> Adrian Hunter (3):
>       KVM: x86: Fix Intel PT IA32_RTIT_CTL MSR validation
>       KVM: x86: Fix Intel PT Host/Guest mode when host tracing also
>       KVM: selftests: Add guest Intel PT test
>=20
>  arch/x86/events/intel/pt.c                         | 131 ++++++-
>  arch/x86/events/intel/pt.h                         |  10 +
>  arch/x86/include/asm/intel_pt.h                    |   4 +
>  arch/x86/kvm/vmx/vmx.c                             |  26 +-
>  arch/x86/kvm/vmx/vmx.h                             |   1 -
>  tools/testing/selftests/kvm/Makefile               |   1 +
>  .../selftests/kvm/include/x86_64/processor.h       |   1 +
>  tools/testing/selftests/kvm/x86_64/intel_pt.c      | 381 +++++++++++++++=
++++++
>  8 files changed, 532 insertions(+), 23 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/intel_pt.c
>=20
> base-commit: d45aab436cf06544abeeffc607110f559a3af3b4
>=20
>=20
> Regards
> Adrian
>=20

--l5QniXQFWRwHsHV7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCZt/g7wAKCRCxBBozTXgY
J4FmAJ4l1Cil0SD6XxGOygTov/Nm/zTkBQCcDgsjqp1rTxgyohF44JMESE88C7o=
=/KK1
-----END PGP SIGNATURE-----

--l5QniXQFWRwHsHV7--

