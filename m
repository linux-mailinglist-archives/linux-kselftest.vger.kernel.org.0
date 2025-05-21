Return-Path: <linux-kselftest+bounces-33475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4296ABFC62
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 19:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 562807B6A9C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 17:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB6928981C;
	Wed, 21 May 2025 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3mzv2TE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCB418BBB9;
	Wed, 21 May 2025 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747849143; cv=none; b=NgBuK9rT+mMagzJvgRJyTVcSLpbXgYZKFtycpRKGZSalVkJXETJN7BEKPnG/JIyXF1XBwL+lPK9cweji7eAugNI/lcso0cVzfUoU0UDjsPEqrKl2IkPqjlS5+0Q2jjMJ5ivVivTd8WBFW1kc9r1o0kSZKrSHDseYQqzOWQ93qU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747849143; c=relaxed/simple;
	bh=d/9Lay8ip8ab2au4iqVimFzQ+8m1zbw8sHdz0x7aqTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etcPd61g32vXyCpye1eHdvn609viTKPWwfDN/aqVYI0oeO8HbpmEkusZU9E2I6TUteKi2oGnCrIkAY+fhczJ4kLQouukrWbdI7+qClkgapmEkmRDw1b2JPX/KE61jdJfz3i2e2wLATOw3yCt9rDblPYTiRmHj77J/QssN17UmKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3mzv2TE; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-742c7a52e97so3459297b3a.3;
        Wed, 21 May 2025 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747849141; x=1748453941; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vYkbEtNCxtADeXC2wY6jcT2l9Xzv0aneRRtY1QU7dgM=;
        b=a3mzv2TE3y32j+ufBTexsB7lWGqk3ygt/aLSONLOz++WDmEHgXsSq5fMivdUhOyWRo
         PZ+L7xQfoAMcgyyVdgLIvDW9EN25h0yJ1QsXdJofYCjr+ep8sooisBJGENpa92lROk8O
         ntyHQ7uxGj+j6kVzTLh72VAKRBVuXxQwBK9vDoumXc8bwX26bvzkQ2VOO7S4DVo0lmMC
         rChch5iu5+T+YkAgaRtd7cdfG24oMEpv6PQ+tlegEkVQq4AsiKkQ0gbTEH340yfFgm1b
         C4Si2LjOB2B4IoJx12CTY5QNHpH5LpZswzApmTm/rgyj5y+Ep8UyeY3p8gwKndsHjPut
         r5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747849141; x=1748453941;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYkbEtNCxtADeXC2wY6jcT2l9Xzv0aneRRtY1QU7dgM=;
        b=WFSWMq7scPMn+N0t3Qo0xnd1wTY2OQL9YYYvNvbg3oM0zF/Kq4fT0lj9yFE+Dzs9kl
         lwXuOuXjEmRdJVwBAZaabwCRh1f6dCT4Gs5Uj9+Dm1fxI/i6L0BtOevtZG8yPhDOaE7S
         tevSFeaDiB1jCe3eJts8BrSBaUR+a9lkhbaiuv7uXkNBs8WJRcvh7aPcEIc94iKhJRXV
         KJIDE8UwZQocS/HFO1ztQkZNFNNS/dBQeVhRhI0fxD1A4ZyoNuqtChBc4mZ0LnIgMMc2
         yr1uW2kGPoVtAE+hjCl+fmbJzWjCAKxQfG6WR1wsBapHjUZ5S5KGLYLIzYf4HNgTkccE
         qyqA==
X-Forwarded-Encrypted: i=1; AJvYcCVaurHCCUw8L2d4CfQ3JyuqO6g5AOQ75J3wz/NbDASjcf2aUNKqB+72Gme2l/KFIcFuC5NSy6Tdzv8X9Fc=@vger.kernel.org, AJvYcCXopQLRVHjT4eUau1eN6yUewzpED5m/6REhblefF6KmEGTBzKHtsaSboZ6n3lB+VfXVR4K3aEJaB+vclg3kIGYI@vger.kernel.org
X-Gm-Message-State: AOJu0YwAIQVd+d1rliZCTzhitOFfX2KqehaZD41MLxQjeoivTnJjCroB
	QP3aqQ4jFN6u4vu4YBac4ztRBEuOu/cjBdIJTP7d3aXylPBmu0dDbMg=
X-Gm-Gg: ASbGncuW8QsNfstbQoBF+sE1feDhoIkuh9R4atQB/rNrIVr1wGr2kwAMuOBdh2YBuoC
	I4wOW68SyjGFYEiUF6jyQyA28Mh9dSaHDKQTES+ya/x+uYKldH3zv4dOiL2hpwfTowMVDIawgsH
	TTtps2GkHnWLioGzVKsUdv4C9BU2k3HF0obM2rj/3F9pLN2i5BpYDQCu6jkVNB+N1iEXd2THDM7
	rzTg7oL1xemiGDrb3oEw8rgKbxTI5V2TTbuAVXtGoxBs7NaCCWnhPmvqf2p6ZUiMszo/M8lazJn
	cyfxKYGKmZvIDYwQzxDQCq5zWTkgSW1wgxxaFEt/pmFmxuB17UF2V+F5oO0H0guw/aaMwuXTunx
	mqfIM9QVFU2LT
