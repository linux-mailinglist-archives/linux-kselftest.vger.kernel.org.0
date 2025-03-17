Return-Path: <linux-kselftest+bounces-29204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45707A64A90
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 11:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669F73B29F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 10:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96831242922;
	Mon, 17 Mar 2025 10:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M/rT9Yt+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4682E241680
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207700; cv=none; b=ZvjGYk2jzU0T/ZWwHnpfzjGw4csTEj9nWZK85quzvusx+Khko9Fl6IPjt1wGFzVRnlNqUR76hsaXGjW0NhvcNp/6qpOawzUFY8gJhj+dLo/bz13JN6n64fCLu0FSyA41YI/6O08ThV0S3t3hU9nvfnQivB4F9NR7/GLYGNpuj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207700; c=relaxed/simple;
	bh=Of5SO/kOuDWzPvH7jgul/ATKgBMz1+uJud1GfXwBsTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFoTzstDrXiTsO4ebQ7Vq7Y0CqlwlwYCPno/THB9nk9DpaQdu91OlJciMBviQe0Cs8UYgeLKZdhHpzenSsMYoXOaMr+5haAX8i8/jo4hpmquDdAnwM6bFQPqv4EyfxXWprFufxjf8OnQSMS/H0Vt49ri08t1RFQzzjH3wEpHzBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M/rT9Yt+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso3587606f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 03:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742207696; x=1742812496; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l/OCIBGi+QQKAbbyEwfquW9P06SxRFDLjeq98QTwp5Y=;
        b=M/rT9Yt+zbFHSBi1gr6bTDp7jlX3+q/GoHoSFsEI3f8d7CkkSm3Qzg2ex6TIrwPbbt
         L4TtFutxgvrc85StoDbpMjrv7A3q1Li2lLXYSsVrgNK9lm2IeZ8LuvDuWA7kFK+bdWs8
         CjsP+vJR4X4RHXaUazbN2xPmbUq+eoTZuOD9WDyY1GjQrNd4PcTKzEivBsmUxn7y9nPF
         /vAsqN/QJ/g3JU8jjDo3t3jgN2wdLp94mJzj3zIF4YXcU6uwGZtarK64KBerIZetg5RW
         LWsYPb68HeYvN2RhK3Ir1IqvpAqQk7Ck9H7mLaE0VpeDLLwbsgdQ3ORNdaiU+HrqLMKJ
         lcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742207696; x=1742812496;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l/OCIBGi+QQKAbbyEwfquW9P06SxRFDLjeq98QTwp5Y=;
        b=uQr3puSyan3GeBK8D78pNeVdNgh+nolEKrpx47yN+F49uBOPx2bKtZfC7bEXY+ynYy
         ca5YBnd/bqxS6/woNGLoFW8pzxe5nd3yHC9S9Jl5f2u9e8xCjpIHCUIh3EWPRHNKrzsD
         bbBlH8pItwFQ7gZ3Osrgxu4HNh4FF7PPXoa5ZKrjfEXsW2nkHvNduwwXO03OfDbJUWoC
         scTiEX3LMFnpyuh1m4BmuO6pgZNf9yHMjyXSO5k1HKM8iZPnY11KV5Dx0cIPkpAxaiKP
         wxO+Bm01bF0ZQdTnW2SgcyuDRkWeFlW4zWwm5v6C15bbywcMyLOKFZR7X26QlgYKTSCw
         8x3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUM/kH0Xn6ogWeCSfO82fFf9bCfLpVZjjSJBmikCMWYC6t8MIff1EJZm+lqmOzWusQPf6aSGZ10FOGoTrZWuDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVLZ/1RH46eST81gj9K40Ref8n3yjDoMcVrK/J+JNXeMK8HFfT
	HajA501/C+XE6bD+/vDZl7Nwez0AVO7GGelzTBEr/14SlsgYFgjtq90SEn3rm6s=
X-Gm-Gg: ASbGnctA+3Wc8NANFHojjLfjlRtnC/ZGht5OPh25hPnv8ZWVcd+2qFssR1qk0K3ftUX
	i9n01YNIJCw65J3AdFCKRkt4s3WhAkCtKWQK8VX7RrADjERSYuuxJCgAQE414xTaI8YdZ7d3jFa
	PS6g8XhCBPKn67hFI2mqJ+GkyslAsNL3qEcWqErnkf57QAVT43cBYa2QMPoxklV9NmcvWrlOIUe
	fGg4EaUlTgexdx++Jg80F75EjjjBkbAdq0PcQGLZLQaqpPm8U3Xo/Sx9yIjc4/j5/LAC3Twjps9
	lc/0+Bjeb8xnbWMRaSkkOg9HOogC1BEApdDVf7mHi4lcego=
X-Google-Smtp-Source: AGHT+IFUetDwdpPXZ56ZmMu09Y/xpUhEIp8BG5ohNi+1XsYZzAjOYO0qpVFi5I1pgbI1u+vznJxLSA==
X-Received: by 2002:a5d:64a2:0:b0:391:4231:416 with SMTP id ffacd0b85a97d-3971e9720e5mr13342344f8f.36.1742207696411;
        Mon, 17 Mar 2025 03:34:56 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c4f9d59dsm14583380f8f.0.2025.03.17.03.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 03:34:55 -0700 (PDT)
Date: Mon, 17 Mar 2025 11:34:54 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Kees Cook <kees@kernel.org>, David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v9 0/6] scanf: convert self-test to KUnit
Message-ID: <Z9f6vYanql2xqbJw@pathway.suse.cz>
References: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>
 <Z9QvRJE0Yun5mfsN@pathway.suse.cz>
 <202503141345.0D3FB87E3@keescook>
 <CAJ-ks9=zFuH=4Sm-zqR_kAuv=fmwpCh__fXgxcoRgc5XuQ46Fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9=zFuH=4Sm-zqR_kAuv=fmwpCh__fXgxcoRgc5XuQ46Fg@mail.gmail.com>

On Fri 2025-03-14 16:50:43, Tamir Duberstein wrote:
> On Fri, Mar 14, 2025 at 4:45 PM Kees Cook <kees@kernel.org> wrote:
> >
> > On Fri, Mar 14, 2025 at 02:29:40PM +0100, Petr Mladek wrote:
> > > On Fri 2025-03-07 06:27:33, Tamir Duberstein wrote:
> > > > This is one of just 3 remaining "Test Module" kselftests (the others
> > > > being bitmap and printf), the rest having been converted to KUnit. In
> > > > addition to the enclosed patch, please consider this an RFC on the
> > > > removal of the "Test Module" kselftest machinery.
> > > >
> > > > Tamir Duberstein (6):
> > > >       scanf: implicate test line in failure messages
> > > >       scanf: remove redundant debug logs
> > > >       scanf: convert self-test to KUnit
> > > >       scanf: break kunit into test cases
> > >
> > > Kees, could you please take the above 5 patches as well
> > > via the tree moving the KUNIT tests to lib/tests ?
> >
> > I think you mean 4? Sure!
> 
> 4 by my count as well :)
> 
> Please let me know if you'd like me to respin with conflicts resolved!

Yes, I meant 4. I am sorry for the confusion.

And the list of pushed patches in the later reply looks good.

Thanks for help.

Best Regards,
Petr

