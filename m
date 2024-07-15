Return-Path: <linux-kselftest+bounces-13721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CCB931200
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 12:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10C41F23461
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 10:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF29E18733B;
	Mon, 15 Jul 2024 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dXs/5jRQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137E818629E;
	Mon, 15 Jul 2024 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038175; cv=none; b=O/NCJoQc1xzhObVEHX9l1WpL4YSTAmAVnOiFmJs25kG7bmiLLtd863CcWtu9Y/htbuxyjNnSqfHdyENXwoVZ5XJ0ru56DNN07QE3lnxVdlIwJu7qmAs0vnrZLV6UY/Ve4w7mpKhWMIXCEYUs6l0QQU9LWa2X1Wxs62q7nhjDQcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038175; c=relaxed/simple;
	bh=3iWkkRhrPMHdpUC2YypIAwVDHV4ZA0Hh2R6TO1it6/E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=bBglAmRURa1F3hfQRJdP0HxmX4vOtp/vdghsoemMo8W9BeDeCAHkd7sJCM2BJrzEC5xGBPabb1ASv0iC2+mTCgUpe/jeWcPQonTvj1ExMYdYDpHn5BnnK/wAlXqNxfag8mM/SfIMM9dyVEX9OqBnBfAjWzWABOaAgW9piw+JD7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dXs/5jRQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721038172;
	bh=3iWkkRhrPMHdpUC2YypIAwVDHV4ZA0Hh2R6TO1it6/E=;
	h=Date:From:Subject:To:Cc:From;
	b=dXs/5jRQwvIZBbphpR2BZhzamKMaqqjn55XTvBiuxb8//GcCmaIFXIKqPpA4D/gfR
	 NmtAGfVvG7Hrt9Bf8B//96Q69DSEWdUO4uuzrEc5noshMqq3GKO+WUpEpxhPPinNej
	 L03DDAoJn0y+CqvHwVjvmbp/Q9JnNkxlYUVWB88Ip4qYwGpAVBaHbBf1RevQHyqTsV
	 yFkh6mcW9m+2tscuEJ3dGS0Qvyn5+ofpuUTb7IKKGRme40i5fovIR0dw2nkKKGRTI7
	 +yYHIKc4Infvhpdg5DdExjWfBuV2NEc8ng3bkkc/uMUWRAgWwKfWuHHXscYanjyFwO
	 Bobcb2kwOkVQw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 42B3C3780B79;
	Mon, 15 Jul 2024 10:09:28 +0000 (UTC)
Message-ID: <327831fb-47ab-4555-8f0b-19a8dbcaacd7@collabora.com>
Date: Mon, 15 Jul 2024 15:09:24 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Converting kselftest test modules to kunit
To: Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
 davidgow@google.com
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 "open list : KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, kunit-dev@googlegroups.com,
 David Gow <davidgow@google.com>, "kernel@collabora.com"
 <kernel@collabora.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kees and All,

There are several tests in kselftest subsystem which load modules to tests
the internals of the kernel. Most of these test modules are just loaded by
the kselftest, their status isn't read and reported to the user logs. Hence
they don't provide benefit of executing those tests.

I've found patches from Kees where he has been converting such kselftests
to kunit tests [1]. The probable motivation is to move tests output of
kselftest subsystem which only triggers tests without correctly reporting
the results. On the other hand, kunit is there to test the kernel's
internal functions which can't be done by userspace.

Kselftest:	Test user facing APIs from userspace
Kunit:		Test kernel's internal functions from kernelspace

This brings me to conclusion that kselftest which are loading modules to
test kernelspace should be converted to kunit tests. I've noted several
such kselftests.

This is just my understanding. Please mention if I'm correct above or more
reasons to support kselftest test modules transformation into kunit test.

[1] https://lore.kernel.org/all/20221018082824.never.845-kees@kernel.org/

-- 
BR,
Muhammad Usama Anjum

