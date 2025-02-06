Return-Path: <linux-kselftest+bounces-25929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E84C7A2AB1F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 15:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D003AA8EA
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 14:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E19521C9E1;
	Thu,  6 Feb 2025 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLnkk7LU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0201C6FFD
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Feb 2025 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851836; cv=none; b=E3nKXStpPcb657ER7HhFpDopXhEcjmOHnL4BaWItghGc0RNvlvwVhO3V44qciZVcgoG+x1EKFylQlVHxGd0JI1WXArIsryeT6dK+VNPslwaV+l2Z6mVep7BoaXGs6vAbZ+1Kzdu0Y1lk1SKflwx/fyuIEsmfo/qOHzjQ15mhb84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851836; c=relaxed/simple;
	bh=QDiPoHWt78UETk6zWdqpw/0pbEYpx51QjZ6lwvwvUts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZ4SV9AnI0lmtwe5JFB57DyJ+OuXgd3JM8cQDPyEXZqwEuj/d4Hfm1YIL8TVJdv9e3Uej2dH/WxioE6YJIqOl/ugIZdfgzVHky/NvqKyNOorQasj6Yfgp0K9XasV/0Pjf00kuNkQB4u7sZ/Watnm42flYcyyCE2ai3n3YB6Xhn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLnkk7LU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738851833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sARMRwqWra02AxNOvFwwfgvAfZfjGVONCzOuY60nMKg=;
	b=gLnkk7LU0VAq9rhXPMP5NfVQBaiFTzcJs0L8L0LELiPEsbYTfFpIsYggbB/fdGuf5J48Bc
	X9D07Cm6ocHn64hhRB80SwVfBALajH6+5OpXh/2EkviovG19ZXpFiGNv1FHewzXx0xnzhz
	GNZ2F9LXZarv2TZbrg9oXo4nKSTvFS0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-xunBNH3uNV6KeZz6CduIfw-1; Thu, 06 Feb 2025 09:23:52 -0500
X-MC-Unique: xunBNH3uNV6KeZz6CduIfw-1
X-Mimecast-MFC-AGG-ID: xunBNH3uNV6KeZz6CduIfw
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38dab928a84so368332f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Feb 2025 06:23:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738851831; x=1739456631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sARMRwqWra02AxNOvFwwfgvAfZfjGVONCzOuY60nMKg=;
        b=Fm3uIfLpp6uJ5fBBaZ62uMzTWoLapO9tQMxOGdhRrnU3TluQSX6BPmS6Blz+HmTp3b
         WsyRTBQG4vOGKrvmpu5MqNtU/PUCLA6I+o/dDBk2V9qBVuLlccoADldvJyOBQk4wyqUd
         8yHuiFrMPaNvVsIt6PZdpAqNVXk3alGWXbZ+TBMGi/ylVsE100nHQXiwJk9jQSnjFA88
         Kk8byxO/LaZH8xwC4zYBcl37qrYmi+e12nA0CfWCTI6KeBEU3MpHnpWeG/8uJ0c2rZJi
         OUfvHWJpsT+TfukpF9/keYSMBxlx47cFGiOt+e8NfIKgGemJt73fh6//7RSlFnAAplO/
         Dv2w==
X-Forwarded-Encrypted: i=1; AJvYcCVmrMx1Ah0WYK0E4XQF3ddPWohbFG1tlDDQAavrGupA/fnzJA2XW/1m2BSUC3rvdpYikiUm8gx7k9E2Z2SQxZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRgCuu2C919OcjkRbS5AniZ7lZqmExr4W6wfxo6BCZZyTlzRCP
	tR1LKug6b8ClAZMD84zAiWvZcn0jTu4wfN9clSudfS6YQZ9XYJ0dEg9XHwmQXPhye2G1MaKPyPb
	rRlbrmjXXtuF1Y2v9UuXWFJj6Fw9ChdiaX0wbV0yPk92lBFOumRXeNQACLpqe5tT+nA==
X-Gm-Gg: ASbGncuNEg+OoWWreROSLUFzmCi/wqOEQwht3WHTnf5LNxLpoaoJG6mStQLS2DVdp65
	7+ZcB9ILeKjT1KEJ8M2KIaHenNkFHj4T1LmGEsLBNDUiHBkLvO4eHsR16nfLiVxC0vUNO+WerMa
	j9o9JiCh+qGRdK/pMYuPzu8tkEQ/R/zC7aw9LZ/WN0vzL5Yj4DPeyOoezv9mcaihDW37ljvjxre
	fTB/cqac0PlhBzdc3nqSlU3FfsDw8aKJ67bkfBuj+OnJzsWXcIn4A8jWAv5Ql89sVKdr2aBXDbG
	bQ4cxRftpNi2/MF2gPxmmS+MxHTBUwEwahE=
X-Received: by 2002:a05:6000:1446:b0:385:f2a2:50df with SMTP id ffacd0b85a97d-38db48812bamr5369022f8f.27.1738851831287;
        Thu, 06 Feb 2025 06:23:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXx+BSFbHwwe2GFW3dNA+ND1wpXAm3XM60cAR69i0CFj0ZvSN/1/aqOpEGD0kNC8huOJ9WSQ==
X-Received: by 2002:a05:6000:1446:b0:385:f2a2:50df with SMTP id ffacd0b85a97d-38db48812bamr5369001f8f.27.1738851830889;
        Thu, 06 Feb 2025 06:23:50 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbdd539c4sm1839934f8f.42.2025.02.06.06.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:23:50 -0800 (PST)
Message-ID: <5c11113e-c7d0-4c71-9f5c-02e7a90940fe@redhat.com>
Date: Thu, 6 Feb 2025 15:23:48 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next, v7 2/2] selftests/net: Add selftest for IPv4
 RTM_GETMULTICAST support
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Hangbin Liu <liuhangbin@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 linux-kselftest@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
References: <20250204091918.2652604-1-yuyanghuang@google.com>
 <20250204091918.2652604-2-yuyanghuang@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250204091918.2652604-2-yuyanghuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 10:19 AM, Yuyang Huang wrote:
> diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
> index ad1e36baee2a..7b1e29467e46 100644
> --- a/tools/testing/selftests/net/lib/py/ynl.py
> +++ b/tools/testing/selftests/net/lib/py/ynl.py
> @@ -38,8 +38,8 @@ class EthtoolFamily(YnlFamily):
>  
>  
>  class RtnlFamily(YnlFamily):
> -    def __init__(self, recv_size=0):
> -        super().__init__((SPEC_PATH / Path('rt_link.yaml')).as_posix(),
> +    def __init__(self, recv_size=0, spec='rt_link.yaml'):
> +        super().__init__((SPEC_PATH / Path(spec)).as_posix(),
>                           schema='', recv_size=recv_size)

The preferred way of handling this case is to define a new class, still
derived from YnlFamily, setting the correct path in the constructor.

/P


