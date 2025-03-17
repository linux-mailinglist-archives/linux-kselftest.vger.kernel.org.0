Return-Path: <linux-kselftest+bounces-29182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0079A64547
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 09:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0FF16865D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 08:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A6022069F;
	Mon, 17 Mar 2025 08:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eb1WwC0B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB07921D5AC
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742199833; cv=none; b=uh+fIGMP+E4y+WY3TyGqv8icAarDTcgVwBt1N5eYpcWRaCixjsOkuHfBt8UAaEwRWjh14Mir7VLsUW3e52HGCy2swsf45UzI5ygNx2WEgbb1Z6/IS7scMfrGu3YU44z7oRapDox9bLs35ziiB/ud3ne5AgvzyGQkrpwSMH8+WE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742199833; c=relaxed/simple;
	bh=6F6vk/bCuTRFj9sHasYFtzBPnP8c9sLQfBUMl+1ThkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQ0bhGmfz9vTbTl30x75JEWEATz+WXrJ68iXH5bveA9Jt0DW1cryJ9kdy2ROTyylaa2gLcwTB1f56l7VnEZTyjUTLtUTwaPakPa2ID4Gtb7zA4nis/FqrfD2YAsvV5RozCd82hnpS7S0YjQl2ptlqHAlFIJa34ijMev/lj9UQH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eb1WwC0B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742199829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rC5lK1FxM1eWQXOh9AroE9tnp2td4VImfPnxc4mu+rg=;
	b=eb1WwC0BDjiqQtrusWTXRhvBhaayNsUhPrC3RNmcVExXx+czvUSYGpp5Ho+XoLfuHXiGdU
	RbIrrhteQiTe48pZtkHygy86vcX2EZew4zi86jwtZmI6DcuRIfiy6uJ3WViuB3FUNYd7jj
	zZwLdQvmwu6LlPVBsjdbL2WTJEIlYWI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-BOxbs7USPr2wLTIHYJwThA-1; Mon, 17 Mar 2025 04:23:46 -0400
X-MC-Unique: BOxbs7USPr2wLTIHYJwThA-1
X-Mimecast-MFC-AGG-ID: BOxbs7USPr2wLTIHYJwThA_1742199825
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf172ff63so10475885e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 01:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742199825; x=1742804625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rC5lK1FxM1eWQXOh9AroE9tnp2td4VImfPnxc4mu+rg=;
        b=NFr72vl9xuAOJVQ1aRn0CiJBzhEw2VLCv2A64zsXRmfV7d0iAb3Sh7oQ90LJGV167r
         rvNH8J6glx2AB4g7msR27uNEXmr34iiSVSfNGjR0YB+jbdH7SzopjQReih4HijU+Cx9D
         fJwhoy3Mkjr/Cno153osLTe0fBORAForvI87zJTAPpNFAJmwf+F06pccNwjtNt7VBXhU
         AuvwBq12G8Dw5ZewXhOxaIipdOJt4Zrx+CIZASkjNO+oGmEeBbFJWHSpiF+lAoq0dB04
         0/qhSNvccJC6Qdc+uQz5ZgnHxul0d+HhK69RqpXS9gSg8b6w3+QBBW2WIgp3ydSb12wh
         6gtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5kBmeYdfCacSzdMq3ygatYdDa/dIKLUvZdix5raxpBCmYrd2JWS3w5oNMXil3+u+sux/1s6VB5VZ1u6CU2NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/H6jEmjQM01Q95jqE6yTAQYsQfpsOB/QPa5sqfaqvEZ7kKFnN
	ELbk421658AcLv6gGNQdtpvDS9xm/OrVMLmXKrAUbX6/QgWnCvEq4q6laWUijOAItTEIHdvM8Tc
	Ok68WoVwmZgTc1T/2QkZl/QETsXwO+kzYy3rCjDn1XlD490/ttLShwoYefg9cvMj966HFQK9Vew
	==
X-Gm-Gg: ASbGnculM43LBGlFnnq0Jn7TSTm/XVHsr5obe6fl7optcswNqapKtOLk60k0DGb4w6g
	kLdlEbvDI9/aiFNUn6EC4n5RqmLRaj2nUCy29A1azc6crTZWzeEnig+RcshucaeD083pa7fa0JM
	pRztQvIMaTBEug4IOyyjE+anJ2B6o6n4OQVchK9QmanmZRuYwBb9+EPAM9gVRagprOyKmBDwRFv
	l5tniyk+bye6T/HEJS5BUku1OtqMO1XH8hZ8K23YUeplwQ2UDB1OcAMSt9VaFxxsiOHVy/GCk9Q
	0byxceHesP0og/lvTfguO0MjcWsIfGXuiIBdeO4X8gx9CA==
X-Received: by 2002:a05:600c:511c:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-43d1ecd60c1mr109892845e9.28.1742199825093;
        Mon, 17 Mar 2025 01:23:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvXGGv6tXY3ajGLLrOXr011xmJAYRLTHi8JZasNx5okT9lH6f9KisDDn8lGridr/hz5ZTMqg==
X-Received: by 2002:a05:600c:511c:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-43d1ecd60c1mr109892625e9.28.1742199824734;
        Mon, 17 Mar 2025 01:23:44 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d2010de59sm96734785e9.33.2025.03.17.01.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 01:23:44 -0700 (PDT)
Message-ID: <981a871f-e0c0-4741-8e7e-4a4e5d93541d@redhat.com>
Date: Mon, 17 Mar 2025 09:23:42 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/3] selftest/bpf: Add test for AF_VSOCK connect()
 racing sockmap update
To: Michal Luczaj <mhal@rbox.co>, Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250316-vsock-trans-signal-race-v3-0-17a6862277c9@rbox.co>
 <20250316-vsock-trans-signal-race-v3-2-17a6862277c9@rbox.co>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250316-vsock-trans-signal-race-v3-2-17a6862277c9@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/25 11:45 PM, Michal Luczaj wrote:
> Racing signal-interrupted connect() and sockmap update may result in an
> unconnected (and missing vsock transport) socket in a sockmap.
> 
> Test spends 2 seconds attempting to reach WARN_ON_ONCE().
> 
> connect
>   / state = SS_CONNECTED /
>                                 sock_map_update_elem
>   if signal_pending
>     state = SS_UNCONNECTED
> 
> connect
>   transport = NULL
>                                 vsock_bpf_recvmsg
>                                   WARN_ON_ONCE(!vsk->transport)
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

This is apparently causing some bpf self-test failure. (Timeout? the
self-test failure output is not clear to me.)

Could you please have a look?

Thanks!

Paolo


