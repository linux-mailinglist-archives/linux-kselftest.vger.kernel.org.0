Return-Path: <linux-kselftest+bounces-7548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF5789ED5B
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 10:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4B81C20AA9
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 08:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6FCBA37;
	Wed, 10 Apr 2024 08:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ujac6vTK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3DFBA2E;
	Wed, 10 Apr 2024 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712736884; cv=none; b=YepDwRJXwX8euNaD8aVYf+sD7cevpPoZY2cgtfDQRkGPPPEAXcA7g4IHMTr+XGrggSCfgMf+gUlUfmd6mSmR751eInJBXbd6VERD12VzcXG/4nwttBTkyBOzi9fIkDIvjRHRVVoku0PkhjcpFWgLD5FBOq3l7V3K/aNlNalWG4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712736884; c=relaxed/simple;
	bh=O+leYepAFRo8ICmIGEVY0G/02B8AAx2Wdt3lPfF8SJE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hZaDDvbKux3/VI4QnASEhQQHf0HGlqshDJtWlpusOgVWTFGb8v9Zr7joLbSYyiPdklDVr65siEWSJ/uD/mxi2a/rVW0foHRNEacu1vcCtt42O4EmcMzTgLs+lOgLs4nm02/kVbQJ/UiTNo7OKcjHhFG2DI9T2pp+ULO9TEl7Dd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ujac6vTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B16C433C7;
	Wed, 10 Apr 2024 08:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712736883;
	bh=O+leYepAFRo8ICmIGEVY0G/02B8AAx2Wdt3lPfF8SJE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Ujac6vTKUvzJmZtrXgkUem3F4helFt39NZHJG9soE23W++90jVtkGUOTLs0scMtH6
	 hPjd/dd93mUOJ8GfMKkJgRy6suXLm9nzOmRNZfC/hotF4E0BxmJ5wTEmUjTbLRiw3a
	 oVjrPMW+EZoSVzDl5bk6noE7Xmtp8owYC0guD0zy5gl8oj6GR46ACWvWaP4t0utrAs
	 PGxLs33k1+rf7sGIsFq5xDA/YRm4/SWr29m9eq+Z93NfKUIlL2G35BserSDaSvmvWn
	 ACjkHJXNscHKMBVl7KI9sfVYzWKZCFwwzeFlBgLBzE7pJaMaC8NWxO3FFi+kqnxs3K
	 GzrbGnlOK0CZw==
Message-ID: <ff6874d5bd8dc5c89fcd913c3f1ba1820fe7ae4f.camel@kernel.org>
Subject: Re: [PATCH bpf-next 06/14] selftests/bpf: Use log_err in
 network_helpers
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>
Cc: bpf@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org
Date: Wed, 10 Apr 2024 16:14:29 +0800
In-Reply-To: <77e0288d4757b2fcc2c491a2ed535ef223268071.1712733999.git.tanggeliang@kylinos.cn>
References: <cover.1712733999.git.tanggeliang@kylinos.cn>
	 <77e0288d4757b2fcc2c491a2ed535ef223268071.1712733999.git.tanggeliang@kylinos.cn>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-10 at 15:29 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>=20
> The helpers ASSERT_OK/GE/OK_PTR should avoid using in public
> functions.
> This patch uses log_err() to replace them in network_helpers.c.
>=20
> And drop '#include "test_progs.h"' in it, include <pthread.h> and
> <sys/param.h> instead.

Sorry, CI complains about this:

  network_helpers.c: In function =E2=80=98open_netns=E2=80=99:
  network_helpers.c:466:25: error: implicit declaration of function
=E2=80=98open=E2=80=99; did you mean =E2=80=98popen=E2=80=99? [-Werror=3Dim=
plicit-function-declaration]
    466 |  token->orig_netns_fd =3D open("/proc/self/ns/net", O_RDONLY);
        |                         ^~~~
        |                         popen

"test_progs.h" is still needed. I'll update this in v2.

Changes Requested.

-Geliang

>=20
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> =C2=A0tools/testing/selftests/bpf/network_helpers.c | 22 ++++++++++++++--=
-
> --
> =C2=A01 file changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/network_helpers.c
> b/tools/testing/selftests/bpf/network_helpers.c
> index 7ddeb6698ec7..9fd271d5d571 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -7,11 +7,13 @@
> =C2=A0#include <string.h>
> =C2=A0#include <unistd.h>
> =C2=A0#include <sched.h>
> +#include <pthread.h>
> =C2=A0
> =C2=A0#include <arpa/inet.h>
> =C2=A0#include <sys/mount.h>
> =C2=A0#include <sys/stat.h>
> =C2=A0#include <sys/un.h>
> +#include <sys/param.h>
> =C2=A0
> =C2=A0#include <linux/err.h>
> =C2=A0#include <linux/in.h>
> @@ -20,7 +22,6 @@
> =C2=A0
> =C2=A0#include "bpf_util.h"
> =C2=A0#include "network_helpers.h"
> -#include "test_progs.h"
> =C2=A0
> =C2=A0#ifndef IPPROTO_MPTCP
> =C2=A0#define IPPROTO_MPTCP 262
> @@ -447,22 +448,30 @@ struct nstoken *open_netns(const char *name)
> =C2=A0	struct nstoken *token;
> =C2=A0
> =C2=A0	token =3D calloc(1, sizeof(struct nstoken));
> -	if (!ASSERT_OK_PTR(token, "malloc token"))
> +	if (!token) {
> +		log_err("malloc token");
> =C2=A0		return NULL;
> +	}
> =C2=A0
> =C2=A0	token->orig_netns_fd =3D open("/proc/self/ns/net", O_RDONLY);
> -	if (!ASSERT_GE(token->orig_netns_fd, 0, "open
> /proc/self/ns/net"))
> +	if (token->orig_netns_fd <=3D 0) {
> +		log_err("open /proc/self/ns/net");
> =C2=A0		goto fail;
> +	}
> =C2=A0
> =C2=A0	snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns",
> name);
> =C2=A0	nsfd =3D open(nspath, O_RDONLY | O_CLOEXEC);
> -	if (!ASSERT_GE(nsfd, 0, "open netns fd"))
> +	if (nsfd <=3D 0) {
> +		log_err("open netns fd");
> =C2=A0		goto fail;
> +	}
> =C2=A0
> =C2=A0	err =3D setns(nsfd, CLONE_NEWNET);
> =C2=A0	close(nsfd);
> -	if (!ASSERT_OK(err, "setns"))
> +	if (err) {
> +		log_err("setns");
> =C2=A0		goto fail;
> +	}
> =C2=A0
> =C2=A0	return token;
> =C2=A0fail:
> @@ -475,7 +484,8 @@ void close_netns(struct nstoken *token)
> =C2=A0	if (!token)
> =C2=A0		return;
> =C2=A0
> -	ASSERT_OK(setns(token->orig_netns_fd, CLONE_NEWNET),
> "setns");
> +	if (setns(token->orig_netns_fd, CLONE_NEWNET))
> +		log_err("setns");
> =C2=A0	close(token->orig_netns_fd);
> =C2=A0	free(token);
> =C2=A0}


