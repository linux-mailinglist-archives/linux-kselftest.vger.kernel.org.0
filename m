Return-Path: <linux-kselftest+bounces-17536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D03D972137
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 19:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34EF31C2092D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 17:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4466718A947;
	Mon,  9 Sep 2024 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9+JeKmi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26D118A940;
	Mon,  9 Sep 2024 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903507; cv=none; b=Q2VX/MkSLxDgzL9RYK745fwlQUNqdDG2xhktOpbLOB5JO03FQ5f/BAIeg0qvvBzoB5p8QWyznw/+FuZx4f7mal/rDsb4K1jdOigPfq0F807bjKMCez4JsR2+tU16HcKbTDbWeGNNhWuZG2/zKFtTlwLIzohhqlh7Ujo0rWb+HPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903507; c=relaxed/simple;
	bh=fMnYjZ7puk4RyEsIR/egM5RTuWKhQoMKRiFm4XTMEHI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qph2huKDpRH7+8DEeQu/Jl7uMYj8blrSV8TffdENGjZazJQWt3Hs6+4N5ZfK3sWiLJbIl6QTxcOYF0esJHRQqon1+mgHovcoQ38EwNMnu1MBj8hsrLDarHl8JI+9r4efCi01+bvZqu57S0nKsCQGbu7iPpbXa3/bz2yKnX0hE/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9+JeKmi; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a9a3071c6bso186798985a.0;
        Mon, 09 Sep 2024 10:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725903504; x=1726508304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWcguGccUwTR9BOegZpc2dDEqNjenCK0RnfNy3CIhcs=;
        b=Q9+JeKmiVpHPXOtpq0jSN6SCB6aJkz2iDwliLZU536I64BmDMqT+d2qvNcK8GZ1gNl
         QfBRu3G66b944VHpH/AS9xUhH5n8CReD8ze6qnExm+BIkbEHbcgx+A45LWIZgb9bF35N
         5Wo8BwMqTv73g1vUfWF0BIcb+roJkiG30i0CDT+Xl6f0JASZTmf4cfgneE+lv0khgosS
         LSucPKLqXOG+RHIbsUdyBwhsQs3v86QzlF4KCci36eWVFkzCt/oV/1aGY0TbMHlg4yCV
         D2fM8LOZWvmPmG2is1NgjeD7pTXDB4VDvrlHm1kI434QQ4lJleHSauX/Xifs16iza0k7
         flRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725903504; x=1726508304;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wWcguGccUwTR9BOegZpc2dDEqNjenCK0RnfNy3CIhcs=;
        b=tzyMW8XRLzMRNRVwLNZ3adsz3n6oo1EYAaXcU8ZHlrgUGxT4BSSlwjjDFWr/vm4R+r
         uyMK7UNJsOv2p92qfNljPeqZaTkoUeiYKoT7V5jAGX4YdynT7SvJrEyBEMEyOx1mR6LP
         fpnlCjnmxq8OY6AsjWI08SwgBcj+Ur0/DRcr0Zu9z1LRyUeYqdgjLyfProB/+pSrt45L
         MVvOsy/hcmH0A3hyYSskZ2L9RGTHuqRRbSMd5MSctSILo5wbm/5ia50GWxqwVTATBqUX
         y/r4WA38rN69zr3DVbSZ60kq9xXgaWe0JiOLyAZTF9u2sHBEoh+nKu5/yO39r8cEYIGm
         9pqw==
X-Forwarded-Encrypted: i=1; AJvYcCViiYd/Wd6/dMoWf3NtT1glZSZjO2nQShA+RUJ7vRoO1cS5RCiqwQ104GUBzHK/eKVFd3Wcra3yVGeIophU7GU=@vger.kernel.org, AJvYcCWBlRjMOe+UQrxLT2yJeBv7R7jwWwX6UGDYll4tXvEkihAWHFBkha3swqYLDLUKT9iQ1l4Tt8Lh@vger.kernel.org
X-Gm-Message-State: AOJu0YwDDDE2B2owr0KAV3EZvVEmk2m+HM10qNSLrqELSnKd9fIU+lNa
	MPVxFtorKHAk9Rp8D9SPRs6jKmybZjY9d09aRVE6XOR/YwH5zw5r
X-Google-Smtp-Source: AGHT+IHB+K+FvjbBd74mem+IwvTs/UYXCR/CU1rh4z6I4/uki7FGMzFbiwmMuMjQkkr/kCMBvzPqvA==
X-Received: by 2002:a05:620a:2946:b0:7a9:ba35:1869 with SMTP id af79cd13be357-7a9ba351bbemr349259085a.51.1725903503683;
        Mon, 09 Sep 2024 10:38:23 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7945734sm235949785a.5.2024.09.09.10.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 10:38:23 -0700 (PDT)
Date: Mon, 09 Sep 2024 13:38:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 willemdebruijn.kernel@gmail.com
Cc: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66df328ee959f_3d03029484@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240909102309.3da82583@kernel.org>
References: <20240905160035.62407-1-kerneljasonxing@gmail.com>
 <20240909102309.3da82583@kernel.org>
Subject: Re: [PATCH net-next v2] selftests: return failure when timestamps
 can't be reported
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Fri,  6 Sep 2024 00:00:35 +0800 Jason Xing wrote:
> > When I was trying to modify the tx timestamping feature, I found that
> > running "./txtimestamp -4 -C -L 127.0.0.1" didn't reflect the error:
> > I succeeded to generate timestamp stored in the skb but later failed
> > to report it to the userspace (which means failed to put css into cmsg).
> > It can happen when someone writes buggy codes in __sock_recv_timestamp(),
> > for example.
> 
> Willem, thoughts?

Reviewed-by: Willem de Bruijn <willemb@google.com>

Sorry, lost track of this.

