Return-Path: <linux-kselftest+bounces-44651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 055E7C2CCB4
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 16:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CF164F8B3B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 15:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646AC30F52B;
	Mon,  3 Nov 2025 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVHnnPlW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD7A2E2665;
	Mon,  3 Nov 2025 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183482; cv=none; b=gt7/4n8nuamIkNgDz9jdhbVcB5PL0EDwQhIbLw0D20jvTX0BpLV2vpOLwylkX4qLjZ61ydDSJDEDicgyWSN7gwj9inwS0x9e5c0yg3WclFj3u1KN9586deImz6gw7PwyepuhjiG82nInmsCkBNfwnAGX22uGScErtbdsbeyObH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183482; c=relaxed/simple;
	bh=ERTab5426w7UT69sbyATXIKlIf/w637zeAtOZ9QJg5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0FqAOt9n9qbAO2Fssu5CkMB9YgojjuBFSH/Zg2ranZD8fAb2TFqE8dYQvIx6Y0PquWxwnKLzba2TIsOKptM+4iy5nyUrabZNawBWWrMlm6G4pXMycIml/fiaedm5Hg82yt6O10flE4npJhBgFhudlxcXOp6yDK1tx35PH6Rbiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVHnnPlW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C811C4CEFD;
	Mon,  3 Nov 2025 15:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762183481;
	bh=ERTab5426w7UT69sbyATXIKlIf/w637zeAtOZ9QJg5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nVHnnPlWcjfbZLiMgW8XKBA3vo3EC8DGd2MerZrHd2e1HmEq03fkqaklYpVXv4SGB
	 f58CMq1JqTYHhoA4aPHWifms5rqcCP6QwUHYmSUGtiQ1S7JJupWpokuuIzheYZX4kP
	 ilRagb8HcJs9BV5SJV8tlaKzHv7v5I5VxjobyfRFyPQ/tQaBZtA0/uovXDVcL4/ZFh
	 g+D4zxTLHhYQsKoBbMC8ilSWjas6DYbb0oA9OOWdmsDwmwMFlUluG/pZE2CJWzTQM3
	 emCv4XY32LI7OmUj3HkZJNOLi9pW0vPA3d2dKhyXGCGCfP6Zpmxl/bAZBjOyOdGpNs
	 vLL56lm1qBe5A==
Date: Mon, 3 Nov 2025 15:24:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Nick Alcock <nick.alcock@oracle.com>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Shuah Khan <shuah@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Russell King <linux@armlinux.org.uk>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
	Shannon Nelson <sln@onemain.com>, linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-s390@vger.kernel.org, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4 23/35] vdso/datastore: Map pages through struct page
Message-ID: <aQjJNmwniQwwjeBR@finisterre.sirena.org.uk>
References: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
 <20251014-vdso-sparc64-generic-2-v4-23-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RnS/s1JLwGUeEB7l"
Content-Disposition: inline
In-Reply-To: <20251014-vdso-sparc64-generic-2-v4-23-e0607bf49dea@linutronix.de>
X-Cookie: If you fail to plan, plan to fail.


--RnS/s1JLwGUeEB7l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 08:49:09AM +0200, Thomas Wei=DFschuh wrote:

> An upcoming change will allocate the datapages dynamically instead of as
> part of the kernel image. Such pages can only be mapped through
> 'struct page' and not through PFNs.

I'm seeing some boot failures on some arm64 platforms in -next which are
bisecting to this patch in -next.  Unfortunately the diagnostics aren't
super useful, we seem to just stop making progress in userspace with no
obvious output.  One sample log from the FVP is:

   https://lava.sirena.org.uk/scheduler/job/2036229#L1268

which isn't super instructive.  Not all platforms seem to be affected,
I've seen this on at least the Arm FVP, Orion O6 and Libretech Renegade
Elite.  The diagnostics aren't very clear here but given that I'm seeing
the same issue and bisect result on multiple platforms it seemed worth
mentioning.  Some platforms do seem fine.

We do have some other serious breakage affecting arm64 in -next which
are making it hard to get a clear picture of which platforms are
affected, at least the FVP and O6 are unaffected by those other issues
(due to using MTE on platforms that don't have it, those platforms do
have MTE).

bisect log:

