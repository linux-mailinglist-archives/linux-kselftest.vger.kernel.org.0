Return-Path: <linux-kselftest+bounces-40290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B10CB3BCB4
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 15:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622C7176B47
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 13:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC8C31B11B;
	Fri, 29 Aug 2025 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F99xqAo7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F63131B130;
	Fri, 29 Aug 2025 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756475016; cv=none; b=VEyfqNDWjFMo0eV2SrH3Fxp4xOjALzFOeEGgy3B2GRSTtVgKlEFiCXuw3ZjKEyzPXOK/faJCYHLtITd73pBD4QzVOLUAE6MwFtyr/+WfEFd171NY2DCW3dfa1q2nwlFafefv/ld1iBY72l+lM483KeeC7iXcdkz5bdC5cqO3Fu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756475016; c=relaxed/simple;
	bh=Za/NTsAgN65OtD/xMe6XpI2G891bowpfGVGLSzZnsFs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQseHtRVTb2tXz5SaD2NtouEZ/uOCgj2cWX6P4vKtVah09Zqws5BE9GV2mCDoaptI/UPd0abDnMTvugKuI4qiiAXYk/K0f3F1zaHO4lxdv7Gi5JaubkQGPiP5Fz9VusKRSxxBjronjtOLccg0gWqrDSbI6pq7XGYinoUYMxaK50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F99xqAo7; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3c68ac7e238so1047276f8f.1;
        Fri, 29 Aug 2025 06:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756475013; x=1757079813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sB0WKcU+AEBRmTb1+TJyfsZxm+o7y+S2VY6/KiNlNcU=;
        b=F99xqAo73c8yUu6afnG4WI3zAHEthi0naFG6+EHSWxC2XJpvLlRSrNgs8yD/JXhnkA
         d+FHOXyc1RLiz6OZoa1PtYBZ+EySaVHgkKjHsrPPfpAVkxYBIud/M45kUcpmRusRq5ok
         jbyWtWV/9U7ycFDJYqKkbTdsbS2hUkhACiaOxhTBTHjLslIXxxLumMNOk8DUDOQPi3nM
         edcgk0wIlWAZcRV+6I+pI51Okm8S1q23rw3jhvdZPwMFHD48QP6p/4NpcM92Acr+8iAa
         YC0h06MCd7tu6Pdt6vmmc+JfK8z1dIQpNDPl6yhpH+qqUi5zb1w2wTHYySN3MtNcH61S
         QUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756475013; x=1757079813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sB0WKcU+AEBRmTb1+TJyfsZxm+o7y+S2VY6/KiNlNcU=;
        b=ZDIKlR9wS/1+HznIYsOHOc5HEMOYG4pdRf5dRmhaz6S0Y0bU6vNiDlLCYEW1gS+daz
         axto/1KquDdVn3+fnT+kiYT43Hu7phYRCYs7Fs4MIfCt4/GNQ8ahJXI2gWwZYltoTkAS
         sw6kJ0BYegJpTvxsHr6gLpZhMwaCp9j+EZl0sNEhgbAAciF+2HpdGpaJJy5+Or4lVk5A
         QnUrAsqfHU5WZCJ48Wuu2wHMNM04llQhnIY9NFO+zCWz1l8c/A8i6/XWWl5dsnbu3bi6
         QzfjoXjYQOcgepvxSPwUt1aO97scVeNZpzJG6LgSLn9xnvuG58m4GC90rgvJINdK6dB/
         WPww==
