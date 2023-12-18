Return-Path: <linux-kselftest+bounces-2132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DA8816935
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 10:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB962813B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 09:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3677210A3F;
	Mon, 18 Dec 2023 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFj9vxgI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC93610954;
	Mon, 18 Dec 2023 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d774533e73so742380b3a.1;
        Mon, 18 Dec 2023 01:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702890376; x=1703495176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mQgfAfNGf1z4lt/9O3/QZAJqpk3m9IQDWyvNsKpSGgU=;
        b=bFj9vxgIW/AE7Wd1wyUvcjT2kbJyXuZe8YrDP9/lXaCgEfVcPWP82s8cXemlw3KVW0
         qTLsqWeI/0QPdnZtGRbKsGcCi5R4DvsW7IONC+TwOeWRHovvkjstd1opWXZwQ1/1cdsW
         7wAI0iTkitBpAIdnQDoEj/HbY3/+GD/wfTDkTPXqeKPt9wc5/FMQ+d+5nCUeTC+ch3uK
         SXmueBmT93XRkSx0kx/o6/XwlZurNOyPX9d3eiaRxNrQwI3AhXx74IetQj53TYhzJCXQ
         1xppR8vtOgQOwhC6Aft76niwiHySWpqWGnAp4U77iZmRrEm3aHFjmoKGpISJT4SSqQGR
         Qj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702890376; x=1703495176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQgfAfNGf1z4lt/9O3/QZAJqpk3m9IQDWyvNsKpSGgU=;
        b=DZOQpBM3nPPuUB34b+Fc1of6whYJ5IRgST65Y+khHl2SENFjm481XU+9V9B20+Upin
         nxXEKFfY2nZaEeyqWn4fsx3Mv+ae/aGeGPmXIuNNQQXF8nPHWYyn7f0SLV1Q6WDG7phI
         QIlWbr0KydGfLZ7JhAYODJw8LOZTSBqRspsfvF9tZdgY/94qjSq7O9xVKcEU+CIJ1Vip
         XX4xGZycifkMM5RnA32DqtbVy+DLF1wRNSwEdBM+MRblSBgIq0AUR/n5NYyxashtuyfC
         nfO811Tti1AyswA6q8oqpbflFocGwC51fnqxLTWdVWDqudxbOMa6JGEagcjxG+iH45eg
         8+cA==
X-Gm-Message-State: AOJu0Yxrl+uqPZjf0USjBMcT9PED/J5YXQOfUodfDqyFh384grt5kOv5
	E+eRLHpWEKa9wMm6o1qPado=
X-Google-Smtp-Source: AGHT+IEv/aSCkdo7BRNdRUZExM4gFY6mzJBiWGZZsHLsWVCnXTiczunqDX0QCQXMekV10S3gnQFprg==
X-Received: by 2002:a05:6a21:99a7:b0:18f:fbe4:ca79 with SMTP id ve39-20020a056a2199a700b0018ffbe4ca79mr20156608pzb.68.1702890375996;
        Mon, 18 Dec 2023 01:06:15 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id pw2-20020a17090b278200b002867594de40sm786078pjb.14.2023.12.18.01.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 01:06:15 -0800 (PST)
Date: Mon, 18 Dec 2023 17:06:10 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Dmitry Safonov <dima@arista.com>
Cc: Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Salam Noureddine <noureddine@arista.com>,
	Bob Gilligan <gilligan@arista.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH 05/12] selftests/net: Add test for TCP-AO add
 setsockopt() command
Message-ID: <ZYALgo_J6E4vXewq@Laptop-X1>
References: <20231215-tcp-ao-selftests-v1-0-f6c08180b985@arista.com>
 <20231215-tcp-ao-selftests-v1-5-f6c08180b985@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215-tcp-ao-selftests-v1-5-f6c08180b985@arista.com>

