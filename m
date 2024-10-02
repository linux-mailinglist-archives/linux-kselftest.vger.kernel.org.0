Return-Path: <linux-kselftest+bounces-18927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2057D98E448
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 22:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497EB1C2344A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 20:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62A0216A21;
	Wed,  2 Oct 2024 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C1gmTxy1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93F8216A20
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 20:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727901517; cv=none; b=H6P6WSHO7vf9Godgu3vRmOJex/+u224aSOMJMwUF8m51CL0UhLiwJ2mOjEjb9PNqdp2LTxJwEvqRVOBXCdCz54439CG2zdQfL3zqzRSLF5a5eMa7dsP46ktuS0t3rIPkBxtkB7l2ivgqeLQk1MQ8dcbrxSrUemMkJCSYwXWjozo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727901517; c=relaxed/simple;
	bh=RFj7Hyjy1vl2DILkchwSSTL39n1AJGeNYRFrvkzQTGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9nQnN11nNZ6nJr0cwM2KhwnaYabwfu/WDENMEi/oc1l+8FT4A4hNKHZMhWmw+niRzrD4kizXGXLmN4OyQU6aCa6C0uqyyePK5R/KzRZmhr0vD/oWTDGnMIPxH8bnhmASb1mx4+3r7n4dXZy5sjLOa5fzkn4lz7aPhFJ3VN44pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C1gmTxy1; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82aab679b7bso12699439f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 13:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727901515; x=1728506315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pj31NYIEiKOa79BDJSCOsHQizupZa9oVr4cU1X4KQpI=;
        b=C1gmTxy1PhMqZO01V7zPv8Hzb3yhlTiZYyMkHrhM708jzacE4lQPTK1OKAIwRDSkLh
         Lr5jxwSP96GBXYMBqcjt/AjUsH01UXiZyhpNCPMOV+AvJJ5Q7ebRqJ+pYORSrTrmZIw1
         JgZSUCVi5SKfAAbKbGCKXcVrgbSLjlD/CCyos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727901515; x=1728506315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pj31NYIEiKOa79BDJSCOsHQizupZa9oVr4cU1X4KQpI=;
        b=JAK7aq3ppwqzCKUeXa4HDzPS3x6TJ2w4sU+x0Uqn+G3jICHDD2TBMWsDXgHBAhD/uq
         A3BooeJOUb+o/ZTRgYGwvWQmy4YWJBnJLgn13GMJf97BLuBk+y5ff5CaoAx1AJsGzSVe
         4/z6S64tB37rlgkNS2Ev5sfVFplN/7rmWpcHy21oAol46DrylIceS1DSnznEDzsXw8Og
         lfDatQ8aRb5DYniegA5I3l34O4xLwUgB+ekijA8ZU/Td4zPiyIzK5kmCgoAVRXrovlPx
         WlyMWNXU6f3tuCxx7LIxsfxK4LhKWFWtAR/YyOKOuhnYDt9FnxLMOwT6TxhoeWXZq9Fl
         HO+w==
X-Gm-Message-State: AOJu0YzjhRZeGoqAuhcAud+/SiuTxo8XQDjwv/HQPxsBLL3hSbuBXaBF
	rWWCj0juIkXh+WjAXcfl+4qLWD2JQueka4aAiJ34POiPe2yhp1GlVphlmDn2H3w=
X-Google-Smtp-Source: AGHT+IHoAHh4z6vuQjNrlpBDVXjyY38lNfKQBAH0b9ce5uY9fB4adjdXI7hcCQ2/goL4wyrRVGBL7A==
X-Received: by 2002:a05:6e02:214e:b0:3a0:9954:a6fa with SMTP id e9e14a558f8ab-3a36591c623mr42921625ab.9.1727901514757;
        Wed, 02 Oct 2024 13:38:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a344d90b31sm37412815ab.37.2024.10.02.13.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 13:38:34 -0700 (PDT)
Message-ID: <1164a0d6-e12e-4ec9-9a32-97ba4e1d9548@linuxfoundation.org>
Date: Wed, 2 Oct 2024 14:38:33 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 v6.11 v5.15 v5.4 v4.19 1/1] selftests: breakpoints: use
 remaining time to check if suspend succeed
To: Yifei Liu <yifei.l.liu@oracle.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, ramanan.govindarajan@oracle.com,
 sinadin.shan@oracle.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240930224025.2858767-1-yifei.l.liu@oracle.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240930224025.2858767-1-yifei.l.liu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/24 16:40, Yifei Liu wrote:
> step_after_suspend_test fails with device busy error while
> writing to /sys/power/state to start suspend. The test believes
> it failed to enter suspend state with
> 
> $ sudo ./step_after_suspend_test
> TAP version 13
> Bail out! Failed to enter Suspend state
> 
> However, in the kernel message, I indeed see the system get
> suspended and then wake up later.
> 
> [611172.033108] PM: suspend entry (s2idle)
> [611172.044940] Filesystems sync: 0.006 seconds
> [611172.052254] Freezing user space processes
> [611172.059319] Freezing user space processes completed (elapsed 0.001 seconds)
> [611172.067920] OOM killer disabled.
> [611172.072465] Freezing remaining freezable tasks
> [611172.080332] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [611172.089724] printk: Suspending console(s) (use no_console_suspend to debug)
> [611172.117126] serial 00:03: disabled
> some other hardware get reconnected
> [611203.136277] OOM killer enabled.
> [611203.140637] Restarting tasks ...
> [611203.141135] usb 1-8.1: USB disconnect, device number 7
> [611203.141755] done.
> [611203.155268] random: crng reseeded on system resumption
> [611203.162059] PM: suspend exit
> 
> After investigation, I noticed that for the code block
> if (write(power_state_fd, "mem", strlen("mem")) != strlen("mem"))
> 	ksft_exit_fail_msg("Failed to enter Suspend state\n");
> 
> The write will return -1 and errno is set to 16 (device busy).
> It should be caused by the write function is not successfully returned
> before the system suspend and the return value get messed when waking up.
> As a result, It may be better to check the time passed of those few
> instructions to determine whether the suspend is executed correctly for
> it is pretty hard to execute those few lines for 5 seconds.
> 
> The timer to wake up the system is set to expire after 5 seconds and
> no re-arm. If the timer remaining time is 0 second and 0 nano secomd,
> it means the timer expired and wake the system up. Otherwise, the system
> could be considered to enter the suspend state failed if there is any
> remaining time.
> 
> After appling this patch, the test would not fail for it believes the
> system does not go to suspend by mistake. It now could continue to the
> rest part of the test after suspend.
> 
> Fixes: bfd092b8c272 ("selftests: breakpoint: add step_after_suspend_test")
> Reported-by: Sinadin Shan <sinadin.shan@oracle.com>
> Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
> ---
> v4->v5: Remove the above quotes in the first part.
> remove the incorrect format which could confuse the git.

Applied to linux-kselftest fixes branch for next rc.

thanks,
-- Shuah

