Return-Path: <linux-kselftest+bounces-43316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E9ABE2536
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 11:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15FE19C382C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 09:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9622D3A7B;
	Thu, 16 Oct 2025 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNz331+8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D663254BC
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606236; cv=none; b=i2seChuSX87LvTds7EnzKdtZ8ziCTHTMFdDyHADfpRy3H59VH6DGN9klZaWCqKGjmicsFI9jeUDrFcIXO2NP546ecBKOyfthcHYAgbmY1wFTAstlbiDX773oPwCS2dUBdPPO/DvUEq1ymgTPTWFlDyLr4pQPpIatpYvBxwCij/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606236; c=relaxed/simple;
	bh=gfUY6k3Za1yX/HAAk7zG4178blXNgWT89fTHHoWhQPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aExhcM0GzNlD4Bk8G6QJAu6c5nEOWS5/lAckdIj39elLuCArSa1/rf/XCqjd40X/3IxEGSraZgDkdT0vp6wKx2vTjbvbhWnC5C78pKGemKNlxiwxVqpilhgoCeRqalx0WEFmW16t7kx4s1GfbQS5eW4AvXr9yLDrRWb2ufC/iVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNz331+8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760606233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UPLteLwS/Ol+pKkRNcrWyR6iIyl0F/A5LRNN9NP4s6k=;
	b=DNz331+8HsgsdKESyLiAL00ty1Dr856bxN4UOC6uQnj0UB6gysNoyeOoSH0PsrFkIjqMxp
	URcRRczKaUDABiRlZg7bQUmQoT5In+NCNk1tjTu/Xg/UQZV9koek8H8ualXnh+rWY6qKbz
	CALm6VYlg8sD6/00+r2Z76f1ZFwTW0s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-P-50vAEEPXKd43KWXD3AHw-1; Thu, 16 Oct 2025 05:17:12 -0400
X-MC-Unique: P-50vAEEPXKd43KWXD3AHw-1
X-Mimecast-MFC-AGG-ID: P-50vAEEPXKd43KWXD3AHw_1760606231
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-426ff59a320so298871f8f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 02:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760606231; x=1761211031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UPLteLwS/Ol+pKkRNcrWyR6iIyl0F/A5LRNN9NP4s6k=;
        b=nSAdkSluaEeLRXns4DTTAA3/JhWW0U7oIL8TbufUgv7hxEJF1JXXsZW1j+edg1sOj7
         BdV0akBrfLBKSjuxN0O96plHhR/4C/6n7SwrFoc1NS3G7ejMfhuJ8QyAulv1rkkRjUhq
         N5ZMq0D5GvKUipnedGeqxLEftlGmoZCL3EaWEHZ8efJCs3Sy4S2Ul+MdqMi2mrrpiksb
         2ZcUjUtoq0IuQfU5p5pUDtTydDaUQVAcGE+vWjoQ8iMwH5513FdkHl84tg8Y+naJar1p
         gMC1+EDFfSpw+TqOe3XBbpm8/fUl7FZ95gveh39XYLPvY+8t0a5r+k2GxbYzUV/Gi+BR
         UR3g==
X-Forwarded-Encrypted: i=1; AJvYcCUvkbxh71D11ZRmn+U44mKxYrb5Ab6FvwsdkFpn8ZizS++VQMr1KZvr6I1cVJ7wfxjgqJzttui0EfqANU6rv30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy32rL6cu0Ssenc2odkxE9/k98ykFHV/SPYstv9PODFTYGGa+5u
	IdXiQLJSJ3h3WC5heNR4AsFPw5j+HHjGGfHguMXBdlGbooPjU9CX+boCtUi30wpSvsS5xRZEVyz
	e4NNjJDUb77M7jIAuPvEjL+bOwwmQ83Q0Bf5QAL1eOLU3J8u6U1ktd+H4SSP1Cd0MMLFd0Q==
X-Gm-Gg: ASbGncuNjgle1cZyeZMDwFz3TJGG5WtLYH4ZF72frahMayRgb2P4PQnaaZRSpE00nBt
	pcWSDtXdz92VtLhdblb+iPLxOU5isz/tnwvYAzxNR7IDfIoXEYM6t/Ua3wyV2F6ygNsbURaS+ho
	N1/6+k4dLuRnsZVpl5KF+6DH/R2PgsETEZdFy5R/zestkX9kLArU88MR6rJgESUG9qiO2Bf1igV
	jyCePbJ86o0iCTRtiCiRJwa9zW3kB/0NA9YAkMRvbFSmX40n/Cwapgtuc+QkwLAReY+/G1HuYGp
	JLkp9PiMIX9mpSjWhedmCcHPESnlvPmBRagh3spiGP9VpMSY/1MPkkhC6E8ErYmrfi3G5FT/tBM
	02bTFd0MhTk36Li2QhJHhEo7jOHVg4JRPE8dPH7vaO+KcGoI=
X-Received: by 2002:a05:600c:138a:b0:45f:2ed1:d1c5 with SMTP id 5b1f17b1804b1-46fa9b171f2mr222149235e9.36.1760606231072;
        Thu, 16 Oct 2025 02:17:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtQayMfbwHyZG1M7ESHO0HokLA6DuGP71NEXIAOvlVT9W48cYSOggIbCg6sBW0bsUEfsGNsg==
X-Received: by 2002:a05:600c:138a:b0:45f:2ed1:d1c5 with SMTP id 5b1f17b1804b1-46fa9b171f2mr222148895e9.36.1760606230619;
        Thu, 16 Oct 2025 02:17:10 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47114428dbfsm14301785e9.5.2025.10.16.02.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 02:17:09 -0700 (PDT)
Message-ID: <98342f21-08c8-46de-9309-d58dfc44d0a0@redhat.com>
Date: Thu, 16 Oct 2025 11:17:06 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 02/13] gro: flushing when CWR is set
 negatively affects AccECN
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
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
 <20251013170331.63539-3-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251013170331.63539-3-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/13/25 7:03 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Ilpo Järvinen <ij@kernel.org>
> 
> As AccECN may keep CWR bit asserted due to different
> interpretation of the bit, flushing with GRO because of
> CWR may effectively disable GRO until AccECN counter
> field changes such that CWR-bit becomes 0.
> 
> There is no harm done from not immediately forwarding the
> CWR'ed segment with RFC3168 ECN.

I guess this change could introduce additional latency for RFC3168
notification, which sounds not good. On the flip side adding too much
AccECN logic to GRO (i.e. to allow aggregation only for AccECN enabled
flows) looks overkill.

@Eric: WDYT?

Thanks,

Paolo


