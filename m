Return-Path: <linux-kselftest+bounces-22392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E909D49D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 10:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554AC280F7C
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 09:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B84C1CACE9;
	Thu, 21 Nov 2024 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOUQxG/D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CC1155CB0
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180874; cv=none; b=F3Y2yNZ6hstP81V7PWWaA8t238TevJ84aD+kC+UFRj9NMroRF7WkRjPmOH7TB+y/2ySC2M1TPoZAgoEZQUVstgu9RmarQaFkamxN2i9u0K4cvCPL8gNRoQYTN6nMRljLrWyZvu3dc4HqCkfqPn5CkE3tcC/VWD+tdjLXzsF5L/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180874; c=relaxed/simple;
	bh=ZHsF+bruKnzomeWRdLcWO5rzZRICLi3lV0cl6r4co3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EoJqu/fCWxQ91eH7mTRo4eczA58vzD9kQxu7Vi2RX7GmkQ66AgST8SzUvjd3GmK3cYB33U8Lu6xfW/m51aGMXjdAKDS514SyV2llr5lCqkpqNdCIDLWr0qTgEnfAbZIXSf0utcuCVKRDal/wedjBfq2WP5dZ2J5UJDpG81Roqd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JOUQxG/D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732180871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wetqTZMAbt2ZmKlMWJbmPjC5Kbm7QlnDEj7t0dmziVI=;
	b=JOUQxG/DiyRAHksodhdw3Hy+PDpWjElrDy86rY6BDPusSvd5eQUXQO/EvTswvTnJinFa98
	l97SP7sbkHZlbPOnjxxvJeEIcjENRrWgdSrhTy+Nc7Mfjn1V7gtApjoeb+SvjCr2Qre7b5
	/3BPohu9wsWVS05VV/f5ZGmvSfn4ac8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-ji0UtY--M_y8dYfBndHLtw-1; Thu, 21 Nov 2024 04:21:10 -0500
X-MC-Unique: ji0UtY--M_y8dYfBndHLtw-1
X-Mimecast-MFC-AGG-ID: ji0UtY--M_y8dYfBndHLtw
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a99fff1ad9cso56859466b.2
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 01:21:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732180869; x=1732785669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wetqTZMAbt2ZmKlMWJbmPjC5Kbm7QlnDEj7t0dmziVI=;
        b=AfG5D6/u+QTbUTswoS96wSUR0rcSlw56iSQVkgGAbdBSRYkOo1CO8Tl+Jwpu8pHZKh
         MDi0K9LjY/oxBCSQhG9px9Iav+qC+EcwoUr5wbxmALB3qMVbvN4GYFRhfC72zQSW42BL
         jmQ0AYDXd5EVr9b12PQ0CR0nEXa1ifBihjf0cKElD4O3RFEaXLqWtL+VL45G8Q3BDbpn
         iDtZomokC/sHX/7L/c6PRHh2WyMN9ywH1sMdJQzK2u440IlbgcpwZlp2WaqOK0axoh43
         SxRx684DDxZANObRpAVwiXFCCshI3SkUizpI9e8+Xk7Vt5anPGJGlQzROcKqGvh/nyl1
         gs0w==
X-Forwarded-Encrypted: i=1; AJvYcCX/q13NXOS23N3aL1bGtivnFqnfYP8I9Zq8nhMTM5orqvfnuG9lmgPuybyZzxw9uCyo949M7uU7E0IlxQVjBHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXONYd9bTX76EQM8hkGNT3lW3+A3dH09c5w35NnnwLuPwkklHZ
	VMZgf69kWKBwD/THAM4HD5uPtFiA8i5BEpgjXu9qYRsVIMNwMr8HsqMoNO3Y0/f52T7fQLHUeml
	guZM5rbaMq9Jay3YGJ8Yj2L5nUKycs1X0lHTu4nAasS6vslN4hyDAqId+bJs9RqEX/g==
