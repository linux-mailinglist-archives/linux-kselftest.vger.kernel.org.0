Return-Path: <linux-kselftest+bounces-17245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5FD96DCA3
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 16:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F74A1C21F2A
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 14:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C965D7F7FC;
	Thu,  5 Sep 2024 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRK90PkT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BA8745F4;
	Thu,  5 Sep 2024 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547998; cv=none; b=Rkjc5ngXMDOoZSSaY+o8Qas+eO/HYnaAaXU2fNQESA9ZuJye+dLru4PTNwDnNmOT6dhxhbcWSTeSoqWhv0pI8WHfed6OUGVFApulmGuRVAbP2rbomKk7j15qH6o18eYDoAZ5PvFJZfGeFqLEROTRg+WCfPe2Zi0gIkv6Zp0GP4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547998; c=relaxed/simple;
	bh=RadwLKNeIwoypi7LoiEYWn+1p8BB8z+3Fbf00DhxKGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZZasnfi4BEhWYzSSxNGTfxDfTXkJqjF1NUxif61tVt5dynLuWEUgmhbqQcg1bNDyS3MDkaGl/kjK3o3+UgdTgZZwIECL4FPZKBB7QqK31sLXvfbiWGxvV6vYFqpUi7cKbfgl2BdVvCFiPHlu2KuJ8Sh1sAYg4jDLu1faL1zIJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRK90PkT; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82a205810ccso36178739f.2;
        Thu, 05 Sep 2024 07:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725547996; x=1726152796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RadwLKNeIwoypi7LoiEYWn+1p8BB8z+3Fbf00DhxKGc=;
        b=iRK90PkTAdbOhJPrJ1Dp6Cr+vFdXM7tR5L83VlsFPQZzwPOO15W1AaYJf5F7aepAqj
         abWHxCfeNcz4EqD4Hj4wvYC3snTCnNZfPMgzDo6Mj/BKEhwgMM2BasjZ2ypgM00/fRY/
         lBlRto++p7VIcWLNc5QQYzrCGtwKqdJYLwnp8kdquhzUJjJdyAsMnWqeyZ6+z29XuOI+
         aQJx2uVuNY1pkbpyeTdtVM7R492vbUiiiadzv1C8kv5XA7rnkKznb3Wb8Ky5GKeziJ49
         ywJvjuK4fuAz1LPeulGrw5s/UL5dkAODCfStO0OdFowh67liLKERetZDTY1L5nRO9kBO
         DFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725547996; x=1726152796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RadwLKNeIwoypi7LoiEYWn+1p8BB8z+3Fbf00DhxKGc=;
        b=r9RslIVSHLMiOPLZPAptcDJkN8XRrJF8O64UELL1mpKlQDIH5BZ5nLpNYJIQk6JIjH
         5yoNH4WUx5RFHKxzzngl2ghz6p4NHw2AuDjNdFyK4kCQslxv8hm1vsldZNQiQxNtqIdv
         46kj0TdL7SsnMPsQFsOOvxL+Odyp2YKtjxSmYc/YhGjSju4DToVAhPG3cclvjrlaJq0H
         JR3BS/MDskvcqxHYm3azuPhew2k1ktfOoYE6p80FEt9ggyI4IAnifBypUVWCKeiOMRvh
         l93eaaAMjME5N50aHuoEQwL1CMJkD01PnlVrCQPWAGVqbMus7AzpFqxx0P7p+cW7Odc/
         4tcA==
X-Forwarded-Encrypted: i=1; AJvYcCX4NB+zLJR0x3EvbJuWusSRCuv+otBvZsGvOTM2wkUeKQG/zOaB2wb4xt5U2bVpjbp71RyWf9Lb@vger.kernel.org, AJvYcCXhRnwlb5aSO1ZCYEVZ+dWbvoS/UVjLQ9ISxtTDaf+m5g7WALuiB/4Rirq50jssFVGRzhP7saqLWfYhTXRAXsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZemZpYPUx57oogRHaUpRD8ypSoXeEo6gvs0OW7GYy2rct10zL
	2OBIXtjNPf/aQzKngYxS0urZkBBX1T0AEq77vFFnUcR4yITbkM/j1v5bMWAynYWDolXtmTczjDV
	nIXns/eJMPk5o3wUouVePi+bdh+4=
X-Google-Smtp-Source: AGHT+IFiCksR5K86arDZQ7pqc6Wqu6c3eW4Hi3i2XP44T/6QLFxnfofcYcZCdVZkBQmKJZt0nfQd1Ymg5ZzF8Hz67kE=
X-Received: by 2002:a92:b709:0:b0:37a:7662:7591 with SMTP id
 e9e14a558f8ab-39f4f516a8bmr177078285ab.6.1725547996074; Thu, 05 Sep 2024
 07:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905071738.3725-1-kerneljasonxing@gmail.com>
 <20240905071738.3725-3-kerneljasonxing@gmail.com> <66d9b467d02d3_18ac2129427@willemb.c.googlers.com.notmuch>
 <CAL+tcoCfPSRaXhLMipeaebn58Knzan4gguEtfeWHXau=0eAwhA@mail.gmail.com> <66d9c3f875b90_18de412948b@willemb.c.googlers.com.notmuch>
In-Reply-To: <66d9c3f875b90_18de412948b@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 5 Sep 2024 22:52:39 +0800
Message-ID: <CAL+tcoAxdbOfHWEoCx5JrBCWkmu3yGy4t6pkf2=2KuP6KAnbvA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/4] net-timestamp: correct the use of SOF_TIMESTAMPING_RAW_HARDWARE
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, shuah@kernel.org, willemb@google.com, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 10:45=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Thu, Sep 5, 2024 at 9:38=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > SOF_TIMESTAMPING_RAW_HARDWARE is a report flag which passes the
> > > > timestamps generated by either SOF_TIMESTAMPING_TX_HARDWARE or
> > > > SOF_TIMESTAMPING_RX_HARDWARE to the userspace all the time.
> > > >
> > > > So let us revise the doc here.
> > > >
> > > > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > >
> > > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > >
> > > As an exception to the rule, as a one word fix, can be squashed into
> > > the feature patch, I think.
> > >
> > > > ---
> > > > Link: https://lore.kernel.org/all/66d8c21d3042a_163d93294cb@willemb=
.c.googlers.com.notmuch/
> > >
> > > Please put these at the top of the Suggested-by/Signed-off-by/..-by
> > > block. Their more useful to future readers than to current followers
> > > of the mailing list.
> >
> > But I have to ask if it looks a little messy if the first patch will
> > grow much bigger than before with adding some suggested-by tags and
> > links, and a separate paragraph to explain why we touch the doc...
> >
> > Cooking one patch which saves my much energy is surely easier for me
> > but not for readers probably, I assume.
>
> Ok. This small patch can even be stand-alone. No need for a series.
>

Got it. I will send it as a standalone patch tomorrow since I need to
wait more than 24 hours.

