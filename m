Return-Path: <linux-kselftest+bounces-44953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD03C3AAD2
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 12:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3B0189352C
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 11:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79728314B95;
	Thu,  6 Nov 2025 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUaY63x1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QykzFlY0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E0030DD37
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429676; cv=none; b=QyhQlhAZkazzjFW14EqtU9TZ5vjWTsuboGtQC+kjAVlTRs32iZEncFNBo1tZKiSiG17eDlUZDSD4nv1bTdNE7PzNMyjL0IBahqpcrjsd7Hq6OLkJm7D4UsG0d7hMVHMRGu3M30+7bOMVRPeoH0Nwmsse3/xiUA7xsKkIugTMvww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429676; c=relaxed/simple;
	bh=D0ESafiFnrAHx1xAZJLjIGxN45DgsIeRyNfJcnFl56Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fJF1auzsVRsA9m3B9ZW0BWTklkoy7203TwecwUS/7f+XkJQ9ix/vNqRmj9AEB4jcAsC1MN7gRn05h76M5nEhmRgg6lKkmENhihUheFkWJM1UGtd6AEEWUE0TphPxV+CzpMMWDm+Oz7DsUchnzFg8wnAuYVwspUmYS5sVlEZNYzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUaY63x1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QykzFlY0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762429674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0JviuZOYT5VOJubSBo7kcaUm1NAOOfzcTxwXg/1vMe4=;
	b=UUaY63x1cO40/wbCYMQ3MnWBd+yJ9BQtSze8PMeRUOQht3AwVqCdMW3ks+YqsBq+jWkkFi
	KE/m9umDapcOvE7SqvDtTqvMaMG4I2Up9rFSBFitVJVxB19K88+mttfKDLocGJeJbllB/h
	o3kVEcJmW1iYpK0HigSVjVauCPRqfS0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-rKgQ8VkXMGWZJ4Wem6X78Q-1; Thu, 06 Nov 2025 06:47:53 -0500
X-MC-Unique: rKgQ8VkXMGWZJ4Wem6X78Q-1
X-Mimecast-MFC-AGG-ID: rKgQ8VkXMGWZJ4Wem6X78Q_1762429672
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429c76c8a1bso630145f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 03:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762429672; x=1763034472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0JviuZOYT5VOJubSBo7kcaUm1NAOOfzcTxwXg/1vMe4=;
        b=QykzFlY0LZCuy3V4UnKJjHEt87nA2uZY8ivl9Bs6bCXUVr0Wtjg/AW8OF41QPjaUY5
         SxQpQm+u7NDV7tYxnmmBBbs9y/ofVzOskLTsMHAIupmjBmEVQslSYEY2m8uDkDrxw05t
         0UwORE/od097juxNbnNi0yt/TBKQvwr2bykKtxT7z3RFaSRvdHtoPvX8j9zDM2DzUvKx
         1v+duEob9eLRj1cHep5PESbsYVFgvD0Wp1RquD+IgNorrZg/En6uH/zqHs7UB5Ta/JRX
         JuWG3OVfMRaeQioyzF8GBxYUlbJT7z8+y4mnaI/EpFa9bs8U4KiQS3TrUTP96l2DVX79
         HX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762429672; x=1763034472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0JviuZOYT5VOJubSBo7kcaUm1NAOOfzcTxwXg/1vMe4=;
        b=FXotQGSH8X8THzii2G3n+tCiSK9JQInUjs792p1q9+a26739GL7Qr/XTqRb3eTHh7O
         B9uAeWfHYPqMECkVmWWdo10ilcm9WTVI5lXqAHAu9nqv25FMUrJJ8IVRhhXQrxacZHdO
         xv08XuRuvvLKs6t6YNmiUHPKBoKRctgulByqeKXgD0MwvpW26FRmHhEx1KF/rM4+x8lV
         BEOpAUGZZLtoJNHkuv2nv3H7gUYJeyukW76cD0D6qFnoMn4cFVN3PDgCL24n7H7AEUlb
         Nz69WpPpqxXjlVt9ubMN/9xOGPd6CnpEwWauQznXNHDv0RfTZjTwSDH4e+aPd4x9VBW8
         wgJw==
X-Forwarded-Encrypted: i=1; AJvYcCUtdm8H+S8AhJDd5pPw3oQOwZFWYkkBYelr00DB2Oyey9mdRvLHB5vKsteQxZemW54AcFlPCrlPzLCsrGFsK6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmafQKz12gsjz2TjPysjCj33/muUWSrSFGYlvxRT9/2hOqhauJ
	vG2fkEZxyr0L8/6M3Bqgp+W2x13ycS0joe+LYyVjuCGAS0cxTvcuH3R5iTPveJjvBftwhKqMc9s
	rKVysiQX30Vnpihju9Zba3tPB1tCIcycr1dbYTnLX9ByGWkXSDHfcFdocIv5Rma+Ywodq8g==
X-Gm-Gg: ASbGncscOyz25GKMC2XXMtUlxlP5WYn8gkkpijybXuZ+aZId5EmooLmIEeZ8EYxUYc6
	xYGAoJSHnbLXScE+/vtUURLO3I3VUcNbBsMBlk0jb9eNu2sX75Gp0Ur0kHYrf6xa0A29txVKke6
	MveWQElWZ8oYvkQT6E8MBi3WqjJeeW9Z4WLoGclNRG4Gu4HeJQYCc8oSCvhbngD1YIxoOHie76x
	PuSmi4+gwMGVieg9nblUhOylHUeUkqmsDogMF4/V/H+uoEqflmijf8nDCOSlFuG9Wg2vve1i96h
	YDKFeLMg8w+he0LZX/Eb9QuOD8ER328UxqpU1yFmV/nO3xfe1XtKcGbU7Tr+7auaSMcdI8JnEk0
	gEg==
X-Received: by 2002:a5d:584a:0:b0:429:d0f0:6dd1 with SMTP id ffacd0b85a97d-429e33396cemr6850997f8f.58.1762429671739;
        Thu, 06 Nov 2025 03:47:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyM0CqjbrXAtnYkiBBxwxzEmqQL7alB7xzeOenRekpIf1Zfq6usduu0337jFWK1+wDdZonKw==
X-Received: by 2002:a5d:584a:0:b0:429:d0f0:6dd1 with SMTP id ffacd0b85a97d-429e33396cemr6850974f8f.58.1762429671254;
        Thu, 06 Nov 2025 03:47:51 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49c2fdsm4632849f8f.39.2025.11.06.03.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:47:50 -0800 (PST)
Message-ID: <981dbc10-0833-418e-b389-93e0daee8acf@redhat.com>
Date: Thu, 6 Nov 2025 12:47:48 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 08/14] tcp: accecn: retransmit downgraded SYN
 in AccECN negotiation
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
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-9-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-9-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Based on AccECN spec (RFC9768), if the sender of an AccECN SYN
> (the TCP Client) times out before receiving the SYN/ACK, it SHOULD
> attempt to negotiate the use of AccECN at least one more time by
> continuing to set all three TCP ECN flags (AE,CWR,ECE) = (1,1,1) on
> the first retransmitted SYN (using the usual retransmission time-outs).
> 
> If this first retransmission also fails to be acknowledged, in
> deployment scenarios where AccECN path traversal might be problematic,
> the TCP Client SHOULD send subsequent retransmissions of the SYN with
> the three TCP-ECN flags cleared (AE,CWR,ECE) = (0,0,0).
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


