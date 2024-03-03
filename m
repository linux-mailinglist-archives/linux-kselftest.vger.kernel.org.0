Return-Path: <linux-kselftest+bounces-5794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6CD86F34D
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Mar 2024 02:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022091F22196
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Mar 2024 01:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E987F4430;
	Sun,  3 Mar 2024 01:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIbZ+SQG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5093A320D;
	Sun,  3 Mar 2024 01:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709431146; cv=none; b=KF/pMgpdetBrem+5AJCcWVsBQdkqwq9X1QYMZFHlGdkf3Gx7kGrLNiqG9jh02FgPeQG06P6SCVBAYdoyK94Z/Jb4McbieBV6YcLXwTxxGrIdNDH0BaKblvf2sDUW6WEGiTzn6UkxqsPGkg3LVjIivuB1UI1R7jYlhheciDvYBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709431146; c=relaxed/simple;
	bh=VPKjqVkiDmVkBIeBeqx8NRfhQo/wESr9jrOroTLiZ9I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GSIweWTum6qlxMcTk//37VV1UESLsMAp0UqU6F4Cc8ka62wahfy7XaDSRdhySZrp44nchP/UmylKR+0qyTlGx6eAh3UVip5WWYgG83a9cMusRZuM2PQAvzMQd7U+jv4DkdnLahxfVIZBwWYPWCgTTfTrvMUqS9Vqff4ErQ4D6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIbZ+SQG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so29742765ad.1;
        Sat, 02 Mar 2024 17:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709431144; x=1710035944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrThd3AbGp2L2TbdibjncZIHTv9jShOpMlQ84CCLklk=;
        b=WIbZ+SQGsy0aAkHhgzoet6DSzci2c3BPgnIZQO74G0J/u0qTY1gEzNoBHiNuKTXQmc
         /1cfrCjwLAtmeWIr5SwBcKbEAovO2Qvr001iFR+y5jOmXWFwim9nJIHRh8oDFvXHNZ2T
         DpgKLTRutVdwBTS0i2i+Nrf4W1ZDwVkaCtFXFvB64qzB7f+OLUydvQtKGnhBgCrNSdAm
         ru0qE+4+C+afpVce6GE/WOvxF8u/WN/umV2sCEUc48ULOCiX94/JmjysWwA+j9USf/rG
         xKr/yUynkgH7D4g1cgwABjcOFWQC7b6KQ+2o7Y6g9+GGxoDxRpQmvnbvfdUMB0VpgBbx
         wFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709431144; x=1710035944;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WrThd3AbGp2L2TbdibjncZIHTv9jShOpMlQ84CCLklk=;
        b=BGNpy+z/jSRPLqjZ8ji6d4hbgsVyABkCKdhll2hCHAF2ZuMQr6HgFh0ONoZwraSpFB
         X1WFkwscnkloelX5+57WCfVjwmMkaIb8j9zjgpwXnkPjbmFPLzvyAImdX1gfe+7+/oz/
         JeCkRpS1x94EwnAooLPwuH8mHyuG7WzwgNSpGxEJWlJB1ehF9V2pBtBHOLfa11BKrK8Z
         xW36yw8e34PDDilaLLw5TCZ4OQq3PkWFU+ab1NdM4JpZoOLo2RYDOCCiLUjZZiNwlSaq
         /bjgoV6WOwHoSLFxXA356lZQCcUtFXvZbiLB4up3MK3anoBP1vSkynKBNr4HNeZO0Fa2
         jS6A==
X-Forwarded-Encrypted: i=1; AJvYcCUQi4hkm1gKZe4PqC9Waqog3mOppmtITk7JHo/K3GVOhBaqOfqKLgpWXvRsWQTG7UYYNmQfdzh5vcT9zhdat/0OUOLcyj3kcKfUga9C89aAeXyKUWTtS08J4/NWKrT2Fz6iPIKfKM7/DkyC61y3Oy7PbODFj4dPXq5Nslg1eWJ5MjtKbdDjLPSmuoKx84FWj06EEqZ52ZoViFS2
X-Gm-Message-State: AOJu0YwZpwyWY913VX7wtrzz5HR8yGIdyq2vraY+6lDsqq2ZtouJtupc
	hBck0t1N5Iv0N+2EcvpEniutJ+L2m1xPmGX/GJUyKZX4k0etItbc
X-Google-Smtp-Source: AGHT+IEpcJ1ppLdYI3v6PLpHlNkGd8s29BlMzJkoxyiUaoL1N4wuBSlJRKARDn+uAIHWuZ2lCr5vRA==
X-Received: by 2002:a17:902:a513:b0:1dc:b77e:1978 with SMTP id s19-20020a170902a51300b001dcb77e1978mr10346412plq.28.1709431144407;
        Sat, 02 Mar 2024 17:59:04 -0800 (PST)
Received: from localhost (071-084-162-223.res.spectrum.com. [71.84.162.223])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903120500b001dc3ef7aa2bsm5827341plh.49.2024.03.02.17.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 17:59:03 -0800 (PST)
Date: Sat, 02 Mar 2024 17:58:59 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 "Gomes, Vinicius" <vinicius.gomes@intel.com>, 
 "Bezdeka, Florian" <florian.bezdeka@siemens.com>, 
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
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
 "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>
Message-ID: <65e3d963c6dc0_8ee3b20879@john.notmuch>
In-Reply-To: <PH0PR11MB58305CA6B9ECA2005DC315CCD85D2@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20240301162348.898619-1-yoong.siang.song@intel.com>
 <20240301162348.898619-3-yoong.siang.song@intel.com>
 <65e2165a89ed0_5dcfe20823@john.notmuch>
 <PH0PR11MB58305CA6B9ECA2005DC315CCD85D2@PH0PR11MB5830.namprd11.prod.outlook.com>
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

