Return-Path: <linux-kselftest+bounces-1405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F26A08098C5
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 02:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE531F2116D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 01:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF991863;
	Fri,  8 Dec 2023 01:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BvbnBT/j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089AB171F
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Dec 2023 17:47:34 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-db3fa47c2f7so1937086276.0
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Dec 2023 17:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702000053; x=1702604853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QasjkTvE12oeIkeDPIYBXwIAiruihNVVX4fkQH8L17I=;
        b=BvbnBT/jCw/UUnZgs0UH+5sifjP4Ni5A0uCwDWSA08tYT8kQE0Rke9gqi6DMjXSugm
         hIADFMw1HFyj6rbRK/EGrGdq9McVURKMPTVPpCBTH9C0b7bNKpyWvI819pvo8ywfiMgR
         pDL3r+43rIS20Q0og4yBM7i0mjzBM/mCH/kmsEsULve5DqpWbWFNoGFltr0be8Ln6HcG
         2vwP7GXJfZK6Ov4V1k6ts55liIt6EsxjzGidH6MG95edz3LKdQIJmzc/RAmulZ+Z4zMi
         I3JrAll0CHg1LSmnqLFFMAggHkvoAIJGv3aZmbd563cTKNirj7ZqUGiQBhOomg+JGhle
         ku7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702000053; x=1702604853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QasjkTvE12oeIkeDPIYBXwIAiruihNVVX4fkQH8L17I=;
        b=ri6GWnmrbhtF8cX9UJ5qgn3cNO29P5KkfYQ8gMnftQA4221PN3aQBqxGqQ1iOOpnAb
         11ASKTNBtyZDyWUwfJo871whaQjq3QynFlrOIwsF0dX/O2MjZ9ukfe4YkJxIf1xKZc51
         QkZjIS334PM5w0GZOEXkW+ObN9QgLpE44CiBMBvBomfLuz2yRYCmuSAv+Q6dvU6EXGKA
         Y2hgZw4+xRrHFfP7tothcm4eCceT2MGr7t4EPOZyArOTurlKyWPK7lvsAOLuwmDDoFs6
         8hR+HsKZuRRgVEra5VztNzXBDta9FfEqvarwrPCYcat0VdaxYqKhb7yecGeCdizlI6WX
         spGw==
X-Gm-Message-State: AOJu0Yzql1ajQ8hAaCnNuCeuEJ6Cwi6wLYhBfu6DfVukVQ3KQ/CrLrkh
	PF+loPZXEsUR/mys0Q40oP7QW6D0W2D0OIKMEzisqg==
X-Google-Smtp-Source: AGHT+IGkcaN4vvcrb8T5smexqtqjrDfI96Nzc421af0VFhb8gbbvwzsJEs/NJAkNTu4GFPThK+R150NgDMf09+eZHpo=
X-Received: by 2002:a05:6902:18ca:b0:db7:dad0:60d7 with SMTP id
 ck10-20020a05690218ca00b00db7dad060d7mr4259393ybb.100.1702000052997; Thu, 07
 Dec 2023 17:47:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
In-Reply-To: <20231208005250.2910004-1-almasrymina@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 7 Dec 2023 17:47:19 -0800
Message-ID: <CAHS8izPitBiASmmdZQ91HRmK33YBZJXOmmCybgeuGYTjP231ug@mail.gmail.com>
Subject: Re: [net-next v1 00/16] Device Memory TCP
To: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, David Wei <dw@davidwei.uk>, 
	Pavel Begunkov <asml.silence@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 4:52=E2=80=AFPM Mina Almasry <almasrymina@google.com=
> wrote:
>
> Major changes in v1:
> --------------
>
> 1. Implemented MVP queue API ndos to remove the userspace-visible
>    driver reset.
>
> 2. Fixed issues in the napi_pp_put_page() devmem frag unref path.
>
> 3. Removed RFC tag.
>
> Many smaller addressed comments across all the patches (patches have
> individual change log).
>
> Full tree including the rest of the GVE driver changes:
> https://github.com/mina/linux/commits/tcpdevmem-v1
>
> Cc: Yunsheng Lin <linyunsheng@huawei.com>
> Cc: Shailend Chand <shailend@google.com>
> Cc: Harshitha Ramamurthy <hramamurthy@google.com>
>

Welp, I messed up the subject line. It should say [PATCH net-next...]
across all the patches. This may trip up bots and email filters. If
this is annoying, I'll resend with the fixed subject line after the
24hr cooldown period. Sorry about that.

--=20
Thanks,
Mina

