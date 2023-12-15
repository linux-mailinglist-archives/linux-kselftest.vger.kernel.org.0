Return-Path: <linux-kselftest+bounces-2012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0E88147B3
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 13:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCDFC1F22D17
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 12:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7669224B31;
	Fri, 15 Dec 2023 12:10:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EFD2D04D
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE6zO-0001Th-VU; Fri, 15 Dec 2023 13:08:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE6zK-00G18H-0I; Fri, 15 Dec 2023 13:08:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE6zJ-003Wy8-ML; Fri, 15 Dec 2023 13:08:17 +0100
Date: Fri, 15 Dec 2023 13:08:17 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: James Clark <james.clark@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
	suzuki.poulose@arm.com, will@kernel.org, mark.rutland@arm.com,
	anshuman.khandual@arm.com, namhyung@gmail.com,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Russell King <linux@armlinux.org.uk>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Zaid Al-Bassam <zalbassam@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v7 05/11] arm64: perf: Include threshold control fields
 in PMEVTYPER mask
Message-ID: <20231215120817.h2f3akgv72zhrtqo@pengutronix.de>
References: <20231211161331.1277825-1-james.clark@arm.com>
 <20231211161331.1277825-6-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ngsobzumwfjdiywd"
Content-Disposition: inline
In-Reply-To: <20231211161331.1277825-6-james.clark@arm.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kselftest@vger.kernel.org


--ngsobzumwfjdiywd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Dec 11, 2023 at 04:13:17PM +0000, James Clark wrote:
> FEAT_PMUv3_TH (Armv8.8) adds two new fields to PMEVTYPER, so include
> them in the mask. These aren't writable on 32 bit kernels as they are in
> the high part of the register, so only include them for arm64.
>=20
> It would be difficult to do this statically in the asm header files for
> each platform without resulting in circular includes or #ifdefs inline
> in the code. For that reason the ARMV8_PMU_EVTYPE_MASK definition has
> been removed and the mask is constructed programmatically.
>=20
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: James Clark <james.clark@arm.com>

This change is in today's next as commit
3115ee021bfb04efde2e96507bfcc1330261a6a1. this breaks allmodconfig
building on ARCH=3Darm:

	In file included from include/linux/ratelimit_types.h:5,
			 from include/linux/printk.h:9,
			 from include/asm-generic/bug.h:22,
			 from arch/arm/include/asm/bug.h:60,
			 from include/linux/bug.h:5,
			 from include/linux/mmdebug.h:5,
			 from include/linux/percpu.h:5,
			 from include/asm-generic/irq_regs.h:11,
			 from ./arch/arm/include/generated/asm/irq_regs.h:1,
			 from drivers/perf/arm_pmuv3.c:11:
	drivers/perf/arm_pmuv3.c: In function =E2=80=98armv8pmu_write_evtype=E2=80=
=99:
	include/linux/bits.h:34:29: error: left shift count >=3D width of type [-W=
error=3Dshift-count-overflow]
	   34 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
	      |                             ^~
	include/linux/bits.h:37:38: note: in expansion of macro =E2=80=98__GENMASK=
=E2=80=99
	   37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
	      |                                      ^~~~~~~~~
	include/linux/perf/arm_pmuv3.h:238:33: note: in expansion of macro =E2=80=
=98GENMASK=E2=80=99
	  238 | #define ARMV8_PMU_EVTYPE_TC     GENMASK(63, 61)
	      |                                 ^~~~~~~
	drivers/perf/arm_pmuv3.c:567:25: note: in expansion of macro =E2=80=98ARMV=
8_PMU_EVTYPE_TC=E2=80=99
	  567 |                 mask |=3D ARMV8_PMU_EVTYPE_TC | ARMV8_PMU_EVTYPE_T=
H;
	      |                         ^~~~~~~~~~~~~~~~~~~
	include/linux/bits.h:35:18: error: right shift count is negative [-Werror=
=3Dshift-count-negative]
	   35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
	      |                  ^~
	include/linux/bits.h:37:38: note: in expansion of macro =E2=80=98__GENMASK=
