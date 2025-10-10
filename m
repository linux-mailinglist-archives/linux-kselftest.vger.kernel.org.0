Return-Path: <linux-kselftest+bounces-42962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D977BCD9EB
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 16:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87FF54EB36B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 14:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBD72F7460;
	Fri, 10 Oct 2025 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DM6Ndb2C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF562F6573
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Oct 2025 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108028; cv=none; b=Typ/QY9nNdzwNuzTr+UPMtDl2QmN2tFxAcrCuYc/tGA49vdwTlcNZ53+GSdce59Z8vOaKxjtsVuraSdpABY6kC5Sa0CoMFIdu44wdARQ13vGxzQIR0QvElbl0/5SWpq7SFTazG7ZvndQJ8hIoZF3mzex4X91xgZ5uoz+Ss5hzrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108028; c=relaxed/simple;
	bh=RE51Q+tai5wxyY7IBNplIrEXUroPvyfLKx/UM06nsPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lB81mhCzJwzqZ76A5VTV2JablFx/u+g9sy5V+38GtarkepADVNQW+x8gY36AEVMwW/8JKrvzhYbohKuQz4F5/O7/bISNplkB4bEB1+57ctuXc5GNXu4cj06QvHV0lTJM5bq4ECAj9s7mmoMJMRh+mS2K1WTD6dIx8rKx3va6aMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DM6Ndb2C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760108025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mm1LsfcOuzKZTTBgXzTaGHCG8Gr2uq1l0R9yl5s8auw=;
	b=DM6Ndb2CAazN+ux9pzrdpD8uO1/yhFOW5ogB3B61bpZ6kKiybDUU/O07g95YHBXgvKWwuR
	R2R2cheLwRMSFyK30GArMFN4sGVNQZes7WKnJOXABVLnLQ3GLntwDEloepobo3920xWguu
	ViZoDXah8YIVqqQ+W5lsXXph3H1gUyM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-xWWzM0vGNWanL4PDUXH1Hw-1; Fri, 10 Oct 2025 10:53:42 -0400
X-MC-Unique: xWWzM0vGNWanL4PDUXH1Hw-1
X-Mimecast-MFC-AGG-ID: xWWzM0vGNWanL4PDUXH1Hw_1760108021
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b3d525fb67eso245412866b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Oct 2025 07:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108021; x=1760712821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mm1LsfcOuzKZTTBgXzTaGHCG8Gr2uq1l0R9yl5s8auw=;
        b=eB8gworSg2ilvVedAEEoYWlp4pOHycPG7V2yb19+blzdj52Rd5cJ6ai+NApYctVqSz
         aCO9Uem8+OHXoLGxmBC2j78XyHPLC2P0g/BSzPwunbApK8qXD6Cdst+njstIk/u7mtx7
         BqkWpzEITs9CeBJKCTERV96XqfiyvCEq9peT/Xrmwu0tWkhhxK5VeLZGCDz4ZjPLkE6B
         Q60mk1FPYlQG3xoLi8dND9GGgMxO0YjkHxGv0kVUWgwcM+MrC+ul48NPAbWWM2oXfE1h
         01OP16WE/JDbE1oFu2P/mjMe1AuM8i0KDS7+opg3Xz9TXwvHWOQ53QTFdyAon7VsjafT
         EHgA==
X-Forwarded-Encrypted: i=1; AJvYcCUqlVmudLdhlGkkozBVlE6GwwFLFLDYeB6vaKGZWBp93LaUyzKFk41T1Lvj35ySYGQSkKUVKcOINZDYL3suSL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpdTv3hEc7soc21ALyseg+xCX9E60VT9ds3PNS2iyfVJ5hAfGo
	qQNNOGRANU+2UnCZsibP3H3v0P+fjMdZdaJotn3IfLQvK/NuXapwrUlWWCEqWuZGi6xdvDkvMZ1
	dH+CNw8Fc+ASsMN7Xrx1NH06GCxmD9x6WJONrj+RldDADYxa1TYUsMJfTAyb62hVRnWf+gg==
X-Gm-Gg: ASbGncv4suzo11lUz+bKRBjgNXaU0iS8MRlLDsF7hXsdgtJzAPxvlKvVSwcLKWTa7dp
	Np2nvxcdN5yLtrJGZmBKihXFEfRsDCYTB474/w0YzpOPnZbS2iIvGTcrBavCeGXXwy26Q5NSfhU
	pE3I8PJEsOEYpoy2dgZodGicBs8Ky1jxCFXaTza7ee7Y5qYV1yE80QStk2sn6zdPBBvl0HZC32N
	UME4O0ei3J06cRI8EVgOkTbBwtNYzbM3g4kjsdBhltj3DfyPjSWTq0136tuAkvKKz8zfcDdCANU
	qCMYUNoR6uD3rzrZEdsE5yQqLNNgax98fPWgGhZ3cTOPNnN+CC80G893wHkycarzfqtQepcRPvP
	Ynke2cqtONxEN
X-Received: by 2002:a17:907:3d16:b0:b38:25b2:e71c with SMTP id a640c23a62f3a-b50ac1c0d4amr1269986766b.41.1760108021416;
        Fri, 10 Oct 2025 07:53:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvs40B7jZcN/+w79lx0XokZpMjaCzgtfhFa84wc/vDHQJD9iDkyGA8sI2ISLmd873BOO53wg==
X-Received: by 2002:a17:907:3d16:b0:b38:25b2:e71c with SMTP id a640c23a62f3a-b50ac1c0d4amr1269983566b.41.1760108021007;
        Fri, 10 Oct 2025 07:53:41 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm249396166b.38.2025.10.10.07.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 07:53:40 -0700 (PDT)
Message-ID: <0ec01c17-1c39-4207-96f8-597bc8d6c394@redhat.com>
Date: Fri, 10 Oct 2025 16:53:36 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 00/13] AccECN protocol case handling series
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/25 3:17 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Hello,
> 
> Plesae find the v4 AccECN case handling patch series, which covers
> several excpetional case handling of Accurate ECN spec (RFC9768),
> adds new identifiers to be used by CC modules, adds ecn_delta into
> rate_sample, and keeps the ACE counter for computation, etc.
> 
> This patch series is part of the full AccECN patch series, which is available at
> https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/
> 
> Best regards,
> Chia-Yu

## Form letter - net-next-closed

The merge window for v6.18 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after October 12th.

RFC patches sent for review only are obviously welcome at any time.


