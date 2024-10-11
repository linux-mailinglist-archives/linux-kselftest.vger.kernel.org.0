Return-Path: <linux-kselftest+bounces-19561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6AB99AC6C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 21:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7941C27215
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 19:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865951C8FC1;
	Fri, 11 Oct 2024 19:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epNstzDn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAEA1BDAA7;
	Fri, 11 Oct 2024 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728673726; cv=none; b=cSuy4Ro+/qcJNOXep8UWqPZyLJYbCvk+hBBaKy+5YQyDx+hrBXz4jChQ9VqdzeeH0ycIwOeQzAIjSOUVNLoWE0EKEcC/IR0mnb9mfxRxPbe5sDAi++oQY2Tsn6zCeFzTDdhPNcK4QUOV1BZd3ZbOtdKvS+pd0Yq3YMHhxK4ou8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728673726; c=relaxed/simple;
	bh=/g5HFJQ/qfXtxuJjeHarUEWpSdzo39LDrraUxmLlEos=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GH+XX9LC5kKIfASioWzGM7TgCKlFpLiwlv4uuDoutbHf4U0Dg/eUmc7OfQ3FVBfBepLesC011RGfRrsjr6Piw66atwf+gkMyprP3s3NYFZzSpMefIj7veWJ2VGxBVZnMNB6qoBeXtc4KKnjK/g2XadwfA6nx31tuBkiEIfJMGTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epNstzDn; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6c5ab2de184so14367226d6.0;
        Fri, 11 Oct 2024 12:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728673724; x=1729278524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Y/geJzGabBXvfM/8UGblm0sFehSeKzBtHLuktddHvE=;
        b=epNstzDnc6muLM7laZBh9dUAq71gztsgbFq/8+NS3lJZy8Smt75RKccCRUOGouAxVm
         D4+bEW5eVJtCeupfTimX9PrzfhAJ9UYHvtsRHon7orUzFiiHjtDCjJ/GgzRTAh+PBFYc
         RHrhHxW5FqrsqHJPG2QbWQGAkVDw5He/ViHvA/42+eE8Sk8F/jngUj3PWXlIGLuBXG02
         LgUJDCkH5kH1GwQoqACcFetgj3z09bgufSoLcKPpqe46HV3POxXm8TGjXOTuNZFGZrDq
         ufRm2isaY3kRN7c1W84J9522dn3HPbl878L2KkG7SdWaZ32ja0v/OMoKayc5sKpo1Rm+
         YbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728673724; x=1729278524;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Y/geJzGabBXvfM/8UGblm0sFehSeKzBtHLuktddHvE=;
        b=Z6D6/o2P6V8oce5zM1BIJ2GtQO7VJedx266lNuzXrFENly2/+X7y2QzN22TPVtJCtW
         waeaTT1Y56MvwmxfXht09Wo2dw1xsL3VMJtbnxq8qUgzXOhMMe9GTDYSj/5tjjqRgvQQ
         DU1wSHtNbsA5XIZZH1tbauY+bZ0P8MxEGFmDq3Ro3EV88OAMA/fwwI0ZIU8UOF/1oV7K
         cQa4prTf+m6XiLC3I+WvgNrUtM0S5MB8GUET1G6eLRKglw4kaUQhC0EyXGTH/qxzKPko
         LRw5O3e1Ow4kqHYP3PmQNRs3lt911a3Dr568E4ilhYZVSPuOStQ+/lx3wWCamd5Svwx/
         /aeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWEL0SMrp469g4/HiBu4MnDoG7DMwzhuyT7+X+7SFLh67+3dB2Uu2AJA0Iy14C1rw7GUEgXjBRL8iXJ6Q0w2Pw@vger.kernel.org, AJvYcCVLipPUjiZtbwaxMI3PUiGmBxanIAjBfc9xhyWiZcTryWUoZPfxwuvvEAAhk+h59Js4LjvD2SFa@vger.kernel.org, AJvYcCVda41N3RX0nfDCkFegtIN5s1CQrYIBNJ9TkoxCY7HMTSyAVLoHqQYHQHfuomZetNhdgW17UEn21IsiR68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/e0dXtxVTvXe4U0b3Cg1agoY+61j2nECJe/ZMtnxLBd5R9BO1
	DI39lbBRdNRTERqKn0XKd2NkmYEmKNpt9D7xkE9rwenKljFPpABk