=E2=80=99
	   37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
	      |                                      ^~~~~~~~~
	include/linux/perf/arm_pmuv3.h:238:33: note: in expansion of macro =E2=80=
=98GENMASK=E2=80=99
	  238 | #define ARMV8_PMU_EVTYPE_TC     GENMASK(63, 61)
	      |                                 ^~~~~~~
	drivers/perf/arm_pmuv3.c:567:25: note: in expansion of macro =E2=80=98ARMV=
8_PMU_EVTYPE_TC=E2=80=99
	  567 |                 mask |=3D ARMV8_PMU_EVTYPE_TC | ARMV8_PMU_EVTYPE_T=
H;
	      |                         ^~~~~~~~~~~~~~~~~~~
	include/linux/bits.h:34:29: error: left shift count >=3D width of type [-W=
error=3Dshift-count-overflow]
	   34 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
	      |                             ^~
	include/linux/bits.h:37:38: note: in expansion of macro =E2=80=98__GENMASK=
=E2=80=99
	   37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
	      |                                      ^~~~~~~~~
	include/linux/perf/arm_pmuv3.h:237:33: note: in expansion of macro =E2=80=
=98GENMASK=E2=80=99
	  237 | #define ARMV8_PMU_EVTYPE_TH     GENMASK(43, 32)
	      |                                 ^~~~~~~
	drivers/perf/arm_pmuv3.c:567:47: note: in expansion of macro =E2=80=98ARMV=
8_PMU_EVTYPE_TH=E2=80=99
	  567 |                 mask |=3D ARMV8_PMU_EVTYPE_TC | ARMV8_PMU_EVTYPE_T=
H;
	      |                                               ^~~~~~~~~~~~~~~~~~~
	include/linux/bits.h:35:18: error: right shift count is negative [-Werror=
=3Dshift-count-negative]
	   35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
	      |                  ^~
	include/linux/bits.h:37:38: note: in expansion of macro =E2=80=98__GENMASK=
=E2=80=99
	   37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
	      |                                      ^~~~~~~~~
	include/linux/perf/arm_pmuv3.h:237:33: note: in expansion of macro =E2=80=
=98GENMASK=E2=80=99
	  237 | #define ARMV8_PMU_EVTYPE_TH     GENMASK(43, 32)
	      |                                 ^~~~~~~
	drivers/perf/arm_pmuv3.c:567:47: note: in expansion of macro =E2=80=98ARMV=
8_PMU_EVTYPE_TH=E2=80=99
	  567 |                 mask |=3D ARMV8_PMU_EVTYPE_TC | ARMV8_PMU_EVTYPE_T=
H;
	      |                                               ^~~~~~~~~~~~~~~~~~~

I guess that's easy to fix but I didn't look into that.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ngsobzumwfjdiywd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV8QbAACgkQj4D7WH0S
/k7AiQf+P2oUWv7SoB0VqSdzaQDZiVP5cLTAQNAUd2/KvKLHcynNocmMBs36c3pg
o+x8tw5H8hmrOREyHLMq2dFVFQOzDjUpzVl/UtvewEwJ/wer59fr31E2+O4d3RzB
HbLD/OuVTL88TWye1hyv+43iSoG4gfff9n9SBsr/423tBmEqnCkIv/A7CMzawZMi
Nr4oV5P03hNhNXEFy4OxIVfuLmAVxIlK4EtUtMErE/+UHeJL6gs+nhOW38UwNR+c
+9uau7zzuYGeBWLmiDYGPteZWs0/DB9/WO5xm+U4eA10oQSho6Tjd8DS4ls2katc
cDqpu8z3U3vqJXktpE5/swkSxSAuWQ==
=wXB9
-----END PGP SIGNATURE-----

--ngsobzumwfjdiywd--

