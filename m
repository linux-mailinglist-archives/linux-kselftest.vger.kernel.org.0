Return-Path: <linux-kselftest+bounces-12368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8439115AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 00:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5DC1F22EF0
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 22:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945B914F9FA;
	Thu, 20 Jun 2024 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk/+7Z1D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2324143737;
	Thu, 20 Jun 2024 22:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718922174; cv=none; b=IWudQed1alIV+2qPFgCfb3lxINBCsqmiWBQJOmTShmi4S0OqkCYOF9xevzmzcUhKhKDP5S0+WXSfmzjrVTWD5cJLSAtdY9L/95EaVbbww6V0/UvEPHMSJ0a1HhCl0G0AzaZS9vCj/jioLhdz098IZc4zwEZSvq/H1Pc5uHx963s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718922174; c=relaxed/simple;
	bh=sHMWDii6L39nvvLe3wn2VrM4Hsd6Vkv52J0MljCu0I8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GrPkne1HtcqR6WPQmsiIBdV9eMAJjNitYDEVODjjz1bRGFDaoY1Go/CAtoPGl5sNKw3ydTx1a2huRyfHiWK1Dov4nNS/ZmsZC0jCz2htNK8wOVlMj3h2r+H2Rbko5zooPWU8mpyao37Gu/RREI0sEQ6oUWjBk4IQ1fSxm87+1FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uk/+7Z1D; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-704090c11easo1157789b3a.2;
        Thu, 20 Jun 2024 15:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718922172; x=1719526972; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sHMWDii6L39nvvLe3wn2VrM4Hsd6Vkv52J0MljCu0I8=;
        b=Uk/+7Z1DlCcoBneBpy/2ZPe8M2xz0DJuwFcYP6gxvrpBMbJTk0Mf9zk891qZndWW3p
         YcXHSam15ofPiEua0iSvBOi8YReuWeDmt9UuZOwiCXZtxL58YRRQUuZ0xfcEbxIvFjIP
         5LeC4PBOBOyRdWgHVLRIVNaGF9XjIpFVmSpgmPZVuSeihyTgf29hDai64HrvhJJgYF49
         lQyCgpE1NUVz/TQf9CCJCo36862BStk0aXl2AxzNyniIgYRe+7EyL8gQdURLO1wVrpDO
         /k46n4G/FBVq97SzfO4RBUSbNcuma6s60FQxaesWWWpbxwdxM22unAFCrlsbjOjpFx1H
         E0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718922172; x=1719526972;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sHMWDii6L39nvvLe3wn2VrM4Hsd6Vkv52J0MljCu0I8=;
        b=rE8WP+DtCxgJqmfIa61nMnHaQyvMvn+1rlRWyVu9ULysiBWFSUlFxkGFZcx8gGjChp
         oeypoDF/jZs0ixzuJK9SPzw/p+dshJDouWV6GEZMK23pl4F676GIcReoLLgta9ZAjXHr
         eXYalsf/Qt9im1krAnDbv+oFfghGGE7UJ9WuhO3qjL/eE9uZ81xMfUi4EqsVHXYh1X0r
         4FujQwOxd04LSoPN4+asIk6D2lpcaa+TGOVoXT3m9pCth2vjkeortCvN+tGX9djB4bHY
         Lk4G/mAHjhgNX+eaR3A6jZrkER0D86v9N/S0ldLQEdNPlHK4ONcn25+On5p3oZUe5TYK
         poRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgupYiWFNXqu4iXEtconEep0GTCs1kICNbHCLB6xD+rACz3PgQ10vAntv1HPCxRciOXzwMRzf5+KpHzgp8XG0s20ZtEyfpqsQ2eNvHUn0JzCX9ptSHLAhmQzmhjMxflE7GStWp
X-Gm-Message-State: AOJu0YxlObvHcJBrelZ0NA2bCQJYd2fASsn1Ftf8ejF0+o1PiRxN34+t
	+cFYBShKk19m1zOfVFt/fuqHQEKChMqP8tjyIZAcaPRimkByr3v3
X-Google-Smtp-Source: AGHT+IGFMqooey6J29dYqt8MSSD7eOGbfQ3WNxCrNqHCtkBTPXV7CqN/h+uev7YQoDgIh00VNLTJBw==
X-Received: by 2002:a05:6a00:2b43:b0:705:98d4:6220 with SMTP id d2e1a72fcca58-70629cf775amr6130324b3a.30.1718922171791;
        Thu, 20 Jun 2024 15:22:51 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716b4a7052esm57162a12.45.2024.06.20.15.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:22:50 -0700 (PDT)
Message-ID: <933f547d145ff1fde49d036b356eb35d78d8c661.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 3/6] selftests/bpf: Add client_socket helper
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
Date: Thu, 20 Jun 2024 15:22:45 -0700
In-Reply-To: <1ce930a1587977be1c6cfe576ec45f159553123f.1718765123.git.tanggeliang@kylinos.cn>
References: <cover.1718765123.git.tanggeliang@kylinos.cn>
	 <1ce930a1587977be1c6cfe576ec45f159553123f.1718765123.git.tanggeliang@kylinos.cn>
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
> This patch extracts a new helper client_socket() from connect_to_fd_opts(=
)
> to create the client socket, but don't connect to the server. Then
> connect_to_fd_opts() can be implemented using client_socket() and
> connect_fd_to_addr(). This helper can be used in connect_to_addr() too,
> and make "noconnect" opts useless.
>=20
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

