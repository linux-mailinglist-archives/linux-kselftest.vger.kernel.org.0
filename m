Return-Path: <linux-kselftest+bounces-17242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49A996DB0B
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 16:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17E8AB22DD3
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 14:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC67219E7D0;
	Thu,  5 Sep 2024 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jpb8KV5T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D98C19DF69;
	Thu,  5 Sep 2024 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545004; cv=none; b=EMWBwUPltLw5B1iEr/SzkgmXY6FQfdr5apxCwzzV58K4XxCJ2br0PLl4e83Qsw8iikPTZaZiwobFFeN9bqFgPctRURy975QYb91DYXRW8QUsbbbV92KCJeJmN7eJYrcfEO3Z3hN2dTrnbqE/PeOKIXxjGHgbnMx59dfGcZJkikg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545004; c=relaxed/simple;
	bh=KIfsWXq8IGdK38T55NYxpRUqODAKTjDd+rDbD2eR0ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEBTH9eJ9utSn0KDPAA86aPLwdpoOJlb4W8CU0ijI/caB61e6cAfJ3DBdcSH8FAfMYS0Gw49TH5kVr9r3PjcZnCMT0q/2hSwDf7yoncgso4gVYiWh0Pd4/DgVtjJByFT4Tf4Mna7GvYNk2HZxu3nQpBtdSnzhf1cGdsO0HE9bQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jpb8KV5T; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39d3872e542so3173525ab.2;
        Thu, 05 Sep 2024 07:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725545002; x=1726149802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIfsWXq8IGdK38T55NYxpRUqODAKTjDd+rDbD2eR0ic=;
        b=Jpb8KV5T3EcNZB+KgwoXgxlNNxo2tCeLk5AEqESbevTMQf8aFtjb12HH7gwLkOPaZB
         7DwGWCFDMjsYxYKvkRUIDC4ZDSrZM8q6kbEbCS7xcYlOK7UH1LlUv2TTQHIxgHpLuAtG
         ofD3s+kFUo6kpg1il5WET1qzdtdKs4Ck6DLkUVc8O/oR8D7SwnQEu5REkLuGF13xDfVU
         ZTMfwe0pXE5T63G3Mqat6YzKNE7+NVnDNixfhxIKUGfvsJeGC3NIWHHu30FSYy5tx1Pe
         rLi70KR8wI09ymXI5PO70lgcGVEleLFIz7Sjf82DNyNRSPgF15IOrbCaMpYzQ2PXLLjT
         Fy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725545002; x=1726149802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIfsWXq8IGdK38T55NYxpRUqODAKTjDd+rDbD2eR0ic=;
        b=eLmVI0pHarN/U67F4dYpvWc3syVBtRQ8OUJJ0+OMg46S52++Wu93D+Rvl+IpPpwxL0
         W4msQOr5tqBMqvfcdZsw4TzoiVZSgHChvCGYBifcv/rWuq6hy/gkjmF9SYZMayFTjISN
         JXxguyPfN/w/SGWroJy5+dvw7hPwFbubqJRD+4cxNqqLabl4AYWvCR8drVQNCpEQ+71h
         K9QfODUS7bljHZrStn8q3vadCdrpcRHfxc4Y0Z+SPZkT8VchpQecmUD9cvIRZFiB02o9
         1SB0FHiKw9vAnDfu3Uy/27r888AZKakLwZCAP+TsKHT3ex/MoNDy86vNu5f3GLd4nfQ7
         A8gw==
X-Forwarded-Encrypted: i=1; AJvYcCVbP2GPOk0y6z1RGBW2LCuHxJp5IiMhrEJHP4n695IlQLfb83pP1SGw7RoUzuVVKWA4plwWb6dr@vger.kernel.org, AJvYcCVdlYalwbZ4Vh+bov0at+DEtP08o8gjKGhIVSwuw4HA21dbsln8OyVGRkysv8KJhO1bB95BkYuvT72JQBI89G4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ayzABNr5KjRehciP2qcHMLn7DzVF14ovzfwzflyzR18yQS1v
	LZ4VEvpFEzE11QK1Td0088aX9tJe/226Q0KGoe5SHGz7qXYcl1FITcxOSAycoH+oJkDYzgMdCQH
	jWSOLMMxrslwdqIU9K0DI5fF7q2s=
X-Google-Smtp-Source: AGHT+IHwSegkGhNccLhrxaCIESlV2GTjpUQBB+Ev6/6ZpP/HCi4GQc1Sed9cVcGzdVUq5Wm+xLgyYVp3gBt2pb8vvdc=
X-Received: by 2002:a05:6e02:1fcf:b0:375:a5de:5d46 with SMTP id
 e9e14a558f8ab-39f4f516a96mr211255255ab.5.1725545002521; Thu, 05 Sep 2024
 07:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905071738.3725-1-kerneljasonxing@gmail.com>
 <20240905071738.3725-3-kerneljasonxing@gmail.com> <66d9b467d02d3_18ac2129427@willemb.c.googlers.com.notmuch>
In-Reply-To: <66d9b467d02d3_18ac2129427@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 5 Sep 2024 22:02:46 +0800
Message-ID: <CAL+tcoCfPSRaXhLMipeaebn58Knzan4gguEtfeWHXau=0eAwhA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/4] net-timestamp: correct the use of SOF_TIMESTAMPING_RAW_HARDWARE
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, shuah@kernel.org, willemb@google.com, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 9:38=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > SOF_TIMESTAMPING_RAW_HARDWARE is a report flag which passes the
> > timestamps generated by either SOF_TIMESTAMPING_TX_HARDWARE or
> > SOF_TIMESTAMPING_RX_HARDWARE to the userspace all the time.
> >
> > So let us revise the doc here.
> >
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
>
> As an exception to the rule, as a one word fix, can be squashed into
> the feature patch, I think.
>
> > ---
> > Link: https://lore.kernel.org/all/66d8c21d3042a_163d93294cb@willemb.c.g=
ooglers.com.notmuch/
>
> Please put these at the top of the Suggested-by/Signed-off-by/..-by
> block. Their more useful to future readers than to current followers
> of the mailing list.

But I have to ask if it looks a little messy if the first patch will
grow much bigger than before with adding some suggested-by tags and
links, and a separate paragraph to explain why we touch the doc...

Cooking one patch which saves my much energy is surely easier for me
but not for readers probably, I assume.

Thanks,
Jason

