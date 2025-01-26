Return-Path: <linux-kselftest+bounces-25198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85932A1C85A
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 15:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C405D7A2272
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 14:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7831F153808;
	Sun, 26 Jan 2025 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SfPLm9Rr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF1E4964F
	for <linux-kselftest@vger.kernel.org>; Sun, 26 Jan 2025 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737901013; cv=none; b=eghi9BajMpw9JtqqzmcflXckQoHpjttczOmep8ymB00484HXREWK5ihs50MFFqAutw1T+keT7bdp9DjSDuS5N8DLHGPNdg8iTy2zzMoHmlv6wEN8RU1bEBkbFVQzKq+uuYaDgLm0UEYBqChZG5mBABDURYGfdCHeEdzouyb+dxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737901013; c=relaxed/simple;
	bh=Rws2a+wog/8MrdQQ3e+bdf6U7//EDWF3+LxC1t1wN/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UvzqC6yoUecLMwdcJxJdGJYCWlZNMo/CskpYlcajsencflg/0dMuMLqYTNVttBPoVO004TG3lJ2AgKes5xTkMclCi3vop2C/Af2NWaz3x48pynxcD6hKXvv6luQMx5NHioNEE/IP2bRgPMB+gGtWCOlF6EPC9RbCPnRktf4PJTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SfPLm9Rr; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso600453966b.2
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Jan 2025 06:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737901010; x=1738505810; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rws2a+wog/8MrdQQ3e+bdf6U7//EDWF3+LxC1t1wN/o=;
        b=SfPLm9RrjR1fW0DBuNtzJCIgxPOzfGtZIWspdanpgbrl21jEQeKKBxWRQ4Gsl9x9Us
         35HlXiAr1Ui7rEWW39Zt/pe/i3dj7nmGGYN959ITd/GXHaKBXvbAEcvcPNionwDD89sN
         YeAvE2Pv5W/Jtnnjt/2a7kkWn/epk7D0Gl5SIABuPilLU0luaqfrzbFoiPAs1Le62i1S
         WE+c2bwBPHVEfDAHvTN6YXcK+s9/JxSwRMK8Ds6I1muwG+UrW7WN8gcUwi1ltVCZztSd
         D7ni9M00apXz4d3yRzJ7VuVCnir8RJFEg6zPkNg20crNKh91JnD4RcHkiMqiQPara91U
         daDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737901010; x=1738505810;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rws2a+wog/8MrdQQ3e+bdf6U7//EDWF3+LxC1t1wN/o=;
        b=bvE5z7xJouJ3tor3viiDyaNZ5eGgWg2kJ08HF158K+hETr8YascJY1mhG9HO2qhvVn
         nclwR3QKdTUfUavMnUASZXu+04mVX4IvURg6rjj96gdklioiFhwO7mEAYJPkw2qMEmT/
         OXeH5cqSw2IgD3rSDZINyM/4D0Vd71dMEG1VSUGw+9RYSz79Dz+ucNgA26WnXtfELbi4
         VMzpBTWOBicI4EDAmhLwNSSfHm2KOtS6Df0AXa/d+4P7V3Sre3bD2Qx9OLM7j7Rop7/T
         3/6VEvZ+CE+IrB9oN2yJg1jgCDjNIOALTPbAEcIy//Pc1NBdFWOpkVdRF1RWDoF3K8ya
         uTyA==
X-Forwarded-Encrypted: i=1; AJvYcCW9Ez84fLuA2uE6/er5e2zCRgVZ2LF3GDCIjqzgLJhd6wMCDV3eMmv0xz3dBxJWZFF/1yik31QXxV1nITftTTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqQkOEkva3uZrW3cWX2NJoaa6S5FUdfbE2GEM0rbcGO7N1q+2E
	kYjRlL5/hAyQSeIUWzijOC+9+HsKSIF48zLML6fh5YNWC+X0wZhV9oOi8q1LiXw=
X-Gm-Gg: ASbGncsIAay8+kfR2+cWLXR8T+eX6lYxcEwtrX47pAm8MbmWWkVl4Rh7YoHHB6Bs1GB
	LBzk/gbPtiiT11rxeMfO+2ogljYBxpnugA1no20XuLywtfr6e18xmB7IZjKxcHkY4chMBk++IUX
	LIjTkwYPYZyYnBQD1b6Ujxz9Wc8uZqwqC4+kKFIuMQj9LkL1iD5OUZV1emVSPoY7OUhCdJqtBJf
	hmnfMixTk3G6isX6BfMx5Byta8NNm6J8/HdMus7sGgtxlfDGWz8bDHSGgEYMF3WHiDe+5W7Fg==
