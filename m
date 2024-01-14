Return-Path: <linux-kselftest+bounces-2949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF0182CF9A
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jan 2024 04:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06051F21C80
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jan 2024 03:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B3D1EEEA;
	Sun, 14 Jan 2024 03:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yqkrz5kD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEFB17CA
	for <linux-kselftest@vger.kernel.org>; Sun, 14 Jan 2024 03:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-598a5448ef5so2262003eaf.0
        for <linux-kselftest@vger.kernel.org>; Sat, 13 Jan 2024 19:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705204138; x=1705808938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fi83qxC7DN9Mrs6Lcn/FzkFtPxyAqAamlzctaT7s4iw=;
        b=Yqkrz5kDxiv7/zEltjfmZnF4yjdyjTHO5kBf6lFurdpZoic3jit7KTS9IPzHyeuPHE
         pRSNWfPJcTIsReLo8+e2Y/QNzJZmixySqYa0mISR80xLx0mnoFY34fstVtZ1aJuD9xkg
         B723f0RnZH1aiAru7vUAJfh2D1Q0Twx1ES2fM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705204138; x=1705808938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fi83qxC7DN9Mrs6Lcn/FzkFtPxyAqAamlzctaT7s4iw=;
        b=IFLPj6dGw5F2x5i2yKquMe4ZLQ4cTKua0SOOvydozSuZNv1GG71ZJ3H4EEFWNF7hDs
         9zQEDSm3LT2oOoP5rzk4XV40L3hbQnP2Yp1DvOVy7s8rZym9HMMOfTsRjTeGa1yROTr3
         gb3s8K0kq8JK9iOKudXjE+QGpWqh88uFV7i3G3TJJycmk8Z611r+WdUAiRsqJMMu76dH
         OC3GvQ27QXQ4VNnqfdMJXPWUzBLWKRz8S92iqGyH/QmUaSt9CtVvayBewPIeyS/yK7Kb
         X8tmUeSuLMtl0FleydufY7Fh94Bs8ZREizdcPhn5fEBQNmQBtIed/CU/Z+ZjJDzObkZv
         GigA==
X-Gm-Message-State: AOJu0YxbwE0bVEG7AAU76GqZdcpSlWiZ51wvFIv1l286C6E/xQCnl820
	JuDdxsGmjuPIdZAGmV1S+re2rm9mlnXE1aX2ZKEk1AXNd5eY
X-Google-Smtp-Source: AGHT+IGxcLy79rvnuOyBki0wllFskUd2ajI6nO0d3k/tEM6ToEF/16NmjnxfE/jV0LwfK2aFzd7ESKdMigeTSVY4LKk=
X-Received: by 2002:a05:6870:5cca:b0:202:ffc8:c6bb with SMTP id
 et10-20020a0568705cca00b00202ffc8c6bbmr5841416oab.4.1705204138403; Sat, 13
 Jan 2024 19:48:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111234142.2944934-1-jeffxu@chromium.org> <20240111234142.2944934-3-jeffxu@chromium.org>
 <202401131146.F017DB5870@keescook>
In-Reply-To: <202401131146.F017DB5870@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Sat, 13 Jan 2024 19:48:46 -0800
Message-ID: <CABi2SkXrUm-oa7bZBxFGHdL6qknAeD0OkLio2vniJw=YgDXQaA@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] mseal: add mseal syscall
To: Kees Cook <keescook@chromium.org>
Cc: rdunlap@infradead.org, akpm@linux-foundation.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 11:48=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Thu, Jan 11, 2024 at 11:41:39PM +0000, jeffxu@chromium.org wrote:
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index f5a97dec5169..345667583b03 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -30,6 +30,7 @@
> >  #include <linux/kasan.h>
> >  #include <linux/memremap.h>
> >  #include <linux/slab.h>
> > +#include <uapi/linux/mman.h>
>
> I think the arm64 build failure is from this include -- it's happening
> too early and some of the arm defines aren't available yet?
>
good point, I will try fixing it.
Thanks!
-Jeff

> -Kees
>
> --
> Kees Cook

