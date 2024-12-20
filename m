Return-Path: <linux-kselftest+bounces-23661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4C79F9546
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 16:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F8217A34CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 15:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09244218E95;
	Fri, 20 Dec 2024 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fay3ox/K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EFC2C182;
	Fri, 20 Dec 2024 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707999; cv=none; b=P+zti45h0wtO0+OgJosv7z/ypYbUaJhkTfoM5pLP4Nq/tGMyogfHsy7pkbloS5ZuklC0ojVdiJaSjg/WCEnIEQ6jUNgxbYqmqyNf/qvEBtgRnvBaHJndLyR2FZjX8kdqk1iKOEKij2+dHDhMFxEbdBEBoX1YR97XaKKCBl9uVMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707999; c=relaxed/simple;
	bh=JldQqxDH8mvpeKCYB9thmfmrzuLJ5su27e3JcvWr/Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBruBZeR6BrLD0oq55H3N3Co0qXRBnp/LtAV/Yu/Frp3XdULhfJbOHBB9swK81l0pGvm2244Q2dCXhC55Yb6D3FF/aQcu1t74XYLbVJuw9Hsy+xh4B8R6IJFF/JWEj/7Q5pzOgEL67+2hQH50Zx2a1XMDEJY96WeNZWnRXhyLSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fay3ox/K; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee74291415so1534059a91.3;
        Fri, 20 Dec 2024 07:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734707998; x=1735312798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ULv4d5ej0EGbh9z1eT6zvijwptui7/HKQ4JCeBG/fHM=;
        b=fay3ox/K/GOktM3HizlWv15ZqMvt19F13yrofbNn9dHgpOswusi+fOcJHnciEQUNQq
         XgkBhJjEKNQyPcYSLQ8tUHWeVMit37jRdTX6KM2Zj67A5r90QsYjSvMI5iyiNhKWByM2
         pDVAYHCFnI/9kab/n31Y7tGIokcd7OyyTwcuAQnqhafEAuARNX0IkaAqz//eSV3bBktt
         R4GCNyehJjyxx0kEhiGi2EbBtZxt8btkdDxnb3xxmyWsf3Ef1k5sThcsMwR3E2GG/rN7
         gIJHoIazoEAgaHGgYmO/tOGzdIEFCbWULNY7+d6UsYl6rhBsg4yBMgYppGmj86jZrhLv
         qmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734707998; x=1735312798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULv4d5ej0EGbh9z1eT6zvijwptui7/HKQ4JCeBG/fHM=;
        b=f4YS9SS1SlRDfV9OQdD+ckQNb36eP7bXQIqye9C/vwCPou+zyLgqLCgIQ0gfCYXKJR
         uxYcjceKG3KqpNAc+pbE8EoB+e+kN0fW9SDF6U2iSiX33sCgds9EwuWzrrBCQgRrCOBM
         /6cVK6i8qUul2Foy7sNXn1mJ9zfPnzjnTaX4T+DB+CdSbmaGMWGxUiqEQ4neStyjjgJF
         1w8AY+uKseVUoj8hHT9FAZ5e5wzCPdk3XZrocQQRAe1olGO6H5U24gkb/J8IQGmAd7k6
         K/SnOBOVHXaOz2G6lJ5xnSPCXFR8tW9qxDEIyQiNh8fun5hAI0LuKfowz6oc2HMNwchb
         Mkyw==
X-Forwarded-Encrypted: i=1; AJvYcCV9sBRKAus+9afQiB5xYf6G1Xd42gR+XC50xKcZ15v3DhmwdgOmM6z891ekv8kHO/36MBEgk6nkkAcBJlQBtLAK@vger.kernel.org, AJvYcCWROddXgdjM9grvYWyaoRTS7XFyNlfn5tIaTL/e7fxQsj9zmr78QWu1KlEgv4wVs2oSh867RP3w@vger.kernel.org, AJvYcCX5yjWirGgaNsxCB6GAf1OVCEmqJETmIBuYWwH+hfBkpgvk+XfDi350GZ0UwFwq9LnIVphA39wkHFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrqZrcV2O5AJje8VZbO6Uh7AZfyunArOIs3ug26cTTAkAzIyoV
	Lie3isrOFavfjZ4ns+zp6I7elGJ8mnkoUncAXAc3LE3l029e4Xll
X-Gm-Gg: ASbGncvvwLOLJRZNRmGEaTLMAhDR+asWrnHom/RcmOFax9u1fPtVDF22id+ikCbulPn
	Qdai7z/l//yy5ylIi0rPjJRte3HUnPdX/m5svPBFUx0boWd7eM98kInuIjm2aMtdRTeJyrZ6G3a
	ZDzBnaNpmWCL5hcvxXeHEuzOGRzs7IRt7XufU0kgUdmJ9Y0zkMLWzrivi26AU9cCEC0SkcgWoe+
	K6B4NQP825/4nQIYpLwiJMacyNYFarz0dYE9i6KDwaQqXeV77bPBwLWpedP/IenobBEmCJmucWA
X-Google-Smtp-Source: AGHT+IEyMqq1xrGIJmgMfuLbdcE1RNg78jfaOb809zKFY/9Vlp9bkY42pZBrpxkTCtBgzJMib9Z2/Q==
X-Received: by 2002:a17:90b:50c3:b0:2ee:6e22:bfd0 with SMTP id 98e67ed59e1d1-2f452e4d5ddmr4359906a91.21.1734707995980;
        Fri, 20 Dec 2024 07:19:55 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4478accb3sm3418138a91.51.2024.12.20.07.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:19:55 -0800 (PST)
Date: Fri, 20 Dec 2024 07:19:52 -0800
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
Message-ID: <Z2WLGHRdlsRpT6BL@hoboy.vegasvil.org>
References: <20241219204208.3160-1-quic_philber@quicinc.com>
 <20241219204208.3160-2-quic_philber@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219204208.3160-2-quic_philber@quicinc.com>

On Thu, Dec 19, 2024 at 09:42:03PM +0100, Peter Hilber wrote:
> Ioctl PTP_SYS_OFFSET_PRECISE2 provides cross-timestamping of device time
> and system time. This can be used for virtualization where (virtualization)
> host and guest refer to the same clocksource. It may be preferred to
> indicate UTC time, rather than TAI. It is then useful to indicate when and
> how the host processes UTC leap seconds (stepping or smearing on leap
> seconds),

If the VM host provides TAI, then the guest may freely derive UTC and
leap seconds on its own.  Whether to smear leap seconds or not is
properly an administrative configuration choice in the VM guest.

Leap seconds are scheduled to be deleted in 2036.  If, between now and
then, another one occurs, it will be global event, not determined by a
VM host.  The way you find out about leap seconds is through
networking using the NTP (or even just downloading the published list
once in a while).  VM clients typically have networking, and so
they can learn about a leap second all by themselves.

> in particular if the guest is not guaranteed to have an
> up-to-date Time Zone Database or similar.

Time zones are not connected to leap seconds.

> Also, a host may have a notion of how accurate its clock is w.r.t. the
> hosts' reference clocks.

I'm opposed to having device drivers try to claim any kind of clock
quality.  All of the clock control, servos, statistics, etc, are done
in user space, and so only user space software can generate meaningful
clock quality metrics.  Putting some kind of hand wavy values into
kernel drivers is just plain wrong IMO.

Thanks,
Richard

