Return-Path: <linux-kselftest+bounces-28960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53794A5FB3E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 17:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527BE18851AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 16:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F012268FFC;
	Thu, 13 Mar 2025 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YzbL2TXj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0DA2698BC
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882514; cv=none; b=mOzyLZdL4iR2uF5PiQeMX05XaVAN6X7bxGF69jqqd/MHa++KAEG+nFqi7Cm7M/OyDtAwsIXhz7je7p/jk5qvDYrq7Q3DP3JEf+gE4AEA4cTG2s/aYc2WyA8A38nh6aQQW6HhR81aCCQ8+DB8MiBmlwH9twSeIC3xjZcIlOcQguM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882514; c=relaxed/simple;
	bh=zmD7MNim/3VQcYsraUusSjJsXZ6QwmA46ppNX6yBUok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZx90PVSQSs+0AeyeFP4MQevrPYURPMIIzR7/neSqeKU8Nib20wTLLttNsJnUmGcrvkoSuRA2IIYki8VVYQoYGmi05HrRNZtvBhRCfGdaCy4HSymFKH8Tep8L6qCXwD1uUDAWIvaLtlDn+aIrN5Oo1k/HowQG33kjWl3RB4KyRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YzbL2TXj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so11184435e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 09:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741882510; x=1742487310; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zmD7MNim/3VQcYsraUusSjJsXZ6QwmA46ppNX6yBUok=;
        b=YzbL2TXjNxPC1MpOJKPZbWgVRSsHHkX7SjRF8BsSFzNDRw7TIP6B+xE8/UbkRBObNF
         OR4t8OkADAf2zWYNZAfw3lQslpr0/Axkabj7znVOCem3qAAViw4IpuXylXXOgxFh2xI0
         HIQziRZCP9RVPCiintT97RjXKhTC7+Kvwc5kvbC/mf+6qEBojh0dylkWH+nvuc0iZBJ4
         NMkkVSnDTt6l4MEBRz3t7gXsWzoANAEQB9WgNKEGcPax7WXdXv8X1Clbzsg6Z+hzZRdK
         o0vrM3UR26YE43kVQOdBzkjE7T9+4o41BLpuq9xDzEbqtUfU77c2DdkaguVPc5qDzzNJ
         FjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741882510; x=1742487310;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmD7MNim/3VQcYsraUusSjJsXZ6QwmA46ppNX6yBUok=;
        b=LR76sjIkQqQ1a2qzr8olig98f+/Iqu88/eWsBogvrA4Jz6SsCxvNyPq3LNMl1JDQx6
         YON3zZi3SFuCQGJTLnd7FSd8z5kBCXFYBrxZYCHg1BY9ko5hdwC0P8axMM9ekRlEpsYz
         K4VH2t7Af3qqNUW17fbxMYFNidbR9pSJXfvmKg+VrghydzMg1hVIoGN/96YgHRSZNamp
         b50pzd56HgwcRNehXhteUE4793V3A6rodz5IXjV1eOvmggN/cwfKwzAR/uLbfALDUqY6
         Dt15KYOsOoWcKr8eNIOvK5MuWub12Gg4dDA1cMa/MLLMIGYWVbrWy6YdjafdZYU43aum
         tk/g==
X-Forwarded-Encrypted: i=1; AJvYcCXr4t6bE+RPtvNMjzX0EbcJ7SK4NbKpXo/WEigNLHSo+7Otf6QHRmywuXqrR7YsB98zhSCY7mDaqZOLvNmljVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzv3FmPF1sjue4SOnAwn1/6v/58AazsGJSyxF8IPRbRGCMQXHS
	gDRi3/cUAczeMq19P2HhIS3PxKgopcMv4nIe/2LGqO7NB7i/Yvf6c2ysTjn5r6U=
