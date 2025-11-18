Return-Path: <linux-kselftest+bounces-45860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1A0C693D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 13:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 95AC42ABB2
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 12:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B5C350A15;
	Tue, 18 Nov 2025 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzydCrSA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/YRxWQ2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A9632E13A
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763467350; cv=none; b=f7QHdNllkx+xFLYfc45jh2kkPbD9jChOMRQc4olSYNYG5/0T24dXZmneu68li4t+/w6eFee+bBwtCbaDwtiVpZREG58xVUyjup8Oi1lIHIoBXkhfAPfym8yKKxmxDqZZKrfPMEus9fqgggFPVzWR20VHC9rm00IU2sQZKlWGbug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763467350; c=relaxed/simple;
	bh=WESiHmXnNlbdDWvUDg2JYyETEusd8ierS+wGRLf1eUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mktZPtUfwP7QSpRtzFkL21eGHL2rRbe+uC8Cz+6IprffG9GdJgrUYKGKU2mT5S3ibm1sDILiCWHRd7DEGSCBYcpFNUSGhY9zolrZd/CgCNtPUFkCAy8ua34U8eH0ax4Hy1g4wIFi0bgF4yS/mWzjcjNAR307GphY7eGOEpthgcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DzydCrSA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/YRxWQ2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763467347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c1i1D0Pw7oFyRhkqVPQdxod01xxz5lck/BaJyW2U7Kc=;
	b=DzydCrSALxKCMAu1SZI0AR/MCAgYGmYRytC3yOgZ66aXNGpA45vP8kzecZ7xs45GC+G9z4
	5Yss63XLg5aSGOxe42zMiJ0xg4HhNYBvlbH7fPXsH1fyy09SdrRG2Mj1Y0JqOkf27J7hFx
	dOUk1QBm2PRNbYT48QZPyJs7gAl4os0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-D-Ap0fKjMNCP1WN-mxvkEg-1; Tue, 18 Nov 2025 07:02:25 -0500
X-MC-Unique: D-Ap0fKjMNCP1WN-mxvkEg-1
X-Mimecast-MFC-AGG-ID: D-Ap0fKjMNCP1WN-mxvkEg_1763467345
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47799717212so25578135e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 04:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763467345; x=1764072145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c1i1D0Pw7oFyRhkqVPQdxod01xxz5lck/BaJyW2U7Kc=;
        b=R/YRxWQ2SMSzQUbsQAvTbRaItCqUi2N1q3QQJzyNCF5rUZXGyzVRA6MX/P3lpSxEPt
         tOIX/7Edg6Qdl9f/O6J+QC8ctoU1LhrjCU0nKI8KO4RuQRrrbZhA7GIO2U7uvz8Tetwq
         NhnjZMvAQ/j1ym3qbBfD4BL6hkaXYJ+vBTrzIA3m86DRZII0T++h9zYPrvqg6cjkhp9I
         eYWPKNNJnapFg/Qm6im4fDZxhZK/YvGPNTR++p/oqclvZEhEej+vuWZ5daLJi+eBXUTc
         t5AYwxZKuVQBZNNGPKRPOFOvDB1A6suX9fPHNyhJLrFGbWhzNUtpzFtKTd/w8epbRPAx
         yTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763467345; x=1764072145;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c1i1D0Pw7oFyRhkqVPQdxod01xxz5lck/BaJyW2U7Kc=;
        b=GgsvwXYla2fE94aXDi5mxZP7h0Zn0YXHyoDLFYVg8+79i7OgHlbZjNtR0DrS+JMdvo
         oN3OhXWBc+d2p0an/U1OzZGroQ4RVTAaxGfaICOrTIw6K6ggT8ryQtdhAeMLbj74Sj0t
         V5f7tnzzpBnjDP0tMpjyp1kA9godeQCD1nvvPDOM3LrZkmilmZxndDuA+uSDnRE5SdGS
         wEwxXBo9p9yycoQhiokxo0dyLH6R0Jt6s17Ej4bxhymnqFlXbygAt1zNGb24lRjfMWwB
         xH2gogJcg/k6o+5narfEZ9btmKu28eAdJIOFc9el/JSFSYLa5prysgEvio7m13FVTRZ+
         c+qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUTV6/pPW6ucJpx2Qpg9KzYYeQWCK91+DoMaCkK1MyK0xyUrUuFmhPuqRY7im4V/WByNfouneND3ssiWDlEh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKVeYNvNCw8kb1KAkm5ppIglIur/F2hNUflOuDErGnWe8zWDfK
	6XynmJZ9sKPRDndBM2RczxrzfqomK0dZNXwSG0AbqIzOfABFmdXp0/dd++nPKfe4MjMGX+dix0o
	Bk2JoXe2SstHHwNPr+6XfXeniDE9Jbp+9jB5X3OUzkaiqP1fdE+5XrSrpCid1bQBCrkygrw==
