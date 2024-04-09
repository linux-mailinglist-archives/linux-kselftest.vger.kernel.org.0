Return-Path: <linux-kselftest+bounces-7464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1978989D150
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 05:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8EF1F25ABF
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 03:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCCE54FAB;
	Tue,  9 Apr 2024 03:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXhCSIkS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8F4657A3;
	Tue,  9 Apr 2024 03:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712634708; cv=none; b=InO+YdB1N3Hannu9/4qJjOji8yOMKOZzz2Kp3Ssybf9DfblRLO+n3g6OlHt4y1uCFdhCcMvbvgtOA6aO5R9DBMOC/XvTsr10h4nV4oGUgXyB+lxKjZX7nhctyuMJ4nFRMdn/4M1H6wEFYejN1SyeTnatvRSru+Sf2RcoA7v4x70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712634708; c=relaxed/simple;
	bh=bBEcjZlJVaO+obZGhoDrKZKLCtaVl1Eaa763J0K4qQk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CXavrvLiYXcgnha17rLPHFBFZbTMlzQ9DJyYKGajinnJzK3QJWsqtgSBef0ITu8HfduvBaUaLrspyzpCFUdqrfAoYGoVL+WrUR1ZH/Hpr4dTV7Zuj7+iRVGcHQEiAB94I924+7RYYvP9NnxGehBcb9+27YJuV+BT6Ymw9a4z0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXhCSIkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92560C433F1;
	Tue,  9 Apr 2024 03:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712634707;
	bh=bBEcjZlJVaO+obZGhoDrKZKLCtaVl1Eaa763J0K4qQk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QXhCSIkS/YNn62dHdCbjW3wPds78xTP0F5hgYPUb0CF6lFDJ0WnT/OH+Oe5pyvKmB
	 KBWmkXMehiAuBH0gscf8KlfLky2h0VvEI0+p38eFdyZq5FrFqpjHRLoqQ+BAbBVLXP
	 bypS36+bBN6figbK2ZDoeTX2YiWuV1un0795QXp1PuJFzXyeWe2Fg/90FtU9HaCs5O
	 +KnmzxIGQgSMZfa/zh8rvVeW4jywgdQYDjQ1JrwpCfEc4QZ/pNp4RtS0H/zaVvXQYZ
	 Fuhk3KYPuKlOCRA/a70D8ie3VrR/NvT+e9bMPdIZR4ZbbcaFmqm32NhdHwlNGcIE2z
	 ZCKenoURhQ7nA==
Message-ID: <77aac1cb0234ec0b0f7a15bf0a2212789e6b63c2.camel@kernel.org>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Export send_recv_data
 helper
From: Geliang Tang <geliang@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org,  Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Date: Tue, 09 Apr 2024 11:51:38 +0800
In-Reply-To: <a8153ab2b82c8cd57aca2c6d44d5d327e8c7be92.1712547287.git.tanggeliang@kylinos.cn>
References: <cover.1712547287.git.tanggeliang@kylinos.cn>
	 <a8153ab2b82c8cd57aca2c6d44d5d327e8c7be92.1712547287.git.tanggeliang@kylinos.cn>
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

Hi Martin,

On Mon, 2024-04-08 at 11:45 +0800, Geliang Tang wrote:
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
> =C2=A0tools/testing/selftests/bpf/network_helpers.c | 85
> +++++++++++++++++++
> =C2=A0tools/testing/selftests/bpf/network_helpers.h |=C2=A0 1 +
> =C2=A0.../selftests/bpf/prog_tests/bpf_tcp_ca.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
 81 +----------------
> -
> =C2=A03 files changed, 87 insertions(+), 80 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/network_helpers.c
> b/tools/testing/selftests/bpf/network_helpers.c
> index 04175e16195a..e17d19f88a36 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -545,3 +545,88 @@ int set_hw_ring_size(char *ifname, struct
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
> +	ASSERT_EQ(bytes, a->bytes, "send");
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
> +void send_recv_data(int lfd, int fd, uint32_t total_bytes)
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
> +	if (!ASSERT_OK(err, "pthread_create"))
> +		return;
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
> +	ASSERT_EQ(bytes, total_bytes, "recv");

I think we should avoid using ASSERT_* in network_helpers.c, but I'm
not sure. What do you think?

Thanks,
-Geliang

> +
> +	WRITE_ONCE(arg.stop, 1);
> +	pthread_join(srv_thread, &thread_ret);
> +	ASSERT_OK(IS_ERR(thread_ret), "thread_ret");
> +}
> diff --git a/tools/testing/selftests/bpf/network_helpers.h
> b/tools/testing/selftests/bpf/network_helpers.h
> index 6457445cc6e2..5172f0b7bf6e 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -76,6 +76,7 @@ struct nstoken;
> =C2=A0 */
> =C2=A0struct nstoken *open_netns(const char *name);
> =C2=A0void close_netns(struct nstoken *token);
> +void send_recv_data(int lfd, int fd, uint32_t total_bytes);
> =C2=A0
> =C2=A0static __u16 csum_fold(__u32 csum)
> =C2=A0{
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> index 64f172f02a9a..3f822100c2b3 100644
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
> +	send_recv_data(lfd, fd, total_bytes);
> =C2=A0
> =C2=A0done:
> =C2=A0	close(lfd);


