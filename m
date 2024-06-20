Return-Path: <linux-kselftest+bounces-12375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2169115E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 00:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255F728550A
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 22:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146A6140378;
	Thu, 20 Jun 2024 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLONapIM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C0E6F2F1;
	Thu, 20 Jun 2024 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718923877; cv=none; b=UWkxZimubgxHbkzKoG1VRnvF1e8SH/vd+fGFF7oGwo1hLERr6KMHWOY7TVSI0vlIM8XRcJBqlhhfV8Nfmuy9zWNKs23qjsApT8UIzsSSssKPQqh8CW9YAEG2EyS0HxEP/5JYeiMfY5s0a1F/5bwj7NUnIOAul5UG0QLklXaB/Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718923877; c=relaxed/simple;
	bh=QgQAxzHkv87x1mpTyfw1sKMVCNuCrZT5JKvpo9c0vFg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jh5viqzuOO0k+ke2hcbIXyLJzXFqJi9ghUSTAOdcRKDtiQSGWMia5VOHcgcZex9gtVXiCHjg5RGC2hosMLv8YE0fvqAnFsPIVSZNYDJpQNGq8pvf++ly6UiONRZow7uTxd3TdMMWah31orYS7hzlvsdeLYnSgVj/sVrh4FTUgEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLONapIM; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-705fff50de2so1007483b3a.1;
        Thu, 20 Jun 2024 15:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718923875; x=1719528675; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gAYtcibVc3S444giuoO5CXI1eTRiknh22eCufx7b1XI=;
        b=TLONapIMiqZiHAcoQYZn2MYfG2nR2/H/liLrHeYkpgOgqWkoV6/NmVYXk4QkXVU3tk
         KYR0E3b6AFqMKs0hN32IffsgOk/KKP2OlUqHgJkfxe3myl7ECGdowQQhJC20goGIMkOs
         tP5HIvqW82v2Roz/Pd6qVjn5Po9xR2vmbFYJu6eY0fbOcsznht2ilDVoZlbBDon05Laj
         /qiJZj23prhfkLthg3kMljl5rzhH8RaDYsJrW/E2336UxwSxlGndj+Ri1jJd4xn5oBJQ
         EO+hF3Gj5naKJsPFvzhihScCsP7Cam2bhY3+AFY/gAgTxWNWkp25pJDIMDQLZdVIEffD
         ygWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718923875; x=1719528675;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gAYtcibVc3S444giuoO5CXI1eTRiknh22eCufx7b1XI=;
        b=qKWxMDM85CX39nzw7E8cQ4fRxvp8Nk9qJuPl3RglUT3aY/BjB+mcVzqlWXx66xb2SI
         lpiWY6EgK63xNhNPqYMU/Kf4QsUrHVpmJk9K7wpBTFmNcK2f0Fwl2s3YYnmMv11YNKsR
         JuESjp6W7T1lSSLee/hWAVC/9n1zJp550xm6tpUCmOsohbFWmGd5HsEx/ihQPRoitr/9
         NL4UeKYHfpD61p5ns56PbevwMD0aJghMLkXXP5+2ukmSfVFzutLzFJXDY6fL2Zl+8w5H
         zJUFB1B33LXbIbGmxzoDIRCKPtebtRoI7McGDo57yWewYykoSfPkeEuJ6MPD8Z9DPXLo
         OBMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyduff+VWED47qAOpPx4Sd1wcOh52pYKf93OK54jpvQJt7MVTPmnQz3GPSRkpeYL13dE2pljaU6CL2OSJFyIA2R+YOQZvfkctw9ic0rHzL1/Yrvhe6oupEAQpTuc4rF7NCERbd
X-Gm-Message-State: AOJu0Yz/E14uMXqCThTsb90uHp12hmX+BlvFjT2RMmFNaEsYP3aMjKH1
	s7gx5mlep5gqKSLIS4WX6f2236ScTdCfXc8zwW6U5+MKrKCn2Jsj
X-Google-Smtp-Source: AGHT+IE0lB74PfjFovEEX+6xs19WhHHouN8o8uHffuo58LfaxAkoO4gENajrhZQ6flrLlcXczRp27w==
X-Received: by 2002:a05:6a00:2e87:b0:705:d6ad:2495 with SMTP id d2e1a72fcca58-7061ac0ea0dmr15945154b3a.12.1718923874920;
        Thu, 20 Jun 2024 15:51:14 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716ba5b5f93sm67291a12.57.2024.06.20.15.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:51:14 -0700 (PDT)
Message-ID: <472e112c540a671f1661b28eb80832114c6da24e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 4/6] selftests/bpf: Drop noconnect from
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
Date: Thu, 20 Jun 2024 15:51:03 -0700
In-Reply-To: <03185ae444b4fc91a3729df1f6f274ae5273aa67.1718765123.git.tanggeliang@kylinos.cn>
References: <cover.1718765123.git.tanggeliang@kylinos.cn>
	 <03185ae444b4fc91a3729df1f6f274ae5273aa67.1718765123.git.tanggeliang@kylinos.cn>
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

Oops, sorry, missed two places that should be changed.
Please keep my ack if you respin.

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c b/t=
ools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
> index 1607a05bf2c2..e73da3de5bf6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c

[...]

> @@ -200,7 +199,7 @@ void test_bpf_ip_check_defrag_ok(bool ipv6)
>  	nstoken =3D open_netns(NS0);
>  	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
>  		goto out;
> -	client_tx_fd =3D connect_to_fd_opts(srv_fd, SOCK_RAW, &tx_ops);
> +	client_tx_fd =3D client_socket(family, SOCK_RAW, &tx_ops);
>  	close_netns(nstoken);
>  	if (!ASSERT_GE(client_tx_fd, 0, "connect_to_fd_opts"))

The ASSERT string should be changed.

>  		goto out;
> @@ -209,7 +208,7 @@ void test_bpf_ip_check_defrag_ok(bool ipv6)
>  	nstoken =3D open_netns(NS0);
>  	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
>  		goto out;
> -	client_rx_fd =3D connect_to_fd_opts(srv_fd, SOCK_DGRAM, &rx_opts);
> +	client_rx_fd =3D client_socket(family, SOCK_DGRAM, &rx_opts);
>  	close_netns(nstoken);
>  	if (!ASSERT_GE(client_rx_fd, 0, "connect_to_fd_opts"))

The ASSERT string should be changed.

>  		goto out;


