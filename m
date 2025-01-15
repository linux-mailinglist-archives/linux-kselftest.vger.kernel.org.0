Return-Path: <linux-kselftest+bounces-24603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44107A12E34
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 23:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EEF53A6CD6
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 22:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE9E1DA61B;
	Wed, 15 Jan 2025 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lm3aQrWc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287661D5AB6;
	Wed, 15 Jan 2025 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736979598; cv=none; b=HWWKcAH72Cy0muDnNcHbi/GyOwq46PkJJFrZzzpOgbHHRNb/sc7I9phxSmaJUDicGJIsE/acrrnXtUzgKCOQt8bSmfZBdqj0/CrEXIOTMGwatzzX/3/3k8MT3XMdJv1xQr73ARnt+JLe+MDdEqqp0IvwDiwGTXJoRNW52Jf+9Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736979598; c=relaxed/simple;
	bh=Z0/lKRWxQRmkWifMhE/m6sk0SdJJRG2NBLDwlK349i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2JJlpIQmlk9hz9HtLEjUz9LpiMOHmeImwwn1PhZLiQtwggDOcMS4r51CqLzKHiAmsZ0rNBg/CHQGasEbXRSUJAvOxnZK5zM4ImZF71PLDG/F1qnTlDk4ptdMraQAy75euqN1zHJ5H1djAFmFDKXDUhlkOtSS8JWDz1vgkawsLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lm3aQrWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F47C4CED1;
	Wed, 15 Jan 2025 22:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736979597;
	bh=Z0/lKRWxQRmkWifMhE/m6sk0SdJJRG2NBLDwlK349i0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lm3aQrWcYT0VmD37y5BrFUEGqHCSgjmq3xuku2dDdrFDHSbTg6sJJJD3rGGUdcytC
	 q8Q9MRs7jQOSqxZq64I1+RijiZOMfSEpoBWmF1eaFGixyqF2u+pQfwSnUSC+AdFA/g
	 ioZD0bX8N6i70Q2N5ng/6g09sG8+hCDNJr6H41ViJmEE+PoFGhUBjoUE6cXUXvHr62
	 naEwhlBBW/hyYM+Ri6MTdeZx9NkQknTXDeoymAxpH9wWXclq8TZFwr/BRgcHnKaTgl
	 IpoWROBh4TDsAm8uJ73oJdNjAi4BKyTUEu1opMa8F9R7eSR/RiJSMjErrudUFSa2Fm
	 N5nMybGuOVFMg==
Date: Wed, 15 Jan 2025 22:19:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel@collabora.com, Aishwarya.TCV@arm.com
Subject: Re: [PATCH 05/16] selftests/mm: kselftest_harness: Fix warnings
Message-ID: <d9c290e2-f22d-41be-aa68-2aebd3eb1a67@sirena.org.uk>
References: <20250109173842.1142376-1-usama.anjum@collabora.com>
 <20250109173842.1142376-6-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ieY0mxb/Z4dE11Uk"
Content-Disposition: inline
In-Reply-To: <20250109173842.1142376-6-usama.anjum@collabora.com>
X-Cookie: Can I have an IMPULSE ITEM instead?


--ieY0mxb/Z4dE11Uk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2025 at 10:38:31PM +0500, Muhammad Usama Anjum wrote:
> Found warnings through hmm-tests and mdwe_test.

> Fix following warnings:
> - Mark unused variable with unused attribute
> - __EXPECT is causing types mismatch warnings when __exp is unsigned and
>   _seen is equal to a constant number, __typeof__(_seen) returns signed
>   type.

This patch, which is in -next as a07b5ab38aad, breaks the arm64 pac
test pac_instructions_not_nop_generic:

   https://lava.sirena.org.uk/scheduler/job/1065981#L2147

(in spite of the subject line it affects all users of the kselftest
harness, not just the mm tests).

