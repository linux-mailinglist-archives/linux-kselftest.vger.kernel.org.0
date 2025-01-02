Return-Path: <linux-kselftest+bounces-23824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6EF9FFB79
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 17:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F1827A0621
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 16:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9691756B81;
	Thu,  2 Jan 2025 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihEo5MD9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5382D627;
	Thu,  2 Jan 2025 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735834877; cv=none; b=r9abrYhT2CjVAs5WXQXY1nFkWisY8uIUKaZARJPtvbWGt44FyRTeT4eFzKXIKcbDlJhYG4e0CpFs6MqZv2JwXaMllbJa4s2EzrgtjlJQQNDDlqGjpl868y59fgJBjIRaY9QTyNM81A62A1Y3NFiN/WWmyttVglu5cu6j5G8Xr58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735834877; c=relaxed/simple;
	bh=dSJv3kAsx4e/jI21sZlJ4yX2VorXsrGLdIC+nkDYCUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qF6/TKWxwkyCDllS65jMM3y6bMNg0K/ygv7R0OieZhets9GErbXdZhVjiiEVDZbLkb7wxnw5dWdKLe+wCy3FVMNHZboXm3u+jIJghz92Eo/TxXYCSWmaMHqz67PaIPsGubTrLd/4pUhsEJZf0/eQzuxnAM22lrLF42kcQHGuVHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihEo5MD9; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so4048528f8f.0;
        Thu, 02 Jan 2025 08:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735834874; x=1736439674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EFwagoQckg1x48oSlTADI+AZ0xM8gKp36cMYG8nIBr0=;
        b=ihEo5MD9vpiRMALBaevwR3lxVROk6hHEF1rjz3cn/s+1Us7jAAeuLenXABrnB2vXNZ
         64RJOuKO22d6grnxywnFW0BM94udvvQ0P7xLHJZaLz3lOyPcOcXGUPUUyBAMTcq2re5j
         a1h04+FnpFiYwBrDhoo5ho0RTUlSwCWpGdVOLIToEQ+PxiDlmjjIt39h0R/NcZaWNK1L
         ldjVIlq85Ns+ZCIMD8KTM4XPwSsC00SgG/v1nazOs7nC3ZHAo7oscJujRp32nmr0RD2x
         PfpUD7TP0KfA9CqGq7bJtsVdR+/MM89i0Jy7m3h9C2KaHwOoy8NsPI8W78ox2Mxr0g7o
         SpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735834874; x=1736439674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFwagoQckg1x48oSlTADI+AZ0xM8gKp36cMYG8nIBr0=;
        b=X/fwVzON7t914fyK1ydRA9DrwDlQYRIE0OdbF74tACdnLpbNWYM3PX5HiRNYAsn413
         SgMy8by+WAKS2bRnydZql9kEMagz7U0FOHNfKG+O06gCt3bLfu0KcD5I+u2kjzHGlvRt
         hIZKZDK1Z/kNoEu/ARp75p8PnvjNkl7wATTI+YWMgguj31CElPcvLPY+AsXq0/T0pk/F
         D/kSdx/N4CuTh67chqJATyO+bUU29KDRn84Bx22jA0ZJ4udYRyjxDbvFUSSEh2CmPabA
         4Rlyc9WaKoIyuRWBOMgApFnD2jAhIJhBTBDobJ/r85AxMTJC5aQofb34VXmHGJG5gyDC
         T1PQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1J5px9WBl4/wrbN7wg3mIcMS1O9uUNPKHLzYk7hUNGZPzT2PBx1TmgkNS+pzanvtXJ+61q9qI@vger.kernel.org, AJvYcCVc2y120Ivl2S/DIhFgA4hheDOfZc+nYKdQ5ox9M9wjk45CEDllbDHFlLlzdmump8oEn95cT7G0e4s=@vger.kernel.org, AJvYcCVkCOPwm0RPwZDqs9XpOKyqUGUzaL2Y623iYntZN6HpoZ/pv7ukQVd42vT3Ty4P0/MupfXVWFFDH877aI4R6LZr@vger.kernel.org
