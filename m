Return-Path: <linux-kselftest+bounces-21058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 697409B5821
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 01:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 130F2B2127F
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 00:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA081FB4;
	Wed, 30 Oct 2024 00:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n85xl9cf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1643F634;
	Wed, 30 Oct 2024 00:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730246491; cv=none; b=qpt/gOj1QvDiD1XueBu/MjUy7qIPJLJyfwjEa5zpkbMiZh7gEOZuw8SFxti2hxVs6uZn70B4pZRisSjsEatnKiqXH/iLiXeO80zy/mZ6+SsI1rCb1mXxpPJKlZX4XFatZ9rlVMt3RXlwaqAa9iH7FzmfUq+VtbY0AF4xbH5OnwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730246491; c=relaxed/simple;
	bh=pR/4O/1pECAg3LGqjUvKrdm+to6brxG6OvUk2kUoGRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIyQS/uI1rbZgjac1OdrGa4fL9e0dnVPZsMpyqwVN+M7otQPZvfD8mtRHDHDZUQGnSmGDWENlNV04lwpZ90hP5VuSchChyJLXpUhLklYjhazvJr2rSX4oTDznHUQRkQWD/2A2dK7Y1OOMkBa5DzcZv6j0p9pNCW6Ur6OlI2ot+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n85xl9cf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368C9C4CEE3;
	Wed, 30 Oct 2024 00:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730246490;
	bh=pR/4O/1pECAg3LGqjUvKrdm+to6brxG6OvUk2kUoGRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n85xl9cfn594k2jUdlnLqJ8nLRKgjn508jk4C0zorfv0982CMKZssdRhIiLz8xI9a
	 t6xqrKeEwx+a6sl7r/l9dK3RoYLB+rF11Sr6LkDEnwDoQsau5eF5tFR0TMkBC3cyvm
	 X1BL6J0GFnvbIXnSWDLNRON7qkDB718opLt75HZaVQPVAi898PEQNSbLZK1KWlP1bp
	 PslQh87VFfX8DghwZ/tnX7rT/8w7AigKgrYI7VN7uvSvHxP1bro9nTnq+rm+VDeZjQ
	 WRfHc2mteuoLnPT+UKB/+coyx4+JPmmLv5Tqhd0/N3dPPiM0DR01P0finB6zDFf6lO
	 35ZOqorHYqR8A==
Date: Tue, 29 Oct 2024 17:01:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
 almasrymina@google.com, willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v5 03/12] selftests: ncdevmem: Unify error
 handling
Message-ID: <20241029170129.75e29323@kernel.org>
In-Reply-To: <20241023154402.441510-4-sdf@fomichev.me>
References: <20241023154402.441510-1-sdf@fomichev.me>
	<20241023154402.441510-4-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Oct 2024 08:43:53 -0700 Stanislav Fomichev wrote:
>  	ret =3D inet_pton(server_sin.sin_family, server_ip, &server_sin.sin_add=
r);
> -	if (socket < 0)
> -		error(79, 0, "%s: [FAIL, create socket]\n", TEST_PREFIX);
> +	if (ret < 0)
> +		error(1, pton, "%s: [FAIL, create socket]\n", TEST_PREFIX);

Looks like sched_ext broke our build_tools check, I think I pushed a
fix, but I also see here:

ncdevmem.c: In function =E2=80=98do_server=E2=80=99:
ncdevmem.c:343:26: error: =E2=80=98pton=E2=80=99 undeclared (first use in t=
his function)
  343 |                 error(1, pton, "%s: [FAIL, create socket]\n", TEST_=
PREFIX);
      |                          ^~~~
--=20
pw-bot: cr

