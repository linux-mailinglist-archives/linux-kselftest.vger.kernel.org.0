Return-Path: <linux-kselftest+bounces-5412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C56B8623EA
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 10:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C3E1F2371A
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 09:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDC7199A2;
	Sat, 24 Feb 2024 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y/e4ofWD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53778199A7
	for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708767077; cv=none; b=PtfIikSy0U+TBYdKbrDuplohQBWojqj8ONwu64M2VyJop4aBUK9Zrx74dtgZROXZEevb5BKh9IDwbPpU1is88XwRk8ALABpxSXkFmcQBjk5gMH9Hzfz0KePKDwueL6CIaFKdUu1zGKBI4smi8T1OrxNVU7OJWov5NzEM8FHQ4eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708767077; c=relaxed/simple;
	bh=y2+xsbNA7nJA5AJAIiiYtBIFp5DHt0sr/WcAwRB23LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGTuyUboF26OXZgvmf/9REO5VOv5qKIFH4hlJDZ6G5GC06E2coA3q59ZHTQW8AFuTUCnY/03CaF8m7PKdZsK0m4jH5shvnp1fyD6UgyLin0OXjGGknbwGD0avywZoGJnJz/vv7qhzM9KhLkt04jTE6FzFh4J7zFHwT7GDiQ5KSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y/e4ofWD; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso3755a12.1
        for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 01:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708767073; x=1709371873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmY5NkPyqyDzoEieFjYp7SW5hjVc2+Nb3/NQOzb8Ges=;
        b=y/e4ofWD20vd3a1URnY4gVNi+xSV3qazdgGof9LdTOzGjqTop0P6aPamki0ZqSqYfB
         8jzkcCaMNaIpmJ0G14woHpNmbJvu/21hSAOyxvWzlfcTyg1WSUuQxHDXvDvmN3lpxB02
         ej0DLMEvAf8S1YVFIb61w0mDWMR793YdZ3YIHn9a7t7ZxU/4A0DVieYSU4KYgccZtO8C
         W0d5MnLT7+WrmnZ9cJ135R76IUHgL2rqZSQ/h4LASdB8h2e0+uax9yjGIw31p4tuTRf1
         OxfMDNLFpY3POZ0yl9X2ouDzGJLcC0KIZ1CnYoVGT2/hTwVoeF9ZgNt8JRMldLkqinZc
         LK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708767073; x=1709371873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmY5NkPyqyDzoEieFjYp7SW5hjVc2+Nb3/NQOzb8Ges=;
        b=sAAozd+zs8ipI3b4lUrvSJvrHMv4OSoNfwffvl8aKSJEmhY3VFI0TJ9lCBwkdmdjuj
         f8cJzxmNvGQ+VHz+A4CcQjF0LOX9ALZfTXti4XijHsTOwCO+egejoJDX5RiPoa9Z7vMu
         O3wgCqM/CHZlla233KaNWfvtfBqTKfNsD8yQwI6FqmdGmEV029ws/FlN55RLkSMJNs3u
         XSUkDh30HOTZyrbToXAKZeMT25Np6W1nTLvO0RVLuVmTp14nLzQzJQLt1FfdDpiu6Mw+
         hB21iISVBiAf0jidDAjjXghgXwdkd93Su2NLyAL2mFod3oaNU5m2DEOUHEYPE1Xb38eR
         CNXg==
X-Forwarded-Encrypted: i=1; AJvYcCWZZZT5B7AqCNRXDMw9LSxlQ9rgggzYSNAKLJ3QKEz1kDD2Wj/pRQwpx/jh9SWgFBfosFT1qfB7sR6lNaD75B2KJlKsCsUUJrtUTMXIDvFp
X-Gm-Message-State: AOJu0YxwT2rxykLma75Zkgf1fkEdMDWo3CABHbUs2TQnF3Sl8NoixpwW
	ZUwbuLySzwoXxVC+hVcb67/YKXJHEHrQTqLqTRl+1eNSPKJP1OoU8u3DN3GwMtgsvptZr9CEHoY
	HMKPSHuQId16hlPt+b59+tgXJ8eYl8pShx3sE
X-Google-Smtp-Source: AGHT+IGOZl/nBisuhQ6zD6jxD83U4XFWrPSRI4XTF0ONfj1DyW3nznVrpeMbXo6M+AY0O65iMMFktnvrm6rpep/W1WI=
X-Received: by 2002:a50:a6d7:0:b0:565:733d:2b30 with SMTP id
 f23-20020a50a6d7000000b00565733d2b30mr114515edc.4.1708767073364; Sat, 24 Feb
 2024 01:31:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com> <20240224-tcp-ao-tracepoints-v1-3-15f31b7f30a7@arista.com>
In-Reply-To: <20240224-tcp-ao-tracepoints-v1-3-15f31b7f30a7@arista.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 24 Feb 2024 10:30:59 +0100
Message-ID: <CANn89iKB3ov_rthyscWn=h4yxmhReXAJzHu9+dOdpzPA8F=C-w@mail.gmail.com>
Subject: Re: [PATCH net-next 03/10] net/tcp: Move tcp_inbound_hash() from headers
To: Dmitry Safonov <dima@arista.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 10:04=E2=80=AFAM Dmitry Safonov <dima@arista.com> w=
rote:
>
> Two reasons:
> 1. It's grown up enough
> 2. In order to not do header spaghetti by including
>    <trace/events/tcp.h>, which is necessary for TCP tracepoints.
>
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Okay, but what about CONFIG_IPV6=3Dm ?

I do not see any EXPORT_SYMBOL() in this patch.