X-Received: by 2002:a17:907:c24:b0:a9e:b610:409c with SMTP id a640c23a62f3a-aa4dd72bd62mr582520166b.48.1732180869114;
        Thu, 21 Nov 2024 01:21:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8LpSbI4/swM2sb/mKZeWPLnl/tnij+/wVc1nky3tLyVxCf2YZlSMNePUGBFhckgw57Vuifg==
X-Received: by 2002:a17:907:c24:b0:a9e:b610:409c with SMTP id a640c23a62f3a-aa4dd72bd62mr582515166b.48.1732180868570;
        Thu, 21 Nov 2024 01:21:08 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-129.retail.telecomitalia.it. [79.46.200.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f4319b15sm57405666b.140.2024.11.21.01.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 01:21:08 -0800 (PST)
Date: Thu, 21 Nov 2024 10:21:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf 2/4] selftest/bpf: Add test for af_vsock poll()
Message-ID: <odr4e7iju2ng5pw6hchbroy2utpabqrjpkf4v64zngzfilqzxx@ghodbng5cful>
References: <20241118-vsock-bpf-poll-close-v1-0-f1b9669cacdc@rbox.co>
 <20241118-vsock-bpf-poll-close-v1-2-f1b9669cacdc@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241118-vsock-bpf-poll-close-v1-2-f1b9669cacdc@rbox.co>

On Mon, Nov 18, 2024 at 10:03:42PM +0100, Michal Luczaj wrote:
>Verify that vsock's poll() notices when sk_psock::ingress_msg isn't empty.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> .../selftests/bpf/prog_tests/sockmap_basic.c       | 46 ++++++++++++++++++++++
> 1 file changed, 46 insertions(+)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>index 82bfb266741cfaceafa2a407cd2ccc937708c613..21d1e2e2308433e7475952dcab034e92f2f6101a 100644
>--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>@@ -885,6 +885,50 @@ static void test_sockmap_same_sock(void)
> 	test_sockmap_pass_prog__destroy(skel);
> }
>
>+static void test_sockmap_skb_verdict_vsock_poll(void)
>+{
>+	struct test_sockmap_pass_prog *skel;
>+	int err, map, conn, peer;
>+	struct bpf_program *prog;
>+	struct bpf_link *link;
>+	char buf = 'x';
>+	int zero = 0;
>+
>+	skel = test_sockmap_pass_prog__open_and_load();
>+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
>+		return;
>+
>+	if (create_pair(AF_VSOCK, SOCK_STREAM, &conn, &peer))
>+		goto destroy;
>+
>+	prog = skel->progs.prog_skb_verdict;
>+	map = bpf_map__fd(skel->maps.sock_map_rx);
>+	link = bpf_program__attach_sockmap(prog, map);
>+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_sockmap"))
>+		goto close;
>+
>+	err = bpf_map_update_elem(map, &zero, &conn, BPF_ANY);
>+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
>+		goto detach;
>+
>+	if (xsend(peer, &buf, 1, 0) != 1)
>+		goto detach;
>+
>+	err = poll_read(conn, IO_TIMEOUT_SEC);
>+	if (!ASSERT_OK(err, "poll"))
>+		goto detach;
>+
>+	if (xrecv_nonblock(conn, &buf, 1, 0) != 1)
>+		FAIL("xrecv_nonblock");
>+detach:
>+	bpf_link__detach(link);
>+close:
>+	xclose(conn);
>+	xclose(peer);
>+destroy:
>+	test_sockmap_pass_prog__destroy(skel);
>+}
>+
> void test_sockmap_basic(void)
> {
> 	if (test__start_subtest("sockmap create_update_free"))
>@@ -943,4 +987,6 @@ void test_sockmap_basic(void)
> 		test_skmsg_helpers_with_link(BPF_MAP_TYPE_SOCKMAP);
> 	if (test__start_subtest("sockhash sk_msg attach sockhash helpers with link"))
> 		test_skmsg_helpers_with_link(BPF_MAP_TYPE_SOCKHASH);
>+	if (test__start_subtest("sockmap skb_verdict vsock poll"))
>+		test_sockmap_skb_verdict_vsock_poll();
> }
>
>-- 
>2.46.2
>


