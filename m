Return-Path: <linux-kselftest+bounces-47803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67063CD41A1
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 15:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 133D3300769E
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 14:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1902FE04E;
	Sun, 21 Dec 2025 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SDXNpG2/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162181DF965
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766329167; cv=none; b=Ew6Egy4s5quLQjYXYpznCkEGsOfLzlL5XDdLAvwGjU9ki881XhwmYkLs7zcxgrlEC1/kpN4B4GWvH+wmOFdJvzrEjSjamF4LVZ/+UmFogevuKK8LTG92kREZkaxWWiH7onzVOGoZMUZamD2weE8FDygoJTyPX3ObgLzYSfd0mRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766329167; c=relaxed/simple;
	bh=wnhdy8ymoLVKqvtAArSDJZar79glM7NZ+Vgw3IPa3BI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=oSR+J9nADWxvNLzama51kM2t59ivMI0HnAbrNawvZJPhl9wBFhMydOx8vmQojvXUyiYXloUEYzRdQaTmf9X2OrIU5furh4RD4Byz2h1o0cbLb+4KJ4B5qQcphpl5jjiDyRWoVzw6+zm4TNbYg0Q9NXaXD9t59jJP+s7VLt+MdIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SDXNpG2/; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7355f6ef12so600789166b.3
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 06:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766329163; x=1766933963; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnhdy8ymoLVKqvtAArSDJZar79glM7NZ+Vgw3IPa3BI=;
        b=SDXNpG2/ld8oxG6q4wzAY9mDZkd95ie5pS5hnsNWsiavXY/Lggr8dGW3NjeZrb+7T0
         luUg6UBF+tu5XyFUt0gylCNWsiyAewfmLpladrt2nZ3xmzO/go70ltE99pfnZ77tXARh
         uZv+Qh58ImqRIiwFtkn4S9iDJyrmguRyilP8cPdF2oceNT8pMMXqiNvpIkSVIpZKVA3P
         shy68+t3dcfW2L6eaJNBz1mbqjAr8VjuiffSWGbUPBkupyxQ0UCvPMgKe6GBEm0/FmKB
         lPZtrXeRbTC9SFh3elm7xloLhQb3AvqkJbM06sKvIpTnURxLXsezdB/1EnbsDsoSi3gj
         DjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766329163; x=1766933963;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wnhdy8ymoLVKqvtAArSDJZar79glM7NZ+Vgw3IPa3BI=;
        b=Ek80h3srUiRBCwihwRtE3Z/rq8dydnlVO69SCp4h5b5C4/vLqhhf40fjcDTXGRf/an
         ZEWD1CZ2yo+D+YFGs/DbWPW1VNeeBlvIzyaSUYce9K8djczDiGEZjXXbCH6GPx4CNURv
         35eGTP6Ap3Ke7+7/wrSkAPzX/U5zA4cbGLJVrpr0Mq/OCDimcXLCo0OddOtdskZWHh/u
         RCuXdygJ1ob33aRGJBgEmWVGpYywVpGbgB4WArQyvUKlEvZfiArI+5eQlp7+7nqN/ZKI
         ypGgjDfKq4GzYJg81IDACRnw73vi/uwYxyYTCx6CJThiRVYxcIWsGedMYrDey4nFl1Og
         T2KA==
X-Forwarded-Encrypted: i=1; AJvYcCXVMNdMfeh4bMvI8KExh07MBiy75kVbJWvWDdXqZPcGONBTzv735tJpXTZ/IOWCao97CxSO+gy9hJB+Zy1JLQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUaUAi2dlZE//bTTwg0cOnV8nPFHhi5zTMHe9KN41AU2bIDi3V
	TXjn440stZGe0Zd4ZNTfAirdeLlmJbO+0yZsmi9MXDt5e7HtU/fzxX+Qo3qWrpIr8fI=
X-Gm-Gg: AY/fxX4B/ZJKZnBTWFk1RDsNM4oZqodnWRxeUuxiHvR2aMoC4PclvVfvzYnnnafExvT
	cFayV+3wVA9Sz52qNgNMthogl4bFOfkpA2Uula3KKmkKEW/BSoQ8w9r4hoTdBgAjLobV+EDL8f+
	F+ZVAvmaqnDNsuTHekRbdu9sdLBOKfIvM5rzhaNnQO/JhuynXtiHSUU1bg5CUoSvxNyT5KS/0Cn
	10SzLy8adC/w5cI87HtWr/D7ClWQ86q9sfTZbXrhb6TxkfKPinfQ8+0KiQjttgEJCdZM6l7KeAc
	HFlBP6+aVBaU6Ysu02lFrvBr61CnSFenLdGwfMYoxHts5JalTNYzIbQv1bC8lxk5F4evoiIVPrv
	zCg4OU2C9rW/a5YxGXfSYfpxJYI/htqXmuR5vhGGAWOOA9NQ7VTWPEU30hIiTnbCwh/CV4BGwaA
	==
X-Google-Smtp-Source: AGHT+IEkCPNzQ5e82IsVboI0n7YYBJlXdYsfKuIyWXfeqElgjGBXzeXsUbx4p69DY/H06b3K/k07KA==
X-Received: by 2002:a17:907:d2a:b0:b73:3e15:a370 with SMTP id a640c23a62f3a-b80371d6c20mr977219466b.57.1766329163464;
        Sun, 21 Dec 2025 06:59:23 -0800 (PST)
Received: from localhost ([177.94.145.206])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65d0f69b9e9sm5197702eaf.12.2025.12.21.06.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 06:59:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Dec 2025 11:59:17 -0300
Message-Id: <DF3ZFGNY9DYU.HO1EOLMCRT8T@suse.com>
Subject: Re: [PATCH] selftests: net: fib-onlink-tests: Set high metric for
 default IPv6 route
Cc: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "David Ahern" <dsahern@gmail.com>, "Fernando Fernandez Mancera"
 <fmancera@suse.de>, =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?=
 <rbm@suse.com>, "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251218-rbm-selftests-net-fib-onlink-v1-1-96302a5555c3@suse.com> <9a3f7b60-37e3-470e-b9f7-8cda5ddccb59@suse.de> <9c979662-cdd9-4733-911d-b1071b7c2912@gmail.com>
In-Reply-To: <9c979662-cdd9-4733-911d-b1071b7c2912@gmail.com>

On Fri Dec 19, 2025 at 12:51 PM -03, David Ahern wrote:
> On 12/19/25 7:51 AM, Fernando Fernandez Mancera wrote:
>> It would probably require some work on the test but I think it could
>> benefit from using two different network namespaces. Currently it is
>> using PEER_NS and the default. I think avoiding the default one is
>> beneficial for everyone as it ensures the state is clean and that the
>> test won't interrupt the system connectivity.
>>=20
>> Other tests already do that, e.g some tests in fib_tests.sh use ns1 and
>> ns2 namespaces.
>>=20
>> What do you all think?
>
> agreed.

Thanks, I'll send a new version later on this week then!

