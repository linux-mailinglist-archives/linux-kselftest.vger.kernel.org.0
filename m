Return-Path: <linux-kselftest+bounces-15666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA96D957205
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 508ABB2966D
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 17:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA82213BAD5;
	Mon, 19 Aug 2024 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqccX7ce"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF1D2628C;
	Mon, 19 Aug 2024 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087974; cv=none; b=jIgOaD1VsRbewtgwm3f07oODbHZU2uZOwYWl16YasUxUJZzppN9Qr6TTclxYxFkDdrBCtfWylFXeyJrSxuVa7JvpRcUtcTDVHvX8AZ2SxPU09WZl/PBkrko+yhELrPyj3W5iN+8W9xxfj6aPsagwru2WsUP805CHWaXuHsmAD1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087974; c=relaxed/simple;
	bh=kpurrWh4GoCk4EhRPyKhyuQNciCdeTMkyFy+HQhj8pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXOBu+KJLs0Bcz/5S7niV5TNZvqDS19uOWmB7zvdIAuFFbUQ4TM92WT0+il82butrxaC5VoqAPd3igZVbnmpu+FAnES1H4hBeL8iDkJVQrb3ojmLZZWfWXMSfOjOI4TbG3BThb3Ins4E+IJtfwiOt2WCiJPx+27C8YsHMxKtA+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqccX7ce; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20227ba378eso14515505ad.0;
        Mon, 19 Aug 2024 10:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724087973; x=1724692773; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=53O9dI32JEiWmNu9kbre51YcA6g5iu5J6Wy1f86hXw8=;
        b=LqccX7cerx1W6dZ1XI2oL2AGD5KBoV1+zBZSqlBp+Zd44K60grcE77y1bdg/loM82t
         k5O+ykucvqYLieUBm0/zgiAbVxelloorg8sVOSqWrKadZBeXBH+LA5rO+Mldc+4OjhJb
         Oj8V+UJP/ZbVweQlcTnuG8fZ6cm3WaOoKcMz4MzZOKGmR6c+2dyyglCft/qhZGcc3VWq
         fyJf9AIOS1vXaebemcmCQD9tO606/bj0p0OtK4IpY7AnYxH6fpB6YiJ+V/Ir4esi2u6O
         X6frgpL2fKB5Nx9hD0WcP4bscdD+TGexW/76V8B0MuUieK0uQx/FtrfVyExWyB6+YuMF
         KFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724087973; x=1724692773;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=53O9dI32JEiWmNu9kbre51YcA6g5iu5J6Wy1f86hXw8=;
        b=vuv3gytLg+MMOzEwsuKDuldI3O486QyS2h2Z5NBfLa6TVgQP5gMk5wFzvmogBxNbGe
         vIrNErzIxyZMTH9nmFQF4QzGr7/UJs53FlHyKoRqebbUZdEasz9Hxdlqxyd41ZxVyxp3
         wWeT/EuDo/OlX8eW72w3rMzAbf9IvFnrBDdeDRXXhTRS9NwOxlHlVBavp3xrwoxK84xP
         j0DFUtYg3tzqFORuZCzZf07+slEdDSTZAVFOCfEIWqPjZ5wCKISCacRP04ZBWu0exUf3
         0a2uNfjXXNyx48zpzLvGCaxV6m6F3fZrBmd0DfFG0Lk82PycausWCKfo/pRSqdwBDHmM
         Zpjw==
X-Forwarded-Encrypted: i=1; AJvYcCWKSvEZA0Su4JYOz1in7pazz0p/rC2j4iWfB0vrnVL3kQYmGGNBExHhYWM8zmiKhVC2fb7dbht/NprES3G/tAuD7kA2c+N5tHXZDMJ7eVxPRWeup1fKnLYQ0hvaUZDeXUyh5tpCY4rQGHZCNwY/A5BWpOjCCKWqjZjmo0B573DBOy69QAfj
X-Gm-Message-State: AOJu0YyRGm6qRLFI7CorYj1LF6gbBRDlJ1WFG1h+xDLh8ojznfoPuJAk
	JAlax8LfoJBGpAo/TJ7F1D0MWyuuDTV0Xr+DZKhzFDKvyjD9g0BGlR8728ynLHQIQiUKFuDDelG
	tR36+NobGPJf3sbPsM7uPZt+F0AM=
