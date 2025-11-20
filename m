Return-Path: <linux-kselftest+bounces-46101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F255AC74114
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 13:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D5B102ABA6
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 12:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D398533508B;
	Thu, 20 Nov 2025 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="S7aqdZIp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E46731813F
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763643507; cv=none; b=kTTB+XoY0NFblBB52/RshZ/MTGcyuByb3C7vaY0S891AVcBm0ragptsk4qQn0W3iMr2gerfgW+co3W9BE2lhQ96DCaU71nQHfnh7LD2PDaaFjVi15sTaUZjAMpVUf0gDAPTsVkDxUkpuQLY6www8t/Txup3Zaw0q22um3M15uB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763643507; c=relaxed/simple;
	bh=yrrGT9RTCWN6v25Jy1PljEJyV2gwJA+0BkSczHJvwqU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jy9uJz49Pud4WXsNoM4YkUdXwfdMEPL0QdqEe39Enxnxtp8FrfJrGMKAVE+ujMCVcW8XGCnQfRzlTB+Aa83hdYO0rvZq/maodJsMtl8+DOv5+eNGaBPmPEHs4lwR593LyU6mg7oyv5WlQqH7ElkBZUoxn/jsLmBopXFwh3rNuY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=S7aqdZIp; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b73b24f1784so156637166b.0
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 04:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1763643505; x=1764248305; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rWt1WezTZ5DpLX3MB7doQs98ekhplq8AtMdx/O/O2yc=;
        b=S7aqdZIpeni1IEmbAnYHWLn6J0Yx8fLyUQLq2Ef1J/WrTksSv4BxKoCb2jI/FILfsc
         wyaUpjWBz/BvwJf4kYQD+NiacTMcuF09mbR03g0xKuuaaEcWUZY0ezk7DscGdzobZBO6
         IejvOvDsDPo+JaQVnqpns0r6JcuL9O4F+ZfF+ihHVAdz8YI6A1CahTv31/CKHY/LU9yC
         Ov/M4kmm+073daycX90GqfpCkJQ+/Rqz6Nk1cqbwvLkKyIQamctisqo/ubcf2I2VwrkS
         B6PboTQVBrKutFNcyknsISoH0nwmw1SMBJHDkNKOFWc7T+QzZ4j5bkqBE+4pRTwWedRc
         Odvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763643505; x=1764248305;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWt1WezTZ5DpLX3MB7doQs98ekhplq8AtMdx/O/O2yc=;
        b=tlgWt1TzxC1o1eB2HXyHHHzsTADTDINg6T838TeghEekBXnuZvgEt66D2TmEUwiz+S
         sLqdrbpSIFIyVfU9b8Tz2HByEbPPA9UALsX36hyzpiowQvgktfHMGsIUxbpxI9dFnS7Z
         I0q21cmwkwefFkBHOuqDiXc77H5WmGzHulWaGCtpRiJCr+LXKHmByzbXDrBfX8FX94xZ
         9BRPNcuXHqah/PQdif2e/4vbXknbvMjdVoP9rLil8EjrqvW8n5RRoY/irQHAeu9NSVd9
         VvhG/7LJYnM+MhQBOTc0JCYtpivfh5aHUer2LAtUp80zrmRpvwnaQGvsqkaWPTeAn/9O
         VY8A==
X-Forwarded-Encrypted: i=1; AJvYcCVwZBEqyYOJKNAz1EUOBBxqiF0PjxNEjURw6iw+CGCvhJApkzJHofwDn5BqdneLEctCBGmve/wol0ANAuJ6uL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyndMj24W/7Ff0JCFDRr9HRNHnLkW3GsAvpsIiEFDlu2zymvVtt
	XIg5CFKlvE96A4YrXV3Nd0/Stm530nzyQyigtO8dyQ5JcjDyxVGMi2UsPfvazorNfSA=
X-Gm-Gg: ASbGnctMFtny6NoIAg7V4ANhP69qb627+RPKhMcPYzgFN+ZpgsD0nNa9dobHG/ozlj1
	uHwvm7nTJz9shKXbx59xZFDC+3raQGBa35pDdP9YJODPV6kTKy9Rr99Ei75el7DqszkFKme7O1m
	vUhUJpU/eGUuigZk9is9IhigPcvjjSe6Vedh2P8r9JTmXoztJlmgqhrrWAWuiUGgd3zjHJnJ1lV
	hHt80RwwiAuuvsQ+dhsRQxJtA3DGlM3IqVDgjxN+1qXVedvXw+txudORugLVCV3lURWyT/XLnVF
	8To4DDnWlh8PinVpl12Oy/2iEBBXWPCkqUsNe5QMUG89OeXeWz4lL6gcu3+NOva/IBTQ6pI1zg5
	peeWCvb/HUcQRGBXwRHYAti14zdUBzWCyHYaA/ySbD1QmlHg3jGgimyeScEM4Ev5jaPPeyilgYI
	tas8E=
