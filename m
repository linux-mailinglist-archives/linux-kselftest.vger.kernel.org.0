Return-Path: <linux-kselftest+bounces-47951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D01CDC4DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Dec 2025 14:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 130083076AED
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Dec 2025 13:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AF81624C6;
	Wed, 24 Dec 2025 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAGu+9Ld";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uNMtlKXN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F3E32FA21
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Dec 2025 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766581283; cv=none; b=gtyBtRZdOVubdbfzAr+qRJR8OMCHKCx01/my9ims1ps/geSjKw5Hb8sJTDPvxQbqJeI7ydjuOE81ujZKtp7cb6HLv6UB7/1zqR6Mv0rn0t2VvvOs+wQbZnl7boXfchac+MTFXMIzvY4KHaw67OB+BOl+YFi91zC0+S9NbrKcOD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766581283; c=relaxed/simple;
	bh=ZPltMTzBETTQT1CqF+sZl3/fAao1GzI/HXVbssWVgUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIQ/0Elmmv5kMumUXofScKeIb1Uk4NINp5PKSX/NxsCYyMWayZmJmkhHZy2+sH58aqh96ROWck5Tw93NRvPsNhOURjDrjc3Qa1gLAxLQVBiEs6WWT0sPVSgfEETZ0FBcEyhJaJ2YDIzSZEGR4Tn1BeTE24YbI0mKlonOCOpM5Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BAGu+9Ld; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uNMtlKXN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766581281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPltMTzBETTQT1CqF+sZl3/fAao1GzI/HXVbssWVgUQ=;
	b=BAGu+9LdkgXJve6guLUEb/NUDKR2WiUSbkG0BwECraH/zP1zfNijwcQnTQ8aJl+dXopbvz
	0pn3fVxQTiYjpbRQcI6MmTFKKrU4tmkwtfDV4HYHpOn3uBlKTmitFYVbqfeItwNdIfYS1w
	3ob99kfYk7CVJB5aUlEsIWCyltQvSr4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-tIF0dA0jMqaj7olC3qrHvQ-1; Wed, 24 Dec 2025 08:01:19 -0500
X-MC-Unique: tIF0dA0jMqaj7olC3qrHvQ-1
X-Mimecast-MFC-AGG-ID: tIF0dA0jMqaj7olC3qrHvQ_1766581279
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47904cdb9bbso57718025e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Dec 2025 05:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766581278; x=1767186078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPltMTzBETTQT1CqF+sZl3/fAao1GzI/HXVbssWVgUQ=;
        b=uNMtlKXNNG/lVwjdQjqTUwZPFSWRlFQpHTOF0uphMYaQKf/d/C7lSmZDkUCJOFAson
         9ac5Ekf5eRJRCTZmwMZ6F3EMvIxTZLrhD05Rn918KZP4A2xl4mIe4K/7PeBMYBoquE6Z
         QjspJV/d5vPuMqkA0jDsr3nR4+GJfDpflJ7IX3NWbDE/11IPowFo4UMVsW0q8jGvxLH4
         E9II5bWbrrh19qy5G5+7dC0vzeaCZ7y9SGjUrMN8fTaJ/z931MxXo1pL1NaF9Y+l1D3n
         LcSvPDkcSLvsZpkoDowQn1FNfDGmsq1hazpyMLfgyA9qEJ1w15RUlPmP7RQXRD93fT9O
         lD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766581278; x=1767186078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPltMTzBETTQT1CqF+sZl3/fAao1GzI/HXVbssWVgUQ=;
        b=t8ZPvbZ+GwojNOixSEpWrmio1fcbT2bXXVp8j2+ddEwCn6RP9Atsp6h0khZMSFFtNB
         IqW5C0ESCH2iAjqWmp+pSVf8IJQ5vD79JUMDr6DEM2iu1pMhO1PJZbfarX2H9A/nWAxi
         6s2o8bGVFulchIb04PIUuRop2FNLTEVeTirc+gyARhE2DIH9W8uSYxm4q8y7Ga533ZAe
         Er5/ZI2NvtAUbDJKmTUArp3bxh4as+Q+I3qCHfwOw31saLeSVtX1zgDiR1XRplNMFTzM
         WOK/pU5eTvmcIhegwPDvUViyoM2aWHtTCPQqdqkUQtL+/ygw+uC0ndihUfp5DeeHqJ+i
         RfIA==