On Fri, Dec 15, 2023 at 02:36:19AM +0000, Dmitry Safonov wrote:
> Verify corner-cases for UAPI.
> Sample output:
> > # ./setsockopt-closed_ipv4
> > 1..120
> > # 1657[lib/setup.c:254] rand seed 1681938184
> > TAP version 13
> > ok 1 AO add: minimum size
> > ok 2 AO add: extended size
> > ok 3 AO add: null optval
> > ok 4 AO del: minimum size
> > ok 5 AO del: extended size
> > ok 6 AO del: null optval
> > ok 7 AO set info: minimum size
> > ok 8 AO set info: extended size
> > ok 9 AO info get: : extended size
> > ok 10 AO set info: null optval
> > ok 11 AO get info: minimum size
> > ok 12 AO get info: extended size
> > ok 13 AO get info: null optval
> > ok 14 AO get info: null optlen
> > ok 15 AO get keys: minimum size
> > ok 16 AO get keys: extended size
> > ok 17 AO get keys: null optval
> > ok 18 AO get keys: null optlen
> > ok 19 key add: too big keylen
> > ok 20 key add: using reserved padding
> > ok 21 key add: using reserved2 padding
> > ok 22 key add: wrong address family
> > ok 23 key add: port (unsupported)
> > ok 24 key add: no prefix, addr
> > ok 25 key add: no prefix, any addr
> > ok 26 key add: prefix, any addr
> > ok 27 key add: too big prefix
> > ok 28 key add: too short prefix
> > ok 29 key add: bad key flags
> > ok 30 key add: add current key on a listen socket
> > ok 31 key add: add rnext key on a listen socket
> > ok 32 key add: add current+rnext key on a listen socket
> > ok 33 key add: add key and set as current
> > ok 34 key add: add key and set as rnext
> > ok 35 key add: add key and set as current+rnext
> > ok 36 key add: ifindex without TCP_AO_KEYF_IFNINDEX
> > ok 37 key add: non-existent VRF
> > ok 38 optmem limit was hit on adding 69 key
> > ok 39 key add: maclen bigger than TCP hdr
> > ok 40 key add: bad algo
> > ok 41 key del: using reserved padding
> > ok 42 key del: using reserved2 padding
> > ok 43 key del: del and set current key on a listen socket
> > ok 44 key del: del and set rnext key on a listen socket
> > ok 45 key del: del and set current+rnext key on a listen socket
> > ok 46 key del: bad key flags
> > ok 47 key del: ifindex without TCP_AO_KEYF_IFNINDEX
> > ok 48 key del: non-existent VRF
> > ok 49 key del: set non-exising current key
> > ok 50 key del: set non-existing rnext key
> > ok 51 key del: set non-existing current+rnext key
> > ok 52 key del: set current key
> > ok 53 key del: set rnext key
> > ok 54 key del: set current+rnext key
> > ok 55 key del: set as current key to be removed
> > ok 56 key del: set as rnext key to be removed
> > ok 57 key del: set as current+rnext key to be removed
> > ok 58 key del: async on non-listen
> > ok 59 key del: non-existing sndid
> > ok 60 key del: non-existing rcvid
> > ok 61 key del: incorrect addr
> > ok 62 key del: correct key delete
> > ok 63 AO info set: set current key on a listen socket
> > ok 64 AO info set: set rnext key on a listen socket
> > ok 65 AO info set: set current+rnext key on a listen socket
> > ok 66 AO info set: using reserved padding
> > ok 67 AO info set: using reserved2 padding
> > ok 68 AO info set: accept_icmps
> > ok 69 AO info get: accept_icmps
> > ok 70 AO info set: ao required
> > ok 71 AO info get: ao required
> > ok 72 AO info set: ao required with MD5 key
> > ok 73 AO info set: set non-existing current key
> > ok 74 AO info set: set non-existing rnext key
> > ok 75 AO info set: set non-existing current+rnext key
> > ok 76 AO info set: set current key
> > ok 77 AO info get: set current key
> > ok 78 AO info set: set rnext key
> > ok 79 AO info get: set rnext key
> > ok 80 AO info set: set current+rnext key
> > ok 81 AO info get: set current+rnext key
> > ok 82 AO info set: set counters
> > ok 83 AO info get: set counters
> > ok 84 AO info set: no-op
> > ok 85 AO info get: no-op
> > ok 86 get keys: no ao_info
> > ok 87 get keys: proper tcp_ao_get_mkts()
> > ok 88 get keys: set out-only pkt_good counter
> > ok 89 get keys: set out-only pkt_bad counter
> > ok 90 get keys: bad keyflags
> > ok 91 get keys: ifindex without TCP_AO_KEYF_IFNINDEX
> > ok 92 get keys: using reserved field
> > ok 93 get keys: no prefix, addr
> > ok 94 get keys: no prefix, any addr
> > ok 95 get keys: prefix, any addr
> > ok 96 get keys: too big prefix
> > ok 97 get keys: too short prefix
> > ok 98 get keys: prefix + addr
> > ok 99 get keys: get_all + prefix
> > ok 100 get keys: get_all + addr
> > ok 101 get keys: get_all + sndid
> > ok 102 get keys: get_all + rcvid
> > ok 103 get keys: current + prefix
> > ok 104 get keys: current + addr
> > ok 105 get keys: current + sndid
> > ok 106 get keys: current + rcvid
> > ok 107 get keys: rnext + prefix
> > ok 108 get keys: rnext + addr
> > ok 109 get keys: rnext + sndid
> > ok 110 get keys: rnext + rcvid
> > ok 111 get keys: get_all + current
> > ok 112 get keys: get_all + rnext
> > ok 113 get keys: current + rnext
> > ok 114 key add: duplicate: full copy
> > ok 115 key add: duplicate: any addr key on the socket
> > ok 116 key add: duplicate: add any addr key
> > ok 117 key add: duplicate: add any addr for the same subnet
> > ok 118 key add: duplicate: full copy of a key
> > ok 119 key add: duplicate: RecvID differs
> > ok 120 key add: duplicate: SendID differs
> > # Totals: pass:120 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Tested-by: Hangbin Liu <liuhangbin@gmail.com>

