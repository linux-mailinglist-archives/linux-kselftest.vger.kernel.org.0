Return-Path: <linux-kselftest+bounces-15678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2FD957369
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 20:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87B06B244EB
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 18:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7F31898E7;
	Mon, 19 Aug 2024 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="akvf6uuj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA77018950C
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092507; cv=none; b=l08tE44CK6GYJzlwtOrK5hJmJ6YsqsxQt3ZvtjP8ALoAQcI4xpS7SebpU6NGc/D4+YPHQJ4Kg7f7ifg2N7Xvv1z5EBXC5oLiDSYpM3c9piZrHU+ynz7B54utk/4CeffRJdu0yhEBJmiEsjYAaLG5lSn2l0iRUPEfsHbNyXLeD+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092507; c=relaxed/simple;
	bh=ZcVkigYWpjlr7iQuQ4MGhGbi2tR5jEY2SDkXCbkC91I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pqsOaqS4D98MS550P0afS4o42zU7KJXTXk37p3ZvbihVchAjHLdWK6U520qFag49NV4kB9Jg804BIl/eCNn/9J4MXciyYzLe6jtJAPCmXgIEcrnQdCudoddyJ4dvoswjJughaQaS7nqqAB+od2aX7Rgsir1ET0B2JcCnjWpGmAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=akvf6uuj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-429ec9f2155so31206515e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 11:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724092504; x=1724697304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qB2aiywFQ/7bZyWYjuuiDbccrZMhIclyQ2+n0baHXZQ=;
        b=akvf6uuj0QfAq/4CJa5leRq8yA9peg8Ko1Xbby4TwrJudROooLQDHSQCnJQ+VtAKZi
         SU5csd7WlmAe7AQJ2h8GPaT/ChrQ75FukMQ1gAd5UrjPuHF2lcJRIOw8lUgxtGRJQgpJ
         rdAutcKIY/KsXyjsTXIEsF5y9G2Z6zB5s1Zs6BrrVdx0WLiYMGZfbDzGbpT/+SW/MF4Z
         6nmlFSG3M2jom2jARXretN0m9dBPirh/JZezzEDBeTUd8pq+yfABHp+0VGKNuXXEGoqf
         HfRF7vq+kFrOstUrQ5q6lmLhnpeevrk6fcdkrVANc8+o7WdzhupcL3YIop7Oa5RSLjhw
         TSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724092504; x=1724697304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qB2aiywFQ/7bZyWYjuuiDbccrZMhIclyQ2+n0baHXZQ=;
        b=rBwGF2gtGu1YTm/jGjEaCsL765YgXZj74zhgnPBJ3XfktAuQs/AumQlKvgD6L3tZNn
         /xOFAafPwhC1RMfRJ+lEdx3V+0LNN9PVV+r0iy0Pjn+MQEmlyXe3JmPLFRhb0pfzQNnA
         tb5BJ4Yv/WXVMtGNrG/1ALvXQjygLxsWEFGwauP0RQcWfeJDWwjBb3Jb/9p9L8lusLNC
         EL4rn4N63yhvHTiIlMWrvJoddnixaY33FYq7lwSsXmK8XpCJvy29WU5gCWbm+JXGeNf0
         yKzz+RQM8yFOg/UEXkCTLAkRCl9xMcQiaCtrZL+ykOe8KrmNKa1t6DL8M4oaiHfxMSCf
         Zy2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFoXmMgFv8MPRljc+flg159hk9xuC3mbt3q+P+1MSk67uDHD5xyNIdZrgSaNjT8xiWou9azKNiIBSd50AfTvSFqtwdQmxJzCn17RtBwLKq
X-Gm-Message-State: AOJu0Yw9wpUX4WYKGHJvdw4eF1QwPlqQn59NmeGQflIKkXnPjnnW9r4j
	w5jn/0jNAdwJMBK8qQ2cXMiI6TW0EJo46RJVSirn+VLGfgqNg56g3NbWvwP4ENyb8AJLNQ8m3NU
	1vh56HQTotItPNOMyQBet/9Z0cKGNWQ0IM8LsohwKTK3H5djY
X-Google-Smtp-Source: AGHT+IHL6SFDUfjBtUFeEhGMqyWAWM/b6qf0aHg/pO4x9FUknerMtwxQJBPOY2OU8LQd8gQ7KOq0NtLDi26TDPoBP0U=
X-Received: by 2002:a05:600c:4e8c:b0:428:31c:5a52 with SMTP id
 5b1f17b1804b1-429ed7cc764mr104616895e9.29.1724092503366; Mon, 19 Aug 2024
 11:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819174814.139344-3-pZ010001011111@proton.me>
In-Reply-To: <20240819174814.139344-3-pZ010001011111@proton.me>
From: John Stultz <jstultz@google.com>
Date: Mon, 19 Aug 2024 11:34:52 -0700
Message-ID: <CANDhNCqoHvvTUk7tmR7u+WPKQV1B7Eztf3TWYDpCQXgLXQijsQ@mail.gmail.com>
Subject: Re: [PATCH] kselftest: timers: Fix const correctness
To: Piotr Zalewski <pZ010001011111@proton.me>
Cc: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	sboyd@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 10:58=E2=80=AFAM Piotr Zalewski
<pZ010001011111@proton.me> wrote:
>
> Make timespec pointers, pointers to const in checklist function. As a
> consequence, make list parameter in checklist function pointer to const
> as well. Const-correctness increases readability.
>
> Improvement was found by running cppcheck tool on the patched file as
> follows:
> ```
> cppcheck --enable=3Dall \
>         tools/testing/selftests/timers/threadtest.c \
>         --suppress=3DmissingIncludeSystem \
>         --suppress=3DunusedFunction
> ```
>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Piotr Zalewski <pZ010001011111@proton.me>

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

