Return-Path: <linux-kselftest+bounces-24201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CAFA08DCE
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 11:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F7537A1221
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 10:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A08120B200;
	Fri, 10 Jan 2025 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OIgWTgOn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4953D20ADF3
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504631; cv=none; b=DIs/nwGQacdvKjsit4N5tZarmZxiCBm8ml6jknCgiBZEzIaEF86FxoFo9LVKi9d6PPFzCJI3zFEpj/cGl1cFdi8pLO/uGSsaXnfQHIGlJwKJudROw9dHoV/2OB0rX++KeDQk7Ze9GNfgmp8VqClpQSD/tfOI/ufkRerWmAJNoVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504631; c=relaxed/simple;
	bh=xjzJiHVG1rcoDk2fTADzQ9apBt/E2B/VHNJo4JUJl8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjse7eSiSfwIsr0mZz+YAttrOOkqOuwfT68AGv3Yx4fJS4I6baL95OBfNOvF4kh5dfF4CwGr8R775ybA7UymA6Z6npAn70KAxZS9vJEFCoYu5z6yNGe+XX6sojcHVYp0N+x6QwKctol+DxMVsxB/wPE6p4Jp3tCAGXhYQ6Qp8dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OIgWTgOn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736504628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jp3bnJiwix2Gu1b46TgPaNYsSc3q3ZVFUH5fpD6tH7A=;
	b=OIgWTgOncQYJ76cz7i+EwYWMSXfiGGie255eEfaLbw44SQqmfuL0fRdOeBlYTtNxlt9B2l
	Y/msrtl1oW+l/h6dCiznGspbUNRERmJEYo4pbQuC2avJbe4bkjxWvL2K8mj492Mh84aSTx
	prR/e7BABVnk2xfoY5viNt/HxNDxNfs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-MNiVfmypNW-fmAas1ID6Aw-1; Fri, 10 Jan 2025 05:23:46 -0500
X-MC-Unique: MNiVfmypNW-fmAas1ID6Aw-1
X-Mimecast-MFC-AGG-ID: MNiVfmypNW-fmAas1ID6Aw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361efc9d1fso16677005e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 02:23:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736504626; x=1737109426;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jp3bnJiwix2Gu1b46TgPaNYsSc3q3ZVFUH5fpD6tH7A=;
        b=wwF2aEiZJsSd1TzCgvFgMIYyAK1hS/u26xPGH+vTDGBoRr0zsjenTAqhgXhQhm/HtU
         uuIxxP82164oj6uikPrO9KnX4xtmKFWCOaPzQEfrG8vkun4IJacJh1OySkdl280rvY7R
         vDkHCDhbCC7jPbZ1CWxegNUypcAfBYyuOMUb+aWzL3og/cXZQ3VtibLXXjzU5nthCzxD
         Qc2pmgAcIKcxS1CBHMNIng8axgdnicDqcFTHKScplQcW1UBW7jNsMfyG4du4Wf/hy0MT
         WotOyubOVHRCasjs92j2z1bUZ3ILWQdzR1fJlg1TnHpTto8nWW5No46bJOf+dBIES1ON
         pAcg==
X-Forwarded-Encrypted: i=1; AJvYcCXItXkBZJgOrxZsg5OkGmTD4ZoAmzn/wXN9Duskc5JLlo6tr4S0juXBDA//ruxsnfmAuXsTi3FY+ZFgEwrv2v8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+PP0rzHoBYDTLLswUbE+MJKFFs6eCT0DF1Jj/F/b2M0PAagQS
	Yw1JYAU3fhV5wqOOZl4Dd5ajqdmvTAXRhUY3N4AFRUK990oULsooyQUaogqc4BAFRtTrMgUtEgJ
	gJ9EBNEZA0bb68x3Jq4xLTeO0kNPG0Fc6dCEPjBddk7fCQZs5yXiy4T53R9zp2P9+Zg==
X-Gm-Gg: ASbGncuHzyGlF6+lO2aiQOokwmXW0BBo6Rw+gU0LWJmyTBJf8iseH0C8VATupcdzuPs
	++ajGVt+SK87j73wYL+708BiqVszvmzDvZn8sroq2sNQ68PHIeaqX/nqP1VakNf2+oqAUt25tyl
	xNKmhpExTZ+kWdm+YAyW/o9/WF1xMGVOqwPWXCdpiSZvjZEyuhr2jHvuco7bZSbyEC27CII4llG
	QsFbR7fx43SHuMr1+k2VGA1sl5TsqX/JYbN9PD2eqHwUNoHTIhG
X-Received: by 2002:a05:600c:1e09:b0:436:e751:e445 with SMTP id 5b1f17b1804b1-436e751e61fmr82747585e9.5.1736504625694;
        Fri, 10 Jan 2025 02:23:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCfvXG8JypksNxAK+IHkKlFtMebcL1LMAzRXVW08Nh57eky+TRviObBgV58/zlzJhK4cMqJA==
X-Received: by 2002:a05:600c:1e09:b0:436:e751:e445 with SMTP id 5b1f17b1804b1-436e751e61fmr82747375e9.5.1736504625358;
        Fri, 10 Jan 2025 02:23:45 -0800 (PST)
Received: from redhat.com ([2a06:c701:740d:3500:7f3a:4e66:9c0d:1416])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e03e5fsm47436835e9.18.2025.01.10.02.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:23:44 -0800 (PST)
Date: Fri, 10 Jan 2025 05:23:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	gur.stavi@huawei.com, devel@daynix.com
Subject: Re: [PATCH v2 3/3] tun: Set num_buffers for virtio 1.0
Message-ID: <20250110052246-mutt-send-email-mst@kernel.org>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-3-388d7d5a287a@daynix.com>
 <CACGkMEsm5DCb+n3NYeRjmq3rAANztZz5QmV8rbPNo+cH-=VzDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsm5DCb+n3NYeRjmq3rAANztZz5QmV8rbPNo+cH-=VzDQ@mail.gmail.com>

On Fri, Jan 10, 2025 at 11:27:13AM +0800, Jason Wang wrote:
> On Thu, Jan 9, 2025 at 2:59 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >
> > The specification says the device MUST set num_buffers to 1 if
> > VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
> 
> Have we agreed on how to fix the spec or not?
> 
> As I replied in the spec patch, if we just remove this "MUST", it
> looks like we are all fine?
> 
> Thanks

We should replace MUST with SHOULD but it is not all fine,
ignoring SHOULD is a quality of implementation issue.


