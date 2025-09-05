Return-Path: <linux-kselftest+bounces-40851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29959B45C6C
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 17:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA55484259
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 15:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3661F418F;
	Fri,  5 Sep 2025 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1E6vaB7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7238E1EFF80;
	Fri,  5 Sep 2025 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085762; cv=none; b=f27jkDwme6zflrXlDgdfmHo8TAs4Zydr2mYDNu9xResTOdxW/zYJ4NrQ3drtpHNHd89FUHAWpbBPE04bj+9JyTbryNhiSwaAsTqGFKTHBO/l7tgzCEnFGSINsp6PRsl8pyI0rIRX0OOrq5GTjnqxGmS5OZ+AuwjjmcZh8KFMIsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085762; c=relaxed/simple;
	bh=gd5ti4PjlFgLqB7m8Mrz/Nw5mFgiA6vRoQPteFAhGjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKhlV5qvRdLNNacq19OU9oiHZdsPfcqDztVSqkz3qmROwG3zfFXmYCs5efw7NVvyvo9jtsobL0G1luQIcCpZgB5GVNwGbkZGaCIft8Tq5oiPIafOIoI8nEy8D9QXhhd4+XQ80pDLLPqwdhj6DFUxEv1OIH9/oHqS4Dl/l1LhYyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1E6vaB7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7742adc1f25so92784b3a.2;
        Fri, 05 Sep 2025 08:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757085761; x=1757690561; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1oFWysCLxO9n+UTpsNWaem6BffV68aEnOmokMlXI8eU=;
        b=A1E6vaB7VixA1LeuXejGX1xdHRzA96yo9CEq27GMh0n7EwbdYFTQ1pjNz/NcS0t7xj
         7FGVudHIzp1mFgDFCwF5Q3IXBTMUBYdLhic2fu/SeKLOx3llvkcWTs5EpmqAKu49k7TG
         v5BYka+kSHLgCa7lCjRJzXaPOzfOQ64txxYFN975YuIfQGVaLf957ZzZAzLxf50G+e4D
         iW0XiDCstf66k5QOPcaiKGVOWSeDtKVPCDKG0f5oh0PAnI1ttvFEBCKfn1OLiyLO4C/z
         TRx8smVqSwO4+BPn4LJhoTrE947yxcLz67TRXX35AtHEZ7iy6UE05/dO1p0+Uv05lwMh
         1yHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757085761; x=1757690561;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1oFWysCLxO9n+UTpsNWaem6BffV68aEnOmokMlXI8eU=;
        b=wgEkfQuP3Fdt2xJpXQm/IR2oKrzXxbXTg4sYHn1+4DL5IrO8TUxDs+83Wll7wQkgOw
         NKOMUEWtwJnR377IEQLgF7Mgpx7V3FgsrzIbkQoGZMH0v3XPGokUgtaVvapA0KFifAm0
         lKR8Glft34odwjXe4sVjBWLpH4vIMNqcMnJU5YTaz/LerV1286IniY42kyl2ZXdm3uva
         yxJUQzqi+UEgWAAjbKPHwZpO+PnuX8AebzNfKxS4cN593T9Oo/pfxgmEcj8So+bD1htE
         5zS5JJ+hCyfh8z6uJ+YMdW+1L5VXMxyAVxKmmlsv51s7kFOEp/5zMtF8MrWEf9pOyE27
         RPmA==
X-Forwarded-Encrypted: i=1; AJvYcCW2LrJ071BKS0vG1Vyh4kfdeQaNk9LobvlqO4qX28crvlt7C4mJ80Su8jH3v1uNMW72CzomRp4p@vger.kernel.org, AJvYcCW5AhrAHsDeYkPla1t124WkXv/XCginzCXCd7pCJ8tFoACrAqWgagxiCgvSh14KGr0i7EZp5alLB2637wJjDQwb@vger.kernel.org, AJvYcCW9DEuPWPZXDL3VTnOthB0MuX+0t5bY0K62FpJEJOkZT2EJx4bR+nF2J3I+sMNRqkM/SmKe/5OGZUzU+oI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK6TLXGjVwnSdkAUc8baDdf2jsOOePDbTSksEdbxXZwcreMhBt
	DJLIKt0pj++Bvlbrc2uQxJk9W09U4S5BoONJ8FWG30NGvW1WFEUa2Y4OyCZF
