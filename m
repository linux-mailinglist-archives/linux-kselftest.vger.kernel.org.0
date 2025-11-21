Return-Path: <linux-kselftest+bounces-46182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD057C775D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 06:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8969A4E48BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 05:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE59A274FC1;
	Fri, 21 Nov 2025 05:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0uVcbqE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C47B214A9B;
	Fri, 21 Nov 2025 05:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763702839; cv=none; b=jyQ2h7M8AHLPzteJsmrRJeeRC46nQ6hpe0E09SWCKbOUk5XToEsi6wvsVLQ/myIAHLNXFaoPKMU/tQ5VVLBU/SC7aEmCofCBdyIWllc7jWKbzoXR6I7cNc6P+VjEOrkLi1/cP6UtiwI9rT+cYr0EQroq4ElWNUzwh3XadMzdKOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763702839; c=relaxed/simple;
	bh=jgjPiFl6nMp/qJWlXf7i92nE2/VyDup9dr7tLT1/Nlw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Fzx0vLnQZF44spXet3XZFqdj6vWtGkdESPGZNviNKtgaYmXkm54KmhgJX0fDjTy/poM2TYiUBvX5gwLnArygR6geJyNxriCJD91nnHVcX9X8RiWzKq0R1gbJj53nBvpTM7IG+1POgLgYuXBerMqvFYgvdzA0ETa8RebhdnPL88g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0uVcbqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECDFC4CEF1;
	Fri, 21 Nov 2025 05:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763702839;
	bh=jgjPiFl6nMp/qJWlXf7i92nE2/VyDup9dr7tLT1/Nlw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Y0uVcbqEqtBkL59NUX3/uNqaE/tU4PMkK+5XdWgWdZhtoc1NFazn7Pz6vJe/QE1yz
	 EX9Fxu2OXRQLV4FK5KtrwxYSWuk33PvKwj64RupTexwWz1YnX46zfPdd313iFwzQL7
	 P+rt7YwH2qoFCT67PD7KhMU/dH912LVcU7cXblAqpowcjut38z+FTIOIPVHa/nfY8J
	 KYPfpciCUn4tw7C5jczdofqjcUKN0vfl4QgoPGZ7Aw0e9289pJACVc2kYoPOizfIJS
	 jZi8irsccYIsSgD5b1FhIDDeeXnefID64vVreTC36KY+oZCxRV+Fg4wOgDj7NFhawC
	 vD8ujo5fpZibQ==
Content-Type: multipart/mixed; boundary="===============6194490512902342718=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f85798386e18578290bba923bc4f0f8c399f903cf5d6c5efd580698e940ad3ec@mail.kernel.org>
In-Reply-To: <20251121030013.60133-3-jiayuan.chen@linux.dev>
References: <20251121030013.60133-3-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf-next v2 2/3] bpf, sockmap: Fix FIONREAD for sockmap
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,john.fastabend@gmail.com,jakub@cloudflare.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,ncardwell@google.com,kuniyu@google.com,dsahern@kernel.org,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,mhal@rbox.co,sgarzare@redhat.com,cong.wang@bytedance.com,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 21 Nov 2025 05:27:18 +0000 (UTC)

--===============6194490512902342718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index 0323a2b6c..49069b519 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h

[ ... ]

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index d73e03f77..4390deaeb 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c

[ ... ]

> @@ -820,8 +821,11 @@ static void __sk_psock_purge_ingress_msg(struct sk_psock *psock)
>  		if (!msg->skb)
>  			atomic_sub(msg->sg.size, &psock->sk->sk_rmem_alloc);
>  		sk_msg_free(psock->sk, msg);
> +		sk_psock_inc_msg_size(psock, -msg->sg.size);
>  		kfree(msg);
>  	}
> +
> +	WARN_ON_ONCE(psock->ingress_size);
>  }

Can msg->sg.size be read after sk_msg_free()? Looking at sk_msg_free():

  int sk_msg_free(struct sock *sk, struct sk_msg *msg)
  {
      return __sk_msg_free(sk, msg, msg->sg.start, true);
  }

And __sk_msg_free() at net/core/skmsg.c:207:

  static int __sk_msg_free(struct sock *sk, struct sk_msg *msg, u32 i,
                           bool charge)
  {
      ...
      while (msg->sg.size) {
          msg->sg.size -= sge->length;
          ...
      }
      consume_skb(msg->skb);
      sk_msg_init(msg);    // <-- this zeros the entire msg structure
      return freed;
  }

And sk_msg_init() at include/linux/skmsg.h:193:

  static inline void sk_msg_init(struct sk_msg *msg)
  {
      BUILD_BUG_ON(ARRAY_SIZE(msg->sg.data) - 1 != NR_MSG_FRAG_IDS);
      memset(msg, 0, sizeof(*msg));    // <-- zeros everything
      sg_init_marker(msg->sg.data, NR_MSG_FRAG_IDS);
  }

After sk_msg_free() completes, msg->sg.size is zero, so the line
"sk_psock_inc_msg_size(psock, -msg->sg.size)" subtracts 0 instead of
the actual message size. This means ingress_size will never be
decremented during cleanup, and WARN_ON_ONCE(psock->ingress_size) will
trigger whenever the ingress_msg queue contained messages.

The fix would be to save msg->sg.size before calling sk_msg_free():

  u32 msg_size = msg->sg.size;
  if (!msg->skb)
      atomic_sub(msg_size, &psock->sk->sk_rmem_alloc);
  sk_msg_free(psock->sk, msg);
  sk_psock_inc_msg_size(psock, -msg_size);
  kfree(msg);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19558612316

--===============6194490512902342718==--

