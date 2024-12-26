Return-Path: <linux-kselftest+bounces-23743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A84C9FC703
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 01:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6841B1882FEE
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 00:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB325258;
	Thu, 26 Dec 2024 00:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQbiXify"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7E1139E;
	Thu, 26 Dec 2024 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735173742; cv=none; b=J4+JAsAltGCTKpBg2zfgSdlrJxxE8perD2hkxK3EoSqavD2+SlkS57iS7950mNkNHn7dHD5el59E6h+viKLMgLPdn4ifB0f8P++ZdYWuE+acNTWB8QlVrxEke49Fg/xcw1Zt63rnh6vwdYTZJA+04qL2XhiLy70dQBUW8YhQhn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735173742; c=relaxed/simple;
	bh=TMTD3KOO7Bw7eUixgoeGme5wThACykG5nhmVHwj4r24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObmVxSjhaGLQFApFBILj1TtBcGRr6roDRQRY92LmqlA5V4mybjtbyTAHOSx4VA2WI+u7ZGOaud4AvFhzRkUfz9dBo/nfxgaobrQuZDNwpUgTxMoO24ZY84rcJL+KogqdK79rx416ixGP5lFw3fsub2DnfNR4DQUiFo/0TBEN4MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQbiXify; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso3396625f8f.0;
        Wed, 25 Dec 2024 16:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735173739; x=1735778539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a+tM814QAYMJ9xpVBh1o3P7ADY//NXbn+HbvIqF1jAY=;
        b=ZQbiXifygx8M58xglyUmd9ItIY74Bck5d+4GYP24Xbea7owRwLs626/UiMi8vAOnTU
         YOgnJbYmjuFpMmf6r1HZJUE7wtfcFrYhf3uVhzntJGfxK7H7DIrfB7YMaxZbpHot9jlx
         SRgmmLV/gcpVx5mMM7GIAWXelnsLfXGKmF1UQwXjaXrOp/6urgp/NtXOOCfhuhYl0mcZ
         4Y78j0XCNSEK+w27ZrkTMOyo77Fjprm1JlsYodrGzEXmKqNxqqcHhx+KOSTv/Easdx2v
         eivJdK6MqdXBwuYQl8FcUZBbxYmTX1KavhioD9BqN2GYCTg4+80Wen11Lq/4ZAhQT4Pm
         FqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735173739; x=1735778539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+tM814QAYMJ9xpVBh1o3P7ADY//NXbn+HbvIqF1jAY=;
        b=NFGd2YlQcDOp8XZToHmd46PhWE4Y18FwgWqR1Pmn4/8YTQK6PqMipv57w/SAfkWyOa
         hvrobWXTxl3g9XO8fKPnicEx3wRpD7HK8zpPS6ZpwyKjKcheQqMmkKCbVrwfeEl7qvfW
         7AG9jO5HIDwx4LSLlPiT/ioz8Sge1f3Dn/qZWx4dEi+ZCxKIDLORY+v2CG0YfT7MRSQA
         NJF6cDM51LijLYZJRWjg33Un9TccOPRnzUphJkPZRkW6C1fvcE4rOA722l+ibeWqC+7P
         IxEKlZdYuK1puu30rzbjWUr0UjLf6UKfcnNFIlhyO9hixky7XF261MI3u9SHIXpMlZIa
         zgmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8VefhAzpjK3XNPf1E55gaKDVINc4MzTu1o8MS0RBSw4RpJJCFFtiEKX4b8fcskNXJkMXNMxNc4bg=@vger.kernel.org, AJvYcCXaGVeKrpRYSiv3k0RMhxwE1h21UcZuII7JEb3n8bMTdc0Z0u8OJu0/wNOKOLlfzpAlI1Tn+ySR@vger.kernel.org, AJvYcCXhh5XsXFoBCEP44rFMCFEQUjSXZWWf8OWP96iv8MTTtfn93qSRiIxF1arMLik+VEJLESEVpB6rBMBLcpNg9aec@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd/aTMJnLdRyWqUpAFoQU0ZShRHe3khv3iB3L/QCGcYphSwPvc
	zXuUWlHt9FVu4kuz7BZtUDlqWPRiDBR6E2ul0dSTFvM6PhTxOIPl
