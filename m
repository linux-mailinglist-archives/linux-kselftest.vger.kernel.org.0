Return-Path: <linux-kselftest+bounces-6630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774C088C57D
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 15:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35F43045A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 14:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060F213C67C;
	Tue, 26 Mar 2024 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYwgmkee"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E413C3F7;
	Tue, 26 Mar 2024 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464239; cv=none; b=Xdlt7BnDBE+kqOEwyNPoyr8ZN6P/+Z+Lo6AMEvnMpnp2XLC5uXq7iF3WO503Yd2EnLlE52cXgdshOFfIsdlqfPVxd5VQsueFKLg9ilsLsEYe8zOKsOOGVPiB4WBqCbINLS0Z6QHcCrJRn5UXEDiH87JgqWLWzLdsACwmmGhie/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464239; c=relaxed/simple;
	bh=jPWM6+WpUBPL+YwV08qHgIODFf2tfl+DO7ozX+Tnf+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFVietBmkn2fB1suMNK1QjjMqXyqiQ352dTARdver0k6IcDcZG1DzTedfwTUIpUw2ab78nKbuues6rTziccrBNE13jCgTWGmWWZYBEvu8zcyXJn6nGRdkw+1CuXgl5vZMT19Tsl/IDnOr9JfgMhBjy0/BGN461EvtMGRXUtaIm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYwgmkee; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-341d730bdfcso851299f8f.1;
        Tue, 26 Mar 2024 07:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711464237; x=1712069037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBZDNawipMzkUz/p9SvTq2gGRo0D52L34u+c+97yOhs=;
        b=kYwgmkeej/3XRdK8hPjYAfx3ocbDeYIPAoydNlkGEsvM9BkSZo95Ve07+2UkZxTRmI
         eCHgFiPcXjul3CvZ0Ht/WACNYuII56P5aKyLBW0cuMBOa/HQB5tnGz4pmuV4IRxQYGUE
         zvTo9vyIrTHR3nAVRCv7rpZTLi8npQXiRMrbX882NloYCaGbxwbOBUpnjLnB8l74Iig8
         Jlq863C3eOs01myYnKV0Dpn5F55red39BMOmUOdaZceRV3vqExjOFppeysURktIrnOwO
         jocD5er4HybguhHQKnMZV9dJMBuxhKeSPEqteirMOBQRbLg3Tg9wONIVJdSlTU0oq/kA
         xspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711464237; x=1712069037;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jBZDNawipMzkUz/p9SvTq2gGRo0D52L34u+c+97yOhs=;
        b=UpiEfkxdd1z+PI4GhWkTSB49yRG3v698+WcjVKp2I54p0E4g6k88EEdX1VtVa6j5zu
         fkOenuhM19qRPoyvuK6sO6Y558EjUqQtDtYiFL2Cuyhd8q7zsDhNwcsu0y3QNchxLDY3
         93MYvc70BWNJbvwdqvbHCK76kQvYbAczqs9dwx4O0dgHcBp/3mduJCy4/30cW2N/AlG6
         R38aFL8iRauoA45jnJFzf289EpqkbOsJG5NlPbnWdB8hcSHTABA//fzMb9F30ot18nX1
         XFalp39gzBC2xTOCJlAShSXDi1wmhnWZrwE8goG0kOyrDrZYuUvF28Bflzv9REfRm5B1
         PQRg==
X-Forwarded-Encrypted: i=1; AJvYcCX+xdSlaywL7vAqsVFERjMk0/n8DlGQ3g11mB0B8ZVvRrxswJenA1QZw1Nvv3lNFe81J2uuZiU6/nlZO+zg9Zt+ciWltPfatYM+DApVSKK5XoXb1UY6fHGhRQTZbeHr8FPmYbNqFoVnPg34aM76bMg+QiyfJ2KrRQyZossVSlRnHk4W2QnA
X-Gm-Message-State: AOJu0YyPZ/9V2/7WY3NyNmitLPG8tLSGLKMDJy1ScdzcZE0PuFuG1QSN
	GH0b03FgTfSLwFo+tozdiOfvmkxY4pyBld8X9hXhJI40mJ2i0k8/
X-Google-Smtp-Source: AGHT+IFr2Afh4wPA8cw5YTVxfO+9Jah04+g4n+rcVUGUTUmT1CTfF5BMd5FDJkcgxWGVd6tTbxFqIQ==
X-Received: by 2002:a5d:4dd0:0:b0:33d:c5b5:5796 with SMTP id f16-20020a5d4dd0000000b0033dc5b55796mr7649289wru.22.1711464236611;
        Tue, 26 Mar 2024 07:43:56 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id dn1-20020a0560000c0100b0033ec7182673sm12357832wrb.52.2024.03.26.07.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 07:43:56 -0700 (PDT)
Message-ID: <46e0c775-91e7-4bf6-88f3-53ab5e00414f@gmail.com>
Date: Tue, 26 Mar 2024 15:43:42 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 4/4] net: gro: move L3 flush checks to
 tcp_gro_receive
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240325182543.87683-1-richardbgobert@gmail.com>
 <20240325182543.87683-5-richardbgobert@gmail.com>
 <CANn89iKzeTKuBA3NL0DQUmUHmmc0QzZ0X62DUarZ2Q7cKRZvSA@mail.gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <CANn89iKzeTKuBA3NL0DQUmUHmmc0QzZ0X62DUarZ2Q7cKRZvSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Eric Dumazet wrote:
> On Mon, Mar 25, 2024 at 7:27 PM Richard Gobert <richardbgobert@gmail.com> wrote:
>>
>> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
>> iph->id, ...) against all packets in a loop. These flush checks are used
>> currently only in tcp flows in GRO.
> 
> I think this is a bug.
> 
> GRO should not aggregate packets if their ttl/tos fields do not match.

AFAIU, the only UDP flow where ttl/flush_id need to be checked is when
udp_gro_receive_segment calls skb_gro_receive - could you confirm / point
out if there are any other flows to which these flush checks may be
relevant?

As I've discussed with Willem in v3 I prefer to fix this bug in a separate
series.

