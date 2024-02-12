Return-Path: <linux-kselftest+bounces-4524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE4B851CF6
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 19:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64349B22DCC
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 18:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FB23FE2B;
	Mon, 12 Feb 2024 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rZnwopuP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678A245016
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Feb 2024 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763169; cv=none; b=WJk+3p3dNZRISBT8+RKoH26GH0C+aJLesUrMRrMxPf2AkQFeHaCTPUR4KNIZJ+nR0IUriVAxWhinskhEflTeHzZjcJmpkPyl8BiRq1bnOxGt6dl86KJk5claxuOD20uTH0wdTidY/y4kCpiH0XMzRrrr8o2qdDp8cmPArC8GYjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763169; c=relaxed/simple;
	bh=HCgT/lIF6+pVrFxFVEXRsHMO2HmD8QWBakVqzWoiQ9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y66afeTJzZ0zf03l0/oXlH6STCYi1DPkJ8Ag6TrNdshNuzAepI0yRXfh+QTgumIyGJ8hvVYlovqQSVahuklIHMwJcC3Z355wAqeceILE5Ak/+jlAzPkVqI+LgI+BHsBjUVwXIFJ3F6UYu+OW5dVXkGI8nVfmlCPUm0hnCqS1Cjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rZnwopuP; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4c01a5e85e8so27008e0c.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Feb 2024 10:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707763166; x=1708367966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HCgT/lIF6+pVrFxFVEXRsHMO2HmD8QWBakVqzWoiQ9M=;
        b=rZnwopuPxaz1NRwgOxXRb3HEErW5l+aank023/5PqrsvlWHjSX4ZRpLumO2bX0B7oj
         AW0BOWxrVJA345klwhGAXEHlyk1JgXLHzfUP16XPhmcDurDzoAxKOjO8eo7S+rc5hJss
         4HsN97plRqzuJXsSBFeFkMADoZuLBfx1Yu090fYV2nRwI1o5Zi6JATngWobKLFK0bBpr
         fXeQT9rUoqn70y0PlgiG91/gK1GbEmtOQqcE1tQaBkHI+iS6q6aycbF+STS/Pzh52Aku
         OFQsvKJjscQxoddZI+HAb2W6u2Fd1KuvLKv+feRIl6C1NPMj8XUzQ9FdWy+H+Ubo9YGA
         6Qdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707763166; x=1708367966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCgT/lIF6+pVrFxFVEXRsHMO2HmD8QWBakVqzWoiQ9M=;
        b=J9waxxny+p8N5Kn3pPRZ4qU9gX7jBc8oqiL4YRKrVY8LQg6eiKrbJiD0sirqX64cl/
         RaQaNCfKI+8JXNekSoSPTW/IQ6Y0Hvpfds+XGQN3spTtoaSAkIjki0ICqL49Ipqvi3M7
         g8zhn1rxxfxzlFvx0Wm1jO8EgLb46cuUWzv3VJzOym4D/VgwpR2B50Yj6aQvigg95XA9
         3JAj8VIsmZn28LroIsmQTOeHRE1KGq5LhZN7NKN7bjDE6lpjNJWNSn3r8Doq954LlNkw
         lNE2OTcf753X47WAiq8X0Fw50g2SiCaUa/fYOJMxHIoWREv0lCQNYmJ5Z4OsRwHnhHd9
         Qzzg==
X-Forwarded-Encrypted: i=1; AJvYcCWSzVjud3ZD6LNjZxXTosLnrD/TdQaa0AO0GBULuAw8HtOu8MukCJU9U2hHe9eoaeLyXr/XeskPJ5QK1Z8rxR9NC9cMKZKF3UirX+XVcQ5E
X-Gm-Message-State: AOJu0YwUzTrNA4RENAP2IvN0E2HNwaW0USm43w/37yne43/TtPmw7My/
	Ryye8TAnC89KXUdZ8SBX3L7e6pzyL0YhTDThJx7OgZXkCQUMJXu3TyAxj9OECGccuQ1u2N8oZQu
	y7Fm1NzdkSlUMA3k25E+qC8iVyJICmQSYfIekDw==
X-Google-Smtp-Source: AGHT+IH0eDVCHbyPL9X/VNVKVFp1oXkZRJlvE5Y3OB8AuOpgh8MtouPlypW8yAb8NtGduUZwTTMV+D64YPCooPEabaU=
X-Received: by 2002:a1f:4c46:0:b0:4c0:3b31:34d3 with SMTP id
 z67-20020a1f4c46000000b004c03b3134d3mr3533056vka.12.1707763166289; Mon, 12
 Feb 2024 10:39:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209132512.254520-1-max@internet.ru> <68d61c24-b6d3-450a-8976-e87beb9b54e3@kernel.org>
In-Reply-To: <68d61c24-b6d3-450a-8976-e87beb9b54e3@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 13 Feb 2024 00:09:15 +0530
Message-ID: <CA+G9fYsBakUkg11TFrKZtsqZH3K=6_C2YvEmx6NoHVTkUNNf1A@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: ip_local_port_range: define IPPROTO_MPTCP
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Maxim Galaganov <max@internet.ru>, Linux Kernel Functional Testing <lkft@linaro.org>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Mat Martineau <martineau@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 19:27, Matthieu Baerts <matttbe@kernel.org> wrote:
>
> Hi Maxim, Naresh,
>
> On 09/02/2024 14:25, Maxim Galaganov wrote:
> > Older glibc's netinet/in.h may leave IPPROTO_MPTCP undefined when
> > building ip_local_port_range.c, that leads to "error: use of undeclared
> > identifier 'IPPROTO_MPTCP'".
> >
> > Define IPPROTO_MPTCP in such cases, just like in other MPTCP selftests.
> >
> > Fixes: 122db5e3634b ("selftests/net: add MPTCP coverage for IP_LOCAL_PORT_RANGE")
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Closes: https://lore.kernel.org/netdev/CA+G9fYvGO5q4o_Td_kyQgYieXWKw6ktMa-Q0sBu6S-0y3w2aEQ@mail.gmail.com/
> > Signed-off-by: Maxim Galaganov <max@internet.ru>
>
> Thank you both for the fix and the bug report!
>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org

