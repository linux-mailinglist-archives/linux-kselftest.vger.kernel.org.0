Return-Path: <linux-kselftest+bounces-5748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2427786E7CF
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 18:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7CE3282A77
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 17:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF07F11C88;
	Fri,  1 Mar 2024 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYI2KflC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B273848E;
	Fri,  1 Mar 2024 17:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315678; cv=none; b=q7mHG0uh2wBkH49UFsc0RhSpyp44mNVf+QJeZIFb5kLAFj/TkbDHSe3RnYz2ASqVNA+JJFMQ+wdUM27H5ubmGcvdxsEueSVtx+VPnNfhRSGTV2SbJ/iMM1gGC+Hw8yV+tbhwZdeEft/SLrvMyRQ/EUUtAFVteJIKuhXhpIllwkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315678; c=relaxed/simple;
	bh=aqeIwwGa/fkHnXgNw3wwR4I8Nh8KUDC4YHT40u34iyA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=E52AdwJUzG3Ym37M2varCH1ZjIe4Q7RKy0WxZ9kXFP10ReERLYns2IowaJKuHkcgbqbPomv/FXPebEpqXilRRzWADW7tS5IkNIWCyVNqmzF5H2xfhemb4zofe9oYv0vxL3J7pwqbbyI/cRpMrBhp0HOsfhlFzSUje+bWak4Pv0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYI2KflC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dccb2edc6dso22096815ad.3;
        Fri, 01 Mar 2024 09:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709315677; x=1709920477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTu8BntRycqg7yt21AHZn8UXSjkjplk0BJ11/qY4XBE=;
        b=OYI2KflC/BHZoPPAx+AtLH6bp56OD8ve8wV6+O0rPklItMqmbqVgihDSr5jQfbWQ44
         EZJj4PnEigZ/S46/pvJtxTSzxqlqZ0hmi9UUB4uN2mzdu1U8b4A0A+467MkXymnfqmDv
         gw7g0JhbGqK+E+wu54Y4XN0WrEr6eFsaK0i8fS1rIhi+IA8EPnD2Ik1/g/jAuRkMewIy
         itJUlFbCaCznyla60T27UaV6YljTwLi/r9aOYg/FoIZEKcADn9yVndddIf6tnOz6RfAR
         i2l8brRKjIapJg27/0C/75hcxM0JpytYC67Jb8Org6JgVpztWqgGby7r1iGC4AGfRE1k
         9tEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709315677; x=1709920477;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nTu8BntRycqg7yt21AHZn8UXSjkjplk0BJ11/qY4XBE=;
        b=SmlQzAMB9eraWLDiQzmkj9cCGfwtUlinADdDdbfY8/Jso8hYrNiD5fletVDY74nebl
         oDAv8BmjPYx67UFNzjv2dkHmB+u3k5s0VSOh57+VOrAoMk/nosbyBupmTYTI0vScubjm
         Ua/FWr4q5cbPr7sB+GTfymI7NhvKp39APyAlkSi4I1aO30IsByCC+QTyc9b0bvXDJMRp
         Q6b4JdhgM/9ohcfdQs1bWmRAzN1gLf/IqX4Jiwt4MeoCICYgav2b/j/aX2g7JFGEStud
         Mdj9hTxT2Y8nsBQWNKGW/R03hsNcHcOvq4hwzpzL3mgxywRWIrMmU2PPZEsC+nWg+GXJ
         jdnA==
X-Forwarded-Encrypted: i=1; AJvYcCVHEjst3RAt81fhtSbBWj5GTGAb/KHr7op+n7lcIfaJrG14W0eIvlJyC8ojZabbl0yyi7Xb/l9klnkNe+/edqrt6AFRfh/xTrIisBh6Iii1jVa30+eoHVYiAyQAHliL3SGrJMBTfB7nZ0b2HqENuEYME668Wo8tXN5tbI8aPAUyZrdm51VLGdzun3ZLbU4XwQ0KIkU0lE/CQQW+
X-Gm-Message-State: AOJu0YwewP5URYAQLD6UHCPJ5Hub0bDL6Y2W/PbrMfXvaDWnatVCvn/1
	AWWUKZRak34aZIWttyPiR4m9GvhKvL25MWJh6FzYt5he3ku/2mCh
X-Google-Smtp-Source: AGHT+IE9csmqmhCHH7CB4+0CxfUKKrr/8xABmiG0iw4SYFgI5JFB+8TUoh0+dZcVBRLvK/L83PLtYQ==
X-Received: by 2002:a17:903:8c6:b0:1dc:d515:79ca with SMTP id lk6-20020a17090308c600b001dcd51579camr2747683plb.5.1709315676554;
        Fri, 01 Mar 2024 09:54:36 -0800 (PST)
