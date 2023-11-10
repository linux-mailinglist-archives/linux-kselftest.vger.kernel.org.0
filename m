Return-Path: <linux-kselftest+bounces-1-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADB67E7EAF
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Nov 2023 18:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 517E8B20FEB
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Nov 2023 17:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2803D38FB5;
	Fri, 10 Nov 2023 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bkvp2pNw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AAE374F0
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Nov 2023 17:46:30 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224408248
	for <linux-kselftest@vger.kernel.org>; Thu,  9 Nov 2023 22:57:39 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41ccd38eaa5so15058871cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Nov 2023 22:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699599458; x=1700204258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHJDdNWZZ4tIwkHZEN1gC9OcT0HCJr1RVppBH6tmUws=;
        b=bkvp2pNwABHLKjBtPgc3UE6IiJWQkgLioCYxSRpmwnLsKhXFxvkM8W7BLyxUYu/mLc
         RRwttHSE6hq/eA8JHgJcao5thQhUwVF0hFzz3GiLwLoevDo8nRykTAYJSsQ/vjcuQblc
         6vWOZNWrRUA8JR0KjaK5zKhz8ejZwFT0JKavVBeIyrxvi3I34ediaBQE6MBkEH5jvaIw
         ADFCsD8hQGEIoXMJXDkbeQGbuAcsjBnh+m0yiNrBdw75S3z3lWbXSFi9BbZU875ylmDD
         pOUbOD5LPZnZ7hZFNwLRsDiY/RiZf14QlwWeu1Xvr8WbQNza47K7bHW+TsKINk4AvmPC
         GnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699599458; x=1700204258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHJDdNWZZ4tIwkHZEN1gC9OcT0HCJr1RVppBH6tmUws=;
        b=AIYHiXXwg9qCSnthaGQEQxVUzOQF2JGeLTvPq+ImVjelPmfEaHlIp3bdJmTiEWiTfV
         KMejJSja2A69EyqROdQIVgsqEHEUh4MErL5srsDFYQjmae86sR3pR1VLs1RzgPCAi0yu
         tphstsDWp9pUKOMyx+cBGBewZvX0k9Cj1OENzCIPvobaq2OWN6XseG0hC1SUdJv46F8b
         SMx6Ozb8/Z3gUTwtM8fE4uRgjtQD66YrJEH05HzLCOlOMirJnfeK/O9eOxDZqu8asx8G
         YxzxIOGZGnSGG4mDdLW/XXd72vuEgW0ihBbxap3iVCiWiMGMW52VyfXZNlwkiP21YQFG
         M4eg==
X-Gm-Message-State: AOJu0YyRIaIaQGVaZWMK2nJpmJ762c0tRc0dkcgAcVww99OaqmY0ORBw
	HPIGQ+FHiNcIDTJL7IsKIuaARIMBZr7Mud02QKuugan2b5q2NvcZhCc=
X-Google-Smtp-Source: AGHT+IHV8+0MFbC/VQpqHkvElGy/RL/z/ISeA+lbF9gB7A+2xFrkzHZehvrtNrke+02jjGbQaJXjvKRk/eDFLYB8QzU=
X-Received: by 2002:a05:6102:3d8b:b0:44d:38d6:5cb8 with SMTP id
 h11-20020a0561023d8b00b0044d38d65cb8mr631035vsv.10.1699589171185; Thu, 09 Nov
 2023 20:06:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-9-almasrymina@google.com> <adde2b31fdd9e7bb4a09f0073580b840bea0bab1.camel@redhat.com>
In-Reply-To: <adde2b31fdd9e7bb4a09f0073580b840bea0bab1.camel@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 9 Nov 2023 20:06:00 -0800
Message-ID: <CAHS8izMrJVb0ESjFhqUWuxdZ8W5HDmg=yRj1J1sTeGoQjDcJog@mail.gmail.com>
Subject: Re: [RFC PATCH v3 08/12] net: support non paged skb frags
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 1:15=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Sun, 2023-11-05 at 18:44 -0800, Mina Almasry wrote:
> [...]
> > @@ -3421,7 +3446,7 @@ static inline struct page *skb_frag_page(const sk=
b_frag_t *frag)
> >   */
> >  static inline void __skb_frag_ref(skb_frag_t *frag)
> >  {
> > -     get_page(skb_frag_page(frag));
> > +     page_pool_page_get_many(frag->bv_page, 1);
>
> I guess the above needs #ifdef CONFIG_PAGE_POOL guards and explicit
> skb_frag_is_page_pool_iov() check ?
>

It doesn't actually. page_pool_page_* helpers are compiled in
regardless of CONFIG_PAGE_POOL, and handle both page_pool_iov* & page*
just fine (the checking happens inside the function).

You may yell at me that it's too confusing... I somewhat agree, but
I'm unsure of what is a better name or location for the helpers. The
helpers handle (page_pool_iov* || page*) gracefully, so they seem to
belong in the page pool for me, but it is indeed surprising/confusing
that these helpers are available even if !CONFIG_PAGE_POOL.

>
> Cheers,
>
> Paolo
>
>


--=20
Thanks,
Mina

