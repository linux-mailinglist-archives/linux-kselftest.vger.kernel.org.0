Return-Path: <linux-kselftest+bounces-43653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D62D4BF5E07
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 12:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 386B64FA7EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 10:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90D132AADD;
	Tue, 21 Oct 2025 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ChnEU0FF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72AA926
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 10:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043765; cv=none; b=t7DZExp+LWFot1IGoyPdxWrw57ch4uOjhCIoiMaczioNQ+9pMg6VA0l55lBEcfDcmDL+xacd1V8x4uU4tzjuMlaPZe/FsHTXX7UfYwipz6onb+Jjr4NqgzAtzOUkcUb6Cw+ftqwywxSObt/Uw3ZWqylO6atUKgiLBE+WP+VrUmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043765; c=relaxed/simple;
	bh=hrF0LCmElQ4WpX5W62bYMJ+jvZnpkYWbqiea2O+smAw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qw2p73IRoqkAO6CASzvNHKTLk401TIqgp33Gt91vlYN0powJYh3Ryr5EinmBScifJdmkzVd37q1oya2y3WjKkOXgZCHiZ5SwdydbqJPSQtyuTx6u5IfVtU+pLjASxwSvI+JHwd28gxP2cbTnnQOpY9CMhPsKZFRlanRoL0/euyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ChnEU0FF; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b54f55a290cso828174466b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 03:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761043761; x=1761648561; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7EOHmK2OfLfwzNiHBksUI9w2NZOUojlK5wP3wAwmdUc=;
        b=ChnEU0FF2MBGOqWLekXisSjna5eNyAi/g7y7+pWsBzT+/GkhltvS4OgQ9nA5zuUr1U
         IFLooonoNDeXoajSkb3prNRHm6TwqZFYgAejnP4ksdDwixBcv8344/JvpF/FWHuU+gCw
         eGV22EtHpMnzAPzkWxTWaySDw4GbQQN5PETcJhsYDehrigkHuoAKxqGvsUAWHt2DhHZ3
         NM1EGCJcAZAr9sqt6RAUtPKbMkm6gUQdGg0ba7nvi2KLdWlHqBQ+A0/gHSl/rgk/4OmG
         ic5jgPQs54mKjT2ng05T8j3L80wd+9zgOdLbY9UlGQ2E+gAvPRoz56TjsT+c7RQxRyr9
         2ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761043761; x=1761648561;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7EOHmK2OfLfwzNiHBksUI9w2NZOUojlK5wP3wAwmdUc=;
        b=nQSQeq/uvRyHqvxJPj71quoB3IhyDItF38NOH2dwoNkEcK5rvSdDz7YC5HHTy70fCQ
         WBEVBgW11Hvy5OsKQQ3IcxR+ncS4BtNHfQCdS83OdXo35H93AuOqsm1Tqw/MSHtbUW+j
         Q3UGumGMv4+NXh8rnyhLukgoIZGFsX8TdnlesFIKm8r0Y6Z+Mtyw70uB1cSxfEJ1YU0C
         mKM+2UVRLQ1TpdxDiiLUuCK2rHo3WBZB/pbIJcf1nArbbL+727DR9CHO72qHpjzLLi/z
         Bhra7VbMgDJ61NpMthzM4Us55Njed5I5j+DZFhivROgjQ1Fsli0VBc7CBP9fZQDCjXo1
         89Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXONYl5feTxDzWZxDdqOhaQ6Ytp1jWZ83SsSVL+qz+wguqXB7KBnjJxFU6hJ5krEUkpMoY1AfbG6ZlY/YHW5GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaNzU2vxz2ZMbUQyjTz5tDhI00vCnP9VOPXpzCrzMUSXj6qxb2
	tMhuL4Pj9KbUliSJhEbjO6Ezj71JyDeRdnU24BZqgY03HlZj6kJOU7/YahQW2dN+1Qg=
