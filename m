Return-Path: <linux-kselftest+bounces-32081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124E6AA5FF4
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 16:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675B9179F6C
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 14:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBBD1F1511;
	Thu,  1 May 2025 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fk5Ca/yc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DDA29CE6;
	Thu,  1 May 2025 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746109667; cv=none; b=sd5UH0uLu3+zRUC0ICIz7XKPIESyAdVPhnjwNnPG+DKuRtEPfiYcM2/rTQhvATEqe/1nFZ3JmmOVYwHs5TugVDqjP1q+ddE3LSax9IqOHDXb0BU+/ByL/XWMqYyLxagfVf/uRUmEurKzBPRhe77fvRh6YuRGnIR0RPFxz6Sg9yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746109667; c=relaxed/simple;
	bh=e2WGSGmrKjNzE3VLNswb+N9eUzr1Q80gbtvvRn6mreE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GmkljRmIk1B0srnh9+s0FHsEjSB/EGxJcKT7ukwCuUErWmkhgY/LKk+YEq2ymF80b1cQM3wy5dFCcE8y/gDmcQDx6oJNk69RuwpMEzyCBxmLB0SnR862cl3m7AgDlBuqm+cD+LhjNht/mdWR/sVF9SEzgyVlyopirydJElN9HIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fk5Ca/yc; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c9376c4dbaso128183285a.0;
        Thu, 01 May 2025 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746109664; x=1746714464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlhhdp9q6ID/4uXioPB8kF8xFNbK7BMwdnQOnij5DYk=;
        b=fk5Ca/yc5SSlLBq8MjpQK4edjO5GIY0UNpSd4ih7hL7osUWYuzhNXFbiuwvEtolBsA
         t1ZKNKIFM7d8wENneMgAGMJ0TF8no6DcnJIHxRWRkzU29Kk5QB169NF9V4A/W195Gjnr
         nErNs0fxfq9qlmju1EIYWpel+xY5mGpCCfHug0IThfdYQqGxdQoQMteW/O6yQIUsaiQk
         NIrZgexl+FnnruySmz3C1WWehXFWXigo0EsaUVTWqIWI3Js7MQ284ERo9xWG0DSMZeZP
         ZLyy2SvNa7htxL8czTDqYpz7b9XawVczu4Lk7Crlth9oU0eDWFw9ZEU7Km5ztlAekJIF
         rm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746109664; x=1746714464;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jlhhdp9q6ID/4uXioPB8kF8xFNbK7BMwdnQOnij5DYk=;
        b=HAUkegzREiilr219Xy7BFQ8atS3Dm1GRTJwO9kSY5JNrNbOXMKB808C7zDC8XhmGxn
         Htrn3v42h2pq2CTFRtxSCzg50+Un3wP7Nc+87NpQvsIslRnwpFVP89NgQm27qlQdJW+F
         FV0QXNNJvSr680YN7+6UX5e1jE0CiZV+hpKCRm3Dx9ydPCzWFLhdHmKXIcMsm9t/oKN9
         dRWYZS9Un1p+hlzxI+q659ykloC3CjnavD0LGpuSyJlhsOE3uDNPkjfBZq2RBVfO/4MO
         IZp3tynNdqJadsJO+En5ku2m+U4LLxH7wEYPiaJI5TKfzWLlf7j7q529fF/aQFyFaIdk
         gR0A==
X-Forwarded-Encrypted: i=1; AJvYcCW62vk8W5RbD/XRCK5wppK8PAqjMq0x+RLfFsuHAEiMNKTNeUnxJjniwyxK0Exhw5Fg1Ub4koQB20rdp2E=@vger.kernel.org, AJvYcCWNp3nIo93HO1BLQ8cmjFUkkWo49EA+2YkA0/zQdC7mRAI7a/a1DkUB6j+jPuYSt33eNjYgyVfN@vger.kernel.org, AJvYcCXs+ANe94wpQ5alsoLVnEEDhheHJutvm6hbgpnHQvtebzqFMSRYzEjmPGcXy129ONGz56OCESyjwZiaPA7l1rPM@vger.kernel.org
X-Gm-Message-State: AOJu0YyYLr04JcdYPke0ttMl9q5wwgBaA3FELdrU2Xg7AaqjT8PW00BW
	SYCeI8M7/B5SRZfUPd6Pv/OYIUcEFXDuoJvliH1fCmyfpJNMhH9f
X-Gm-Gg: ASbGncueYl8XF8974VQCKpOpFF0N0cbaeyUt3yC+xXkw1XfYijgC7q9ebmBxcpNniMB
	JjEwJ20uGCDFO9zN0zlRXd3f1FdKlYXuvMaHPil6evj86yUU20MygSV/pRi0Ol86GQ82cOD97Eu
	iE0USrTvj5aNGbbek0EmGba5KydiqMHkaMJwSCwr/WGzQcEGgarrECeKEWhJmBWhAGcoR45huDi
	FG79HVH9teNtMmCS5qJWfxBKvwbyG7mis6CFOZSlefQYN6brxERZR/FqYcGuUZVQBX5bh7+mjVR
	CeWOqe1mPE2DsJlxntRy69MBiSZcw23ZjL6tKEB9g4y6z96GCDq/0mX32AQgZNYGq5JcS64ymBE
	yRhKwEmjSoX++8Z6sQCra
