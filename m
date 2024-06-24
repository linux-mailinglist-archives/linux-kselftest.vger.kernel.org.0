Return-Path: <linux-kselftest+bounces-12573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAF29158C9
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 23:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45C8BB24298
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 21:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EB71A08C4;
	Mon, 24 Jun 2024 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1AcWet8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478C01A0705;
	Mon, 24 Jun 2024 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719264115; cv=none; b=SIJGuObsQVBoh9SELw9yVO6hQJtRkHtVw8Iq/hXGuYhLsE7NAk0toNnvtXSf04+mNTFJj3OYF2kYA2yqEtQHEZkmMuj6d9WxHIOrlpJrRLHiXwGSryL5G7eN1MS356X/iaNW96wOHDTqGtv3hUrK5V/uATf7zN70/8SsrRuPQNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719264115; c=relaxed/simple;
	bh=K2nPn5+KXr5fsJLrzV+n/VjSsb6iFSG6s/idgmFCEOQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ahR8xBXWgKk79cDaUXEbDt5bywgEnmYpmc60jWmXG0sUmT48fqkSxBYEq1j7PIaOGA7FKdzNeaEce/qDTjI5M44i/6jfyoRoc/ia69BMyk2arep0zPHTdky7lSrS0OOIymMAnRjN5cciKIihYi1SyitFS3kPamJr0DpNMXh2uKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1AcWet8; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fa2ea1c443so14330455ad.0;
        Mon, 24 Jun 2024 14:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719264113; x=1719868913; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K2nPn5+KXr5fsJLrzV+n/VjSsb6iFSG6s/idgmFCEOQ=;
        b=e1AcWet8ny+7G4zynIWEfEwejSvliiLO9mK+KzRJZI6JP4FRmnIFY4wRrsEMYgZmMZ
         7eDXHzfLqyEfh7oL6W1NoJ3pX6DM2X7CEruNIGvt4cmm6FWqk2bFUCf/3eKx7kTlYB58
         r+0f1f2CDBuXkyFbs+C9RcHigHWBjpmDEK7cBzvkbm8L0t5Z8p0XHGGP91nxZQNcpD+l
         ykH/qLs5FQ6UoLxw4muz3SXGxbZlcyJxGEqJxxqhqgvweAh8LKQJR2o60SOR4AAI10/+
         7hLnQbFl9Nel8GdUuZPu1Dih1QBvRJJNkY2SxpFtRwImRIK9vKK5575gjxNpKyp2JAet
         Pl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719264113; x=1719868913;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K2nPn5+KXr5fsJLrzV+n/VjSsb6iFSG6s/idgmFCEOQ=;
        b=PU/caULvZbcwOUogynmLdVFdVVZghq/+Jxezjyy3PiTqaArJCEv+aHpk4pKm0Z9lEL
         9N0PAF1HpfFwklA9LWTFQLoL4AG0PaHgn+nI3B0zPXjPhfMAKbcb740dAt01ODS+r1eR
         AZTnnJLqpbIoMzkOBZqY2lFm6434q8vl4sLJ68CrOloGZpgO85achFM4a1GycnttJe4U
         6KHcJSaEMvm9W0wxekRlJCNlSZSYJ9KbN8jBUipizVYGxN+4S51SEOmgN1HrKVJ9B+Cn
         dWXgmS8EzPsX7CACSjtuIW1/PUlQcngLdOLALr95TXuSeluswl+9brLseayzSvwEXsMt
         G9gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkB6tRL4ZYuEAgfCF+t6LeOA9y/2sTmD5Wd9cm5FLuaVUgBescE0BzgI2Dka6496kUKQGzUAsoYLcu/zH+mzgntyuOmfb3VKqauyTfD9qwN0zEyAWcVc4+mI5T1NThQ0k1MZ7+
X-Gm-Message-State: AOJu0Ywa8dlOUqq8EVGON9SLWKehnEchPMPqDcLD8fW0Eyq688BjJKkx
	ASfTTkz7qFnEadswXnEsY2xfGEiYMNFSVp3tJXPiozthSb7VBNdN
X-Google-Smtp-Source: AGHT+IEb9zvrdrM3OIpz6L19RKtvKlJlwDJeeVDO3+id/OqYV4mHGPqzxTgvEwVxot5NXRYNrw0KXQ==
X-Received: by 2002:a17:902:db07:b0:1fa:e0c:8bd4 with SMTP id d9443c01a7336-1fa23f07142mr60141675ad.68.1719264113273;
        Mon, 24 Jun 2024 14:21:53 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f0353sm67212815ad.23.2024.06.24.14.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 14:21:52 -0700 (PDT)
Message-ID: <dc971af1ec9204a4be2924c20c26006890c61d84.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 4/9] selftests/bpf: Use make_sockaddr in
 sockmap_ktls
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
Date: Mon, 24 Jun 2024 14:21:47 -0700
In-Reply-To: <7f6985c0ad1c031662ff677b6b4be5f51f920c4a.1719203293.git.tanggeliang@kylinos.cn>
References: <cover.1719203293.git.tanggeliang@kylinos.cn>
	 <7f6985c0ad1c031662ff677b6b4be5f51f920c4a.1719203293.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-24 at 12:33 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>=20
> This patch uses public helper make_sockaddr() exported in network_helpers=
.h
> instead of open-coding in sockmap_ktls.c. This can avoid duplicate code.
>=20
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

