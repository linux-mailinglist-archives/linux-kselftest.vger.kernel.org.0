Return-Path: <linux-kselftest+bounces-48218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F774CF4DCD
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 18:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F480317EE39
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 16:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B2128B40E;
	Mon,  5 Jan 2026 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDbhuYD+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfTT5jWW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3233A27E056
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631437; cv=none; b=IbUmWuj40XCRZiWBzV+yc4yVT1Z7/KAQAx3HG5Y1v8dRPUKXo3yrX4V8jUlwxAXkfscku3O+B54/b6KPrrTP4ShS1Qaq3arEwKcxCvK/zi+dZSquHPId7s729ZQbk/XEJInwCaECba6YKGfmoH/H+EqDQdWRPgkfiYYwfQSGjSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631437; c=relaxed/simple;
	bh=V2RcMFWNxHXpx7Cbk1wLqeq5HUPDZY2CLps3fwdMAtY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VPFTpmRtPLYwwW8L52BdtjBTqHc6aixCRzRhKKZSpO8SOlL9KCWWCsSeJ2JArYfJyepVkcx1yUCs7VRHP3ZGhGJECodZAcx3oLcrPqn1PqFnIsEQjmHivPHkdVB69ztvDschVsi/q5XuvHZ4eF5mO0nKWe7ygB1vmhC0YNybrcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SDbhuYD+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BfTT5jWW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767631434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V2RcMFWNxHXpx7Cbk1wLqeq5HUPDZY2CLps3fwdMAtY=;
	b=SDbhuYD+zHAUYkGSI0OlEWCSzGeUpnfl+AiymGcVacGPTMAobII4Qs2vwmFG0ymq34KyTs
	Hz95amezKtI5AQeU9Ribddsw666lmJjh+prizyutxZKbyScT2/mD9LVXENGbCnUhgLla37
	x0IYEBWm9o2PBcJPeKpe78lGzIvM6PA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-zn8TrJVyO2u45PnQdUX3Ug-1; Mon, 05 Jan 2026 11:43:53 -0500
X-MC-Unique: zn8TrJVyO2u45PnQdUX3Ug-1
X-Mimecast-MFC-AGG-ID: zn8TrJVyO2u45PnQdUX3Ug_1767631432
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-64ba13b492aso99647a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 08:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767631432; x=1768236232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V2RcMFWNxHXpx7Cbk1wLqeq5HUPDZY2CLps3fwdMAtY=;
        b=BfTT5jWWW9XcWvj2mHWxy95/dLJmljmH225nTzmf9u01uoo+9HWhIKFHWalLCZq+Oo
         XXcCsC3sMvGWfXDw1G3idF6qakzRnpWdKQn7MszfbcmtxleLFQVdi359RqvqUmtqOWeM
         Zdmn5A9D/SZKOYilVIQWPq4Y+tzG6GtgU0+/OFC5dN6efNxIuXhLEopShYsuDXWUqwJB
         kaRjDqLsHMx7CK41m8C7oa2wLcez1cYUFD1nqeG3pmjGCi46tanzzjphD3bXCqvsfqNt
         udlNwWdAiOVT35KkUM0bus6VfS9XUXeL+u0u0dpkKKOegkhFVnUhuWrki729FpconX2d
         7HjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767631432; x=1768236232;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V2RcMFWNxHXpx7Cbk1wLqeq5HUPDZY2CLps3fwdMAtY=;
        b=emHh/Jz425k/zr941z8aHCS/9niKfyecLDgGXs46F5lTqlcxQTB8H80iWrMd0fb6IE
         hd+gT7NCmN8Nf5sI3ZT6JKTTZtNxgh7KghuZ7zdobCj/bYOuTfckSsI/zkcK1O3xRzgc
         Lbmp4jIe2CqVaIy2ZPcJDW/MkkxRlPBNM56bIYr+NBAioEpXjZK5xRvFN5IrMZb0D58D
         E9QXdDHs4rFzkQxtypYWsM0vYni45gx7Ow61pZx/VqP9ksqxrfEbst3a8cfpJ6PmRMzZ
         mN99IXRcJ2lO+x+ArSJZcUNLInXbRgHLLEYe6WF/bemy0RlNheayF4oHi+6pfzMP1PJZ
         GmPg==