X-Forwarded-Encrypted: i=1; AJvYcCVMTx9ApbvKN7GgLpYUupYDGNO2fPtQft7ZatyjIqzanD3UitCc762qKmZexGWeAsq9IAA=@vger.kernel.org, AJvYcCVezHvnZ09LjaOx8WdBn5t+GFDL6SaP01bmH6tzpt+BzgiGNysxSnGL/K4Rn0XnccKKPJD57Dks3MRsE1JS@vger.kernel.org, AJvYcCVu8uFcwIE9uYB0sX1i2AHtaDkKgZIljwWjwTL+YSigRp0+coyIur7fgejC9C4blaZpSnw5w2itsgZjo2imtJ+e@vger.kernel.org
X-Gm-Message-State: AOJu0YzU8yVzYiOrszQGjK2vezE7O2qqyMo4IJhWbu/vAPgOmqRoKtb7
	6nWyKIYrqtPeUgif44Vz2M+w/QPnDZ8RyNnIZWuIl67fDgiFwBsDTRmN
X-Gm-Gg: ASbGnctotSI7QlW/wotZ2OFDCjtj8YLojB/8k0K9Qqb52Meo7TO7vLPpN1mUefnqLJ/
	ENAdzy2+luMGDOimxS9GPe96azOly0PdUwv4J82cPny6WCtb6jtkE2IetSS76iGsDo4nU+4FJKC
	HNR79CsR+lFeWKXfevA6Jh5FPJzKCh8L3JGUrlAan0ZUi2AB6jPeWdjYY/WK71OvBdISRLnTqw2
	v/++NUB+hBZj9tPw11UZl1Oa2a6b1xK45a2ZLi3rA+SIEHVJNgPQQfYh7EOeg+/q5zLqu3wM3n2
	780kiRm5Hr1MoY2D/8ZOVMcUcA2/pv+e0VRg3mJrV7vakopQfoXd5AGuw7cOitzpwpsU0KcbELx
	d/OCBnTXRYLoQvPAjwsJP
X-Google-Smtp-Source: AGHT+IEFoAYjqpy8YgWQqICxqDxaYy0+7IShDLWFFW3sHlW2wBtsL+faEarDyULa+yB9wPHyNTncFg==
X-Received: by 2002:a05:6000:2c05:b0:3ca:4e3:6e91 with SMTP id ffacd0b85a97d-3ca04e3774amr14035561f8f.26.1756475012355;
        Fri, 29 Aug 2025 06:43:32 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e898b99sm38833525e9.19.2025.08.29.06.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 06:43:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 29 Aug 2025 15:43:30 +0200
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, andrii@kernel.org,
	eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	shuah@kernel.org, yikai.lin@vivo.com, memxor@gmail.com,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: add benchmark testing for
 kprobe-multi-all
Message-ID: <aLGugoKpnZbVPYtC@krava>
References: <20250826080430.79043-1-dongml2@chinatelecom.cn>
 <20250826080430.79043-4-dongml2@chinatelecom.cn>
 <aK4BiJduYDsw7e0m@krava>
 <3664215.iIbC2pHGDl@7940hx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3664215.iIbC2pHGDl@7940hx>

On Fri, Aug 29, 2025 at 03:01:41PM +0800, Menglong Dong wrote:
> On 2025/8/27 02:48 Jiri Olsa <olsajiri@gmail.com> write:
> > On Tue, Aug 26, 2025 at 04:04:30PM +0800, Menglong Dong wrote:
> > > For now, the benchmark for kprobe-multi is single, which means there is
> > > only 1 function is hooked during testing. Add the testing
> > > "kprobe-multi-all", which will hook all the kernel functions during
> > > the benchmark. And the "kretprobe-multi-all" is added too.
> > 
> > hi,
> > fyi this bench causes panic on my setup.. very silent, so not sure
> > yet which function we should blacklist next, attaching my .config
> 
> According to my testing, the panic is due to the task hang.
> With so many debug config enabled(KASAN, LOCKDEP, etc),
> the system will become quite slow. What's wrose, there are
> many debug function is called during fprobe_entry(), which
> makes the BPF much slower. If you wait long enough, the
> testing can still run.
> 
> Add more symbol to the blacklist can mitigate this problem,
> but we need to maintain many symbols for this purpose. So
> I suggest that we only run this testing in product kernel.
> 
> What do you think?

yes I see the same.. I think we can keep it and perhaps make
some comment about that

jirka

