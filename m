Return-Path: <linux-kselftest+bounces-7819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34E88A33F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 18:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D536285190
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 16:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDA9149E06;
	Fri, 12 Apr 2024 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hexYpX6y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E36D84A35;
	Fri, 12 Apr 2024 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712939924; cv=none; b=gW3cYvUBFg9HkrkTC77WdwuFItRMM3uR4JceCpbD5X/GRuxSmWzMVBrVISGii6UAjlspCV1d/XgVUyec/Dck1JC184iihjKcvLnKw511AAEBrbT34qruAN6zu/v6qlDMUKkzbtrpV3U5HNJcyJvC5W5DIFjtIqzOy+sRSD8Oz7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712939924; c=relaxed/simple;
	bh=msuI6S9nRaowLt1utkGFS1wHr/5dXNzjdT0E1gFYYmo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QdytwTGnpL4qQDozGm4WoG8QgrzU83aFI/SBLK1DJmVp1QZUzfN4Sa/WOrw5XmC6TvYt3+OYuplwl/5t3qDd6JfFCTddGlNk/Tr4drHg/ml1pwFsEpcdG4NvFbW2KCb9tp70ZBQb3nKCghhvj53vXhUUWuPqq12rBjkst090Ntc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hexYpX6y; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516c403cc46so2402210e87.3;
        Fri, 12 Apr 2024 09:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712939920; x=1713544720; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l3+lq2mBMXz1UT61yeekIa96Ey8lYxtqAq7+woRsPSk=;
        b=hexYpX6yKwUmEU9zk2QsjuK+jJM9AosqEY+lTRWQemAhrrgF2fhaEGmT2tq+mr+vOk
         6rkjWty2awlyrPHiftVo6cpCvEPO88CjNsVF6Sb9/eiU5mpsV4OUAdL+9dqANMrEdBkg
         +aTVjNn1uSmUoCM3crQ857IvOqzoHLN6VwbofWUAbZ/a7yRs59ZWFIwoHy8oItFQ85hv
         vvGrbuIw+fWLOaT9uQjQXqguYjnEZq03BK/B201ajsDb9hXrDEPpkhxPZ/HAd9pSYMqB
         WP2W0u3LNFUACBe+yehqcu3wN2s2rAn8lNm4oTuQiXUkZOvtLE7Lu16b+w7++cTR+euK
         HH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712939920; x=1713544720;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l3+lq2mBMXz1UT61yeekIa96Ey8lYxtqAq7+woRsPSk=;
        b=WWAeyshzXPzfZRLYKL+B6dzWN4nMyjJ049Ec3wttXVCBfVF91tETm8mIRoKp+31T50
         ifKhI5+BfVRiRZ8Gk5OjagXq/VDB+TQE/zJbdZptUgrpW09h8c4c3pwAEu0CE+iTLeUu
         ZeHK/6CJ55JkYlJ3vNwZDF8yMMk6w3NXqQTyDAhgxwzmsMhiOuO4CynHhepGHGzXhu0u
         LapBIp7CxUUR905lM8DlbStJeEF3fpOLpdQZNKHDuEJH59kpdKL84DT7nv9ZvdK5mabx
         9FI4WcJIOCXPQlHXAUjj74BMQepBojm5lZfnNdWSxNF2/9qi9Zg1CB/qSkfK6SC6geYB
         RnuA==
X-Forwarded-Encrypted: i=1; AJvYcCVqAXkWRKgQaMHqtSFlcVTS3GXwDGkV6vm5402ENk1yIRVyLMNAH3h/vGJ79DZl/Nc4hISVGiWctk0MnORSqiQforWQw9g5jOw2Bsn7mOcta0FDTuWIjt8ZYAK7p8Eiw7rIZZRG
X-Gm-Message-State: AOJu0Yz0w/TUiTukv/p2rdma+QMiLMYnZKERyMgvxMK7Lf62zDsWHmby
	ltzbjM3aH02ZTe42ACmAYvY7C7Oh9+vAwMsoAP0dt/QpbobvUfAp
X-Google-Smtp-Source: AGHT+IEb8H0sUeDApUji/WBXLkXBPw4zs+6RGun9Eb+4w2and1/bKOYUID5QZ0YO0phHNkYb5HCI4Q==
X-Received: by 2002:a05:6512:15a9:b0:515:d1c2:c216 with SMTP id bp41-20020a05651215a900b00515d1c2c216mr3500008lfb.46.1712939920343;
        Fri, 12 Apr 2024 09:38:40 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id jw24-20020a170906e95800b00a51adace6ebsm2006423ejb.79.2024.04.12.09.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 09:38:39 -0700 (PDT)
Message-ID: <d0ff63ae74c44efab13c718e270a22c9dbb70d8c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 05/14] selftests/bpf: Use connect_to_addr in
 sk_assign
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
Date: Fri, 12 Apr 2024 19:38:38 +0300
In-Reply-To: <55a16644cf8b53e2bbf305fbd9ae21c6f8ad3cbf.1712796967.git.tanggeliang@kylinos.cn>
References: <cover.1712796967.git.tanggeliang@kylinos.cn>
	 <55a16644cf8b53e2bbf305fbd9ae21c6f8ad3cbf.1712796967.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-11 at 09:03 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>=20
> This patch uses public helper connect_to_addr() exported in
> network_helpers.h instead of the local defined function connect_to_server=
()
> in prog_tests/sk_assign.c. This can avoid duplicate code.
>=20
> The code that sets SO_SNDTIMEO timeout as timeo_sec (3s) can be dropped,
> since connect_to_addr() sets default timeout as 3s.

Hi Geliang,

Thank you for this cleanup patch-set!
I think there is a mistake regarding connect_to_addr(),
as it does not set any timeouts (while start_server_addr() does):

-------------------------------------------------------- >8 ---

int connect_to_addr(...)
{
	...
	fd =3D socket(addr->ss_family, type, 0);
	if (fd < 0) { ... }
	if (connect_fd_to_addr(fd, addr, addrlen, false))
		goto error_close;
	return fd;

error_close:
	...
}

static int connect_fd_to_addr(int fd,
			      const struct sockaddr_storage *addr,
			      socklen_t addrlen, const bool must_fail)
{
	...
	ret =3D connect(fd, (const struct sockaddr *)addr, addrlen);
	if (must_fail) { ... error handling ... }
    else { ... error handling ... }
	return 0;
}

--- 8< --------------------------------------------------------

Maybe add a flavor like connect_to_addr_opt() with an additional
flag or options parameter?

Thanks,
Eduard

[...]

