Return-Path: <linux-kselftest+bounces-43693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3043CBF93EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 01:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F12C4E3C52
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 23:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2315B2BD58A;
	Tue, 21 Oct 2025 23:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAy9lZLH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D91820FA81
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761089521; cv=none; b=pAUZpRsq1WJqct6F+PB7QM33+ImaLKQmaCfh1HhECvJmeg1Xo1xf6vlHo6q66RXvmjLL+pc2xSlLsfInRD5ZT2HBsR3FXcA7QBPhJZupmdlz9zFQxzrgwvk7jCDYotvTwF9RkA5ItW8xyuuR2IV4sF9UHuHfTdxyUe/S35LzZgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761089521; c=relaxed/simple;
	bh=pqqWmzw7DjJdnFf8r+/KCbFt0dIYwNLmYz8AmwYgSR8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=meSXK8ylGKceoadkI6MdZKComowamOfV9N1eb7/Zv1aqUth0fFZXf+0tp3pm9b1FJMvcH3tvG4Pena+w7a5Mh9ZpERbzXtnJ3gb/bOkNALypA3NZOx58KBWA2iZvC+lVt9w8wX5CrH5NkaV/Lx41JP/PbLkNgTJvFlxYfRzM9wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAy9lZLH; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so5768917a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 16:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761089518; x=1761694318; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vcxIn3xS1W1KdT5lDY1lIR5M97MqhUxp9HDJPsXzhq4=;
        b=bAy9lZLHPzNYzadbzUzir1Mm5vQm8mGhLBFWFOFTj8yHGO4/1OiUckqDaKRUpGhdrV
         e/nIgScgstUUUIxES9i8Mb7kd6B6TbfKCOKVpucHtw9zt04mGRMUAkb4JgcOQg7db5vm
         qOeadvu074q6gqFNkpCHyUIfi/CtH1eoodYPaWd6gLqmaDCyfqvyFu7xBDIo9NoppqgB
         wCIDzMlnwxKqfkG3V6Dq/okyPCiwC9ELEUXLPjU7CeVaHnnElFzghKFqEZHSPV8mSSTP
         gom+3Bh+XiFlTB14dozJNnRzP/YHhpXHj3OGPpE3CFni6YhnCIqnREev6IEAfl7wF9v8
         zdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761089518; x=1761694318;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vcxIn3xS1W1KdT5lDY1lIR5M97MqhUxp9HDJPsXzhq4=;
        b=EMwcgDEMnzAtt2u3xicRxZrBrdG58+VGU6Wkt3Y0HGriwY11vexizQXdX9jzn99YF1
         0aa9EOPAJw5c/EXjPVDAQTiFtI15vH8fO7IZ+nKC0r/rrxl7q8YtRA+F9XUoClBBlhQ4
         G1xHllE3JkeeQum5NNT2DSAJj4Op1/VzLL0AlIpZVb5YOtbeleAMBsLM/zmQp9o3lrxN
         U70XHEVLYzFNpFsrOYiA4gKJc+U1Cq5wztNKZ2CtR3ypKxkqE2aXMZ89Ox7TwYqKpvBZ
         2nHxV+pWXGRDYKXyYA5ARc4VdkJv8jbM5EzTrSGGZvCQkCJiOUlB/j5QZqJLEOexN9Ws
         ZWrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1TIn2mJMFA6gzynISdKPxu8VihOhwA/UO8jaCziPY66+kAxxONOsYsq0cI8wpz13F0Vv/fWZLUYA6URKz7bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzQnxEfpiuuovrNOkJXdJNpgL05ZUxdx/8xCMrdEdhYjrryGGR
	iaFSXa6ZqyoGC+/8U5PzRlY1Z01U2JOlINnXMYK9XQYQHflpcLXLgaV+
