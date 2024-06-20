Return-Path: <linux-kselftest+bounces-12374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E59F59115D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 00:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7341C1F219AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 22:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F4D13D278;
	Thu, 20 Jun 2024 22:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1jU33LW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB1279949;
	Thu, 20 Jun 2024 22:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718923678; cv=none; b=QjaYZ0pvlUYif7hz9gv4w1FpaqTA9l6IKWCkbyxT+7fWs3FFkvbUIoiWS1pgtgs+00SYMfuxQ4nAl0RYbfkyLuD+fqqepj3eKzbCSfjPvYnR4E7VurQ05uxezraR+5QCzBhv2WUiVoUe/0GmBvLGAow8nNq8puu+vruE9wEkUW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718923678; c=relaxed/simple;
	bh=OcvbwW7S3KCiswLqyMQtEzqQAARGiwx0OKDa49cIg7Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q0xPJUciPh63P/PBK06POPoZRtj8FCDek3ZLQp2MhUej0tg2YSUg25JGt/+Xj6S5g003LxrS5kk5r1WkkOHkOfE7ebqL8nQEepfMT3TOv79zDfSZfCeQhvDTaeWyohErf9YbI0nwgCDyc/w4yAamlrgvji9QqscsfzTyYI6cbCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1jU33LW; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70601bcfddcso1398767b3a.3;
        Thu, 20 Jun 2024 15:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718923676; x=1719528476; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OcvbwW7S3KCiswLqyMQtEzqQAARGiwx0OKDa49cIg7Q=;
        b=G1jU33LW12GSlQR5lcXCrppX2FaGnEJGFxPlZkvDZCSA1BnP+SVLcftdXvXyCkXWN4
         tUUbMI0Rax4zCWEGh3uHEmSBmZg0eMGqEPACUP+LtTYBmmXYQWK4mU3J6vwjMsPRi7ao
         0ViylUTA+Clep24iYsUc0wcpgD02PIC6i4BthxiwO0TubN5zRxxidWg8zjkqUlp+4Avt
         FUzahOErLXWXvqirlaEKx7xcqi0x6dDWUtIH53Iu1ExGfKnizFAgPFSPtt8UdhQ79kiE
         h2yB15j4N174uCgLcXS8EhAGXGR+aJfopds3TKA2S7DhyXX6oHaZJriB4soK7bCyfgqy
         0B+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718923676; x=1719528476;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OcvbwW7S3KCiswLqyMQtEzqQAARGiwx0OKDa49cIg7Q=;
        b=hsTwzh56S30OCNkNgux2W0jlSGDoV71oqIYW5dNPV4EBWY/BV20JVWFO23QevGeBUu
         xon2pQCZTk7EeU8wSR/vBVT0uhuoO5Y8g2qAkpUHJ9nO9vDifzk1XXISucCl/cYsAcab
         g0TlnaO9BCRgqJ6xoIBGFBDSXJ215VQt2IujVhZi38N4MvoLVRaeMoRCP7ynKI2kNBOw
         NhuruRhVO+ftG8z/sYBvbjH2v8mrNhDAm9XnuHE4QWgV4XAC+S3JONFsmPsns9TW35lD
         iBuN2p8MW5kJb0FkBNRaTPSZ6ng3xJTD3TGgFteF7ME751B8X1bfmBwRNr0DmzHVnHZy
         7zjg==
X-Forwarded-Encrypted: i=1; AJvYcCUD9QgmULgX7VKPnyKSB45UsZBwop64OnUY0u4WZpoH4fO/tED07qQKCfueo9XZRh5zbT2C2EvV5+vFkA3YEB5k8OzVfDPHUVsc4H6GW+T2UoqlYKsUWk4VJFWotYTH2zKliIX0
X-Gm-Message-State: AOJu0YxbIIwUN9IDuidjdTScL9htXe1qlVwqr0fo6MCFdG35r/gbPJzB
	b3viMIxKZ9dchUQ/uGeiWr8Xx33CuJqGU+4wkC0QnWyzX3VQ/Pfz
X-Google-Smtp-Source: AGHT+IEoMH0Ce8g6qfFMZbOXebkjN73qYU8/dxgw8wLxiefPV1DEmm0c1OczhJyqHnfrQiY4q62xWw==
X-Received: by 2002:a05:6a20:77a5:b0:1b6:dffa:d6ec with SMTP id adf61e73a8af0-1bcbb5e34e5mr6819067637.46.1718923676519;
        Thu, 20 Jun 2024 15:47:56 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e4ff97e2sm2233227a91.10.2024.06.20.15.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:47:55 -0700 (PDT)
Message-ID: <dd1387bfa694e7d1f792441d1e2e80b9b85c8c35.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/6] selftests/bpf: Drop type from
 network_helper_opts
From: Eduard Zingerman <eddyz87@gmail.com>
To: Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Thu, 20 Jun 2024 15:47:50 -0700
In-Reply-To: <db1a7bdb3ae9b51001c1220d1783d816302598a7.1718765123.git.tanggeliang@kylinos.cn>
References: <cover.1718765123.git.tanggeliang@kylinos.cn>
	 <db1a7bdb3ae9b51001c1220d1783d816302598a7.1718765123.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-19 at 10:51 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>=20
> The opts.{type, noconnect} is at least a bit non intuitive or unnecessary=
.
> The only use case now is in test_bpf_ip_check_defrag_ok which ends up
> bypassing most (or at least some) of the connect_to_fd_opts() logic. It's
> much better that test should have its own connect_to_fd_opts() instead.
>=20
> This patch adds a new "type" parameter for connect_to_fd_opts(), then
> opts->type and getsockopt(SO_TYPE) can be replaced by "type" parameter in
> it.
>=20
> In connect_to_fd(), use getsockopt(SO_TYPE) to get "type" value and pass
> it to connect_to_fd_opts().
>=20
> In bpf_tcp_ca.c and cgroup_v1v2.c, "SOCK_STREAM" types are passed to
> connect_to_fd_opts(), and in ip_check_defrag.c, different types "SOCK_RAW=
"
> and "SOCK_DGRAM" are passed to it.
>=20
> With these changes, the strcut member "type" of network_helper_opts can b=
e
> dropped now.
>=20
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

