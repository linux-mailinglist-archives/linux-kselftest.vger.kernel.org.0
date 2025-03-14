Return-Path: <linux-kselftest+bounces-29066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65722A6196E
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 19:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0202D17F3DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 18:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93EF1F3BAE;
	Fri, 14 Mar 2025 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYh2TXlx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0C413B58C
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741977134; cv=none; b=lIeIOP0ukXJNKFnzHKmBTiXNLx7H4AGkar3J9XS0XTFZ1Vq9rtsG2BGvzv0mGJzsRKMFs9flXYL+9MKkO1/UjJo1a2MeTqOvzU86FlsP37regNkqA/+X80B+SgPuW0amZXmRvX9PMBvidEnR4poCvmnJw+H7Z6XHm+F1YFw13Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741977134; c=relaxed/simple;
	bh=ZAlDB8f3z/UtpU4Kr17RyxB+EhhNFrQC+QXpc8vm7rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fw9og99VJ09W10cVthvLvMlU0VO/Q6JB1nhbrJ/uC7EE83immsm4DbRzr8U9Y2+VJ7owe7UhEg4hS3oyx4ZOPrkYMdO120CO31DgrCKteXgWN+aGNkhTgDLWvdD8O4qWHs5njvqkrkD1jcS420f/jROSw1GcsWAo5yVaL9KCe3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYh2TXlx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741977132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cMyLUb8LhPfp38YWXS83SjE2dBcmOEXzjF8frO+TYyk=;
	b=JYh2TXlxNz37zVjmlu8Fn4heKQB73AHBypNicBPR5Xt5n0YYTa10JMrlXmw4M5G5SuA5Ug
	Vpx9cb40exLP3VLZphUnLbGjkCmWQsPaXwI9M2SMGDWh8Siz+37sfmVNBAfC3PVI3xA9T0
	RpuAHawm84dKmsFHjk1dw6Ncdp7Ihzg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-lXny_JXXMG66aCKKQmp83g-1; Fri, 14 Mar 2025 14:32:10 -0400
X-MC-Unique: lXny_JXXMG66aCKKQmp83g-1
X-Mimecast-MFC-AGG-ID: lXny_JXXMG66aCKKQmp83g_1741977130
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e9083404b7so50706466d6.1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 11:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741977130; x=1742581930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMyLUb8LhPfp38YWXS83SjE2dBcmOEXzjF8frO+TYyk=;
        b=ujgjciipCdvFQ3RgAZsI+Ravux8phgrqOUk84zDvavxQoTRWZFfLxVflrAHC3wZL1c
         dtXzcuOxzukB8Qk72T1kx33POFrRqBs1A776V5P36OUX1q2pzTZizkmRczyehEFrnDXV
         uXQ4dyEQs1Dc6qNhEHtZIujKRgdY9ryVU6vZ/L4Uuao4wH12IW86INfEzS+tcE2CoRtE
         ObD5YdE98FhxqLmy49GMf6iK353g7tH+/hXFwLwelwq2/QQyl5oh3UqILvX/WTIXrlKQ
         3MO8ipKT+VzWIpVK7RoUjf2Lnsfj9WM+aAvvbx9DWzUggv3SdYfJOZ4j5clF9imxXGno
         96Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUfOM4P8jLFE0xaWFsROLfkZhPwP/h3dppzkTBCH5kvnHBB6h9CVrqsZcb2nNy/wcjIkqD9SpvU+AUuXW5aOjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4j/TXyWWdjRHJzDP1cZp0PnasEfIMxPrz8VmmTFITTE0Lmrdy
	olPYK6+UlziJXtFSigeF8WhQ1Rbsg+bdT7rCt5L8bShDcfUsbJ2nnKGzHJAf7wYNMQBvvUYMVci
	PCvB7hqGLYUvnnYTTKFAbaHsgs0IXm8KdpA5UQ0omJEUJMW94T1Dwb+LiA0jvwfI1EQ==
X-Gm-Gg: ASbGncuUhCvFl9mEUZyRpEWSXVcGX5lB7y6BIMEAlWUOpEjScHoeEAhIy5AM4lDWylm
	JOyuEVdPgRn69y35bRdszzA3TiDfHTj9c6w2rilcexNq/hkX7sn3vNNb3G7gT/jNUAlvKeLuoYd
	kcIZmYwkd7DeyMuZnp52vn0prvNzduiUbb8tRfiYQasLMB1BvI8DzxJQNGyxV3hCybxpT0P4+VM
	WbMGFNT09eUb3ODAriRORmwoCLymvmJecZZoLtrDBtKlUAe7ITQTIBVHJwR1A2kRQMfQNdQ2nYk
	KFyM/DI=
X-Received: by 2002:a05:6214:29ed:b0:6e8:feb2:bad9 with SMTP id 6a1803df08f44-6eaeaaac26fmr45881406d6.30.1741977130133;
        Fri, 14 Mar 2025 11:32:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHscSVLDkbW24B9zbK0LGwRDEEXA7mFC28oFGsGZvhR+c2wtyNhUM9wN90pI1MPGQwzkAu4dQ==
X-Received: by 2002:a05:6214:29ed:b0:6e8:feb2:bad9 with SMTP id 6a1803df08f44-6eaeaaac26fmr45881066d6.30.1741977129812;
        Fri, 14 Mar 2025 11:32:09 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade231261sm26870036d6.30.2025.03.14.11.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 11:32:08 -0700 (PDT)
Date: Fri, 14 Mar 2025 14:32:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: James Houghton <jthoughton@google.com>, akpm@linux-foundation.org,
	pbonzini@redhat.com, shuah@kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, david@redhat.com,
	ryan.roberts@arm.com, quic_eberman@quicinc.com, graf@amazon.de,
	jgowans@amazon.com, roypat@amazon.co.uk, derekmn@amazon.com,
	nsaenz@amazon.es, xmarcalx@amazon.com
Subject: Re: [RFC PATCH 0/5] KVM: guest_memfd: support for uffd missing
Message-ID: <Z9R2JapHdhR2Xhp_@x1.local>
References: <Z89EFbT_DKqyJUxr@x1.local>
 <9e7536cc-211d-40ca-b458-66d3d8b94b4d@amazon.com>
 <Z9GsIDVYWoV8d8-C@x1.local>
 <7c304c72-1f9c-4a5a-910b-02d0f1514b01@amazon.com>
 <Z9HhTjEWtM58Zfxf@x1.local>
 <69dc324f-99fb-44ec-8501-086fe7af9d0d@amazon.com>
 <Z9MuC5NCFUpCZ9l8@x1.local>
 <507e6ad7-2e28-4199-948a-4001e0d6f421@amazon.com>
 <Z9NeTQsn4xwTtU06@x1.local>
 <24528be7-8f7a-4928-8bca-5869cf14eace@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24528be7-8f7a-4928-8bca-5869cf14eace@amazon.com>

On Fri, Mar 14, 2025 at 05:12:35PM +0000, Nikita Kalyazin wrote:
> Yes, I was thinking about MADV_POPULATE_WRITE as well, but AFAIK it isn't
> available in guest_memfd, at least with direct map removed due to [1] being
> updated in [2]:

I see, so GUP is no-go.  IIUC the userapp can also prefault by writing
zeros in a loop after mmap().

Thanks,

-- 
Peter Xu


