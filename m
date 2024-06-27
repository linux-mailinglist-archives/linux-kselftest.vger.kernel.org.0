Return-Path: <linux-kselftest+bounces-12848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1444591A2DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 11:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B022817A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 09:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12A213AD04;
	Thu, 27 Jun 2024 09:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEr7ufUq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE394D5BD;
	Thu, 27 Jun 2024 09:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719481482; cv=none; b=qdXQ7uKctAZaX5LPT7nD+sxCkyaJj5u1oy0rZjWRmPssFOyzNT+0oGNMrEdxZewf9GlmH0UhiRh2xj/fEzcNggXopGaDHogfFyeZY4BzrhSiTlu6YN7sTlVdsr6ZyvkaGHCSAEGfcxUqxPwzfw5KgwJk2hk/+HfkCzc/7x7ryRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719481482; c=relaxed/simple;
	bh=4eHV7uQqDXKYHXSv8kF60xp3hlm9jIZG1+VL5nQ6X/4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aZWc+bxx4HtpJLl3Ku4R9FZYXofJap/3xHyC97ZPsTLmlGkjKxk+S8uR8MVnCIpEeoAEV1h3AhOieFPBOcF/TJqSSJxjBblXg7gY2Gs7kchOB50VZhldpYIHlHV73ACHfeUD0zy2GuKSr3JnEZx8wc4lLzj3UNr5c2R/1ViYnug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEr7ufUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350FBC2BBFC;
	Thu, 27 Jun 2024 09:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719481482;
	bh=4eHV7uQqDXKYHXSv8kF60xp3hlm9jIZG1+VL5nQ6X/4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eEr7ufUqdWBgfY0AtFS553jIM1GnAxzuO8EKUrgJx8HG3zH4U0vhRB3zm1Iydi0hs
	 /D3cETJNA+4Z7EUGYSpfR6U+qQvCkIB1WkkCbEhRM8s+SNPKyY/3zCfGdgx/FNcqhg
	 mSI2/Nq78F2zaNjbIa3r/ZlJE14Ma1+m56A6bhJFO/JHg+IszAEks2H/4Is/iC/oMm
	 AlPcwMrX2wyBvGuFGLQDNkkIvJ3a2jh7urHUDmaTw3e1vV+5F0JMY46AYqUXoq0wAT
	 iPWbGw02NM+gKxzPdVISTB/2UuoneyeHijp9dCva/s1sTuCwdMFu+ZYeOBGvdv8xaY
	 XftfXzpq1t2zg==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
References: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
Subject: Re: [PATCH HID v2 00/13] HID: bpf_struct_ops, part 2
Message-Id: <171948147992.34428.17204298089806959827.b4-ty@kernel.org>
Date: Thu, 27 Jun 2024 11:44:39 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0

On Wed, 26 Jun 2024 15:46:21 +0200, Benjamin Tissoires wrote:
> This series is a followup of the struct_ops conversion.
> 
> Therefore, it is based on top of the for-6.11/bpf branch of the hid.git
> tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/log/?h=for-6.11/bpf
> 
> The first patch should go in ASAP, it's a fix that was detected by Dan
> and which is actually breaking some use cases.
> 
> [...]

Applied to hid/hid.git (for-6.11/bpf), thanks!

[01/13] HID: bpf: fix dispatch_hid_bpf_device_event uninitialized ret value
        https://git.kernel.org/hid/hid/c/ebae0b2a6f4b
[02/13] HID: add source argument to HID low level functions
        https://git.kernel.org/hid/hid/c/67eccf151d76
[03/13] HID: bpf: protect HID-BPF prog_list access by a SRCU
        https://git.kernel.org/hid/hid/c/6cd735f0e57a
[04/13] HID: bpf: add HID-BPF hooks for hid_hw_raw_requests
        https://git.kernel.org/hid/hid/c/8bd0488b5ea5
[05/13] HID: bpf: prevent infinite recursions with hid_hw_raw_requests hooks
        https://git.kernel.org/hid/hid/c/75839101ce52
[06/13] selftests/hid: add tests for hid_hw_raw_request HID-BPF hooks
        https://git.kernel.org/hid/hid/c/015a4a2a439b
[07/13] HID: bpf: add HID-BPF hooks for hid_hw_output_report
        https://git.kernel.org/hid/hid/c/9286675a2aed
[08/13] selftests/hid: add tests for hid_hw_output_report HID-BPF hooks
        https://git.kernel.org/hid/hid/c/3ac83fcd6e67
[09/13] HID: bpf: make hid_bpf_input_report() sleep until the device is ready
        https://git.kernel.org/hid/hid/c/fa03f398a8ac
[10/13] selftests/hid: add wq test for hid_bpf_input_report()
        https://git.kernel.org/hid/hid/c/fe8d561db3e8
[11/13] HID: bpf: allow hid_device_event hooks to inject input reports on self
        https://git.kernel.org/hid/hid/c/9acbb7ba4589
[12/13] selftests/hid: add another test for injecting an event from an event hook
        https://git.kernel.org/hid/hid/c/62f2e1a096cd
[13/13] selftests/hid: add an infinite loop test for hid_bpf_try_input_report
        https://git.kernel.org/hid/hid/c/d3e15189bfd4

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


