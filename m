Return-Path: <linux-kselftest+bounces-7517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B68D89E87A
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 05:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A331F23CD3
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 03:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990C0C127;
	Wed, 10 Apr 2024 03:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPmKLlXL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692AFBE66;
	Wed, 10 Apr 2024 03:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712720251; cv=none; b=m5QaX1tpCQHle7ZuehWS3LRGa6EScGX2cesUiJJychybZtflFna16DLIOZVWGGY9bveoB/AvT6s5Bs2BIqsiyUv4XHGvUZZCPQr1jDnu+s1rMURt5ncx1T1Ii+hMZGi6NBruQoIWlI4AqRBG/uz+6g+3Yt8r0S1iM3fc+/QW3W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712720251; c=relaxed/simple;
	bh=L9Zaq0e8GXHoYdf9292xhKRUtx+8gzPbPR21ozqU/T4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AutXaj3ggmbWhwQflzG0FQp8kKBtHscq3iJnCVR8fJ0tZcXp8A6f3y+lNHIFv79StM5+5gR+LC6NdgtSzRVpcHPk8ySXOobE+3G0/dNFre1hInA0w3eKjaXFUrLg4Axm2O+YmuwbAK8cUtezBWls8HpPmVS4Ruwp46TdI12/Ccw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPmKLlXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F167CC433F1;
	Wed, 10 Apr 2024 03:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712720250;
	bh=L9Zaq0e8GXHoYdf9292xhKRUtx+8gzPbPR21ozqU/T4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pPmKLlXLw/ABT/ff98119KKPoyIj6HZfpY5chZVyeUKZj/crhG/K07oWuDmyi0yMJ
	 RLBPx62rRqY/b6gTHizyzRwUWa5EPfXi6ZlVEVKUuOz6Ej3Ib1plgLtdVoswLk6zaH
	 kpQJHux/ReVZS7YvhoY6Ol22A64mmRck5YYK/DvRbfImMk+WavFyu+zrM06dR6iCAj
	 tnqjUHmt2TN+trMxA+IV55Qf6GV5xJGLpPe7VoT5vhSVQWgMLsnGwRsqvRX5xr+bfl
	 wp92ObYk2d5ca6fWYN9Agj6cwUl4KhktacQg4o6T4txZhMw5ANtaYO+GQuQxaKVjB3
	 BokWa3dL/fuWA==
Message-ID: <7f8f8e78938c97dbb523087bd4554c242ca27ddd.camel@kernel.org>
Subject: Re: [PATCH bpf-next v3 3/4] selftests/bpf: Export send_recv_data
 helper
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
Date: Wed, 10 Apr 2024 11:37:20 +0800
In-Reply-To: <344caa7ef362105ba871f52e21e6c62f6edb954e.1712659575.git.tanggeliang@kylinos.cn>
References: <cover.1712659575.git.tanggeliang@kylinos.cn>
	 <344caa7ef362105ba871f52e21e6c62f6edb954e.1712659575.git.tanggeliang@kylinos.cn>
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

On Tue, 2024-04-09 at 18:57 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>=20
> This patch extracts the code to send and receive data into a new
> helper named send_recv_data() in network_helpers.c and export it
> in network_helpers.h.
>=20
> This helper will be used for MPTCP BPF selftests.
>=20
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> =C2=A0tools/testing/selftests/bpf/network_helpers.c | 96
> +++++++++++++++++++
> =C2=A0tools/testing/selftests/bpf/network_helpers.h |=C2=A0 1 +
> =C2=A0.../selftests/bpf/prog_tests/bpf_tcp_ca.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
 81 +---------------
