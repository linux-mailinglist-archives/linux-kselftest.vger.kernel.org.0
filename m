Return-Path: <linux-kselftest+bounces-9605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C561B8BE6D6
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 17:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022501C24101
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 15:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FDD161911;
	Tue,  7 May 2024 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eo5ODtEh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D80161322;
	Tue,  7 May 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094148; cv=none; b=qTXOsNwK+ZoK34VpNGob+qSEp18iGKaJbld4bKVvasOs93JgbFIV9HAcvSNawFiryJNnvGH+4U3QB9No7r1+4ulC+Lozhka+xBFmuRLdk4fYWg/dLYATllEJHwMuwXVt92Fy4PdHX5VEkqjk28BdQg3ybubaI2UiTPSrC0PwhvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094148; c=relaxed/simple;
	bh=1kl+9sqFf6ado4Kj03DXRpQ9AwVV9pVh1QIHdqKauG8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lKal/cPC40YV2KeHkvyY/rRFFCILJQdIIHbYZKUzYc/ooTlFWRJi08H43T8mQabQeL/bjKMSqXrulg/VqMC3Dt0DpGBHGoICabP+hFyS/i+SZ2uAPtKOt6g4DwQGKcXYkRZ2z773xRhKI3cpvg3La3rC06WWuRpIzPHB+gvQfhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eo5ODtEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11123C4AF18;
	Tue,  7 May 2024 15:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715094147;
	bh=1kl+9sqFf6ado4Kj03DXRpQ9AwVV9pVh1QIHdqKauG8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eo5ODtEhMQWGPr5XLrYtgy1Qx3x/w4V3EHrL7a3YnDaOB9a2BdEL3inxCHB2ZsV81
	 O9MkF/TouJBP2gm8IV1+SPCJ7bRHSQnhhisDqQmQENzDBfRIlwYYewbnXbmU6/CxYa
	 w5ArvD3UxiN3s+sEcSfUHMdcsVolvcnNJTUSvXPc54L3fFBB4iIepvQfB7ucTfTG3t
	 at9kAhYiz7B790FOzJAtp6FpK9n56cYNEEIcHdz7hrhmPekwC3NTF+sHs7s0IFavkf
	 ZliL5jFhl8pJZSOwk1dIg5XUUY+7joew4Ww5/GbgCmDaw6ZZA/p29XlcQKmBP9byop
	 L5pncAeb3nktg==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Martin Sivak <mars@montik.net>, 
 Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, 
 Aaron Armstrong Skomra <skomra@gmail.com>, 
 Joshua Dickens <Joshua@joshua-dickens.com>
In-Reply-To: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
References: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
Subject: Re: [PATCH 00/18] HID: Include current HID-BPF fixes in tree
Message-Id: <171509414478.293793.7835177895270675109.b4-ty@kernel.org>
Date: Tue, 07 May 2024 17:02:24 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

On Wed, 10 Apr 2024 19:19:20 +0200, Benjamin Tissoires wrote:
> When I introduced HID-BPF, I mentioned that we should ship the HID-BPF
> programs in the kernel when they are fixes so that everybody can benefit
> from them.
> 
> I tried multiple times to do so but I was confronted to a tough problem:
> how can I make the kernel load them automatically?
> 
> [...]

Applied to hid/hid.git (for-6.10/hid-bpf), thanks!

[01/18] HID: do not assume HAT Switch logical max < 8
        https://git.kernel.org/hid/hid/c/65ad580a14e8
[02/18] HID: bpf: add first in-tree HID-BPF fix for the XPPen Artist 24
        https://git.kernel.org/hid/hid/c/04b3e5ab0555
[03/18] HID: bpf: add in-tree HID-BPF fix for the XPPen Artist 16
        https://git.kernel.org/hid/hid/c/e0599675a32c
[04/18] HID: bpf: add in-tree HID-BPF fix for the HP Elite Presenter Mouse
        https://git.kernel.org/hid/hid/c/4e6d2a297dd5
[05/18] HID: bpf: add in-tree HID-BPF fix for the IOGear Kaliber Gaming MMOmentum mouse
        https://git.kernel.org/hid/hid/c/0bc8f89f4040
[06/18] HID: bpf: add in-tree HID-BPF fix for the Wacom ArtPen
        https://git.kernel.org/hid/hid/c/d9e78973921d
[07/18] HID: bpf: add in-tree HID-BPF fix for the XBox Elite 2 over Bluetooth
        https://git.kernel.org/hid/hid/c/1c046d09c6ba
[08/18] HID: bpf: add in-tree HID-BPF fix for the Huion Kamvas Pro 19
        https://git.kernel.org/hid/hid/c/9f1bf4c22532
[09/18] HID: bpf: add in-tree HID-BPF fix for the Raptor Mach 2
        https://git.kernel.org/hid/hid/c/0cd1465cac52
[10/18] selftests/hid: import base_device.py from hid-tools
        https://git.kernel.org/hid/hid/c/a7def2e51c66
[11/18] selftests/hid: add support for HID-BPF pre-loading before starting a test
        https://git.kernel.org/hid/hid/c/e906463087ce
[12/18] selftests/hid: tablets: reduce the number of pen state
        https://git.kernel.org/hid/hid/c/e14d88d9b8da
[13/18] selftests/hid: tablets: add a couple of XP-PEN tablets
        https://git.kernel.org/hid/hid/c/03899011df4b
[14/18] selftests/hid: tablets: also check for XP-Pen offset correction
        https://git.kernel.org/hid/hid/c/1b2c3caf7839
[15/18] selftests/hid: add Huion Kamvas Pro 19 tests
        https://git.kernel.org/hid/hid/c/51de9ee0a6c7
[16/18] selftests/hid: import base_gamepad.py from hid-tools
        https://git.kernel.org/hid/hid/c/c6b03c736a52
[17/18] selftests/hid: move the gamepads definitions in the test file
        https://git.kernel.org/hid/hid/c/aa7e560454a9
[18/18] selftests/hid: add tests for the Raptor Mach 2 joystick
        https://git.kernel.org/hid/hid/c/b22cbfb42c19
[19/19] selftests/hid: skip tests with HID-BPF if udev-hid-bpf is not installed
        https://git.kernel.org/hid/hid/c/89ea968a9d75

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


