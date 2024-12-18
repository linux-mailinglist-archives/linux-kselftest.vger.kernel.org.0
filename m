Return-Path: <linux-kselftest+bounces-23494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914989F6261
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 11:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D9EF7A4648
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 10:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453D01991AF;
	Wed, 18 Dec 2024 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3gSTQZu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606CE198E69
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734516516; cv=none; b=my8g4BiaLqb3COMZTyz/7/akZCQPNmZj9h2DGmYiUdkH/Ias61OnxS9d02JNLfEhGJScgRtdlBO+d59wxup0aOIQH8z1PCzBCAeQ6ssvozoi9LFUCqEonqBYsTRTB2UmcR1+owP6jiAZ5+3RR9mk39hAGmD/CpH4bWKEBmpooh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734516516; c=relaxed/simple;
	bh=McJFBGRi73qOskvj2dJzcmMaMHZrowp+ckL4fxI8kEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+beESHIBeapHG7maZCDxLs1OaK3U3WcQDs6UpxBkKeW+a9JKTNfdwVzpnpxlQwDlkejzp0fI2zfmJJMVv9UtpoAnKCkZmHVZ97ZzayWnT1kfIq/TNbwl4HNnhFafsHzOYyrBtwqMVtlAyDJoqa8anXDwRfurih2YAfNCAocN04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b3gSTQZu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734516513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=28LtfQqtpdHfDU07S6WF6bvRxmpMXf24CtX5DCj2iy0=;
	b=b3gSTQZux+RKapAjzcgO2LUmkrNoJHKTU6ckJJqY6gS4C0b6U6UoZ5DvGqFgZCGYv6gEmI
	Bp0o/Bv7sU+7mgUR8y3xbzeR5zrDMk1Zqv6t4aiGGP7UjHE/ECOFoPifw0VXXK71djkEfw
	vUv5GRA7wVNiCfl2Dwk2b2jectB4QWo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-cGkI5xVcMk61VhaEobb4ug-1; Wed, 18 Dec 2024 05:08:32 -0500
X-MC-Unique: cGkI5xVcMk61VhaEobb4ug-1
X-Mimecast-MFC-AGG-ID: cGkI5xVcMk61VhaEobb4ug
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa68952272bso602815666b.2
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 02:08:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734516511; x=1735121311;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28LtfQqtpdHfDU07S6WF6bvRxmpMXf24CtX5DCj2iy0=;
        b=j5eBhhASLWVChcCECZOaYvTEHXS3g6Oj/3i+OgPb04GD11MJVEK3/9bxXGr57pwEQi
         R5BfIjj4vB2uZHjzPOy78xNQR/tCR0Rmp6yMJgsyn54WJ8M/75xcS9rceh+NEIns9BaO
         HV61HqR+QCnSajDZPHkIv/rU93ScLIG2Qij+Ec0ZLlBd6gEbAJXYGIzKgfsXiJ9K6XVX
         aaUWZF+eFHHxIOJ1EymO+5ob4EcxWUOZTo0O/FQ1p77dpmVUNUbq8ti+MtIL6csFeUfI
         3tlS1XV3vW2/xhykKU7jKvi6mvrSUhCM9LYji19N+H63dY8/uGWoGKq4JG7qCxwEk0ti
         esHQ==
X-Gm-Message-State: AOJu0YwdoDc0mr6XtKLlLTjTnJJKaCp/02AQmiLtijONxJaqNxaelA4b
	2SRCmuT/49tnm9nDDCkIFvfUdjni244809sPE1A7hlb06wn6dExTz8U8Cj4aCIpEeWvr/6nBar8
	bDsgDbv15F6MsmE0bfBuH+w2ianieSJFQgpEBYNwlLlYt/bW87HYkH0Xx7s9b8DjwdQ==
X-Gm-Gg: ASbGnctYbh0PDtWX85MjNczYUWnhcDTzHNGY+BVE4A4dV5sApPUQPuOgaTHu3EwAv9j
	i7M4A9M4MJ2GCpb8idJpnqNTihvdWwKBFZ4PNC3cfD93Flrk6JeukMXeZwvf8UfnWPKWkiw9Pfa
	yj78CUwyazYz1R9Hgza/KoeD1To2uCnPWWXU8351Rnq/HDomK/F5hav33Z5xVVNi2WNP+DQ2cYZ
	lR38yB9LGtFkdHrcvGeHiVPZzUoy1QH8hZlHJGdpyry//khmOh6UC1A60GQe43ilvUyzCv/12BX
	qZ0AfePKrm558BgESuTT00OpfkY=
X-Received: by 2002:a17:906:ee88:b0:aa6:950c:ae0e with SMTP id a640c23a62f3a-aabf491e146mr184740166b.51.1734516510649;
        Wed, 18 Dec 2024 02:08:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElz+KnDnIV4/z/HLgJGjKzAErVWdv9XAf6U6sQ+wwJVIlLKVdwuAxA2tbLvawq9el84pF0yg==
X-Received: by 2002:a17:906:ee88:b0:aa6:950c:ae0e with SMTP id a640c23a62f3a-aabf491e146mr184736566b.51.1734516510242;
        Wed, 18 Dec 2024 02:08:30 -0800 (PST)
Received: from [10.39.193.174] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96067ef1sm534517866b.48.2024.12.18.02.08.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2024 02:08:29 -0800 (PST)
From: Eelco Chaudron <echaudro@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: linux-kselftest@vger.kernel.org, dev@openvswitch.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net] selftests: openvswitch: fix tcpdump
 execution
Date: Wed, 18 Dec 2024 11:08:29 +0100
X-Mailer: MailMate (1.14r6065)
Message-ID: <6D309AF5-AC5A-4F68-9F86-84E66AC0FB4F@redhat.com>
In-Reply-To: <20241217211652.483016-1-amorenoz@redhat.com>
References: <20241217211652.483016-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 17 Dec 2024, at 22:16, Adrian Moreno wrote:

> Fix the way tcpdump is executed by:
> - Using the right variable for the namespace. Currently the use of the
>   empty "ns" makes the command fail.
> - Waiting until it starts to capture to ensure the interesting traffic
>   is caught on slow systems.
> - Using line-buffered output to ensure logs are available when the test
>   is paused with "-p". Otherwise the last chunk of data might only be
>   written when tcpdump is killed.
>
> Fixes: 74cc26f416b9 ("selftests: openvswitch: add interface support")
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Thank for fixing this, the change looks good to me.

Acked-by: Eelco Chaudron <echaudro@redhat.com>