X-Gm-Gg: ASbGncsEMSafDAiD7ZmcBkZj9ZCZC5P4wozFittvIeRcct5IjK82aya92M9vgAHPA5B
	hRhPrIFsIw+56c+0llX0xN/gQ7+kGP9LxRwQ/KEmaAg19V+Ahfi9ubMWBytg9ZZCICzLkkRarLW
	ybrI5mSjRQIsQHLdJyN42g4YNkvN5MDmhAvbxNG7VIOvaUBRibLeya5raVPBE/M87sVSUbWaXSY
	JIM+cCllsNe3A77wiIYvtlK9gl/1YxsJ2+KJYIWXRPIfIYjge8cUG/fkNWMW45RI0j2nqPkBrX5
	cwyE5YBjXvSu+zJ/jsoCsRbL6q1k
X-Google-Smtp-Source: AGHT+IF79E7qNVt5omQB4N+mfTI57BdyjPEsWNaWLJn83SOWA5s9pwX8QgXP0UEnoPT1F9Ng0+UaHg==
X-Received: by 2002:a05:6000:184e:b0:385:de67:2269 with SMTP id ffacd0b85a97d-38a223ffaafmr16672215f8f.36.1735173738766;
        Wed, 25 Dec 2024 16:42:18 -0800 (PST)
Received: from hoboy.vegasvil.org (91-133-84-221.stat.cablelink.at. [91.133.84.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b207sm248044245e9.32.2024.12.25.16.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2024 16:42:18 -0800 (PST)
Date: Wed, 25 Dec 2024 16:42:14 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Peter Hilber <quic_philber@quicinc.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	virtio-dev@lists.linux.dev, netdev@vger.kernel.org,
	Trilok Soni <quic_tsoni@quicinc.com>,
	Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	"Ridoux, Julien" <ridouxj@amazon.com>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [RFC PATCH 1/2] ptp: add PTP_SYS_OFFSET_STAT for xtstamping with
 status
Message-ID: <Z2ymZuiFqY8mxihJ@hoboy.vegasvil.org>
References: <20241219204208.3160-1-quic_philber@quicinc.com>
 <20241219204208.3160-2-quic_philber@quicinc.com>
 <Z2WLGHRdlsRpT6BL@hoboy.vegasvil.org>
 <wcxdbqhoe4cppukyy5rvkq5am4ht6wk5u6d6g2k2swqhidjw7i@6nar5vuusm35>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wcxdbqhoe4cppukyy5rvkq5am4ht6wk5u6d6g2k2swqhidjw7i@6nar5vuusm35>

On Mon, Dec 23, 2024 at 07:13:46PM +0100, Peter Hilber wrote:

> The precise synchronization of the VM guest with its immediate
> environment can also be important; a VM guest may depend the decision
> about leap second smearing on its environment.

I thought that the whole point of using a VM is to isolate the guests
from each other and the host.  What you describe is a promiscuous
coupling between guest and host, and the kernel shouldn't be in
the business of supporting such behavior.

> Also, the administrative
> configuration choice may change over the lifetime of a system.

Right, which is why we should keep those choices out of kernel space.
Kernel provides mechanism, not policy.
 
> The intent is to also support (embedded) VM clients which are themselves
> not necessarily internetworked, which do not get a lot of maintenance,
> and which are not guaranteed to get an update within the typically less
> than 6 months between leap second announcement and occurrence.

Again, I don't think the kernel should be the solution to guests that
lack networking.  Instead, the place to fix the problem is at the
root, namely in the guests.

> I agree that a device driver should not determine clock quality metrics.
> The intent is that the driver forwards metrics, if such are advertised
> by the device. These metrics should describe the accuracy etc. of the
> device itself.

Overall, I don't trust devices to tell the truth about their
qualities.  But putting that aside, we would need to see some kind of
commonality in hardware implementation to advertise their metrics.
However, AFAICT there is no such industry practice on the market.

> The patch message should document this more clearly. The
> metrics can be determined e.g. by virtualization host user space
> software. The device driver would just expose the device metrics to user
> space.

Again, host user space shouldn't misuse the kernel to share random
metrics with guest user space.  Isn't there another way to share such
info from host to guest?

Thanks,
Richard

