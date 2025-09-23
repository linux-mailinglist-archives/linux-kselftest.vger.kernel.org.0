Return-Path: <linux-kselftest+bounces-42144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E2BB95614
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 12:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBA8190251B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 10:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253582ECE86;
	Tue, 23 Sep 2025 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fscTTd83"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697F713B797
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621906; cv=none; b=RoP+qsjhDCk1MQl+DQDLn2TxecEy5pSzqnyqwhwu2JZPqDovRKjiLifPSRGT55ebyLKr07s9zO8/63swfxrAjh8t/9T7RU5Z53wLk+LJqlu1H5BZ2ZgRX4zBPkSmQ9MwIsyDN/GPNBQPR8FwFonz+VwLwl89bYwRSXPZOokc7dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621906; c=relaxed/simple;
	bh=ZumSwhxH522m/LliPqf9t5tJA+MJDBIhWI+I852334M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DnN915HNEuu3tC/SY+FCtlaUEsy6NgQryeQyE3+b6BVUdTtOedFgaeajCrBU//YTpYShiKTFLiyC9s/ErbrQ2v92p4+EIo5ImSZpskVcNnz3ki1kOKBn6KlmALakIzojBE8rOYaGBEKdh5Q4m9/SP2+7IkZH2uCvtkQ5k5eTNg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fscTTd83; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758621902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MlXEXY9viVFYgaW7HM7/EGwK4GqnOUp4Wcb/T7Io6s=;
	b=fscTTd83rxPbkWP1sUCnnvULMMOB9UtIprODnFxnmM5LSo7jo/UPtXXr11+iNKLx8jHDxS
	+yueW/YUw7QlUVOTPvSDimmafIWZgxRcRvs7CqFxxGYAkyft0AN0B93alIEs/2vMTkDUAL
	qZArSgEA+Xne/2hf/I5W3wZ7wW+fIaw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-3KygzgI3Pw6CBgsB3zG9Bw-1; Tue, 23 Sep 2025 06:05:01 -0400
X-MC-Unique: 3KygzgI3Pw6CBgsB3zG9Bw-1
X-Mimecast-MFC-AGG-ID: 3KygzgI3Pw6CBgsB3zG9Bw_1758621900
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46d46692831so12803895e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 03:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758621900; x=1759226700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8MlXEXY9viVFYgaW7HM7/EGwK4GqnOUp4Wcb/T7Io6s=;
        b=Z3NAPDS1fsk84kZYRiLxlrRaK0hx9zdUiJ417DgkDaTgFEFRQXtgSsFRZ8zY5XtZ1v
         YwHlyLNlCT0l+ph4vpUG3pD9bOB2+ooNnhotIDqcvWKFkOxt6ov6ae52LMyjkuS7JR/3
         05P/5xYZcuSPrgHHN+N0wTyGxmroGIOBBFe2A762hrXNJq4/ckJMwIh3veJxH7g5Ppop
         ioZgz5U8GI5F4XMjyeUjZw7bTqs1vABFEoKjQ8X6/BpgMhaQWStFoWDv889jC61ejRYJ
         VuGrIT5osTIxgxD/X0Xax7xXYiuFSJMsWM4jfPKZP6kZbbTMbKAYfwazNm1Ayw6/6V5G
         RrnA==
X-Forwarded-Encrypted: i=1; AJvYcCUc87347uUwftOeyqV09a2od8ABNdE5JeBCv/cs6HCkgMqmpsbUJz6V6m5DWuP/TMcIRZqP3XGDxwZoV+bpI6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGeu0kN/jK+mP5UPqX7smnVQTtv6ENarZAlQjKuAhkutjc0zfL
	84rFwEDFlW6Ib8HtUSZohHz/fQxTbYt7JlOcLRrXEGAVMXIB2ahLHiLXQWL+HiEFhjovH2hSEnz
	VydYwMCoy6wXYbHGRSsAe+ibyBw6StQ3PG5DK+PvM+pHEGqMq4gXKHY3hx4QdW/GekgRjWg==