X-Gm-Gg: ASbGncupBM7Z33uGhlaiew0Tzj4Cu83IBMO6i5bPjh3dApcuCstRvc9sgKbwKYmEYaC
	Y4Vl9UgaiL+OJrG3xJsI4kSeKWoxe0aK6y/rlj1p/1HRdmzVjVXqzOFNvZwOXZXqXHoLItSb8Qs
	F3xy4fnhJQw1PiWc5JNuzfDDUd19XAgJ5SqfKD/IPjNZAbi6wrNeg+tlx4SagvCArbnguGXZuRg
	v46TzXuRi7Qw4CN57/ZmOLhYunY5jYigwLXfSO7nVUVQZT5E0TpyCuat6BYfMo95I5cZT2rm4JB
	9+ab7L3yA9I+sLPyY5B+JLOj/0TTtVPnVGGasEjE+Tcx0ZO66FNJlmrmzEykdt2v7cmS9autHLr
	s4C18p4paQN4w
X-Received: by 2002:a05:600c:6289:b0:46e:37fc:def0 with SMTP id 5b1f17b1804b1-4778fe62100mr150046095e9.9.1763467344595;
        Tue, 18 Nov 2025 04:02:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIbPbD3fHl61Z9bqUbxf1dmLAfvuvlg8WHRxbMNqZy32h7ZBzMmci6k7t6kXMAsw9zXDp8Qw==
X-Received: by 2002:a05:600c:6289:b0:46e:37fc:def0 with SMTP id 5b1f17b1804b1-4778fe62100mr150045425e9.9.1763467343987;
        Tue, 18 Nov 2025 04:02:23 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779fc42f25sm156990785e9.6.2025.11.18.04.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 04:02:23 -0800 (PST)
Message-ID: <d87782d4-567d-4753-8435-fd52cd5b88da@redhat.com>
Date: Tue, 18 Nov 2025 13:02:20 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 03/14] net: update commnets for
 SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
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
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
 <20251114071345.10769-4-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251114071345.10769-4-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Note: typo in the subj

On 11/14/25 8:13 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> No functional changes.

Some real commit message is needed.

> 
> Co-developed-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> ---
> v6:
> - Update comments.
> ---
>  include/linux/skbuff.h | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index ff90281ddf90..e09455cee8e3 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -671,7 +671,13 @@ enum {
>  	/* This indicates the skb is from an untrusted source. */
>  	SKB_GSO_DODGY = 1 << 1,
>  
> -	/* This indicates the tcp segment has CWR set. */
> +	/* For Tx, this indicates the first TCP segment has CWR set, and any
> +	 * subsequent segment in the same skb has CWR cleared. This is not
> +	 * used on Rx except for virtio_net. However, because the connection
> +	 * to which the segment belongs is not tracked to use RFC3168 or
> +	 * Accurate ECN, and using RFC3168 ECN offload may corrupt AccECN
> +	 * signal of AccECN segments. Therefore, this cannot be used on Rx.

Stating both that is used by virtio_net and can not be used in the RX
path is a bit confusing. Random Contributor may be tempted from removing
ECN support from virtio_net

Please state explicitly:
- why it makes sense to use this in virtio_net
- this must not be used in the RX path _outside_ the virtio net driver

something alike:

/* For Tx, this indicates the first TCP segment has CWR set, and any
 * subsequent segment in the same skb has CWR cleared. However, because
 * the connection to which the segment belongs is not tracked to use
 * RFC3168 or Accurate ECN, and using RFC3168 ECN offload may corrupt
 * AccECN signal of AccECN segments. Therefore, this cannot be used on
 * Rx outside the virtio_net driver. Such exception exist due to
 * <reason>
 */

/P