X-Forwarded-Encrypted: i=1; AJvYcCU5tJ1/Kt/Zsz/5IqrUm8OeQZ3CfJ7TMnh1sDzfzqBk6uWEkuifOqTgWUAvOfuuYmB0jf6VTTvE1DjCq9gbhwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy80aImzNkfGeJzpxxC042QXLcpjarD9IRY+pJfPIu01iiffdd/
	vWETYC/gh1QNP3Yy5pTKWBp+HqjvOUOdM2Ml8ydfSpPwRpzuoD3MIuEUJH4zOfOzqyW7wKfQ54x
	WSaz75eLO4hlyMSxE0rFQ2pz0hgCdeP4LKz6/aXVMROHphEEOHtZFHYxyw9uMvsBum2F9oA==
X-Gm-Gg: AY/fxX4DSlY5i+Kh50iGUalrg7XrFdBbgB+NW7RJ6NOYHcQaTofvjVUygIbP2dNFCie
	OPnfQT5HQvmkVuj+VzpzPyaDHfRqKrDBJvFRj1xGWzi/ScobE+Bm5syAqzJ2VY5mkNtTXZhLMip
	kG5a3PrCR8jWTM3iR7PDGWu00ViNzCIqrRI0jPcSTQ4lGzIXz3l1WnRMroQAjhmhHjR5NH928eE
	k6PTbxYk/urGhJE93s+8Wv6276GBH0pqQ0V3rZbW2MXaVwuO3EFs1tOapGUqGvTQcdtFYDkZwbx
	nNDuOXUu7D+sgs3jzwSY+OfPbzZq7tgNLrlbp9tZHiVd9LK7TpiNVvazpLnE237EXoyh8JnFLl1
	ofsOKkZF22Q+iI6To
X-Received: by 2002:a05:600c:3508:b0:479:1348:c63e with SMTP id 5b1f17b1804b1-47d18bd57bemr161759985e9.9.1766581278495;
        Wed, 24 Dec 2025 05:01:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHybeuqcZcHlfztr3bbKh1cFE8NLb3cLhTczAcvHp67h5Q0r41aRhsvZBwseTxwsTVGzvf/GQ==
X-Received: by 2002:a05:600c:3508:b0:479:1348:c63e with SMTP id 5b1f17b1804b1-47d18bd57bemr161759125e9.9.1766581277580;
        Wed, 24 Dec 2025 05:01:17 -0800 (PST)
Received: from sgarzare-redhat ([193.207.128.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be272e46fsm339791035e9.4.2025.12.24.05.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 05:01:16 -0800 (PST)
Date: Wed, 24 Dec 2025 14:01:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, berrange@redhat.com, 
	Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v12 04/12] vsock: add netns support to virtio
 transports
Message-ID: <aUvjj1HyEG6_hoLR@sgarzare-redhat>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
 <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
 <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
 <06b7cfea-d366-44f7-943e-087ead2f25c2@redhat.com>
 <aS9hoOKb7yA5Qgod@devvm11784.nha0.facebook.com>
 <aTw0F6lufR/nT7OY@devvm11784.nha0.facebook.com>
 <uidarlot7opjsuozylevyrlgdpjd32tsi7mwll2lsvce226v24@75sq4jdo5tgv>
 <aUC0Op2trtt3z405@devvm11784.nha0.facebook.com>
 <aUs0no+ni8/R8/1N@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aUs0no+ni8/R8/1N@devvm11784.nha0.facebook.com>

On Tue, Dec 23, 2025 at 04:32:30PM -0800, Bobby Eshleman wrote:
>On Mon, Dec 15, 2025 at 05:22:02PM -0800, Bobby Eshleman wrote:
>> On Mon, Dec 15, 2025 at 03:11:22PM +0100, Stefano Garzarella wrote:

[...]

>> >
>> > FYI I'll be off from Dec 25 to Jan 6, so if we want to do an RFC in the
>> > middle, I'll do my best to take a look before my time off.
>> >
>> > Thanks,
>> > Stefano
>
>Just sent this out, though I acknowledge its pretty last minute WRT
>your time off.

Thanks for that, but yeah I didn't have time to take a closer look :-(
I'll do as soon I'm back!

>
>If I don't hear from you before then, have a good holiday!

Thanks, you too if you will have the opportunity!

Thanks,
Stefano


