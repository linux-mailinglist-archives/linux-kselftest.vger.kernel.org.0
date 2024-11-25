Return-Path: <linux-kselftest+bounces-22516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C42BC9D8E96
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 23:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6055CB284E3
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 22:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91BB1CCEF8;
	Mon, 25 Nov 2024 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mot/HVWZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6031C1F20;
	Mon, 25 Nov 2024 22:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732574064; cv=none; b=aINeNzkNnoyGI4/UU6yP6E3K+oLFkvnrytrSYTZm7jwU61H8oniZG87qJkbhSXB9o00+H0QqJCA25I8TOL3QKwQ9+s8kFVB12SwQ9x4/lixxHKc1yHUdONCRxUB/HcxNX/c3B233MWZSv8wCVGEECNUMjZoaYmC6EQjRHhpMw9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732574064; c=relaxed/simple;
	bh=JId8FJHJMPrG0n9QXj3iDjW4/gQayePB/qaUjzuWQao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQ7wIC3lG5eWMgMYRbSoU7DHL/bk2MFWdBwKczbCY+8viHIeQ881mWeBGJFtQ5kKFjz5v3p9clI2kvfU6pUO7Gc0P1SG9jFnHXtTb5ORz3Rfj6WgjDMBBbPoykhra5V/bKErJSNK5esT2vyv6x2GZgH9+88/+lpvKvtxxGMq+Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mot/HVWZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43494a20379so18792135e9.0;
        Mon, 25 Nov 2024 14:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732574061; x=1733178861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JId8FJHJMPrG0n9QXj3iDjW4/gQayePB/qaUjzuWQao=;
        b=Mot/HVWZPdmm4kWO9PLuJPPfYJ1RjAOXo6UJwVnUXYvQhda3/WuvY2/SuA+Jo9yIjI
         B33qfQDsep+nAn1z17VxRa9F4/HX1PUC238Fy2sLSUu847uP8KUuIZVsXYvhGhXHjm1I
         /JEcJnKFvd5rcEeSKvy4/q0HbOTb0r/e846yC85TYO5L335RcP9jauKLgVQ+T2z8DxmU
         0fuwalGE0nY9ykmgpAYKPjG9e4bRzruJMXe4cYCFMmqNkmtbEZ7W5Sb7aWnMIrok3xfH
         7HxZTWw/4g9dm+jDDjtz0wE+faI6fGps8fLYA1DDz/pUcsyZYHi27e0gT2OD5Vf6WoLp
         Ybyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732574061; x=1733178861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JId8FJHJMPrG0n9QXj3iDjW4/gQayePB/qaUjzuWQao=;
        b=IINqqsM264+9TLcr3Atu/wk6QZprl3kRfl7gHORH7Om6tpFMIscO/ET7G25wzlSJ4X
         kJPtnmyCNxb5Ekg5+JAYROktKqwc6nwppNNA6DtVh+MRS/eyYIgQ899kdAsHsnV6hrWT
         nQzFLM4z82frWGX/uN5OKETahxHTSTdQNuMM9eI43+ehXfJ44sPwuNpjpNbeP5jLzfkq
         9in7LSJ8GSVnM/ZVC05WKFqRg16OL7sAU2fEcaFkXBq2uZP4QYyWhr8wAafBlEFVTmOd
         lE9QOBPG0B2unU2II7MaFpOxnqe9vWTwCkUvA7SJuKqYQoSdsw6c/w3xTI9ry5cmpRJU
         v+qw==
X-Forwarded-Encrypted: i=1; AJvYcCX1oNObNfeUNmfeuWDjCQisqXZA0x5TVF3F3Utu/UTaCzq2nG5ncq2R4uU96JAOGvtRgNk=@vger.kernel.org, AJvYcCXVwS+ZeNJNAzSdpUFv1sL3LuAjCFwUREwSS20rc7Sb8XrVaDWvNYqlV83KBYltkV36UP84TWiISfLys+Ge@vger.kernel.org, AJvYcCXkxGprMgrhsk/ITkHT0zZDjC/qBnZEf03FgRz/WN3wdxY0EhIw9jXAHVumSxZkVeo2662VhKJ8lRmvmCX2n1rh@vger.kernel.org
X-Gm-Message-State: AOJu0YwhBpgfU4MnxX7RcfmyDa3Oq6pkZ6eJG4uLpAFfNwri9bAXRIzc
	M0cXTmgmsCR8VSkoTC/d0emb5Gv/sGmfGa0BdUIFvGOyRtOgsXvJRZaLRvIGxQ0IT0ARSpjPdC5
	A/1iM78XFYHHD4K0FPnqti+K8OOE=
X-Gm-Gg: ASbGncs8WXnzfVGS8LpxQPbt+BVUgLv7L3QYBHm7cl3QHjMvuc6TlIAIY2OCJ3WTjBm
	kEn7rx5xoQuORQdD/d669rThOXWfCx8c2eLK4tTbsFyjYqzE=
X-Google-Smtp-Source: AGHT+IHCTd9BUM21DGJEF2mblcp5uJ9mo9QXafRzk1/JP2A0sIpGPIRH2edRU3Om5p7+rD8vZ5wZXQ9VLH952v3ZdIA=
X-Received: by 2002:a05:600c:3150:b0:42f:310f:de9 with SMTP id
 5b1f17b1804b1-433ce434707mr140832075e9.15.1732574061157; Mon, 25 Nov 2024
 14:34:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117102857.198803-1-guanjing@cmss.chinamobile.com>
In-Reply-To: <20241117102857.198803-1-guanjing@cmss.chinamobile.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 Nov 2024 14:34:10 -0800
Message-ID: <CAADnVQ+FziJ47sGE8vwBqnPNnNc9Ny41fW7nzzNOaeWY60snaw@mail.gmail.com>
Subject: Re: [PATCH v1] selftests/bpf: Fix unnecessary conversion to bool in 'run_subtest'
To: guanjing <guanjing@cmss.chinamobile.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 1:36=E2=80=AFAM guanjing <guanjing@cmss.chinamobile=
.com> wrote:
>
> Fixes the following coccicheck:
>
> tools/testing/selftests/bpf/test_loader.c:1033:64-69: WARNING: conversion=
 to bool not needed here
>
> Fixes: 80a4129fcf20 ("selftests/bpf: Add unit tests for bpf_arena_alloc/f=
ree_pages")
> Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>

Pls use your full name.

pw-bot: cr