X-Google-Smtp-Source: AGHT+IEtEozd4ZbHmZSXMJeEU/z3POYgpvsYmnTf9qF0iv5ALo2LKCWSk1rqIWjzzlS5YtECkNssNQ==
X-Received: by 2002:a17:907:969f:b0:aae:8495:e064 with SMTP id a640c23a62f3a-ab38b44e119mr3607839866b.40.1737901010016;
        Sun, 26 Jan 2025 06:16:50 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2432::39b:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e8ae96sm424145466b.80.2025.01.26.06.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 06:16:49 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  john.fastabend@gmail.com,  netdev@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org,
  corbet@lwn.net,  eddyz87@gmail.com,  cong.wang@bytedance.com,
  shuah@kernel.org,  mykolal@fb.com,  jolsa@kernel.org,  haoluo@google.com,
  sdf@fomichev.me,  kpsingh@kernel.org,  linux-doc@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v9 0/5] bpf: fix wrong copied_seq calculation and
 add tests
In-Reply-To: <20250122100917.49845-1-mrpre@163.com> (Jiayuan Chen's message of
	"Wed, 22 Jan 2025 18:09:12 +0800")
References: <20250122100917.49845-1-mrpre@163.com>
Date: Sun, 26 Jan 2025 15:16:47 +0100
Message-ID: <877c6hd5io.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 22, 2025 at 06:09 PM +08, Jiayuan Chen wrote:
> A previous commit described in this topic
> http://lore.kernel.org/bpf/20230523025618.113937-9-john.fastabend@gmail.com
> directly updated 'sk->copied_seq' in the tcp_eat_skb() function when the
> action of a BPF program was SK_REDIRECT. For other actions, like SK_PASS,
> the update logic for 'sk->copied_seq' was moved to
> tcp_bpf_recvmsg_parser() to ensure the accuracy of the 'fionread' feature.
>
> That commit works for a single stream_verdict scenario, as it also
> modified 'sk_data_ready->sk_psock_verdict_data_ready->tcp_read_skb'
> to remove updating 'sk->copied_seq'.
>
> However, for programs where both stream_parser and stream_verdict are
> active (strparser purpose), tcp_read_sock() was used instead of
> tcp_read_skb() (sk_data_ready->strp_data_ready->tcp_read_sock).
> tcp_read_sock() now still updates 'sk->copied_seq', leading to duplicated
> updates.
>
> In summary, for strparser + SK_PASS, copied_seq is redundantly calculated
> in both tcp_read_sock() and tcp_bpf_recvmsg_parser().
>
> The issue causes incorrect copied_seq calculations, which prevent
> correct data reads from the recv() interface in user-land.
>
> Also we added test cases for bpf + strparser and separated them from
> sockmap_basic, as strparser has more encapsulation and parsing
> capabilities compared to sockmap.
>
> ---
> V8 -> v9
> https://lore.kernel.org/bpf/20250121050707.55523-1-mrpre@163.com/
> Fixed some issues suggested by Jakub Sitnicki.
>
> V7 -> V8
> https://lore.kernel.org/bpf/20250116140531.108636-1-mrpre@163.com/
> Avoid using add read_sock to psock. (Jakub Sitnicki)
> Avoid using warpper function to check whether strparser is supported.
>
> V3 -> V7:
> https://lore.kernel.org/bpf/20250109094402.50838-1-mrpre@163.com/
> https://lore.kernel.org/bpf/20241218053408.437295-1-mrpre@163.com/
> Avoid introducing new proto_ops. (Jakub Sitnicki).
> Add more edge test cases for strparser + bpf.
> Fix patchwork fail of test cases code.
> Fix psock fetch without rcu lock.
> Move code of modifying to tcp_bpf.c.
>
> V1 -> V3:
> https://lore.kernel.org/bpf/20241209152740.281125-1-mrpre@163.com/
> Fix patchwork fail by adding Fixes tag.
> Save skb data offset for ENOMEM. (John Fastabend)
> ---

Thanks for addressing all feedback, Jiayuan. Series LGTM.
Feel free to carry my tags if there is another iteration.

-jkbs

