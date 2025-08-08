Return-Path: <linux-kselftest+bounces-38570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F233B1EA62
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 16:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4D2188039C
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 14:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EF027F74C;
	Fri,  8 Aug 2025 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KDZVfo2K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC8727F19F
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754663373; cv=none; b=egrCtEhFs9cTJxQDzwBfZAzmTFRu5sdOK225Fp4mzaz/i3MZc9m/BkfK3JDrJTGZHjF2MULlJ2MXrSyaWQGUXQYs0f3c6vGoa4wX4+Hp3xZ6YQS+nr4IWyMYNlSTjZLUWyTVbdW+XljrzH4GAArYTtCCOze0CqItmqRPB/NVzuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754663373; c=relaxed/simple;
	bh=HE0XpdsalRjA1PXYRuaAKW7Ag02uAh1zUcx7SbwS7kQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClXn5qUP2+TUAly9Z/z/ROYoHgdBsDQcRcqnt1ow2F3BkyYE196Ex9NiFjLWtERmIcy0yDOarG9G3w90BwmPTZ7Mh38k5kiEWEOfSuHqqN86/OdVVO2lNRb8JuAbNNk+Qa4rB3R4s4a0dg2IjA9ovEV9rheOtBoOs4ljBDsFX98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KDZVfo2K; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e835e02d96so30053785a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Aug 2025 07:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754663370; x=1755268170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lu1rubSJHWYgGS9Ti+/Ua4nK5aRcxgMx133HRXn+2nQ=;
        b=KDZVfo2KYZQH8S7YS9z7zCtrQu350IpC9NEpBacZIjyTEtufuwUfHSltjuxR47T6EA
         rte40gAuGAqC+Yr4Xoq+hu0vgutKKXpp6NuN9A9+UeQUMpQ2AkhBCX7h0w3tjMc8s6mT
         ugtSYANQrm8YMvYP+HGhqpCuZrKZ399gcZ9zLnQXf8rnEKNoNyaOaJ4Xw/Cl+jJczfCr
         Q/X+oEfDIBZlxmSm+YvF0Sr6UsHhxHptkchr95hKFnRa4+uy5eWIc6wy1dZmPx2OmLAx
         Z5RR0Gh7v4NNwP3t2nuTlUwS0DyAfkvaF4M7SiombmQGQ94rACQOFGA0hUZoHEXvW3VZ
         DOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754663370; x=1755268170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lu1rubSJHWYgGS9Ti+/Ua4nK5aRcxgMx133HRXn+2nQ=;
        b=hYRf5lqtSR4/31vFkzgNQ7f4pHnNcLSNQkgK0pEsmbe+ZDt50WSOIGf0b5b73pY7R/
         JIeWQ83Ik1P0BsTQ8ufjfQIalw4niat6cGbkSt6I/a8xcdPhnWxhV57NnANsJijPCkd5
         DsQO2T6ulXVkSJmmISHQ1MPUdnYfo2wGUb3FfP26jSRL7IA7MLJ5q3UjskODDv2RYVR/
         KwyQEbN9UWa0iMP4cQpuTuIrei4VpON4AKH9q3y3EvfCdhOAyWBpSuogdAAtl+7ZqoU1
         4B2IrQDrguy02ezK1E89kj3xB7f6EH6/Z3rf4Zzvq4y9DeNYunoNJWLN+SXu4g5tdMP5
         bjnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmqu+Jvcp/H3jA05z1xxEHns+ETIUwE8VmpEPY1vFI8smgb7SHnLlFBaJG20IXvPU26m746P1v9y1KISPLboY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe2kLKSZOpviahD7h6AcIZ6s0WehliME6B2Z+GTxy9jqhQAzel
	7OWR6gYibdtq8XvMX0DjBSeP7MnuBhywAZc1j21o+rIoAOTIpV4TzLe8VVS8DgpgPJtGr0txXpB
	Es/2tm/hi+EPsbRbhagxvvNM104flnrvospOjsuju
X-Gm-Gg: ASbGncuV7A5z0QdiaaWAoT8sWlLm9LqSiWYGe7Fl9eL1g5LZ5cGlylvk8ULj7klpsWF
	WA5iRNVjqyMFZVPkxemMCNag0kOOyEpg1GMJXViC/FrTXntFmu+qdL5WYt+zP6Sh7XvtBfVPt2G
	BP4RAtmEklIbXGy/56/ceU2QvqK475p7kwkrTb85Sch398NxW7pxYmGeCjU/50jbcgnbUvREGp4
	AoPCYvSbJPDp4JqbryjUHuR0g==
X-Google-Smtp-Source: AGHT+IFGgYdr/LfByXsHoMgjH74PdXbGLGz0kR6esAOf/HuNG/BDsxk4V1ht6i8qdCPj0em97BWqaEFSSD0S1XSM6eI=
X-Received: by 2002:a05:620a:4247:b0:7e8:2197:23d0 with SMTP id
 af79cd13be357-7e82c7319d7mr371095285a.38.1754663369886; Fri, 08 Aug 2025
 07:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807232907.600366-1-kuba@kernel.org> <20250807232907.600366-2-kuba@kernel.org>
In-Reply-To: <20250807232907.600366-2-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Aug 2025 07:29:18 -0700
X-Gm-Features: Ac12FXxO7Qn5GApEoYqfnkU8BABbpI-ShumV2gKhkZ9IdxcQVZFNs73fwTz8Hs0
Message-ID: <CANn89iK1oUXV_L+7a4zB7-tB7AFT92GJCp5-ss_zgqnirVdh+A@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] selftests: tls: test TCP stealing data from
 under the TLS socket
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, borisp@nvidia.com, 
	john.fastabend@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	sd@queasysnail.net, will@willsroot.io, savy@syst3mfailure.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 4:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Check a race where data disappears from the TCP socket after
> TLS signaled that its ready to receive.
>
>   ok 6 global.data_steal
>   #  RUN           tls_basic.base_base ...
>   #            OK  tls_basic.base_base
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

