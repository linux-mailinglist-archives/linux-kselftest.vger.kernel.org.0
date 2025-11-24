Return-Path: <linux-kselftest+bounces-46399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B680DC820D3
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 19:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BACC83497E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 18:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3C931961D;
	Mon, 24 Nov 2025 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0DI7Gcj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46516299AB4
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008137; cv=none; b=WY+NL1AHdxvHmKucMO/Sd4c7vxaDbjY8HwV1Qr/KqCpfaF1VcrbGDQ17GJ7inCZGvQCTFhRmskbe/WvgjPseEQYkzchvWmpN8aBikMZ3IjoQVg+j4f5Bhz+Emc/he1YGN26m67JSKey1UFiPzks1jE30CrPs/vvHYZbFDmetr3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008137; c=relaxed/simple;
	bh=9OsOtu2FdRcdJ07h5ePZqFdT7LILIFGuF6mCtnACmDk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GLYzS/7SPSwjOs4IafiE081EYoeoI9b5t5hXBw5kUVSGN1UYkqpdrlYyla9hZEgjVeGu9sU//08SGdiSHfIo8ghiuQy6NG5cSqIZbqYj+tMhGjwnhkXSMYbkjYEuj8c2CeFlVWNTS3Pe1+vg0S7WgNWmXqXI09VueY1aLyKbsiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0DI7Gcj; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-786943affbaso32877927b3.0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 10:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764008134; x=1764612934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocgYXOVPq3H23c7s3bIbF+RIkWJqwfLZLsXUE58QTME=;
        b=F0DI7GcjN2Zh6kP52XzPrWWK6vpuf1FxNx5vvkjnRgGw8bfowb63tX768OP3OD3zfB
         fPFU86xibhiaLPmuxnbvSD7owo+a95j4I6lFfKt/ORyg2aIubCQpj5m9jYoA/TK/hNm9
         T8mUnumI0aiC+hxLcCHPuyU1Yiprx3wHYnYpqp7p4OIRnFqDpjH/Cllev1RAm866pnst
         RhU+JtGnli4K64yoMczcyeppe/FfQmsPRayxbfs+h/vWPTe8HWg2U6DFbfQV3GvH3Wbl
         V3kxzPEsAeD8JmqgWI6CyHg/1v0zrWkFw/AvrkNevhlK025GcklTuf6VD8PIAdK6U8gN
         zkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764008134; x=1764612934;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ocgYXOVPq3H23c7s3bIbF+RIkWJqwfLZLsXUE58QTME=;
        b=coIYOZBoJBpDPDQEVs5k50N0uHb53gsgGJGvQD0oKFRbLDYpSC5Xd9rGCLVcuKdqvJ
         IB6Fy3cjB2eWfJOBLlttdgvUGsIDLTPFaVxAr2LApMuuOkX5BJ/rxcVGd5u0VxZKZ1Xs
         QYicd9hsVFEhWeiHFkbLzoOJGy95vw36fgtvqab1nzi6mzD/rD7QD1Nx/2Nk3Qjnc1kd
         4cMGWlW6bbcjWVNpzWuWvxLl2qvx56pzOXWZJQdq1NnBYK1gRisv6Gi4etYFduXgQM0Z
         OnawMTZMWHDpP665f2qbQj1LYOiKt0DvPY+Zf+Qwu4fMmJ8jPcNaB/o/0SLmhZ8MnRLJ
         jb+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRyRsGugEo//3qIDwNuCA8/wVVp5xRCjKXs/zfhxljZbJKIzwFlLIERJ/nYGqjxfXQB5IGrr6mr/ldkfyScKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3M3UNMD7j3wLGd5rFWzEFnAJcouvInrK03ApQy+YBW+2HcEjz
	N3NQ0qBoqmLyB921X/kI0f9+C8ePEW85F5PkQdRTlP0UlJELRIgANDvE
X-Gm-Gg: ASbGnctnehk24R/G76Br/5sIcv0hM5+4oApLbE59jNiYZERTqOcunS/Y3EOI4IrGtrK
	HrYXd5hvnUNl2bc1MjHtkWjpdoTUdLRvksPTlWctIp5AXNCaboIHWygbaHrTr9t0KTLDvADQ/32
	v/BsS1xdksBgsVkQIBFr5dAjK8DPrXRPfoHDucemsrypUTqjZKiFSiCFJaO7B5ehwAxBSpkkHTI
	JmvYpMGGU7cjDW+Mn8EMgEmWOOQVrqWmE5iL7IYtaEdPOfY7FCjwa7USFq3bPm/jJ7KYSqvrxMQ
	8y46KEb4WRipjT4/dZiQMSEPs5Tx2JnLx+Xwq6SDieuHoWKzw7WkbSU8VNSSsL0kt5v3ePidBkA
	JIrOAh1KE1Or3iM4C03mxvtKxmOUMafekMiKx6oAROW9WGZ7CUk5sUj830sFqVGj5x3oOWZL29k
	Xayf7quIQO+9lYjF/3344yDgaasb62Nr9zUcNgDFB4f9Z9RaEnSTrdCMMm4f8tfTUlu7s=
X-Google-Smtp-Source: AGHT+IHKw38JYHIxZFzyhwOjV8GuTsmYuY4+zL8F9XRTar88RbjKnm9PRPGZuonaN2Z6WT66KIVDGg==
X-Received: by 2002:a05:690c:4482:b0:786:a185:13b6 with SMTP id 00721157ae682-78a8b4aec25mr105084257b3.22.1764008134312;
        Mon, 24 Nov 2025 10:15:34 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78a798a5decsm46985517b3.21.2025.11.24.10.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 10:15:33 -0800 (PST)
Date: Mon, 24 Nov 2025 13:15:33 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jason Xing <kernelxing@tencent.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1e69bae6de428@gmail.com>
In-Reply-To: <aSSdH58ozNT-zWLM@fedora>
References: <20251124161324.16901-1-ankitkhushwaha.linux@gmail.com>
 <willemdebruijn.kernel.6edcbeb29a45@gmail.com>
 <aSSdH58ozNT-zWLM@fedora>
Subject: Re: [PATCH] selftests/net: initialize char variable to null
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ankit Khushwaha wrote:
> On Mon, Nov 24, 2025 at 12:46:52PM -0500, Willem de Bruijn wrote:
> > Ankit Khushwaha wrote:
> > > char variable in 'so_txtime.c' & 'txtimestamp.c' left uninitilized
> > > by when switch default case taken. raises following warning.
> > > 
> > > 	txtimestamp.c:240:2: warning: variable 'tsname' is used uninitialized
> > > 	whenever switch default is taken [-Wsometimes-uninitialized]
> > > 
> > > 	so_txtime.c:210:3: warning: variable 'reason' is used uninitialized
> > > 	whenever switch default is taken [-Wsometimes-uninitialized]
> > > 
> > > initialize these variables to NULL to fix this.
> > > 
> > > Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
> > 
> > These are false positives as the default branches in both cases exit
> > the program with error(..).
> > 
> > Since we do not observe these in normal kernel compilations: are you
> > enabling non-standard warnings?
> 
> Hi Willem,
> 
> this warning appeared while building the 'tools/testing/selftests/net'
> multiple times. 
> Cmd used to build
> 	make -C tools/testing/selftests/net  CC=clang V=1 -j8
> 
> while test building by "make -C tools/testing/selftests/ CC=clang V=1
> -j8" doesn't raises these warning.

This does not reproduce for me.

Can you share the full clang command that V=1 outputs, as well as the
output oof clang --version.

