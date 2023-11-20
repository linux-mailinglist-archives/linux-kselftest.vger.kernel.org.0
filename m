Return-Path: <linux-kselftest+bounces-292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EE67F0EAF
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 10:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7501B215BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 09:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665C210A05;
	Mon, 20 Nov 2023 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DMUqDQfC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D98A1AA
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Nov 2023 01:12:35 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4078fe6a063so63895e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Nov 2023 01:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700471554; x=1701076354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+uIjKTA9mmQZQKmxMlAd6qDO2AL3fBqrTi9w8Ax8L4=;
        b=DMUqDQfCp5bLokrXATFaYUc1cxHKCuDeuex9XoNbFR06XNCrDKSVbRpK7xISRkJluA
         kSR6o8bVc5Vvuaj67fj0y+XPmlq2rTr2vg+RMemTKzA+qtWyn78+0v+43JUKiT5TG+gG
         GH4sxoP/u/DzsE5PHvjQcvB1JEx9LAbCALYw4I4H0Xq2ZNqSNxxKBIDFfm+q+HuQRX1w
         W8Q8asEDk6pKpqW2YQwcoZLj4CBDfV7RUay7L8T+5ES2qllgsxYk7C+Rz+1RENq99s9N
         DaT4Fo5PylOazmFRP1mtWZsWZ1URFDmK2yiVi7cBglvdQKHhu5SQErawreAVh0fHQhrv
         PX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700471554; x=1701076354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+uIjKTA9mmQZQKmxMlAd6qDO2AL3fBqrTi9w8Ax8L4=;
        b=AISI25mGS93irvnVgZVXuKTkjK2KRNgeth/VIGMj1d6yVqKVSH3aJLBosM/kN3L25K
         5wpjpJtR6+0TEhWpwCulIskeGczOxrSyyRGVD7x0nutnKfMfvkr1ly1V8jo/0+6kJXFP
         bvSnuklUmib8VWu1Ps5sCzvYNfHl8WLhUhVCxWp0nkg30kgVpWkxLNozvRMEuveR2LZu
         T4XfjYOq4mCXBnPCuHfD8s1+04Fnr1epLwCpcy1GhqkCz4lWBDEuv8x7672pNnFQAUgR
         rvI7vRF6e+/WujSXDvEmV6H0ZCmOnQHaGRLD/95oWq0DfbRZ267dMe4MXd4fFocig63t
         XVTQ==
X-Gm-Message-State: AOJu0YzxTihCtBTUWpaao3cC0Kxfk/IYsJEovBn1v97FU1eeE4XpgZB8
	oxMi+GGx/xHlyHNs2KA0vBp+nDouJMXlX+hS6w07YzXZWkxNE+kKiQw=
X-Google-Smtp-Source: AGHT+IEbhC/aygyIj+7Ih6+zR3HZ33Ymlg1pevcu+ZQr6eHBWkaL8T2epFCMqEDE8zKj78dMGKrK/UVIWhVZUlvzohw=
X-Received: by 2002:a05:600c:12c9:b0:404:7462:1f87 with SMTP id
 v9-20020a05600c12c900b0040474621f87mr196426wmd.6.1700471553706; Mon, 20 Nov
 2023 01:12:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116203449.2627525-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20231116203449.2627525-1-willemdebruijn.kernel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 Nov 2023 10:12:20 +0100
Message-ID: <CANn89iL0L4L8N40aiP9pQqerk3jy4zALOGjhHqvwpvyrMnzHZw@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: net: verify fq per-band packet limit
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, linux-kselftest@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 9:34=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> Commit 29f834aa326e ("net_sched: sch_fq: add 3 bands and WRR
> scheduling") introduces multiple traffic bands, and per-band maximum
> packet count.
>
> Per-band limits ensures that packets in one class cannot fill the
> entire qdisc and so cause DoS to the traffic in the other classes.
>
> Verify this behavior:
>   1. set the limit to 10 per band
>   2. send 20 pkts on band A: verify that 10 are queued, 10 dropped
>   3. send 20 pkts on band A: verify that  0 are queued, 20 dropped
>   4. send 20 pkts on band B: verify that 10 are queued, 10 dropped
>
>

...

> Signed-off-by: Willem de Bruijn <willemb@google.com>
> ---

Thanks Willem for upstreaming this test.

Reviewed-by: Eric Dumazet <edumazet@google.com>

