Return-Path: <linux-kselftest+bounces-39198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 319D1B29A63
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 09:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67AD1B23099
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 06:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F682798EA;
	Mon, 18 Aug 2025 06:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8hAYZjN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65B4277C82;
	Mon, 18 Aug 2025 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755500222; cv=none; b=D3UGMIHDGvB1qQdBanDOguQH9cn/bm0jh4D81WwrF/CjGY+00NCFgd9E4smpNoozJXQAbnhdcE9Az08/h5BWhx2q0anZvOTtK8VM4BwcTdUUiFasCACzdNqAI26K9KnR5XMxgkiBK9al1v6vWiXWWtXNZpC6evRuLn7++hwaIbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755500222; c=relaxed/simple;
	bh=5B5ehd/ybTumioQAMnEZCPlDsR0Umh5x8SN3YdJ+EWM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzsVi1faNwxB3lC7kfO9EAsd99j8SyZrioxvw08grTVjsL88/o0X2DvOmWFSnUkyT/tNbkSTS8GWqlLXQzaWkTiyqN3BdC9S1mXLEXjCAfwB3FxJ/4EHeMJoifd56o39tcfcDXJl+Ulp08Ex3RdKWwTxkWao7uuMDupwwShp0Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8hAYZjN; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b0d224dso18310275e9.3;
        Sun, 17 Aug 2025 23:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755500219; x=1756105019; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EX4tIPF+9pA1B1ujJvfDs+/G2NtAVR/2RXmpw0nl6lk=;
        b=i8hAYZjNvnyf1LR8YOeIp7CIZ0JxSyUMQdf6wxAX1k6q5W98UpMzt8RWgT75qtrmrS
         Oqg18MdrQrVU6uFfokzN+Q6FpB1MnkbZi9FhvUhVwuuxYTzD3afjjkSbUA5dGmXbFd3k
         FMyp/vfZQa/FENX/hVnMWCS+C+FmgWvXVOS9lPAr2xK0phDihXM6w+jj/1CaxvBRK5DJ
         +Ltht7cKyCIcc+NjOOx8+ZlnuRQbu5omvQUbYdQlRsn72fGe7UT46ZOFYUVKzgybeiqj
         fMD8E9mcM32jPBYRu212MMVJDn3ZS9PlgYN+NRS6l7s9qE01tCP6Twyt4iBySxZBaWBG
         gHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755500219; x=1756105019;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EX4tIPF+9pA1B1ujJvfDs+/G2NtAVR/2RXmpw0nl6lk=;
        b=D9xNUMh/l4ti5/XmafOJzZjrHEcjy5OSW1x56ODn+WsAnfb/R4cIZcO04cWH7k96tR
         tBueLHCk+Rm/htJk0Ef48BONx9/QYqGa+FAhQ2sTUC82Sq/+ADfvMLCTLkUZu4dr/6Q9
         +B19y7smY/H0GvJTiDGLNMVGbE2bOkqa3M4Yuql0KWTMCswnm42Nl6pf2EPAb6c2oySp
         sR0a88o27NRr+nA5hY7hXJI1v7XzVP/ulR2Tvu/u8KavgB/cy2Ey5Fk3KXMBjs7VAgoY
         zlk8SGnJok52hWWf2XqAbwjhTYoaiOx/eI8/pBbO/wHbt40jSgzpN6v9ygI+G4uuAY4y
         zjpg==
X-Forwarded-Encrypted: i=1; AJvYcCVJxIEARLwg1LVRCwlXNMEOfD2/IoWeD4ZsoF3FIYl0UyJKd8CHklSziqFgpc/quKDzWS4YdDCHzIfgVivk@vger.kernel.org, AJvYcCWcNjTESdCUxAesHmLXr1qjHsuQ6zgAvhSWLsYjFWeZHZO31QVbEAVGxe6v3cCdiGATUKg=@vger.kernel.org, AJvYcCXwQ2HCixeO5h6BODeusLrhkpebSzx1Uh3eklyR7euvjHjYveEycjco0DNmmq5pFW3iYuaA32blo/50PPZKMBiQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzDlRjBEOlj2H2tkKYSq+9AxNxZNjpcuFwf5Gaq0nIQ6zfCYf3m
	4pGp2PC7wmuZAVNxrN/usAFkxF1ybjSYToDR58CuF4abhpGvTbGHcd2g
