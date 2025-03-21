Return-Path: <linux-kselftest+bounces-29591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A69F7A6C4D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 22:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090DC169FF8
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 21:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1930922E414;
	Fri, 21 Mar 2025 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZVRI8Gc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7459522CBF8
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Mar 2025 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742591305; cv=none; b=CKOtcBydDEWSraGhFRIXCCG0LiH0Y9eT8feJ2gZfPCpBpGUwSlUx0dLKYH5/omO/0nD+4lDZ/MQTsYvniHJnCt546j1sjObrIsGu3mQfAHsSslOsTF32eanzWjs28XCgjH6Y6QRI+vR09JpypkLWrrrIVh7J2zRkD9NSZMr1CGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742591305; c=relaxed/simple;
	bh=OByW12Ve0fpZVXNs6aQ0h4RP1YKFcy4WV8juU5zXTxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYXLm3tdITR0zR88CSaVDQnAuAZaLRr4gYSFa2QiCE+r8BS/fs4ITIdOtbGiiXcGtHChm12YZOINUyYLmb7WOAyIFsU0gqwbwalo1NTg9cMHDpe38HrOp6gfXmjehWRD8TQ2Pr7HO+G+28ru7IoB9z3kVgF9IhhGYR5+QkCREAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DZVRI8Gc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742591302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgltGrzJqg2st6HJvgrt1xVAH1sJSHek/6ESfVQKA7M=;
	b=DZVRI8Gcrlu0FkK401bcP4iAZifTorvtmchbFW4FuTokz7d9kDuuQHdeHS/TyCrwW0LMfM
	QaMYjFbTRCo3cxKShrD6mdiaHX98PmK+3Zhk6mQx1sSA02UXbXw0f5YQNRaFpH9dFoMLRX
	vQLV0wEdHH93SUbxNVBRa8BOs255KK0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-16Eu0lDGPlOL96QKha3Z_w-1; Fri, 21 Mar 2025 17:08:19 -0400
X-MC-Unique: 16Eu0lDGPlOL96QKha3Z_w-1
X-Mimecast-MFC-AGG-ID: 16Eu0lDGPlOL96QKha3Z_w_1742591297
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912fc9861cso1064158f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Mar 2025 14:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742591297; x=1743196097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RgltGrzJqg2st6HJvgrt1xVAH1sJSHek/6ESfVQKA7M=;
        b=o7jv+wA/qxBeAJigqD9V5iOWvJivRe2wQMqPHkaoiqzKHDBYC8sr/+zxY1wa6Q0J5c
         pB7tSiMiP7KrLqzfARh2RqBOXzCPIsvsPTicbRemuDloWTsIFgZgZEWBh1b2Kwq/D6y3
         e3ASu1G91VXXKbMnrSG5GaYlahr9As+X9PjnAZ6YI2vYdllxpFTHoWQxE2e2Duhf2NfD
         8Wci8+tL4bJUl9Tn9Ad9N3AkNjZctqtCvJfK8sfrvak3Ntbl0tNvIKnAdSshqSevmzvu
         kbxkxA9honaTOl+VtAVAnBsNiOtow0CfARz5hO04up2FIsr6pT2MLuTuZAnvVZiPWNxh
         kdEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKI7ih2AVtX+t6erXic/pcI5viVCH7yCg8kz3o+9ognF6muyo8Nu0v6FSFHFoYgwY5Frn0jEpcFQvTHcDl2F0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww2jvaBxFfrZC9weq4rKAJ1Sqh1B9cv1CExsuuyO/D8PregocT
	/pVeSFKzxWbQowX4dx4hR2IZ8y2lanBzlq8lP0Cxp/w2Gy95aeeBQUpBIzTnXPmH5BGLsIayiqQ
	70wD4GUIVQBcoDUAZVBNFVC6Z5+o5I/amfPvrdKbfXtQrfD6ufjGHTkiaEgOerZQWhQ==