X-Forwarded-Encrypted: i=1; AJvYcCWoOIuVFKmjQcZSV4kC5/4TUy5Rv3UHkopZA0jML7l5eJ2HiKOeZza/rR1Do/WSIYo33EZBYBJMxJfg9Ij5odg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbuhgzJgu7oYjKwDj/qxFN/hEiLJgh3Y+zoT3EZQYnTW7eU7Xq
	XjNXPm3/9S7vXjBcLwAmwkB9ye8KvcFRaZ31PWlba8wIL/TAs4w+QUJJ2TkMvaZ+W9+9sczab/k
	aWY6krXaiMiZjeELH/Ot9L4eIBy827LOKlcCN0em8X5wkNvUj7XshSfjQcm0V29nR9hqnOA==
X-Gm-Gg: AY/fxX6mqXsmXMMUtRHlpeznS3nQiE2ki8C8QzQ7lN6uQ7w6jAwvFiU4hKWC8V9cjty
	naX0OBlNd3rmkz+qndjBsSLNG7jUQ33k4lJJrX5JGkSW4AKU8KDzXw4JZs7lqPXFzWOWgXoxwJa
	lkkoimVuS8u+Nko2kHtHUaf7uAMqzdPOS5DN0cW2sAL4pmp6l7eMeIA22vB6y3SZk+TjAS/EHWh
	VYneMtYzMYJ0XsgoU06r5fzBOcZXQ12YQD72esC9l9nv2Uyq9xIuw09D/4jNGvAPoRL4iPj+Ybg
	g2BqjDJTZkzPENp/4liefMPC5VDi6KpBQ5MX/nlUtaxEC3OCyr1VJjAgtmwba9twe3MSL1CtkyK
	3Dpa6uDsgHKvnJbbXDRdtRd19bqSUJudgoL83
X-Received: by 2002:a05:6402:4414:b0:64b:ea6b:a884 with SMTP id 4fb4d7f45d1cf-65079561d9amr39814a12.17.1767631431879;
        Mon, 05 Jan 2026 08:43:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5+CYTAwrLc8azSOHqieZ/AYKr+pOh1WCTsnwOkUqmz4srueS6d/oRRO9LBMmPRJORe96YbQ==
X-Received: by 2002:a05:6402:4414:b0:64b:ea6b:a884 with SMTP id 4fb4d7f45d1cf-65079561d9amr39766a12.17.1767631431378;
        Mon, 05 Jan 2026 08:43:51 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507618cc31sm222081a12.24.2026.01.05.08.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 08:43:50 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 18D1C407EDE; Mon, 05 Jan 2026 17:43:50 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, hawk@kernel.org, shuah@kernel.org,
 aleksander.lobakin@intel.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Yinhao Hu <dddddd@hust.edu.cn>, Kaiyan Mei <M202472210@hust.edu.cn>,
 Dongliang Mu <dzm91@hust.edu.cn>
Subject: Re: [PATCH bpf-next 1/2] bpf, test_run: Fix user-memory-access
 vulnerability for LIVE_FRAMES
In-Reply-To: <38dd70d77f8207395206564063b0a1a07dd1c6e7.camel@linux.dev>
References: <fa2be179-bad7-4ee3-8668-4903d1853461@hust.edu.cn>
 <20260104162350.347403-1-kafai.wan@linux.dev>
 <20260104162350.347403-2-kafai.wan@linux.dev> <87y0mc5obp.fsf@toke.dk>
 <38dd70d77f8207395206564063b0a1a07dd1c6e7.camel@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 05 Jan 2026 17:43:50 +0100
Message-ID: <87ms2s57sp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

KaFai Wan <kafai.wan@linux.dev> writes:

> On Mon, 2026-01-05 at 11:46 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> KaFai Wan <kafai.wan@linux.dev> writes:
>>=20
>> > This fix reverts to the original version and ensures data_hard_start
>> > correctly points to the xdp_frame structure, eliminating the security
>> > risk.
>>=20
>> This is wrong. We should just be checking the meta_len on input to
>> account for the size of xdp_frame. I'll send a patch.
>
> Current version the actual limit of the max input meta_len for live frame=
s is=20
> XDP_PACKET_HEADROOM - sizeof(struct xdp_frame), not
> XDP_PACKET_HEADROOM.

By "current version", you mean the patch I sent[0], right?

If so, that was deliberate: the stack limits the maximum data_meta size
to XDP_PACKET_HEADROOM - sizeof(struct xdp_frame), so there's no reason
not to do the same for bpf_prog_run(). And some chance that diverging
here will end up surfacing other bugs down the line.

-Toke

[0] https://lore.kernel.org/r/20260105114747.1358750-1-toke@redhat.com


