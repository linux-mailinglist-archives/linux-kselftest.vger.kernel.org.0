Return-Path: <linux-kselftest+bounces-17946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C38978154
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 15:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02A21C22159
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 13:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3751D935A;
	Fri, 13 Sep 2024 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bs/fFwqb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C231D6C7A;
	Fri, 13 Sep 2024 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726234738; cv=none; b=MUZYsl3k4gBNfwOwaEKJ2TjoRyQSyAPaeby9/WPi9m5fqCvzBr0Ceiy+ZN1FsunKGslofnB/8BVaK9sVutMfZ2njcmEEaOnVZLN6r/jacwma8XhAkUzIkIw6RAVoUaTC1Ngp8tgFNpl1Nq5ouH/j+zrxQ3c/9W/NDuAdrdSD+e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726234738; c=relaxed/simple;
	bh=/KYBSsDBCUsu+s6eKQzz/C+xxOtD1VUVkICShhczuto=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PdhHl2bzhdJb5TXUPM/PmIqt76ySRJBp0k4DU0L89zGzqJf5b/QM8eN8od9d/NuQiU6nJC4dNwzgarXfzYzxT1NbIzZn+W5CEhXJ0Bq6rIms5Mg7T9Ys/qfMLj1aXKL8ZJA0zs6csFEDCKBWgfk40IGrs2yaV6BzaVXjunM4Ff8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bs/fFwqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34808C4CEC0;
	Fri, 13 Sep 2024 13:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726234738;
	bh=/KYBSsDBCUsu+s6eKQzz/C+xxOtD1VUVkICShhczuto=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Bs/fFwqbdW6dlxBnItsXK36LvRQXPXcToYHuJUWFx6tvZ+ExVwLy+TlJyf+jFxlf0
	 68TsjIdQub/qzqSm6R/Ym1o0APmC8da4YOjZOgiFrHMPvaoAFDTNyXnf2dpdDFRnQJ
	 md/lYpfK1c1N0fV3phv+O+kGwE02CYfXL2IBShc7hbPsmaA/TWfbExj5Ji4GOyxRGh
	 LQLWGUfT/Xz/oZYLO81dyF2eBXZsz8gqdtK9usPTcPGRUDDQcpoAW0qEMUedfirquF
	 7i83vW4pBF0H8OiPYo6E8W8fQfM7wKjMzuqLAU61rjuq2g+Tv2tkrQMWYBgAkeHijU
	 +I64sUZR7hjsQ==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
References: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
Subject: Re: (subset) [PATCH HID v2 00/11] HID: bpf: add a new hook to
 control hid-generic
Message-Id: <172623473588.1192461.11090201509053454593.b4-ty@kernel.org>
Date: Fri, 13 Sep 2024 15:38:55 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Tue, 10 Sep 2024 23:43:36 +0900, Benjamin Tissoires wrote:
> This is a slight change from the fundamentals of HID-BPF.
> In theory, HID-BPF is abstract to the kernel itself, and makes
> only changes at the HID level (through report descriptors or
> events emitted to/from the device).
> 
> However, we have seen a few use cases where HID-BPF might interact with
> the running kernel when the target device is already handled by a
> specific device.
> 
> [...]

Applied to hid/hid.git (for-6.12/bpf), thanks!

[01/11] HID: bpf: move HID-BPF report descriptor fixup earlier
        https://git.kernel.org/hid/hid/c/f10a11b7b599
[02/11] HID: core: save one kmemdup during .probe()
        https://git.kernel.org/hid/hid/c/6941754dbbc7
[03/11] HID: core: remove one more kmemdup on .probe()
        https://git.kernel.org/hid/hid/c/4fe29f36d2a3
[04/11] HID: bpf: allow write access to quirks field in struct hid_device
        https://git.kernel.org/hid/hid/c/b722f588adc6
[05/11] selftests/hid: add dependency on hid_common.h
        https://git.kernel.org/hid/hid/c/3d816765e12e
[06/11] selftests/hid: cleanup C tests by adding a common struct uhid_device
        https://git.kernel.org/hid/hid/c/28023a0f99d1
[07/11] selftests/hid: allow to parametrize bus/vid/pid/rdesc on the test device
        https://git.kernel.org/hid/hid/c/10d3147f9bb1
[08/11] HID: add per device quirk to force bind to hid-generic
        https://git.kernel.org/hid/hid/c/d030f826ea47
[09/11] selftests/hid: add test for assigning a given device to hid-generic
        https://git.kernel.org/hid/hid/c/10929078201f

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


