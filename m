Return-Path: <linux-kselftest+bounces-10990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FF78D5C6A
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 10:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DEB1C23A26
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 08:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0016C78C76;
	Fri, 31 May 2024 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ewoco75a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED5477114
	for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717143159; cv=none; b=JJZE0Nf/DeoZLYxpd+kYah/JCgNU3RkfD7i5wZc1f9lR1v15dD01GJgi75UU7s3fOjyhQQPejLdyEamYGXHEaonS04NzyG3wPbwcr5k45yy/FvgA0F15UGgBbrLVbdURvNtIJDEEq4Lo7+xEXuSqRrQxHG9ZXIJScHn/q2xQplg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717143159; c=relaxed/simple;
	bh=+zcuFiMnBzt6Je3SocB3n14Z+8rap9B5dQT91Kolxik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Skymt7t4k5FNDkgaZDkJjUzs/OsnIwa3AKsOYTIiiYwNPZAxpEf4aJqZsk77bcNsoe1jf65HJB84MaSy+rr3e/gWHXxM+dnE67qICI4QKwO4+ehBFX7/qvZ1tUZblufxUcuMydgxRSJo/ijUXgrAXCAjc5VGulUK3mmfCEYLYrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ewoco75a; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so10612a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 01:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717143156; x=1717747956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zcuFiMnBzt6Je3SocB3n14Z+8rap9B5dQT91Kolxik=;
        b=ewoco75aRrV9Pek9I1loQsCw9RokeIJ5FAT8crVMFNCw4kogrtPxp4qfOeSB6gprOL
         NsPo0l06W2/slp8u5NshO9vw5rZJA5yc+YVuKn/SOHkBjPCGUTKeXpfn3RwWxljUahNL
         0SiQTfansRPGCmMK0IbvOAb3phsR1gjnWpoX+YK2DaXvnSFyQ/QslZtNWiBGE4/5T5iR
         WxgwdjCuqYvjPLOU2Km/4HSm0BwnNTQbdYojGE0GOecigkqgnrxJW1XuuykA068wwgh+
         ghfyo7ZCQ9lor+F5HNLsakNDyalWvNnB+Oh1d2OWCWBnD5v3MLOgRYe4S9roUYiHra+3
         CgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717143156; x=1717747956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zcuFiMnBzt6Je3SocB3n14Z+8rap9B5dQT91Kolxik=;
        b=lQJtkw5BwUAznqS9EtPfmMNZqVshwtju/4Z6xQtqdhqkD/9lixgxf9jAgCZQoYZ6lt
         8GwgVf9wl/4355+fyZ+djvLU0oanGCjKJiXTZfayuRhX5btyW7riaWnC3V2ZDjYSGc+0
         o5bvx4QbvizdEsI5yXUQ0HxvX4LdsPaGAHkauwUeVFRTyDMf1ISajn9goSJSBx9ZJ2bY
         hxzshDJck54HYSpyNiHM403HuW3MsbBt7uof7nJy4ygfGh8i97ii23MiqU8hYnbN/20+
         Qt3biOsN2zlSJ+v97zsWTNtwAsx/GMlCtGkRmehpSxCBYV2miyaA+kDTPiAi66MDjgNk
         q6jw==
X-Forwarded-Encrypted: i=1; AJvYcCU8rADNTZE9tBInaI8PYbnMepmd9PpgONbKlVSLA/2oie4Lz+hXg8WXvisnAMeie+KQ7vER8Btytk6WQwiPuuDtSsxFHUDJJIOxFqPNiGlG
X-Gm-Message-State: AOJu0YzmxzTJXQKXQKCd4AMzpE0EE0i9g/8p/ZS2XLEYU/Y8GvnLw7jA
	t8dpgnydBxn9C74J+NsjKyAzMMgm2OLx85ALQ2d8bYP4tnplsZt2PuPu2NyIKFq0XrVaVAgN4ag
	nu7m2lR3MTVvGX1Y6VqsgQzzhW5W51yM7dpcG
X-Google-Smtp-Source: AGHT+IEMtyGeXl/fX7gxxAL/632eX3+s+KyYKjTtKvCIZwvhhUfWl/OjeNy13luErF1LkScAcaTd4e4OSvlnM4p8mrY=
X-Received: by 2002:a05:6402:2029:b0:57a:2398:5ea2 with SMTP id
 4fb4d7f45d1cf-57a378648c9mr75743a12.3.1717143154749; Fri, 31 May 2024
 01:12:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530232722.45255-1-technoboy85@gmail.com> <20240530232722.45255-2-technoboy85@gmail.com>
In-Reply-To: <20240530232722.45255-2-technoboy85@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 May 2024 10:12:23 +0200
Message-ID: <CANn89i+GZ31Epxs6sfgg_skW4QOQHKFA4GHgM_4i95FcxX31gQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: make net.core.{r,w}mem_{default,max} namespaced
To: technoboy85@gmail.com
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Matteo Croce <teknoraver@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 1:27=E2=80=AFAM <technoboy85@gmail.com> wrote:
>
> From: Matteo Croce <teknoraver@meta.com>
>
> The following sysctl are global and can't be read from a netns:
>
> net.core.rmem_default
> net.core.rmem_max
> net.core.wmem_default
> net.core.wmem_max
>
> Make the following sysctl parameters available readonly from within a
> network namespace, allowing a container to read them.
>
> Signed-off-by: Matteo Croce <teknoraver@meta.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

