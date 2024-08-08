Return-Path: <linux-kselftest+bounces-15021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF51D94B999
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 11:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34584B221C8
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 09:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC636146D76;
	Thu,  8 Aug 2024 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWU8/L6r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F571465BE;
	Thu,  8 Aug 2024 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723109069; cv=none; b=Ru7Zl0jflk9VnAGVeqtHXcMbKRAWr22PPZGxI7O2F2vwn3ex4x5NpP3rj9ClBLrT70LYGVwq2zjTEGqCNyR7e1KH/CZGfCjfFdaCmdfZHvxfKJcGBbRMmLBtFotdNM2wYXSXsdk8oqnMLPD0w5xxRqOeqTOt5LDikMQik7ykPFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723109069; c=relaxed/simple;
	bh=uX5ep/PSOVtOKHu44Nss6ozVLTd5AuP0lWO5Jg0wheA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qunA790C6XxSsZfDtb0SZG69IU7Xps1ErhX8JTh9hg6PFbjxW7OOUxuEUejHAtvaLsQ4Qn5P79I7Ef3zZhvPsRnYATHrTDUkChrjLssN7WlXvG1L7uSGoajPRBf7LTnes+UVT6L5a0TVgZI2mzdTkF7TDRvh+EswOgxyDJ6VnGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWU8/L6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081A7C32782;
	Thu,  8 Aug 2024 09:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723109069;
	bh=uX5ep/PSOVtOKHu44Nss6ozVLTd5AuP0lWO5Jg0wheA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CWU8/L6rtcD/JU2QJr5xEWmJ5IFCbthmLwc6ZChNljQljQK/wgMEMlJZkyEFEMyZ0
	 PZjSB3Wd/q8XJ4bq2Q4WwKAr2eA50ihT8nLDFNc1vYxs8DpwwyreiAwoHXBUiB8ltw
	 1MwBXX3ogBujRv2dEj9dPh6xUI17dhw0bkfv5l9Zo9oTbWTBjiESn71NBRkR7tli/D
	 K8BXDNq4vSxXxE5BifRbfFmPhNgYAWP3DqvDJ1MUMShmPlIf61Ol3MKk0DMMKiSZ7p
	 8F0CwtBEW341rsK9KJ5m1z1iaNmqIZ+EHzCjheFQZmeBTIcD9bCDABtkVmCIGtVsfT
	 TPeQdWovWJz7w==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2A41414AD64A; Thu, 08 Aug 2024 11:24:26 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>, bpf@vger.kernel.org
Cc: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Tushar Vyavahare
 <tushar.vyavahare@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Avoid subtraction after htons()
 in ipip tests
In-Reply-To: <20240808075906.1849564-1-ast@fiberby.net>
References: <20240808075906.1849564-1-ast@fiberby.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 08 Aug 2024 11:24:25 +0200
Message-ID: <87sevfpdti.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:

> On little-endian systems, doing subtraction after htons()
> leads to interesting results:
>
> Given:
>   MAGIC_BYTES =3D 123 =3D 0x007B aka. in big endian: 0x7B00 =3D 31488
>   sizeof(struct iphdr) =3D 20
>
> Before this patch:
> __bpf_constant_htons(MAGIC_BYTES) - sizeof(struct iphdr) =3D 0x7AEC
> 0x7AEC =3D htons(0xEC7A) =3D htons(60538)
>
> So these were outer IP packets with a total length of 123 bytes,
> containing an inner IP packet with a total length of 60538 bytes.

It's just using bag of holding technology!

> After this patch:
> __bpf_constant_htons(MAGIC_BYTES - sizeof(struct iphdr)) =3D htons(103)
>
> Now these packets are outer IP packets with a total length of 123 bytes,
> containing an inner IP packet with a total length of 103 bytes.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org>