# bad: [9823120909776bbca58a3c55ef1f27d49283c1f3] Add linux-next specific f=
iles for 20251103
# good: [3575af345aa2424636e69ac101a568bda249abe6] Merge branch 'i2c/i2c-ho=
st-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/lin=
ux.git
# good: [ed5d499b5c9cc11dd3edae1a7a55db7dfa4f1bdc] regcache: maple: Split -=
>populate() from ->init()
# good: [e73b743bfe8a6ff4e05b5657d3f7586a17ac3ba0] ASoC: soc-core: check op=
s & auto_selectable_formats in snd_soc_dai_get_fmt() to prevent dereference=
 error
# good: [ecd0de438c1f0ee86cf8f6d5047965a2a181444b] spi: tle62x0: Add newlin=
e to sysfs attribute output
# good: [6ef8e042cdcaabe3e3c68592ba8bfbaee2fa10a3] ASoC: codec: wm8400: rep=
lace printk() calls with dev_*() device aware logging
# good: [f1dfbc1b5cf8650ae9a0d543e5f5335fc0f478ce] ASoC: max98090/91: fixin=
g the stream index
# good: [20bcda681f8597e86070a4b3b12d1e4f541865d3] ASoC: codecs: va-macro: =
fix revision checking
# good: [cf6bf51b53252284bafc7377a4d8dbf10f048b4d] ASoC: cs4271: Add suppor=
t for the external mclk
# good: [8fdb030fe283c84fd8d378c97ad0f32d6cdec6ce] ASoC: qcom: sc7280: make=
 use of common helpers
# good: [28039efa4d8e8bbf98b066133a906bd4e307d496] MAINTAINERS: remove obso=
lete file entry in DIALOG SEMICONDUCTOR DRIVERS
# good: [e062bdfdd6adbb2dee7751d054c1d8df63ddb8b8] regmap: warn users about=
 uninitialized flat cache