Song, Yoong Siang wrote:
> On Saturday, March 2, 2024 1:55 AM, John Fastabend <john.fastabend@gmail.com> wrote:
> >Song Yoong Siang wrote:
> >> This patch adds support to per-packet Tx hardware timestamp request to
> >> AF_XDP zero-copy packet via XDP Tx metadata framework. Please note that
> >> user needs to enable Tx HW timestamp capability via igc_ioctl() with
> >> SIOCSHWTSTAMP cmd before sending xsk Tx hardware timestamp request.
> >>
> >> Same as implementation in RX timestamp XDP hints kfunc metadata, Timer 0
> >> (adjustable clock) is used in xsk Tx hardware timestamp. i225/i226 have
> >> four sets of timestamping registers. Both *skb and *xsk_tx_buffer pointers
> >> are used to indicate whether the timestamping register is already occupied.
> >>
> >> Furthermore, a boolean variable named xsk_pending_ts is used to hold the
> >> transmit completion until the tx hardware timestamp is ready. This is
> >> because, for i225/i226, the timestamp notification event comes some time
> >> after the transmit completion event. The driver will retrigger hardware irq
> >> to clean the packet after retrieve the tx hardware timestamp.
> >>
> >> Besides, xsk_meta is added into struct igc_tx_timestamp_request as a hook
> >> to the metadata location of the transmit packet. When the Tx timestamp
> >> interrupt is fired, the interrupt handler will copy the value of Tx hwts
> >> into metadata location via xsk_tx_metadata_complete().
> >>
> >> Co-developed-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>
> >> Signed-off-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>
> >> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> >> ---
> >
> >[...]
> >
> >>
> >> +static void igc_xsk_request_timestamp(void *_priv)
> >> +{
> >> +	struct igc_metadata_request *meta_req = _priv;
> >> +	struct igc_ring *tx_ring = meta_req->tx_ring;
> >> +	struct igc_tx_timestamp_request *tstamp;
> >> +	u32 tx_flags = IGC_TX_FLAGS_TSTAMP;
> >> +	struct igc_adapter *adapter;
> >> +	unsigned long lock_flags;
> >> +	bool found = false;
> >> +	int i;
> >> +
> >> +	if (test_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags)) {
> >> +		adapter = netdev_priv(tx_ring->netdev);
> >> +
> >> +		spin_lock_irqsave(&adapter->ptp_tx_lock, lock_flags);
> >> +
> >> +		/* Search for available tstamp regs */
> >> +		for (i = 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
> >> +			tstamp = &adapter->tx_tstamp[i];
> >> +
> >> +			if (tstamp->skb)
> >> +				continue;
> >> +
> >> +			found = true;
> >> +			break;
> >
> >Not how I would have written this loop construct seems a bit odd
> >to default break but it works.
> 
> Hi John,
> First of all, thank you for reviewing the patch.
> I agree that we can make the loop better. 
> How about I change the loop to below:

That is more natural to me, but whatever reads best for you
is probably ok.

> 
> for (i = 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
> 	tstamp = &adapter->tx_tstamp[i];
> 
> 	if (!tstamp->skb) {
> 		found = true;
> 		break;
> 	}
> }
> 
> >
> >> +		}
> >> +
> >> +		/* Return if no available tstamp regs */
> >> +		if (!found) {
> >> +			adapter->tx_hwtstamp_skipped++;
> >> +			spin_unlock_irqrestore(&adapter->ptp_tx_lock,
> >> +					       lock_flags);
> >> +			return;
> >> +		}
> >
> >[...]
> >
> >>
> >> +static void igc_ptp_free_tx_buffer(struct igc_adapter *adapter,
> >> +				   struct igc_tx_timestamp_request *tstamp)
> >> +{
> >> +	if (tstamp->buffer_type == IGC_TX_BUFFER_TYPE_XSK) {
> >> +		/* Release the transmit completion */
> >> +		tstamp->xsk_tx_buffer->xsk_pending_ts = false;
> >> +		tstamp->xsk_tx_buffer = NULL;
> >> +		tstamp->buffer_type = 0;
> >> +
> >> +		/* Trigger txrx interrupt for transmit completion */
> >> +		igc_xsk_wakeup(adapter->netdev, tstamp->xsk_queue_index, 0);
> >
> >Just curious because I didn't find it. Fairly sure I just need to look more,
> >but don't you want to still 'tstamp->skb = NULL' in this path somewhere?
> >It looks like triggering the tx interrupt again with buffer_type == 0 wouldn't
> >do the null.
> >
> >I suspect I just missed it.
> 
> Since the timestamp register will only be used by either skb or xsk,
> So we make tstamp->xsk_tx_buffer and tstamp->skb as union,
> Then based on tstamp->buffer_type to decide whether
> tstamp->xsk_tx_buffer or tstamp->skb should be used.
> 
> My thought is, by setting tstamp->xsk_tx_buffer=NULL,
> tstamp->skb will become NULL as well, and vice versa.

Seems good to me. Maybe a comment though? Otherwise I suspect next
person to read the code will have to spend the extra time to track
it down as well.

> 
> Thanks & Regards
> Siang

Also feel free to carry my ack into the v2 if you make the couple
small nitpick changes.

Acked-by: John Fastabend <john.fastabend@gmail.com>


