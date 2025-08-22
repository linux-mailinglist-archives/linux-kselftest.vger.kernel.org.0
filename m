Return-Path: <linux-kselftest+bounces-39763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 899E6B324E4
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 00:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8D21C27950
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 22:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336602836A3;
	Fri, 22 Aug 2025 22:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AH8iYHwm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A3927A90A;
	Fri, 22 Aug 2025 22:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755900867; cv=none; b=UXRHpMURNXfKw5TFLhLnBh86U/D8cZDs0wTYrGuBqx8IXD1ei9gcZh3mPLQjnQ4+loe4BMMqlkPhRxy4aYHWjzZ8GOfAYyNewVkVp0MXP6iYCGvCOByl3VjQa0INRCKg4z2nBWr/LKhRbq9A/O8T6W3+JpZ3LwE0sQq4L9EwX0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755900867; c=relaxed/simple;
	bh=HpjN9bytdAmuip/cywY2vIy4/1j1ueBGn4f5b3H0qSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFuK7NW/qVj7IfPZfYMzF2wjTgSMxBt5aEDj2H9JDd+QpOdlfaS3ZheLDKKxE9hTQsE0jxz8S0ckSntRnauq/KyyekXvr4IX3gIiRjkNRK3OCqOAxM8epDXef0KpjSTmiP0a1L2Nij9asbBiVLYT6ptKeUvGjxmZa+hyJ3Hnu7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AH8iYHwm; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b476c67c5easo1655613a12.0;
        Fri, 22 Aug 2025 15:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755900865; x=1756505665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xOxVFkxIIZB6/tB2dmGZklOHL/47OsZn8AgpIzTP3sI=;
        b=AH8iYHwmsmu355bYPRDd7OIFisWluokTPebiNaVO3D464x2n32ZqYUPzxJzNUwXLJY
         dmS2nqMM6O1zgqY8mka96Bi5nghnJKiMFUBrLR9kElC0954gLu4e9pmXGzu3x09G/dnM
         tHtkSq1WxCCdUNGHOTu26UfDE3VCgdq9WUB3TOnbuLSMyUvFu7ONChL4cy8CZFwrVpcF
         9jRt+f4AjjHR69lG88E/NzTKRurSWHOwwlS1pGJH9VDJzCNwfmohvoimE7y3GyKtwDam
         T9/S1KFUlS3aw9lJFWW7LBDXqAkxFZKIzmfGxc/jJqiCnoQnfBNLYQnoVxud+2eC+JBz
         D/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755900865; x=1756505665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOxVFkxIIZB6/tB2dmGZklOHL/47OsZn8AgpIzTP3sI=;
        b=QXTFsGf3LinSp9tyE/DG7WDOJ2z6xjXZxjiJuXTpIKkY/tavtdlfCrdfBX+ZuJVZBJ
         MZ0fx3pKz96PzyXKtwgGUKPxAk3Ql0oR4ONjuhP0mMtXNwnWAK0jKLy3kVa9ducsDhTd
         Df0aNAjz7tvMPDj1eEM+XHothyjzMnSeAiUWDzDaIqVUKBZu6YggcoLvtad0J65LRjZG
         g+b9A4jhPDUjqCBR55wjoV9WBR8fHRAcJRaEiypWcg+e57avgaCIxLIEQit8RNpjiZBe
         fiBN/ZUA26G+l9imtALW/s3fpaOOn3TlvSnCZ9mZpe3BubRSBRggWqSZJiSNp1IjPzuV
         iXdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtx2HgzddnO59o6uVPH1rVskO4wly+JzfWog8sosZM4tfNndIRBvl20nRzIah7hDCYUQD/ELh1gesTes/R1YY=@vger.kernel.org, AJvYcCXQlV+cG2ti3BSDHnkWE524SvGtebG/gyBcJ6LycJBFpgObvxy0rUE9FEGSZn7Jb24ui7H+mIYx@vger.kernel.org
X-Gm-Message-State: AOJu0YyRGfXLkkuevg8xLnhFPLxfL20vnynb++z2j8wAp0pLbnK7tGKD
	yEb5+974sHBB6rfKqBjGQSEKgzWkGwDqy0Qpx+IH2Y42cWh+KyvgFGFbgH9D
X-Gm-Gg: ASbGncsAOC/qOg+DH2Z7O7nXQRbhRKlHPXwkCdh48GfPql5MQrGtNDooPhD3wk0PC+j
	nMLpRe866DwPe0UM3KAlt/7sHHp0QrXxDmYfx7zjtKzbVXQtvsijZIm14eXxC9Nqtiv33PmMOo/
	GFQhYI7Hs2/z43XAlXlw7KilBOGqi2rNR6AxQ7ymtAqe/BZPhRS7qLCwI8ebNsAM9mW7NVfUw59
	SZ4BVqThvV8ag1F67L52Klg3Yn9ddknC1Z7CM1hfT1r/Kp6NQih5cFNLiehjqOylHev/T/ZkqHP
	6ZQ8xndxogm9P5t+ZSbeaQAeLSHFGHXHanAAFexBENk0B3pg9KNVWZvVq4hAp0rzwMBQ7NALtJ4
	hQXefdIxPstFl1nY7OfaIUTz27FbgYI3Bw6M3tx7SGp/MiLylwogpMGnWl0hV/MzEgsAia9dagU
	F8PXW2Kpzc0nd00XpP1407DdpF3HzYH3ilcbpjPRs3akLoLb7S6saXKxdQw141VTe45y8Bxx27N
	AWr
X-Google-Smtp-Source: AGHT+IFTJVFbb+zZKHcGdIrnQ9lL43uHQRURfRN6/tLFgd8PJ+M+yB6sCX1UQqe9UiJ4K+xNxCfNDQ==
X-Received: by 2002:a17:903:2441:b0:234:9fe1:8fc6 with SMTP id d9443c01a7336-2460245b12cmr107628055ad.18.1755900864881;
        Fri, 22 Aug 2025 15:14:24 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2466886479fsm5790115ad.75.2025.08.22.15.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 15:14:24 -0700 (PDT)
Date: Fri, 22 Aug 2025 15:14:24 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	almasrymina@google.com, sdf@fomichev.me, joe@dama.to,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] selftests: drv-net: ncdevmem: restore old
 channel config
Message-ID: <aKjrwJsQP1AUACYH@mini-arch>
References: <20250822200052.1675613-1-kuba@kernel.org>
 <20250822200052.1675613-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250822200052.1675613-4-kuba@kernel.org>

On 08/22, Jakub Kicinski wrote:
> In case changing channel count with provider bound succeeds
> unexpectedly - make sure we return to original settings.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../selftests/drivers/net/hw/ncdevmem.c       | 34 ++++++++++++-------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> index 8d9d579834b1..580b4459a840 100644
> --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> @@ -469,7 +469,7 @@ static void reset_rss(void)
>  	run_command("ethtool -X %s default >&2", ifname, start_queue);
>  }
>  
> -static int configure_channels(unsigned int rx, unsigned int tx)
> +static int check_changing_channels(unsigned int rx, unsigned int tx)

Good call on renaming!

