Return-Path: <linux-kselftest+bounces-18992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC24698FAFF
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 01:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19203B22B17
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 23:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0221D1743;
	Thu,  3 Oct 2024 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5/19+JC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689E81D07B5;
	Thu,  3 Oct 2024 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999203; cv=none; b=LU2PAKJddXrTex3XWi0Ovw9ukpmkW64RJCrp75oVfp/MGYNfTKecCAh31KmxbVE/kDlj9hipLYGVQ5ibNFB6JoMMfd1sGOo39ffkzaeNSwH31b1gEDW5vOM4zSjWoQM8eeCPVvg/DHLVDQWfCxsdzJwJjE3DIm9S8GGi2YEkgXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999203; c=relaxed/simple;
	bh=d87RLPsqMRDHm/5vfS1K/yGBaUfYR1Kog9kelwLBOdY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=MrAD9A3q0EOzhRdDxpsLNf96jE6iEhByWkKDBXgULewFUD45BF0LRBTnEHDwZy1TCmvy+PFK+gI0l7ENBK/XYhT9O4s7eJCvYsr/cLSVge0QJvPf+BjkyxTG8Z5lTi+4215c+/IGhH04ZTMf7uXAVKNTUsTQmnB4pxIyYEsN0c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5/19+JC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8913C4CEC5;
	Thu,  3 Oct 2024 23:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727999203;
	bh=d87RLPsqMRDHm/5vfS1K/yGBaUfYR1Kog9kelwLBOdY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=F5/19+JCZah2NSLpQZhUQKdl4Pt0gLFrrpcxQ0Dla+wSNiw0wawlki9X3g/Idypyy
	 qYKCXSIAxvzSc5DyaLorD4OPtCtF9ZQXuq943etotmLYgRbGGwbu7mPtA7zeE2NveO
	 h4GHghokJ8A4kx6I80UV9HttQUmq9eFq3r0VjOPaIuFcn2hWW2XyLHk/rwr34Nr4ZT
	 yhaZWgNws0V85RoJa1hC1jOJCVyJdCvphFgsa2WWhitUlHZ9tBqC3l6R9pks9lNyXG
	 Ub71agYtEk82GIP4knWK4ChTjRDh9WLYyqsWi2UmiHUo9AQz+orDSs4oIH99ZbnHjF
	 r2GGfQhxyVfCw==
Message-ID: <4a8abb5f501279de7907629f4dd6be24.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f5f1c42d-77c0-48c7-ac52-3d4a3b5c2b47@roeck-us.net>
References: <20240718210513.3801024-1-sboyd@kernel.org> <6cd337fb-38f0-41cb-b942-5844b84433db@roeck-us.net> <a339ec8c-38f6-425a-94d1-ad69b5ddbd88@roeck-us.net> <dcd8894f-1eb6-4b5c-9e6f-f6e584c601d2@roeck-us.net> <6f5a5b5f-71a7-4ed3-8cb3-d930bbce599b@linuxfoundation.org> <ba88a29c-f05e-4ca3-82d1-0a634613caee@roeck-us.net> <4216b852-11a2-41ae-bb01-5f9b578ee41b@roeck-us.net> <879831a8-2039-4cdb-bce2-aefdeb7ab25f@linuxfoundation.org> <da260b77-2ecb-4486-90cb-6db456d381ef@linuxfoundation.org> <f5f1c42d-77c0-48c7-ac52-3d4a3b5c2b47@roeck-us.net>
Subject: Re: [PATCH v8 8/8] clk: Add KUnit tests for clks registered with struct clk_parent_data
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>, Geert Uytterhoeven <geert+renesas@glider.be>
To: Guenter Roeck <linux@roeck-us.net>, Shuah Khan <skhan@linuxfoundation.org>
Date: Thu, 03 Oct 2024 16:46:40 -0700
User-Agent: alot/0.10

Quoting Guenter Roeck (2024-09-28 14:32:35)
> On 9/28/24 12:27, Shuah Khan wrote:
> > On 9/28/24 11:54, Shuah Khan wrote:
> >> On 9/28/24 11:31, Guenter Roeck wrote:
> >>> On 9/27/24 17:08, Guenter Roeck wrote:
> >>>> On 9/27/24 13:45, Shuah Khan wrote:
> >>>>> On 9/27/24 10:19, Guenter Roeck wrote:
> >>>>>> Copying devicetree maintainers.
> >>>>>>
> >>>>>> On Thu, Sep 26, 2024 at 09:39:38PM -0700, Guenter Roeck wrote:
> >>>>>>> On Thu, Sep 26, 2024 at 09:14:11PM -0700, Guenter Roeck wrote:
> >>>>>>>> Hi Stephen,
> >>>>>>>>
> >>>>>>>> On Thu, Jul 18, 2024 at 02:05:07PM -0700, Stephen Boyd wrote:
> >>>>>>>>> Test that clks registered with 'struct clk_parent_data' work as
> >>>>>>>>> intended and can find their parents.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> When testing this on arm64, I see the error below. The error is =
only
> >>>>>>>> seen if I boot through efi, i.e., with "-bios QEMU_EFI-aarch64.f=
d"
> >>>>>>>> qemu parameter.
> >>>>>>>>
> >>>>>>>> Any idea what might cause the problem ?
> >>>>>>>>
> >>>>>>> I noticed that the new overlay tests fail as well, also with "pat=
h '/' not
> >>>>>>> found".
> >>>>>>>
> >>>>>>> [Maybe] answering my own question: I think the problem may be tha=
t there
> >>>>>>> is no devicetree file and thus no devicetree root when booting th=
rough
> >>>>>>> efi (in other words, of_root is NULL). Would it make sense to ski=
p the
> >>>>>>> tests in that case ?
> >>>>>>>
> >>>>>>
> >>>>>> The problem is that of_root is not initialized in arm64 boots if A=
CPI
> >>>>>> is enabled.
> >>>>>>
> >>>>>> =C2=A0From arch/arm64/kernel/setup.c:setup_arch():
> >>>>>>
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0if (acpi_disabled)
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unflatten_device_tree()=
;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // initializes of_root

