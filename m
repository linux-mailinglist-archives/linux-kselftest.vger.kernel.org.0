Return-Path: <linux-kselftest+bounces-6631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B468888C58B
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 15:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6B41C62F7A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 14:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D601813C66E;
	Tue, 26 Mar 2024 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SqquaAIH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0AD13C3EE
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464413; cv=none; b=gNgCACVX7IU3MgVvBtjtcGx+6Jazb+ur6ucnr10otMjqkfJNcxDja6ZIo6Dk7xhPqU/srZjT9QYto46SEbSTwuIflOJ2Xw6+X2nxzdk/4GtJ2MiJRKrchqlKLodUC6cbinE8MU4pNddnebZZZHh5EEr8pFXvii4gRjH8m+g7CXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464413; c=relaxed/simple;
	bh=dVw2sCCZsjOclcEyJtFzLmGPKBY9n3k3XeHTRvzsKws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YANL3EKjnjkvjkW+20NBYr+dgGwwIUFn3qRe8XzqaigvV4ptPhPih+GLIX4UXL8riUXebQVWm2pF0okoI9fsCV84MghxpsRcg7uGGmVaErWrSh4XUiE1BJEVlqD570WojXkfCD1IMDbWzkcv95bdE8Fsh1iycXiUYVWZAIi3YfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SqquaAIH; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56bde8ea904so14112a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711464410; x=1712069210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVw2sCCZsjOclcEyJtFzLmGPKBY9n3k3XeHTRvzsKws=;
        b=SqquaAIHb4Yw0ver83CxpNmIiJbclD87OH/QF3hJGrsmwxOgo/Y+mbANkxY4BaPodx
         QC+4pcPW/4yXo8vc2uLyjF3EYuc7nsHRfyW/DESdmnrLy7lLs0ZgEeB/oK/4ycbXXAYb
         40rahRzYpuT1EtuwIAFr3q2Dl1pmXqO5/8douSnwAR0916Bqk8HxEpreKjHi2/qKj8M7
         AYBfM0m7CVcoM/FbyjZDXd4AwHo+xdYgFTOQ4M+Q4XYghIA3ZT3zHDHA25UivMeKHWAX
         UzDc+o1NvQ28V/OPDZexXg1+BSRef2+YIKmeviB4iTMBm/pVM9G+SYSwRQ336aesRCyr
         agxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711464410; x=1712069210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVw2sCCZsjOclcEyJtFzLmGPKBY9n3k3XeHTRvzsKws=;
        b=xVhhc+BbP1eSJUm7mU8BOouWvArvLhK6oPuBnkVGl4JpUKNM9+qdtE0cqSOMSLLOL0
         vVHD6/IheYxbxRGQBV/7lYFgcP89lWmRQN9KZbRAZyI6JuEO08OAuIMpHKGDuxPg/yZ3
         K2Fj2SM06Ys8fLi+ZYZgm+GTjjTIn3lCaaRPpYyRxjYxhltDF2/0a13ewQcL0LsS6vw4
         rJ9sCty3QpmKzht5/fRXFbEobUyThvm2gjoPkaYiWvVZcKaJJMs7K776oREgzP/sdccn
         AJuQlJl8mNUZy2BezM/GszkE5dcnW6EOnwrbTgiyXGou/hGVDdDSYfJQufC1KL2n3Onw
         Kybg==
X-Forwarded-Encrypted: i=1; AJvYcCVtDW2ideU95Zg/7BJ5t/ffrfSV44z3c5CK3Czyfj7CEDVaRUbXBvXZzofbkhoiaFWgB5Wjgv5rGSaxxzWmhAy3vYHPPMVbPa/tBN8jf3pM
X-Gm-Message-State: AOJu0YxKUlyWHBU2rjF2YhXveke+/6QisPOZ/hhViaZ1oFyUt7k5tjeb
	SBoCNJflEDU36mZakMcLXA2fHoZsAfTZLsno+Q5JA4EUx7b92xwbESX+PwUXY4nrtUKQ3NCXi9H
	G2431YXK0JTRmhqHlhXt/ZHfgpJhqZLBmT1F2
X-Google-Smtp-Source: AGHT+IG9LbpsClHFRdFkwkVL7pLUpmQRG00kiEIP3HmNZZDos4Tq2PhwBiVFXB28ezLKitT3SO1TZnjwEjpGhUtA9hs=
X-Received: by 2002:a05:6402:7c2:b0:56c:9ae:274a with SMTP id
 u2-20020a05640207c200b0056c09ae274amr120016edy.7.1711464409816; Tue, 26 Mar
 2024 07:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325182543.87683-1-richardbgobert@gmail.com>
 <20240325182543.87683-5-richardbgobert@gmail.com> <CANn89iKzeTKuBA3NL0DQUmUHmmc0QzZ0X62DUarZ2Q7cKRZvSA@mail.gmail.com>
 <46e0c775-91e7-4bf6-88f3-53ab5e00414f@gmail.com>
In-Reply-To: <46e0c775-91e7-4bf6-88f3-53ab5e00414f@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Mar 2024 15:46:35 +0100
Message-ID: <CANn89iJkDbzLKmUGRHNFpfiaO8z19i44qgqkBA9Updt4QsRkyg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/4] net: gro: move L3 flush checks to tcp_gro_receive
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 3:43=E2=80=AFPM Richard Gobert <richardbgobert@gmai=
l.com> wrote:
>
> Eric Dumazet wrote:
> > On Mon, Mar 25, 2024 at 7:27=E2=80=AFPM Richard Gobert <richardbgobert@=
gmail.com> wrote:
> >>
> >> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
> >> iph->id, ...) against all packets in a loop. These flush checks are us=
ed
> >> currently only in tcp flows in GRO.
> >
> > I think this is a bug.
> >
> > GRO should not aggregate packets if their ttl/tos fields do not match.
>
> AFAIU, the only UDP flow where ttl/flush_id need to be checked is when
> udp_gro_receive_segment calls skb_gro_receive - could you confirm / point
> out if there are any other flows to which these flush checks may be
> relevant?
>
> As I've discussed with Willem in v3 I prefer to fix this bug in a separat=
e
> series.

I do not understand this patch 4/4 then.

Why bother moving stuff in net/ipv4/tcp_offload.c if we plan to move
it back to where it belongs ?

