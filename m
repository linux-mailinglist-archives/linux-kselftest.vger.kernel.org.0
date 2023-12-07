Return-Path: <linux-kselftest+bounces-1342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9FF808392
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 09:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C169D1F2254F
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 08:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEA81E480;
	Thu,  7 Dec 2023 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sukd+z35"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616401400F;
	Thu,  7 Dec 2023 08:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D33FC433C8;
	Thu,  7 Dec 2023 08:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701939208;
	bh=DhSbqjsnrf7h3qd/f9SD+8GsKgMde5b6jsS8tzFL0Tc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Sukd+z35LV7PFNWE1vLfL8foH9cYFCR3ZR2Tu0hpnkI6Hc5+V/5LwFBR5VyNDHW9a
	 /MWsvUaxFy7+n0Oy5gqltAeo/+1nZBQ1jtvzFIdwcz+5eBpV0VnAR/JqxqREvXeDPE
	 AF1wxNOqLyRiMLOQhR9Xqd1obQXGQ7yk8dc5YsP8ojmAh2GFrg/x4VM7z/Vg1x1ZPC
	 jkTYfbTZLEB9mxkXU635xG+MfVRgvEeJjBnat1gPz4jPNbgHMk38K0g4YmxHlQkPEE
	 jMETGQT1tJ+kP+ILo8HLxMkY+UqtIH1ORDvdU/j3qCG8cIQt5WUVk7s/pmPkKmF7OV
	 JOsiVE0BA/Ejw==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
References: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
Subject: Re: [PATCH v2 00/15] selftests/hid: tablets fixes
Message-Id: <170193920703.229356.5910722658341910962.b4-ty@kernel.org>
Date: Thu, 07 Dec 2023 09:53:27 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

On Wed, 06 Dec 2023 11:45:51 +0100, Benjamin Tissoires wrote:
> the main trigger of this series was the XP-Pen issue[0].
> Basically, the tablets tests were good-ish but couldn't
> handle that tablet both in terms of emulation or in terms
> of detection of issues.
> 
> So rework the tablets test a bit to be able to include the
> XP-Pen patch later, once I have a kernel fix for it (right
> now I only have a HID-BPF fix, meaning that the test will
> fail if I include them).
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-5.8/selftests), thanks!

[01/15] selftests/hid: vmtest.sh: update vm2c and container
        https://git.kernel.org/hid/hid/c/887f8094b335
[02/15] selftests/hid: vmtest.sh: allow finer control on the build steps
        https://git.kernel.org/hid/hid/c/46bc0277c250
[03/15] selftests/hid: base: allow for multiple skip_if_uhdev
        https://git.kernel.org/hid/hid/c/110292a77f7c
[04/15] selftests/hid: tablets: remove unused class
        https://git.kernel.org/hid/hid/c/b5edacf79c8e
[05/15] selftests/hid: tablets: move the transitions to PenState
        https://git.kernel.org/hid/hid/c/d52f52069fed
[06/15] selftests/hid: tablets: move move_to function to PenDigitizer
        https://git.kernel.org/hid/hid/c/881ccc36b426
[07/15] selftests/hid: tablets: do not set invert when the eraser is used
        https://git.kernel.org/hid/hid/c/d8d7aa2266a7
[08/15] selftests/hid: tablets: set initial data for tilt/twist
        https://git.kernel.org/hid/hid/c/e08e493ff961
[09/15] selftests/hid: tablets: define the elements of PenState
        https://git.kernel.org/hid/hid/c/83912f83fabc
[10/15] selftests/hid: tablets: add variants of states with buttons
        https://git.kernel.org/hid/hid/c/74452d6329be
[11/15] selftests/hid: tablets: convert the primary button tests
        https://git.kernel.org/hid/hid/c/1f01537ef17e
[12/15] selftests/hid: tablets: add a secondary barrel switch test
        https://git.kernel.org/hid/hid/c/76df1f72fb25
[13/15] selftests/hid: tablets: be stricter for some transitions
        https://git.kernel.org/hid/hid/c/ab9b82909e9b
[14/15] selftests/hid: fix mypy complains
        https://git.kernel.org/hid/hid/c/ed5bc56cedca
[15/15] selftests/hid: fix ruff linter complains
        https://git.kernel.org/hid/hid/c/f556aa957df8

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


