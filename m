Return-Path: <linux-kselftest+bounces-22107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AE19CF095
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 16:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18D0AB3C823
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 15:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BA61E0DC4;
	Fri, 15 Nov 2024 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y02bJzNX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33601D5145;
	Fri, 15 Nov 2024 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684808; cv=none; b=TwixIcWxptGhjbpUWIKe/tW5qb93F+F5j/1O7/7kibZuo65Ha429Qm8NNqTnzr9AXxkvtJ7/tekq7+daMTedq6NzHSc49bbOYm4HcEDR+SEnPV4hMMq4VtiQZGv8RXRXNzUUV4sQJWvbks4a4rBGnvWIjlHrpspL0RoFFziGD/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684808; c=relaxed/simple;
	bh=EQmW+6qtlic7muFJOBQKcRPW3U1LPcHefIwIJM6ZqeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgTizwobzUHu/DWjRn6I3xixO6qGs9a2ujaJUOj+MgPFhIx52r8s61EMAxy1eYQpLQdOLC3c4BQs+n4xSFKusgXXrbkRBmE7UGBNk0qov9K5vf9Lmw2RYyXMuZY0evsbubu6Yl+TZIyey8szt8Y0qrPXVcdo/Mf76TKzi4Anj/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y02bJzNX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c70abba48so20347655ad.0;
        Fri, 15 Nov 2024 07:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731684806; x=1732289606; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R4xDCj5B2QeGrTNDvnzO6HQLCL3c6E+XtripCJ8X3Mw=;
        b=Y02bJzNXKCYh7aTwdGop4Np8SoeNlbbSBfIAGeRBg62Y/VQ7Xj17jFWAjLECcttANz
         XIfTPxkxrUU6BdO3jd5/cFLyJ6kg8aDUwGHFPPz17b/YZCeKlmndqqk0Y5L7ARXiiFKe
         D1MvEOfTu5+wZXpkOddjVig2p8ag4Fs8HZ2UDaUflkxT1vXfgQsvyBzmKfaDDKKgIfSg
         Y/zIqNTA9enR69dqPvuR60Lzdmv2WMIogV1g4qzKAAP1xs+VNkqbBWmH//Q5RgXsxVh2
         zc+QkM4CwtHf/+/BHEDG4qoiwhp5BqnQR6iQgGasTiZZl0cmSnW3WQvvBPCGcUta8jpr
         NEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684806; x=1732289606;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R4xDCj5B2QeGrTNDvnzO6HQLCL3c6E+XtripCJ8X3Mw=;
        b=X+M59Vcq5ULBuSeusb03L12z9dM+oSYqDtz69pSjjPwXxRlHLApSKKJ+3LRbfAKn8F
         DCwdLzIXYzf86QcEkem0fXb/7TlaVMSamIxI7/uaiNkoMfJExUiwS3Wx0hTAj6OLANW9
         +cLwfInJDlUqv2jPST6AMXW+sRvSkc4mH4wT/ewGdJ4Ph8Jmv6fxkwjCZY8MkcKlNGQe
         asth7fCGnz48vvK+j+g/6t4Xn4L/gPi/zEPaN5mvRjYgeu8wy3S5EUAkojVq+gphbZB3
         1mvgBNbjrfrSluW7c1lxd61XgYC6SUZaBoyS3z0kFhTFelMwqqwyb21WXmlDtGwFwSWM
         IoJw==
X-Forwarded-Encrypted: i=1; AJvYcCVLda1vgIQcWOm0tgueBq9XyKPJk9lnXjyGN1F4TU54996ltz2DHmcHWG4rqpgC42aEomA=@vger.kernel.org, AJvYcCVbBwlm0tU5+WJ2EKTiUru40uWO9ys9bU8+owAng/kOpHwxadh1CvQVIDak0HAOQtSOFrh7KM2qmlWmKsqY@vger.kernel.org, AJvYcCVepxvsA6PYaYDX1QahNcyGB8iuWrqnRq/h6QvOd+0BSap5HDGvbXBiHI0YuJXciJ8H51o0mBHV@vger.kernel.org, AJvYcCX82Drk2Ez1rPRtEXmSoYxiWN8yO5sB3xC3eEFNPkCysogu75umjJaX6JAUZDzSvPu/zdQoaxXTy4T5c45VcyQg@vger.kernel.org
X-Gm-Message-State: AOJu0YxGW64DxKDiPYQuKBvcThJKQjYWJcc+o8TxjsFe+8ilmyAVPAEv
	KR1lqSmJkEQN+5IRKEnlWFKUHC23jl3j0xI+hiy1eLWMwX6AOYQ=
X-Google-Smtp-Source: AGHT+IFdNLJpKmGKgs+Fdc+XyEbqC4Q7ibZECpAVJgFfNUW2ri9gW30CImhEHhaKAvks7ItIU3ci8A==
X-Received: by 2002:a17:902:e746:b0:20b:80e6:bcdf with SMTP id d9443c01a7336-211d0d726b3mr39033025ad.23.1731684805713;
        Fri, 15 Nov 2024 07:33:25 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0ec7db9sm13545245ad.63.2024.11.15.07.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:33:25 -0800 (PST)
Date: Fri, 15 Nov 2024 07:33:24 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Alexis =?utf-8?Q?Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 10/13] selftests/bpf: rename pseudo headers
 checksum computation
Message-ID: <ZzdpxDYzwDDu5W6x@mini-arch>
References: <20241114-flow_dissector-v2-0-ee4a3be3de65@bootlin.com>
 <20241114-flow_dissector-v2-10-ee4a3be3de65@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241114-flow_dissector-v2-10-ee4a3be3de65@bootlin.com>

On 11/14, Alexis Lothoré (eBPF Foundation) wrote:
> network_helpers.h provides helpers to compute checksum for pseudo
> headers but no helpers to compute the global checksums.
> 
> Before adding those, rename the pseudo header checksum helper to clarify
> their role.

Same here: let's keep the old names? They are matching the ones we
have on the kernel side so it's easy to find them. I do agree that
the naming is unfortunate :-( If you prefer, maybe clarify with
a doc?