X-Gm-Message-State: AOJu0YyDphCOi53+rO6e2L7U/ycqKmqPv4TP8tSZDt9qZ3Shn+DFPci7
	9dp9Jf8tD/jpsWA9+/EPzybr7BonrgPp7lAXNCfpjimI1iV/aCjK
X-Gm-Gg: ASbGncusSbQN49KqvBCwLD/xPBIAMBqGGkj/vw01RxjI82rWyCB+aDwOYHoxHhvL4Xt
	qrLizVmbiMM3uoNcZJjwJRH5X6QEvTTIBWLk/8tZMS4T7nvQ24P2kuQpy4RdODYmE0F5jwgLlb3
	tSorOWiBawDR3DzZA/4Eh0PS9pWEl1kLZhiEBNL8L63vmHCUOBW1R4F3T7ZTgttoauFdlnYyu6e
	df3JMWHQY4wEsOSbMT5s+sZSrZTDd1kZQ2qdaRO85fedCQvGMv0sdASPEf/P4+vzinPHXPMuFva
	AdDIWi5OvRpqTaimkzUO
X-Google-Smtp-Source: AGHT+IG0AunmMSQFcstGX2xexmsNqbQEnotP3JgjDGhHiAOcDSrfECwecZI3LFYSIzW+tk7K7kLpPg==
X-Received: by 2002:a05:6000:1a8a:b0:385:df84:8496 with SMTP id ffacd0b85a97d-38a221f2ef4mr40402238f8f.3.1735834874159;
        Thu, 02 Jan 2025 08:21:14 -0800 (PST)
Received: from hoboy.vegasvil.org (89-26-16-1.stat.cablelink.at. [89.26.16.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c848a47sm38031656f8f.62.2025.01.02.08.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 08:21:13 -0800 (PST)
Date: Thu, 2 Jan 2025 08:21:11 -0800
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
Message-ID: <Z3a892mBOSRl6BlN@hoboy.vegasvil.org>
References: <20241219204208.3160-1-quic_philber@quicinc.com>
 <20241219204208.3160-2-quic_philber@quicinc.com>
 <Z2WLGHRdlsRpT6BL@hoboy.vegasvil.org>
 <wcxdbqhoe4cppukyy5rvkq5am4ht6wk5u6d6g2k2swqhidjw7i@6nar5vuusm35>
 <Z2ymZuiFqY8mxihJ@hoboy.vegasvil.org>
 <a352mltlizneonxazn4bffydn57fyudrc3zougii2rnatg3jga@3yagssaob5sb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a352mltlizneonxazn4bffydn57fyudrc3zougii2rnatg3jga@3yagssaob5sb>

On Thu, Jan 02, 2025 at 05:11:01PM +0100, Peter Hilber wrote:
> Would it be more acceptable to just announce leap seconds, but not
> whether to smear?

Up until now, leap second announcements were handled in user space,
and the kernel played no role.

> I do not understand. Is the point that guests should decide through
> another channel about leap second smearing?

Yes, that would make more sense to me.

> I hope there will be some feedback from third parties (at least related
> to virtualization).

+1

I'm no VM expert, but I'd like to avoid tacking things onto the kernel
PTP layer, unless there is a really strong justification.

> For sure. But the aim of this proposal is to have an interoperable time
> synchronization solution for VMs through a Virtio device. So the idea is
> to include metrics, if a consensus on their usefulness can be reached.
> AFAIU it is difficult to bypass the kernel for Virtio devices.

Providing clock metrics only makes sense when there is some choice to
be made based on those metrics.  If the "limited" VM guests don't even
have networking, then they have no choice but to accept the time from
the VM host, right?  In which case, the metrics do not provide any
benefit to the guest.

Or what am I missing?

Thanks,
Richard

