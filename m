Return-Path: <linux-kselftest+bounces-2939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D591282C960
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jan 2024 05:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E297284C82
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jan 2024 04:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ABBEAD6;
	Sat, 13 Jan 2024 04:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UjMqfJdV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9F3EAEA
	for <linux-kselftest@vger.kernel.org>; Sat, 13 Jan 2024 04:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bba0ac2e88so3625366b6e.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Jan 2024 20:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705121524; x=1705726324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRzVjE/60hfoJmBpHx7JmI7NVqzyKuJ6EGRYVVIYHyE=;
        b=UjMqfJdV8x7S+D4gIOJebINqm1UTCTvejoRiAJ1qA3bqWpGcYb2IRBxK0GNdDJvvVV
         N2QHNk/UqxXbzcfkRkeJoKB1yRgKapI9IaWA9tD6ROo3ZY9716wDJK4Q/PKXvjvbAov6
         OnY35t8wVpCfzOxQq/XjC88dBDXwp0+xNw4WE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705121524; x=1705726324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRzVjE/60hfoJmBpHx7JmI7NVqzyKuJ6EGRYVVIYHyE=;
        b=hyIHmkkNm/jvY6eiQmMBa3Kxg8MmLEK1WTIjrtZ7NB6FsK8Stqp2mWoSe+Aq10OWME
         UouYTODohZ1EnR7NsnvtOz+ZInY8PA5icLgi9D6o6P2Dh1jAeaNww92cOfy8kUz8vE8v
         xY17RquI2rz8Dvl6dza37coT+bcJ8LYyuogcstT7P7HvebWPzQwqIRPs5hRRspJ7h/q6
         1MsHMEa1yDAvod5DXHnSuvlUB1cVvYJxNGgPyUlwAxszvLEBiOeLmOQ2lWrS37gGwiSR
         jDzSXXME0X95RThn8j5IF3cXwlxejPZSXyb5dkU/Lra7MQpJOuZnkLrLf9RFCpRgRVvR
         qPDw==
X-Gm-Message-State: AOJu0Yzu4TK57qJz3JO12hbcMQr0d6AOUzK8yXnYcjLelNm5ulzNU+rQ
	NbABFPJ+Z3enkmbiG2DwQFUkSNjViYxJY7OS3Jgku2aCQzhT
X-Google-Smtp-Source: AGHT+IEdaiJcCRLapVikT9wJgN0tDnSDzzD4ce1+B39OTXVVa6pay9HsBvUgQn35yTvGDp6kcRfdFxzZi0JF2T7blZk=
X-Received: by 2002:a05:6808:2092:b0:3bd:646d:4366 with SMTP id
 s18-20020a056808209200b003bd646d4366mr816782oiw.19.1705121524684; Fri, 12 Jan
 2024 20:52:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111234142.2944934-1-jeffxu@chromium.org> <20240111234142.2944934-5-jeffxu@chromium.org>
 <8cb16dfe-993e-4c41-b1fe-63bc7ac97609@infradead.org>
In-Reply-To: <8cb16dfe-993e-4c41-b1fe-63bc7ac97609@infradead.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 12 Jan 2024 20:51:53 -0800
Message-ID: <CABi2SkWdp5UpKmrWV5Y-v_XTVWJvhxq0nSXmK9jV2UDUXLWFyA@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] mseal:add documentation
To: Randy Dunlap <rdunlap@infradead.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 5:10=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi Jeff,
>
>
> On 1/11/24 15:41, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Add documentation for mseal().
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  Documentation/userspace-api/mseal.rst | 181 ++++++++++++++++++++++++++
> >  1 file changed, 181 insertions(+)
> >  create mode 100644 Documentation/userspace-api/mseal.rst
> >
>
> To prevent the following documentation build warning:
>
> linux-next-20240112/Documentation/userspace-api/mseal.rst: WARNING: docum=
ent isn't included in any toctree
>
> please add the following to your patch 4/4:
>
OK. will do.


> diff -- a/Documentation/userspace-api/index.rst b/Documentation/userspace=
-api/index.rst
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -23,6 +23,7 @@ place where this information is gathered
>     ebpf/index
>     ELF
>     ioctl/index
> +   mseal
>     iommu
>     iommufd
>     media/index
>
> --
> #Randy