Received: from localhost ([98.97.43.160])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902784800b001da001aed18sm3800862pln.54.2024.03.01.09.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:54:35 -0800 (PST)
Date: Fri, 01 Mar 2024 09:54:34 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>, 
 Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@google.com>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 xdp-hints@xdp-project.net
Message-ID: <65e2165a89ed0_5dcfe20823@john.notmuch>
In-Reply-To: <20240301162348.898619-3-yoong.siang.song@intel.com>
References: <20240301162348.898619-1-yoong.siang.song@intel.com>
 <20240301162348.898619-3-yoong.siang.song@intel.com>
Subject: RE: [PATCH iwl-next,v2 2/2] igc: Add Tx hardware timestamp request
 for AF_XDP zero-copy packet
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Song Yoong Siang wrote:
> This patch adds support to per-packet Tx hardware timestamp request to
> AF_XDP zero-copy packet via XDP Tx metadata framework. Please note that
> user needs to enable Tx HW timestamp capability via igc_ioctl() with
> SIOCSHWTSTAMP cmd before sending xsk Tx hardware timestamp request.
> 
> Same as implementation in RX timestamp XDP hints kfunc metadata, Timer 0
> (adjustable clock) is used in xsk Tx hardware timestamp. i225/i226 have
> four sets of timestamping registers. Both *skb and *xsk_tx_buffer pointers
> are used to indicate whether the timestamping register is already occupied.
> 
> Furthermore, a boolean variable named xsk_pending_ts is used to hold the
> transmit completion until the tx hardware timestamp is ready. This is
> because, for i225/i226, the timestamp notification event comes some time
> after the transmit completion event. The driver will retrigger hardware irq
> to clean the packet after retrieve the tx hardware timestamp.
> 
> Besides, xsk_meta is added into struct igc_tx_timestamp_request as a hook
> to the metadata location of the transmit packet. When the Tx timestamp
> interrupt is fired, the interrupt handler will copy the value of Tx hwts
> into metadata location via xsk_tx_metadata_complete().
> 
> Co-developed-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>
> Signed-off-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> ---

[...]

>  
> +static void igc_xsk_request_timestamp(void *_priv)
> +{
> +	struct igc_metadata_request *meta_req = _priv;
> +	struct igc_ring *tx_ring = meta_req->tx_ring;
> +	struct igc_tx_timestamp_request *tstamp;
> +	u32 tx_flags = IGC_TX_FLAGS_TSTAMP;
> +	struct igc_adapter *adapter;
> +	unsigned long lock_flags;
> +	bool found = false;
> +	int i;
> +
> +	if (test_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags)) {
> +		adapter = netdev_priv(tx_ring->netdev);
> +
> +		spin_lock_irqsave(&adapter->ptp_tx_lock, lock_flags);
> +
> +		/* Search for available tstamp regs */
> +		for (i = 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
> +			tstamp = &adapter->tx_tstamp[i];
> +
> +			if (tstamp->skb)
> +				continue;
> +
> +			found = true;
> +			break;

Not how I would have written this loop construct seems a bit odd
to default break but it works.

> +		}
> +
> +		/* Return if no available tstamp regs */
> +		if (!found) {
> +			adapter->tx_hwtstamp_skipped++;
> +			spin_unlock_irqrestore(&adapter->ptp_tx_lock,
> +					       lock_flags);
> +			return;
> +		}

[...]

>  
> +static void igc_ptp_free_tx_buffer(struct igc_adapter *adapter,
> +				   struct igc_tx_timestamp_request *tstamp)
> +{
> +	if (tstamp->buffer_type == IGC_TX_BUFFER_TYPE_XSK) {
> +		/* Release the transmit completion */
> +		tstamp->xsk_tx_buffer->xsk_pending_ts = false;
> +		tstamp->xsk_tx_buffer = NULL;
> +		tstamp->buffer_type = 0;
> +
> +		/* Trigger txrx interrupt for transmit completion */
> +		igc_xsk_wakeup(adapter->netdev, tstamp->xsk_queue_index, 0);

Just curious because I didn't find it. Fairly sure I just need to look more,
but don't you want to still 'tstamp->skb = NULL' in this path somewhere?
It looks like triggering the tx interrupt again with buffer_type == 0 wouldn't
do the null.

I suspect I just missed it.