X-Gm-Gg: ASbGncvKlJQtl3YYKRCwWVNiHWrzlv/9TBkNhL/KQNSsWX7F5999VdqtYojEGbIzP98
	EWtYmyrVHdKl/AYBo8gCRuORfo9i/clFfFfH9WzNvERaWPb3MSRM9glKimiQtEQCG0kKjOmAM1N
	loH+1yj5A7DRwyBWAMl7WSWY/wmxk5vnqhip4pIc+91zmmF9UmHKa++wuaCIn/0ETnMIfrlTTYs
	hhzPeI6E7lhud+2qCztQsFIBnqOHIryD+pbTK1XCDIsvdnoT03rDxPEdtklVmHJjz+2q80HZteo
	scwkhYCmckeBxPc+/Ch85ni1DjmhxREOaQeyZBUE3kw3Od03rkLF1l6gBQWEsOLWDavFbY1olTl
	6VEaz6iCFCz+T
X-Received: by 2002:a05:600c:c8a:b0:46e:978:e231 with SMTP id 5b1f17b1804b1-46e1e0aec9bmr21981475e9.17.1758621899795;
        Tue, 23 Sep 2025 03:04:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI25GAUzFMzn1I18q3eiplupnGbcDgSnNTWVjo5qrpHHjC0ezlLXo+X0Ba4DizXVJNpGvdsQ==
X-Received: by 2002:a05:600c:c8a:b0:46e:978:e231 with SMTP id 5b1f17b1804b1-46e1e0aec9bmr21981025e9.17.1758621899350;
        Tue, 23 Sep 2025 03:04:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-403ec628ff7sm3599419f8f.4.2025.09.23.03.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 03:04:58 -0700 (PDT)
Message-ID: <476c5c79-bc37-4c41-865d-d04d1d6974c4@redhat.com>
Date: Tue, 23 Sep 2025 12:04:56 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 04/14] tcp: L4S ECT(1) identifier and
 NEEDS_ACCECN for CC modules
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
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
 <20250918162133.111922-5-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250918162133.111922-5-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 6:21 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Two CA module flags are added in this patch. First, a new CA module
> flag (TCP_CONG_NEEDS_ACCECN) defines that the CA expects to negotiate
> AccECN functionality using the ECE, CWR and AE flags in the TCP header.
> The detailed AccECN negotiaotn during the 3WHS can be found in the
> AccECN spec:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
> 
> Second, when ECN is negociated for a TCP flow, it defaults to use
> ECT(0) in the IP header. L4S service, however, needs to se ECT(1).
> This patch enables CA to control whether ECT(0) or ECT(1) should
> be used on a per-segment basis. A new flag (TCP_CONG_WANTS_ECT_1)

I find this description confusing/contradictory with the implementation
where TCP_CONG_WANTS_ECT_1 is actually a mask.


> @@ -1322,6 +1328,18 @@ static inline bool tcp_ca_needs_ecn(const struct sock *sk)
>  	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
>  }
>  
> +static inline bool tcp_ca_needs_accecn(const struct sock *sk)
> +{
> +	const struct inet_connection_sock *icsk = inet_csk(sk);
> +
> +	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ACCECN;
> +}
> +
> +static inline bool tcp_ca_wants_ect_1(const struct sock *sk)
> +{
> +	return inet_csk(sk)->icsk_ca_ops->flags & TCP_CONG_WANTS_ECT_1;

Should the above tests be:

	(inet_csk(sk)->icsk_ca_ops->flags & TCP_CONG_WANTS_ECT_1) ==
TCP_CONG_WANTS_ECT_1

?

Otherwise existing CC with TCP_CONG_NEEDS_ECN will unexpectedly switch
to ECT_1 usage.

[...]
> diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
> index df758adbb445..f9efbcf1d856 100644
> --- a/net/ipv4/tcp_cong.c
> +++ b/net/ipv4/tcp_cong.c
> @@ -227,7 +227,7 @@ void tcp_assign_congestion_control(struct sock *sk)
>  
>  	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
>  	if (ca->flags & TCP_CONG_NEEDS_ECN)
> -		INET_ECN_xmit(sk);
> +		__INET_ECN_xmit(sk, tcp_ca_wants_ect_1(sk));

Possibly a new helper for the above statement could be useful

/P