X-Google-Smtp-Source: AGHT+IGjqqyilZJTQ6JAChTYoPBhygOgNNNZTYMgXQete2ywNqTY8GoZgssKT1j8IztLKLrT7J4vfg==
X-Received: by 2002:a05:620a:1995:b0:7c7:c1f8:34eb with SMTP id af79cd13be357-7cacea24694mr375669585a.23.1746109664348;
        Thu, 01 May 2025 07:27:44 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cad242b5cfsm48312685a.70.2025.05.01.07.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 07:27:43 -0700 (PDT)
Date: Thu, 01 May 2025 10:27:43 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 jiayuan.chen@linux.dev
Cc: davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 horms@kernel.org, 
 kuba@kernel.org, 
 kuniyu@amazon.com, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 willemdebruijn.kernel@gmail.com
Message-ID: <681384df8e0f1_35e23e294ea@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250501071308.1931-1-kuniyu@amazon.com>
References: <1f4d3fb4eed397e346efb3ef597e29204e5a2f4b@linux.dev>
 <20250501071308.1931-1-kuniyu@amazon.com>
Subject: Re: [RFC net-next v1 1/2] udp: Introduce UDP_STOP_RCV option for UDP
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
> Date: Thu, 01 May 2025 06:22:17 +0000
> > 2025/5/1 12:42, "Kuniyuki Iwashima" <kuniyu@amazon.com> wrote:
> > 
> > > 
> > > From: Jiayuan Chen <jiayuan.chen@linux.dev>
> > > 
> > > Date: Thu, 1 May 2025 11:51:08 +0800
> > > 
> > > > 
> > > > For some services we are using "established-over-unconnected" model.
> > > > 
> > > >  
> > > > 
> > > >  '''
> > > > 
> > > >  // create unconnected socket and 'listen()'
> > > > 
> > > >  srv_fd = socket(AF_INET, SOCK_DGRAM)
> > > > 
> > > >  setsockopt(srv_fd, SO_REUSEPORT)
> > > > 
> > > >  bind(srv_fd, SERVER_ADDR, SERVER_PORT)
> > > > 
> > > >  
> > > > 
> > > >  // 'accept()'
> > > > 
> > > >  data, client_addr = recvmsg(srv_fd)
> > > > 
> > > >  
> > > > 
> > > >  // create a connected socket for this request
> > > > 
> > > >  cli_fd = socket(AF_INET, SOCK_DGRAM)
> > > > 
> > > >  setsockopt(cli_fd, SO_REUSEPORT)
> > > > 
> > > >  bind(cli_fd, SERVER_ADDR, SERVER_PORT)
> > > > 
> > > >  connect(cli, client_addr)
> > > > 
> > > >  ...
> > > > 
> > > >  // do handshake with cli_fd
> > > > 
> > > >  '''
> > > > 
> > > >  
> > > > 
> > > >  This programming pattern simulates accept() using UDP, creating a new
> > > > 
> > > >  socket for each client request. The server can then use separate sockets
> > > > 
> > > >  to handle client requests, avoiding the need to use a single UDP socket
> > > > 
> > > >  for I/O transmission.
> > > > 
> > > >  
> > > > 
> > > >  But there is a race condition between the bind() and connect() of the
> > > > 
> > > >  connected socket:
> > > > 
> > > >  We might receive unexpected packets belonging to the unconnected socket
> > > > 
> > > >  before connect() is executed, which is not what we need.
> > > > 
> > > >  (Of course, before connect(), the unconnected socket will also receive
> > > > 
> > > >  packets from the connected socket, which is easily resolved because
> > > > 
> > > >  upper-layer protocols typically require explicit boundaries, and we
> > > > 
> > > >  receive a complete packet before creating a connected socket.)
> > > > 
> > > >  
> > > > 
> > > >  Before this patch, the connected socket had to filter requests at recvmsg
> > > > 
> > > >  time, acting as a dispatcher to some extent. With this patch, we can
> > > > 
> > > >  consider the bind and connect operations to be atomic.
> > > > 
> > > 
> > > SO_ATTACH_REUSEPORT_EBPF is what you want.
> > > 
> > > The socket won't receive any packets until the socket is added to
> > > 
> > > the BPF map.
> > > 
> > > No need to reinvent a subset of BPF functionalities.
> > >
> > 
> > I think this feature is for selecting one socket, not filtering out certain
> > sockets.
> > 
> > Does this mean that I need to first capture all sockets bound to the same
> > port, and then if the kernel selects a socket that I don't want to receive
> > packets on, I'll need to implement an algorithm in the BPF program to
> > choose another socket from the ones I've captured, in order to avoid
> > returning that socket?
> 
> Right.
> 
> If you want a set of sockets to listen on the port, you can implement
> as such with BPF; register the sockets to the BPF map, and if kernel pick
> up other sockets and triggers the BPF prog, just return one of the
> registerd sk.
> 
> Even when you have connect()ed sockets on the same port, kernel will
> fall back to the normal scoring to find the best one, and it's not a
> problem as the last 'result' is one selected by BPF or a connected sk,
> and the packet won't be routed to not-yet-registered unconnected sk.
> 
> 
> > 
> > This looks like it completely bypasses the kernel's built-in scoring
> > logic. Or is expanding BPF_PROG_TYPE_SK_REUSEPORT to have filtering
> > capabilities also an acceptable solution?

Reuseport BPF exists because we want to avoid having to continue to
add custom rules in C for each scenario.

In this case, I did wonder whether it is possible to avoid hitting
the soon-to-be connected socket with the standard reuseport
algorithm in reuseport_select_sock_by_hash.

Setting SO_INCOMING_CPU to a cpu on which no packets arrive will
lower its priority relative to other sockets. It's a bit of a hack,
but should work?