X-Gm-Gg: ASbGncudS6n+/hMtv0FPV7aMWaWOCveeJjvrfMnjx+Fc887K1qoFWEvwFiUIDkrO35s
	bRrPtedUpb3vko83v+V15SsZP/iduRbQ97kvsxFeuxr8acI4JiFW0nwJKVOfEPDoljCfJiJHEx5
	qshyPA8IyrApllLtcUt+iWkorH9tXOTt/d5j+LEmhHyBCVOMCOcLuuPUcWOZqOgMGAj/PTwobwD
	nAMeFm750GsqT50x3JprvdyUMqef1Hq0r64ZICk9PZtBaE3a6Z7O/X1iEmo2yehDLPKwZTdC/rM
	dh3CWO6lPN7PyszAlt57lJNcMYTMMA0cZgTCF/SWv/LHkP+0Tuu44IzsuyVJdZB+AhQHXdcl
X-Google-Smtp-Source: AGHT+IHkd8i8YWmwuqUt6Dd9fdgrOhr29UsN7EafxxS8WuXHYyO+kPtvNtcQNMZmn2uUsKeLfd40Gg==
X-Received: by 2002:a05:6000:188c:b0:3a3:7ba5:93a5 with SMTP id ffacd0b85a97d-3bb671f6b13mr6913879f8f.26.1755500218688;
        Sun, 17 Aug 2025 23:56:58 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb6475863dsm11926662f8f.5.2025.08.17.23.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 23:56:58 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 18 Aug 2025 08:56:56 +0200
To: =?utf-8?B?6LW15L2z54Kc?= <phoenix500526@163.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, yonghong.song@linux.dev, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH bpf-next v10 3/3] selftests/bpf: make usdt_o2
 reliably generate SIB USDT arg spec
Message-ID: <aKLOuLGY93zYXbxA@krava>
References: <20250814160740.96150-1-phoenix500526@163.com>
 <20250814160740.96150-4-phoenix500526@163.com>
 <aJ8rsK2-XcPXNX7h@krava>
 <5f3a942c.1b6e.198b1b181ef.Coremail.phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f3a942c.1b6e.198b1b181ef.Coremail.phoenix500526@163.com>

On Sat, Aug 16, 2025 at 03:04:17PM +0800, 赵佳炜 wrote:
> 
> 
> 
> 
> 
> 
> Hi, Jiri. Sorry for my oversight, the optimized compile condition didn't work properly.
> 
> Could you try to replace the `__attribute__((optimize("O2")))` with `#pragma GCC optimize("O2")`
> in usdt_o2.c and verify it one more time?  I guess it'll help. In fact, the usdt1 argument spec generated 
> by the `__attribute__((optimize("O2")))` on my machine was `8@%rax`, not `8@(%rdx,%rax,8)`.
> 
> For more detail:
> 
> > - #if defined(__GNUC__) && !defined(__clang__)
> > - __attribute__((optimize("O2")))
> >
> > +#if (defined(__GNUC__) && !defined(__clang__))
> > +#pragma GCC optimize("O2")
> > +#else
> > +#pragma message("non-gcc compiler: the correct probes might not be installed")
> > +#endif
> 
> Thanks

yep, that helped

  stapsdt              0x00000033       NT_STAPSDT (SystemTap probe descriptors)
    Provider: test
    Name: usdt1
    Location: 0x00000000007674d9, Base: 0x00000000035bc698, Semaphore: 0x0000000000000000
    Arguments: 8@(%rdx,%rax,8)


thanks,
jirka

