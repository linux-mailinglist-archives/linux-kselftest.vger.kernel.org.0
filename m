Return-Path: <linux-kselftest+bounces-45862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EFFC6961E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 13:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 928B62ACAB
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 12:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55191FBEB0;
	Tue, 18 Nov 2025 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O83kRwuv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKKgTpkP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BDE1EA84
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763469026; cv=none; b=e/vrlmPuMex9ya8IVuJfmjwtFE0rHtbtQylJyfl6919SLudC+C0niQXGQ+jPKiCsdFKEpMTCSeKZF3lIywoYxzg0a9TgWIYxBwIHiolrhwltXnoHWN6TN5rEZaoorcUmohM8yDZm3t6PAceGnRG/hX+hgnJtSuq0pGryW2bl/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763469026; c=relaxed/simple;
	bh=8B9ouElv+xeFaTKAh9MT9KBQGuCsWdhQ9skK5QulCOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upfdJmb/BjaYhDZsafWoZ0EyumHlbYWMqC5G4SrzQ1XGjhnWx+o5hAPowpA1NLCV9oBQrGKNBgJyQVaSAC5y1JISzeBrPE7ZrXG81TJ6IY0OmW6BFYXMcY5hA0XOkV4EernR2F8qO66exq6BNpfCbrlB4i8LNw1fRWMs+jkNxBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O83kRwuv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKKgTpkP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763469024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1y6PrlUAcuxkkEloRxo0vMvd5pujl1anuTqxEZ8o/Q=;
	b=O83kRwuvD5AKFvQbFu6mrpO9JcXSk/KF+Xooa27/DRka+F8uuo/EEMh6SfG2wgaRcXlfry
	DnpsEUkCjNiA/JwkIgf2SLruFZagfTWR69uUe3Y44BqT195CnNuzkUfl3SQT2OjKd0J0hT
	fizHXj0aec845wY6SgcWNuEH+rnenQ0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-vTd8ncXOOMGS-qCQZ-NOag-1; Tue, 18 Nov 2025 07:30:22 -0500
X-MC-Unique: vTd8ncXOOMGS-qCQZ-NOag-1
X-Mimecast-MFC-AGG-ID: vTd8ncXOOMGS-qCQZ-NOag_1763469022
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429ca3e7245so2180585f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 04:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763469022; x=1764073822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m1y6PrlUAcuxkkEloRxo0vMvd5pujl1anuTqxEZ8o/Q=;
        b=XKKgTpkPFMCo15edxy9QngPgSQnaQWbNxg6TKGlvn7gI/a4y1SChmGOYHi8qXDIK+P
         s+WOKRUrEZsl8IyLHNjUrlE3HwF8vHEgMEy9T7HvAdHO1riQAIqTL61PxbG86Guse2EY
         olKjiDLm+NEnUQ80+x5mtMUg1AZ+kS+k+y0kbcviaabOHRxz3SEDfC3BlXSxcEdafMci
         WrEJrydqKOSdbKotxJDUO05MMss5B/O/40/OtYk9kt8o1ogfDynZmuzzgrFgsgrNmMiy
         0j8grEa04E60VhPD7rxPVDlgb9IAl/RI2+iaHevdph3tRoOj1kaj8W6TFoJ7tseN9OX3
         UxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763469022; x=1764073822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1y6PrlUAcuxkkEloRxo0vMvd5pujl1anuTqxEZ8o/Q=;
        b=GQ4Y8XOzkXckNXpYbKA8pseMiVl7LmzD2/+mNQLqEWUNlrLlm50I7ru2Q3zih/A8iL
         5vwegB+TgF86n3gMZ2MTfuQA1AoKwpktlJ91GS4Za/t9tdlqrk3s92WmIAmr+d2AK3aU
         PjOwJDrHTQ+uNPF3UVwMJe/pqVymL0hUXbPCj9A/U6BqtE3z48pBdC2unXGNKTKXXvl7
         K7Y2qlGnOJ6TNYyNN0rxWMeUGRriQ+8to6cHATsqJdhBvxePH+ViolhY2HcX2WB/LpMO
         T8XJwNYQrhkKDJIHYCimvPl//9xEBHAHsuSW8MOZBZlU9g8Z46mmLvaAq9aD7dqgxihX
         1P2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUo7lBwYis4n1P8pPiDDJZsBCi9D5ovOj/nr3V/fl+cN4t6WhHgDH8VwNiVfxBegICXGiWxh/uMtkiVGanzi+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAQpcJf6TlC96yTQSSgRNiu7WQYhDY9jymjyvrQQmDDXLukpyB
	L4yg70k/Yk+JakJLLGlfeaBUDWwPkq1sLKOKwyMNFRmgjoN8cX6hSS4hG+gCyIMKx7HLbyAPMRZ
	8e1OXHO4H+P4M4GQ4nMkk2Te5296VtgtMG/gV/iFuTo9+M3EXBdxD4roMWWScJJRYB8F2Zg==
X-Gm-Gg: ASbGncvwKqqiHtPEZkK2pj0h0xjSI81In/qp9NQuDVqov2LmqqwXBoFyTY091JMa85h
	LX+A3qnuhT/bfMl+krBsSrWWMKMyXsVLeeudo1QhZRXfhOIkid4cyRVTPDktmYt6Xd9qUBuA5LN
	9NzvSidhKb2OZiHE0sLIfSGJMoxNVRhSQJFizEGQ8XG4Pb1tfpNhQHCQLfKTo/a+6O94SuSM5e8
	v5rEiy1pPQ+F+3bCDOZDUJ1cBxHhc7cUb457j9RyOsIoOGQz4jGqrMMfADAnyHTfJU2ha26jONX
	c3A9kFVDLDl3Q5YVmNQ+mbs8VMJHwGR1CLiiO4Ktj77X/Oa4VUt01TSSdjM8s/n6thtLKMGIkGZ
	/vuy+kydMzE5w
X-Received: by 2002:a05:600c:4513:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-4778fe5c820mr175963155e9.10.1763469021604;
        Tue, 18 Nov 2025 04:30:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOZAD7E1uZGLJ36i/AdVTCJbTikjjEi/nzH5t0pOPTGX1/txTaGcM5dmDEUHhqBH4ogD1aHQ==
X-Received: by 2002:a05:600c:4513:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-4778fe5c820mr175962585e9.10.1763469021119;
        Tue, 18 Nov 2025 04:30:21 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dcd891sm15757525e9.7.2025.11.18.04.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 04:30:20 -0800 (PST)
Message-ID: <715746f8-d1f0-485a-ab83-2f768722698f@redhat.com>
Date: Tue, 18 Nov 2025 13:30:17 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 05/14] tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN
 identifiers
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
 <20251114071345.10769-6-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251114071345.10769-6-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/14/25 8:13 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Two CA module flags are added in this patch related to AccECN negotiation.
> First, a new CA module flag (TCP_CONG_NEEDS_ACCECN) defines that the CA
> expects to negotiate AccECN functionality using the ECE, CWR and AE flags
> in the TCP header.
> 
> Second, during ECN negotiation, ECT(0) in the IP header is used. This patch
> enables CA to control whether ECT(0) or ECT(1) should be used on a per-segment
> basis. A new flag (TCP_CONG_ECT_1_NEGOTIATION) defines the expected ECT value
> in the IP header by the CA when not-yet initialized for the connection.
> 
> The detailed AccECN negotiaotn during the 3WHS can be found in the AccECN spec:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
> 
> Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


