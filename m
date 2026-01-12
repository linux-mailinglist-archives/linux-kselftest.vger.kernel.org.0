Return-Path: <linux-kselftest+bounces-48776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE3ED1465A
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 18:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 606F23023EA2
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 17:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B7237BE9F;
	Mon, 12 Jan 2026 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNj0Oim9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CoIhvYqc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBA137BE60
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 17:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768238797; cv=none; b=CMBg+/jQq5WFghZsx+peqquLbL+OVto5+TuH5dJWyVJ9+tTyRTGb+bhM7SB/NYd7YjnTBdzqwyiJkl1Qg76NSMVicE1eoAFaTRnW4Vbu9acK1po/ZkacuUF+bzhlYMKpuDokWHsVLhixUMHwydnW63jI5qPACeDks36dguVEqMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768238797; c=relaxed/simple;
	bh=VcWKMM3TsRHjfu+KXLUJOs/P3Fis/5txZmCUs7c62Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4JBNPTCY8IM8Pc/vOJw4bYbMreonauiU0yeDX0OaVf6yp43YuiVTdtmns9h54dXKrYKhpzbpWXhcI1lswLB8v4pjf7CoVxi1FybcrkPWSCNFRI+Bu1KRpHp6f6dJ5rXo81EEhMv8y5GBRkf2J4n37vpdvkMvZn8CePlFSI1Sg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JNj0Oim9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CoIhvYqc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768238794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BcomD5fw9IVBx/EvgIn//kfeDV6vnh/bPzC6DXjWibA=;
	b=JNj0Oim9wKof8VBgCL+0xXrfpqlgwjE0j+zGrhSJX8gZPu83ps7s3wIs2Rp+Oq4y7dpb6g
	nhFZ4pQe/z4bVWUg09iX/tHoJIZHkcpPjZ1olu1FgzH11ZTeGLEjwElfrYb4ae2FZxy1hD
	r+gtw4OOZIO6eI1BvpNExri8+RfMl+4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-ekl7Y6Y6MIiOfmJXUq7fDw-1; Mon, 12 Jan 2026 12:26:32 -0500
X-MC-Unique: ekl7Y6Y6MIiOfmJXUq7fDw-1
X-Mimecast-MFC-AGG-ID: ekl7Y6Y6MIiOfmJXUq7fDw_1768238791
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47a97b785bdso48697415e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 09:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768238791; x=1768843591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BcomD5fw9IVBx/EvgIn//kfeDV6vnh/bPzC6DXjWibA=;
        b=CoIhvYqcw17rpFY27OsZLFV1dDWaDQMOaAHz1OB5jLxB54fYAPrI66KLbBgQmDOt4e
         0Byy7xM5hAxUXVhsa1Tz8xVcXVCjH/QREGxVoXc1FllIr/4XEwey1bEGcKKkTBBTDGYe
         RVdyC/1a3XSA6X+HcSXhgAuBm4nP1PZulUasF+3a/7rpyK2c8XWIsIzVKcA9A90W5hak
         FrLyr0Wn+RyWzqmtjL9y0C/OFEA2+mv80M73RbQ+23xfnsrlkR0szr02/wWloSNz/Yn+
         Q9Vc//qrx0+Ik8cPZYnIuwQwRH2l05c17KpyDxWm6X3RBcEBayBmKfiNtr8mMAeBME+0
         a0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768238791; x=1768843591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BcomD5fw9IVBx/EvgIn//kfeDV6vnh/bPzC6DXjWibA=;
        b=C4mULqgWuqLOJtB4rehw8+xFclO9056ELqSLZc4TwELMBWDdgj+wTobk33KUuHuACm
         MaQnnnEi68188fcdLPxcpQIeGB+Hk039N9mAqJrGbHlZ47YtiNE8e+2SCejoNTToaWTI
         gbd82Cdx8QBGwn8LnP799ARh3MkGMNe74PIKNRnqsyJzSeV/WyydCA+RWn9EDWmzhrrz
         YlJPcbPtacrPnlbq39CR/dvCxUbub7Q6URDGYmZS16wO2fmrSTzyOtY808SmIx582Vom
         agI4wv9ZJXj+VDqk+7QHKY3VACBuflw6dRWeNUBvqaxS4R0IuEHtaflJI9g96vEtuvvp
         E9ug==