X-Gm-Gg: ASbGnctfHueey51Gg8LSvcbVdcrr3LK+sAVUk+TIoFW1N/KGgSyNW7ptl1h7JgTIrYR
	mh0g6wLiNNgbVqjD+VH7m/7JFdRw8ABOHKbEPRr0npGbPb+3anHKFn6sd+cqqcQcDklpenW45VW
	oDf3AJzxcUaaTW58q7ZuC1Sv1OFjNP5vhopRFlc1wWZgxjsShvTDpW5vhrPU5vD5VaSICmIbozy
	thMubvsZSQhGUxi6ITBXWFDoVdF+BLeZiFMiAibN1jdffycV7xxWIeVP2W8n1ZJFzwzvZdHi9qv
	wCCOsOATQxmwuS5QCb+QBojlcT1xD+3QZMrisDmWf5yC3G3jtf8XB0Arry33N4AJzAFdv3YhJOn
	7b4KV4CRxDByWdQIKJCodCgmk3Kc6K0X8/MZ9BWgqpn1GCc+qQd9bKrObmqoA/wB/Y6W6U+1keW
	sav2o=
X-Google-Smtp-Source: AGHT+IHy8op2SrI/lJue90xZTdUE8jYPVJKT9x3Xt5nh13yYcQucOr2Oqx/NtzVh356uT2+TUQAh8g==
X-Received: by 2002:a17:907:3f11:b0:b42:7c2:1f9f with SMTP id a640c23a62f3a-b6475706f53mr1757165566b.62.1761043761371;
        Tue, 21 Oct 2025 03:49:21 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:d0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036a3esm1068920266b.46.2025.10.21.03.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:49:20 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: mptcp@lists.linux.dev,  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  Eric Dumazet <edumazet@google.com>,  Kuniyuki Iwashima
 <kuniyu@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Willem de Bruijn
 <willemb@google.com>,  John Fastabend <john.fastabend@gmail.com>,  "David
 S. Miller" <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,
  Simon Horman <horms@kernel.org>,  Matthieu Baerts <matttbe@kernel.org>,
  Mat Martineau <martineau@kernel.org>,  Geliang Tang <geliang@kernel.org>,
  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Florian Westphal <fw@strlen.de>,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 2/3] bpf,sockmap: disallow MPTCP sockets from
 sockmap updates
In-Reply-To: <20251020060503.325369-3-jiayuan.chen@linux.dev> (Jiayuan Chen's
	message of "Mon, 20 Oct 2025 14:04:47 +0800")
References: <20251020060503.325369-1-jiayuan.chen@linux.dev>
	<20251020060503.325369-3-jiayuan.chen@linux.dev>
Date: Tue, 21 Oct 2025 12:49:19 +0200
Message-ID: <87cy6gwmvk.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 20, 2025 at 02:04 PM +08, Jiayuan Chen wrote:
> MPTCP creates subflows for data transmission, and these sockets should not
> be added to sockmap because MPTCP sets specialized data_ready handlers
> that would be overridden by sockmap.
>
> Additionally, for the parent socket of MPTCP subflows (plain TCP socket),
> MPTCP sk requires specific protocol handling that conflicts with sockmap's
> operation(mptcp_prot).
>
> This patch adds proper checks to reject MPTCP subflows and their parent
> sockets from being added to sockmap, while preserving compatibility with
> reuseport functionality for listening MPTCP sockets.
>
> Fixes: 0b4f33def7bb ("mptcp: fix tcp fallback crash")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/core/sock_map.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 5947b38e4f8b..da21deb970b3 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -535,6 +535,15 @@ static bool sock_map_redirect_allowed(const struct sock *sk)
>  
>  static bool sock_map_sk_is_suitable(const struct sock *sk)
>  {
> +	if ((sk_is_tcp(sk) && sk_is_mptcp(sk)) /* subflow */ ||
> +	    (sk->sk_protocol == IPPROTO_MPTCP && sk->sk_state != TCP_LISTEN)) {
> +		/* Disallow MPTCP subflows and their parent socket.
> +		 * However, a TCP_LISTEN MPTCP socket is permitted because
> +		 * sockmap can also serve for reuseport socket selection.
> +		 */
> +		pr_err_once("sockmap: MPTCP sockets are not supported\n");
> +		return false;
> +	}
>  	return !!sk->sk_prot->psock_update_sk_prot;
>  }

You're checking sk_state without sk_lock held. That doesn't seem right.
Take a look how we always call sock_map_sk_state_allowed() after
grabbing the lock.

Same might apply to sk_is_mptcp(). Please double check.

