Return-Path: <linux-kselftest+bounces-19033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A75F99059E
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 16:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FEA281CE3
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 14:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552D62178E2;
	Fri,  4 Oct 2024 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hs/rGzpg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229492139B2;
	Fri,  4 Oct 2024 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051136; cv=none; b=O1tqYw7zdHOBBx/oleRphqmK7V46XQEhDUJBp6Pbn76MrUDLVRZC5glm69ium0yd9Cq6aBx+dKl8ssAk+RIXCNCNL1b1adXml9Aefz/Sr2PyL+NyaxQBycwV0zN++o5d+FLPdwJZiVJLXoAmUojzzgVJdo0vRPMab0OboUyod80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051136; c=relaxed/simple;
	bh=F1SQlcp5IkLNO1H2vORA9XiW8hozZMZLQRqYlz5sTkI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GJkv0GzCIy6pxoU5XbaIwCRI9oUr4HV3EW3owlts0IDWKUyq97hYFjrqiw5pX3eBv/R0OoF0tQuPS8ohOzZWkC7v1V7JuYYeyemwCBeOZzc/8+UzYuu1tIDbLJwACFIv4DJ7ifWE6+zpVeetPflnvMSGG627B1b64IFNAywmMMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hs/rGzpg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E587CC4CECE;
	Fri,  4 Oct 2024 14:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728051135;
	bh=F1SQlcp5IkLNO1H2vORA9XiW8hozZMZLQRqYlz5sTkI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Hs/rGzpg5Bl6ZC0v3dD6ZT6tvuOAlGRBcwmF+gLfitzEmtK0p7bIihKbCBC4W9atx
	 Kpd2s+6NHcweWkzft1Q1gpgSvvtnXKNA6CkvUloVgDc78cRfKL6FFJrbjq/ypHOih3
	 xnb7Ho09eQghGrWOYZclP3BZIopujd4L4LqGYEo4ak/5to1OxfvoDXbLwpvKxNpgyu
	 C9TavjClxwUkgXmzjkptBZTWtRYxyBIV0RlqD66xF1CgB3TgUDH8e5bzNl2s7h29PS
	 zPo+hUgaW5aM0bhzwb5ID1nZW0ccJHzWC4fcJO3e0kd+1OWu0Qq8jtWmOscv1reeyf
	 eL5vFUpb1R2oA==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20241001-hid-bpf-hid-generic-v3-0-2ef1019468df@kernel.org>
References: <20241001-hid-bpf-hid-generic-v3-0-2ef1019468df@kernel.org>
Subject: Re: [PATCH HID v3 0/9] HID: bpf: add a new hook to control
 hid-generic
Message-Id: <172805113364.312675.1594218264039046838.b4-ty@kernel.org>
Date: Fri, 04 Oct 2024 16:12:13 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Tue, 01 Oct 2024 16:30:04 +0200, Benjamin Tissoires wrote:
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

Applied to hid/hid.git (for-6.13/bpf), thanks!

[1/9] HID: bpf: move HID-BPF report descriptor fixup earlier
      https://git.kernel.org/hid/hid/c/8b7fd6a15f8c
[2/9] HID: core: save one kmemdup during .probe()
      https://git.kernel.org/hid/hid/c/52cd1906ef6b
[3/9] HID: core: remove one more kmemdup on .probe()
      https://git.kernel.org/hid/hid/c/7316fef4b993
[4/9] HID: bpf: allow write access to quirks field in struct hid_device
      https://git.kernel.org/hid/hid/c/6fd47effe92b
[5/9] selftests/hid: add dependency on hid_common.h
      https://git.kernel.org/hid/hid/c/0b838d768ccd
[6/9] selftests/hid: cleanup C tests by adding a common struct uhid_device
      https://git.kernel.org/hid/hid/c/4fb41dfde069
[7/9] selftests/hid: allow to parametrize bus/vid/pid/rdesc on the test device
      https://git.kernel.org/hid/hid/c/72c55473fc8c
[8/9] HID: add per device quirk to force bind to hid-generic
      https://git.kernel.org/hid/hid/c/645c224ac5f6
[9/9] selftests/hid: add test for assigning a given device to hid-generic
      https://git.kernel.org/hid/hid/c/e14e0eaeb040

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


