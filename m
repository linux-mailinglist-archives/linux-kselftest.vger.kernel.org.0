Return-Path: <linux-kselftest+bounces-15307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5336295188B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 12:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152582861DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 10:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443A91AD416;
	Wed, 14 Aug 2024 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="az3FJ5Hm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B4E143889
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Aug 2024 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723630842; cv=none; b=BbfrJBdND8WP1ZEVwkSfUiDf8Y7xOhOupYMvBfOJplaVq7RWqsqCAdTU7YJWq6/YrbaXecLPet1BxwFmQUBO/0r+lqk21YLc1PYhi92HrNJw2x/GQLakK85/HF/a+I4Womw0dTpltBAeMwWHbKG6RyFa9QWW8otgH2/OpZVd5YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723630842; c=relaxed/simple;
	bh=OesaZVG85sa5tJ2CWd0ZRjKD4AAHsYi37iOiX+FHu/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZPUteEvINl8hVUb7XoolkbGoSjXaXgEQWcoapO1/KeSC7BSAlVQ5FoR6ig6cfGdQzg0NOtqODftfDXiGPHPMbgYCpbH0cqHwMhZrqDA9UI96Y4QGQdGacQR6icr7PrtPN/Th0hqHvGnHT5LNtqxPvOOpPw+Z8oTzw7x0gBJvdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=az3FJ5Hm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723630839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArvT52QZCzAIBxygYJAvMZW0y/eajEvYt8KDonFX9zk=;
	b=az3FJ5HmQXer/fpFKdJPs0K2iIhkswSbMm79mIERb+BWPY0+1zHSX2b53LJoQjRtl8g9It
	3RA/e25JqwMidTz3wkhmqm1QJNP8aMe0ratBtlXXJ2v79MeTmq+skcjPCxBLFlD0e+YICK
	NtfHZg6f8ASllnxdEHRyBO5TA03uxGI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-n3G6aHh-NaKZNh5NHdaT8w-1; Wed, 14 Aug 2024 06:20:38 -0400
X-MC-Unique: n3G6aHh-NaKZNh5NHdaT8w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4280b24ec7bso967725e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Aug 2024 03:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723630837; x=1724235637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ArvT52QZCzAIBxygYJAvMZW0y/eajEvYt8KDonFX9zk=;
        b=YzZ3D7VKz+tp4mQ6QvkNFpMrgjUtik2kUsLoVkeMe61F6UwsA0/1QrHs/yzLprqDhv
         pzmT6oAE4b+i34GwHf7+4g2aR3olQoDj+L5xWg1yzGG2BJDLZu3rqAM+3BiPCbp1l2Dq
         iDijitD36KPMRgXwlbaSKO6Ig+JouopY4aU5cbBspDim6zfxErG39q7h6ynhfS7EwDfs
         MQtw5xXvN9JLlCBGX03O7HcWKIls0DM87GOV4ZN+hAYcWjrXYbNoB7gWnum2WAHa+efY
         diYk2K+PhNAX/3BIzLp427nKLaCpfg8IZfAevE02mVWJcfeaLsWas83ibaCJevwSxGDm
         HgPA==
X-Forwarded-Encrypted: i=1; AJvYcCWHw2PdHpB6PmbgGi+RBYbJPUhAXZ+jRNH/HkMJDjwOHJ7dw8ky2EqKhVg+K/ohyb77h+qZV0A8/zSet7Y+pbVGDNdSx1g6L0Y5fG+bgANk
X-Gm-Message-State: AOJu0Yzd1LhctEICihTwrG1LGNYBepwXM/JmNPFFxTrkhX0q//yigwdP
	BXTG9ow6OoT4Mw3RQAPltAqErJx5i7DC9LixwHxX93SS/KHD16DaXtDMp1v4Q+rqX9Jih3mCkKA
	jt43HD+UESm+nG42/oBlv7FWVvTPTLm4wVegpbtRsAsEdAdhxv/rXJLOXVBaWbTtGdA==
X-Received: by 2002:a05:6000:1a8d:b0:36d:1d66:554f with SMTP id ffacd0b85a97d-371777b426cmr1041935f8f.3.1723630837328;
        Wed, 14 Aug 2024 03:20:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWUqTtYdG3Z83woA9aA35QcrGb+K5syL0svoCJ4GlfCHLPwm9xo1NeGshX8quWbWdeBH9ywQ==
X-Received: by 2002:a05:6000:1a8d:b0:36d:1d66:554f with SMTP id ffacd0b85a97d-371777b426cmr1041911f8f.3.1723630836299;
        Wed, 14 Aug 2024 03:20:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1711:4010:5731:dfd4:b2ed:d824? ([2a0d:3344:1711:4010:5731:dfd4:b2ed:d824])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36bea4sm12524894f8f.13.2024.08.14.03.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 03:20:35 -0700 (PDT)
Message-ID: <696bc883-68f5-48f0-bf7e-258b4dc05bcc@redhat.com>
Date: Wed, 14 Aug 2024 12:20:34 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] selftests: udpgro: no need to load xdp for gro
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Ignat Korchagin <ignat@cloudflare.com>, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, Yi Chen <yiche@redhat.com>
References: <20240814075758.163065-1-liuhangbin@gmail.com>
 <20240814075758.163065-3-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240814075758.163065-3-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/24 09:57, Hangbin Liu wrote:
> After commit d7db7775ea2e ("net: veth: do not manipulate GRO when using
> XDP"), there is no need to load XDP program to enable GRO. On the other
> hand, the current test is failed due to loading the XDP program. e.g.
> 
>   # selftests: net: udpgro.sh
>   # ipv4
>   #  no GRO                                  ok
>   #  no GRO chk cmsg                         ok
>   #  GRO                                     ./udpgso_bench_rx: recv: bad packet len, got 1472, expected 14720
>   #
>   # failed
> 
>   [...]
> 
>   #  bad GRO lookup                          ok
>   #  multiple GRO socks                      ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520
>   #
>   # ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520
>   #
>   # failed
>   ok 1 selftests: net: udpgro.sh
> 
> After fix, all the test passed.
> 
>   # ./udpgro.sh
>   ipv4
>    no GRO                                  ok
>    [...]
>    multiple GRO socks                      ok
> 
> Fixes: d7db7775ea2e ("net: veth: do not manipulate GRO when using XDP")
> Reported-by: Yi Chen <yiche@redhat.com>
> Closes: https://issues.redhat.com/browse/RHEL-53858
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

LGTM,

Acked-by: Paolo Abeni <pabeni@redhat.com>


