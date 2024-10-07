Return-Path: <linux-kselftest+bounces-19150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B02D0993054
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 17:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A227B235E2
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 15:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1D21D88B3;
	Mon,  7 Oct 2024 15:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A6VBUdpR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B30F1DDC9
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Oct 2024 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313281; cv=none; b=GiPpPuBPj63mcoUocSd2WMmh3Bl66ysnhE4HjFgbkR8wtleou5GjpoEJUojcs7DYOqatlaRlvDx/s3aKKk1/LzqeMz0S0L8YEjla6t3kwsE/KmH+8JqSpLfQ0cs0Nl1ypc8/GxEs7iVQJ6834yiaUmAJt7Xw/FJSNh/6BwFcH20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313281; c=relaxed/simple;
	bh=9lGMjsL9YvR2b5UZp7IaSLPOgsW7pqd2+sFOluaC1UI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pv9BfdFYmxEvZmWKED9LwQ8r5RIdhIq7u1htBukjBkLEfBbHzdaAFMJR2d9N0ihCvknrtapNpTHlrUsvsvbMWWcg+/BV6pn3/PK1IfCmRa4v2VVYgpB2RDcNWHr4zbusS47TBsYW9DaxQ+IJkqaG//cgbd+/l/t7CAAV8ta09s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A6VBUdpR; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e03ffc29b5so344965b6e.2
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Oct 2024 08:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728313279; x=1728918079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lGMjsL9YvR2b5UZp7IaSLPOgsW7pqd2+sFOluaC1UI=;
        b=A6VBUdpRet3ACFD/FPEGj3vJYbLsWtmYKDf/aFQMSsUM7R/gGugI/yGTHpGtbKxVLr
         aMF3sTvV2Nt2MR0DuIgaU12MHzHN7uQI/GFKCINnB0pH/6lcCk0N98cu2sE8PfZrl7PR
         fQ+EEsMc7g0xO6diVe26L6oSfqjLxNZSkQV4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728313279; x=1728918079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lGMjsL9YvR2b5UZp7IaSLPOgsW7pqd2+sFOluaC1UI=;
        b=OXOW8EAQZU26WQ1vSf9tuxH/NTjuoMtxHzFVWEiVzX0XKnvpbpK8TOK3qKAbD83bSM
         FF7lOUhhcCJMzbSqGMgkWnvdQzYkHpguDfQvHIXUK8Al8z2otoa8LPVEh4kqNeJIuDe1
         6S67Mw2E43nb6uJVRt79uFAG7kVah59lrIPakozK/XnPULuMFtbFVCxlTAm5u+ERo1a5
         Cgz/NnnjCQrB0MlOj/A81FbX0bY9uxAAYKhkx7UVfL8dPPef2aHZDaOlF9wBUAl6aD1F
         ItS4g6WrTwnhgFVYS2cjN1v3PBLzcqi7j35PF7KCAlCM1xHX+aeq0dWD2ptdMxYzfbXA
         JG4g==
X-Forwarded-Encrypted: i=1; AJvYcCVdc3uMBaHFOahmbYSYVKWVGmU/+wEQnoSmpJxrH34teD00nb6NcCdN4XZTvwz1BUwbgjzmkptbOdMRUGMH6NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAR9gqWVuf7W4dL/FS9FE8HamGBr2sZclyfovD3WKZRiMMGBT8
	vbSiTDbD50/DTdV1I5pemxXiGLkhzduauD1HMjF/HlAO8XLwMGt/T7f3w1NnACKVLBofeq4TTzP
	n0dFPw8etQudBEGU9PwUKrn1Wl7I7RVqYL+SrJEAxkomcC5Y7jA==
X-Google-Smtp-Source: AGHT+IEMgEtMkPMuigjIyri58XNpbb/jhG0K3/t0P5EIDskUDPqzyw/E5ZxVQMR+NVn6DfogZxiFeyS63OQiwPyJRj4=
X-Received: by 2002:a05:6870:64a0:b0:268:bd85:ff9a with SMTP id
 586e51a60fabf-287c1d38686mr1975731fac.3.1728313279521; Mon, 07 Oct 2024
 08:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001002628.2239032-1-jeffxu@chromium.org> <20241001002628.2239032-2-jeffxu@chromium.org>
 <4544a4b3-d5b6-4f6b-b3d5-6c309eb8fa9d@infradead.org> <CABi2SkUhcEY7KxuRX3edOHJZbo2kZOZfa0sWrcG2_T0rnvHCWQ@mail.gmail.com>
 <78f05735-cca3-491e-b2d6-c673427efa07@infradead.org>
In-Reply-To: <78f05735-cca3-491e-b2d6-c673427efa07@infradead.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 7 Oct 2024 08:01:00 -0700
Message-ID: <CABi2SkVQLW_hCmOA3is3nyG9nMjCQ9ZaFJ1tgG3=5M9_83+9Rw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mseal: update mseal.rst
To: Randy Dunlap <rdunlap@infradead.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, corbet@lwn.net, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, 
	sroettger@google.com, pedro.falcato@gmail.com, 
	linux-hardening@vger.kernel.org, willy@infradead.org, 
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	deraadt@openbsd.org, usama.anjum@collabora.com, surenb@google.com, 
	merimus@google.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	enh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Randy

On Fri, Oct 4, 2024 at 4:52=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
>
>
> On 10/4/24 9:52 AM, Jeff Xu wrote:
> >> above is not a sentence but I don't know how to fix it.
> >>
> > Would below work ?
> >
> > Certain destructive madvise behaviors, specifically MADV_DONTNEED,
> > MADV_FREE, MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK,
> > MADV_WIPEONFORK, can pose risks when applied to anonymous memory by
> > threads without write permissions. These behaviors have the potential
> > to modify region contents by discarding pages, effectively performing
> > a memset(0) operation on the anonymous memory.
>
> Yes, that works.
> Or at least it explains the problem, like Theo said.
>
I updated with :

Certain destructive madvise behaviors, specifically MADV_DONTNEED,
MADV_FREE, MADV_DONTNEED_LOCKED, and MADV_WIPEONFORK, can introduce
risks when applied to anonymous memory by threads lacking write
permissions. Consequently, these operations are prohibited under such
conditions. The aforementioned behaviors have the potential to modify
region contents by discarding pages, effectively performing a
memset(0) operation on the anonymous memory.

Thanks
-Jeff



> Thanks.
> --
> ~Randy