> @@ -756,7 +756,7 @@
>  	/* Avoid multiple evaluation of the cases */ \
>  	__typeof__(_expected) __exp =3D (_expected); \
>  	__typeof__(_seen) __seen =3D (_seen); \
> -	if (!(__exp _t __seen)) { \
> +	if (!(__exp _t (__typeof__(_expected)) __seen)) { \
>  		/* Report with actual signedness to avoid weird output. */ \
>  		switch (is_signed_type(__exp) * 2 + is_signed_type(__seen)) { \
>  		case 0: { \

I *believe* it's this change, which seems a bit suspicous but I didn't
nail down the exact failure mode (the failing test compares a constant 0
to a size_t).  It's not clear to me why a cast is appropriate here, the
warning I think this was supposed to address was:

  hmm-tests.c: In function =E2=80=98hmm_anon_read=E2=80=99:
  ../kselftest_harness.h:523:52: warning: comparison of integer expressions=
 of
 different signedness: =E2=80=98long unsigned int=E2=80=99 and =E2=80=98int=
=E2=80=99 [-Wsign-compare]

=2E..

  hmm-tests.c:303:9: note: in expansion of macro =E2=80=98ASSERT_NE=E2=80=99
    303 |         ASSERT_NE(npages, 0);

which is a similar comparison of 0 with a signed value but with the
position of the constant reversed.  It's not clear to me that the
warning isn't legitimate, or that a cast blindly done on one argument is
the appropriate way to address it.  AFAICT the issue comes because of
the dance the macro does to copy the arguments into a variable to avoid
multiple evaluations, which defeats the magic C has for assigning a type
to bare constants.  I think either the macro needs to be more clever
(and legibility challenged) or we should do any casting of constants
that's needed to shut warnings up in callers.

In any case, failing tests seem obviously worse than a build warning.

Bisect log, there's huge numbers of good commits at the start since my
automation feeds in the results of any test results it already has for
commits in the bisected range in order to avoid duplicate work:

# bad: [e7bb221a638962d487231ac45a6699fb9bb8f9fa] Add linux-next specific f=
iles for 20250115
# good: [7b90deb712bbacdf8aa1fc01bf155cab5c21d98a] Merge branch 'for-linux-=
next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
# good: [6b077230a1e163f01c866923915def6f73f9c390] ASoC: fsl: Support micfi=
l on i.MX943
# good: [e896c04890aeff2292364c19632fc15d890d436c] spi: amd: Fix -Wuninitia=
lized in amd_spi_exec_mem_op()
# good: [41f1d2bd4998829341cdada022ede610068a0f33] ASoC: soc-dapm: remove !=
card check from snd_soc_dapm_set_bias_level()
# good: [40ba3c9019ccd34d576fa14f94ef4f3bd9284c1a] spi: ti-qspi: Use syscon=
_regmap_lookup_by_phandle_args
# good: [eab69050450ba63a4edb17d3d1a8654d2a130786] ASoC: fsl_micfil: Add i.=
MX943 platform support
# good: [3927c51e49c1a45785334dc578f0b29c685619ec] ASoC: dt-bindings: fsl,m=
icfil: Add compatible string for i.MX943 platform
# good: [9a8afbe5677234ac2490438d6b8ab74ee7fb359e] spi-nand/spi-mem DTR sup=
port
# good: [65880d32e1d7eb1ef03253c454fcd8f9d41aaa09] ASoC: sun4i-codec: Use n=
ew devm clk and reset APIs
# good: [292284f2be46514ed07e7b3e3350329f656c4f62] ASoC: fsl: Support MQS o=
n i.MX943
# good: [9d499259db0cc5a31e212570c2cf945ad117b900] ASoC: extra format on ea=
ch DAI
# good: [8eb27b5758e6fb6d1881413e3f1159c579ac48b3] ASoC: codecs: Use ARRAY_=
SIZE() to calculate PEB2466_TLV_SIZE
# good: [7299cc06fe4ab2ac26af73ac5fecd35a28fef527] ASoC: SOF: Intel: Use st=
r_yes_no() to improve bdw_dump()
# good: [5f281c3e82b1203c40cf6ead009ffb5b09db056b] ASoC: audio-graph-card2:=
 use __free(device_node) for device node
# good: [c8903242bcb119660232c9cbf336fea3737d1a60] ASoC: soc-core: return 0=
 if np was NULL on snd_soc_daifmt_parse_clock_provider_raw()
# good: [85dc053c87bcc32afd8e5cbf20a649dc24e93d24] ASoC: audio-graph-card2:=
 use of_graph_get_port_by_id() at graph_get_next_multi_ep()
# good: [365865b7d7467aea9767ea18670198921bcada7c] ASoC: audio-graph-card2:=
 Use extra format on each DAI
# good: [c8a1dccf449eb71b23b6c04ff6b40db568d7cf92] ASoC: audio-graph-card: =
use __free(device_node) for device node
# good: [24410f499e808884cc91239dc16013e5bee8779a] ASoC: soc-core: Enable t=
o use extra format on each DAI
# good: [2518a0e1b878042f9afa45ae063e544a16efc1a3] ASoC: simple-card: use _=
_free(device_node) for device node
# good: [6f490e6b2c34792e363685bacb48a759e7e40cd1] ASoC: fsl_mqs: Add i.MX9=
43 platform support
# good: [a1a771e5f1e31e4764d9a225c02e93969d3f5389] ASoC: dt-bindings: fsl,m=
qs: Add compatible string for i.MX943 platform
# good: [e8d06511ee70175a58be450a098ab1ce37fe9ecb] Merge branch kvm-arm64/c=
oresight-6.14 into kvmarm-master/next
# good: [4e26de25d2b617e12bba98e11393fdf7c27885f9] Merge remote-tracking br=
anch 'arm64/for-next/cpufeature' into kvm-arm64/pkvm-fixed-features-6.14
# good: [6f91d31d47c57953da68e1a91240ae2543b00172] KVM: arm64: Drop pkvm_me=
m_transition for host/hyp donations
# good: [38138762faffeb923d9f49efbcc09884f1530786] tools: arm64: Update sys=
reg.h header files
# good: [d0670128d42fa170bf8ba878cd23504c5c5cccc7] Merge branch kvm-arm64/p=
kvm-np-guest into kvmarm-master/next
# good: [e880b16efb78f9c7449239a76814aeb015daf2a1] Merge branch kvm-arm64/p=
kvm-fixed-features-6.14 into kvmarm-master/next
# good: [8fd113c6ba2490e4ce38447a596ab448eeb1a1f4] Merge branch kvm-arm64/m=
isc-6.14 into kvmarm-master/next
# good: [17b99c04d9b48465d45b0913fa78a6859b0b24c5] Merge branch kvm-arm64/p=
kvm-memshare-declutter into kvmarm-master/next
# good: [a2b579c41fe9c295804abd167751f9fdc73c7006] coresight: trbe: Remove =
redundant disable call
# good: [c382ee674c8b5005798606267d660cf995218b18] arm64/sysreg/tools: Move=
 TRFCR definitions to sysreg
# good: [226d6cb3cb799aae46d0dd19a521133997d9db11] spi: spi-mem: Estimate t=
he time taken by operations
# good: [fd85b6b7bc53409d0be82763419bdcdaa48f2c91] spi: Add spi_mem_calc_op=
_duration() helper
# good: [89b37e49929653b7c350aac7fb2b96a052533015] spi-nand/spi-mem DTR sup=
port
# good: [abea0cbfba5848d11b6364e82df4864fd0bfa683] ASoC: simple-card: Drop =
unnecessary "dai-tdm-slot-width-map" property presence check
# good: [2438db5253eb17a7c0ccb15aea4252a150dda057] spi: fsl-qspi: Support p=
er spi-mem operation frequency switches
# good: [26851cf65ffca2d3a8d529a125e54cf0084d69e7] spi: nxp-fspi: Support p=
er spi-mem operation frequency switches
# good: [d3f35dd3ad968256ed1080e3ea2022f947861cff] spi: rockchip-sfc: Suppo=
rt per spi-mem operation frequency switches
# good: [67707cb094f134f5b3931eefbedbb9ca7e3209d0] spi: mxic: Support per s=
pi-mem operation frequency switches
# good: [d1f85873d2d62d6980e68d21d3a21f20b0664cc3] spi: spi-mem: Reorder sp=
i-mem macro assignments
# good: [13529647743d906ed3cf991f1d77727e7ff1fb6f] spi: microchip-core-qspi=
: Support per spi-mem operation frequency switches
# good: [5baa189789e8894c58eacc7803e3c163c1d0fc0a] spi: amlogic-spifc-a1: S=
upport per spi-mem operation frequency switches
# good: [b2fac3192919dd07e7ce30558e34abd7e07dde77] spi: spi-ti-qspi: Suppor=
t per spi-mem operation frequency switches
# good: [1248c9b8d54120950fda10fbeb98fb8932b4d45c] spi: spi-mem: Add a new =
controller capability
# good: [eee7bc9e7ade6f7ac17d9ec02887cd5509ba9427] spi: dw: Support per spi=
-mem operation frequency switches
# good: [13fd04b53053bbfa741a0f2a781837ab80e485f6] spi: mt65xx: Support per=
 spi-mem operation frequency switches
# good: [1a206344218cc15ad8f321e3abab3f3d36ab639f] spi: spi-sn-f-ospi: Supp=
ort per spi-mem operation frequency switches
# good: [e6204f39fe3a7b4538815a2d778b601bd543649e] spi: amd: Drop redundant=
 check
# good: [0fefeade90e74bc8f40ab0e460f483565c492e28] spi: spi-mem: Extend spi=
-mem operations with a per-operation maximum frequency
# good: [d0e5faccb229b1dacc4c9fa11f6df33bb1fdabd8] spi: amd: Support per sp=
i-mem operation frequency switches
# good: [30eb2e6e78225f92f04a2325c6fd77fe8f5b4aab] spi: zynqmp-gqspi: Suppo=
rt per spi-mem operation frequency switches
# good: [84eac6d478c00f8f9101f91716ea3866d2fc1e54] ASoC: Use of_property_pr=
esent() for non-boolean properties
# good: [9a68f6c8d6cfddeac7c5874528ed04e50a1cb579] spi: zynq-qspi: Support =
per spi-mem operation frequency switches
# good: [06e9f5a1f6ba774d8942a168d3ec5ed5a008fbcb] spi: cadence-qspi: Suppo=
rt per spi-mem operation frequency switches
# good: [f0006897a96c736623ddeb9b68c3880eb5cdebe7] spi: spi-mem: Create mac=
ros for DTR operation
# good: [61aff2da3e63a43f22e60aa1bc57026ce07d189e] ASoC: intel: remove disa=
ble_route_checks
# good: [dd2395162c07e4102fc83878dc394ff63f2eaae8] ASoC: remove disable_rou=
te_checks
# good: [fd688ce125a4ff5cc2b6be1184dc17c9f342db37] ASoC: Intel: avs: Fixes =
and cleanups
# good: [7e24ec93aecd12e33d31e38e5af4625553bbc727] ASoC: amd: Add ACPI depe=
ndency to fix build error
# good: [9c0e29b9957e407af6197ff1fb48f365a9b0c248] ASoC: remove disable_rou=
te_checks
# good: [c3ad22ad34f81a8906dba02ea8cc9756d2ce7b50] regulator: core: Resolve=
 supply using of_node from regulator_config
# good: [cf4d74256fe103ece7b2647550e6c063048e5682] ASoC: Intel: avs: Fix th=
eoretical infinite loop
# good: [e9ca3db9f01a7ce91ceab35cd5fa52f0c5aca174] ASoC: Intel: avs: Fix in=
it-config parsing
# good: [33228036ff655ebed1bc4bde9c9b6329b569b27b] ASoC: Intel: avs: Print =
IPC error messages in lower layer
# good: [e3146775f05d18c667a2e26082da3ac105f87d9f] ASoC: Intel: avs: Update=
 hda component teardown sequences
# good: [bca0fa5f6b5e96c03daac1ed62b1e5c5057a2048] ASoC: Intel: avs: Do not=
 readq() u32 registers
# good: [5e56618e1593a9eb9d72dc9433ac7a02a6c48c8f] spi: atmel-quadspi: Upda=
te to current device naming terminology
# good: [5640fd07b90ed43225704fecfbbda9d402dba1cf] spi: Merge up v6.13-rc6
# good: [636ee5781d259258dc9425a5552be1ffa458633c] spi: fsl-spi: Remove dis=
play of virtual address
# good: [dbda5c35b88794f6e5efe1b5b20044b0b3a340d4] ASoC: Intel: avs: Fix th=
e minimum firmware version numbers
# good: [aea305d28551bc213aab3a41a0f59412247ae2b4] ASoC: Intel: avs: Update=
 ASRC definition
# good: [3eede0fc99c684df6f3f35866761036dabf89d05] ASoC: Intel: avs: Adjust=
 DSP status register names
# good: [94aa347d34e079859a5378272c9452c728e4183a] ASoC: Intel: avs: Add MO=
DULE_FIRMWARE to inform about FW
# good: [480d9bb9cfb7b774b22cf82ff21903eb50d64cb9] ASoC: Intel: avs: Improv=
e logging of firmware loading
# good: [0ca529926c5d9d0a3c0b1609fb7034ab870e4770] ASoC: Intel: avs: Clearl=
y state assumptions of hw_params()
# good: [0b12850ddfb0032376ef1be10b5b46be00bba4d4] ASoC: Intel: avs: Add mi=
ssing includes
# good: [ef724707788325a53ffa4cf58fceb94654e4793a] ASoC: Intel: avs: Adjust=
 IPC traces
# good: [3566784817aeb1a733c95953998a29adc386d2ff] drm/i915/display: Update=
 DBUF_TRACKER_STATE_SERVICE only on appropriate platforms
# good: [9c3d68ce5dee76f30b23ca29b2be4774e291f7f1] ASoC: soc-card: remove c=
ard check
# good: [82a0a3e6f8c02b3236b55e784a083fa4ee07c321] ASoC: renesas: rz-ssi: A=
dd a check for negative sample_space
# good: [309caeef4381e8777f65030dccabc71456650269] ASoC: Merge up v6.13-rc6
# good: [d406b354df909155ff0122acf80f3bc7410fa27e] Expand SoundWire MBQ reg=
ister map support
# good: [5bc493bf0c37c157bf2eb364e55a1c6f8bc43a69] regmap: sdw-mbq: Add sup=
port for SDCA deferred controls
# good: [fdd9ef3dce98e035d21c17fac587cb6e3c7706fd] regmap: sdw-mbq: Add sup=
port for further MBQ register sizes
# good: [8227c7510b56460e9ecf1acf4e5150da7070ab6c] Minor debugging improvem=
ents
# good: [b21468e83b787ab31aa9df8f429d2ca61def0cc9] ASoC: SDCA: Update list =
of entity_0 controls
# good: [5d085b25ae9843b4865360986ab288332bb01e21] ASoC: rt5682: Support th=
e ALC5682I-VE codec
# good: [c51187903fe4523fd7f521662c1ae1f1f3174036] ASoC: codecs: Add aw8808=
3 amplifier driver
# good: [7b16e60b31202254c62a29f5c709ffb42684b6f9] soundwire: SDCA: Add add=
itional SDCA address macros
# good: [a83678be5ea152dca98791956f7bf2a0e899e3ad] ASoC: madera: Use str_en=
abled_disabled() helper function
# good: [fffe003fc209a3c1f3d07be7e860fed4e51c4c00] ASoC: dt-bindings: Corre=
ct indentation and style in DTS example
# good: [be947cc0cbbb0985d60a77aed709460a46eb3d0b] ASoC: codecs: Add aw8808=
3 amplifier driver
# good: [f1a92bb81a6cf9ae9a50d175be8b396bfabcb487] ASoC: simple_card: Show =
if link is unidirectional
# good: [8c588fe965d95fd2d18e1a1d55489b9237eeddfe] ASoC: simple_card: Impro=
ve debugging messages
# good: [af103eb7d7d881cf6ff7414242bce2d8e394cc32] spi: rockchip-sfc: Suppo=
rt sclk_x2 version
# good: [dddca3b2fc676113c58b04aaefe84bfb958ac83e] regulator: of: Implement=
 the unwind path of of_regulator_match()
# good: [1e293574c6f5d5d87acd7d64415eae055d0672e7] spi: cadence-quadspi: En=
able SPI_TX_QUAD
# good: [be92ab2de0ee1a13291c3b47b2d7eb24d80c0a2c] spi: atmel-qspi: Memory =
barriers after memory-mapped I/O
# good: [c0641be588c22fdcecdb1e90a64803047d4441f8] ASoC: SOF: Intel: Use st=
r_yes_no() helper in atom_dump()
# good: [530e5ada1c8efb8bac7dad668f4176260d13d4da] ASoC: dt-bindings: renes=
as,rsnd: remove post-init-providers property
# good: [2fcde2fbec74c91fb6a724f44cced67a6837b647] drm/i915/dp: Use intel_d=
isplay instead of drm_i915_private
# good: [a38509fd5cdc125ef54562760a05c68ebd4812bc] spi: atmel-quadspi: Use =
devm_ clock management
# good: [173876aa5d4b8d27b99a4288e2501771fd0c9422] drm/i915/ddi: Optimize m=
tl_port_buf_ctl_program
# good: [e7b73981380cefc9ed6261e3b53c37c327cab189] ASoC: dt-bindings: Add s=
chema for "awinic,aw88083"
# good: [2890601f54c7f3365cc2a860889d5d5fba55c106] crypto: vmac - remove un=
used VMAC algorithm
# good: [c5fb51b71788926feef0d07f30c8af1d5e4af1a6] Merge remote-tracking br=
anch 'pm/opp/linux-next' into HEAD
# good: [19dbdbfb747ad7afed88dc7661697744ce192d3b] drm/msm/a5xx: remove nul=
l pointer check on pdev
# good: [855e9d0fbb0aa1150d350b7185d840edd85dfb0e] drm/msm: adreno: enable =
GMU bandwidth for A740 and A750
# good: [0bc9a9e85fcf4ffb69846b961273fde4eb0d03ab] KVM: arm64: Work around =
x1e's CNTVOFF_EL2 bogosity
# good: [de662429f3362dcc0647dd16879214efa4373d9d] crypto: lib/aesgcm - Red=
uce stack usage in libaesgcm_init
# good: [935cd06bfad4b715195befaf527a2d4fd36361d9] ASoC: SDCA: Clean up err=
or messages
# good: [c1ed5eb13f39b0058670bc2b1e251a040c306868] ASoC: SDCA: Add missing =
function type names
# good: [69dcf023f1f13ca9c2e9e8f30b9ec52ac0486c0a] ASoC: SDCA: Split functi=
on type patching and function naming
# good: [c36297b1bd6e52a75a8ed75eb5dbf35c50402398] ASoC: SDCA: Add bounds c=
heck for function address
# good: [deb015208f7be9a62cb68dd8337d075b1829ee1d] ASoC: SDCA: Add missing =
header includes
# good: [3d3ca0915aa3692a837f7235ca9d12db26f09911] drm/msm/dpu: link DSPP_2=
/_3 blocks on SM8650
# good: [a5a9d959936499a3106a1bf3b9070875d0d3dec4] crypto: hisilicon/sec2 -=
 fix for aead invalid authsize
# good: [7b6092ee7a4ce2d03dc65b87537889e8e1e0ab95] crypto: qce - revert "us=
e __free() for a buffer that's always freed"
# good: [99996d575ee69d4327bad98a0148729b73dde23a] KVM: arm64: Add {get,put=
}_pkvm_hyp_vm() helpers
# good: [c4a6ed85455979ef3fbadc2f1bdf18734b0ecea6] KVM: arm64: Promote gues=
t ownership for DBGxVR/DBGxCR reads
# good: [5398ddc5c90bd418b90d859e9267aa39399021af] KVM: arm64: Pass walk fl=
ags to kvm_pgtable_stage2_mkyoung
# good: [f7d03fcbf1f482069e9afac55b17de3bd323b8f6] KVM: arm64: Introduce __=
pkvm_vcpu_{load,put}()
# good: [c77e5181fed54b25d489eb7d2ccb5c1c72a1063c] KVM: arm64: Make kvm_pgt=
able_stage2_init() a static inline function
# good: [d0bd3e6570aee42766e7bd884734ae078667ea1e] KVM: arm64: Introduce __=
pkvm_host_share_guest()
# good: [ee37bc7e0144e312a8e990acdd4f49e4afa71f1c] firmware: cs_dsp: Delete=
 redundant assignments in cs_dsp_test_bin.c
# good: [b69386fcbc6066fb4885667743ab4d4967d561b8] spi: rockchip-sfc: Using=
 normal memory for dma
# good: [f663898d047a7a0a04d30732b1405ee007fdd243] spi: atmel-quadspi: Fact=
or out switching to Serial Memory Mode to function
# good: [cf126261d5d3b8767fd9c838ffe7213144d05147] ASoC: fsl_asrc_m2m: forc=
e cast for snd_pcm_format_t type
# good: [2ef8310c464cac41a024fc6fd2910e51f10a38e7] regulator: tps65219: Upd=
ate driver name
# good: [64a6b577490c1c71f1a3bbdb3844717815214621] regulator: tps65219: Rem=
ove debugging helper function
# good: [e7ce0437709552a5f5e577c29f3dfde620153913] regulator: tps65219: Use=
 dev_err_probe() instead of dev_err()
# good: [ca321ef98b80eb282a4dcdd5231f666c610b0575] regulator: tps65219: Rem=
ove MODULE_ALIAS
# good: [0acb90676629f5549e185dd3a144806e2a88fe40] spi: atmel-quadspi: Refa=
ctor to allow supporting
# good: [d349fd151f1aeb0d8aea4a2f0fe9ba24309609ed] ASoC: soc-core: remove r=
edundant assignment to variable ret
# good: [e490ceff433fbc111404ce040bd9e8f41f12af16] spi: spidev: Align order=
ing of spidev_spi_ids[] and spidev_dt_ids[]
# good: [644115e86023fccdaecb1318133ed14418b76f49] firmware: cs_dsp: Fix en=
dianness conversion in cs_dsp_mock_wmfw.c
# good: [7b4035ebf2af2c2f1450e8c38bf4f41acd3f01bf] spi: dt-bindings: Docume=
nt CS active-high
# good: [db8b9b12892f0528c3a78715243c22398ab3cb5d] ASoC: cs42l43: don't inc=
lude '<linux/find.h>' directly
# good: [a5bd108d4a57d6c00372041c83e633a26fb450de] firmware: cs_dsp: Avoid =
using a u32 as a __be32 in cs_dsp_mock_mem_maps.c
# good: [8011709906d0d6ff1ba9589de5a906bf6e430782] spi: rockchip-sfc: Suppo=
rt pm ops
# good: [c0a0203cf57963792d59b3e4317a1d07b73df42a] spi: atmel-quadspi: Crea=
te `atmel_qspi_ops` to support newer SoC families
# good: [8bfb66c75cdace542dabe87841152614fd5b8d91] ASoC: qcom: sdm845: add =
handling of secondary MI2S clock
# good: [5af42209a4d23adc9a09e59e586d1b47fef3cc86] spi: atmel-quadspi: Add =
support for sama7g5 QSPI
# good: [a5dfca553c237c8cfd0b02aacad64d6e6e14149b] ASoC: Intel: Add matches=
 for Cirrus Logic CDB35L56
# good: [b0e4e2030b18b4e8a6820fc7c9da00e120c89338] firmware: cs_dsp: avoid =
large local variables
# good: [37c42bde28f580ac5de4de838afd5eea72e40262] ASoC: rt715: Remove unus=
ed hda_to_sdw
# good: [301c26a018acb94dd537a4418cefa0f654500c6f] ASoC: soc-pcm: don't use=
 soc_pcm_ret() on .prepare callback
# good: [bc7bd5c335030858216581e7a591d02ebfdb53e7] ASoC: Intel: mtl-match: =
Add CDB35L56-EIGHT-C with aggregated speakers
# good: [bf4519f4b1e1fa6286af5d331146238ddc580ea6] ASoC: Intel: tgl-match: =
Add entries for CS35L56 on CDB35L56-EIGHT-C
# good: [539a3f0c99cf62c61edc37a8f88e3073119ae852] firmware: cs_dsp: Fix ke=
rneldoc typos in cs_dsp_mock_bin.c
# good: [6dcc8e7f2bb7b748d75844631b2bae860648202a] ASoC: Intel: mtl-match: =
Add CDB35L56-EIGHT-C 8x CS35L56 without CS42L43
# good: [5725bce709db1c001140d79398581e067e28c031] ASoC: simple-card-utils:=
 Unify clock direction by clk_direction
# good: [abf594ce914172e3bb640d02fc6e79569fa25b8e] ASoC: soc-core: tidyup r=
et handling for card->disable_route_checks
# good: [047ea6d85ee32c768ceec9a3ad6b7f403971aa63] crypto: seed - stop usin=
g cra_alignmask
# good: [9b94f41449939537151dfd91e922b2e897054b94] ASoC: SOF: core/Intel: H=
andle pause supported token
# good: [5ce3beed07b8145aff61f2cb41f1868f6221271f] ASoC: fsl: add memory to=
 memory function for ASRC
# good: [94c545aa535d7f5dcf54ad8e648f22943bbfcb32] firmware: cirrus: Add KU=
nit tests for cs_dsp
# good: [cd8c058499b65e8605cd3c387bb1f76e2954870e] firmware: cs_dsp: Add KU=
nit testing of bin error cases
# good: [f4425e3ab2f796d442a44f31262eade9b6427ff7] ALSA: compress: Add outp=
ut rate and output format support
# good: [70a667d70cce338ab8552dd762ae114a5ab96500] ASoC: SOF: Add support f=
or pause supported tokens from topology
# good: [75a4a6ef615e2f4e9458051641f185498273ce02] firmware: cs_dsp: Add KU=
nit testing of client callbacks
# good: [7c052c6615297ff32032105130cd5f02059f7ae4] firmware: cs_dsp: Add mo=
ck bin file generator for KUnit testing
# good: [286d658477a43284f7be2539b059ecc90ba109c2] ASoC: fsl_asrc: register=
 m2m platform device
# good: [41e78c0f44f97c958afcda3f82b23f4f4a05b968] firmware: cs_dsp: Add mo=
ck DSP memory map for KUnit testing
# good: [b62eaff0650dc6dc2a4bf0f50714f2357a23fc71] ASoC: fsl_easrc: registe=
r m2m platform device
# good: [5cf1b7b471803f7cc654a29ee16cb085ad69c097] firmware: cs_dsp: Add mo=
ck wmfw file generator for KUnit testing
# good: [dd0b6b1f29b92202d03a6d2dd7d65ecead27941a] firmware: cs_dsp: Add KU=
nit testing of bin file download
# good: [a2b2f2c1cd2a8b21c23bd1ec33131d2266c7568a] firmware: cs_dsp: Add KU=
nit testing of wmfw download
# good: [feb5fb0615f321ab514f4fbbab777f3591f7e4b5] firmware: cs_dsp: Add KU=
nit testing of wmfw error cases
# good: [8ea7d04a4e9e30876c9d8184b4b8e4cab33e0372] ASoC: fsl_asrc: define f=
unctions for memory to memory usage
# good: [9b33a4fc500cedc1adc9c0ee01e30ffd50e5887a] firmware: cs_dsp: Add KU=
nit testing of control cache
# good: [f851b987f39121bb73d110c8508cac5ea60cfdc5] ASoC: SOF: sof-priv: Rem=
ove unused SOF_DAI_STREAM() and SOF_FORMATS
# good: [e4b3a8456447f0e10223ebaca81efabe8a71f3f2] ASoC: SOF: ipc4-topology=
: Use macro to set the EXT_PARAM_SIZE in widget setup
# good: [d54a3fc6bf3db0db0e16cfdf7f48a8bbb803f6b0] firmware: cs_dsp: Add mo=
ck regmap for KUnit testing
# good: [24a01710f6271ec32b629d714e6a64a69665128b] ASoC: fsl_asrc_m2m: Add =
memory to memory function
# good: [3a47319d2d910291f4c09c0f1fec4e86a2e03696] ASoC: SOF: Intel: hda-pc=
m: Follow the pause_supported flag to drop PAUSE support
# good: [fe54fd5474f746f07f2b587f2f5e3311bf611970] firmware: cs_dsp: Add KU=
nit testing of control read/write
# good: [27147695aaf7ccb0edc3f21454b5405c9037b4ba] ASoC: fsl_easrc: define =
functions for memory to memory usage
# good: [83baecd92e7c2a44ac963fab8fd4476c71e19ddd] firmware: cs_dsp: Add KU=
nit testing of control parsing
# good: [08242719a8af603db54a2a79234a8fe600680105] regulator: dt-bindings: =
mt6315: Drop regulator-compatible property
# good: [3ce8df13f65e3ed297def63bb1e3ee6f024cbdc5] Add audio support for th=
e Renesas RZ/G3S SoC
# good: [dec61e16e72db196e8dc1daf7f7022fd98e6d921] ASoC: renesas: rz-ssi: R=
emove the rz_ssi_get_dai() function
# good: [f2efcd90b58d74e6aab7ba47ead0dedc543c0145] drm/i915/display: clean =
up DP Adaptive Sync SDP state mismatch logging
# good: [eb708cd631a8dca17ff004ccc39bbeb096c1db22] regmap: regmap_multi_reg=
_read(): make register list const
# good: [c28dac5d3a6e87615d4c8e50f574c320172a3d55] ASoC: dt-bindings: renes=
as,rz-ssi: Remove DMA description
# good: [cf3a79e4f826fc680fd7bfef7c427e2cc6023bc3] ASoC: renesas: rz-ssi: E=
nable runtime PM autosuspend support
# good: [f0c155c9da7536ab33687b5207eb21e704122a56] ASoC: renesas: rz-ssi: U=
se goto label names that specify their actions
# good: [1fc778f7c833aeb13041adc06f016f1a2dff7350] ASoC: renesas: rz-ssi: A=
dd suspend to RAM support
# good: [fc2a31affb22394d1d74d3ecc86b5c68da33d52a] ASoC: renesas: rz-ssi: I=
ssue software reset in hw_params API
# good: [100c6b22d6c70adabdf45dcb346d7d853bff6a30] ASoC: renesas: rz-ssi: F=
ix typo on SSI_RATES macro comment
# good: [ab20bcb2d0c80b4df9f9a6ef86c6e47d5d10cba0] ASoC: dt-bindings: conve=
rt rt5682.txt to dt-schema
# good: [403366d2a43eb7c911c6cddf1d7882e429d1212d] ASoC: renesas: rz-ssi: U=
se temporary variable for struct device
# good: [e8fcf25f562891d5c0734d4f49c44bb6aa72bc15] ASoC: renesas: rz-ssi: R=
ely on the ASoC subsystem to runtime resume/suspend the SSI
# good: [55c209cd4318c701e6e88e0b2512a0f12dd02a7d] ASoC: renesas: rz-ssi: U=
se only the proper amount of dividers
# good: [541011dc2d7c4c82523706f726f422a5e23cc86f] ASoC: renesas: rz-ssi: T=
erminate all the DMA transactions
# good: [699a9733a354d74482ae4d4304acdbb0c0318a23] ASoC: dt-bindings: renes=
as,rz-ssi: Document the Renesas RZ/G3S SoC
# good: [3888672495fcaee98b90196c0a899b1c2eb57d5b] ASoC: renesas: rz-ssi: A=
dd runtime PM support
# good: [4bf77dfa3308b7cfda29d9c4ead1dc32f1ceefa9] ASoC: renesas: rz-ssi: U=
se readl_poll_timeout_atomic()
# good: [109e60866f11c7db8f720f01b0bda3105c47b463] ASoC: renesas: rz-ssi: R=
emove the first argument of rz_ssi_stream_is_play()
# good: [a73710a25808a585a2bf0a8325eb16fd6a2f370c] ASoC: renesas: rz-ssi: R=
emove pdev member of struct rz_ssi_priv
# good: [3f3b063e0c6d6c35da99bdabba0a9f2bc7e58a47] spi: Unify and simplify =
fwnode related checks
# good: [c56078128c0afe92985c378478b0b0435062c8df] ASoC: simple-card-utils:=
 tidyup for Multi connection
# good: [8c695b4d19cff2828683b8ec1aa6794419ef3a86] ASoC: Intel: boards: upd=
ates for 6.14
# good: [b7cc281812c4e0545d415e9761d5b03e130a41f2] spi: Merge up fixes
# good: [527acf5de4c060ebb3d1eb98c4acf21743c2cde7] Add function to constrai=
n rates
# good: [5a305d9d48df11e8eeb8c28fa08927067bc274af] ASoC: sun4i-spdif: Add 2=
4bit support
# good: [b6ffe0e6147915fe3d31705e14dfbbecb724fb81] spi: Unify firmware node=
 type checks
# good: [80ac12ffb3a9e19a2f11eb1975ed31c9a39183c8] ASoC: sun4i-spdif: Alway=
s set the valid data to be the MSB
# good: [17b531c162e5dbdce9a184ccd1c730ae3f31576b] regulator: dt-bindings: =
pca9450: Add pca9452 support
# good: [a17162f0b2dc97aa2dedfde8a7226fb9b5210534] spi: mxs: support effect=
ive_speed_hz
# good: [af4cffb250ec9e26a76c90cf753f1a6630811eed] ASoC: tas2781: Remove us=
e of i2c_match_id()
# good: [06c61070173803a5341be31ff5281d15cc133e5d] ASoC: tas5720: Remove us=
e of i2c_match_id()
# good: [77f3bfeacb939b47e1ffcda000cdf3c52af70e0f] ASoC: wm8904: Remove use=
 of i2c_match_id()
# good: [229773f90b1f886e8fd542f98b495c66e43be5ba] regulator: pca9450: add =
enable_value for all bucks
# good: [b9f99efcc59ae86bcf238719e29427e9519b3878] ASoC: pcm186x: Remove us=
e of i2c_match_id()
# good: [f742875ee2534473ca4bf5ce1e120bebdf8d624d] ASoC: tlv320aic31xx: Rem=
ove use of i2c_match_id()
# good: [2a169c459d9614dd6edebd8d34ab096b09f134ac] ASoC: tlv320aic3x: Remov=
e use of i2c_match_id()
# good: [0020c9d2d572b49c55b2e1fabe6f6687e11a3ced] spi: Deduplicate deferre=
d probe checks in spi_probe()
# good: [55cf63cc8d951246ec35195ae5a1628beb9c9da3] ASoC: tlv320adc3xxx: Rem=
ove use of i2c_match_id()
# good: [0a7bd3dba60a967032ce8c05b4d81350f01ecc8a] ASoc: pcm6240: Remove us=
e of i2c_match_id()
# good: [8332e667099712e05ec87ba2058af394b51ebdc9] spi: zynq-qspi: Add chec=
k for clk_enable()
# good: [0f5c601098bd3c9cdfea3e01aacdd9d0c4010ea7] regulator: pca9450: Use =
dev_err_probe() to simplify code
# good: [017b76fb8e5b6066f6791e7ad2387deb2c9c9a14] regulator: pca9450: Add =
PMIC pca9452 support
# good: [eb4b5da0ecf61135533574285bacb9dab4fc4703] ASoC: tas2562: Remove us=
e of i2c_match_id()
# good: [6c978c1baeb8449114e8cb35c68832e903f713d8] ASoC: ssm2602: Remove us=
e of i2c_match_id()
# good: [7d57d1ce9398bb59fa0b251aa2ffa6eafef5cff4] ASoC: wm8985: Remove use=
 of i2c_match_id()
# good: [0a2319308de88b9e819c0b43d0fccd857123eb31] ASoC: sun4i-spdif: Add c=
lock multiplier settings
# good: [a8bb9855de4c5ca5b586814b7f8cc4a77d9e8b9c] ASoC: max98095: Remove u=
se of i2c_match_id()
# good: [cb47dcedef8dee9e9e64598612b2a301f70a7fdb] ASoC: tpa6130a2: Remove =
use of i2c_match_id()
# good: [6e750d3ec7410c8d3aa6a006d37142eb837b3c03] ASoC: sun4i-spdif: Add w=
orking 24bit audio support
# good: [124d534c581cda93aae06b37351ed76af7b98d5c] ASoC: Intel: soc-acpi-in=
tel-lnl-match: add rt713_vb_l2_rt1320_l13 support
# good: [5757b31666277e2b177b406e48878dc48d587a46] ASoC: Merge up v6.12-rc2
# good: [56731c80fc3b17850e49913cec262c2bcaa88dcb] ASoC: adau1761: Remove u=
se of i2c_match_id()
# good: [ebf572bfefcd27584e1b32b0dd51ba71f3fe33d6] ASoC: max98088: Remove u=
se of i2c_match_id()
# good: [558d516e4b0f886f15ea04c83bf3ab0bbe62e474] ASoC: Intel: sof_sdw: Ad=
d a dev_dbg message for the SOC_SDW_CODEC_MIC quirk
# good: [90a73807fd8a6c044cc971e53c2cc602f3841ef6] ASoC: Intel: sof_sdw: re=
duce log level for not using internal dmic
# good: [bd4a5c8d5356fa42a1d63b684d34cf58a21eb8f7] ASoC: simple-card-utils:=
 use for_each_of_graph_port() on graph_get_dai_id()
# good: [d6ba6f50fae4170a8b7058da81dc2644913a5216] ASoC: adau1977: Remove u=
se of i2c_match_id()
# good: [a3003af649efb6f3d86d379d1e9a966ea6d5f5ab] ASoC: Intel: soc-acpi: a=
rl: Correct naming of a cs35l56 address struct
# good: [41f91a884f9e5d9fda73fcb30d87b72fb7526216] ASoC: Intel: sof_sdw: im=
prove the log of DAI link numbers
# good: [4edc98598be43634f87af5d3876ebec6c274d2cb] ASoC: fsl_sai: Add sampl=
e rate constraint
# good: [7662f0e5d55728a009229112ec820e963ed0e21c] ASoC: Intel: sof_sdw: Co=
rrect quirk for Lenovo Yoga Slim 7
# good: [b622b677d255b41cbfce20b66535723933a6b640] ASoC: fsl_xcvr: Add samp=
le rate constraint
# good: [db2aaa0943803fbba606e3b59b5cf900eced2a5c] ASoC: max98090: Remove u=
se of i2c_match_id()
# good: [f9812846ffdb1f5686154cae18ca8cc765232967] ASoC: adau1781: Remove u=
se of i2c_match_id()
# good: [e9705da8472f306b44cbe1992ea2161bb96ece6e] ASoC: dt-bindings: qcom,=
wcd9335: Drop number of DAIs from the header
# good: [bd40d912728fc306e0861c82af4a359d8691ee16] ASoC: Intel: soc-acpi-in=
tel-ptl-match: add rt712_vb + rt1320 support
# good: [e5fca61fdfcdd7d3cc43c0b4c3b959d4f2b06666] spi: Merge up v6.12-rc2
# good: [99816f3fa964380a50ccc898b08cc7d9dd58c764] ASoC: alc5632: Remove us=
e of i2c_match_id()
# good: [a7ebb0255188a7a2f1c9edd5660346bd5b17fb7b] ASoC: Intel: soc-acpi-in=
tel-ptl-match: add rt713_vb_l2_rt1320_l13 support
# good: [820bcaeb1ff5705ba907563e554f17d0deecc3fa] ASoC: fsl_utils: Add fun=
ction to constrain rates
# good: [1331fb6640440f42a709eafd5c802f3496f746b8] regmap: Merge up v6.12-r=
c2
# good: [76c29db042e4f0fdea75c76cd4ad5f36080cd1c9] ASoC: codecs: wcd9335: A=
dd define for number of DAIs
# good: [b5e8f7abbb73d0f71ec8742c990c7e1ffa44a554] ASoC: alc5623: Remove us=
e of i2c_match_id()
# good: [daf7a173fc7c4b652f3fe69d3b5aa520976a7d63] ASoC: fsl_micfil: Switch=
 to common sample rate constraint function
# good: [8c491103c946fb760005044a74c82d7cf6c6f6b4] ASoC: ad193x: Remove use=
 of i2c_match_id()
# good: [419d1918105e5d9926ab02f1f834bb416dc76f65] ASoC: simple-card-utils:=
 use __free(device_node) for device node
# good: [4ab80a2961c75562ffbac1f80de151a978c31659] ASoC: Intel: sof_sdw: co=
rrect mach_params->dmic_num
# good: [76deee29153b8313cc9629d3db45e56024b3dd26] ASoC: simple-card-utils:=
 check port reg first on graph_get_dai_id()
# good: [d7f671b2f566379f275c13e25a29fa7001bb278f] ASoC: Intel: soc-acpi: a=
rl: Add match entries for new cs42l43 laptops
# good: [a6ebabd0e53d4352abe0fd2ad156a52162f5d3ce] regulator: Merge up v6.1=
2-rc2
# good: [5a56323a54b7febcfe82cc5eda840a176647b7cd] ASoC: dt-bindings: media=
tek,mt8188-mt6359: Allow DL_SRC/UL_SRC dai-links
# good: [8e22ea5fb8498c52fcc20bbe2070c3aef1a3dff2] ASoC: dt-bindings: media=
tek,mt8188-mt6359: Add compatible for mt8390 evk
# good: [1a90aae3b25b72e639da6062e0dc5efb9cff58f1] spi: spi-kspi2: Add KEBA=
 SPI controller support
# good: [d59f0196e990e5a1bb474eabf146f25cb8aea33d] ASoC: Correct *-objs usa=
ges
# good: [577f1cf76ceedb5fbdc9aca4f712b21864ac15ee] spi: rockchip-sfc: Optim=
ize the judgment mechanism completed by the controller
# good: [31823f27f84bfa06be20f98ec9be63a671307d63] ASoC: Splitting cs35l56 =
SoundWire DAI into separate
# good: [9d6aacda3ad546048e02d83e5831e0b415382518] Add support for codec of=
 F1C100s
# good: [297711ba0282abef38824b1e08c0ad6dcb6c4a53] ASoC: fsl_xcvr: Add susp=
end and resume support
# good: [c41da3a620e611b16b62a5cf93168caf01252fc4] ASoC: Merge up origin to=
 resolve interaction with manline symbol changes
# good: [582057d2233a5a38e1aec3f4a6d66b362b42076c] ASoC: wcd937x: Use *-y f=
or Makefile
# good: [f686a2b52e9d78cf401f1b7f446bf0c3a81ebcc0] pinctrl: samsung: Fix ir=
q handling if an error occurs in exynos_irq_demux_eint16_31()
# good: [ba257e7006867ab1844a6449bdfa3b5aea94fe29] spi: cadence-quadspi: Ad=
d support for device reset
# good: [c841f9909b0d947ae7593040cc59646dc9f14455] dt-bindings: dma: qcom,g=
pi: Add QCS615 compatible
# good: [569922b82ca660f8b24e705f6cf674e6b1f99cc7] ASoC: SOF: Intel: hda-da=
i: Ensure DAI widget is valid during params
# good: [bcbf421d2190bc4f7d3fd2cc61caf748779ee69e] ASoC: amd: ps: update ma=
ch params subsystem_rev variable
# good: [5547e7ca122081d0603d2d7e0fe81a7c551f1e11] ASoC: cs35l56: Split Sou=
ndWire DAI into separate playback and capture
# good: [bb2cc3014d74dfdab0b358b4539a9d2747598663] ASoC: dt-bindings: Add A=
llwinner suniv F1C100s Audio Codec
# good: [3f0b8d367db5b0c0a0096b1c2ff02ec7c5c893b6] ASoC: cs40l50: Use *-y f=
or Makefile
# good: [a308f9e47fc2377863f0f561ceedd45ccc7c7f9c] regmap: Cleanup and micr=
ooptimization
# good: [8359ea9c119570fb5971379655661f77a3aafb1d] ASoC: Drop explicit init=
ialization of struct i2c_device_id::driver_data to 0
# good: [f60646d9c3bd5b390728ed1a1caa9ded53d47afc] ASoC: SDCA: Use *-y for =
Makefile
# good: [484c997e03cec04da6f69c2c17e854b22aa0f98f] ASoC: sdw_utils: cs_amp:=
 Assign non-overlapping TDM masks for each codec on a bus
# good: [7378aeb664e5ebc396950b36a1f2dedf5aabec20] remoteproc: core: Fix id=
a_free call while not allocated
# good: [e9d2a2f49244d9737f0ec33f4b7f3580faecd805] ASoC: mediatek: mt8365: =
Use *-y for Makefile
# good: [5f7fb33b7ba1287c33e35b7778d5a371472e3503] drm/i915/display: remove=
 unused for_each_crtc()
# good: [25cd677636d316669871947639430615ff564890] ASoC: amd: ps: add ZSC c=
ontrol register programming sequence
# good: [7916a8d8782d4e53fe0133c8dace20a925e0204e] ASoC: cs42l84: Use *-y f=
or Makefile
# good: [2198deb823a6ebe110b737614421a4687d3327f4] ASoC: sun4i-codec: Add s=
upport for Allwinner suniv F1C100s
# good: [cabd4ac290a6ceb87c8dbfb5a3251750e24529e7] ASoC: sun4i-codec: Add D=
MA Max Burst field
# good: [1684e8293605062dee45a5e4118fe8db6cd0d9d9] arm/crc-t10dif: expose C=
RC-T10DIF function through lib
# good: [a4a7d86bc1a59839ad0dffbefa473135b342dd0b] regmap: Use BITS_TO_BYTE=
S()
# good: [2e4d9f5111a3b3c24550e34710efa690c03b3ea1] spi: cadence-quadspi: Us=
e quirks to set dma_set_mask instead of compatible string for 64-bit DMA su=
pport
# good: [42c7af046aaf35c42ef864cbd96df025c48ce50f] ASoC: rockchip: i2s-tdm:=
 Fix a useless call issue
# good: [9b3cd5c7099fe7710356dd76ecf9910dc8c32548] regmap: place foo / 8 an=
d foo % 8 closer to each other
# good: [096c34ddf5835f02f5260719cd8a16fcf5e5e56f] spi: spidev: Add an entr=
y for lwn,bk4-spi
# good: [27cf57f65bea55d985f0ad0dc1737ce1d01f05dc] spi: cadence-quadspi: Su=
pport for device reset via OSPI controller
# good: [37c95f022a7a34823c123eeccdfe415b88562867] regmap: cache: mapple: u=
se kmalloc_array() to replace kmalloc()
# good: [f2b4fa19647e18a2e2aade7e3e4620567e7e594a] ext4: switch to using th=
e crc32c library
# good: [e6a9750a346b103bd8ab2bf25be76a719d8061b2] ASoC: fsl_xcvr: Add susp=
end and resume support
# good: [dc9f2312acaee205609ad3c8b5f064e39eab1d6b] ASoC: tas2781: Fix redun=
dant logical jump
# good: [3787255c967ba64dc72adc3038f0cb81211bd297] ASoC: cs42l51: Constify =
struct i2c_device_id
# good: [e39531352aed30156b270a61ba075e5b8d3b8498] spi: rockchip-sfc: Suppo=
rt ACPI
# good: [509544d1b6dbffe7bc1849593ff217f965ec0419] ASoc: mediatek: mt8365: =
Don't use "proxy" headers
# good: [36e7886075262429158aec6f258e6a5a92f025b1] dt-bindings: misc: lwn,b=
k4-spi: Add binding
# good: [4a3aafe01f6c628932a402c21e58101173c8dab3] regmap: cache: Use BITS_=
TO_BYTES()
# good: [c14e85360969d7b0aaeab3915314787f3466c326] lib/crc16_kunit: delete =
obsolete crc16_kunit.c
# good: [a8d77166fcfe1cd4be70c21d65ff2b27b4f54a26] regulator: bd96801: Add =
ERRB IRQ
# good: [707080d4fea8f6b8319ceead569f34c2be5bf1d5] spi: dt-bindings: cdns,q=
spi-nor: Add compatible string to support OSPI controller on Versal Gen2 pl=
atform
# good: [2c55f67c3a71cf57665294a02f258625c1da9385] spi: sc18is602: Switch t=
o generic firmware properties and drop of_match_ptr()
# good: [5a8b4785cddabfad348a96ca38eb0c3d735202df] ASoC: fsl_xcvr: Use regm=
ap for PHY and PLL registers
# good: [b95cacd8d708bce5839db2767d425e20ae548fd8] regmap: cache: rbtree: u=
se krealloc_array() to replace krealloc()
# good: [01981565c764c554cc96e2d30a71c42975171416] ASoC: mediatek: mt8192-a=
fe-pcm: Simplify probe() with local dev variable
# good: [e03b0aa67ac0106d8961581a426649fabab50827] drm/xe: Set XE_BO_FLAG_P=
INNED in migrate selftest BOs
# good: [f161809b362f027b6d72bd998e47f8f0bad60a2e] drm/xe/guc_submit: fix r=
ace around suspend_pending
# good: [b6308aaa24a7ad3dfc6157b6afc550b9ab7e8945] drm/xe/display: Update i=
ntel_bo_read_from_page to use ttm_bo_access
# good: [7d08df5d0bd3d12d14dcec773fcddbe3eed3a8e8] drm/ttm: Add ttm_bo_acce=
ss
# good: [54254727837440966c3381ea688df002ff14f269] drm/xe: Only allow conti=
guous BOs to use xe_bo_vmap
# good: [90e315a58fd903e43457fa085b6644e45c047e31] drm/xe/gsc: Improve SW p=
roxy error checking and logging
# good: [678ccbf987969a6020fe95ecb4a2f568e7466821] drm/xe/vram: drop 2G blo=
ck restriction
# good: [6baab135eb00e85020abd0f13907a934b3df5c6b] MAINTAINERS: exec: Add a=
uxvec.h UAPI
# good: [2378bd0b264ad3a1f76bd957caf33ee0c7945351] ipmi: ipmb: Add check de=
vm_kasprintf() returned value
# good: [9fbf78b6d6cecc2e9833c2f74eb2edc027c9b4cb] Merge branch 'for-6.12/t=
rivial' into for-next
# good: [136a78710f33e91e28ff4bd29e256ca27f87631f] MAINTAINERS: exec: Mark =
Kees as maintainer
# good: [9871e6af43db3892811f5a4ed0ed2e2d7cf6cf3c] Merge branch 'for-6.11/s=
ysfs-patch-replace' into for-next
git bisect start 'e7bb221a638962d487231ac45a6699fb9bb8f9fa' '7b90deb712bbac=
df8aa1fc01bf155cab5c21d98a' '6b077230a1e163f01c866923915def6f73f9c390' 'e89=
6c04890aeff2292364c19632fc15d890d436c' '41f1d2bd4998829341cdada022ede610068=
a0f33' '40ba3c9019ccd34d576fa14f94ef4f3bd9284c1a' 'eab69050450ba63a4edb17d3=
d1a8654d2a130786' '3927c51e49c1a45785334dc578f0b29c685619ec' '9a8afbe567723=
4ac2490438d6b8ab74ee7fb359e' '65880d32e1d7eb1ef03253c454fcd8f9d41aaa09' '29=
2284f2be46514ed07e7b3e3350329f656c4f62' '9d499259db0cc5a31e212570c2cf945ad1=
17b900' '8eb27b5758e6fb6d1881413e3f1159c579ac48b3' '7299cc06fe4ab2ac26af73a=
c5fecd35a28fef527' '5f281c3e82b1203c40cf6ead009ffb5b09db056b' 'c8903242bcb1=
19660232c9cbf336fea3737d1a60' '85dc053c87bcc32afd8e5cbf20a649dc24e93d24' '3=
65865b7d7467aea9767ea18670198921bcada7c' 'c8a1dccf449eb71b23b6c04ff6b40db56=
8d7cf92' '24410f499e808884cc91239dc16013e5bee8779a' '2518a0e1b878042f9afa45=
ae063e544a16efc1a3' '6f490e6b2c34792e363685bacb48a759e7e40cd1' 'a1a771e5f1e=
31e4764d9a225c02e93969d3f5389' 'e8d06511ee70175a58be450a098ab1ce37fe9ecb' '=
4e26de25d2b617e12bba98e11393fdf7c27885f9' '6f91d31d47c57953da68e1a91240ae25=
43b00172' '38138762faffeb923d9f49efbcc09884f1530786' 'd0670128d42fa170bf8ba=
878cd23504c5c5cccc7' 'e880b16efb78f9c7449239a76814aeb015daf2a1' '8fd113c6ba=
2490e4ce38447a596ab448eeb1a1f4' '17b99c04d9b48465d45b0913fa78a6859b0b24c5' =
'a2b579c41fe9c295804abd167751f9fdc73c7006' 'c382ee674c8b5005798606267d660cf=
995218b18' '226d6cb3cb799aae46d0dd19a521133997d9db11' 'fd85b6b7bc53409d0be8=
2763419bdcdaa48f2c91' '89b37e49929653b7c350aac7fb2b96a052533015' 'abea0cbfb=
a5848d11b6364e82df4864fd0bfa683' '2438db5253eb17a7c0ccb15aea4252a150dda057'=
 '26851cf65ffca2d3a8d529a125e54cf0084d69e7' 'd3f35dd3ad968256ed1080e3ea2022=
f947861cff' '67707cb094f134f5b3931eefbedbb9ca7e3209d0' 'd1f85873d2d62d6980e=
68d21d3a21f20b0664cc3' '13529647743d906ed3cf991f1d77727e7ff1fb6f' '5baa1897=
89e8894c58eacc7803e3c163c1d0fc0a' 'b2fac3192919dd07e7ce30558e34abd7e07dde77=
' '1248c9b8d54120950fda10fbeb98fb8932b4d45c' 'eee7bc9e7ade6f7ac17d9ec02887c=
d5509ba9427' '13fd04b53053bbfa741a0f2a781837ab80e485f6' '1a206344218cc15ad8=
f321e3abab3f3d36ab639f' 'e6204f39fe3a7b4538815a2d778b601bd543649e' '0fefead=
e90e74bc8f40ab0e460f483565c492e28' 'd0e5faccb229b1dacc4c9fa11f6df33bb1fdabd=
8' '30eb2e6e78225f92f04a2325c6fd77fe8f5b4aab' '84eac6d478c00f8f9101f91716ea=
3866d2fc1e54' '9a68f6c8d6cfddeac7c5874528ed04e50a1cb579' '06e9f5a1f6ba774d8=
942a168d3ec5ed5a008fbcb' 'f0006897a96c736623ddeb9b68c3880eb5cdebe7' '61aff2=
da3e63a43f22e60aa1bc57026ce07d189e' 'dd2395162c07e4102fc83878dc394ff63f2eaa=
e8' 'fd688ce125a4ff5cc2b6be1184dc17c9f342db37' '7e24ec93aecd12e33d31e38e5af=
4625553bbc727' '9c0e29b9957e407af6197ff1fb48f365a9b0c248' 'c3ad22ad34f81a89=
06dba02ea8cc9756d2ce7b50' 'cf4d74256fe103ece7b2647550e6c063048e5682' 'e9ca3=
db9f01a7ce91ceab35cd5fa52f0c5aca174' '33228036ff655ebed1bc4bde9c9b6329b569b=
27b' 'e3146775f05d18c667a2e26082da3ac105f87d9f' 'bca0fa5f6b5e96c03daac1ed62=
b1e5c5057a2048' '5e56618e1593a9eb9d72dc9433ac7a02a6c48c8f' '5640fd07b90ed43=
225704fecfbbda9d402dba1cf' '636ee5781d259258dc9425a5552be1ffa458633c' 'dbda=
5c35b88794f6e5efe1b5b20044b0b3a340d4' 'aea305d28551bc213aab3a41a0f59412247a=
e2b4' '3eede0fc99c684df6f3f35866761036dabf89d05' '94aa347d34e079859a5378272=
c9452c728e4183a' '480d9bb9cfb7b774b22cf82ff21903eb50d64cb9' '0ca529926c5d9d=
0a3c0b1609fb7034ab870e4770' '0b12850ddfb0032376ef1be10b5b46be00bba4d4' 'ef7=
24707788325a53ffa4cf58fceb94654e4793a' '3566784817aeb1a733c95953998a29adc38=
6d2ff' '9c3d68ce5dee76f30b23ca29b2be4774e291f7f1' '82a0a3e6f8c02b3236b55e78=
4a083fa4ee07c321' '309caeef4381e8777f65030dccabc71456650269' 'd406b354df909=
155ff0122acf80f3bc7410fa27e' '5bc493bf0c37c157bf2eb364e55a1c6f8bc43a69' 'fd=
d9ef3dce98e035d21c17fac587cb6e3c7706fd' '8227c7510b56460e9ecf1acf4e5150da70=
70ab6c' 'b21468e83b787ab31aa9df8f429d2ca61def0cc9' '5d085b25ae9843b48653609=
86ab288332bb01e21' 'c51187903fe4523fd7f521662c1ae1f1f3174036' '7b16e60b3120=
2254c62a29f5c709ffb42684b6f9' 'a83678be5ea152dca98791956f7bf2a0e899e3ad' 'f=
ffe003fc209a3c1f3d07be7e860fed4e51c4c00' 'be947cc0cbbb0985d60a77aed709460a4=
6eb3d0b' 'f1a92bb81a6cf9ae9a50d175be8b396bfabcb487' '8c588fe965d95fd2d18e1a=
1d55489b9237eeddfe' 'af103eb7d7d881cf6ff7414242bce2d8e394cc32' 'dddca3b2fc6=
76113c58b04aaefe84bfb958ac83e' '1e293574c6f5d5d87acd7d64415eae055d0672e7' '=
be92ab2de0ee1a13291c3b47b2d7eb24d80c0a2c' 'c0641be588c22fdcecdb1e90a6480304=
7d4441f8' '530e5ada1c8efb8bac7dad668f4176260d13d4da' '2fcde2fbec74c91fb6a72=
4f44cced67a6837b647' 'a38509fd5cdc125ef54562760a05c68ebd4812bc' '173876aa5d=
4b8d27b99a4288e2501771fd0c9422' 'e7b73981380cefc9ed6261e3b53c37c327cab189' =
'2890601f54c7f3365cc2a860889d5d5fba55c106' 'c5fb51b71788926feef0d07f30c8af1=
d5e4af1a6' '19dbdbfb747ad7afed88dc7661697744ce192d3b' '855e9d0fbb0aa1150d35=
0b7185d840edd85dfb0e' '0bc9a9e85fcf4ffb69846b961273fde4eb0d03ab' 'de662429f=
3362dcc0647dd16879214efa4373d9d' '935cd06bfad4b715195befaf527a2d4fd36361d9'=
 'c1ed5eb13f39b0058670bc2b1e251a040c306868' '69dcf023f1f13ca9c2e9e8f30b9ec5=
2ac0486c0a' 'c36297b1bd6e52a75a8ed75eb5dbf35c50402398' 'deb015208f7be9a62cb=
68dd8337d075b1829ee1d' '3d3ca0915aa3692a837f7235ca9d12db26f09911' 'a5a9d959=
936499a3106a1bf3b9070875d0d3dec4' '7b6092ee7a4ce2d03dc65b87537889e8e1e0ab95=
' '99996d575ee69d4327bad98a0148729b73dde23a' 'c4a6ed85455979ef3fbadc2f1bdf1=
8734b0ecea6' '5398ddc5c90bd418b90d859e9267aa39399021af' 'f7d03fcbf1f482069e=
9afac55b17de3bd323b8f6' 'c77e5181fed54b25d489eb7d2ccb5c1c72a1063c' 'd0bd3e6=
570aee42766e7bd884734ae078667ea1e' 'ee37bc7e0144e312a8e990acdd4f49e4afa71f1=
c' 'b69386fcbc6066fb4885667743ab4d4967d561b8' 'f663898d047a7a0a04d30732b140=
5ee007fdd243' 'cf126261d5d3b8767fd9c838ffe7213144d05147' '2ef8310c464cac41a=
024fc6fd2910e51f10a38e7' '64a6b577490c1c71f1a3bbdb3844717815214621' 'e7ce04=
37709552a5f5e577c29f3dfde620153913' 'ca321ef98b80eb282a4dcdd5231f666c610b05=
75' '0acb90676629f5549e185dd3a144806e2a88fe40' 'd349fd151f1aeb0d8aea4a2f0fe=
9ba24309609ed' 'e490ceff433fbc111404ce040bd9e8f41f12af16' '644115e86023fccd=
aecb1318133ed14418b76f49' '7b4035ebf2af2c2f1450e8c38bf4f41acd3f01bf' 'db8b9=
b12892f0528c3a78715243c22398ab3cb5d' 'a5bd108d4a57d6c00372041c83e633a26fb45=
0de' '8011709906d0d6ff1ba9589de5a906bf6e430782' 'c0a0203cf57963792d59b3e431=
7a1d07b73df42a' '8bfb66c75cdace542dabe87841152614fd5b8d91' '5af42209a4d23ad=
c9a09e59e586d1b47fef3cc86' 'a5dfca553c237c8cfd0b02aacad64d6e6e14149b' 'b0e4=
e2030b18b4e8a6820fc7c9da00e120c89338' '37c42bde28f580ac5de4de838afd5eea72e4=
0262' '301c26a018acb94dd537a4418cefa0f654500c6f' 'bc7bd5c335030858216581e7a=
591d02ebfdb53e7' 'bf4519f4b1e1fa6286af5d331146238ddc580ea6' '539a3f0c99cf62=
c61edc37a8f88e3073119ae852' '6dcc8e7f2bb7b748d75844631b2bae860648202a' '572=
5bce709db1c001140d79398581e067e28c031' 'abf594ce914172e3bb640d02fc6e79569fa=
25b8e' '047ea6d85ee32c768ceec9a3ad6b7f403971aa63' '9b94f41449939537151dfd91=
e922b2e897054b94' '5ce3beed07b8145aff61f2cb41f1868f6221271f' '94c545aa535d7=
f5dcf54ad8e648f22943bbfcb32' 'cd8c058499b65e8605cd3c387bb1f76e2954870e' 'f4=
425e3ab2f796d442a44f31262eade9b6427ff7' '70a667d70cce338ab8552dd762ae114a5a=
b96500' '75a4a6ef615e2f4e9458051641f185498273ce02' '7c052c6615297ff32032105=
130cd5f02059f7ae4' '286d658477a43284f7be2539b059ecc90ba109c2' '41e78c0f44f9=
7c958afcda3f82b23f4f4a05b968' 'b62eaff0650dc6dc2a4bf0f50714f2357a23fc71' '5=
cf1b7b471803f7cc654a29ee16cb085ad69c097' 'dd0b6b1f29b92202d03a6d2dd7d65ecea=
d27941a' 'a2b2f2c1cd2a8b21c23bd1ec33131d2266c7568a' 'feb5fb0615f321ab514f4f=
bbab777f3591f7e4b5' '8ea7d04a4e9e30876c9d8184b4b8e4cab33e0372' '9b33a4fc500=
cedc1adc9c0ee01e30ffd50e5887a' 'f851b987f39121bb73d110c8508cac5ea60cfdc5' '=
e4b3a8456447f0e10223ebaca81efabe8a71f3f2' 'd54a3fc6bf3db0db0e16cfdf7f48a8bb=
b803f6b0' '24a01710f6271ec32b629d714e6a64a69665128b' '3a47319d2d910291f4c09=
c0f1fec4e86a2e03696' 'fe54fd5474f746f07f2b587f2f5e3311bf611970' '27147695aa=
f7ccb0edc3f21454b5405c9037b4ba' '83baecd92e7c2a44ac963fab8fd4476c71e19ddd' =
'08242719a8af603db54a2a79234a8fe600680105' '3ce8df13f65e3ed297def63bb1e3ee6=
f024cbdc5' 'dec61e16e72db196e8dc1daf7f7022fd98e6d921' 'f2efcd90b58d74e6aab7=
ba47ead0dedc543c0145' 'eb708cd631a8dca17ff004ccc39bbeb096c1db22' 'c28dac5d3=
a6e87615d4c8e50f574c320172a3d55' 'cf3a79e4f826fc680fd7bfef7c427e2cc6023bc3'=
 'f0c155c9da7536ab33687b5207eb21e704122a56' '1fc778f7c833aeb13041adc06f016f=
1a2dff7350' 'fc2a31affb22394d1d74d3ecc86b5c68da33d52a' '100c6b22d6c70adabdf=
45dcb346d7d853bff6a30' 'ab20bcb2d0c80b4df9f9a6ef86c6e47d5d10cba0' '403366d2=
a43eb7c911c6cddf1d7882e429d1212d' 'e8fcf25f562891d5c0734d4f49c44bb6aa72bc15=
' '55c209cd4318c701e6e88e0b2512a0f12dd02a7d' '541011dc2d7c4c82523706f726f42=
2a5e23cc86f' '699a9733a354d74482ae4d4304acdbb0c0318a23' '3888672495fcaee98b=
90196c0a899b1c2eb57d5b' '4bf77dfa3308b7cfda29d9c4ead1dc32f1ceefa9' '109e608=
66f11c7db8f720f01b0bda3105c47b463' 'a73710a25808a585a2bf0a8325eb16fd6a2f370=
c' '3f3b063e0c6d6c35da99bdabba0a9f2bc7e58a47' 'c56078128c0afe92985c378478b0=
b0435062c8df' '8c695b4d19cff2828683b8ec1aa6794419ef3a86' 'b7cc281812c4e0545=
d415e9761d5b03e130a41f2' '527acf5de4c060ebb3d1eb98c4acf21743c2cde7' '5a305d=
9d48df11e8eeb8c28fa08927067bc274af' 'b6ffe0e6147915fe3d31705e14dfbbecb724fb=
81' '80ac12ffb3a9e19a2f11eb1975ed31c9a39183c8' '17b531c162e5dbdce9a184ccd1c=
730ae3f31576b' 'a17162f0b2dc97aa2dedfde8a7226fb9b5210534' 'af4cffb250ec9e26=
a76c90cf753f1a6630811eed' '06c61070173803a5341be31ff5281d15cc133e5d' '77f3b=
feacb939b47e1ffcda000cdf3c52af70e0f' '229773f90b1f886e8fd542f98b495c66e43be=
5ba' 'b9f99efcc59ae86bcf238719e29427e9519b3878' 'f742875ee2534473ca4bf5ce1e=
120bebdf8d624d' '2a169c459d9614dd6edebd8d34ab096b09f134ac' '0020c9d2d572b49=
c55b2e1fabe6f6687e11a3ced' '55cf63cc8d951246ec35195ae5a1628beb9c9da3' '0a7b=
d3dba60a967032ce8c05b4d81350f01ecc8a' '8332e667099712e05ec87ba2058af394b51e=
bdc9' '0f5c601098bd3c9cdfea3e01aacdd9d0c4010ea7' '017b76fb8e5b6066f6791e7ad=
2387deb2c9c9a14' 'eb4b5da0ecf61135533574285bacb9dab4fc4703' '6c978c1baeb844=
9114e8cb35c68832e903f713d8' '7d57d1ce9398bb59fa0b251aa2ffa6eafef5cff4' '0a2=
319308de88b9e819c0b43d0fccd857123eb31' 'a8bb9855de4c5ca5b586814b7f8cc4a77d9=
e8b9c' 'cb47dcedef8dee9e9e64598612b2a301f70a7fdb' '6e750d3ec7410c8d3aa6a006=
d37142eb837b3c03' '124d534c581cda93aae06b37351ed76af7b98d5c' '5757b31666277=
e2b177b406e48878dc48d587a46' '56731c80fc3b17850e49913cec262c2bcaa88dcb' 'eb=
f572bfefcd27584e1b32b0dd51ba71f3fe33d6' '558d516e4b0f886f15ea04c83bf3ab0bbe=
62e474' '90a73807fd8a6c044cc971e53c2cc602f3841ef6' 'bd4a5c8d5356fa42a1d63b6=
84d34cf58a21eb8f7' 'd6ba6f50fae4170a8b7058da81dc2644913a5216' 'a3003af649ef=
b6f3d86d379d1e9a966ea6d5f5ab' '41f91a884f9e5d9fda73fcb30d87b72fb7526216' '4=
edc98598be43634f87af5d3876ebec6c274d2cb' '7662f0e5d55728a009229112ec820e963=
ed0e21c' 'b622b677d255b41cbfce20b66535723933a6b640' 'db2aaa0943803fbba606e3=
b59b5cf900eced2a5c' 'f9812846ffdb1f5686154cae18ca8cc765232967' 'e9705da8472=
f306b44cbe1992ea2161bb96ece6e' 'bd40d912728fc306e0861c82af4a359d8691ee16' '=
e5fca61fdfcdd7d3cc43c0b4c3b959d4f2b06666' '99816f3fa964380a50ccc898b08cc7d9=
dd58c764' 'a7ebb0255188a7a2f1c9edd5660346bd5b17fb7b' '820bcaeb1ff5705ba9075=
63e554f17d0deecc3fa' '1331fb6640440f42a709eafd5c802f3496f746b8' '76c29db042=
e4f0fdea75c76cd4ad5f36080cd1c9' 'b5e8f7abbb73d0f71ec8742c990c7e1ffa44a554' =
'daf7a173fc7c4b652f3fe69d3b5aa520976a7d63' '8c491103c946fb760005044a74c82d7=
cf6c6f6b4' '419d1918105e5d9926ab02f1f834bb416dc76f65' '4ab80a2961c75562ffba=
c1f80de151a978c31659' '76deee29153b8313cc9629d3db45e56024b3dd26' 'd7f671b2f=
566379f275c13e25a29fa7001bb278f' 'a6ebabd0e53d4352abe0fd2ad156a52162f5d3ce'=
 '5a56323a54b7febcfe82cc5eda840a176647b7cd' '8e22ea5fb8498c52fcc20bbe2070c3=
aef1a3dff2' '1a90aae3b25b72e639da6062e0dc5efb9cff58f1' 'd59f0196e990e5a1bb4=
74eabf146f25cb8aea33d' '577f1cf76ceedb5fbdc9aca4f712b21864ac15ee' '31823f27=
f84bfa06be20f98ec9be63a671307d63' '9d6aacda3ad546048e02d83e5831e0b415382518=
' '297711ba0282abef38824b1e08c0ad6dcb6c4a53' 'c41da3a620e611b16b62a5cf93168=
caf01252fc4' '582057d2233a5a38e1aec3f4a6d66b362b42076c' 'f686a2b52e9d78cf40=
1f1b7f446bf0c3a81ebcc0' 'ba257e7006867ab1844a6449bdfa3b5aea94fe29' 'c841f99=
09b0d947ae7593040cc59646dc9f14455' '569922b82ca660f8b24e705f6cf674e6b1f99cc=
7' 'bcbf421d2190bc4f7d3fd2cc61caf748779ee69e' '5547e7ca122081d0603d2d7e0fe8=
1a7c551f1e11' 'bb2cc3014d74dfdab0b358b4539a9d2747598663' '3f0b8d367db5b0c0a=
0096b1c2ff02ec7c5c893b6' 'a308f9e47fc2377863f0f561ceedd45ccc7c7f9c' '8359ea=
9c119570fb5971379655661f77a3aafb1d' 'f60646d9c3bd5b390728ed1a1caa9ded53d47a=
fc' '484c997e03cec04da6f69c2c17e854b22aa0f98f' '7378aeb664e5ebc396950b36a1f=
2dedf5aabec20' 'e9d2a2f49244d9737f0ec33f4b7f3580faecd805' '5f7fb33b7ba1287c=
33e35b7778d5a371472e3503' '25cd677636d316669871947639430615ff564890' '7916a=
8d8782d4e53fe0133c8dace20a925e0204e' '2198deb823a6ebe110b737614421a4687d332=
7f4' 'cabd4ac290a6ceb87c8dbfb5a3251750e24529e7' '1684e8293605062dee45a5e411=
8fe8db6cd0d9d9' 'a4a7d86bc1a59839ad0dffbefa473135b342dd0b' '2e4d9f5111a3b3c=
24550e34710efa690c03b3ea1' '42c7af046aaf35c42ef864cbd96df025c48ce50f' '9b3c=
d5c7099fe7710356dd76ecf9910dc8c32548' '096c34ddf5835f02f5260719cd8a16fcf5e5=
e56f' '27cf57f65bea55d985f0ad0dc1737ce1d01f05dc' '37c95f022a7a34823c123eecc=
dfe415b88562867' 'f2b4fa19647e18a2e2aade7e3e4620567e7e594a' 'e6a9750a346b10=
3bd8ab2bf25be76a719d8061b2' 'dc9f2312acaee205609ad3c8b5f064e39eab1d6b' '378=
7255c967ba64dc72adc3038f0cb81211bd297' 'e39531352aed30156b270a61ba075e5b8d3=
b8498' '509544d1b6dbffe7bc1849593ff217f965ec0419' '36e7886075262429158aec6f=
258e6a5a92f025b1' '4a3aafe01f6c628932a402c21e58101173c8dab3' 'c14e85360969d=
7b0aaeab3915314787f3466c326' 'a8d77166fcfe1cd4be70c21d65ff2b27b4f54a26' '70=
7080d4fea8f6b8319ceead569f34c2be5bf1d5' '2c55f67c3a71cf57665294a02f258625c1=
da9385' '5a8b4785cddabfad348a96ca38eb0c3d735202df' 'b95cacd8d708bce5839db27=
67d425e20ae548fd8' '01981565c764c554cc96e2d30a71c42975171416' 'e03b0aa67ac0=
106d8961581a426649fabab50827' 'f161809b362f027b6d72bd998e47f8f0bad60a2e' 'b=
6308aaa24a7ad3dfc6157b6afc550b9ab7e8945' '7d08df5d0bd3d12d14dcec773fcddbe3e=
ed3a8e8' '54254727837440966c3381ea688df002ff14f269' '90e315a58fd903e43457fa=
085b6644e45c047e31' '678ccbf987969a6020fe95ecb4a2f568e7466821' '6baab135eb0=
0e85020abd0f13907a934b3df5c6b' '2378bd0b264ad3a1f76bd957caf33ee0c7945351' '=
9fbf78b6d6cecc2e9833c2f74eb2edc027c9b4cb' '136a78710f33e91e28ff4bd29e256ca2=
7f87631f' '9871e6af43db3892811f5a4ed0ed2e2d7cf6cf3c'
# bad: [e7bb221a638962d487231ac45a6699fb9bb8f9fa] Add linux-next specific f=
iles for 20250115
git bisect bad e7bb221a638962d487231ac45a6699fb9bb8f9fa
# bad: [7e6fed2078eadc4446fb3d6b31ee41e725009858] Merge branch 'for-next' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
git bisect bad 7e6fed2078eadc4446fb3d6b31ee41e725009858
# bad: [4b4d01ac54328462849bb9e3a27ec3b8f450b772] Merge branch 'for-next' o=
f git://github.com/Xilinx/linux-xlnx.git
git bisect bad 4b4d01ac54328462849bb9e3a27ec3b8f450b772
# bad: [198b52ae0bb80033a800d0f8495311c109000884] Merge branch 'for-next' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
git bisect bad 198b52ae0bb80033a800d0f8495311c109000884
# bad: [eec6da7e7e41200a5bc0cef53762faa3cfcb02a5] foo
git bisect bad eec6da7e7e41200a5bc0cef53762faa3cfcb02a5
# good: [a865446b3c9efc9118fd2abd80ad7a7f5d1623ad] foo
git bisect good a865446b3c9efc9118fd2abd80ad7a7f5d1623ad
# good: [2d1b22c49e939917c89f01aedeb7a4b804eb756c] minmax.h: add whitespace=
 around operators and after commas
git bisect good 2d1b22c49e939917c89f01aedeb7a4b804eb756c
# good: [cb953d97163d0d2cb3187df8c37e4f014fa8100d] selftests/mm: remove arg=
c and argv unused parameters
git bisect good cb953d97163d0d2cb3187df8c37e4f014fa8100d
# bad: [4c1b87a614cbb73e19747ce46b977ff6b54baacf] selftests/mm/cow: modify =
the incorrect checking parameters
git bisect bad 4c1b87a614cbb73e19747ce46b977ff6b54baacf
# bad: [c9c419c146abdc3d6ba43bf3061c26de61548a70] selftests/mm: Makefile: a=
dd the compiler flags
git bisect bad c9c419c146abdc3d6ba43bf3061c26de61548a70
# bad: [d1737c0c4885d418280710ef62afed4c76904c6d] selftests/mm: hugetlb-mad=
vise: fix type mismatch issues
git bisect bad d1737c0c4885d418280710ef62afed4c76904c6d
# bad: [a07b5ab38aadc6eb8807f28e9065217bb4b0aaa8] selftests/mm: kselftest_h=
arness: Fix warnings
git bisect bad a07b5ab38aadc6eb8807f28e9065217bb4b0aaa8
# good: [3b43278b91b4bafb48df42496f5456b0eed03275] selftests/mm: fix type m=
ismatch warnings
git bisect good 3b43278b91b4bafb48df42496f5456b0eed03275
# first bad commit: [a07b5ab38aadc6eb8807f28e9065217bb4b0aaa8] selftests/mm=
: kselftest_harness: Fix warnings

--ieY0mxb/Z4dE11Uk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeINIcACgkQJNaLcl1U
h9AaKwf9H2Ezipz44Y2Ahv2aN7yemXCTGyxf30WvhrvSG6TQx9VDzlT28unZm/vt
sacRWDW3O38ibUl7zaYXdHixDubsHJdRQBRZz36zxBVf9mxl7fhJGfyGi+Kloj6p
2JQCk9kZx0gdGLeiKfT7u+RI/gJp8KImlKxS5wl7FsFfcGDUt3LEksl+c7m14tmx
h+SYFvdaBHAukVdqEhYUKvDUYBD5B/wtX6m3jx4XTwE0Rxfe/9gGu/vXh7JiGGZB
fgiX+WS3EkYGDztJS6p3gH6SGCMTxX6st6vyzQa1+yfcuJIKzBcLTmC6Ydevz2S2
tU/HpGtUX/wqwVEkZRHq8qr1hRjc+g==
=gbvP
-----END PGP SIGNATURE-----

--ieY0mxb/Z4dE11Uk--

