Return-Path: <linux-kselftest+bounces-26408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7281A314E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 20:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22DCC1886850
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 19:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E641E4929;
	Tue, 11 Feb 2025 19:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INB9sV5I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBBD263889;
	Tue, 11 Feb 2025 19:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301715; cv=none; b=kQWK469qomm8io4EDwKBY1CD8radQGIik0mk4aCB+3kxsY2iVJcXTgFbSoMsSdhzTRV7EcLBiyUbsR9nkGYmdCWrge+IWo55ZNQGsKht1a5onfxRoCqyz1Nl+0oxVM3E+B8pJL7lWNp+Kc+2m/gyVYuErBaKa+hmeYMwULzTUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301715; c=relaxed/simple;
	bh=tgtV+Wa7SeGMVxezIYOVlCAkbZVBWE2HOEvollOng80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTdcwFi1UdbFnAQki9hIJHoclOddHWF4QbLz8Yt/syiOE12nT1Aq84GZazmhvD9AbhIeXwvy3ptu9xD3crju72eEpfGcrY0SOiW7Mw1N732w5bRRaf5EGWbTmiggVK7G0UXhtgYpnIogNKnH8sAi7Bou9JE/xx9lADmz44RzlCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INB9sV5I; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-308f4436cb1so739381fa.1;
        Tue, 11 Feb 2025 11:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739301712; x=1739906512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgtV+Wa7SeGMVxezIYOVlCAkbZVBWE2HOEvollOng80=;
        b=INB9sV5IxCGqMUFCo7LUffCLD/uiC0SxLJOqQGKq0s4tDb4IOBv5z0QMfTKHO5FT0i
         6EbAWHIUEb7CSjTSVzDCLwyQeVx1pj7o4sOPNjlDuBYynDECCaB9A0/VZ08fTONSBomG
         ignQzsGl0t6kT8FpSL4B+A0xtKy5QblOl7094vuIc5VjdPk6xXCYWPb6yQcHfAvdUzLN
         v7SAPxx4z76FIOWYLFn4fln9l2KJjxbNVRMQ1Q8DPUMGE8nTAL2zAqJkBW0pLO9bT3A3
         Ig5qGRZ9YG06st193W3IDiTqqvy+yb97CjnOpXuduCtjU/IdH+5LBOIRqCzLfFGG2Vzg
         jtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739301712; x=1739906512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgtV+Wa7SeGMVxezIYOVlCAkbZVBWE2HOEvollOng80=;
        b=ULu/0jPfOQoMsG2+BG4NPqOAoLJL28C6ZGaVzZsHpRFtjI6lwV9NOo2ri3SHA1jBnK
         NkbjKIaFL60s+t901q+NkaVZn077LQhAyZi7t466nKyav8u3kEsZSOHQXZaqMVbADwyr
         Lxw7HrQJO387hL7hH/TYiizp4Z6DENQxjiHGCHOB/j0+G3QWwx2Nc5gUH5JBkztcoCfV
         v8TgUA0x5CjhhlSDZyBEuqGNLtr5hSvIqNyNn7jzWPDKcnKBlPlxuHppwax8Pdt117UZ
         3ig5RjeHwuFgqeL5YSNkAM3pYly/spvCkWigEGswPL4/4evffPCIMvJVROfd9e3YlrDq
         eEFw==
X-Forwarded-Encrypted: i=1; AJvYcCXMKfENN2NYy3uFL1MsBcN1lMQItSCLHk+jrqwKTSjWjsduQzvclWH8dwPxEMOJqIzEkzTK0xT0WSq/a9U=@vger.kernel.org, AJvYcCXQfUstx1sJpqSsSgtr7HuPpinsXJt2DjTNApVD3mUPZi9IzdOr0lE4cuYMROdh9kxKXxhIOAEs2RYyqVb1korg@vger.kernel.org
X-Gm-Message-State: AOJu0YyoFZ7iI484rL3jFezwIthZnuRX2P7yifHD9+lqWPScpQMeBxaQ
	BItWjxdegq173g9mo5cwEFeT+6hZq9LYMQPffsa/qlC9PGpdWhKfKp0fS2F6t9zU+whq9p4bevx
	QE1KE4UtbEqS9XkK/LkK/0tnnmCY=
X-Gm-Gg: ASbGncs1FCXRJ+lBERSyz23PbqStJxLewLFYSa0wGfw3JGAaq1Ng7dfCi9H4iSx6is3
	RuPXgXUrE6QJuAT6vtlh/D72Kv2jfWr600H77Kwe9wYUHfqCTu0YhDxuxEYjMm+miFy18xTzmmu
	YNwxd/EAVat1ZO
X-Google-Smtp-Source: AGHT+IEKJAzutbQRM+DNEY/sK2iNGzebZM0+/CFesmtvWA5xbvrBToJwne6Nsp1ZZPn1QsgYCsv7TokRO6AuAuLytUw=
X-Received: by 2002:a2e:a78a:0:b0:302:49b6:dfaf with SMTP id
 38308e7fff4ca-30904632510mr659631fa.20.1739301711976; Tue, 11 Feb 2025
 11:21:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204-printf-kunit-convert-v1-0-ecf1b846a4de@gmail.com>
 <CAKwiHFi6SUCT7UjUTdKmLJ8kiAEqVg=d6ND60R05MJB85Eoj9w@mail.gmail.com>
 <CAJ-ks9kLmArqqPati8n0dwzhjccLmTuTHtkaSyf_F_1QXzCoRw@mail.gmail.com>
 <87bjvers3u.fsf@prevas.dk> <CAJ-ks9=0+fk22Dx-65a+CSYhy0dnjTJuot9PtgOCi5Th1_wARA@mail.gmail.com>
 <87y0yeqafu.fsf@prevas.dk> <CABVgOS=dfuX+X8=EVHcrCZnbOZj3T+wGD922eoeHb-dcOmmzXw@mail.gmail.com>
 <87h650ri08.fsf@prevas.dk> <CAJ-ks9mKZVSZzgaPbJ3t3qcx0bMc1LUH+GueOtVX4UAWbntdvg@mail.gmail.com>
In-Reply-To: <CAJ-ks9mKZVSZzgaPbJ3t3qcx0bMc1LUH+GueOtVX4UAWbntdvg@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Feb 2025 14:21:15 -0500
X-Gm-Features: AWEUYZn-IDVzrPa3u-avQrQtvmNmvj-VcisIqvcjJqs5Hdu21kJ1zWqRiaBmgMQ
Message-ID: <CAJ-ks9kMoWiWACGWWAL7TJkf9MU2k4afPBikz2hxRibzA2hHZA@mail.gmail.com>
Subject: Re: [PATCH 0/2] printf: convert self-test to KUnit
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 6:34=E2=80=AFAM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> https://lore.kernel.org/all/20250210-printf-kunit-convert-v3-1-ee6ac5500f=
5e@gmail.com/
>
> Weirdly the cover letter seems to be missing on lore, should I resend?

It's there now.
https://lore.kernel.org/all/20250210-printf-kunit-convert-v3-0-ee6ac5500f5e=
@gmail.com/

