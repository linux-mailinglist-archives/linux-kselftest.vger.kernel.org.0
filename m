Return-Path: <linux-kselftest+bounces-22441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584F29D5AE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 09:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18426284DD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 08:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C508C171E6E;
	Fri, 22 Nov 2024 08:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2DK6ipZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB431632C6
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Nov 2024 08:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732263420; cv=none; b=UWEE2g3+RdX3ODulZj0Dt5rn/C78EmUsrW79Uq8MOLT4hH/stQuSH4/VeTDHwR5LwlKNoFmmqoobptnTSQ8T21sFBGIrxOdQhlVhuQpAYa1ui0LiKPSnaMlI6EzHS6eih4iRlx3W4LP0AYUu8zUl3W0bsW4IiWls44Zet/1Cxg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732263420; c=relaxed/simple;
	bh=xk0Fp0+bN6FKayBAYjalWJTCWsFsWEGxzuF72NhSP38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CeVZk4EwYqbtHG7wqS0AxTbvVabwIfXyV36zxlsQU5iBSF0R6R8Cr4Uy6UyBxZKlo8LBQ6/y1Msuf3dYj51lvcYHOUfYzHyx3JgqDAJJ3053zPOwTAiowLKlZqBsKVYqCckhBE0CwPQTzzzlIvqsW8kuXklHZB6gc46Acv1MqKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N2DK6ipZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732263418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SL5pNnDPsbVA1xe0hrEJ7KV9XmpKuGUUP9MjKyVDU+E=;
	b=N2DK6ipZbI1JXvE3yGMP/mellj30HDKeJw+nBuFWinUoISek9mp1e5IGHpjgmQ5XwS7zIM
	iqqUh8p1QJs8HJiW//6zcN/osPAxloN8bouD7eN55JSP3+/ZTydO0BLrVmdgiteLW17oKC
	y17PDH08xZIzuNjdqYmA3lRrJMKDBr8=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-2i2rfBzkPGCbacj9--_RLg-1; Fri, 22 Nov 2024 03:16:56 -0500
X-MC-Unique: 2i2rfBzkPGCbacj9--_RLg-1
X-Mimecast-MFC-AGG-ID: 2i2rfBzkPGCbacj9--_RLg
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e30b8fd4ca1so2853210276.3
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Nov 2024 00:16:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732263416; x=1732868216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SL5pNnDPsbVA1xe0hrEJ7KV9XmpKuGUUP9MjKyVDU+E=;
        b=saL/q14LIa2JfPVqCLZShy8wRuOToKSQhbMI/KxCygoyOFMlAjKpupBrxZA8uor3f4
         KUtP4v3gHuGOvGKT25rLafGsqtUqknxAwhJTYD+Svf/BpC7lRLq8gPQroxr9mDFP96E/
         xLaIWOUVSuLB/eTBbnhQmmBsClnGe83Q5aUR10Psj64iHIuCGC//MCQxl4oqsWcZZvFI
         CfhOoQyRDNpuSLkn0Dq0IDEsbaa8bQQZIlin2OT6rA3FlbdjAK/dfYmz45fetOocVH3v
         K3unvJALuL7s5+E1vpVuyoDmSezVUmi7U+/qXMNb9ghKAonmoIGFJbUKk/jdaOUan7WF
         r5Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXLIqFlrTaWAuTY7B3AM0uOKeoh1zoK703IjdK+ABf3pA2UOImoKh2UIWEUNh/XtkjDkHSsXmLYOke10+kPPaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVH+AsUE6abJSTtZDplfHVYCfCEMDiFWCF+QjCep8d/6y2b+ny
	80/x6qk5WfaLIzmD548uBLdZk687mLfoiv/WM0LDtrqmKoeMTjXxllb24RyN8nDCNInv1Q19mQa
	blI16Hfma/REzNuMWFkq+7KijqyTqRv/Ego/1K5TmiI6xFUbZqC9RV81DPKIW55tUdPWGUNUPHR
	gBdtgipSGoMxVoT48b8GKzNFzTKj5oB0Q/uwK9kJte
