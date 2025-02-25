Return-Path: <linux-kselftest+bounces-27521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC318A44A48
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 19:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989984232FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC8020DD7A;
	Tue, 25 Feb 2025 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6JbI9ua"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18F519E998;
	Tue, 25 Feb 2025 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507895; cv=none; b=jsWN3U8gxm+kkcQm9DwiVhxB0uWM4+7Qeo5qtIG9dxJqlG6TAS0ZODe0D/qoz3Vi8GQUeFqLGT22GvMWMgnw+0aPYWPeEi6DQn2ldgvm6I6U+ELTWiONxxDeUYeSnSescEFDVnERg11YAri+sg2yZnJ426rpJGqC/EwVTN3L72o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507895; c=relaxed/simple;
	bh=e12//0ouSuYLnVYPUmLDp7+6wElM0flmFydsFm2XJB0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hUUd2+hUgBMKXqlS52REur/RlOAOqNl+LusF2aV1ud1dJ7qJ+oUQuuwEGME+JBzEAlYszX6v4xLNx5riWjEganexhR1U1XID1ZHIMjBljUASAl678LTf1T7imgEZwNQm61x22fcBwDzxfBf7l9IVZvtnJ+AjN3m+X9cnQelOHlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6JbI9ua; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c0893f9aa6so536043785a.1;
        Tue, 25 Feb 2025 10:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740507893; x=1741112693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IN/wgdM/wrAvot6cEOXlKkAGhjZU8WUV09Vtdsf31A=;
        b=c6JbI9ua2p+yguKTnsQTJIll2cOZALrC9flTAvd9hT61Y9FK6fc4mqYekP+8JPs1Er
         q2AIz1MkE8kG1pWMqbJO+jzgS6x557F/MAN6KcpxzOWdUFP/5aEhedJdUYJcZWuLrHhg
         6Hi+GewAEitXcy2WxzK0KlsnlYLy9MH3H6bi1DzS0t0r3eBCg/8ZRE57pMfEjstLy/OG
         5/bVutjhEHPDGam7zXVexCa5edBZEWI6aOOTvRuvCXy/r2be9hOY8LTrToPP/ndW+aJa
         Z48F8Gs/zj9H46eWbxsOP2jyQfqe4VldFkozVmFwafd8fZK8quazRSHAV0Xgq05rLK5F
         lAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740507893; x=1741112693;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0IN/wgdM/wrAvot6cEOXlKkAGhjZU8WUV09Vtdsf31A=;
        b=isV4E2Z4F+gcbZW3xDBh+0ThSIrOd4iJjskox/SmXD+8ts4slqHFiFo4rw19G3P4QV
         uG3CU/pB+7L7QxlQMdL9D3tm1OgyYxhyUc66KgDqU9OFbllT/VlQydOYS1wgC22wqGgb
         An7D2JjBLePcwH686ZTluVlUxWtZ07Xrdeo+IQTEpuc9gaTpeB7TRMZRq1SFEfADUeGX
         JlmZDy9AlujUot6LCkuGgxJ5zJhOsjdIe1mfAuOzX6kSSY0qYKClTR3lDCxHFNZbX2V5
         XvjUv4xgLYw14vrumHipWYKtnM1JUso12x6aZuWliAtseo+I4oxlfnGzxHOqTnfJkM0D
         vZrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUna2ahw/ydT11CM4/9aQMdJvO+noYhCNJyjyX/bQtMogpqKPHczwbcV9a78CojU/gfNprIcRHitP2fN59Y@vger.kernel.org, AJvYcCWEOkNQT48rH1lJMcLMn4SqBBlZRyO8qNt1F2yFmr0Xx+vZI31BTSKp9lw6XN60TAq29OiTr7Yg1eq7tGTwF4tU@vger.kernel.org, AJvYcCWNckhL/asMZDppNK0KVb6dujC08n1ouAUYE6xCWiIS3lAWiMT5e2vSy7FLLYRkNwaxXww=@vger.kernel.org, AJvYcCXFEKK8S5OtV0/ZRPzFPuNK0tZ1EJgHddRTdIBrAQI6+HuN8JqHQO5vKEHDfHnmDH4L7QCgxix3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw15cYT4PD3kygaKxjXVVrGml0/HhJLyBaKKAwPpka1fx05gt95
	RjTnIPehFTjwxlMJXI6Oz8cgzrFNueRwQTNFn287n5YRUC99PvdN
X-Gm-Gg: ASbGncsKrcxNmdvz9Yl9OFkmDtQPmBBKRowv6kqawcMD/DvApnPGuYn+iXa64sJRGQM
	Kfb4brRCqHl1439CwjmF1jEUrgx7uiErk5fm/q/wqBHvwAHWK6ZQjmKxE77Do/ebFnwCAzVGQ4P
	fjF6ZHUNTc+ldMkHPh40dZgnValGV0g1J9/VzHuSvipfu3+BiFbtY5X569sylltkSunBarP3AGE
	HSsxq8eCtrYODOKPcA1R2SX0NPn1JCJYyflYNpNWkdrZWSEMhozUurWcegwfq2HLlpxgh6VMIhE
	Ke9vmdJbpHt8CsxOb9K+r5BTzSWWx8N0AgpmAyXywI+EgHo3cj2sZDEpvdXwakbKv/jIp1LD64m
	sFIk=
X-Google-Smtp-Source: AGHT+IE0uqadArm2YyxmryYO6uV+0djUKpmQp6U0wfVS3CUcxbQVu8M6YUav4D1eNxARKeUZWioYCA==
X-Received: by 2002:a05:620a:4148:b0:7c0:9f12:2b90 with SMTP id af79cd13be357-7c0cf8aea46mr2519889085a.6.1740507892562;
        Tue, 25 Feb 2025 10:24:52 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c329847sm136097285a.74.2025.02.25.10.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 10:24:51 -0800 (PST)
Date: Tue, 25 Feb 2025 13:24:51 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 mykolal@fb.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@linux.dev, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 hawk@kernel.org, 
 marcus.wichelmann@hetzner-cloud.de
Message-ID: <67be0af39dbf7_25ccfc2943c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250224152909.3911544-7-marcus.wichelmann@hetzner-cloud.de>
References: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de>
 <20250224152909.3911544-7-marcus.wichelmann@hetzner-cloud.de>
Subject: Re: [PATCH bpf-next v3 6/6] selftests/bpf: fix file descriptor
 assertion in open_tuntap helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Marcus Wichelmann wrote:
> The open_tuntap helper function uses open() to get a file descriptor for
> /dev/net/tun.
> 
> The open(2) manpage writes this about its return value:
> 
>   On success, open(), openat(), and creat() return the new file
>   descriptor (a nonnegative integer).  On error, -1 is returned and
>   errno is set to indicate the error.
> 
> This means that the fd > 0 assertion in the open_tuntap helper is
> incorrect and should rather check for fd >= 0.
> 
> When running the BPF selftests locally, this incorrect assertion was not
> an issue, but the BPF kernel-patches CI failed because of this:
> 
>   open_tuntap:FAIL:open(/dev/net/tun) unexpected open(/dev/net/tun):
>   actual 0 <= expected 0
> 
> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>

Reviewed-by: Willem de Bruijn <willemb@google.com>