X-Gm-Gg: ASbGnctPwDYJ3nQl9Ez+dlStOnMIN4IjW8ZoOcrIkWX6Uojr8EqdFvzqYFJL/G/sDZY
	8d2CMIhQ0skHfwF/lRw1zsJqgOvNs68cRzgLRJ1W5PJ6suFYJM4lKGLS59Tv/y3Z2hmamy8wekq
	LnaUX/Tjf/mAfxxE8uqoyhPV+lEkkOYD3hoFqmhY2/T0Eq5uYfBXOYfXiMDiTjECwna3qAcstVy
	G7LQDiRlxbyZz5z7dSF0+VLpaCWfiGEyGEA4+3GCGlWGaaeiW92e0e8wslfj40Pv/1P60tD4wbb
	EFiU/NIjw0c9K9A5bbr3U3SdtNCXE5pxtDZ8+6P3aftGoQJoNwXKl55Kh+ziEuXP7ZKLUSBEMt8
	Ee1jVzAS8pveT6+65OcPs6A8a6Q4LAJpwF6mhPSXVfxS8d3pwQf3/ga/FJ8HwuUCtkKGp8UTYCy
	akPDYeMYy4WAPvb2WnnM9a4DAhBdegiA==
X-Google-Smtp-Source: AGHT+IGzAsvapfQPwXxI8Qn0+WUuZk0fpYv0ATQ3QcqzMDCO7tvMff3/oU84M5k7fByuu6Mv1I4JIQ==
X-Received: by 2002:a17:90b:48c8:b0:33b:ba55:f5dd with SMTP id 98e67ed59e1d1-33bcf93ab88mr20368837a91.37.1761089518516;
        Tue, 21 Oct 2025 16:31:58 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e2247a359sm678229a91.12.2025.10.21.16.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:31:57 -0700 (PDT)
Message-ID: <ba52cb688c9fd3209feefc5f7927d929190626fc.camel@gmail.com>
Subject: Re: [PATCH net-next v7 1/2] net/tls: support setting the maximum
 payload size
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, Simon Horman <horms@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>
Date: Wed, 22 Oct 2025 09:31:51 +1000
In-Reply-To: <aPeASl1RRAKMmuhC@krikkit>
References: <20251021092917.386645-2-wilfred.opensource@gmail.com>
	 <aPeASl1RRAKMmuhC@krikkit>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-21 at 14:44 +0200, Sabrina Dubroca wrote:
> 2025-10-21, 19:29:17 +1000, Wilfred Mallawa wrote:
> > diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> > index 39a2ab47fe72..b234d44bd789 100644
> > --- a/net/tls/tls_main.c
> > +++ b/net/tls/tls_main.c
> > @@ -541,6 +541,32 @@ static int do_tls_getsockopt_no_pad(struct
> > sock *sk, char __user *optval,
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > +static int do_tls_getsockopt_tx_payload_len(struct sock *sk, char
> > __user *optval,
> > +					=C2=A0=C2=A0=C2=A0 int __user *optlen)
> > +{
> > +	struct tls_context *ctx =3D tls_get_ctx(sk);
> > +	u16 payload_len =3D ctx->tx_max_payload_len;
> > +	int len;
> > +
> > +	if (get_user(len, optlen))
> > +		return -EFAULT;
> > +
> > +	/* For TLS 1.3 payload length includes ContentType */
> > +	if (ctx->prot_info.version =3D=3D TLS_1_3_VERSION)
> > +		payload_len++;
>=20
> I'm not sure why you introduced this compared to v6?
>=20
> The ContentType isn't really payload (stuff passed to send() by
> userspace), so I think the setsockopt behavior (ignoring the extra
> 1B)
> makes more sense.
>=20
> Either way, we should really avoid this asymmetry between getsockopt
> and setsockopt. Whatever value is fed through setsockopt should be
> what we get back with getsockopt. Otherwise, the API gets quite
> confusing for users.
>=20
Ah I see, okay I will revert this change :)

Thanks,
Wilfred=20
>=20
> The rest of the patch looks ok.