X-Gm-Gg: ASbGncu0k33YqbKg+ttRljGqW8KZDE2VTNz9FaL29nsBiAcb3TmSZeFahl2ncBrAEPS
	D6IjE0CXPZlc0z8w4FPvyNkHCLxglW2wAesMVV0S7xTMVkX938ZEq30OgAsw4MB/jpnwud5DsOc
	ibJWC4HHKgtQOfyN90ztiq7YFJOOi894RwxtJJcUasq+8Apwe/UjjffOU27u95Btxc4W3yi8xF/
	qQV961K0NTtz9KzvCoLw6G0QXHSc5/pTg+tBfmh0QS98IXn5yxKfRtpRk5ipSMbi9ZGoMd3H7di
	8+L1qmqrLYBTGdRhf8/wDEfFCK5ODh2J10NMwV9gWravi90=
X-Google-Smtp-Source: AGHT+IFjIwacJKCHP0dnkNtlm25kdYN3UhdeehaflwmpbcpOVEH+KkVK3wJpO9PY4hmEX1fJPFgkvw==
X-Received: by 2002:a05:600c:3146:b0:43c:fd72:f039 with SMTP id 5b1f17b1804b1-43d1d8afa48mr3000805e9.11.1741882510053;
        Thu, 13 Mar 2025 09:15:10 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d188b0cc7sm25704255e9.3.2025.03.13.09.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:15:09 -0700 (PDT)
Date: Thu, 13 Mar 2025 17:15:07 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>, Kees Cook <kees@kernel.org>
Cc: Arpitha Raghunandan <98.arpi@gmail.com>,
	David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org, workflows@vger.kernel.org
Subject: Re: [PATCH v6 0/3] printf: convert self-test to KUnit
Message-ID: <Z9MEi-hWiGf9W4gi@pathway.suse.cz>
References: <20250307-printf-kunit-convert-v6-0-4d85c361c241@gmail.com>
 <202503072046.34DAF614E6@keescook>
 <CAJ-ks9kTO-u+Wqp0K-vdMLAs08fBeoovSeb_pGkMjSHFnBKysA@mail.gmail.com>
 <CAJ-ks9=zHBmOApsqa=UZcKtg1cH0tp34Kt9_5AEJ7vzwt2QeOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9=zHBmOApsqa=UZcKtg1cH0tp34Kt9_5AEJ7vzwt2QeOA@mail.gmail.com>

On Sat 2025-03-08 07:52:49, Tamir Duberstein wrote:
> On Sat, Mar 8, 2025 at 7:51 AM Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > On Fri, Mar 7, 2025 at 11:49 PM Kees Cook <kees@kernel.org> wrote:
> > >
> > > On Fri, Mar 07, 2025 at 05:08:55PM -0500, Tamir Duberstein wrote:
> > > > This is one of just 3 remaining "Test Module" kselftests (the others
> > > > being bitmap and scanf), the rest having been converted to KUnit.
> > > >
> > > > I tested this using:
> > > >
> > > > $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 printf
> > > >
> > > > I have also sent out a series converting scanf[0].
> > > >
> > > > Link: https://lore.kernel.org/all/20250204-scanf-kunit-convert-v3-0-386d7c3ee714@gmail.com/T/#u [0]
> > > >
> > > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > > > ---
> > > > Changes in v6:
> > > > - Use __printf correctly on `__test`. (Petr Mladek)
> > > > - Rebase on linux-next.
> > >
> > > Thanks for doing this!
> > >
> > > If Petr, Rasmus, Andy, and/or others Ack this I can carry it in my
> > > "lib/ kunit tests move to lib/tests/" tree, as that's where all the
> > > infrastructure in lib/tests/ exists.
> >
> > I think the plan is to take it through the printk tree.

It would be much easier when Kees takes it together with the move
to lib/texts. It causes several conflicts...

Kees, could you take it, please?

Note that %pGg test currently fails in linux-next. It is a regression caused
by a change in tracing code and should be fixed in the tracing code,
see https://lore.kernel.org/all/Z9L5HsVzQ0bVZtjp@pathway.suse.cz/

Best Regards,
Petr

