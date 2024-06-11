Return-Path: <linux-kselftest+bounces-11707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D0F90461E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 23:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20D7EB24C05
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 21:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56662154449;
	Tue, 11 Jun 2024 21:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxGMHtiZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B454415442C;
	Tue, 11 Jun 2024 21:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718140318; cv=none; b=uSsspC4HQu8XXnm1pW9zwlQm+6FxSiX8a3Y5kNCkVamN4oOh6fHwbcIktnU79C7AiyBdW3wab39CS1x9Z+Jqg2Fxa2UU4iqwcJyfDsO4JpXUTP2f5MdR4iA+37iYkgIDF9wm8gqWnxkRkNVWnmXVl5g+smZ1+tiy4WVJWlqo8Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718140318; c=relaxed/simple;
	bh=cEdz3pPx0zFZuyZzlN3HhDAjH5K92x6qPhdCxkwqjEA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XhJ73iIOZndnbxJm9TkcmmZm6+s60LmNA5slYAn2ecvwF8w40TqV7JFUY9bQPO1vDuOEvJRvJnUOhYqT/xxTqEynIDaQVPu8GzbljGHS3/hybGJV9Dyktp2U2zbfubXCCm0QJRNe5shzcsAMZzMLWFyksCRorSNNZ/UQdPv7bXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxGMHtiZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f700e4cb92so12643915ad.2;
        Tue, 11 Jun 2024 14:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718140316; x=1718745116; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cEdz3pPx0zFZuyZzlN3HhDAjH5K92x6qPhdCxkwqjEA=;
        b=VxGMHtiZyFAi6pvKHEkKyO/fQoXTZ9x3tPAIyxyMwGx3Z1njFG/TRxHLDLrstiSakt
         WCYjAGoU7RSkfY0hbtmQwKrdgnqsjgvF9R7qDYicNWsxKSeeHj4koolPS6TvMkwhSY/U
         WiUuvml0c6RtMU8drna7f1JFvaEYN2OG+U5ODAa8hihSgEzghJqn9ZVUxHRxHxoiYLEo
         FFQZZrXzk9Q5VA0ZsrPWx/WE1MF3M3/xeQ9UVY1iSREyGpa00JrQAaisNi3IAjRpZ4+d
         t+CyYZfvG3HuQG065CQKB1ahMmCzsN60NisuGw34tlzVL8vaUPK2kRfrr5XZtmsUklQt
         CQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718140316; x=1718745116;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cEdz3pPx0zFZuyZzlN3HhDAjH5K92x6qPhdCxkwqjEA=;
        b=G1j0Skff+iIlsCkor+BUcbfjWvwfk11Jc2obPAeL1Lakqia/UvnCXREBuPSybtcLLZ
         Z0wa7/+AxS8EInyekTflN1cUB7/k0Y0NrkSHnS7TMP/wzCYAS/AQAF+mRZoP5hE7JCzZ
         kWPwGg/7nXJ5RfI0gVFDSsu48IUHwpvub16+6QMLzFDnu0/jl5WHHctHjvhUTsOFwrAQ
         ZovOg7FQAciiJGOgWBe6nVZG9AsP3T1chd8zV22HZJySvh3UnsUrFwg1VxTBLl6cSOKb
         ZzAdEKHdAHemnBwblgw7lde2Oc7tAT+TEqRrXelSjyPVFSaXYmhlqj7uFxTmPKp6ZI/j
         Jbww==
X-Forwarded-Encrypted: i=1; AJvYcCW9i1QrPChMcQdawIlfbLwr4THQeOgxfe52bLB+Tpek4cvz6y7LsMvmzOiO8dfU0FhKwBzH4rPWud71LW4DnGVd/f5Gs1+yy/1yi+is3yy0ea9APvmUm8SPTQM3B13d/zYpiwUJ
X-Gm-Message-State: AOJu0Yx7iXyUjuuiBxM6WT7nzK7RAtdAQnxevlkSUahegriHSz8g1CrE
	h8giK2nXYR0ba1m/FRk25wc5P6nUDG+6G30jciMxl5YKUTpbWtoS
X-Google-Smtp-Source: AGHT+IHGhjitXPHSLmwpEKWOxcRkB09CCleEUgBSXUtzY7wNE50A7/T0BXndwkVz2bxLmuVxMr5Xrw==
X-Received: by 2002:a17:902:d507:b0:1f8:393e:8b9a with SMTP id d9443c01a7336-1f83b613520mr932825ad.33.1718140315949;
        Tue, 11 Jun 2024 14:11:55 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f72561cfb4sm26307015ad.268.2024.06.11.14.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 14:11:55 -0700 (PDT)
Message-ID: <1f4c4d90ec6909ae74d595c213f45f9dd49a9867.camel@gmail.com>
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: Use start_server_str in
 mptcp
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
Date: Tue, 11 Jun 2024 14:11:50 -0700
In-Reply-To: <bd2f838063195bb7e199df9d01e7f266dbb1d360.1718070940.git.tanggeliang@kylinos.cn>
References: <cover.1718070939.git.tanggeliang@kylinos.cn>
	 <bd2f838063195bb7e199df9d01e7f266dbb1d360.1718070940.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-11 at 09:59 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>=20
> Since start_server_str() is added now, it can be used in mptcp.c in
> start_mptcp_server() instead of using helpers make_sockaddr() and
> start_server_addr() to simplify the code.
>=20
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

