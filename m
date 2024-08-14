Return-Path: <linux-kselftest+bounces-15292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA2595118D
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 03:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72E361F245AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 01:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830E4179AD;
	Wed, 14 Aug 2024 01:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cwup81S0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53492AD5A;
	Wed, 14 Aug 2024 01:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723598468; cv=none; b=SFskXIo7oF4HIcmZNvbbny8ULl3jtwQq1GJES/5P6WTdcFvZHTFc0RacGuK2F8tzVQT198eoVTSZpl0eb5EnJBitq8sRFBP7v95DujaduYQg9eYw7SWyOiwe93Yed4XoITFo9uh6DSwidcor+A8+L/k3XLumXp/2wRcxL9dkFbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723598468; c=relaxed/simple;
	bh=DHUyAlr5wEveCy7/40XkLjIui63y4HTHoanCym0AGZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBagmc1xZ8Y08y/BL5jqcCyMruiZpeMt3g/kBIZ48BZrvgmJmALdM1tz6Mb9T9vhCXKTtg1AobZYv+qukEBXDt57xvJJ4NX3vNO1USGuy+uMHfRQp1KGk4Xk2GvhvqsWHnKbxfS0mqfFWuaKPaMME5XKiYkk1bU/4gDByE2oEhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cwup81S0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A4DC32782;
	Wed, 14 Aug 2024 01:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723598467;
	bh=DHUyAlr5wEveCy7/40XkLjIui63y4HTHoanCym0AGZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cwup81S0Gz0YNNOuDxFBWy82hWQ0aijzjbxt7nMbNRRJDjnyu4438vun701gaeC67
	 9lydYszGC3KY1aSguezyHcmzq2Z33EAuECnqy6jXyIzI2IKMDlUznhnJ4PsUzFhWYV
	 54YdGIZDB2ujMyERoskAJ6eTfT/1+d/O3e/1MULMRkgVNOpizXO4Et08tmZOFeQpOT
	 aGm6efpzYIaSRg8Jbb0sn/cnlXfnsSQXgfSYYj7pLLFHPYvNcDUXxaE5Rm+pgAuIhc
	 E7Nv+s4tiDZfPrqdkbXEeepJu1McJgSp6uA2w8oRmw58mZHju0HHqFtf5j3mYbzMVU
	 rI7d5wmdPySrg==
Date: Tue, 13 Aug 2024 18:21:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH net v2] selftest: af_unix: Fix kselftest compilation
 warnings
Message-ID: <20240813182106.1f44d161@kernel.org>
In-Reply-To: <20240812191122.1092806-1-jain.abhinav177@gmail.com>
References: <20240812191122.1092806-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Aug 2024 00:41:22 +0530 Abhinav Jain wrote:
> Change the parameter expected_buf from (const void *) to (const char *)
> in the function __recvpair() as per the feedback in v1.
> Add Fixes tag as per feedback in v1.
>=20
> This change fixes the below warnings during test compilation:
>=20
> ```
> In file included from msg_oob.c:14:
> msg_oob.c: In function =E2=80=98__recvpair=E2=80=99:
>=20
> ../../kselftest_harness.h:106:40: warning: format =E2=80=98%s=E2=80=99 ex=
pects argument
> of type =E2=80=98char *=E2=80=99,but argument 6 has type =E2=80=98const v=
oid *=E2=80=99 [-Wformat=3D]
>=20
> ../../kselftest_harness.h:101:17: note: in expansion of macro =E2=80=98__=
TH_LOG=E2=80=99
> msg_oob.c:235:17: note: in expansion of macro =E2=80=98TH_LOG=E2=80=99
>=20
> ../../kselftest_harness.h:106:40: warning: format =E2=80=98%s=E2=80=99 ex=
pects argument
> of type =E2=80=98char *=E2=80=99,but argument 6 has type =E2=80=98const v=
oid *=E2=80=99 [-Wformat=3D]
>=20
> ../../kselftest_harness.h:101:17: note: in expansion of macro =E2=80=98__=
TH_LOG=E2=80=99
> msg_oob.c:259:25: note: in expansion of macro =E2=80=98TH_LOG=E2=80=99
> ```
>=20
> v1:
> lore.kernel.org/netdev/20240810134037.669765-1-jain.abhinav177@gmail.com
>=20
> Fixes: d098d77232c3 ("selftest: af_unix: Add msg_oob.c.")
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>

Some patchwork malfunction, the patch didn't get registered :(
Could you resend?

Please keep Kuniyuki's review tag and address his feedback.

