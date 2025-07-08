Return-Path: <linux-kselftest+bounces-36757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B34AFCC5B
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 15:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62CF4A44D1
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 13:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CAC2DD61E;
	Tue,  8 Jul 2025 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JX95dItG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648922DC358
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Jul 2025 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982167; cv=none; b=KNts8F67zHYEKTAG47clkzfBdfy2JVwb9ZYXgbsW2xqox1AhnR3Q2mkzZ3HKoN9pmV7XKGlKq8rDdFPuEq8ApiU7kAl39iMaeSIPOP9S43LnzGAyZ995bB+wuL5gAi5rpFBaLhQ7miSx1oCBAqJ9AVdfW7MvjR6U9x/2W6Oxe3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982167; c=relaxed/simple;
	bh=7IMZwdtT4ONplTSo8XHJ6xX4Q4sptOL8v2V3UkoQjlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dV7ZP+pb4HQUfk1mS89qFNdM5j86B/YKr7SNwguUyPyzUgjv3kWQmmQJkAE8V8B4jSdC1vq6CJR2h7wae0ekAlFrb73Fchn7+4vFsauzkxCmkekBLvpAABUTjv2OvZl5E8rMuyFP5cPanYzIKxgsSecCbJFTkoVFhZtFC2rQeSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JX95dItG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751982164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P27oZItgQlQTIEu6BrjTyR+ZcNfbW2DcDgBZkxGIz3s=;
	b=JX95dItGi/IzAFix0WKuR1J/KAccgku2dIUEkiXvU4tRfOCfEaS/iH981HXIbp2sw00aSZ
	HeoPqmZzgo9mpyCLVos3syP/0nuIZZIbAd1Y6AN6fVGL6XCLQmtam6eQd/9wZwupsuO89n
	ou/nFJSdfCxKl9j6YD8YzfRl0NOXcg8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-3bDolwjtNtCTpHthtauMPA-1; Tue, 08 Jul 2025 09:42:42 -0400
X-MC-Unique: 3bDolwjtNtCTpHthtauMPA-1
X-Mimecast-MFC-AGG-ID: 3bDolwjtNtCTpHthtauMPA_1751982161
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4536962204aso18731575e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Jul 2025 06:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751982161; x=1752586961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P27oZItgQlQTIEu6BrjTyR+ZcNfbW2DcDgBZkxGIz3s=;
        b=fOMNnBZ27GS5LeInWlMsXTm/JGGkOqmaeyKuzRYCZC1XhR9RNlMo4cRGFnrUtATCWu
         pk+Y3nkFntVruJ/sPccOIy23CYk679d06Y0uVzZuTfG+LVie47L5ntTwAwEdaZZyl0LN
         FWtUuvv1QJFJimcNmtDYuP9eofGrWN98hFVkbTP3uSrMaxkayBGXf7TxKeIAIhAwjBjK
         Ll8/x4XK9O2WE4ijkQerg2ykG/LWSmPDzpWi6NnxiTt95KJeMXiL/b5765skUkxo1ww4
         doRlM6je18BJhkLv8qw//6M7NkCKYermWzv7hdCZK5c35LgUGD7AO2Hl77pHhQibhHe+
         TP7A==
X-Forwarded-Encrypted: i=1; AJvYcCXGk/3ZGQBCpRHvo+9QRCwqNsn2ndKCh1UR9ctECr0XCIxZpdB/lwM6xqH9mgvAwEPvC2ceYOpb8nMUNURyMjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3D/r32zGsbCq6UfuBpBZPk/2NSYwCByCFJiupjM5YxwqCBJJ7
	MSy193H+Qko9iFiTlDGeqnKuNL/SqHl+u/Wr/XwGPQ/g/zGNYDcnTckTdjJFByC7Jp1Y5vP2Rtt
	I23j0g0lekKDnabhctRQmhTdLcNPEwjm1RB3J7B152x+qUzgGVT9poEm5SP7QAocM7nYpHA==
X-Gm-Gg: ASbGncuwlrXQ7a7pCEACdeny5ZXVquKHm9g4B2r+9Jk19KK0+MWXjEU1vmDY1gkKALl
	qUGZn7VCz0h1jkMfkBeYgb8kmhgFAIg2/dOItm3KywN9GZjqhRxnfJd7AQDvzCFIX8DgpwTtl48
	NBNJZ6/Y1RcR0fy/cTPu4A/wxPOYItnF7W2vLOs7MR/Qsk2vbNUWEY2XqJlmDIspVkQEgxCyOVI
	RIjnAmTslLIgk5Cx6kPU9UGmFjy1yCAWD46V+9EUxgdcXJZ2fX3K6fZSBIk4210ijb53pJuIfMP
	34y0b2mHhMr9nkuY6Uym155e8cfOB7kjddnl9kw3CTDKWOFyY1t0M64iJT5B/6jXc2IU5g==
X-Received: by 2002:a05:600c:154c:b0:442:f482:c429 with SMTP id 5b1f17b1804b1-454b4eacc98mr145947545e9.8.1751982160587;
        Tue, 08 Jul 2025 06:42:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwFsHBVEro5CvXOCFzVmkJDQs/mNrwHrnzu4qHxJ8LIqAIs4YS5XK8sVi8hyjhO6N8NrfG4w==
X-Received: by 2002:a05:600c:154c:b0:442:f482:c429 with SMTP id 5b1f17b1804b1-454b4eacc98mr145947095e9.8.1751982159842;
        Tue, 08 Jul 2025 06:42:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2717:8910:b663:3b86:247e:dba2? ([2a0d:3344:2717:8910:b663:3b86:247e:dba2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0b9bsm13204192f8f.30.2025.07.08.06.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 06:42:39 -0700 (PDT)
Message-ID: <b610c003-5c8b-4fef-8fea-a2b40f8d1377@redhat.com>
Date: Tue, 8 Jul 2025 15:42:33 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/3] selftests: drv-net: add helper/wrapper
 for bpftrace
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org,
 kernel-team@meta.com
References: <20250702-netpoll_test-v4-0-cec227e85639@debian.org>
 <20250702-netpoll_test-v4-1-cec227e85639@debian.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250702-netpoll_test-v4-1-cec227e85639@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/25 1:21 PM, Breno Leitao wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> bpftrace is very useful for low level driver testing. perf or trace-cmd
> would also do for collecting data from tracepoints, but they require
> much more post-processing.
> 
> Add a wrapper for running bpftrace and sanitizing its output.
> bpftrace has JSON output, which is great, but it prints loose objects
> and in a slightly inconvenient format. We have to read the objects
> line by line, and while at it return them indexed by the map name.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Does not apply cleanly anymore. Please rebase and repost, thanks!

/P


