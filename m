Return-Path: <linux-kselftest+bounces-21646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587479C10B4
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 22:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B6328407E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 21:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ECD2185A8;
	Thu,  7 Nov 2024 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQ6fthhP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0675121830E
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Nov 2024 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013694; cv=none; b=r0/ZxQQ/lpvcIA/8y6BeeIpgx2dkDE8xTxXH8KZRQa/J9TG4xMu6ndbpy3cmrNr/DoGgtmsG92XRLFzA4rVPBA6yJQ5DuPoo+12JMqvFAiod4GpMhAA3SZRrro3SUKC0hJ1c2LokirSlUqxCfMkHfatIFlrAbWvGIOSTXXu3E8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013694; c=relaxed/simple;
	bh=EMxt7kYIYpj0aTE8SaO6Cet7tiJN1I4Ls+423fh4Wfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHE3SHxpJ5pi14Nkp/vINtd3XRuNcSdjZq3mCrK210SYnZ2wEuZr0cl+ig45eSqirXfmpQUFwwMJYNFlrHgBZg4ur2PtYgsVxcnRymBwzvv5t4NJF4FIIt6qzgQFeP4cTfGuM7qDJnKPS5PLjfwwTxJIN3m2HUA8gpSm61S4Jw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XQ6fthhP; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-460a8d1a9b7so6711cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Nov 2024 13:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731013692; x=1731618492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMxt7kYIYpj0aTE8SaO6Cet7tiJN1I4Ls+423fh4Wfk=;
        b=XQ6fthhPaLHGGP2gFO8RTINYS6eiFl7bg/v+iBhou5J2wu+PH5LLfSIvUGNxWPK8ez
         oI0d0RlNkuyDHz0/T4DIwWXl5j5Ai5vTHHNyEUp7TY3sKm45FtmM9GleXdROKa8NtbOp
         IEZu/h8M5T1BmoReXU8yqJLteCkTd1BI3XXqoMoJ+rSvZX3qZevp8H5yiN2MHPlCMbXb
         M6wISunbcJQx94RKSUjsbOATPOzhf8ouhkwMy+d1Ej9dkb11FiaR05ywMSuSqISbU2aR
         wqQe5TeNeEp0qTgM3SLSvycHN2A1rc37L29Od2KXy4DX7xYC8ZOaHT8Eb8XCdsXM6YZF
         yeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731013692; x=1731618492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMxt7kYIYpj0aTE8SaO6Cet7tiJN1I4Ls+423fh4Wfk=;
        b=Dk6nNilt+PZxo7s4kFDQeoGgTBygqqXkYUcqvOWCmSSHTqVEZufhPmAHrhCy9TLedg
         QeDnJPuKK+snS+/LznluLhSsax2nX68W7nR+ZP9cgVRN1GZ6OgNY/ZjF74yhhJ3yzEm5
         +aHWpl0Gfouoedyxj+bClN0LwhA0wx1iipIeT/+4j/dhuUWOitVZiBkzgPIcT8pG7kg8
         JrPpPgpFSoFfYFF86JNrmZSYJRfkynpbHMT1n2aO6DxMt4r4paoeEiJLnRXpoTLDL+51
         thuMXsHJ358PX4DRjUQKEvCISNRKNG4X6XvGFNgj9Qxi+86DEsrZlI9PDY/eKVdlP4NK
         AmZw==
X-Forwarded-Encrypted: i=1; AJvYcCX7cVKfWCLH67VaCRiwBFUnsZ6Us8+Yknoec/9vo3otLoIVUhHu0XJRt4m0+a5uKepWX/Nj4bsSUAl0XSLh/eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR0ez4KZcYGKPgyfBmhD2moWEI3AW5VCJDyxjLuGDsULRlbIz9
	pbNNwqpzJNaR6XBvZtFnmuBS36OVArG2DIoqttShsMNfqwsVb06u+h0HTqMTXFtC10psNNJ5nAO
	A2O1O7n7wHQOxHQfvW7XxegjCSJFHSyXxtOl5
X-Gm-Gg: ASbGnctA5w47MiOV5nmjKv6mL73ON79Luvwu62c6T+0IyHmqxWyc/ao8oTNkkCD6kGq
	xQV0BQ4bNObk3xEtykdKwwJiNJVA0bQw=
X-Google-Smtp-Source: AGHT+IGVwRKmmDdCXrJ9yts4PX0oCLDtCnr3iWhEQX4cctr2L6Hn+5HNxGpsOGoqz1dx/nbffB51ZSEpbDnMPa46nQo=
X-Received: by 2002:ac8:5710:0:b0:460:e7fa:cf2 with SMTP id
 d75a77b69052e-462fa6112e8mr5871971cf.23.1731013691732; Thu, 07 Nov 2024
 13:08:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029204541.1301203-1-almasrymina@google.com>
 <20241029204541.1301203-3-almasrymina@google.com> <763d9630-3064-4d88-8e99-549a07328ec8@huawei.com>
 <CAHS8izMgF8nx87D9pWPmq1pfDm1v8x5Z6gc_eMHcYo8zKX-Lrw@mail.gmail.com> <1d8c55c7-1406-4af6-9dce-0b296cd40fc9@gmail.com>
In-Reply-To: <1d8c55c7-1406-4af6-9dce-0b296cd40fc9@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 7 Nov 2024 13:08:00 -0800
Message-ID: <CAHS8izPuwiPk49yjWgBYYa+uGuQ4fNtXaRF8+9cWJsf3gk04Hg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/7] net: page_pool: create page_pool_alloc_netmem
To: Yunsheng Lin <yunshenglin0825@gmail.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 3, 2024 at 6:35=E2=80=AFAM Yunsheng Lin <yunshenglin0825@gmail.=
com> wrote:
>
> On 11/1/2024 9:10 PM, Mina Almasry wrote:
>
> ...
>
> >>
> >> Isn't it a little odd that old and new are not following the same
> >> pattern?
> >
> > Hi Yunsheng,
> >
> > The intention is that page_pool_alloc_pages is mirrored by
> > page_pool_alloc_netmems.
> >
> > And page_pool_alloc is mirrored by page_pool_alloc_netmem.
> >
> >>From your description, the behavior is the same for each function and
> > its mirror. What is the gap in the pattern that you see?
>
> I was mostly referring to the API naming pattern.
>
> Isn't it better if page_pool_alloc is mirrored by netmem_pool_alloc and
> netmem_pool_alloc_netmems is mirrored by page_pool_alloc_pages() from
> API naming prespective?
>

I've been treating the page_pool_* prefix to all the page_pool
functions as constant in all the renames so far. I replace 'page' with
'netmem' when available, or add a _netmem postfix when available.

> And maybe page_pool_alloc_frag can be mirrored by netmem_pool_alloc_frag
> in the future?
>
> Also, it would be good to update Documentation/networking/page_pool.rst
> for those new netmem APIs, or create a new doc file for them.
>

Heard. I do have an action item to update the docs. Currently, outside
of drivers immediately looking to immediately adopt devmem tcp, there
is no need yet to use the netmem APIs, but I do hope to make them more
widespread (and perhaps deprecate the page APIs when it's time to do
so).

--=20
Thanks,
Mina