X-Gm-Gg: ASbGncugmisT1w1Baa97tsxutM1KseqEYXvMiCAKWuBaBv1K8i5ZKne0YLgQGh22MPM
	z6OL+TJ8BqXuyUPFe72/1bH+6muHUNWo=
X-Received: by 2002:a05:6902:2891:b0:e38:bbea:5f99 with SMTP id 3f1490d57ef6-e38f8c0827dmr1776434276.44.1732263415788;
        Fri, 22 Nov 2024 00:16:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEj5vouXz0BRQwa2iQNMlHQsy/q/aCh6IzhfMrbtN83KbXl29vM/kWrF8c5EzwxZD81oxJ4cvZZonMj3R9bA/k=
X-Received: by 2002:a05:6902:2891:b0:e38:bbea:5f99 with SMTP id
 3f1490d57ef6-e38f8c0827dmr1776401276.44.1732263415431; Fri, 22 Nov 2024
 00:16:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118-vsock-bpf-poll-close-v1-0-f1b9669cacdc@rbox.co>
 <673ed7b929dbe_157a2089e@john.notmuch> <dpt2h73fnzgzufuvilmaw5lbs2nydc3572xqn4yoicateys6cb@reuefsarvhka>
 <673fc371c9de1_11182089c@john.notmuch>
In-Reply-To: <673fc371c9de1_11182089c@john.notmuch>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 22 Nov 2024 09:16:44 +0100
Message-ID: <CAGxU2F7G-s9pwYBD6ateceJJTq_ac5=Yi=AKC6GNX+d6Ly9PUA@mail.gmail.com>
Subject: Re: [PATCH bpf 0/4] bpf, vsock: Fix poll() and close()
To: John Fastabend <john.fastabend@gmail.com>
Cc: Michal Luczaj <mhal@rbox.co>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 12:34=E2=80=AFAM John Fastabend
<john.fastabend@gmail.com> wrote:
>
> Stefano Garzarella wrote:
> > On Wed, Nov 20, 2024 at 10:48:25PM -0800, John Fastabend wrote:
> > >Michal Luczaj wrote:
> > >> Two small fixes for vsock: poll() missing a queue check, and close()=
 not
> > >> invoking sockmap cleanup.
> > >>
> > >> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> > >> ---
> > >> Michal Luczaj (4):
> > >>       bpf, vsock: Fix poll() missing a queue
> > >>       selftest/bpf: Add test for af_vsock poll()
> > >>       bpf, vsock: Invoke proto::close on close()
> > >>       selftest/bpf: Add test for vsock removal from sockmap on close=
()
> > >>
> > >>  net/vmw_vsock/af_vsock.c                           | 70 +++++++++++=
+--------
> > >>  .../selftests/bpf/prog_tests/sockmap_basic.c       | 77 +++++++++++=
+++++++++++
> > >>  2 files changed, 120 insertions(+), 27 deletions(-)
> > >> ---
> > >> base-commit: 6c4139b0f19b7397286897caee379f8321e78272
> > >> change-id: 20241118-vsock-bpf-poll-close-64f432e682ec
> > >>
> > >> Best regards,
> > >> --
> > >> Michal Luczaj <mhal@rbox.co>
> > >>
> > >
> > >LGTM, would be nice to get an ack from someone on the vsock side
> > >though.
> >
> > Sorry, is at the top of my list but other urgent things have come up.
> >
> > I will review it by today.
>
> Thanks a lot Stefano much appreciated! I was also slow to review as I
> was travelling and on PTO.
>

You're welcome :-) Thanks for reviewing the bpf part!

Hope you enjoyed your PTO!

Ciao,
Stefano

> >
> > Stefano
> >
> > >
> > >Acked-by: John Fastabend <john.fastabend@gmail.com>
> > >
> >
>
>


