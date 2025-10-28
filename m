Return-Path: <linux-kselftest+bounces-44177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D92C14762
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 12:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE1405071CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 11:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0862B30E85D;
	Tue, 28 Oct 2025 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AA9haMyl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B9B30DED5
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652055; cv=none; b=fNHFi2LXPerTzjlbnqlWZGYc5/A0eubS1Mr+VutWceE485/MKudn8tIjPeYhdonR2pNkBjGYkorIZ6onbaNX7WL5FRPONoEBF4Ng6Te5IDVTo0r+RLNZYX4KVWmxc6r1YGTPZ7Oedyyb/Pplgi2Tqt5LA62SUspYwgeJPpvhkLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652055; c=relaxed/simple;
	bh=hTHSTmvO2gcuI9bvffQRykt0y1SGaZooIAbSqmRKxWY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Fy8ZQSmR3b9SqHjblJKfWmLgeYx9xMkzewV4rd9ymKasrpEEXinJJLIeL/MUUvNVJUeKp8L8P7oEeLyqePpoGenwv4xmIUMfGeWiT7asSAkhJf04vvrAs1iJLpxs9kHMSDm/LwNIhNvvI/6+9ClIsV7OYAav2nEqv1uTVREt+aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AA9haMyl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761652052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ej5v2AhyT2+gsUph5VSZWo0mYhFvGVyUF+E1rpDGkYk=;
	b=AA9haMylBAidafCPCHDsWLUkv37h7NL1XI4lk7FudkS2N2t/nbQI/gG6K84hzbZDevzl7f
	m+p1S6uKR3lfPYFsP14GQY1bUbI0xhJdOy0dE5Zp8RAVyTRyTHSzoWteD2QZxW1CZEWVlW
	o6QudmcANfiRdMezzYtk4o7oAIWx3w0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-aiTGeY9cOgKbgBSMW16M8w-1; Tue, 28 Oct 2025 07:47:31 -0400
X-MC-Unique: aiTGeY9cOgKbgBSMW16M8w-1
X-Mimecast-MFC-AGG-ID: aiTGeY9cOgKbgBSMW16M8w_1761652050
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4710d174c31so54880275e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 04:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761652050; x=1762256850;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ej5v2AhyT2+gsUph5VSZWo0mYhFvGVyUF+E1rpDGkYk=;
        b=Xu7WKXfI1PKCe2xZACq6VIe5Ajkl8ymqvPbMR/eEIp5wRfFxIhx4gPqSwHe0IoSQF6
         rIHpSP8PyU6tktnGv4QCcZdg2Wdg7r801Xsi1x336F0I37x9m4qdT43eZhkL/625UKiv
         f0GG2ufgjqZjgSSF5SkZbUksGIuYnBe6JYpWhtpDNAkZXx75gAdROIH/AWHz8pdbZskh
         HcYWGoarSEuYCo4bVldyzq+gcIPG8QNo3X3HR3hPJN5AXQpmKMENjGU7Ex+7FuXEdlCu
         ukppy+uiZzUgUpF1uexzk1ReuhJnB83tpkL34k8STxEC3R3AyeGuLuaNcKdRV4BjKE1M
         /IYA==
X-Forwarded-Encrypted: i=1; AJvYcCWJmz3BMxoc9oOkNwjaO8/68t0BlsdQbwNyibwODverVJnkIMZLchl8+DGDAU7CCcJZtduwPU124BZ/oCyLze4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCIt9Kfz80uRhRgb8kG7uEnmY2viaYe3hrtghJpIVsFioe0/Y2
	QUIhuLyivY+SZJsnTezfhjFrwxEQ/q/Qyc7D7LFZ0+p2+rOVi/GMufoEWmSSZ4RuSpx7/v0Ikdl
	FaJliWM0iWbM1j3iQZ59JlohL7yAveBcXIL3mCjghi94fqgK9Ug8RT+UV3steWK010PCzcWFpoc
	QDVQ==
X-Gm-Gg: ASbGncsbYDL+rLEmbaNtibMgFflzTk7Rfx1two621bQnGhM+f1JfQd1vWCqdD3HCbxD
	oaqU6rJ9sRSZcYWDFQ/qD7kf1vT5xQrrDM2hJTChdoyE1yjc98exwe/bTYtGwnbhdonpW//xVjh
	mzQ4zUAG0Nzelt7knQdYphAPfBq4CTuBqk6FXSFGsCZXcd1KXSk5TdC7p2PW/mC4rTzkATYpfHj
	k+G9W9YhdQf/mi7vsF1F+TA8vurB7aiMyJ/Y0+QZ8H1ldUsB3JqOZeeC+iVG8EFs3eFlKZq8T/A
	HpFbReL+SR3UT3fqHBEoMO4JV2nV7eW/w5SVMwHAao5f0DM3UNZ0B07fMlPZ3kLakKl6FGX8FQY
	g1TXJZrSBPtDQnWMpg7uuotIaeeLfPiX472Qz0A13yJYefjs=
X-Received: by 2002:a05:600c:b90:b0:477:58:7cfe with SMTP id 5b1f17b1804b1-47717e04c2bmr26366925e9.18.1761652049819;
        Tue, 28 Oct 2025 04:47:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYsmPrnr2n5dOG2TMddpHesTATKrRY3s7taqm1slxtVNIFUzWMD6kXpI/krQ6+LdMW9yh+6A==
X-Received: by 2002:a05:600c:b90:b0:477:58:7cfe with SMTP id 5b1f17b1804b1-47717e04c2bmr26366375e9.18.1761652049184;
        Tue, 28 Oct 2025 04:47:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd47793fsm194874245e9.3.2025.10.28.04.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:47:28 -0700 (PDT)
Message-ID: <7dfda5bb-665c-4068-acd4-795972da63e8@redhat.com>
Date: Tue, 28 Oct 2025 12:47:26 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] net,mptcp: fix proto fallback detection with
 BPF sockmap
From: Paolo Abeni <pabeni@redhat.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, mptcp@lists.linux.dev
Cc: stable@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251023125450.105859-1-jiayuan.chen@linux.dev>
 <20251023125450.105859-2-jiayuan.chen@linux.dev>
 <c10939d2-437e-47fb-81e9-05723442c935@redhat.com>
Content-Language: en-US
In-Reply-To: <c10939d2-437e-47fb-81e9-05723442c935@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/25 12:30 PM, Paolo Abeni wrote:
> On 10/23/25 2:54 PM, Jiayuan Chen wrote:
>> When the server has MPTCP enabled but receives a non-MP-capable request
>> from a client, it calls mptcp_fallback_tcp_ops().
>>
>> Since non-MPTCP connections are allowed to use sockmap, which replaces
>> sk->sk_prot, using sk->sk_prot to determine the IP version in
>> mptcp_fallback_tcp_ops() becomes unreliable. This can lead to assigning
>> incorrect ops to sk->sk_socket->ops.
> 
> I don't see how sockmap could modify the to-be-accepted socket sk_prot
> before mptcp_fallback_tcp_ops(), as such call happens before the fd is
> installed, and AFAICS sockmap can only fetch sockets via fds.
> 
> Is this patch needed?

Matttbe explained off-list the details of how that could happen. I think
the commit message here must be more verbose to explain clearly the
whys, even to those non proficient in sockmap like me.

Thanks,

Paolo


