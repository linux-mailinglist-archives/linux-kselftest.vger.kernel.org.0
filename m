Return-Path: <linux-kselftest+bounces-14583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87199438B8
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 00:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C106283D90
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 22:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF9016C86D;
	Wed, 31 Jul 2024 22:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aghJxYb9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA4B433B1;
	Wed, 31 Jul 2024 22:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722464439; cv=none; b=HXkcTvzqw6kxrM3Gz59kku6TCa8czPO4k7EZWcQMcoZD/nJ+O5TL/aOH1FIgpc42P5eGFmYXoRArAi3lHtT+vJK1lHclzSuN97qNKKjapZgiLjHeM5IAEukmH3O5pRNVX/rwjrF+/JbOzV1LnibMilT3CmXJpPH3mRrrko139I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722464439; c=relaxed/simple;
	bh=1KHTNx3zHW1OAbXxP8Wfv93PuXa0Ex/IbY9P9htr83s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Kt/Lkw/Rma2SYSawpowb54+csnghjwu5UWSPjK6fvdztoz8dGgaxNlUJIVfCM3GrUGSA+txU8o/cxFCRKGgLM1u1iu68O6r6+cLxAbjoWm+qBRfGJihsD1qHMr9xSPmlDSnK57WQSIxlqIo0Rz9QbwyZCb/eXNHg/lPSn9YqPEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aghJxYb9; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b79fc76d03so35219886d6.1;
        Wed, 31 Jul 2024 15:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722464436; x=1723069236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoDwoN0b06NlwveibeSSY/sr1v6lbKFi/ZJRMvzAmSw=;
        b=aghJxYb9dXX9ynNcujMeLkPB7u3JoNpSzTmm/8+aJV0zirtclG4+Qr0dlDUH0ADKqb
         YcxaoZcFljZz7aNsh3XSWQEebyOi61/lvxD0iEyg5rO5huAzJWXF3scMbkTrrf1RaDIj
         YPVrQS8MmQ+kecVSWVhFaRwi+6FmSHmJR66xu5dv+GvgmxUEFlEhLz2hJ+wtZ19a1jK2
         rEVDxDmH0vHAAi4i3FprssE8BSGxOFJLOLOG/BWfsApXmDJVOWHYloZMBzqez8fLscNM
         8kVMlOCxqUky14R/4zGdJTTKiCrYXZBvqij7d2u7xdaNCFWxvFjm28bjOsy9IxJJPa6i
         pnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722464436; x=1723069236;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SoDwoN0b06NlwveibeSSY/sr1v6lbKFi/ZJRMvzAmSw=;
        b=MLHJg2/Hh/vHIVjoZ54oQztcSkcVs658yQc4VeijJm5mLDYZFl81ag7EZ3ko6M/Z2R
         IM7euyA7eJyHyJRMnW7GDZ6gQc75fUZTyFV2FxfMuFhKf1xkmms4GDUNm1sdnqt0kmH4
         dmUET8p3sBAqmuObeualdmmPw5CPdyfavQrOQFAtZ3k+P4qW//i2mk9FRtxQyNtoe1dJ
         GWunbAuXdWECICYFZhH1wh3O6y0/bh4EUcsFOb3gRkOOl/6MfbKUDU6X7xw5j4Mv5AZH
         snRkh/llL3khtpMyTvaw/HpWF44yztTQym8viwMsy50bIPFrJna6WsprVLdMfQ6In9tF
         lRrA==
X-Forwarded-Encrypted: i=1; AJvYcCUWnq5jyKWyHFqavz4ytCl4KqWLpg5X42Z+42t3G7kuJUhM0RwWsVkVS7CpDn1MJIxWnTIsuvva/fyrkRYSpPJCvU8qEZgOLX3NIw6E9LOhMSNfTR1NfConM9mY0bmKayTs+Qq5pKyQ
X-Gm-Message-State: AOJu0Yz83z1D7NS0S3WaK7m7XbCGOROvR2OEZYa6kr0Fak7hyPf91TfH
	4TFz/Uf8ug7Geot7O/y5xRmW52uJKl7uKUkWojJMCXBXaHUKY2/m
X-Google-Smtp-Source: AGHT+IFaDv5XUBemzXUXgWR5rOVTTABOsmDyG7pKywABkh0dl77FGHyBNK/mMHso504F9LSLhnmqfQ==
X-Received: by 2002:a05:6214:5544:b0:6b9:607e:275e with SMTP id 6a1803df08f44-6bb8d7e22demr6254756d6.34.1722464436245;
        Wed, 31 Jul 2024 15:20:36 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f906e9dsm79155536d6.50.2024.07.31.15.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 15:20:35 -0700 (PDT)
Date: Wed, 31 Jul 2024 18:20:35 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: zijianzhang@bytedance.com, 
 netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 almasrymina@google.com, 
 edumazet@google.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 axboe@kernel.dk, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 cong.wang@bytedance.com, 
 xiaochun.lu@bytedance.com, 
 Zijian Zhang <zijianzhang@bytedance.com>
Message-ID: <66aab8b37157d_21c08c2941@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240730184120.4089835-3-zijianzhang@bytedance.com>
References: <20240730184120.4089835-1-zijianzhang@bytedance.com>
 <20240730184120.4089835-3-zijianzhang@bytedance.com>
Subject: Re: [PATCH net-next v8 2/3] sock: add MSG_ZEROCOPY notification
 mechanism based on msg_control
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

zijianzhang@ wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> The MSG_ZEROCOPY flag enables copy avoidance for socket send calls.
> However, zerocopy is not a free lunch. Apart from the management of user
> pages, the combination of poll + recvmsg to receive notifications incurs
> unignorable overhead in the applications. We try to mitigate this overhead
> with a new notification mechanism based on msg_control. Leveraging the
> general framework to copy cmsgs to the user space, we copy zerocopy
> notifications to the user upon returning of sendmsgs.

May want to

- Explicitly state that receiving notifications on sendmsg is
  optional and existing recvmsg MSG_ERRQUEUE continues to work

- Include a very brief example of how this interface is used.
  Probably pseudo-code, as msghdr setup and CMSG processing are
  verbose operations

Btw patchwork shows red for patch 1/3 due to a new error or warning.
Not sure if it's a false positive, but take a look.
 
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>

> +/*
> + * zc_info is the struct used for the SCM_ZC_NOTIFICATION control message.
> + */
> +struct zc_info {
> +	__u32 size; /* size of the zc_info_elem arr */

Size is ambiguous, could mean byte size. Perhaps length, or number of
elements in arr[].

> +	struct zc_info_elem arr[];
> +};



