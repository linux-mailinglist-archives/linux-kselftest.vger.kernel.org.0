Return-Path: <linux-kselftest+bounces-3927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6275845427
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 10:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050DB1C22B0D
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 09:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F8E15F327;
	Thu,  1 Feb 2024 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cU2mGfXS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B756A15F32E
	for <linux-kselftest@vger.kernel.org>; Thu,  1 Feb 2024 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780101; cv=none; b=BPauY8iB/UQmmhyMSgGBxj19RE4M4micEgAXrH2ikPCxM6csVd0aj9pAhUA1WDSWGFRZ47bbzApMh2TnBGsoGR1Hzhg86acspfdOpM49Sag+vWTQ3eboAAsRcYSFIqclwJezbWQcgGMAmLj9JZndGw5Z0jTM3KbXwdYD37B7yO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780101; c=relaxed/simple;
	bh=iXW6hMhpJvg7i0EsoL632QQCAv9F99Yf4XFJiekgr+Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XBdFrFfpd6kvMpSftvM5Iyt1svw2PqouQkzrCzY0PigPr6sp9nJ/yZnp9eUqqXAefLaUHXbxdZxkog2nb9pGOmY8d6vQbKk4Np5K6QLhkai2IhKA1Fd4GdKizoo4hQmllp9d/fdLP2KlxbynaZUFSieeajvEs6zPHRoq/vXefKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cU2mGfXS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706780098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iXW6hMhpJvg7i0EsoL632QQCAv9F99Yf4XFJiekgr+Q=;
	b=cU2mGfXS/G6UNdu92Lwqvygr9Ic9Sz3fIraUx/31onm4WDaBYRuicXNwCbzFNbQtVBBOhN
	od9z9V7fnrC9ezdooQAJraQhNFHxXlj8o2N7NoHdh27Cp6JxgrTmprprcwHO3SGzTe8rjd
	o6AECC0e2kVGu197K+KbtOwo0cT5VMo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-RC3tQeuBOjqElqibXEXrPw-1; Thu, 01 Feb 2024 04:34:55 -0500
X-MC-Unique: RC3tQeuBOjqElqibXEXrPw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40ef6441d1aso620655e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Feb 2024 01:34:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706780094; x=1707384894;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXW6hMhpJvg7i0EsoL632QQCAv9F99Yf4XFJiekgr+Q=;
        b=GqKT83MY9kHEaVhd+IVH+klGcGkwrS1YVtKUeIzPnUb/TE3b5B5AtAhB0Klec82tj0
         dqD1niSg6ZUf0vEaZAXFzGZHubY+qmVZNKprv0ikizwtNcv6WInFMFPB1SboZfHn+tfH
         h32K08m0wkNQN2NgfEIPCXbMIx/TAoxtf/8OFQ1NogMzrIMdPoRDKPCuPt5JBm2JJjT1
         z1ExBA8OhQTQryv/ESbwhB7e70ni9zuLkC9GqhhLaoQCNCv5KpGpfslapGCy40zGvFxy
         6RG2bxHFN4GOqBih3nz33hYXgbB06u0yJQsIkOcyI/+53nXt9GRu1sRAWABxPZe3B9Aj
         5ajg==
X-Forwarded-Encrypted: i=0; AJvYcCUs1xZXtya7tK/RblxDfQWrYk9UbmI1AOG7QeCjYHHb6TOfwKXVVhY0C4JV8ff6q5aQvX5QaKroFyl7X+vgUQVTXfNIaJd6HXY1NZueUDTI
X-Gm-Message-State: AOJu0YzUBvwCmkX26XXRDEB34J0FZR/deFo4WpGPnA0ozbD+aqwgeuNj
	Bx07yXOz6IcVfu/Oqt1NUk2ap+qaL5ZQBjfn/Nhrq0p58dKdBBNEeHl6jDuH/AC4dmvAAeZnaO7
	ryMdSd/YQd/5I3XEmIGgPt/iV4qqXBOhJMYCb4Ex1lWDs6+xAuNbwYS7FXXIqpSPA1w==
X-Received: by 2002:a05:600c:5103:b0:40f:b642:d58f with SMTP id o3-20020a05600c510300b0040fb642d58fmr2566141wms.2.1706780094094;
        Thu, 01 Feb 2024 01:34:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFl7YTTl9eqKiPSbT3BTu1MOxl/pLbwU2AvMKNda45dE5MDK2HZW6QrqJ4oJCNrrqrsYxW23Q==
X-Received: by 2002:a05:600c:5103:b0:40f:b642:d58f with SMTP id o3-20020a05600c510300b0040fb642d58fmr2566119wms.2.1706780093770;
        Thu, 01 Feb 2024 01:34:53 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-238-90.dyn.eolo.it. [146.241.238.90])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c4fc700b0040efb20fa6csm3884712wmq.47.2024.02.01.01.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 01:34:53 -0800 (PST)
Message-ID: <4cca1f0d3c015a6ab9e371b1639f6c3c29b33024.camel@redhat.com>
Subject: Re: [PATCH net-next] selftests: net: Fix bridge backup port test
 flakiness
From: Paolo Abeni <pabeni@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 shuah@kernel.org,  razor@blackwall.org
Date: Thu, 01 Feb 2024 10:34:52 +0100
In-Reply-To: <20240201080516.3585867-1-idosch@nvidia.com>
References: <20240201080516.3585867-1-idosch@nvidia.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-01 at 10:05 +0200, Ido Schimmel wrote:
> The test toggles the carrier of a bridge port in order to test the
> bridge backup port feature.
>=20
> Due to the linkwatch delayed work the carrier change is not always
> reflected fast enough to the bridge driver and packets are not forwarded
> as the test expects, resulting in failures [1].
>=20
> Fix by adding a one second delay after a carrier change in places where
> a packet is sent immediately after the carrier change.

What about adding an helper alike wait_local_port_listen(), checking
for bridge link status in short intervals, to likely reduce the overall
wait time?

Thanks,

Paolo


