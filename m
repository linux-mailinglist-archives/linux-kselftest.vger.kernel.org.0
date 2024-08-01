Return-Path: <linux-kselftest+bounces-14672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA04794524E
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 19:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8CC1F23B18
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 17:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B659A1B4C49;
	Thu,  1 Aug 2024 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsbY2QEB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C52F182D8;
	Thu,  1 Aug 2024 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534809; cv=none; b=Y5vQ6343KvxoSFpHztLoxXpsPVK2zNsygyDsaOmJuvQlPApca5570FgachjkH/N2i3xc1t3b1iiqAWhzLudmoYoAceaVzOOS85kzdQIiiwR3cF+MhZCIaxYy/uPmjhVwwo5se82cFqGD/z1/caG5eNKeMH+K+VqfskYzOBxyWks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534809; c=relaxed/simple;
	bh=mGLolEufx6bum48H+BAmq0wMhphlEPb+F/nkHuBPXKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNn+r2z90jfPHDReNUalT+HjVEdToTVQh10YrVdzLwhgYuCf9SsMF1tjqgIid8w/BL9oWYJ9bScUZydGhMHJxy2HxWa/6mkMFzukzyZdKfICsuGi88Kp7df9QrhnRe4lvuqJ0Ef4+cMOZG+/468pq/ooYh6maLBHQQH4Q4TTuE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsbY2QEB; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e0be2978a0fso27180276.3;
        Thu, 01 Aug 2024 10:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722534807; x=1723139607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGLolEufx6bum48H+BAmq0wMhphlEPb+F/nkHuBPXKw=;
        b=UsbY2QEB7SejjZycKN358DMUYAsbJF0lrAeEG9F6yTVzwCwbcShUyUj3CZh+kIGxGC
         mB/cSwYBlw3s65BiOFXV1BhdpksSD+s5pEThOpzJbzeuy2RYq43FjM68SLNU0A2E/wUB
         dpTZJWtiFlZAocjUPiU7SvZr8wYSTMfONxwCaMJuW3KhiebRfFlIedhKVAYxamgAgfEm
         0xA4ZZx5Rr5aiRX37jpIFic4Vasnl/jP5gLKZUDCi7+IeKqaIbdYvQWmxxPUaPg4OukG
         agoQT5wjCYwAAw61Ac+fuCJQdluYObEiT4Nm6x854/HhvNfsAO/REQPeRu28MfJePDex
         7Fuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722534807; x=1723139607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGLolEufx6bum48H+BAmq0wMhphlEPb+F/nkHuBPXKw=;
        b=pzcfomn2+698lxuQiigAvzAUTOIcFU9nhyKTks6Hr25qu3h8PzqxjEu9TsGKQupMmt
         0a1A2cVWz2COBhzBtCwPwDWgMGoCXhwMU+99H/GBhwgvcMyL5AJxP/vKUCUnlc5qcwCF
         JcvRgDKOFjoh7oCSVgvV2yMrxIBacuKebRpT6m588dkmBgJNBaZiXjl0FK+KZUqF/One
         tIT8BX4PELMH4eX5gcbnD9gwC+UjWNhg2iknyni1tx8YM6gv9bpM02g9YpgZqoASIMH9
         J6jh8IPVnhSHK7ybw42dLtCIG+/3EIy28ZsNNhrR8/nLhpxqgxO0kerzy23zoTtTDldt
         6wAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkCPCf3/3JweVuHXIMgfoSdwdQNsP6W/0B5GclfQD4WgXsMXMtWv/tPns/1ZMWOxRJ8Hr95H5mIC1GsGgdAP0Uvr4VrVgoW2SACuYkM73mlKeiiqQZsgxlEpw5uIA6uAzr2D+3/lmbA2CpHl0hnGfGqK2/GH6OUrxDStMbwgNvdEiW
X-Gm-Message-State: AOJu0Yz9s3A5DZc+cBi7vxmWo+7Y/OiEAnMQC3yryQ+PIgPhaTIIdWjU
	Yf7ehwkBcnxcfxozzWqpHXljRZD5jOsnhUwkQq/4rSxLK0FZSjP8+aqA9WDdyJJx/U/aiPBqBS1
	+KASYJng9MrmIH/vvVroG1gb++AE=
X-Google-Smtp-Source: AGHT+IGdpJoRQYWy9uB+AHFV/AQvp5FWr8KDs+A2Eq4BrwMEYvt4CDISHnkekaZ6DeZK1ghY0Ezjm0jqUUi94iazTj0=
X-Received: by 2002:a5b:51:0:b0:e08:5f16:813 with SMTP id 3f1490d57ef6-e0bde4c8fe7mr1010237276.53.1722534807037;
 Thu, 01 Aug 2024 10:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730184120.4089835-1-zijianzhang@bytedance.com>
 <20240730184120.4089835-3-zijianzhang@bytedance.com> <66aab8b37157d_21c08c2941@willemb.c.googlers.com.notmuch>
 <20240731182908.4584a3e1@kernel.org>
In-Reply-To: <20240731182908.4584a3e1@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 1 Aug 2024 13:52:50 -0400
Message-ID: <CAF=yD-K5=RSLD0b+0hdp2_dvGbbA04aKygh3f947zM_sgjb=yQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 2/3] sock: add MSG_ZEROCOPY notification
 mechanism based on msg_control
To: Jakub Kicinski <kuba@kernel.org>
Cc: zijianzhang@bytedance.com, netdev@vger.kernel.org, 
	linux-api@vger.kernel.org, almasrymina@google.com, edumazet@google.com, 
	davem@davemloft.net, pabeni@redhat.com, dsahern@kernel.org, axboe@kernel.dk, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, cong.wang@bytedance.com, 
	xiaochun.lu@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 9:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 31 Jul 2024 18:20:35 -0400 Willem de Bruijn wrote:
> > Btw patchwork shows red for patch 1/3 due to a new error or warning.
> > Not sure if it's a false positive, but take a look.
>
> Patchwork is not for contributors, I keep repeating this :|
> Were you not in the room at netdev when I was talking about NIPA
> or am I this shit at communicating?
>
> Next person pointing someone to patchwork will get a task to fix
> something in NIPA.

:-)

It's a super informative tool. I did miss the point about the intended
audience, use cases and known limitations (such as false positives).
Got it now!

Looking forward to the netdev talks and slides online soon.

