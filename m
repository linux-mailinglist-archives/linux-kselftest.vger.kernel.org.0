Return-Path: <linux-kselftest+bounces-48972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 770C1D20FB1
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 20:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F1F9300AFDC
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 19:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E301233C187;
	Wed, 14 Jan 2026 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2WeAOZj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DEB19C540
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768417864; cv=none; b=k028nPVos+trcFwXGQkHOFyZZi1i/RL2RD572skeEvcPJU57p0M99tDuZ4Cebx09TDEswmHyaMFAW4QJua230t0Nof+JPEbEc9SU7uJwY6h+WC4ejBog2bMP3dCbN7HDwUX41RpBuB4jw2535DvEycisMTZPnBkqNPRwJ57UKMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768417864; c=relaxed/simple;
	bh=QKRezXrA3bG4ArDBbT58+S8c1CtyAn6iBKaQozySKZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jb0kmjs+NiC1HBLJeqhsvw4UFjzwneeGa8MF8kVdPuN56levnn+Ki+dK1V35Ony2fvxYueHNiYpdJENjD7JOayOvVm3qYFe5YKxENQhpTj5qhN17okTnp589pskYwtIksISLwcKmfwhh3s2+P92Q0dx3ZDKinSMOf0qrAmyiIik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2WeAOZj; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5634feea416so118414e0c.2
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 11:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768417862; x=1769022662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jUpDNPxjIqi9ICJXtc+mfMuxEexyo061EqFw5Nyb8q0=;
        b=W2WeAOZjEs8YD+z5CIoy6KSKQ2B9aMRCTcfmMYTQsPYKbcYJTSIc0N+piH8+lnpMs8
         F+kBYyaH7Pqqm7uXiC1JBCMOXIalOiWy7cfPJ1CVZnEMN8biJPWUIpE5Fv8/nqWuw7d7
         3LyL+WC9AZ7kCHhnf6K9pM2IXh0qBqoZ29ocr0KbTX3z1jCxjaGQ5BzYFs7WWh2s9fXt
         PXt1BjJX1TNnnGtv+9F6rkDi4y6fhMGAdv4naRsqgNKmJvK18YYZYbEQc5XGQoMqYgcK
         2WSff0me80inzzNAl0f+IZK83neQ1jE3L0J9kVK21eLm+x6sgmBeNeGSouyN7j0vr6o3
         2Fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768417862; x=1769022662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUpDNPxjIqi9ICJXtc+mfMuxEexyo061EqFw5Nyb8q0=;
        b=RxDChbgbWnOk3lo4LMr88d6ioTlOkOkrjP//DSk0eU4JLVdsG15XSmY+JlMTfBWUn1
         KgkLlGZS1Pq2YTC38ARmE2SK1Ej8nZNfDo+cWQW0ClxWAU1v7mmc5scEF0Wx9NuPIkAI
         pvFciR2sNiiLr397a3N7plGZxf1pOXri+uNtw+Sl2AgkLGlqVPYfbB2lOUuX1Ba6ZP3e
         r9puuESVFqH7iRXt137a8DKOVwD7fqem0tdWtzBwsmiynqA1AOLz2Bwf4EoYsXXX3Iiv
         h+vJvIIOidHZ+2y1UAXCbs4Dn2o3LeSsR0ILMjqNNAPiVViJXuVkdeY0Bw1Olu+ISGTF
         YVmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHxi4fJl6rfEUzP0MQgoxkHouZkJwklyBsXndhxXz/imZslhzpyFMgOVRb0pd79su5YY1tDRg4KNvxy35Crik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7NO3nCbsUmfYyZe0JdXWcftkNf0Sd4/6VEqaIYAk1GYtiG3a3
	wKxZh0bobOAZU+AnXdodSyJrY0tCI81NtTHNrsjjeM9ozDvY52p5TEDa8ea9JA==
X-Gm-Gg: AY/fxX4kts+gWoLJ2sACIFM3TsQko64z2C2zwPg3EcKOduez5ytPI0491CyyO+wdWtD
	WwbS2wP05Uo0P40Nrc71gS+x7IblX6+EWb1Uo0zYCifh0lqM+4t39ues7uUaAXTq0w08vO0oPdd
	D37CdT6DFRXqunxua+ZOCovV9VE34O2HdVkqX1zO1615RKT51fuUjf6iJAPN0huMzGc/GJ9cMNJ
	SVvYLmBjk4ttHORhXXp1bOzTB7u7wopmakIJMzvdmGKcCxHYMyYaQIjcDLvPG6HFgYF20UIKCum
	QL/uLo7jMGmyCpONatiVXzQU1/8UTM000d802frLIY3Qz97OxEYPqDW09fLL1/dgbZje84prRkH
	u2gXXH9kcr8FnNttutFLKfwxKmToy8ZrRo7G03otdjKJykwmxSn4erEoAwaoPc8pOGLFpCVcc/e
	5yujkf8LZWh4mY85N2yFOkJ76O6zEf275Yig==
X-Received: by 2002:a05:690e:1c06:b0:646:eb06:f2e2 with SMTP id 956f58d0204a3-64903b513d2mr1973243d50.73.1768411311135;
        Wed, 14 Jan 2026 09:21:51 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6e12ffsm92418037b3.53.2026.01.14.09.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:21:50 -0800 (PST)
Date: Wed, 14 Jan 2026 09:21:49 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kernel test robot <lkp@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Long Li <longli@microsoft.com>, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>
Subject: Re: [PATCH net-next v14 01/12] vsock: add netns to vsock core
Message-ID: <aWfQrS1oNcXwcXu3@devvm11784.nha0.facebook.com>
References: <20260112-vsock-vmtest-v14-1-a5c332db3e2b@meta.com>
 <202601140749.5TXm5gpl-lkp@intel.com>
 <CAGxU2F45q7CWy3O_QhYj0Y2Bt84vA=eaTeBTu+TvEmFm0_E7Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F45q7CWy3O_QhYj0Y2Bt84vA=eaTeBTu+TvEmFm0_E7Jw@mail.gmail.com>

On Wed, Jan 14, 2026 at 04:54:15PM +0100, Stefano Garzarella wrote:
> On Wed, 14 Jan 2026 at 00:13, kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Bobby,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on net-next/main]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Bobby-Eshleman/virtio-set-skb-owner-of-virtio_transport_reset_no_sock-reply/20260113-125559
> > base:   net-next/main
> > patch link:    https://lore.kernel.org/r/20260112-vsock-vmtest-v14-1-a5c332db3e2b%40meta.com
> > patch subject: [PATCH net-next v14 01/12] vsock: add netns to vsock core
> > config: x86_64-buildonly-randconfig-004-20260113 (https://download.01.org/0day-ci/archive/20260114/202601140749.5TXm5gpl-lkp@intel.com/config)
> > compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260114/202601140749.5TXm5gpl-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202601140749.5TXm5gpl-lkp@intel.com/
> >
> > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> >
> > >> WARNING: modpost: net/vmw_vsock/vsock: section mismatch in reference: vsock_exit+0x25 (section: .exit.text) -> vsock_sysctl_ops (section: .init.data)
> 
> Bobby can you check this report?
> 
> Could be related to `__net_initdata` annotation of `vsock_sysctl_ops` ?
> Why we need that?
> 
> Thanks,
> Stefano
> 

Yep, no problem.

Best,
Bobby

