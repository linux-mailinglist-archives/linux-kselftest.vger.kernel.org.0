Return-Path: <linux-kselftest+bounces-2130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F202681692A
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 10:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75981B20EC6
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 09:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339B210A22;
	Mon, 18 Dec 2023 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgtT/IY4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D131412B6C;
	Mon, 18 Dec 2023 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d04c097e34so20541605ad.0;
        Mon, 18 Dec 2023 01:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702890287; x=1703495087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8YU1reJ9K3iukGIMAlWDnrpIVtAk/bboD9gXjUJSYOQ=;
        b=fgtT/IY4dLvX8ahW5kmvZNrHEY2hFJ72OMBd2lq2T8oIxjQC38Vsr0VhXOCuQLOYST
         OZVth1nc/iwrxueiwFSDd7fBTlqqS2GEPskPKKWfux25L2pFAeTAqp9o3qRWdiSCvruR
         eahF+n6ay9/kef7YNY2O8LwsJyUa+5NUEsGhHzTf3P5yFkQGI9iz7l5fie8Q4NdPSgMD
         EoUI5I37g33YtXnG6B3kX/9Xue7b5nWE01ifDX5kb3zAkUR7hM3WiJc9pi3lobby84Eo
         z43QrfEyGRO2o+b5BoeV767i5FRUQjE0n7Z+qtdFfLonActZOojcHvfEgYjiFMM+Aqkr
         WWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702890287; x=1703495087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YU1reJ9K3iukGIMAlWDnrpIVtAk/bboD9gXjUJSYOQ=;
        b=faeGhQdtjj9S0sZV0Xg69Go0vc+50Ex2Enp7K4HXiibjc2fFD0uLWBAhmSQ50X83xk
         aRnWXV7uAZ4lgDgNuqsX9Rm8BP8jDSH9gH/pzIJHhd5aVVXRpIJ5yWCi/zjNG+04S282
         8bmitQylfv0BDP5ANQ/6siUXrz+wBvZAtF4cAMwkBRUhP5i2I5L6JEhXSF/9NhcsfYfw
         aZMVEqzSUiLy+Z50V0Selz8L3AF0zKNjE1R5v19PqeyhGZ8b/cjOiF2w9AdmtrtiXGox
         Fay8FAUAyrj8cmGXMxNlJLEeSh3sPjsWe4q33/t0oe2mQEU92Y+qOuUXLOrOnH/mLsgX
         pFEA==
X-Gm-Message-State: AOJu0YzWXAb97uobZ2Zzzr22gn28hhYD+m6HcEy9WZ5jHmNcPbyOUOTQ
	ByfhbRg1+bWe+K3BodU1A7k=
X-Google-Smtp-Source: AGHT+IEYtZJkpuaQCy6F85uGc0t/zB4XAkh9CanuyYqHbEGu2p4qs3yLw/2+PTY0aW5BZI4g9Z6Z7Q==
X-Received: by 2002:a17:902:c3c6:b0:1d3:a674:6da6 with SMTP id j6-20020a170902c3c600b001d3a6746da6mr2766688plj.49.1702890287101;
        Mon, 18 Dec 2023 01:04:47 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902bd4200b001d369beee67sm4196951plx.131.2023.12.18.01.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 01:04:46 -0800 (PST)
Date: Mon, 18 Dec 2023 17:04:41 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Dmitry Safonov <dima@arista.com>
Cc: Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Salam Noureddine <noureddine@arista.com>,
	Bob Gilligan <gilligan@arista.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH 03/12] selftests/net: Add TCP-AO ICMPs accept test
Message-ID: <ZYALKQGYuRrpOo_A@Laptop-X1>
References: <20231215-tcp-ao-selftests-v1-0-f6c08180b985@arista.com>
 <20231215-tcp-ao-selftests-v1-3-f6c08180b985@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215-tcp-ao-selftests-v1-3-f6c08180b985@arista.com>

