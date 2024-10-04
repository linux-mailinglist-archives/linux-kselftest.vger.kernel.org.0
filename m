Return-Path: <linux-kselftest+bounces-18998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D4F98FBAE
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 02:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82941F22598
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 00:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6960A17FE;
	Fri,  4 Oct 2024 00:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7V3NzlS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3680111CBD;
	Fri,  4 Oct 2024 00:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728002577; cv=none; b=Ov+WZ6EOJI4bXxIiOMvla0OzxeTFbRrW6DZ/Q6LblkqS9nwRgEOLtYwVhh7TTFLeIwkYjPmRcb7V+bPrQ/etI3lqd4LDRsBPwjYcf0w2XcRKyP6rHT+0Q/01gqz7hl8IFawPjQIWexJIjtOC4XLMVy/ai1nyMLHSrQcmKn8TGQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728002577; c=relaxed/simple;
	bh=kMMo9BAc0r9Ly2hSQLr4fnwD0fAa39h+ExMmstruj/Q=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=euABGkFCdrX55Yir6vm2LB/IDmJBssUVbWwALg7NZvaOkcWbkyXXojoEIAduiRf48uG0ZQlS/QBW1fWpm+o4H1+pyuu1mG5V7aZSDHE1QUIPD3mYN2SnnGB00A5hSQXMetJFSZI9dRzx9SzeesQ9gCvF5tDnRVc2AyspgznNbjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7V3NzlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943E4C4CEC7;
	Fri,  4 Oct 2024 00:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728002576;
	bh=kMMo9BAc0r9Ly2hSQLr4fnwD0fAa39h+ExMmstruj/Q=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=e7V3NzlSubY7reZLd5JUnQsOasf7lH26uNnmDfrfJagQCqYL4qr11fwPJVsi7HNpi
	 QgZOm+6DPsGITx3dheRWzcPgD8niD3La1DnxQSiFeUWxz0cMKfojzlKFzJePWSAKNw
	 9eFb5q25wS4KmlRqZtuCWDL4CWjJlXUUAlbalZPI6xV+Gpy5cV+aqNQcQ8xAN3ccb4
	 pGtuMR9+Zjd/8YZoItg0yoiqLQt7Gd9V+lQywlZ523pD1+hnEfp6A7Y9OasEg8mCsY
	 w0V2XNgp/oGC0YT07gWFxj4lRjzm+S99bXSplJi5fnIp+OsH6qW9gx3K+EtgWJyGBE
	 btQwmPJSnWLKw==
Message-ID: <cd31493888acc2b64a4986954dfa43ae.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3e1de608-008c-4439-acd2-647a288dcdc0@roeck-us.net>
References: <20240718210513.3801024-1-sboyd@kernel.org> <dcd8894f-1eb6-4b5c-9e6f-f6e584c601d2@roeck-us.net> <6f5a5b5f-71a7-4ed3-8cb3-d930bbce599b@linuxfoundation.org> <ba88a29c-f05e-4ca3-82d1-0a634613caee@roeck-us.net> <4216b852-11a2-41ae-bb01-5f9b578ee41b@roeck-us.net> <879831a8-2039-4cdb-bce2-aefdeb7ab25f@linuxfoundation.org> <da260b77-2ecb-4486-90cb-6db456d381ef@linuxfoundation.org> <f5f1c42d-77c0-48c7-ac52-3d4a3b5c2b47@roeck-us.net> <4a8abb5f501279de7907629f4dd6be24.sboyd@kernel.org> <3e1de608-008c-4439-acd2-647a288dcdc0@roeck-us.net>
Subject: Re: [PATCH v8 8/8] clk: Add KUnit tests for clks registered with struct clk_parent_data
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J.Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>, Geert Uytterhoeven <geert+renesas@glider.be>
To: Guenter Roeck <linux@roeck-us.net>, Shuah Khan <skhan@linuxfoundation.org>
Date: Thu, 03 Oct 2024 17:42:54 -0700
User-Agent: alot/0.10

Quoting Guenter Roeck (2024-10-03 17:25:37)
> On 10/3/24 16:46, Stephen Boyd wrote:
> [ ... ]
> > That DT test has been there for a few releases. Is this the first time
> > those tests have been run on arm64+acpi? I didn't try after sending the
> > patches and forgot that the patch was dropped.
> >=20
>=20
> Previously I had the affected tests disabled and never tracked down the p=
roblem.
> Since the problem is now spreading to additional tests, I finally tracked=
 it down,
> that is all.

Ok great. Good to know this isn't a new problem. Thanks for tracking it
down.

>=20
> > How are you running kunit tests? I installed the qemu-efi-aarch64 debian
> > package to get QEMU_EFI.fd but passing that to the kunit.py run command
> > with --qemu_args=3D"-bios /usr/share/qemu-efi-aarch64/QEMU_EFI.fd" didn=
't
> > get me beyond the point that the EFI stub boots linux. I think the
> > serial console must not be working and thus the kunit wrapper waits for
> > something to show up but nothing ever does. I haven't dug any further
> > though, so maybe you have a working command.
> >=20
>=20
> I run all tests during boot, not from the command line. I also use the -b=
ios
> command but don't recall any issues with the console. I specify the
> console on the qemu command line; depending on the qemu machine it is eit=
her
> ttyS0 or ttyAMA0. The init script then finds and selects the active conso=
le.

Can you please describe how you run the kunit test? And provide the qemu
command you run to boot arm64 with acpi?

>=20
> > Here's my command that isn't working:
> >=20
> > ./tools/testing/kunit/kunit.py run --arch=3Darm64 --kunitconfig=3Ddrive=
rs/of --qemu_args=3D"-bios /usr/share/qemu-efi-aarch64/QEMU_EFI.fd" =20
> >=20
>=20
> I can't really see what that command is actually doing ;-).

It eventually runs this qemu command

qemu-system-aarch64 -nodefaults -m 1024 -kernel .kunit/arch/arm64/boot/Imag=
e.gz -append 'kunit.enable=3D1 console=3DttyAMA0 kunit_shutdown=3Dreboot' -=
no-reboot -nographic -serial stdio -machine virt -cpu max,pauth-impdef=3Don=
 -bios /usr/share/qemu-efi-aarch64/QEMU_EFI.fd

I see that it fails because the architected timer isn't there after I
add an earlycon=3Dpl011,0x9000000 to the kernel commandline. I suspect
passing a bios like this is incorrect, but I rarely run qemu manually so
I don't know what I'm doing wrong.

NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
rcu: srcu_init: Setting srcu_struct sizes based on contention.
timer_probe: no matching timers found
Kernel panic - not syncing: Unable to initialise architected timer.
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.11.0-rc1-00261-g497f7c30=
f184 #203
Call trace:
 dump_backtrace+0x94/0xec
 show_stack+0x18/0x24
 dump_stack_lvl+0x38/0x90
 dump_stack+0x18/0x24
 panic+0x36c/0x380
 early_brk64+0x0/0xa8
 start_kernel+0x27c/0x558
 __primary_switched+0x80/0x88
---[ end Kernel panic - not syncing: Unable to initialise architected timer=
. ]---

>=20
> I'll just keep the affected tests disabled on arm64 for the time being.

We should skip the tests on arm64+acpi, which is similar to disabling
but not exactly the same. There will likely be more DT overlay usage in
kunit and so that will lead to more test disabling. Skipping properly is
the better solution.