X-Gm-Gg: ASbGnctFimQp1zFynF7mVjRxajUiwuiWBuyIsKnUfTxJ1b+RrtfQoqSmkpizFvAWbGx
	IazSxjn4ZigLTLVvoeGoFm4E+6ugvsDdX28eQIlTH9E4Bl28xekzDf11AJhtsqGm2cwSaEekT4v
	EVbx24L7lx/ADvSmSU+bT2r5yqm/HjKCu5+9ytwR7PNkeQJKovkWnMP4DFT6/vM/k5ajxsI/wTr
	QpSYYQAVfyLbEDdSOU8RwvYz5gQ2tbw+pFNcZzijBH3hLlGWCCtMbe8QobCSS3qsOCeP2zp1ICZ
	ZefgZc1jsb3jLHUuaSEQW3oM6JupIIrCA0MpmFR8EMSWAg==
X-Received: by 2002:a5d:59ad:0:b0:391:3cb7:d441 with SMTP id ffacd0b85a97d-3997f90d30fmr4908506f8f.25.1742591297049;
        Fri, 21 Mar 2025 14:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERkSaLPvjOg3of5q9RHcYoHxuYgujb3iqhlb7BNZGhZ8idpUjjKHfSk0mQf0ZrvJlxGHEdlA==
X-Received: by 2002:a5d:59ad:0:b0:391:3cb7:d441 with SMTP id ffacd0b85a97d-3997f90d30fmr4908486f8f.25.1742591296572;
        Fri, 21 Mar 2025 14:08:16 -0700 (PDT)
Received: from [192.168.88.253] (146-241-77-210.dyn.eolo.it. [146.241.77.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a31a7sm3335236f8f.23.2025.03.21.14.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 14:08:16 -0700 (PDT)
Message-ID: <26f2f366-aa14-4879-978a-58d46f9d83a4@redhat.com>
Date: Fri, 21 Mar 2025 22:08:13 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 net-next 3/3] sched: Add dualpi2 qdisc
To: chia-yu.chang@nokia-bell-labs.com, netdev@vger.kernel.org,
 dave.taht@gmail.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net,
 liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Olga Albisser <olga@albisser.org>,
 Olivier Tilmans <olivier.tilmans@nokia.com>,
 Henrik Steen <henrist@henrist.net>, Bob Briscoe <research@bobbriscoe.net>
References: <20250316152717.20848-1-chia-yu.chang@nokia-bell-labs.com>
 <20250316152717.20848-4-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250316152717.20848-4-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/25 4:27 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0dbfe069a6e3..987686e91919 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -30,6 +30,7 @@
>  #include <asm/byteorder.h>
>  #include <asm/local.h>
>  
> +#include <linux/netdev_features.h>
>  #include <linux/percpu.h>
>  #include <linux/rculist.h>
>  #include <linux/workqueue.h>

I guess this chunck is a left-over... in any case it should be dropped.

[...]
> +struct dualpi2_sched_data {
> +	struct Qdisc *l_queue;	/* The L4S Low latency queue (L-queue) */
> +	struct Qdisc *sch;	/* The Classic queue (C-queue) */
> +
> +	/* Registered tc filters */
> +	struct {
> +		struct tcf_proto __rcu *filters;
> +		struct tcf_block *block;
> +	} tcf;

This usage of anonimous struct is quite unconventional, the preferred
way of scoping fields is to add apprepriate prefix to the field name.

[...]
> +static bool must_drop(struct Qdisc *sch, struct dualpi2_sched_data *q,
> +		      struct sk_buff *skb)
> +{
> +	u64 local_l_prob;
> +	u32 prob;
> +	bool overload;

Please respect the reverse christmas tree order in variable declaration
(many other occurrences below).

[...]
> +static void drop_and_retry(struct dualpi2_sched_data *q, struct sk_buff *skb,
> +			   struct Qdisc *sch)
> +{
> +	++q->deferred_drops.cnt;
> +	q->deferred_drops.len += qdisc_pkt_len(skb);
> +	consume_skb(skb);

Possibly you want to use kfree_skb_reason() here.

I think this patch is still too huge to get a reasonable review. You
should try to split it further, e.g.  struct definition and parsing in
pX, dump in pX+1, enqueue related ops in p+2, ...

Thanks,

Paolo