Oof I forgot that Rob didn't apply the patch that let an empty root live
on ARM64 ACPI systems. See this thread[1] for all the details.

> >>>>>>
> >>>>>> ACPI is enabled if the system boots from EFI. This also affects
> >>>>>> CONFIG_OF_KUNIT_TEST, which explicitly checks if of_root exists and
> >>>>>> fails the test if it doesn't.
> >>>>>>
> >>>>>> I think those tests need to add a check for this condition, or aff=
ected
> >>>>>> machines won't be able to run those unit tests. The obvious soluti=
on would
> >>>>>> be to check if of_root is set, but then the associated test case in
> >>>>>> CONFIG_OF_KUNIT_TEST would not make sense.
> >>>>>>
> >>>>>> Any suggestions ?
> >>>>>>

I think that's the best we can do for now. Basically add a check like

	if (IS_ENABLED(CONFIG_ARM64) && acpi_disabled)
		kunit_skip(test, "ARM64 + ACPI rejects DT overlays");

to the overlay application function and the DT test.

> >>>>>
> >>>>> Would it work if these tests check if acpi_disabled and skip if it =
isn't
> >>>>> disabled? It might be low overhead condition to check from these te=
sts.
> >>>>>
> >>>>> acpi_disabled is exported:
> >>>>>
> >>>>> arch/arm64/kernel/acpi.c:EXPORT_SYMBOL(acpi_disabled);
> >>>>> arch/loongarch/kernel/acpi.c:EXPORT_SYMBOL(acpi_disabled);
> >>>>> arch/riscv/kernel/acpi.c:EXPORT_SYMBOL(acpi_disabled);
> >>>>> arch/x86/kernel/acpi/boot.c:EXPORT_SYMBOL(acpi_disabled);
> >>>>>
> >>>>
> >>>> I don't think that would work. Looking through the use of acpi_init,
> >>>> I don't think that of_root is always NULL when acpi_init is false; t=
hat
> >>>> just happens to be the case on arm64 when booting through efi.
> >>>> However, even arm64 has the following code.
> >>>>
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (acpi_disabled)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 psci_dt_init();
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 psci_acpi_init();
> >>>>
> >>>> While psci_dt_init() doesn't set of_root, it does try to do a device=
tree
> >>>> match. So there must be some other condition where acpi_disabled is =
set
> >>>> but of_root is set anyway. I just have not found that code path.
> >>>>
> >>>
> >>> I ended up disabling all affected unit tests for arm64. I'll do the s=
ame
> >>> for other architectures if I encounter the problem there as well.
> >>>
> >>> Unfortunately that includes all clock unit tests because the tests re=
quiring
> >>> devicetree support can not be enabled/disabled separately, but that c=
an't be
> >>> helped and is still better than "mandatory" failures.
> >>>
> >>
> >=20
> > of_root is set in drivers/of/pdt.c when it creates the root node.
> > This could be a definitive test for kunit tests that depend on
> > devicetree support.
> >=20
>=20
> That is not always the case, including arm64. It is primarily set in
> unflatten_devicetree(), which is not called on arm64 unless acpi_is disab=
led
> (see above).

>=20
> > It is an exported symbol. drivers/of/base.c exports it.
> >=20
>=20
> Yes, checking if of_root is NULL and skipping the test in that case might=
 help,
> but then there is the of_dtb_root_node_populates_of_root unit test which
> explicitly fails if of_root is NULL. The comment describing the test is
>=20
> /*
>   * Test that the 'of_root' global variable is always populated when DT c=
ode is
>   * enabled. Remove this test once of_root is removed from global access.
>   */
>=20
> The devicetree unit test code explicitly assumes that of_root is set if
> CONFIG_OF_EARLY_FLATTREE is enabled, but that is not always the case
> (again, of_root is NULL on arm64 unless acpi is disabled).
>=20

That DT test has been there for a few releases. Is this the first time
those tests have been run on arm64+acpi? I didn't try after sending the
patches and forgot that the patch was dropped.

How are you running kunit tests? I installed the qemu-efi-aarch64 debian
package to get QEMU_EFI.fd but passing that to the kunit.py run command
with --qemu_args=3D"-bios /usr/share/qemu-efi-aarch64/QEMU_EFI.fd" didn't
get me beyond the point that the EFI stub boots linux. I think the
serial console must not be working and thus the kunit wrapper waits for
something to show up but nothing ever does. I haven't dug any further
though, so maybe you have a working command.

Here's my command that isn't working:

./tools/testing/kunit/kunit.py run --arch=3Darm64 --kunitconfig=3Ddrivers/o=
f --qemu_args=3D"-bios /usr/share/qemu-efi-aarch64/QEMU_EFI.fd"=09

[1] https://lore.kernel.org/all/20240217010557.2381548-6-sboyd@kernel.org/

