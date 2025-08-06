Return-Path: <linux-kselftest+bounces-38385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0259B1C8CE
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 17:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4133A5F86
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 15:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDF3292B3F;
	Wed,  6 Aug 2025 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJJzJ5m4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA19524503C;
	Wed,  6 Aug 2025 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494468; cv=none; b=WiaD2KKFlxO9MlwD1NG4jOdXbdDlAXvqTcnI6mdorakJvQo6/coFzDiMYeFsRPBPcOzuAwZNyKvkHAIqWPpzHNmrurLoGIijaPwLCZMATp4tUgYApDjAnhH9jrQzyGrLUa/l8rdxGL2Xm/Ucu7aSj2OJqHAeEW4A/3l+hEDIpwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494468; c=relaxed/simple;
	bh=9k5FqnoKkgBQy4Bx9d/Hz1VRfIa6e+0sJLuBBqzZUKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elcrqjRiNvyB6S4bj1owW20MrIIsZz/XEQfCnDk5BAWvM0hMQYqVHH6mBlTyreqBIzr/idisDOQu81mTqvKbWO9sCnQoUDEOu/EXvotN8/Y/rS7ODDvNf566au9YmyHne3gnKkG3UaNTYZ102PGv0tRD7WW/8RLX+lR1dnefuyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJJzJ5m4; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55b823c9129so6847902e87.3;
        Wed, 06 Aug 2025 08:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754494465; x=1755099265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dr2iD/x5RNPmf2/wZEirrgdGMAy27l5lk2Wo0A6tpXk=;
        b=nJJzJ5m4BN0Q2AqdOZ36CW/wdCvynCkbRrIEIfGt4yM1WlE55pDaJf4lVVp3qFQ9Fw
         KB7FMbVMaQTPRfbHlANGk+QHB721D7/PKZcBUnRIxQLI2kAbTElwoZscjlEwyF45jldQ
         iWOsstU9Za3/ApPjWPjaAomTWaflIePE5ODF71Eu/mYD5LTm5AGl+6AA7rmEPZKDS/WD
         jXA2xKMqHuU0MsxnFh8lHdsNW7VWTKAqo+/UYSo9o0CZvfDybWxLPR0C4FS5wnsK6rXD
         3HWaC+xGVZFAQIvkp1wegVjyzSzsewkq4ltGTW+8L+Ibrk+ioIrmOIcQ3G9mm52/dbh9
         ZayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754494465; x=1755099265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dr2iD/x5RNPmf2/wZEirrgdGMAy27l5lk2Wo0A6tpXk=;
        b=slK28Ck0hEnTvh4cbq3UDB9bEKKa7x6HZ2NKhqk0TXVQJ9YAf+bS4LfiXmo2xl/koN
         TB6BUMP9yfVpnK70Ve7vIz5VG7f1NW//POxvV/LCfL3OedIHWVZcqCfzOskPNU9/OJW1
         Zb4YI0hsAB54YRK7G2VhDxUtaoDfzzMH+7digs2zRrVD6Oh18pSSdqBLmsM3HjuVsraQ
         y87gqDSsQxFGtBk+cmdRVSOpIpo5ZdIZQeMbYZrKUJ5hLpee/ptUnPUov4bLfejBSMZ1
         Fknb7v4pI7hml7QsupNKTKfgV1PReRlNtlvv4w/bPviQmd8BOMDD2PY0VWKBiC1o3nVV
         zS3A==
X-Forwarded-Encrypted: i=1; AJvYcCUfENQVhaktTcTvyk3JVoHv0lQeT+2dJ+XDgfrMNS5ZdbpqQZTKXsy6jcwlFs1+xzNPdECKrLgOOjGOliuuJBHI@vger.kernel.org, AJvYcCV2foRLVS54Tm0qeAKCKghCk7TBZvsNeQxxvHO4IVU6jR0egbPR5uKhzK39nbspA0AtGyXhhqEN@vger.kernel.org, AJvYcCWO3pajrqLaBCy4SzSdnCMXvaWfAe2qgg88PTp1HD3w0ioQe+umlCnXG9VBdoMXVevgbwpaLOk3NvrLgsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx26TTgAN8NoGNQbdJ+CMmxXOWc3U0lHRMYz4ifXh06VfPCUY0+
	Tz7jQefJaV+u4yjtgxC0mHY8DFpTwv5UMZSb+1PV7PxYI0WDiVW/paLIuRQVQ10WdduRqjRaKhI
	l1eWPij3KC2IvrSQGLnhMURIDmjF1k55augDw
X-Gm-Gg: ASbGncsCpitM9Zm2XVb8f/wc2mtMcOJsyd2ji76ybvDvMkuPXcEP6+4h+faA9ZgNf0m
	YgctlDi24YVfEOl4aN8k3diG7WDD+794aCaW0hP1TWud9ISvpYJ8/wSgR/LF5rzQTB/75jYPjXv
	xTUK50aaPo4o5athf+hSVTTK6qWapWskHLnJkzvASbvtrw+LbizXOr9cC80w1eoD1WEyOb8zyzu
	BUJ6KIo45HQ6gBlkGamqNh3GQIVp3hFbg5fbq70cQ==
X-Google-Smtp-Source: AGHT+IHzYnj2t0StXyiHnTT7AmBDLHvyVs5VmB+AUx/CTQwaqmFE5NjD51Ls4fjvngJ3ybeRwbshDtvTMQF8qgnMbII=
X-Received: by 2002:a05:6512:3c8e:b0:55b:8f40:32bd with SMTP id
 2adb3069b0e04-55caf34c5bfmr1035444e87.33.1754494464775; Wed, 06 Aug 2025
 08:34:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806082016.14891-1-pranav.tyagi03@gmail.com> <20250806082933.4c1240c1@kernel.org>
In-Reply-To: <20250806082933.4c1240c1@kernel.org>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Wed, 6 Aug 2025 21:04:12 +0530
X-Gm-Features: Ac12FXyFmqPogFZVuBbAAVtJwDwboWX38L2kXniEux0YesnBsfKWjaAg2UPcZOc
Message-ID: <CAH4c4jKB_oTHDN6tp_ujBY_mNOyY_J60RrNFiFKXf=H_OCMPEA@mail.gmail.com>
Subject: Re: [PATCH] selftests/drivers/net: replace typeof() with __auto_type
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, shuah@kernel.org, dw@davidwei.uk, haiyuewa@163.com, 
	axboe@kernel.dk, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 8:59=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  6 Aug 2025 13:50:16 +0530 Pranav Tyagi wrote:
> > Replace typeof() with __auto_type in iou-zcrx.c.
> > __auto_type was introduced in GCC 4.9 and reduces the compile time for
> > all compilers. No functional changes intended.
>
> Yet another unnecessary compiler feature. Please no.

I understand. Thanks