X-Google-Smtp-Source: AGHT+IGx1D4Lf3+ONX9DYRjufCOc1Fw/EfSu7B0mNDhtvWXtJYLURbexh3sFGvbZtkfpHNbDzHlRQg==
X-Received: by 2002:a17:907:9487:b0:b04:48b5:6ea5 with SMTP id a640c23a62f3a-b765720a6e1mr306820066b.17.1763643504589;
        Thu, 20 Nov 2025 04:58:24 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd4e51sm201000466b.42.2025.11.20.04.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 04:58:23 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org,  "John Fastabend" <john.fastabend@gmail.com>,
  "David S. Miller" <davem@davemloft.net>,  "Eric Dumazet"
 <edumazet@google.com>,  "Jakub Kicinski" <kuba@kernel.org>,  "Paolo Abeni"
 <pabeni@redhat.com>,  "Simon Horman" <horms@kernel.org>,  "Neal Cardwell"
 <ncardwell@google.com>,  "Kuniyuki Iwashima" <kuniyu@google.com>,  "David
 Ahern" <dsahern@kernel.org>,  "Alexei Starovoitov" <ast@kernel.org>,
  "Daniel Borkmann" <daniel@iogearbox.net>,  "Andrii Nakryiko"
 <andrii@kernel.org>,  "Martin KaFai Lau" <martin.lau@linux.dev>,  "Eduard
 Zingerman" <eddyz87@gmail.com>,  "Song Liu" <song@kernel.org>,  "Yonghong
 Song" <yonghong.song@linux.dev>,  "KP Singh" <kpsingh@kernel.org>,
  "Stanislav Fomichev" <sdf@fomichev.me>,  "Hao Luo" <haoluo@google.com>,
  "Jiri Olsa" <jolsa@kernel.org>,  "Shuah Khan" <shuah@kernel.org>,
  "Michal Luczaj" <mhal@rbox.co>,  "Stefano Garzarella"
 <sgarzare@redhat.com>,  "Cong Wang" <cong.wang@bytedance.com>,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/3] bpf, sockmap: Fix incorrect copied_seq
 calculation
In-Reply-To: <5a66955891ef8db94b7288bbb296efcc0ac357cf@linux.dev> (Jiayuan
	Chen's message of "Thu, 20 Nov 2025 02:49:43 +0000")
References: <20251117110736.293040-1-jiayuan.chen@linux.dev>
	<20251117110736.293040-2-jiayuan.chen@linux.dev>
	<87zf8h6bpd.fsf@cloudflare.com>
	<5a66955891ef8db94b7288bbb296efcc0ac357cf@linux.dev>
Date: Thu, 20 Nov 2025 13:58:23 +0100
Message-ID: <87tsyo6ets.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 20, 2025 at 02:49 AM GMT, Jiayuan Chen wrote:
> November 20, 2025 at 03:53, "Jakub Sitnicki" <jakub@cloudflare.com mailto:jakub@cloudflare.com?to=%22Jakub%20Sitnicki%22%20%3Cjakub%40cloudflare.com%3E > wrote:
>
> [...]
>> >  +/* The BPF program sets BPF_F_INGRESS on sk_msg to indicate data needs to be
>> >  + * redirected to the ingress queue of a specified socket. Since BPF_F_INGRESS is
>> >  + * defined in UAPI so that we can't extend this enum for our internal flags. We
>> >  + * define some internal flags here while inheriting BPF_F_INGRESS.
>> >  + */
>> >  +enum {
>> >  + SK_MSG_F_INGRESS = BPF_F_INGRESS, /* (1ULL << 0) */
>> >  + /* internal flag */
>> >  + SK_MSG_F_INGRESS_SELF = (1ULL << 1)
>> >  +};
>> >  +
>> > 
>> I'm wondering if we need additional state to track this.
>> Can we track sk_msg's construted from skb's that were not redirected by
>> setting `sk_msg.sk = sk` to indicate that the source socket is us in
>> sk_psock_skb_ingress_self()?
>
> Functionally, that would work. However, in that case, we would have to hold
> a reference to sk until the sk_msg is read, which would delay the release of
> sk. One concern is that if there is a bug in the read-side application, sk
> might never be released.

We don't need to grab a reference to sk if we're talking about setting
it only in sk_psock_skb_ingress_self(). psock already holds a ref for
psock->sk, and we purge psock->ingress_msg queue when destroying the
psock before releasing the sock ref in sk_psock_destroy().

While there's nothing wrong with an internal flaag, I'm trying to see if
we make things somewhat consistent so as a result sk_msg state is easier
to reason about.

My thinking here is that we already set sk_msg.sk to source socket in
sk_psock_msg_verdict() on sendmsg() path, so we know that this is the
purpose of that field. We could mimic this on recvmsg() path.

