Return-Path: <linux-kselftest+bounces-31031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C94FA911CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 04:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82A55A0AED
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 02:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2245D19F133;
	Thu, 17 Apr 2025 02:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l9knKAqP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0CD42A97
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 02:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744858572; cv=none; b=U1HVVmXbtD8VobuFRqhr+q5JAYhUoDWztyrHtK84uy1wkl7B0N8J8K8XK9dFP+/zq0GLxEYKSGyWUCPjYMq7mFftH9CbqhnA8/JUeJ5v5f0cnJswrf7UWZv4hmv2b9Dgg7TJ54sZ+FsWPsWqhqx6ZrPxsIJrvjm6wwS6UQ0v2kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744858572; c=relaxed/simple;
	bh=qsfwsVIHH+F/NGmT4ago54kC7hpzRNsfBaKhYEwIaEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OR5axbuUOFSjzUkkd8HLrDDLp4icTIf4lWfLszXwsdeawiKtLsJ93QGyxQbpqwi3gRewwXhs1pXP96d7+FucOA4z9WD2c7V+w2/UW3/RB+/BpluldYiVBhJZUPe/V6LqcqwrTEzlmQ51ikN4/fg3w6EwXFsuhsAmcP7Hyzc1boY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l9knKAqP; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54b0d638e86so381217e87.1
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Apr 2025 19:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744858568; x=1745463368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsfwsVIHH+F/NGmT4ago54kC7hpzRNsfBaKhYEwIaEM=;
        b=l9knKAqP6dvAwAiF+Q56y3R81G6VY2QmqxKnvngZdPlpgK16y2ELrIrIE8synSPyjH
         N9DnsN7rSRbzc05ctTekW/UX3gMGBHaeo4pUjfWzrol+IMR8KM3mbjToIMzTEvwNCzgw
         zwC+YevD4Z6mVHG78U6FWSC0TAtyaiCK91a8QE+1OxnfgPFSOm35OmCK1hHOOPeDK3yj
         hcRMWaL8pepUflth1431VArRxkIqgf1C8UxTmChR6x4Gy4dGScBcHurZWg3RFsPfW72a
         mW80B6w/1hJMF0oTJBVgbC70SM2qJNpDP5hUOhGcPlNoDbnJV+dLoztj80TINvrMXkpd
         U0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744858568; x=1745463368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsfwsVIHH+F/NGmT4ago54kC7hpzRNsfBaKhYEwIaEM=;
        b=VZe9/T3Z2qV4sj7OJJ7JTjbvyiiTlVTWri0MqfuFA6+QvsyiAwaeygf+fCsjCw8pEi
         o1rvswSbLMtxn585mizE9Bqi5mrh1zByRTjM0o9duAQXsKzYjUh7bI31GjweG6BhPhud
         PUDBAUtuszkKXcNUdwNn8+CtqJm+Gry/DdngQAyTMgub4H+YZLCRcCpooeWDt0viTNe4
         yldq9BglOdmFF3dgQpDqWPoJmgoEsAsXUEu13ZZTu3OhWHWWdJKhxT3/TpyGZ89jkIbg
         x57ESAgAi4IKyDE6TaJHFc/w8Ez38Ng4gtPTfY+03SC3dm/RiQZdRJKjntXYaGvedPPn
         jZNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOpXl39qWsWtVey6hLPc7W/ZOTyFoNAlfHsRKTmwjQ8fuJYa0Q9llx/pPl8aCfQ0gOq7Nj5fOxQENL8prkJlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUssqbEQdFy0zld4CCbCgacuCzTxU+jGoHOgfysxDts8v3GolB
	u/xSv2YMi9e3RbdkwT6qhnZRgEDehSS4ViqrJ+FcwiHGKU0nKBKs5BRVm2sJB2qAyWUlKI5btGG
	DnbhqBIdR7ACJL2wSmIuvPDqtaVsUa/eBpew=
X-Gm-Gg: ASbGncvxFD4c8sFKG5X4+Rrgtw2R6I10hM5Y8sLRmqV2RG48/YYnVEnk02VCfsVMneU
	C8kvUf9cuVKzRVFNbHLC6TEiY1k9GBvn0OjVg55kA2S7C8frjPW7VYB+xRCbOKgItBMOxoo9bhh
	yiM19wE2E82YTqJnG5pykVjHwMizGB9RB9IDy9TkZ+OQjRY92QYqA=
X-Google-Smtp-Source: AGHT+IHiWQzzu5QN+eSXGm1qO1fUfiULKdHlZ+2ubPrubYzVuGFxp5+JbQwKV+eqtRJEj0mEa1LtliBkhLvslM9mW0s=
X-Received: by 2002:a05:6512:224f:b0:549:8ed4:fb5c with SMTP id
 2adb3069b0e04-54d64aab393mr1230755e87.31.1744858568113; Wed, 16 Apr 2025
 19:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320200306.1712599-1-jstultz@google.com> <Z-KURRE_Gr72Xv_n@localhost>
 <874izezv3c.ffs@tglx> <Z-Vx8kV4M3khPknC@localhost> <87bjtmxtuc.ffs@tglx> <Z-pKEYr01vEaQDIw@localhost>
In-Reply-To: <Z-pKEYr01vEaQDIw@localhost>
From: John Stultz <jstultz@google.com>
Date: Wed, 16 Apr 2025 19:55:55 -0700
X-Gm-Features: ATxdqUEmknpvxJqRKfqcEecjSX7QDiHSNKV9CQcfs7eRe5qwPAW4T7DARPoZVlU
Message-ID: <CANDhNCo82jKs4Tq8uiqmJvT5JyPw8VQPFg526POooK0O+15-uQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] time/timekeeping: Fix possible inconsistencies in
 _COARSE clockids
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Lei Chen <lei.chen@smartx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 12:54=E2=80=AFAM Miroslav Lichvar <mlichvar@redhat.=
com> wrote:
> On Thu, Mar 27, 2025 at 06:32:27PM +0100, Thomas Gleixner wrote:
> > On Thu, Mar 27 2025 at 16:42, Miroslav Lichvar wrote:
> > > On Thu, Mar 27, 2025 at 10:22:31AM +0100, Thomas Gleixner wrote:
> > > To clearly see the difference with the new code, I made an attempt
> > > to update the old linux-tktest simulation that was used back when the
> > > multiplier adjustment was reworked, but there are too many missing
> > > things now and I gave up.
> >
> > Can you point me to that code?
>
> It's this thing: https://github.com/mlichvar/linux-tktest
>
> > It would be probably useful to create a test mechanism which allows to
> > exercise all of this in a simulated way so we actually don't have to
> > wonder every time we change a bit what the consequences are.
>
> Yes, that would be very nice if we could run the timekeeping code in a
> deterministic simulated environment with a configurable clocksource,
> timing of kernel updates, timing and values of injected adjtimex()
> calls, etc. The question is how to isolate it.

Miroslav, Have you looked at KUNIT?
https://docs.kernel.org/dev-tools/kunit/index.html

I've not yet done much with it, but it seems like it might be a good
match for moving some of this simulation logic (which has always
impressed me) into the kernel tree.

thanks
-john

