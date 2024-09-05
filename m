Return-Path: <linux-kselftest+bounces-17237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F9896DA83
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 15:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934C21F222B2
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 13:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AE119CD19;
	Thu,  5 Sep 2024 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMHSmfyI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF121E487;
	Thu,  5 Sep 2024 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543531; cv=none; b=iGKsSTVMpbPDpn3QxXlbRpitucI1yku/7ciIuMOuglklJQFT0u2nZ7qeBpvSDRNHqFi63QkNa70XCHrRGFz3WSlVLlMvGFWYEebMtTf2voKspbAv2p3bxujS+xvCIMfwc3LxC9QnRPx4Hv3ABvzlFvtrOf79gQXFc6cZbfFcChg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543531; c=relaxed/simple;
	bh=NLI4YXBOvKNdOh0CHIhsEHoTRJKK1WBg8REqep/zUvI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sk4RbokZDoT+o760UjmlcG8FpUeDH84CJw6PZpFgcB9w2Kjw0vWf1aKOPuhQs3ZSPS1W6yTOSWYo9HTu0tz8+XFVF+qtboQqpd05yo4APApxnZOX+g6m/D77X3M0cT4xhnXdOM/zckJ5Sy4AE+GNYJ7D/ncyb+6qf05MlfpZBNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMHSmfyI; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a7fef9a5fdso78176585a.1;
        Thu, 05 Sep 2024 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725543529; x=1726148329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjhSxFYCkr8rnda0l2t/cT0nS4CMqkRkbRMVRHs+lTY=;
        b=lMHSmfyID9mTKZLfBoTkugtgxK0UyQhuI8JD8l6oEqN71C3E+Okc0dONaGsPBrzS8P
         mnh6vubY5QNwPiR40b3jsT+o9fh5gbA7J2owxyq+M/eRn0CJ/89IZOTlQSBjIe9uPILD
         bNX5i2OGtuw28ZG5v4xVl3m1jzUO/XCg+l/POrQXzo+ukCsMvUj6ivZJewWY8eb/6F23
         mBDN4NmLwElaYKrtTDr82BRkL0T9L/oKCOLDzEx0XTB/yhPaI04cw0bmmZmH2484wOHP
         ExZe1l9uwQyrI7MuKYV516N+NtVuvrniljHHbMQAsIdApEfpGv2xEbWW9WaEcGKMGiQz
         gY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725543529; x=1726148329;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xjhSxFYCkr8rnda0l2t/cT0nS4CMqkRkbRMVRHs+lTY=;
        b=LLJwZZSrbTco2OWcYLq57e0ykEEifmIVxe5ea9XNJGo2aRo+JOO0G3h0h1TMiVnpID
         QjMaLjhf0ktnD+TX5soACCJN82hKm1BBiAvEMP0iHRS1gx+WnrcbWn8yqKDLs35e3r/V
         8CMWShYQSPbD3alvnVVWL8hRaO2q4UW/iezDkaCyathGjDijmSNE9hv4NllaYRQpck4a
         De6AoM1dCFDS2PBEadD+y0nKkSTxuj9rQ55USnsv/g59c+gn3d0u2J4CdAI1hNZeEftj
         rA1U8YmFLt9+vqOcBRGPGyc5vbebEb/R+apDneOtpfRuuL61w0oWkbNG5JrRNRxXurSA
         l5XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKwIk5Jgcg/LyD2+65ivdNrveqclM6Aeil49xoY+LfjS07k6v0siHN22OH2j4sn4U9ShnN+6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdc72bccdcSAd2iNwarxYvLyV+ghwRhp/diLXHfnmbCL3aeRnf
	x4qy2beALOUfnwxotKfpruEZPauJlrwYXAy3VrMYBzDUX4vw5SJm
X-Google-Smtp-Source: AGHT+IErV/ynmOl+/W3l4qa0XC5MadoX05dBge7jLjTwMl/XLffZ+Pke9+NZaWhOWrQwr61lK0eLnw==
X-Received: by 2002:a05:620a:190f:b0:79f:4c8:d873 with SMTP id af79cd13be357-7a9888e5bb8mr1046040285a.28.1725543528733;
        Thu, 05 Sep 2024 06:38:48 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98ef1e6efsm75907385a.23.2024.09.05.06.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 06:38:48 -0700 (PDT)
Date: Thu, 05 Sep 2024 09:38:47 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 shuah@kernel.org, 
 willemb@google.com
Cc: linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66d9b467d02d3_18ac2129427@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240905071738.3725-3-kerneljasonxing@gmail.com>
References: <20240905071738.3725-1-kerneljasonxing@gmail.com>
 <20240905071738.3725-3-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v4 2/4] net-timestamp: correct the use of
 SOF_TIMESTAMPING_RAW_HARDWARE
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> SOF_TIMESTAMPING_RAW_HARDWARE is a report flag which passes the
> timestamps generated by either SOF_TIMESTAMPING_TX_HARDWARE or
> SOF_TIMESTAMPING_RX_HARDWARE to the userspace all the time.
> 
> So let us revise the doc here.
> 
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

As an exception to the rule, as a one word fix, can be squashed into
the feature patch, I think.

> ---
> Link: https://lore.kernel.org/all/66d8c21d3042a_163d93294cb@willemb.c.googlers.com.notmuch/

Please put these at the top of the Suggested-by/Signed-off-by/..-by
block. Their more useful to future readers than to current followers
of the mailing list.

