Return-Path: <linux-kselftest+bounces-2619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B603B823175
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 17:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567991C23B1F
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 16:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2A41BDF8;
	Wed,  3 Jan 2024 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xt105CKZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66961BDDD
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Jan 2024 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so15271a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Jan 2024 08:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704300423; x=1704905223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SAZtTgsMoR0htuI/uDVatrkyoqnPaglyETllJqt29U=;
        b=Xt105CKZqOofuJoyoV+mLGM6J4bqDz4Oh+3y+7sTspzW0wDa2q3L9cCSHrTaWJI8XG
         7Q/HLbw07sxRXHsx8YIHdNfZCI3ckPti2dH8FfJ1KQr5LSI7DisTbrI4cEbuzVYNcAah
         xjQ2PKorNwNmUQDOudSqzImepVE15ic9GQi7yjs/zPlyHbHiQWhUs2JyFKjlQt3GWOMZ
         1u+s5N/HqMWzNQ+QkG00RFUAmvhgVFX74qyukrd4PqIa5v5HifMN7GmqoKF9g+TXVXDq
         lYOfv7FUlfECHtR6KnEQA78CWFM632it1Rv3LJDhM5xHgl8D2nA9yMhSDRbzeBqnd544
         9YnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704300423; x=1704905223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SAZtTgsMoR0htuI/uDVatrkyoqnPaglyETllJqt29U=;
        b=F9HeeF3bVO/1GObQ58+w2hL0zho99CujU3Z5y5iypWChZe2cLh8+4wkHE7610GQ/Xs
         jJ9DCJitYeFHip5/Iw7XmtQswhcB7hX8TadjdoiR3TiE04sNrUoyjXMfTmzHuy8yZtpX
         W+CEZAaACw5/FFImItu0DF3DGAEvgi+vUzneSJ0q7iWSCZb4PiCPiofTecc0c4nm8W9A
         L4XH89Z3R7Y9e4Z5rjWt6E0bp+zT3/Vr7k9kVZUAThwKHVw6ykB9UmoVOxRyJCVuG954
         BKwqH3qlBGXcGlx5EE3D+ocjXFL44V0kBWgFDt+uqUQRkoz1InIENFAM9YUq7n5AOZGq
         emZg==
X-Gm-Message-State: AOJu0YzpG9y1ZcpqduFI/TB6Aw2Zg+8z0hExZ3SVkAtVYePPcLvX67gr
	/pBvEoSWg8UBJgS7KuU8DfxSJKU9KXeqrOhYxwGRceQJfp5n
X-Google-Smtp-Source: AGHT+IE5Lvxi6Uh+t5HLAohyqXdOfMpoJrTnnSQ0HQWHt1cRrSiFm3RtP6RFEi87baJJe6kIRdg6wuypbuWlzNMV8YQ=
X-Received: by 2002:a50:ab42:0:b0:553:773b:b7b2 with SMTP id
 t2-20020a50ab42000000b00553773bb7b2mr132511edc.6.1704300422957; Wed, 03 Jan
 2024 08:47:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ac6fb684-c00e-449c-92c3-99358a927ade@gmail.com> <504130f6-b56c-4dcc-882c-97942c59f5b7@gmail.com>
In-Reply-To: <504130f6-b56c-4dcc-882c-97942c59f5b7@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Jan 2024 17:46:49 +0100
Message-ID: <CANn89iJCeW=DKazMxJx3fouJoPnQkNmdvPasXHPpxf3cHKZW7w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: gro: parse ipv6 ext headers without
 frag0 invalidation
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 3:44=E2=80=AFPM Richard Gobert <richardbgobert@gmail=
.com> wrote:
>
> The existing code always pulls the IPv6 header and sets the transport
> offset initially. Then optionally again pulls any extension headers in
> ipv6_gso_pull_exthdrs and sets the transport offset again on return from
> that call. skb->data is set at the start of the first extension header
> before calling ipv6_gso_pull_exthdrs, and must disable the frag0
> optimization because that function uses pskb_may_pull/pskb_pull instead o=
f
> skb_gro_ helpers. It sets the GRO offset to the TCP header with
> skb_gro_pull and sets the transport header. Then returns skb->data to its
> position before this block.
>
> This commit introduces a new helper function - ipv6_gro_pull_exthdrs -
> which is used in ipv6_gro_receive to pull ipv6 ext headers instead of
> ipv6_gso_pull_exthdrs. Thus, there is no modification of skb->data, all
> operations use skb_gro_* helpers, and the frag0 fast path can be taken fo=
r
> IPv6 packets with ext headers.
>
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