X-Gm-Gg: ASbGnct9r61jAPV4uBSHlkSbw/jbLDLyQ/o5Lg0Bk98EpwakvPQPN/W+SbJPeNqCWJz
	zjv0PWyk/HYJJ6oMAAS4t8xpHsEaLsk5IaFHd+4LGGQa2jbhPzhBThp7CJLCC1YxmKFrE+xo4u9
	N4bWQV4JPaZTV/l7gnq742Vf4Ilwof4egn0ir/nV34Be1yLmSCb+YDxZuqjGRPlk0VZJ+5oxp0f
	RUUjniP82kHlQwkr+KvOoxqWloKvzAImH0kf9qTWNJ7DjMOjayTHbxXh9AQB/KSMW0iJeeXI7gU
	qYFzO7werKCSS+UhTfdng36JRJKluIBqmfRUzZTmiibK63CUDzloKQ/yo8y90wnLXH2SJ2PqDlE
	BUIn3JF30Pt0OBWYAd4XHSy0uY5EqV0U9GwElhbNMPF5vlaIdtOxTlW9+dy3NHUmmX2epAs4coj
	l9ULb79g5II4Ls3kv0VR354KTtOOrrcF7O5pJ3frP2mI9jwv5hedx/AITarZQZS2g0AwQ7fQVA6
	I9I
X-Google-Smtp-Source: AGHT+IEuaiqHgVm7q8ldrIIPsG5Sbhz75PV1SIW2xxUI00CEIAhWu/km7QmeT4z2gHV0Q2uneGYM3g==
X-Received: by 2002:a05:6a20:244b:b0:24d:301a:79d0 with SMTP id adf61e73a8af0-24d3048777amr8130890637.38.1757085760553;
        Fri, 05 Sep 2025 08:22:40 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7725f9f7b50sm14112474b3a.68.2025.09.05.08.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 08:22:40 -0700 (PDT)
Date: Fri, 5 Sep 2025 08:22:39 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org,
	joe@dama.to, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: ncdevmem: don't retry EFAULT
Message-ID: <aLsAP-UgtINNwIMJ@mini-arch>
References: <20250904182710.1586473-1-sdf@fomichev.me>
 <CAHS8izOSq+mYmP58eNqC5WFTvXxh+s8gRSrTv6YQdq6jn41pMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOSq+mYmP58eNqC5WFTvXxh+s8gRSrTv6YQdq6jn41pMw@mail.gmail.com>

On 09/04, Mina Almasry wrote:
> On Thu, Sep 4, 2025 at 11:27 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > devmem test fails on NIPA. Most likely we get skb(s) with readable
> > frags (why?)
> 
> I would expect if we get readable frags that the frags land in the
> host buffer we provide ncdevmem and we actually hit this error:
> 
> ```
>   1                 if (!is_devmem) {
>   0                         pr_err("flow steering error");
>   1                         goto err_close_client;
>   2                 }
> ```
> 
> which as it says, should be root caused in a flow steering error. I
> don't know what would cause an EFAULT off the top of my head.

Yea, I don't understand what happens :-( I'm thinking of doing the
following as well:

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 40b774b4f587..0c18a8c7965f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2820,7 +2820,7 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 							 used);
 				if (err <= 0) {
 					if (!copied)
-						copied = -EFAULT;
+						copied = err;
 
 					break;
 				}

Should give us more info for the devmem case... LMK if you don't like
it. If I don't hear from you in a couple of days, I'll send it out..

