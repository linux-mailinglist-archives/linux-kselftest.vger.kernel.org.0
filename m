Return-Path: <linux-kselftest+bounces-43210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62045BDF570
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 17:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D5A189AEBD
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 15:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48662FCBEB;
	Wed, 15 Oct 2025 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXr5fnfO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0A424395C;
	Wed, 15 Oct 2025 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542055; cv=none; b=TimOhUdmJS2JLAEsTxh+59L22EP0FbK/fMS/3BZf57ZyiWsyIYghw6kpDNix5ygQGcM/T3sISO/0mQWz9TfOIcfcQ3Z/WotShQvoWi9F5C6NG5kQF2fyVyzLLUX2fRNBBVdqfxH1SAJfWoxkMM8ut9Ub45ypanMuCofhdmUFTL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542055; c=relaxed/simple;
	bh=pXjv/FZhWR4n2Yfb++gguKHpAI6OOMdbZJ7zMRvXI5M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E2kHjvni7yPQFJ3dCEx6wWXIv6grN3z4WIQj5+2gnS/Tn+PJKPqDlCtXtGiMjcZbUCd+hEEjjgsPJ0R+iWP4YQQdvttaF5LIml5UcaWUSAWBC/iXwEgOQYay4JveAu6BWY5Vgw8G5U/J9Q/yZpTdJFvyW8MGQsvpC7lc+mTUzOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXr5fnfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B054C4CEFB;
	Wed, 15 Oct 2025 15:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760542054;
	bh=pXjv/FZhWR4n2Yfb++gguKHpAI6OOMdbZJ7zMRvXI5M=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=DXr5fnfOS82QY9401usex4XLXhOxaEBt0eXgzFtuTDlXb4PqipMiNIiPu053lQNr/
	 7Zi2w2nJbyQ4tWVeZzYIHtkbFFTbS42y6FO1O/AA1lL0KWQ1mI9F2SpR4axFishxRw
	 y7StUCjfoja7lfmPUlKTWeKlH59FlxsS80NV33uMWP8k8c2MRbjwn6ZU2Kp1LlSj8W
	 DBVol0Cp9OzVx12FkiUV7OKkU4ZVf1k5XcwDqSVR085YL9LZ0AuuKURtZQhyAQB2vJ
	 4DfR9uUTKTUwxrYmn4nlNtrwNPtzwZJFeHVapsJaK8WUE3dSf5HKZLsSkixsb5XNNd
	 xepTZGDxDRV9A==
Date: Wed, 15 Oct 2025 17:27:32 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
cc: Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] HID: multitouch: fix sticky-fingers quirks
In-Reply-To: <20251008-fix-sticky-fingers-v1-0-760f1f26fce3@kernel.org>
Message-ID: <41s6pp01-1947-n4pq-1866-820n84so4op1@xreary.bet>
References: <20251008-fix-sticky-fingers-v1-0-760f1f26fce3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 8 Oct 2025, Benjamin Tissoires wrote:

> According to Peter, we've had for a very long time an issue on some
> mutltiouch touchpads where the fingers were stuck in a scrolling mode,
> or 3 fingers gesture mode. I was unable to debug it because it was
> rather hard to reproduce.
> 
> Recently, some people raised the issue again on libinput, and this time
> added a recording of the actual bug.
> 
> It turns out that the sticky finger quirk that was introduced back in
> 2017 was only checking the last report, and that those missing releases
> also happen when moving from 3 to 1 finger (only 1 is released instead
> of 2).
> 
> This solution seems to me to be the most sensible, because we could also
> add the NSMU quirk to win8 multitouch touchpads, but this would involve
> a lot more computations at each report for rather annoying corner cases.
> 
> Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/1194
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
> Benjamin Tissoires (2):
>       HID: multitouch: fix sticky fingers
>       selftests/hid: add tests for missing release on the Dell Synaptics
> 
>  drivers/hid/hid-multitouch.c                       | 27 ++++++-----
>  .../testing/selftests/hid/tests/test_multitouch.py | 55 ++++++++++++++++++++++
>  2 files changed, 69 insertions(+), 13 deletions(-)

Now queued in for-6.18/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs


