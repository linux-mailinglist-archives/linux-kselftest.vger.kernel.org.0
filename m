Return-Path: <linux-kselftest+bounces-31867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 601EBAA08D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 12:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B691B65CA2
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 10:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E922BF3EA;
	Tue, 29 Apr 2025 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L84mSrcS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C4C1D8DE1
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745923559; cv=none; b=R5Ld2svSqHkhX4edDv62SEFLvKp9qaIGt76r+eREQ9RG961PoNhdFt0358NlE2HJvlT3EuTKhvONUnXzpkOHDpJ1+tTPpNXRRieb7tmoK9Xuhs4YsFBG8qe12EQRnD5H2QZ+gGYkFOJPsxrZtSMMNpVRFuGfk0q9wIWtQMZXC64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745923559; c=relaxed/simple;
	bh=0NSKurciESBFEUjfZdIo82rXaTeTXcfkyDzLrLZIYIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ptzn9YiVzw6r3cZiRMqUBHsdxEks1R3wvjIQ1TH17WUl8aXc+6jS2o3zFAMsTVRxWzphYtPEJOtpv5qjt6JOX+brQir2r65NG9blA1WAZmT+h7HVgmn9TPPzydT1H4JxW9KWanXXcu8+hl24JXeTOkpXUTKrm1H8yRQtnBqFRAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L84mSrcS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745923556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aN+UKNlb4Wy7kol3NSyz5lz02pJ0x8EuJYg2sYbM+jY=;
	b=L84mSrcSu7ocwOKurliAqhnA7QSYblF1Nlr7KtbYHKmhdIW+VSGSTpvsCvCfEFEzuqg/6v
	/gEX7278ymfSdpDxWl+BflUzP9q/lVNDAVU8i8x2PLMom0GnFsiXzP3wxZiLqVlA/zj7dI
	2MFWGv4AiNxwOMwobQQEKrW1HHhBc+U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-eMSMK8VAOEigSioCX-rNTA-1; Tue, 29 Apr 2025 06:45:54 -0400
X-MC-Unique: eMSMK8VAOEigSioCX-rNTA-1
X-Mimecast-MFC-AGG-ID: eMSMK8VAOEigSioCX-rNTA_1745923553
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac79e4764e5so561910066b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 03:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745923553; x=1746528353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aN+UKNlb4Wy7kol3NSyz5lz02pJ0x8EuJYg2sYbM+jY=;
        b=eKvhz78H+huJFeHfCZ70oMr0W5qGtZFP60JVYSoZ7blTYHonDqvIMwdNfbx8ZxM1yt
         tUDh8m3vUaFzzIDUnRy/cxhAkiJm2cRrL41hSlpaYsgSZezS1oZQ9DI2442RUoSOls4z
         VHNHC6RrV8CSJYW9eWBSP3xDGBmNGgMlHibcN/45wyfaSItgMTbRbXNrZMOeBgwdz+gh
         Jhpd+SC7aJ+OUQy+pgNyv1tOw1c7odh55JzxGE4ecLPD7mqF+CtSMok6cgqxcwolZrNM
         L3r8+egYkXGxMKo12p8PNEnqsDjkom6lABf31Tf+JseRr+6DQubX5MNm1saLqZ4mopZ4
         sVSg==
X-Forwarded-Encrypted: i=1; AJvYcCUP6BZKKDFoEInICAo5O17iEeP8tV23R8KZ1VH0Io1ZDSckZrx1PP3GDu/la9J1UiWwCHmWie6+TVMCEkAcZ0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeGXhDKUPAS5CzTuC7LOmowPvusTGAeXjCgeDZp0BtReOoMFDP
	W+9Y2rmKYnhAd3nP8gi6qrjRxDVdTaf1peaA263sUZRRHt1FnGIDgosErXbrsyUfECtBVWvECWk
	q2U0iJWY6lz0h5wBEKV2708PoniIvjMm4yn9R1IL24CL2eOQ2P5c8oQcOr42+qGR+yA==
X-Gm-Gg: ASbGnctcLs6P/zk4ijsbaQ/Ku1eWN8u6aA4iN2yTNBTz4laNgrYSeuLeUjbpFYEuhsF
	MQnqL+6RMBuva53Yq/5KTm31kuhoSC4QDttYISUgv0GOr28PGQo5/5LAFwb39JbZL4RlvU+6k+M
	mqcTQ2ggCQ/w41BonnA4Aea77ELcOteeh0fLiva+l3aeiCXEKQmz4+cCdUvFCqKtuyRJaa1FCIA
	LdDJsAhNyLpo7bEoJfsvAJGokLYzN+Z0seA485QaaBJ6/QoJLrn8/vYZan6gsOF14wrwyx3air5
	yAe6Y0oKSsnCrVzjV+io4MplIn/CYO5jfu6eQ1uCPIqVHOoG+QcUeWfAPjE=
X-Received: by 2002:a17:907:7289:b0:acb:52cb:415f with SMTP id a640c23a62f3a-ace84b279e1mr1102946566b.48.1745923553464;
        Tue, 29 Apr 2025 03:45:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGozcf6FjAPnL3LZPQMJPZBCYzwfasWb1qRqTn81hns/gqHo3eKbml0IfXHZplrtmlSv+ODGw==
X-Received: by 2002:a17:907:7289:b0:acb:52cb:415f with SMTP id a640c23a62f3a-ace84b279e1mr1102942166b.48.1745923552966;
        Tue, 29 Apr 2025 03:45:52 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897? ([2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41cb08sm772460366b.19.2025.04.29.03.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 03:45:52 -0700 (PDT)
Message-ID: <5f7897f3-5225-4f86-8596-a5793989a9c3@redhat.com>
Date: Tue, 29 Apr 2025 12:45:50 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 05/15] tcp: accecn: add AccECN rx byte
 counters
To: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org, dsahern@kernel.org,
 kuniyu@amazon.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 dave.taht@gmail.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
 <20250422153602.54787-6-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250422153602.54787-6-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 5:35 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index af38fff24aa4..9cbfefd693e3 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -303,6 +303,7 @@ struct tcp_sock {
>  	u32	delivered;	/* Total data packets delivered incl. rexmits */
>  	u32	delivered_ce;	/* Like the above but only ECE marked packets */
>  	u32	received_ce;	/* Like the above but for rcvd CE marked pkts */
> +	u32	received_ecn_bytes[3];

I'm unsure if this should belong to the fast-path area. In any case
AFAICS this is the wrong location, as the fields are only written and
only in the rx path, while the above chunk belongs to the
tcp_sock_write_txrx group.

/P