> =C2=A03 files changed, 98 insertions(+), 80 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/network_helpers.c
> b/tools/testing/selftests/bpf/network_helpers.c
> index dbcbe2ac51ba..55d41508fe1f 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -555,3 +555,99 @@ int set_hw_ring_size(char *ifname, struct
> ethtool_ringparam *ring_param)
> =C2=A0	close(sockfd);
> =C2=A0	return 0;
> =C2=A0}
> +
> +struct send_recv_arg {
> +	int		fd;
> +	uint32_t	bytes;
> +	int		stop;
> +};
> +
> +static void *send_recv_server(void *arg)
> +{
> +	struct send_recv_arg *a =3D (struct send_recv_arg *)arg;
> +	ssize_t nr_sent =3D 0, bytes =3D 0;
> +	char batch[1500];
> +	int err =3D 0, fd;
> +
> +	fd =3D accept(a->fd, NULL, NULL);
> +	while (fd =3D=3D -1) {
> +		if (errno =3D=3D EINTR)
> +			continue;
> +		err =3D -errno;
> +		goto done;
> +	}
> +
> +	if (settimeo(fd, 0)) {
> +		err =3D -errno;
> +		goto done;
> +	}
> +
> +	while (bytes < a->bytes && !READ_ONCE(a->stop)) {
> +		nr_sent =3D send(fd, &batch,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MIN(a->bytes - bytes, sizeof(bat=
ch)),
> 0);
> +		if (nr_sent =3D=3D -1 && errno =3D=3D EINTR)
> +			continue;
> +		if (nr_sent =3D=3D -1) {
> +			err =3D -errno;
> +			break;
> +		}
> +		bytes +=3D nr_sent;
> +	}
> +
> +	if (bytes !=3D a->bytes)
> +		log_err("send");
> +
> +done:
> +	if (fd >=3D 0)
> +		close(fd);
> +	if (err) {
> +		WRITE_ONCE(a->stop, 1);
> +		return ERR_PTR(err);
> +	}
> +	return NULL;
> +}
> +
> +int send_recv_data(int lfd, int fd, uint32_t total_bytes)
> +{
> +	ssize_t nr_recv =3D 0, bytes =3D 0;
> +	struct send_recv_arg arg =3D {
> +		.fd	=3D lfd,
> +		.bytes	=3D total_bytes,
> +		.stop	=3D 0,
> +	};
> +	pthread_t srv_thread;
> +	void *thread_ret;
> +	char batch[1500];
> +	int err;
> +
> +	err =3D pthread_create(&srv_thread, NULL, send_recv_server,
> (void *)&arg);
> +	if (!err) {

Sorry, here should be 'if (err)'.

Changes Requested.

-Geliang

> +		log_err("pthread_create");
> +		return err;
> +	}
> +
> +	/* recv total_bytes */
> +	while (bytes < total_bytes && !READ_ONCE(arg.stop)) {
> +		nr_recv =3D recv(fd, &batch,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MIN(total_bytes - bytes,
> sizeof(batch)), 0);
> +		if (nr_recv =3D=3D -1 && errno =3D=3D EINTR)
> +			continue;
> +		if (nr_recv =3D=3D -1)
> +			break;
> +		bytes +=3D nr_recv;
> +	}
> +
> +	if (bytes !=3D total_bytes) {
> +		log_err("recv");
> +		return -1;
> +	}
> +
> +	WRITE_ONCE(arg.stop, 1);
> +	pthread_join(srv_thread, &thread_ret);
> +	if (IS_ERR(thread_ret)) {
> +		log_err("thread_ret");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/network_helpers.h
> b/tools/testing/selftests/bpf/network_helpers.h
> index 6457445cc6e2..70f4e4c92733 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -76,6 +76,7 @@ struct nstoken;
> =C2=A0 */
> =C2=A0struct nstoken *open_netns(const char *name);
> =C2=A0void close_netns(struct nstoken *token);
> +int send_recv_data(int lfd, int fd, uint32_t total_bytes);
> =C2=A0
> =C2=A0static __u16 csum_fold(__u32 csum)
> =C2=A0{
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> index 64f172f02a9a..907bac46c774 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> @@ -33,75 +33,15 @@ static int settcpca(int fd, const char *tcp_ca)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -struct send_recv_arg {
> -	int		fd;
> -	uint32_t	bytes;
> -	int		stop;
> -};
> -
> -static void *server(void *arg)
> -{
> -	struct send_recv_arg *a =3D (struct send_recv_arg *)arg;
> -	ssize_t nr_sent =3D 0, bytes =3D 0;
> -	char batch[1500];
> -	int err =3D 0, fd;
> -
> -	fd =3D accept(a->fd, NULL, NULL);
> -	while (fd =3D=3D -1) {
> -		if (errno =3D=3D EINTR)
> -			continue;
> -		err =3D -errno;
> -		goto done;
> -	}
> -
> -	if (settimeo(fd, 0)) {
> -		err =3D -errno;
> -		goto done;
> -	}
> -
> -	while (bytes < a->bytes && !READ_ONCE(a->stop)) {
> -		nr_sent =3D send(fd, &batch,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MIN(a->bytes - bytes, sizeof(bat=
ch)),
> 0);
> -		if (nr_sent =3D=3D -1 && errno =3D=3D EINTR)
> -			continue;
> -		if (nr_sent =3D=3D -1) {
> -			err =3D -errno;
> -			break;
> -		}
> -		bytes +=3D nr_sent;
> -	}
> -
> -	ASSERT_EQ(bytes, a->bytes, "send");
> -
> -done:
> -	if (fd >=3D 0)
> -		close(fd);
> -	if (err) {
> -		WRITE_ONCE(a->stop, 1);
> -		return ERR_PTR(err);
> -	}
> -	return NULL;
> -}
> -
> =C2=A0static void do_test(const char *tcp_ca, const struct bpf_map
> *sk_stg_map)
> =C2=A0{
> -	ssize_t nr_recv =3D 0, bytes =3D 0;
> -	struct send_recv_arg arg =3D {
> -		.bytes	=3D total_bytes,
> -		.stop	=3D 0,
> -	};
> =C2=A0	int lfd =3D -1, fd =3D -1;
> -	pthread_t srv_thread;
> -	void *thread_ret;
> -	char batch[1500];
> =C2=A0	int err;
> =C2=A0
> =C2=A0	lfd =3D start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
> =C2=A0	if (!ASSERT_NEQ(lfd, -1, "socket"))
> =C2=A0		return;
> =C2=A0
> -	arg.fd =3D lfd;
> -
> =C2=A0	fd =3D socket(AF_INET6, SOCK_STREAM, 0);
> =C2=A0	if (!ASSERT_NEQ(fd, -1, "socket")) {
> =C2=A0		close(lfd);
> @@ -133,26 +73,7 @@ static void do_test(const char *tcp_ca, const
> struct bpf_map *sk_stg_map)
> =C2=A0			goto done;
> =C2=A0	}
> =C2=A0
> -	err =3D pthread_create(&srv_thread, NULL, server, (void
> *)&arg);
> -	if (!ASSERT_OK(err, "pthread_create"))
> -		goto done;
> -
> -	/* recv total_bytes */
> -	while (bytes < total_bytes && !READ_ONCE(arg.stop)) {
> -		nr_recv =3D recv(fd, &batch,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MIN(total_bytes - bytes,
> sizeof(batch)), 0);
> -		if (nr_recv =3D=3D -1 && errno =3D=3D EINTR)
> -			continue;
> -		if (nr_recv =3D=3D -1)
> -			break;
> -		bytes +=3D nr_recv;
> -	}
> -
> -	ASSERT_EQ(bytes, total_bytes, "recv");
> -
> -	WRITE_ONCE(arg.stop, 1);
> -	pthread_join(srv_thread, &thread_ret);
> -	ASSERT_OK(IS_ERR(thread_ret), "thread_ret");
> +	ASSERT_OK(send_recv_data(lfd, fd, total_bytes),
> "send_recv_data");
> =C2=A0
> =C2=A0done:
> =C2=A0	close(lfd);