X-Google-Smtp-Source: AGHT+IF/SiYd5lqR3tMuI1/TV4/981yonR0uSduTSphD/IKyJ+JLfMwoMsQPJqNdLCwQHfkSTmri7g==
X-Received: by 2002:a05:6214:390b:b0:6cb:ed3b:fab2 with SMTP id 6a1803df08f44-6cbf0074776mr45386496d6.19.1728673723674;
        Fri, 11 Oct 2024 12:08:43 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe8636f11sm18090176d6.125.2024.10.11.12.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:08:43 -0700 (PDT)
Date: Fri, 11 Oct 2024 15:08:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gur Stavi <gur.stavi@huawei.com>, 
 'Willem de Bruijn' <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 shuah@kernel.org
Message-ID: <670977bac8b03_247429294f6@willemb.c.googlers.com.notmuch>
In-Reply-To: <000401db1c00$bd86afe0$38940fa0$@huawei.com>
References: <67054127bb083_18b21e2943f@willemb.c.googlers.com.notmuch>
 <20241009065837.354332-1-gur.stavi@huawei.com>
 <67068a44bff02_1cca3129431@willemb.c.googlers.com.notmuch>
 <002201db1a75$9a83b420$cf8b1c60$@huawei.com>
 <67072012c983a_1e805629421@willemb.c.googlers.com.notmuch>
 <002701db1ae3$368d9b70$a3a8d250$@huawei.com>
 <6707e3028d844_20573a294f0@willemb.c.googlers.com.notmuch>
 <000101db1b2f$7410c2f0$5c3248d0$@huawei.com>
 <67085135e4fe2_21530629429@willemb.c.googlers.com.notmuch>
 <000301db1bbc$453feae0$cfbfc0a0$@huawei.com>
 <670937c990fca_234aca29481@willemb.c.googlers.com.notmuch>
 <000401db1c00$bd86afe0$38940fa0$@huawei.com>
Subject: RE: [PATCH net-next v02 1/2] af_packet: allow fanout_add when socket
 is not RUNNING
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Gur Stavi wrote:
> > Gur Stavi wrote:
> > > >
> > > > If we don't care about opening up fanout groups to ETH_P_NONE, then
> > > > patch v2 seems sufficient. If explicitly blocking this, the ENXIO
> > > > return can be added, but ideally without touching the other lines.
> > >
> > > I don't think that allowing ETH_P_NONE is relevant.
> > > In my opinion the 2 options that should be considered to fail
> > > fanout_add are:
> > > 1. Testing proto == 0
> > > 2. Testing proto == 0 || ifindex == -1
> > >
> > > The only corner case that is caught by [2] and missed by [1] is
> > > the "unlisted" case during do_bind. It is such a rare case that
> > > probably no one will ever encounter bind "unlisted" followed by
> > > FANOUT_ADD. And this is not a dangerous corner case that leads to
> > > system crash.
> > >
> > > However, being a purist, I see the major goal of code review to promote
> > > correctness by identifying corner cases while improving style is a
> > > secondary priority. Since we did identify this corner case in our
> > > discussion I think we should still use [2].
> > > I don't consider the code complex. In fact, to me, the ifindex clause
> > > is a more understandable direct reason for failure than the proto which
> > > is indirect. Having the ifindex clause helps figuring out the proto
> > > clause.
> > 
> > It's interesting that the unlisted fix does not return ENODEV, but
> > returns success and leaves the socket in an unbound state, equivalent
> > to binding to ETH_P_NONE and ifindex 0. This seems surprising behavior
> > to the caller.
> > 
> > On rereading that, I still do not see a purpose of special ifindex -1.
> > 
> >
> 
> Can this code be relevant?
> 
> 		case NETDEV_UP:
> 			if (dev->ifindex == po->ifindex) {
> 				spin_lock(&po->bind_lock);
> 				if (po->num)
> 					register_prot_hook(sk);
> 				spin_unlock(&po->bind_lock);
> 			}
> 			break;
> 
> Perhaps, although the socket failed to (re) find the device, the device
> is still aware of the socket and we need the ifindex condition to fail.

But the behavior is the same for ifindex -1 and 0. Devices always have
an ifindex >= 1.

