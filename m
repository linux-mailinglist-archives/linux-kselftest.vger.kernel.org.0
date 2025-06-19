Return-Path: <linux-kselftest+bounces-35373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7101AE0AAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 17:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0EC7188ECA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 15:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035B7236437;
	Thu, 19 Jun 2025 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZwGUap/Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACF5230D2B
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347440; cv=none; b=tgOOjenGTnWsrkCxxZRfQ90aZquEuF3SiORPHc1mr4GmIBALxDrrRL3n3Mg9p/MMs2lpQQ1ytlXB53sEKDL9kp+NuCYfzNr7MFNQzChv4LMf/yJoq+FGtCkDPBaf0FGSe9OOoeqmmeqLAwUE+K34S1J0EtalRiV0GP6V1UADSHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347440; c=relaxed/simple;
	bh=HXqBNC79E8+zULge9cmYzz8aTHkD1900PAbJWPHai6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvyRf92H1xQaX7mOuL02CZGq7X4gA5w9I8ByDoQAYLTVkE5LOwe1cZqhnGrmmLVt7oEQuw3ZVPfhztKfNuK5Rm4VJRVWP23j/FQ/CNIIsRMekQSRyOB8gXsCmwhsV209XhYxKmJRPn9y+256t4MKRu3N/rAxRFl/dMGf79AkfEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZwGUap/Z; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2357c61cda7so131885ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 08:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750347439; x=1750952239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXqBNC79E8+zULge9cmYzz8aTHkD1900PAbJWPHai6M=;
        b=ZwGUap/ZQIUKxrhMq86JDkwqv74o1d+pL1OoeJh6iuC6Ea3xhpabXhvr4OnF707rGg
         RhW3wH9P8H5QPJF24ldOIyHIupquYFOEJxcwliGb7A8MYELZV8QJqKX0fVflOScsoMi6
         EhbXUgicndUXfIGFF6BlE3UeJjDE1rid3x66SmDOD4i0fN06bkMQa+Yjdcntgsa+CQsJ
         NxTCoLlwlCq2VeAjkVb/YXrWkG0LzcnJq9zDipq0rUjF8c+KUDhMBHofXOqpnQASL5z4
         7p+p/B3iuhfwSlxZUGSanrPQdtASxcXZiz3sH0T8u4Jh5WcgOWtEd8OmtS9usP2rgeKw
         Za8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750347439; x=1750952239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXqBNC79E8+zULge9cmYzz8aTHkD1900PAbJWPHai6M=;
        b=ckc4ltUJbjwcziWfUP6ScMzTsYGIHt8KsCMH7NV9l13Kw21iNZ6uA8bn6qddwjiCFe
         dolAeaghW/2Z9y0OZ3asbyA6jN/GDhgeVWKOigkUNA9fIwSTQMi+qyhG4r+wji+vyz75
         HMghGV1MVsVTnQN+fRwVXeYZKtb+64siMgEJFU4AnYKNsC46W8qQ8khRc8xGEiYTobiK
         LdkNcm2xgtoDhBu6asmSulb9cZRcSw1eSvJmuRqqz4s4E/7ooAzIV1FoemFuITW85XwL
         r2DFsYxp3ngM90lbwDZ72OE30438GVFkZx4IBDbWHBrx9XPlJeOcdijxFC1+157QJwQP
         sR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1e7qNtJbn9mgDMoPRWAdlwX+hoXR+wRz/aK3u0BcUWgJ9FLx3Hy+GTDujSIv/LKko/CxCJELaBdKvchB94PA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyruyM9f/X/N9zVwSFUlBqvhdL54NklXDwkV6ZoveKpyA+U0VJG
	8HlLTM2r9OIi3GiL7EGmgN1YhFsSuO5UI4bNouyEQ+MGKRgQMONIBDb988k8n4kfB5hh0fg+J3k
	n5b3vRTBJ4sMPK77udR3bpF/IY6X2yjPml4GFj1Ws
X-Gm-Gg: ASbGnctPteWjT4v3JOfB/EvY358ThhRb7ZmogSvAkFPO5+SlATfAGZFtX19f8cFYxv2
	dISYvMZYq5tZZEg6HOIR+3myfrxwQVUMI3A9yGcLr8YvWlrm4nkaORwcnoHlneh5Giv0Rz9xxFW
	GzUjdgwAabDrugCQDFV1Pfe65UO8J0jUPO3FIxVgVzH92OVsN9DxubF2k=
X-Google-Smtp-Source: AGHT+IEeijlQPpJuvXLonxzDPjlDUwYkzvUY7s0SbGkDqtAlVdPJnNp8p53qHr02gdS8vRw9Ecwmxce7UO+kYeJGCME=
X-Received: by 2002:a17:902:ccc9:b0:234:afcf:d9e8 with SMTP id
 d9443c01a7336-237ce035db1mr2436035ad.7.1750347438284; Thu, 19 Jun 2025
 08:37:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615205914.835368-1-almasrymina@google.com>
 <c126182c-8f26-41e2-a20d-ceefc2ced886@kernel.org> <CAHS8izPyzJvchqFNrRjY95D=41nya8Tmvx1eS9n0ijtHcUUETA@mail.gmail.com>
 <f445633e-b72c-4b5d-bb18-acda1c1d4de6@kernel.org> <CAHS8izOhNRNXyAgfuKW1xKb8PTernfer6tJfxG5FZmq7pePjwA@mail.gmail.com>
 <a122981d-ac9a-4c7e-a8a3-d50a3e613f0b@kernel.org>
In-Reply-To: <a122981d-ac9a-4c7e-a8a3-d50a3e613f0b@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 19 Jun 2025 08:37:05 -0700
X-Gm-Features: AX0GCFtbSJkA9B2FmfN23HT-G5zxw5AQXqfUAsX29ALKFUjOOk7WFn4t987JlLo
Message-ID: <CAHS8izOQLvPAE_E2dgMS7-11ZGFK5jmZ7q58LZCnhymhhUj2bQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4] page_pool: import Jesper's page_pool benchmark
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Ignat Korchagin <ignat@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 3:24=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
> > Does this alleviate your concern? Or do you still see an issue here?
> > There is still a delta between our results, on different
> > hardware/configs but results are in a sane range now.
>
> Now the results a sane and in range :-)
>

Thanks!

Jakub, this patch was marked 'changes requested' for good reason, but
after investigation we found the patch itself is good and the issues
were elsewhere. What do I do here? A resend of v4? Or does this un
'changes requested' as-is?

--=20
Thanks,
Mina

