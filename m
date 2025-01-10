Return-Path: <linux-kselftest+bounces-24174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F43A085EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 04:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F803A420E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 03:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE991E3DDB;
	Fri, 10 Jan 2025 03:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAMEy2WH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CEA1A8F97
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 03:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736479650; cv=none; b=C0FQ1l8nxELNOlIbsbi885P8cNOVm5oQuzcgay4iKPsXFuPSG5CUImodX4SPskp3YJtYFi4CQDeAAmk1Uz1Wvio5fqlaYj4VYLva0umvwZBnZGmejQbXx1A6KABIK4cFueLFeJ7F96nzuiohAeS+iER4WBAWCz2b4gGnIru+p9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736479650; c=relaxed/simple;
	bh=7uR8vN0M0CFh5qpZV7D1vSWR3xVu4IYzXqUeioDmijc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFS0ObBMqTfVAEFItRGl5loM2Zh1xIDLUM16O7LhoRGIFG3Ttaw1rmYUCUK/bRgn4PtsHV4mgKZYGSLO4jaK1OJwlZM866xSkVchEdCYJsCDbPnxZ0HzYTHXRufEmX76pshY88GHB0FSPGmiME6kHXcVof5NWbibFspJk8YAOF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAMEy2WH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736479648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7uR8vN0M0CFh5qpZV7D1vSWR3xVu4IYzXqUeioDmijc=;
	b=LAMEy2WHIppx4eDngWDwKFjhKXrx5SjLgw2Ri96nV+Se8CAk/1DjSBpIcP7gglTZ1VaWbW
	+tJnTdI6NypDGTirlITf6bl+HKofFIgthUh99UuVJXQLTB8/mcTwGYCh26iY4gwfuu2DDr
	hwZJtSm5qdSRbR0ZH0+9a409jOwOJc4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-Q7whyARkMeKxmf76aY87ZA-1; Thu, 09 Jan 2025 22:27:27 -0500
X-MC-Unique: Q7whyARkMeKxmf76aY87ZA-1
X-Mimecast-MFC-AGG-ID: Q7whyARkMeKxmf76aY87ZA
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ef9dbeb848so2894659a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Jan 2025 19:27:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736479646; x=1737084446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uR8vN0M0CFh5qpZV7D1vSWR3xVu4IYzXqUeioDmijc=;
        b=YutGqEW97Lgp0+zeik5ScPnkrTwfSmYjrNQ5zOanfjQh7GgDBKjzTRYXXga74Do7iV
         +g0ltaPmvYVUFSIOS/bPbrUBpGJ6hzmxW2RamTLJ0w1FWBRS1W0p4GvyTRtbpu/LiUDI
         gCoC2PxsKIGpuAdLQ189bY+Tld5mXeKt1FqMk04qnVVaaasjGNZ6MF5RWkj6LXC3OYgq
         0OkBGrsu8M1Brapjq0KpajCz6rKnJ0e5cXi9HRD7vq1dNO4jXc78JfZC5fDWijvIFoLT
         Z0WriWIeyNQiDBPTztcsghctjKoATr8xRLf43/x1D0p6iqZ/fiHDYgSAJwZ40mQCcwyK
         1/1g==
X-Forwarded-Encrypted: i=1; AJvYcCUioVCuyBWVPY0q2PkNZuK/HU0mNuzCS0W22wsXtAnp+9gzl5Gr9D7uaAqhmMQGMztl1hwHNo9JGcOqIRAYRC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt8ziaxbFUd1j/uTzW0jLLs0M2j7ETX5cquHVUoBize7jMZ4ET
	r+2y/ZZR2uo9V322za4yuuPY4qMGGnN8zhJGZAmiqLOzxfOEQNpw/b5R84EEgtiOfUMkMzxjUjY
	36BUCqiIn7ZRMm7W6dpf5Qq/1nW21dbpanOFs82Ud68i+1ygRSppdp6s8HnGuPB7tdqBpDpT5lC
	VqMSY1tYUM3iH8Y6e2WchrNolDDs819ze+1mcVaiLf
X-Gm-Gg: ASbGncsaj9E+r3NGRS6rfMI4dnB32CKtSLsIyAd6lUVvpsGl12h0kIheT+tSSHIe6JD
	5le/h+TjagUmkxoGENsu+dIQ2LhCnQty2z4e9txk=
X-Received: by 2002:a17:90b:2f0e:b0:2ea:59e3:2d2e with SMTP id 98e67ed59e1d1-2f548eb9e0emr14161347a91.10.1736479645908;
        Thu, 09 Jan 2025 19:27:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGr6qt6YqI8gxH2NjDJ69HLIEFDu0/JDwyZCE+11GxsqEEXtLHHfTQDNxjuhLS8NYQPmojHsZtINe9boq5qSYU=
X-Received: by 2002:a17:90b:2f0e:b0:2ea:59e3:2d2e with SMTP id
 98e67ed59e1d1-2f548eb9e0emr14161300a91.10.1736479645509; Thu, 09 Jan 2025
 19:27:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com> <20250109-tun-v2-3-388d7d5a287a@daynix.com>
In-Reply-To: <20250109-tun-v2-3-388d7d5a287a@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 Jan 2025 11:27:13 +0800
X-Gm-Features: AbW1kvZyiy6igQIYtcT2bEIGGuMlsgd6CYsI8IZapQaNgu__KkmEtAKFahTJbko
Message-ID: <CACGkMEsm5DCb+n3NYeRjmq3rAANztZz5QmV8rbPNo+cH-=VzDQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tun: Set num_buffers for virtio 1.0
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 2:59=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> The specification says the device MUST set num_buffers to 1 if
> VIRTIO_NET_F_MRG_RXBUF has not been negotiated.

Have we agreed on how to fix the spec or not?

As I replied in the spec patch, if we just remove this "MUST", it
looks like we are all fine?

Thanks


