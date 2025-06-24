Return-Path: <linux-kselftest+bounces-35680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB09AE634E
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 13:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626E617DB41
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 11:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFB5288536;
	Tue, 24 Jun 2025 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLfCm+Ar"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8F0283FC2
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750763348; cv=none; b=dTWp9oCJK9eP7SRdE+5pP82RAapHlawXV+0Ba0wOwb8RMJ1emvIp39c1YHBC/Cz165yufHgw5Pn1ab5jXV6ZsRcLfwCsQxBcaChBBivYMIhV/VWjEBjwUQ9JAf+TvOX6oz84aQMIjQhWJOQPlG76Hrk1mVEzPzvttdunsv4GU+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750763348; c=relaxed/simple;
	bh=xk0K8Y9GNGQRlSmr9+j3AdvLKGa1tXM70MIgWys7z68=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QoN/cpo4ADR5idKw5TeNiktxdAJ9MvDHwuTod2Sy6go2oL9NCD3Li8GkfZA2cFzUsIkcVKcKPpIfr9EARF3h/bHBUY81MRyoaRQY4bLdsbTqtVfGqVVNhaxPKZSAU0LR/Qm20bySVH3wO9DMkoNqyxKDO4F4WfiGFEIQ/YdF1I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dLfCm+Ar; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750763345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kGyqpb2hXEKZ5FRzXkAxKuJIK/tLYcR4CdnvTMOm+wA=;
	b=dLfCm+Ar8iMwukT5sqoB4nY24vznzAVJicYQDDC5mVx9kLZGGfc+f6GTyYDlbZOK1+VIUZ
	nsVim8dDp3SuD8A1eX4KcYMMH2f5Ad2tXZTL6y93XnO8HF2e74/8APc0EXZtNmxuCLeq4Q
	kpZOqBDl0vVuKKnDYIxUXrWlmjdRv9k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-T_xz70JxNW6T8Fa3RImk6A-1; Tue, 24 Jun 2025 07:09:04 -0400
X-MC-Unique: T_xz70JxNW6T8Fa3RImk6A-1
X-Mimecast-MFC-AGG-ID: T_xz70JxNW6T8Fa3RImk6A_1750763343
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so1964455e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 04:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750763343; x=1751368143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kGyqpb2hXEKZ5FRzXkAxKuJIK/tLYcR4CdnvTMOm+wA=;
        b=ObkARHtAxbVmP6U+6gfZnkJa40HaZ8JHDvkdjVXEpbxJrCQZvb2ViUT8tfml+J9saz
         EcS65yxOasXki72zjhE7arGlj+A9Gu1lgTPIcLbtZeYmhoCHOP5n9nc76/ud+ZThbylZ
         /yG8F8cCipX/dR3Q4oe9NqT/IsV7tUS9jMtt7V/aXaucnIy0Ydt9ziztmumbGIUOhe9g
         //tXVsaKDrBsyAkvGxAHwcHEPsMDJTute9KtoB929XYsV4g2jtg92Rc3TI6eZLbRErWk
         ebSfm/KtHFayrEGNlnZ1CGVNbohlfkL5IhgAUhRJyuHDPT2R3tZcnTOzvNV9HBrpidOA
         2YsA==
X-Forwarded-Encrypted: i=1; AJvYcCXUNzBD+0Uu2p+9WRBhPc7IWtYcdJZ0p9jd72AyzT6TVytwwPPXkc/4MsjqZTAcpI29lU0mHT++xb3bRTAyTYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIdX5srMUlsPM5aFk9DZ8Udohhq2jQ/3atqlvkRsR7HwMSzdKn
	KyKL66Ej5ZPXLOlhzWZrC6Oa5IcvbrSuXv2GbOEnaNR7CJXWoPpRRVibbdH1/+I82S/tDABT6z+
	VRWnf5nqN3WGHEY2kLz/w1RhmIbON3i/X+FYbPyC3X96srgCUoXxxIRU1YC3rABVNaBLLWw==
X-Gm-Gg: ASbGncu1LWnkurX4RF1O9wr3cLs8WK+xGnCQg4IeeSIe3Q5si6MOSf4IMwl4/h0CNT/
	uRF9Ibtnbl56HSY95mgDADfprIl/uSotQFTJh1C63Mw4ef3dFGhaBnQ/fOUyp4oZvX4QfrW+auB
	qubSLwB+/74vJzixwGTHFENiC/riCa2xjU2M+rf2GsmHwVBLHr04h69/Eqkw4hr4bFb61pKPEoQ
	HDRgTTzoUJR3C/v7QnHMN0JW9zKByaNgCaeIVaRV68A8b3SrK0wW45Ermbf/P58/GS2h9xu781P
	YMFdqoiZJjk3q9+YVXv0ss3wv1otGw==
X-Received: by 2002:a05:6000:2003:b0:3a4:dfc2:2a3e with SMTP id ffacd0b85a97d-3a6d12e154dmr13691888f8f.39.1750763343114;
        Tue, 24 Jun 2025 04:09:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGm18O1vFLDsvo59xhvJ0D87DUDiE63/ilEIWM14hPF8ZubR/QRhwNQIPxsY8BH5HgKlvb0A==
X-Received: by 2002:a05:6000:2003:b0:3a4:dfc2:2a3e with SMTP id ffacd0b85a97d-3a6d12e154dmr13691857f8f.39.1750763342665;
        Tue, 24 Jun 2025 04:09:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2445:d510::f39? ([2a0d:3344:2445:d510::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ef6edbesm171253365e9.20.2025.06.24.04.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 04:09:02 -0700 (PDT)
Message-ID: <073dfdc8-dd56-47a3-b43d-4674279325e6@redhat.com>
Date: Tue, 24 Jun 2025 13:08:59 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 net-next 0/6] DUALPI2 patch
To: chia-yu.chang@nokia-bell-labs.com, alok.a.tiwari@oracle.com,
 pctammela@mojatatu.com, horms@kernel.org, donald.hunter@gmail.com,
 xandfury@gmail.com, netdev@vger.kernel.org, dave.taht@gmail.com,
 jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, ast@fiberby.net,
 liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/25 9:33 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
>   Please find the DualPI2 patch v20.
> 
>   This patch serise adds DualPI Improved with a Square (DualPI2) with following features:
> * Supports congestion controls that comply with the Prague requirements in RFC9331 (e.g. TCP-Prague)
> * Coupled dual-queue that separates the L4S traffic in a low latency queue (L-queue), without harming remaining traffic that is scheduled in classic queue (C-queue) due to congestion-coupling using PI2 as defined in RFC9332
> * Configurable overload strategies
> * Use of sojourn time to reliably estimate queue delay
> * Supports ECN L4S-identifier (IP.ECN==0b*1) to classify traffic into respective queues
> 
> For more details of DualPI2, please refer IETF RFC9332 (https://datatracker.ietf.org/doc/html/rfc9332).

I don't have additional relevant comments, but I would appreciate any
additional review from net_sched maintainers.

Thanks,

Paolo