On Fri, Dec 15, 2023 at 02:36:17AM +0000, Dmitry Safonov wrote:
> Reverse to icmps-discard test: the server accepts ICMPs, using
> TCP_AO_CMDF_ACCEPT_ICMP and it is expected to fail under ICMP
> flood from client. Test that the default pre-TCP-AO behaviour functions
> when TCP_AO_CMDF_ACCEPT_ICMP is set.
> 
> Expected output for ipv4 version (in case it receives ICMP_PROT_UNREACH):
> > # ./icmps-accept_ipv4
> > 1..3
> > # 3209[lib/setup.c:166] rand seed 1642623870
> > TAP version 13
> > # 3209[lib/proc.c:207]    Snmp6             Ip6InReceives: 0 => 1
> > # 3209[lib/proc.c:207]    Snmp6             Ip6InNoRoutes: 0 => 1
> > # 3209[lib/proc.c:207]    Snmp6               Ip6InOctets: 0 => 76
> > # 3209[lib/proc.c:207]    Snmp6            Ip6InNoECTPkts: 0 => 1
> > # 3209[lib/proc.c:207]      Tcp                    InSegs: 3 => 23
> > # 3209[lib/proc.c:207]      Tcp                   OutSegs: 2 => 22
> > # 3209[lib/proc.c:207]  IcmpMsg                   InType3: 0 => 4
> > # 3209[lib/proc.c:207]     Icmp                    InMsgs: 0 => 4
> > # 3209[lib/proc.c:207]     Icmp            InDestUnreachs: 0 => 4
> > # 3209[lib/proc.c:207]       Ip                InReceives: 3 => 27
> > # 3209[lib/proc.c:207]       Ip                InDelivers: 3 => 27
> > # 3209[lib/proc.c:207]       Ip               OutRequests: 2 => 22
> > # 3209[lib/proc.c:207]    IpExt                  InOctets: 288 => 3420
> > # 3209[lib/proc.c:207]    IpExt                 OutOctets: 124 => 3244
> > # 3209[lib/proc.c:207]    IpExt               InNoECTPkts: 3 => 25
> > # 3209[lib/proc.c:207]   TcpExt               TCPPureAcks: 1 => 2
> > # 3209[lib/proc.c:207]   TcpExt           TCPOrigDataSent: 0 => 20
> > # 3209[lib/proc.c:207]   TcpExt              TCPDelivered: 0 => 19
> > # 3209[lib/proc.c:207]   TcpExt                 TCPAOGood: 3 => 23
> > ok 1 InDestUnreachs delivered 4
> > ok 2 server failed with -92: Protocol not available
> > ok 3 TCPAODroppedIcmps counter didn't change: 0 >= 0
> > # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Expected output for ipv6 version (in case it receives ADM_PROHIBITED):
> > # ./icmps-accept_ipv6
> > 1..3
> > # 3277[lib/setup.c:166] rand seed 1642624035
> > TAP version 13
> > # 3277[lib/proc.c:207]    Snmp6             Ip6InReceives: 6 => 31
> > # 3277[lib/proc.c:207]    Snmp6             Ip6InDelivers: 4 => 29
> > # 3277[lib/proc.c:207]    Snmp6            Ip6OutRequests: 4 => 24
> > # 3277[lib/proc.c:207]    Snmp6               Ip6InOctets: 592 => 4492
> > # 3277[lib/proc.c:207]    Snmp6              Ip6OutOctets: 332 => 3852
> > # 3277[lib/proc.c:207]    Snmp6            Ip6InNoECTPkts: 6 => 31
> > # 3277[lib/proc.c:207]    Snmp6               Icmp6InMsgs: 1 => 6
> > # 3277[lib/proc.c:207]    Snmp6       Icmp6InDestUnreachs: 0 => 5
> > # 3277[lib/proc.c:207]    Snmp6              Icmp6InType1: 0 => 5
> > # 3277[lib/proc.c:207]      Tcp                    InSegs: 3 => 23
> > # 3277[lib/proc.c:207]      Tcp                   OutSegs: 2 => 22
> > # 3277[lib/proc.c:207]   TcpExt               TCPPureAcks: 1 => 2
> > # 3277[lib/proc.c:207]   TcpExt           TCPOrigDataSent: 0 => 20
> > # 3277[lib/proc.c:207]   TcpExt              TCPDelivered: 0 => 19
> > # 3277[lib/proc.c:207]   TcpExt                 TCPAOGood: 3 => 23
> > ok 1 Icmp6InDestUnreachs delivered 5
> > ok 2 server failed with -13: Permission denied
> > ok 3 TCPAODroppedIcmps counter didn't change: 0 >= 0
> > # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> With some luck the server may fail with ECONNREFUSED (depending on what
> icmp packet was delivered firstly).
> For the kernel error handlers see: tab_unreach[] and icmp_err_convert[].
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Tested-by: Hangbin Liu <liuhangbin@gmail.com>