# good: [66fecfa91deb536a12ddf3d878a99590d7900277] ASoC: spacemit: use `dep=
ends on` instead of `select`
# good: [f034c16a4663eaf3198dc18b201ba50533fb5b81] ASoC: spacemit: add fail=
ure check for spacemit_i2s_init_dai()
# good: [4a5ac6cd05a7e54f1585d7779464d6ed6272c134] ASoC: sun4i-spdif: Suppo=
rt SPDIF output on A523 family
# good: [4795375d8aa072e9aacb0b278e6203c6ca41816a] ASoC: cs-amp-lib-test: A=
dd test cases for cs_amp_set_efi_calibration_data()
# good: [ef042df96d0e1089764f39ede61bc8f140a4be00] ASoC: SDCA: Add HID butt=
on IRQ
# good: [e7434adf0c53a84d548226304cdb41c8818da1cb] ASoC: cs530x: Add SPI bu=
s support for cs530x parts
# good: [01313661b248c5ba586acae09bff57077dbec0a5] regulator: Let raspberry=
pi drivers depend on ARM
# good: [d29479abaded34b2b1dab2e17efe96a65eba3d61] ASoC: renesas: fsi: Cons=
tify struct fsi_stream_handler
# good: [4c33cef58965eb655a0ac8e243aa323581ec025f] regulator: pca9450: link=
 regulator inputs to supply groups
# good: [e973dfe9259095fb509ab12658c68d46f0e439d7] ASoC: qcom: sm8250: add =
qrb2210-sndcard compatible string
# good: [77a58ba7c64ccca20616aa03599766ccb0d1a330] spi: spi-mem: Trace exec=
_op
# good: [c17fa4cbc546c431ccf13e9354d5d9c1cd247b7c] ASoC: sdw_utils: add nam=
e_prefix for rt1321 part id
# good: [310bf433c01f78e0756fd5056a43118a2f77318c] ASoC: max98090/91: fixin=
g a space
# good: [2528c15f314ece50218d1273654f630d74109583] ASoC: max98090/91: addin=
g DAPM routing for digital output for max98091
# good: [d054cc3a2ccfb19484f3b54d69b6e416832dc8f4] regulator: rpmh-regulato=
r: Add RPMH regulator support for PMR735D
# good: [fd5ef3d69f8975bad16c437a337b5cb04c8217a2] spi: spi-qpic-snand: mak=
e qcom_spi_ecc_engine_ops_pipelined const
# good: [638bae3fb225a708dc67db613af62f6d14c4eff4] ASoC: max98090/91: added=
 DAPM widget for digital output for max98091
# good: [ecba655bf54a661ffe078856cd8dbc898270e4b5] ASoC: fsl_aud2htx: add I=
EC958_SUBFRAME_LE format in supported list
# good: [7e1906643a7374529af74b013bba35e4fa4e6ffc] ASoC: codecs: va-macro: =
Clean up on error path in probe()
# good: [d742ebcfe524dc54023f7c520d2ed2e4b7203c19] ASoC: soc.h: remove snd_=
soc_kcontrol_component()
# good: [fce217449075d59b29052b8cdac567f0f3e22641] ASoC: spacemit: add i2s =
support for K1 SoC
# good: [6658472a3e2de08197acfe099ba71ee0e2505ecf] ASoC: amd: amd_sdw: Prop=
agate the PCI subsystem Vendor and Device IDs
# good: [0cc08c8130ac8f74419f99fe707dc193b7f79d86] spi: aspeed: Fix an IS_E=
RR() vs NULL bug in probe()
# good: [0743acf746a81e0460a56fd5ff847d97fa7eb370] spi: airoha: buffer must=
 be 0xff-ed before writing
# good: [d77daa49085b067137d0adbe3263f75a7ee13a1b] spi: aspeed: fix spellin=
g mistake "triming" -> "trimming"
# good: [1e570e77392f43a3cdab2849d1f81535f8a033e2] ASoC: mxs-saif: support =
usage with simple-audio-card
# good: [15afe57a874eaf104bfbb61ec598fa31627f7b19] ASoC: dt-bindings: qcom:=
 Add Kaanapali LPASS macro codecs
# good: [65efe5404d151767653c7b7dd39bd2e7ad532c2d] regulator: rpmh-regulato=
r: Add RPMH regulator support for Glymur
# good: [fb25114cd760c13cf177d9ac37837fafcc9657b5] regulator: sy7636a: add =
gpios and input regulator
# good: [6621b0f118d500092f5f3d72ddddb22aeeb3c3a0] ASoC: codecs: rt5670: us=
e SOC_VALUE_ENUM_SINGLE_DECL for DAC2 L/R MX-1B
# good: [0b0eb7702a9fa410755e86124b4b7cd36e7d1cb4] ASoC: replace use of sys=
tem_wq with system_dfl_wq
# good: [433e294c3c5b5d2020085a0e36c1cb47b694690a] regulator: core: forward=
 undervoltage events downstream by default
# good: [7e7e2c6e2a1cb250f8d03bb99eed01f6d982d5dd] ASoC: sof-function-topol=
ogy-lib: escalate the log when missing function topoplogy
# good: [6277a486a7faaa6c87f4bf1d59a2de233a093248] regulator: dt-bindings: =
Convert Dialog DA9211 Regulators to DT schema
# good: [64d87ccfae3326a9561fe41dc6073064a083e0df] spi: aspeed: Only map ne=
cessary address window region
# good: [4412ab501677606436e5c49e41151a1e6eac7ac0] spi: dt-bindings: spi-qp=
ic-snand: Add IPQ5332 compatible
# good: [5e537031f322d55315cd384398b726a9a0748d47] ASoC: codecs: Fix the er=
ror of excessive semicolons
# good: [4d410ba9aa275e7990a270f63ce436990ace1bea] dt-bindings: sound: Upda=
te ADMAIF bindings for tegra264
# good: [fe8cc44dd173cde5788ab4e3730ac61f3d316d9c] spi: dw: add target mode=
 support
# good: [b83fb1b14c06bdd765903ac852ba20a14e24f227] spi: offload: Add offset=
 parameter
# good: [9797329220a2c6622411eb9ecf6a35b24ce09d04] ASoC: sof-function-topol=
ogy-lib: escalate the log when missing function topoplogy
git bisect start '9823120909776bbca58a3c55ef1f27d49283c1f3' '3575af345aa242=
4636e69ac101a568bda249abe6' 'ed5d499b5c9cc11dd3edae1a7a55db7dfa4f1bdc' 'e73=
b743bfe8a6ff4e05b5657d3f7586a17ac3ba0' 'ecd0de438c1f0ee86cf8f6d5047965a2a18=
1444b' '6ef8e042cdcaabe3e3c68592ba8bfbaee2fa10a3' 'f1dfbc1b5cf8650ae9a0d543=
e5f5335fc0f478ce' '20bcda681f8597e86070a4b3b12d1e4f541865d3' 'cf6bf51b53252=
284bafc7377a4d8dbf10f048b4d' '8fdb030fe283c84fd8d378c97ad0f32d6cdec6ce' '28=
039efa4d8e8bbf98b066133a906bd4e307d496' 'e062bdfdd6adbb2dee7751d054c1d8df63=
ddb8b8' '66fecfa91deb536a12ddf3d878a99590d7900277' 'f034c16a4663eaf3198dc18=
b201ba50533fb5b81' '4a5ac6cd05a7e54f1585d7779464d6ed6272c134' '4795375d8aa0=
72e9aacb0b278e6203c6ca41816a' 'ef042df96d0e1089764f39ede61bc8f140a4be00' 'e=
7434adf0c53a84d548226304cdb41c8818da1cb' '01313661b248c5ba586acae09bff57077=
dbec0a5' 'd29479abaded34b2b1dab2e17efe96a65eba3d61' '4c33cef58965eb655a0ac8=
e243aa323581ec025f' 'e973dfe9259095fb509ab12658c68d46f0e439d7' '77a58ba7c64=
ccca20616aa03599766ccb0d1a330' 'c17fa4cbc546c431ccf13e9354d5d9c1cd247b7c' '=
310bf433c01f78e0756fd5056a43118a2f77318c' '2528c15f314ece50218d1273654f630d=
74109583' 'd054cc3a2ccfb19484f3b54d69b6e416832dc8f4' 'fd5ef3d69f8975bad16c4=
37a337b5cb04c8217a2' '638bae3fb225a708dc67db613af62f6d14c4eff4' 'ecba655bf5=
4a661ffe078856cd8dbc898270e4b5' '7e1906643a7374529af74b013bba35e4fa4e6ffc' =
'd742ebcfe524dc54023f7c520d2ed2e4b7203c19' 'fce217449075d59b29052b8cdac567f=
0f3e22641' '6658472a3e2de08197acfe099ba71ee0e2505ecf' '0cc08c8130ac8f74419f=
99fe707dc193b7f79d86' '0743acf746a81e0460a56fd5ff847d97fa7eb370' 'd77daa490=
85b067137d0adbe3263f75a7ee13a1b' '1e570e77392f43a3cdab2849d1f81535f8a033e2'=
 '15afe57a874eaf104bfbb61ec598fa31627f7b19' '65efe5404d151767653c7b7dd39bd2=
e7ad532c2d' 'fb25114cd760c13cf177d9ac37837fafcc9657b5' '6621b0f118d500092f5=
f3d72ddddb22aeeb3c3a0' '0b0eb7702a9fa410755e86124b4b7cd36e7d1cb4' '433e294c=
3c5b5d2020085a0e36c1cb47b694690a' '7e7e2c6e2a1cb250f8d03bb99eed01f6d982d5dd=
' '6277a486a7faaa6c87f4bf1d59a2de233a093248' '64d87ccfae3326a9561fe41dc6073=
064a083e0df' '4412ab501677606436e5c49e41151a1e6eac7ac0' '5e537031f322d55315=
cd384398b726a9a0748d47' '4d410ba9aa275e7990a270f63ce436990ace1bea' 'fe8cc44=
dd173cde5788ab4e3730ac61f3d316d9c' 'b83fb1b14c06bdd765903ac852ba20a14e24f22=
7' '9797329220a2c6622411eb9ecf6a35b24ce09d04'
# test job: [ed5d499b5c9cc11dd3edae1a7a55db7dfa4f1bdc] https://lava.sirena.=
org.uk/scheduler/job/2029024
# test job: [e73b743bfe8a6ff4e05b5657d3f7586a17ac3ba0] https://lava.sirena.=
org.uk/scheduler/job/2026405
# test job: [ecd0de438c1f0ee86cf8f6d5047965a2a181444b] https://lava.sirena.=
org.uk/scheduler/job/2026139
# test job: [6ef8e042cdcaabe3e3c68592ba8bfbaee2fa10a3] https://lava.sirena.=
org.uk/scheduler/job/2025827
# test job: [f1dfbc1b5cf8650ae9a0d543e5f5335fc0f478ce] https://lava.sirena.=
org.uk/scheduler/job/2025495
# test job: [20bcda681f8597e86070a4b3b12d1e4f541865d3] https://lava.sirena.=
org.uk/scheduler/job/2023002
# test job: [cf6bf51b53252284bafc7377a4d8dbf10f048b4d] https://lava.sirena.=
org.uk/scheduler/job/2023010
# test job: [8fdb030fe283c84fd8d378c97ad0f32d6cdec6ce] https://lava.sirena.=
org.uk/scheduler/job/2021423
# test job: [28039efa4d8e8bbf98b066133a906bd4e307d496] https://lava.sirena.=
org.uk/scheduler/job/2020312
# test job: [e062bdfdd6adbb2dee7751d054c1d8df63ddb8b8] https://lava.sirena.=
org.uk/scheduler/job/2020146
# test job: [66fecfa91deb536a12ddf3d878a99590d7900277] https://lava.sirena.=
org.uk/scheduler/job/2015355
# test job: [f034c16a4663eaf3198dc18b201ba50533fb5b81] https://lava.sirena.=
org.uk/scheduler/job/2015401
# test job: [4a5ac6cd05a7e54f1585d7779464d6ed6272c134] https://lava.sirena.=
org.uk/scheduler/job/2011275
# test job: [4795375d8aa072e9aacb0b278e6203c6ca41816a] https://lava.sirena.=
org.uk/scheduler/job/2009637
# test job: [ef042df96d0e1089764f39ede61bc8f140a4be00] https://lava.sirena.=
org.uk/scheduler/job/2010189
# test job: [e7434adf0c53a84d548226304cdb41c8818da1cb] https://lava.sirena.=
org.uk/scheduler/job/2007769
# test job: [01313661b248c5ba586acae09bff57077dbec0a5] https://lava.sirena.=
org.uk/scheduler/job/2008804
# test job: [d29479abaded34b2b1dab2e17efe96a65eba3d61] https://lava.sirena.=
org.uk/scheduler/job/2008456
# test job: [4c33cef58965eb655a0ac8e243aa323581ec025f] https://lava.sirena.=
org.uk/scheduler/job/2009446
# test job: [e973dfe9259095fb509ab12658c68d46f0e439d7] https://lava.sirena.=
org.uk/scheduler/job/2008154
# test job: [77a58ba7c64ccca20616aa03599766ccb0d1a330] https://lava.sirena.=
org.uk/scheduler/job/2007294
# test job: [c17fa4cbc546c431ccf13e9354d5d9c1cd247b7c] https://lava.sirena.=
org.uk/scheduler/job/2000033
# test job: [310bf433c01f78e0756fd5056a43118a2f77318c] https://lava.sirena.=
org.uk/scheduler/job/1996006
# test job: [2528c15f314ece50218d1273654f630d74109583] https://lava.sirena.=
org.uk/scheduler/job/1997609
# test job: [d054cc3a2ccfb19484f3b54d69b6e416832dc8f4] https://lava.sirena.=
org.uk/scheduler/job/1995710
# test job: [fd5ef3d69f8975bad16c437a337b5cb04c8217a2] https://lava.sirena.=
org.uk/scheduler/job/1996160
# test job: [638bae3fb225a708dc67db613af62f6d14c4eff4] https://lava.sirena.=
org.uk/scheduler/job/1991858
# test job: [ecba655bf54a661ffe078856cd8dbc898270e4b5] https://lava.sirena.=
org.uk/scheduler/job/1985138
# test job: [7e1906643a7374529af74b013bba35e4fa4e6ffc] https://lava.sirena.=
org.uk/scheduler/job/1978644
# test job: [d742ebcfe524dc54023f7c520d2ed2e4b7203c19] https://lava.sirena.=
org.uk/scheduler/job/1975972
# test job: [fce217449075d59b29052b8cdac567f0f3e22641] https://lava.sirena.=
org.uk/scheduler/job/1975665
# test job: [6658472a3e2de08197acfe099ba71ee0e2505ecf] https://lava.sirena.=
org.uk/scheduler/job/1975550
# test job: [0cc08c8130ac8f74419f99fe707dc193b7f79d86] https://lava.sirena.=
org.uk/scheduler/job/1965723
# test job: [0743acf746a81e0460a56fd5ff847d97fa7eb370] https://lava.sirena.=
org.uk/scheduler/job/1964844
# test job: [d77daa49085b067137d0adbe3263f75a7ee13a1b] https://lava.sirena.=
org.uk/scheduler/job/1962817
# test job: [1e570e77392f43a3cdab2849d1f81535f8a033e2] https://lava.sirena.=
org.uk/scheduler/job/1962293
# test job: [15afe57a874eaf104bfbb61ec598fa31627f7b19] https://lava.sirena.=
org.uk/scheduler/job/1962946
# test job: [65efe5404d151767653c7b7dd39bd2e7ad532c2d] https://lava.sirena.=
org.uk/scheduler/job/1959944
# test job: [fb25114cd760c13cf177d9ac37837fafcc9657b5] https://lava.sirena.=
org.uk/scheduler/job/1960141
# test job: [6621b0f118d500092f5f3d72ddddb22aeeb3c3a0] https://lava.sirena.=
org.uk/scheduler/job/1959728
# test job: [0b0eb7702a9fa410755e86124b4b7cd36e7d1cb4] https://lava.sirena.=
org.uk/scheduler/job/1957410
# test job: [433e294c3c5b5d2020085a0e36c1cb47b694690a] https://lava.sirena.=
org.uk/scheduler/job/1957405
# test job: [7e7e2c6e2a1cb250f8d03bb99eed01f6d982d5dd] https://lava.sirena.=
org.uk/scheduler/job/1954272
# test job: [6277a486a7faaa6c87f4bf1d59a2de233a093248] https://lava.sirena.=
org.uk/scheduler/job/1947019
# test job: [64d87ccfae3326a9561fe41dc6073064a083e0df] https://lava.sirena.=
org.uk/scheduler/job/1947206
# test job: [4412ab501677606436e5c49e41151a1e6eac7ac0] https://lava.sirena.=
org.uk/scheduler/job/1946280
# test job: [5e537031f322d55315cd384398b726a9a0748d47] https://lava.sirena.=
org.uk/scheduler/job/1946649
# test job: [4d410ba9aa275e7990a270f63ce436990ace1bea] https://lava.sirena.=
org.uk/scheduler/job/1947851
# test job: [fe8cc44dd173cde5788ab4e3730ac61f3d316d9c] https://lava.sirena.=
org.uk/scheduler/job/1947062
# test job: [b83fb1b14c06bdd765903ac852ba20a14e24f227] https://lava.sirena.=
org.uk/scheduler/job/1946842
# test job: [9797329220a2c6622411eb9ecf6a35b24ce09d04] https://lava.sirena.=
org.uk/scheduler/job/1947376
# test job: [9823120909776bbca58a3c55ef1f27d49283c1f3] https://lava.sirena.=
org.uk/scheduler/job/2036229
# bad: [9823120909776bbca58a3c55ef1f27d49283c1f3] Add linux-next specific f=
iles for 20251103
git bisect bad 9823120909776bbca58a3c55ef1f27d49283c1f3
# test job: [32db2b6bea82a3565aac82569f0a5dd3f808b1c9] https://lava.sirena.=
org.uk/scheduler/job/2036846
# good: [32db2b6bea82a3565aac82569f0a5dd3f808b1c9] Merge branch 'nand/next'=
 of https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
git bisect good 32db2b6bea82a3565aac82569f0a5dd3f808b1c9
# test job: [b6ee14cdb3b42da9d2c3773014abca821e5bd6b6] https://lava.sirena.=
org.uk/scheduler/job/2036933
# good: [b6ee14cdb3b42da9d2c3773014abca821e5bd6b6] Merge branch 'for-next' =
of https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux
git bisect good b6ee14cdb3b42da9d2c3773014abca821e5bd6b6
# test job: [4bf8b41b640db6006ae9415262fac145590f69e3] https://lava.sirena.=
org.uk/scheduler/job/2036996
# bad: [4bf8b41b640db6006ae9415262fac145590f69e3] Merge branch 'driver-core=
-next' of https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/drive=
r-core.git
git bisect bad 4bf8b41b640db6006ae9415262fac145590f69e3
# test job: [3eaa2454f5701a95dd0e7d080b3afd60b1e83ffa] https://lava.sirena.=
org.uk/scheduler/job/2037194
# bad: [3eaa2454f5701a95dd0e7d080b3afd60b1e83ffa] Merge branch into tip/mas=
ter: 'timers/vdso'
git bisect bad 3eaa2454f5701a95dd0e7d080b3afd60b1e83ffa
# test job: [10eaf0467388d7cd57b7bd6075c3c5716e204184] https://lava.sirena.=
org.uk/scheduler/job/2037413
# good: [10eaf0467388d7cd57b7bd6075c3c5716e204184] Merge branch into tip/ma=
ster: 'objtool/core'
git bisect good 10eaf0467388d7cd57b7bd6075c3c5716e204184
# test job: [973d20365abff9f24919deb015b12ef76aed0ff8] https://lava.sirena.=
org.uk/scheduler/job/2037436
# good: [973d20365abff9f24919deb015b12ef76aed0ff8] Merge branch into tip/ma=
ster: 'x86/entry'
git bisect good 973d20365abff9f24919deb015b12ef76aed0ff8
# test job: [184372e1d10789d8730971070630ba5a10c9be34] https://lava.sirena.=
org.uk/scheduler/job/2037468
# bad: [184372e1d10789d8730971070630ba5a10c9be34] sparc64: vdso: Implement =
clock_gettime64()
git bisect bad 184372e1d10789d8730971070630ba5a10c9be34
# test job: [189163e207c49196e52e86737dc3048f37a8eee9] https://lava.sirena.=
org.uk/scheduler/job/2037700
# good: [189163e207c49196e52e86737dc3048f37a8eee9] random: vDSO: Remove ifd=
effery
git bisect good 189163e207c49196e52e86737dc3048f37a8eee9
# test job: [1280e8b97d703a686eb2270c5723f2d44e99252e] https://lava.sirena.=
org.uk/scheduler/job/2037739
# bad: [1280e8b97d703a686eb2270c5723f2d44e99252e] sparc64: vdso: Link with =
-z noexecstack
git bisect bad 1280e8b97d703a686eb2270c5723f2d44e99252e
# test job: [5fd2a3424ce51df60deade50d5057177439c62b5] https://lava.sirena.=
org.uk/scheduler/job/2038036
# good: [5fd2a3424ce51df60deade50d5057177439c62b5] vdso/datastore: Reduce s=
cope of some variables in vvar_fault()
git bisect good 5fd2a3424ce51df60deade50d5057177439c62b5
# test job: [6a011a22829362bfee8ff9fc1212f803c18af5f2] https://lava.sirena.=
org.uk/scheduler/job/2038079
# bad: [6a011a22829362bfee8ff9fc1212f803c18af5f2] vdso/datastore: Map pages=
 through struct page
git bisect bad 6a011a22829362bfee8ff9fc1212f803c18af5f2
# test job: [8ebb65c38828760ed028f637850d4b4c62655993] https://lava.sirena.=
org.uk/scheduler/job/2038136
# good: [8ebb65c38828760ed028f637850d4b4c62655993] vdso/datastore: Drop inc=
lusion of linux/mmap_lock.h
git bisect good 8ebb65c38828760ed028f637850d4b4c62655993
# first bad commit: [6a011a22829362bfee8ff9fc1212f803c18af5f2] vdso/datasto=
re: Map pages through struct page

--RnS/s1JLwGUeEB7l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkIySkACgkQJNaLcl1U
h9Dykgf+LB8fzcSU0f/ec57pHXyy2s964jvkol8e+OrYlOda+iUs3F10LD/gCFuj
8saokN0lHhGscf7Y0E/Gj8FN7vnxSM/9OHiI7LPWKXaAA+cbD664enqVYqB20NC9
dVT6NXW95+hhFRPw5uF62CjwjxTraOFwGd/Jw5lqaxsnwQB/PiqFPAQq/BlIPJGo
rWnGjbikaMB8W8VEApnqWJCrZk0tSXCKXbyc4qSgAO9GNpk/zICxmZDEYDjAJqZt
tD2Hh564sX5RIGNC1sae1Gl9LypfBJogssCYXtSwHvgmuV1/fKcAn4Gan/8Uo4ln
fMHrZ9E4uvwvbvIRCHX5KokQWG8e1g==
=OGOf
-----END PGP SIGNATURE-----

--RnS/s1JLwGUeEB7l--

