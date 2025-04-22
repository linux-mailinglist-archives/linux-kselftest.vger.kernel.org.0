Return-Path: <linux-kselftest+bounces-31288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 218EAA965C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 12:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EFB8175187
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 10:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A5020E00C;
	Tue, 22 Apr 2025 10:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZIUraCM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E827020C49E
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745317286; cv=none; b=hNd30J6jpPx6iYc+HyxE5ozF0/P9w2lEheh7MRKRk1MRBFhtVwU+tU/GgOhRvsHjBRNRuMR4Kzuhm7qh3GRiK1UqTTSqmD9DWZv9zOclthwGFCFQgzlah8Td1+3IK0fPKM1dXDi1va7+8UK1byzDz5b2r7DlZrLnqtdKwzw46X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745317286; c=relaxed/simple;
	bh=TYTDUcslDoOfEDL8WgCEKVmORgs+59nZqp7WHQ3s8xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXNp2QetW9VkIKquX0Ed2fCcONGAqLIAX2K/ij9mIwCsjMJJGVWR63fmFgBkt3zPyCoVXB+7zo0GZbBgwWTGyk+4UmYVDNGROBuJ6602nbScQCs6ETrEryit2HhU8fEwrb6Bah9fyIbEinx308B0lWOdv1qFDwgDPXsbZgh+2PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZIUraCM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745317284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0ZYpeioJZ2jDB/cEJqcZLeqV9YgXQFIexoS6m6z+Q0=;
	b=BZIUraCMopnO42izUdqozpVGBM7Bw+VoDNpCmm23yKmgFFlSsXvPlnxpba19kdcZbsLgkq
	VzhtUQf29nrJA2jMoNVaxNnsB02uXr1xc/YDrPMcibQHpbdgIk3sI9NNJ0iagwoIeqgEij
	uC826dE8Y2jF+dGBZJ2Lx24FLxA3M6E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-FAG97X4pOsusjdnAaYA-bw-1; Tue, 22 Apr 2025 06:21:22 -0400
X-MC-Unique: FAG97X4pOsusjdnAaYA-bw-1
X-Mimecast-MFC-AGG-ID: FAG97X4pOsusjdnAaYA-bw_1745317281
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3913b2d355fso1428541f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 03:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745317281; x=1745922081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0ZYpeioJZ2jDB/cEJqcZLeqV9YgXQFIexoS6m6z+Q0=;
        b=lvOM4jxE7h5+k2KI386nfZv2NTd18QmaBRCMfJFkKUztVnjAxoymTWb9a8WCRVLZzx
         kvYrwHN+gCeh5KDZlO3OmBvXcb+I0j097ucJckDlB6qBTp076yTHKtNbZku6LJ74fJ4o
         1ESbFKLN6aipz11K2Bb7GzX4KdpJYr0xC51jaRtDfOZLDNiLywXbTCPTfazEoJLnS0Xn
         U98gmswHo0vbVVk5i/pVoceseEWCn/xCHEp+C3w8uFiTmc8G5qDA7zU21DBoBtJ7T6eD
         AIkyR8Ft26skYldea2qh0WiKtT0A4MtAtZpqYy2AjbR3KMIYwsoFx6OZWC+Jq3uOeYw6
         +xEw==
X-Forwarded-Encrypted: i=1; AJvYcCVi1Ff29bpMC8kdWjdrGbOS1NHHGBIOr+pqWL1f3bFLSlGwtmc/8awJzHi0FYNxA8X+KApc2ehdv21aM/kCLy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz46lmHN7d64UaNfG+snPofx8QTZYml/Qcjw80QzeVEZ2OdkanS
	Z3xA/fLupzLRXlhoLBN47csOBzyEHR4K50bivxjV9qzFSrrBm12j9nUV9vhlNxl0gbVftWd5VHV
	k17njLKUI0G4Zs6MOUz2pqPKBiQOCM8Qb43OVQI/51luYjZXeqZGv/fRdnzbIph3bHQ==
X-Gm-Gg: ASbGncsTrApmPma/Yhz73uWNlG34HV/VjukkauBdyoUdhuhB9OL8sFvpVVCiRQFWozY
	wK21XCl+2ohe8IzG2kh29iwmMCHDHZWYnWbwK5vUmYVk1ObgoUsj6oJFNQzkPr7YuKbxoRivEZ7
	lY2w3TEGUXkhYa8dpaAI8s0FnSHtLDFgF3fuHz3XjUrjzloFQ/Xybe++5H1Nn0CFB5aq8I+Vttk
	TCfbw71A56JYOS2JJpERl3x9pYfHlYITUQRaKco6Kdb0fXQmQEtkWctCq6qCWnOwZWHzmemoy4I
	PwXmTXfJUUpNCXQt668StJB3pO0k2vrVitsq
X-Received: by 2002:a05:6000:2485:b0:391:4559:8761 with SMTP id ffacd0b85a97d-39efbae004cmr11182269f8f.36.1745317281310;
        Tue, 22 Apr 2025 03:21:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtTZCnU9DNSZC2KRCnxqlkBPAHgyu/4YMJ+l9HN4PfmL5c/0x72KL+BpoC5GVKi5gVTnYkew==
X-Received: by 2002:a05:6000:2485:b0:391:4559:8761 with SMTP id ffacd0b85a97d-39efbae004cmr11182234f8f.36.1745317280932;
        Tue, 22 Apr 2025 03:21:20 -0700 (PDT)
Received: from [192.168.88.253] (146-241-86-8.dyn.eolo.it. [146.241.86.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4206fasm14515005f8f.2.2025.04.22.03.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 03:21:20 -0700 (PDT)
Message-ID: <e2921eea-1430-4626-9419-eb04dc2ec23d@redhat.com>
Date: Tue, 22 Apr 2025 12:21:17 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 net-next 5/5] sched: Add enqueue/dequeue of dualpi2
 qdisc
To: chia-yu.chang@nokia-bell-labs.com, xandfury@gmail.com,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
Cc: Olga Albisser <olga@albisser.org>,
 Olivier Tilmans <olivier.tilmans@nokia.com>,
 Henrik Steen <henrist@henrist.net>, Bob Briscoe <research@bobbriscoe.net>
References: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
 <20250415124317.11561-6-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250415124317.11561-6-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 2:43 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> +static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
> +{
> +	struct dualpi2_sched_data *q = qdisc_priv(sch);
> +	struct sk_buff *skb;
> +	int credit_change;
> +	u64 now;
> +
> +	now = ktime_get_ns();
> +
> +	while ((skb = dequeue_packet(sch, q, &credit_change, now))) {
> +		if (!q->drop_early && must_drop(sch, q, skb)) {
> +			drop_and_retry(q, skb, sch,
> +				       SKB_DROP_REASON_QDISC_CONGESTED);
> +			continue;
> +		}
> +
> +		if (skb_in_l_queue(skb) && do_step_aqm(q, skb, now)) {
> +			qdisc_qstats_drop(q->l_queue);
> +			drop_and_retry(q, skb, sch,
> +				       SKB_DROP_REASON_DUALPI2_STEP_DROP);
> +			continue;
> +		}
> +
> +		q->c_protection.credit += credit_change;
> +		qdisc_bstats_update(sch, skb);
> +		break;
> +	}
> +
> +	/* We cannot call qdisc_tree_reduce_backlog() if our qlen is 0,
> +	 * or HTB crashes.
> +	 */
> +	if (q->deferred_drops.cnt && qdisc_qlen(sch)) {

Since commit cd23e77e6568abfac6354dd3f69d5b154e60e342 the qdisc_qlen()
check is not needed anymore.

/P