X-Google-Smtp-Source: AGHT+IGkp58oHXbrhbtUSvKX8NI0k1CR1NhEKl4WxsC62cHk4yM6lcUikR+Gz0WpJI+ZExuQ4WYW7wU6rWz25uzTJb4=
X-Received: by 2002:a17:90a:88e:b0:2c9:7611:e15d with SMTP id
 98e67ed59e1d1-2d3dfc8a893mr12563110a91.20.1724087972499; Mon, 19 Aug 2024
 10:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815-tcp-ao-selftests-upd-6-12-v3-0-7bd2e22bb81c@gmail.com>
In-Reply-To: <20240815-tcp-ao-selftests-upd-6-12-v3-0-7bd2e22bb81c@gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Mon, 19 Aug 2024 18:19:21 +0100
Message-ID: <CAJwJo6bMxTC8BJaHWy1AfMJ-CLPvn67qfkS0cZYr7TuhgHH-6A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/8] net/selftests: TCP-AO selftests updates
To: 0x7f454c46@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Going to update with v4, I see some netdev failures on non-appeared
trace events.
I need to review the synchronization on the tracer thread.

pw-bot: changes-requested

On Thu, 15 Aug 2024 at 22:32, Dmitry Safonov via B4 Relay
<devnull+0x7f454c46.gmail.com@kernel.org> wrote:
>
> First 3 patches are more-or-less cleanups/preparations.
>
> Patches 4/5 are fixes for netns file descriptors leaks/open.
>
> Patch 6 was sent to me/contributed off-list by Mohammad, who wants 32-bit
> kernels to run TCP-AO.
>
> Patch 7 is a workaround/fix for slow VMs. Albeit, I can't reproduce
> the issue, but I hope it will fix netdev flakes for connect-deny-*
> tests.
>
> And the biggest change is adding TCP-AO tracepoints to selftests.
> I think it's a good addition by the following reasons:
> - The related tracepoints are now tested;
> - It allows tcp-ao selftests to raise expectations on the kernel
>   behavior - up from the syscalls exit statuses + net counters.
> - Provides tracepoints usage samples.
>
> As tracepoints are not a stable ABI, any kernel changes done to them
> will be reflected to the selftests, which also will allow users
> to see how to change their code. It's quite better than parsing dmesg
> (what BGP was doing pre-tracepoints, ugh).
>
> Somewhat arguably, the code parses trace_pipe, rather than uses
> libtraceevent (which any sane user should do). The reason behind that is
> the same as for rt-netlink macros instead of libmnl: I'm trying
> to minimize the library dependencies of the selftests. And the
> performance of formatting text in kernel and parsing it again in a test
> is not critical.
>
> Current output sample:
> > ok 73 Trace events matched expectations: 13 tcp_hash_md5_required[2] tcp_hash_md5_unexpected[4] tcp_hash_ao_required[3] tcp_ao_key_not_found[4]
>
> Previously, tracepoints selftests were part of kernel tcp tracepoints
> submission [1], but since then the code was quite changed:
> - Now generic tracing setup is in lib/ftrace.c, separate from
>   lib/ftrace-tcp.c which utilizes TCP trace points. This separation
>   allows future selftests to trace non-TCP events, i.e. to find out
>   an skb's drop reason, which was useful in the creation of TCP-CLOSE
>   stress-test (not in this patch set, but used in attempt to reproduce
>   the issue from [2]).
> - Another change is that in the previous submission the trace events
>   where used only to detect unexpected TCP-AO/TCP-MD5 events. In this
>   version the selftests will fail if an expected trace event didn't
>   appear.
>   Let's see how reliable this is on the netdev bot - it obviously passes
>   on my testing, but potentially may require a temporary XFAIL patch
>   if it misbehaves on a slow VM.
>
> [1] https://lore.kernel.org/lkml/20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=33700a0c9b56
>
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
[..]

Sorry for the noise,
             Dmitry

