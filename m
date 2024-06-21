Return-Path: <linux-kselftest+bounces-12475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B55912EC2
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 22:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A4F1F221CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 20:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C0517B43F;
	Fri, 21 Jun 2024 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sqsq8/MQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E551E1607B3;
	Fri, 21 Jun 2024 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719002713; cv=none; b=UcWM3LmqFSrxWSA0i2V3KtXKjgLhIvz+jY+EtuheCsXkq1aag6mhnVcmOhif5eP0SFMRzHLcbzUNht5PnEtqN8o2ItnjyWlY8P2VQpGYDtDl8+pU6PNYNvX6+5m3ilk8B57x+WAVfATvSHqldlTISeR3uBXKqu+z6soK1+jFwdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719002713; c=relaxed/simple;
	bh=YtR6a99jRsgTUBoqjyn8lJNisJGYH3232cPI1vOUjh8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hnl2RjzyRnFGNbJ57NcjDBJv8mZUttX8GIkOXrzCYIFsFlQSED7TL4UbwvNb9Bgg8LsVOwLcJjnEfplQ5H5rQ1bPdW1XfCbwA7rtg6T8SBg598cyyZA4RtUHQjHzIeu6QG1T5xNzCPDSrAeBdkXIOLZeodXN8VqQMdx+EyK1heE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sqsq8/MQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-706524adf91so832975b3a.2;
        Fri, 21 Jun 2024 13:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719002711; x=1719607511; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ukS/O569i/qPp+dueRpioSwLvyfTvSXT0tfryhSUXWY=;
        b=Sqsq8/MQHsTVrDlQ2Sk9IT+jSQvBRETYMG/UPrihoMBAmERew2uRZEteWUFzEVkbqy
         R/PDI6OhKYXrhZfipkOo5fyHoutT5tfjAgZ3mb3j1cOPDJ27Dn5h9YwG7+BXRquBl9rI
         zT7bo3cr9SigBgJ8p1t7mrYfjN5jQpukMLIqAyAWtxOaYdeW/POCUadxTybHKhQHB+5y
         fO7knWVDBVSmQPQ7qcjndqZVAB87XbkBBK1GfSlc2dpl/wBrfaClRIBQZrXZ+XhlqGOK
         QOpaRkUFy8YB7NnqVW6/o7bBM1bHmYHsQkHpzYmnGu/vEhK1qvMnWw+dEzZxhtATsp4C
         OlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719002711; x=1719607511;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ukS/O569i/qPp+dueRpioSwLvyfTvSXT0tfryhSUXWY=;
        b=BHMO4/JXX3xqnekV0HfZam1KK55vTVybEfYQPie1EFzm/uliRxcEoRyNZchP1IocgW
         Rd/kyvhu8tof+fkn/76S5XBBuKugzymkvvwsgQOILJELPMt85MeQVswsIw/bQZBmpVZS
         8uYYLxWIRuo2IJMTBcET0a73eCXGicTU0IshkgrLWnDfb7Dm8QNGbF2sjpePS4+JloNQ
         nber+pU7MGavibgdEZfvnK0eUyBdmVHKqWo3WGQ/GJgRIubkusa6hjWZ5CT4hMhlWrBu
         R/7K759WfC/K882pqbLyePBFP/W6mDiHMPE8eBq65vh9+1mQeg84V0EPeNMUJYDUJ25P
         b0iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbBzg7ntgG0xxsmMWDjwjxoOp1PwAxgQ63CnHdcaWCJEBN1MS6vT2Wxxzo9Oy7N6IoDwo/3unkAVz/4reST9Dp2IMgX9DBk8b1bKv8+PJTKnhFvPsliH18CqwhlXZ1iXeW79nC
X-Gm-Message-State: AOJu0YzXHW7JlIKGw/yDio72Ds/q4gI1mkeX620GuIhywO/ufzGYDPpO
	5ZODlWitix1YVKTd+wOsVjjZHgfv7P6TjeOkvmlm/eiuU0uhqlRn
X-Google-Smtp-Source: AGHT+IHoBXYxNVBahz9VJuPuGIbwDK4p7U0OmKHJtbi30SIP2ZojZmMsHYzhIYHJawtmvvsK4GC8nA==
X-Received: by 2002:a05:6a00:2a2:b0:704:1ed3:5a19 with SMTP id d2e1a72fcca58-70629cf2083mr9090097b3a.32.1719002711039;
        Fri, 21 Jun 2024 13:45:11 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706512547a2sm1832574b3a.132.2024.06.21.13.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 13:45:10 -0700 (PDT)
Message-ID: <8a1d215239e9e39ec075778e4eb58d884448619f.camel@gmail.com>
Subject: Re: [PATCH bpf-next 6/6] selftests/bpf: Drop make_socket in
 sk_lookup
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
Date: Fri, 21 Jun 2024 13:45:05 -0700
In-Reply-To: <489e1543f8c4ac8feb9e90d1384af66ecb59ba82.1718965270.git.tanggeliang@kylinos.cn>
References: <cover.1718965270.git.tanggeliang@kylinos.cn>
	 <489e1543f8c4ac8feb9e90d1384af66ecb59ba82.1718965270.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-21 at 18:35 +0800, Geliang Tang wrote:

[...]

> @@ -224,24 +188,22 @@ static int make_server(int sotype, const char *ip, =
int port,
> =20
>  static int make_client(int sotype, const char *ip, int port)
>  {
> +	int family =3D is_ipv6(ip) ? AF_INET6 : AF_INET;
>  	struct sockaddr_storage addr =3D {0};
>  	socklen_t len;
>  	int err, fd;
> =20
> -	fd =3D make_socket(sotype, ip, port, &addr, &len);
> -	if (fd < 0)
> +	err =3D make_sockaddr(family, ip, port, &addr, &len);
> +	if (err)
>  		return -1;
> =20
> -	err =3D connect(fd, (void *)&addr, len);
> -	if (CHECK(err, "make_client", "connect")) {
> +	fd =3D connect_to_addr(sotype, &addr, len, NULL);

Nit: same nit about timeout, need to pass options here.

> +	if (CHECK(fd < 0, "connect_to_addr", "connect")) {
>  		log_err("failed to connect client socket");
> -		goto fail;
> +		return -1;
>  	}
> =20
>  	return fd;
> -fail:
> -	close(fd);
> -	return -1;
>  }
> =20
>  static __u64 socket_cookie(int fd)



