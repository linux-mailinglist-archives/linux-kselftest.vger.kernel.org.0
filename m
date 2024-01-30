Return-Path: <linux-kselftest+bounces-3763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1658842D09
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 20:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40FD11F23037
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 19:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6F07B3FA;
	Tue, 30 Jan 2024 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OV7i9x38"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7724D7B3DA
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643497; cv=none; b=Qm6wSSq7TtQGn6QfDFJwFzxFXlHNS1cMHcpQB3VU/+HP1S32nNNi0tFGqQAqeXga7ahju/BezQnSp6w6vUrtxxjPtLgxJ1CjLM7v2NIsVnmz686q3JICfGjPww+0ueJcf2SwTWMb0r+r7oy0LvmQTGN93ThZNBlCVYPIHAEz96U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643497; c=relaxed/simple;
	bh=7LYL6l0Z94iO3etF1kV6s2A40BMWc1Uz9hRf/JzOdEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnJFygQgmYmzHRIHmBmGB2FqUkr063lGQK8vymWi0tpes/xv8ytxrFexmibfBvNr4N4kgV1Q9B7hsSBiPoDXb0KL1hWDzL6Ad7dF9QYT5OHsKpZWgUJBKz+vAt/J6cCHf4FrnVbjDNLxccWFNTimF0CkOyk26eZKqVY8nVwAeMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OV7i9x38; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706643494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=erebicM5EGUj+TO55LHiZrDopa0H+e3Sw6aLGoB/nf8=;
	b=OV7i9x38twJKtpV2rC39GWg/63o0kVW6pYrWxd4auCt5NteNwsV8iKIh0sqZQZFE75Jb7f
	BviPG94MBmy9OSembcdES2lOWxgBgKwMa3M3YJCkBItm2E9GeX/07K1alxQFIv48n+D7rQ
	VaI3xWk4t0/4vM+cg0pkBjdpxWeGD7s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-iKPONNoOPf2jfdhqsN2zdw-1; Tue, 30 Jan 2024 14:38:12 -0500
X-MC-Unique: iKPONNoOPf2jfdhqsN2zdw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33ae5be0940so1408045f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 11:38:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706643491; x=1707248291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erebicM5EGUj+TO55LHiZrDopa0H+e3Sw6aLGoB/nf8=;
        b=diZGhn4uMOs1WjYspKQeQ7vMRy2NuuNhcP6GoybvPLnf3iiJhpUr0tAkphQ3cJz3gk
         ebb4HzGuLP6PE0obDzyBLEWoDyspT8x/BRYbPXCh/Izcbp+6GrZ09wfxVsd9Aj/jN6Qk
         YHU+yR3UtF5iFlVJAd4Cdm2CW2d18HEH0nh/2K8kjOZ/Clm1OT+Ud3kuyVwPrmd0qf7o
         gnyLbQDMO5dTrxHxAr0OfIagJnzwwGxOGlmCl5+Hd9poaGBkdNuVCR954lUFwQNDCkwT
         /RdNZj0jyZ2/Lg7OF1gRVzvLgEx2ps+Eu+18+I345d555mLP16MJh3g8kH+/sze3gHu5
         22Eg==
X-Gm-Message-State: AOJu0YyIb+6uv9AhSBbmqPYAmMAK6U/ITyVI+sVUMW2CFiimwJ9Qcpju
	w1Gcs+Tf5z2tS7jScRDCisj/4jtkuuUmFHj7BRDXSSesWiAjDE1q0XUPpdtAD7PvFpPFRu3A948
	Rn4HkP+kDcSDF7T9RW5ZHnW3/Xua0gzi1gKgnvxJ/SvXYS0WAPq0wL92sOKGO8deQGg==
X-Received: by 2002:a5d:5f49:0:b0:33a:eec4:c0c6 with SMTP id cm9-20020a5d5f49000000b0033aeec4c0c6mr5906527wrb.12.1706643491351;
        Tue, 30 Jan 2024 11:38:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKqkjGsWLgqXDkjV3UDL3t5SPr6NwD7S1Po3VHtcXwQXYWg8xViryXwt1DgPwb+7G83X9Dmw==
X-Received: by 2002:a5d:5f49:0:b0:33a:eec4:c0c6 with SMTP id cm9-20020a5d5f49000000b0033aeec4c0c6mr5906518wrb.12.1706643491073;
        Tue, 30 Jan 2024 11:38:11 -0800 (PST)
Received: from debian (2a01cb058d23d60036688fbd67b19d62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:3668:8fbd:67b1:9d62])
        by smtp.gmail.com with ESMTPSA id gw6-20020a05600c850600b0040e813f1f31sm14019540wmb.25.2024.01.30.11.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:38:10 -0800 (PST)
Date: Tue, 30 Jan 2024 20:38:08 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Florian Westphal <fw@strlen.de>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 2/3] selftests: net: fix available tunnels detection
Message-ID: <ZblQIIiSYNn6kv8f@debian>
References: <cover.1706635101.git.pabeni@redhat.com>
 <cab10e75fda618e6fff8c595b632f47db58b9309.1706635101.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cab10e75fda618e6fff8c595b632f47db58b9309.1706635101.git.pabeni@redhat.com>

On Tue, Jan 30, 2024 at 06:47:17PM +0100, Paolo Abeni wrote:
> The pmtu.sh test tries to detect the tunnel protocols available
> in the running kernel and properly skip the unsupported cases.
> 
> In a few more complex setup, such detection is unsuccessful, as
> the script currently ignores some intermediate error code at
> setup time.
> 
> Before:
>   # which: no nettest in (/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin)
>   # TEST: vti6: PMTU exceptions (ESP-in-UDP)                            [FAIL]
>   #   PMTU exception wasn't created after creating tunnel exceeding link layer MTU
>   # ./pmtu.sh: line 931: kill: (7543) - No such process
>   # ./pmtu.sh: line 931: kill: (7544) - No such process
> 
> After:
>   #   xfrm4 not supported
>   # TEST: vti4: PMTU exceptions                                         [SKIP]
> 

Reviewed-by: Guillaume Nault <gnault@redhat.com>


