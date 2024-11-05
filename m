Return-Path: <linux-kselftest+bounces-21430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4269BC2D3
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 02:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17662B21023
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 01:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96D33A8CB;
	Tue,  5 Nov 2024 01:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4zLScGy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC19627713;
	Tue,  5 Nov 2024 01:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730771660; cv=none; b=Y20mUNmqCeuZPODh4Fk6E691xz587NTG1PvPFLnHw9WRjRB0TpEpkl9fh8NHdSMsVZSTpKcE418tFFUuGbQ4dkeUZak/tqBim4yARt0ZSk6Cw30vODZ0pNQRlGz8M7ZtipYNpZ4nM/6qBbY/R+sDTygQqtX/+u1TN/5CApY4EZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730771660; c=relaxed/simple;
	bh=UAZ11ux6gd0FAH3T+YGg5qMCNONRgpHeVBzPAkpUqZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RaAhUbfu9bC7/9akzGBEINBLdl1oKAoSKVodmgmqkMj73BStVi97BFhqvoHRbmVmJ3gHZWjX97Wd5+DrjKhv/rUQUCXelWKj/Dfgxik2W91cv2SRTmeINWQOO5bH0a18yp8c0r0QZwRq45vRarXttJO3EYlrDae7SYFKhUmExs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4zLScGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF95C4CECE;
	Tue,  5 Nov 2024 01:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730771660;
	bh=UAZ11ux6gd0FAH3T+YGg5qMCNONRgpHeVBzPAkpUqZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E4zLScGyp8QiXwAO8HzgNG1Ni/y/Q4Ig+F12FCA2PU5rY319u+2CpH7LTWAPtPz2o
	 rtxsNlE2UFHlupEcFBEGyOz0lr67SV/93ZUr4FESSgNrFU7YySVfHC9M0SVIw4HHTy
	 VPOsbFbcoArEBnhZATpSxH4N6hFNoJ0wPMpWpDKiOPEXA9Akwz8gYPf83PM0YD/T+b
	 l7njfcMyefzBYxyK2YU0bRkRyTQzlhI1l3K+54Gw7vCo8KXclLWk3yIsjJw/d/T8RF
	 cEZmA+WCYLCIkHsMriST7G0FfNOMpPJt6rOjNkvbixSMCLxSdH8Z9Qz56n3T/myQp6
	 982DXn7fKEvPw==
Date: Mon, 4 Nov 2024 17:54:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
 horms@kernel.org, almasrymina@google.com, willemb@google.com,
 petrm@nvidia.com
Subject: Re: [PATCH net-next v7 06/12] selftests: ncdevmem: Switch to
 AF_INET6
Message-ID: <20241104175418.0d996608@kernel.org>
In-Reply-To: <20241104181430.228682-7-sdf@fomichev.me>
References: <20241104181430.228682-1-sdf@fomichev.me>
	<20241104181430.228682-7-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon,  4 Nov 2024 10:14:24 -0800 Stanislav Fomichev wrote:
> -static int configure_flow_steering(void)
> +static int configure_flow_steering(struct sockaddr_in6 *server_sin)
>  {
> -	return run_command("sudo ethtool -N %s flow-type tcp4 %s %s dst-ip %s %=
s %s dst-port %s queue %d >&2",
> +	const char *type =3D "tcp6";
> +	const char *server_addr;
> +	char buf[256];
> +
> +	inet_ntop(AF_INET6, &server_sin->sin6_addr, buf, sizeof(buf));
> +	server_addr =3D buf;
> +
> +	if (IN6_IS_ADDR_V4MAPPED(&server_sin->sin6_addr)) {
> +		type =3D "tcp4";
> +		server_addr =3D strrchr(server_addr, ':') + 1;
> +	}
> +
> +	return run_command("sudo ethtool -N %s flow-type %s %s %s dst-ip %s %s =
%s dst-port %s queue %d >&2",
>  			   ifname,
> +			   type,
>  			   client_ip ? "src-ip" : "",
>  			   client_ip ?: "",
> -			   server_ip,
> +			   server_addr,
>  			   client_ip ? "src-port" : "",
>  			   client_ip ? port : "",
>  			   port, start_queue);

nit: I think this generate a truncation warning, not sure if it's easy
to fix:

ncdevmem.c:259:28: warning: =E2=80=98%s=E2=80=99 directive output may be tr=
uncated writing up to 255 bytes into a region of size between 209 and 215 [=
-Wformat-truncation=3D]
  259 |         return run_command("sudo ethtool -N %s flow-type %s %s %s d=
st-ip %s %s %s dst-port %s queue %d >&2",
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

maybe make buf smaller? =F0=9F=A4=94=EF=B8=8F