X-Google-Smtp-Source: AGHT+IH0uxIYsHODNRzqA5pDLFVF2/9GobTHWHdmmypo3wi5vIQaTNvzU2nKE3Kc8UqMvG/b4LQ+9g==
X-Received: by 2002:a05:6a21:710a:b0:1f5:9069:e563 with SMTP id adf61e73a8af0-2170ccb38b3mr33129046637.21.1747849141396;
        Wed, 21 May 2025 10:39:01 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-742a982b7e8sm10220305b3a.90.2025.05.21.10.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 10:39:00 -0700 (PDT)
Date: Wed, 21 May 2025 10:39:00 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, viro@zeniv.linux.org.uk,
	horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
	sagi@grimberg.me, willemb@google.com, asml.silence@gmail.com,
	jdamato@fastly.com, kaiyuanz@google.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] selftests: ncdevmem: make chunking optional
Message-ID: <aC4PtKAt5QF655uZ@mini-arch>
References: <20250520203044.2689904-1-stfomichev@gmail.com>
 <20250520203044.2689904-2-stfomichev@gmail.com>
 <CAHS8izNwpgf3ks1C6SCqDhUPnR=mbo-AdE2kQ3yk4HK-tFUUhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNwpgf3ks1C6SCqDhUPnR=mbo-AdE2kQ3yk4HK-tFUUhg@mail.gmail.com>

On 05/21, Mina Almasry wrote:
> On Tue, May 20, 2025 at 1:30 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > Add new -z argument to specify max IOV size. By default, use
> > single large IOV.
> >
> > Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> > ---
> >  .../selftests/drivers/net/hw/ncdevmem.c       | 49 +++++++++++--------
> >  1 file changed, 29 insertions(+), 20 deletions(-)
> >
> > diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > index ca723722a810..fc7ba7d71502 100644
> > --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > @@ -82,6 +82,9 @@
> >  #define MSG_SOCK_DEVMEM 0x2000000
> >  #endif
> >
> > +#define MAX_IOV 1024
> > +
> > +static size_t max_chunk;
> >  static char *server_ip;
> >  static char *client_ip;
> >  static char *port;
> > @@ -834,10 +837,10 @@ static int do_client(struct memory_buffer *mem)
> >         struct sockaddr_in6 server_sin;
> >         struct sockaddr_in6 client_sin;
> >         struct ynl_sock *ys = NULL;
> > +       struct iovec iov[MAX_IOV];
> >         struct msghdr msg = {};
> >         ssize_t line_size = 0;
> >         struct cmsghdr *cmsg;
> > -       struct iovec iov[2];
> >         char *line = NULL;
> >         unsigned long mid;
> >         size_t len = 0;
> > @@ -893,27 +896,29 @@ static int do_client(struct memory_buffer *mem)
> >                 if (line_size < 0)
> >                         break;
> >
> > -               mid = (line_size / 2) + 1;
> > -
> > -               iov[0].iov_base = (void *)1;
> > -               iov[0].iov_len = mid;
> > -               iov[1].iov_base = (void *)(mid + 2);
> > -               iov[1].iov_len = line_size - mid;
> > +               if (max_chunk) {
> > +                       msg.msg_iovlen =
> > +                               (line_size + max_chunk - 1) / max_chunk;
> > +                       if (msg.msg_iovlen > MAX_IOV)
> > +                               error(1, 0,
> > +                                     "can't partition %zd bytes into maximum of %d chunks",
> > +                                     line_size, MAX_IOV);
> >
> > -               provider->memcpy_to_device(mem, (size_t)iov[0].iov_base, line,
> > -                                          iov[0].iov_len);
> > -               provider->memcpy_to_device(mem, (size_t)iov[1].iov_base,
> > -                                          line + iov[0].iov_len,
> > -                                          iov[1].iov_len);
> > +                       for (int i = 0; i < msg.msg_iovlen; i++) {
> > +                               iov[i].iov_base = (void *)(i * max_chunk);
> > +                               iov[i].iov_len = max_chunk;
> 
> Isn't the last iov going to be truncated in the case where line_size
> is not exactly divisible with max_chunk?

I have this for the last iov entry:

   iov[msg.msg_iovlen - 1].iov_len =
           line_size - (msg.msg_iovlen - 1) * max_chunk;

I think that should correctly adjust it to the remaining 1..max_chunk
len?

> > +                       }
> >
> > -               fprintf(stderr,
> > -                       "read line_size=%ld iov[0].iov_base=%lu, iov[0].iov_len=%lu, iov[1].iov_base=%lu, iov[1].iov_len=%lu\n",
> > -                       line_size, (unsigned long)iov[0].iov_base,
> > -                       iov[0].iov_len, (unsigned long)iov[1].iov_base,
> > -                       iov[1].iov_len);
> > +                       iov[msg.msg_iovlen - 1].iov_len =
> > +                               line_size - (msg.msg_iovlen - 1) * max_chunk;
> > +               } else {
> > +                       iov[0].iov_base = 0;
> > +                       iov[0].iov_len = line_size;
> > +                       msg.msg_iovlen = 1;
> > +               }
> 
> Do you need to special case this? Shouldn't this be the same as max_chunk==1?

I might need a better name. max_chunk is the max size of the iov entry
(max iov_len), not the max number of IOVs. And I use max_chunk==0 as
"max size of the iov is not provided -> use line_size", so not sure
I can't make it work without a special case?