X-Forwarded-Encrypted: i=1; AJvYcCWrdccWa6bkjMWS84L+Gdd123ygpln4mC63V5QePfD0SrQlXOdWXCHA+9dqZS8Xvtz8W1CS+acC+jU9jjzTXO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJM3kogi2W97v/Fql1o7COA9ZI5MTQ4sIhckXuTB9y8As7XD/a
	RXrgLlJSM9bHuDbOnsY5jhnZPV9+0kybJ9H5xMIVwBonvaMnYckQ+zl1ztsVs959c8Qxz05NFhS
	HZnGVEI1k2mPq3ri8ilW46iEeveH8CXQKRv++OVVeazTJzyIQgQ4FlknmjrDhW+xmuqPHaA==
X-Gm-Gg: AY/fxX4+kzI5weX4nV9gryDsbs3HDlLvhGYSuiBdm2J1mn3rw87YU2qqmHPkcuOxZmw
	6sOTgjHZyDyirKq8ei1TtXcmbK6deUfOarFsYtnPftYCdvAgt9UQSsyOjxQ61PVgZcfBMOLYA6z
	YFRI0ltlCJX9XNBkfzjWsU9eB1PaQNNnpGmiQo6JjF5hh+wvK11FTx11o2rK9XauM2uTk9YR5Oy
	Dy43L+Z2OfPY3CPM/CEyRAmEhBXDCo4d3f5Ujz/D1Q2bqnPSao/rLjaUTzQWzVZASfnqH4x+F0h
	CsrPZrlyITvBGjSByiCVfy+Mp2SB+j8lr/r6R0jheNmzx4JMmNpP/+OLFW5iR+oNFrL+v9N1hEl
	RRVuHoxnKwN4tYIMKr2Unr/CK31Cp2lelkifNqkebhjiERzhvLD+NeRLIaTEIqg==
X-Received: by 2002:a05:600c:3556:b0:477:9b35:3e49 with SMTP id 5b1f17b1804b1-47d84b0a23cmr220596155e9.3.1768238791237;
        Mon, 12 Jan 2026 09:26:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbooX6m235tcKkT8gxwgze2BljLHzxenepn63aMTJ5BFbz8FRH46rUY9bsCgL8OFUNeCvvZA==
X-Received: by 2002:a05:600c:3556:b0:477:9b35:3e49 with SMTP id 5b1f17b1804b1-47d84b0a23cmr220595755e9.3.1768238790766;
        Mon, 12 Jan 2026 09:26:30 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6ef868sm358964245e9.11.2026.01.12.09.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:26:30 -0800 (PST)
Date: Mon, 12 Jan 2026 18:26:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v13 00/13] vsock: add namespace support to
 vhost-vsock and loopback
Message-ID: <aWUnqbDlBmjfnC_Q@sgarzare-redhat>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <aWGZILlNWzIbRNuO@devvm11784.nha0.facebook.com>
 <20260110191107-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260110191107-mutt-send-email-mst@kernel.org>

On Sat, Jan 10, 2026 at 07:12:07PM -0500, Michael S. Tsirkin wrote:
>On Fri, Jan 09, 2026 at 04:11:12PM -0800, Bobby Eshleman wrote:
>> On Tue, Dec 23, 2025 at 04:28:34PM -0800, Bobby Eshleman wrote:
>> > This series adds namespace support to vhost-vsock and loopback. It does
>> > not add namespaces to any of the other guest transports (virtio-vsock,
>> > hyperv, or vmci).
>> >
>> > The current revision supports two modes: local and global. Local
>> > mode is complete isolation of namespaces, while global mode is complete
>> > sharing between namespaces of CIDs (the original behavior).
>> >
>> > The mode is set using the parent namespace's
>> > /proc/sys/net/vsock/child_ns_mode and inherited when a new namespace is
>> > created. The mode of the current namespace can be queried by reading
>> > /proc/sys/net/vsock/ns_mode. The mode can not change after the namespace
>> > has been created.
>> >
>> > Modes are per-netns. This allows a system to configure namespaces
>> > independently (some may share CIDs, others are completely isolated).
>> > This also supports future possible mixed use cases, where there may be
>> > namespaces in global mode spinning up VMs while there are mixed mode
>> > namespaces that provide services to the VMs, but are not allowed to
>> > allocate from the global CID pool (this mode is not implemented in this
>> > series).
>>
>> Stefano, would like me to resend this without the RFC tag, or should I
>> just leave as is for review? I don't have any planned changes at the
>> moment.
>>
>> Best,
>> Bobby
>
>i couldn't apply it on top of net-next so pls do.
>

Yeah, some difficulties to apply also here.
I tried `base-commit: 962ac5ca99a5c3e7469215bf47572440402dfd59` as 
mentioned in the cover, but didn't apply. After several tries I 
successfully applied on top of commit bc69ed975203 ("Merge tag 
'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost")

So, I agree, better to resend and you can remove RFC.

BTW I'll do my best to start to review tomorrow!

Thanks,
Stefano


