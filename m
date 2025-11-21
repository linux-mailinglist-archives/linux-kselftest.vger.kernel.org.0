Return-Path: <linux-kselftest+bounces-46291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5C6C7BEBA
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 00:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F9434E1E63
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 23:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F6230FF34;
	Fri, 21 Nov 2025 23:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gfy3Mwfe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DA627F16C
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763766613; cv=none; b=Cgih/CcSW7M5ErZs0IWjljJ+Qg2VJW0i02xni1cqKlO/2bBKio4ACaiEktsol6R4hqrt3bJzHeRf3XH+uFJ/vgncU4CLvXCLtBh/GC86xT2LF4cB/MYsREogv/9QXaFwwG4T1YgTzSFNK6hW1nE/fDRfPN2TISMA4FKmPuAJCYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763766613; c=relaxed/simple;
	bh=VdHSOcTtxGxUrX1sBmgMTtbKzqAZgA48oaPuJfmSDVo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WbVuzLAJMbl9kI2eeYhjtczraIbLL48d8JCNn0znbMiHilQqGHvlI5c1pYRf2n/1BcCmJ9Dxw0UfPR+SYXjuNg9288kT3uhWG73uOcX7BtDWEDp1SFueQplHIE39pz4skpDVXK09C9Htyz1acDzSyS6KQGgzNLilq/TJlJ8gg34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gfy3Mwfe; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7866aca9ff4so25585997b3.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 15:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763766605; x=1764371405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIhyiakhBQz7pP1gby69E80SsuyQpol3QkLbw3g393Q=;
        b=Gfy3MwfeBAYXXFSDqQBu+dxtBEWzVHhV0k67Me+B+IKfi+rm+AIm0fF2tWd0W9FSw5
         E5V1rel0jQnt9SLmNNetqtkoJf0MBJt7biWmIwdC+4QJ8nDyI17AozBJiDvDtnjM8yzG
         DslS4SMJkKhYDTT7oz3p6hLHoGrJZRZB0Tv8NBbLcz8YyPYQ3FuSIKvtFXjTaBVQ7ciW
         9zrNdBDsFFdDGc7kZxNsakPMklVf6HMDWWNlSYgZZ5BBocjzQVtQSEV/7gEqQUuS1Lb3
         Hod9sk6sRY3/SEvktzUI8Q8WCthkPBDH1gVJLAdXoxMVOzoCtBcTvIMNA6tF7Tj60g4I
         ofsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763766605; x=1764371405;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XIhyiakhBQz7pP1gby69E80SsuyQpol3QkLbw3g393Q=;
        b=WzJffE2u5QGHr3r0o7kHQS1pBUQSVzKJflq0dJKXkSdl11HcHxwPEZ/VXYRMjbjyo3
         N2v446fcXePrdVwWGMPX42IVyWjAvb4bERWCIBJhMM8y2Lzp9HK/Ell+/jGxZOQa9006
         x7Q0P4RtqMR6PCKpRsvyjstrnwkgVx3ZvX6GNFrhlzz+NzuqaexcgH1qnBqQsuPVt4HL
         NNBSmO99frcE8w3CsJOune/+n2mCOvyJza0DJnjx8wVHS4Yk2maHeBHE0gW8DdbEYnbZ
         OEKvfP1gJw0A3wZ0g0n+N2nHcGUH7ajXECoSx9+xQmWmPoHIj3NVPqgD5+87uvzurRFD
         W7EQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0uMKSzY1nGLpANnu+QC5Cvd9aneMkHVLAtTtT3fFfPHgSv6ZJKCUnF/iFzn1ajiAbJGd3tLTQN0cpM+i5QlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzA8eyBcLVHmi4ScCFsYgtV+TQlcCKdU4qHSdoRiLwP8qmVGo1
	rgBBp7if1oI4MLXcP9Sn306hkQP+XEpnQK8R/MkHhoMjmjFB7yuBGt3f
X-Gm-Gg: ASbGncvJ7AONNJdWkSsq17aeDkC1YUAAdXIeqMHhDYn4c0rqyM3G8EzH2rdmcRnv+g1
	oytuzB6VyS6azLXgfTDpawaOF3wvK6QxOyzzjDY253M/vwnX+o7+Lwn8WgP5GkhIoxH/bdBLdPd
	ZatAZHfPV36GW7+7pKmW1gG/jSxn1Bi9grZCA59+eNfhP+p6n/UVPn6dlotPWJ9CjUNS7yl7njT
	OS13GvedBf8tt8qIGJ+Dq0/7FyKKWoZKugWiL6XMKIgxMkToB0aXi+5FdT91sBNoyntGNUgOzwY
	oXsWVTTEdCMXZkiTxp2BLoGHxaXYgXT2OdzpTghcRaEuR08Nt3BUE3Ja6NO4gg6rYo9fJMuZx0d
	oXjxmS9i5VKoh6mtUWQSWhp2JcwOSj98jb7t8upmv1RgrB4yVm9eMrqWRrNTuW7m2fdu1zzMTos
	ta6z4OpBccuIvZYf6jy4CY2pajCF04u/MUvr214b8r6MojR+fEVzeEI7QBq11ddkd0kOM=
X-Google-Smtp-Source: AGHT+IHfCNm/h1SWg6slN1yIU0nIrFVDdi5F9NffXFDZ8GMcG484usVNe9HQYWOgCoGXaTA5uDjGxg==
X-Received: by 2002:a05:690c:b9e:b0:787:d2ee:e2d6 with SMTP id 00721157ae682-78a8b53930fmr29887407b3.34.1763766605302;
        Fri, 21 Nov 2025 15:10:05 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78a798804c4sm19847067b3.3.2025.11.21.15.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 15:10:04 -0800 (PST)
Date: Fri, 21 Nov 2025 18:10:02 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemb@google.com, 
 petrm@nvidia.com, 
 dw@davidwei.uk, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.2fe8d4c058a2d@gmail.com>
In-Reply-To: <20251121040259.3647749-1-kuba@kernel.org>
References: <20251121040259.3647749-1-kuba@kernel.org>
Subject: Re: [PATCH net-next 0/5] selftests: hw-net: toeplitz: read config
 from the NIC directly
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
> First patch here tries to auto-disable building the iouring sample.
> Our CI will still run the iouring test(s), of course, but it looks
> like the liburing updates aren't very quick in distroes and having
> to hack around it when developing unrelated tests is a bit annoying.
> 
> Remaining 4 patches iron out running the Toeplitz hash test against
> real NICs. I tested mlx5, bnxt and fbnic, they all pass now.
> I switched to using YNL directly in the C code, can't see a reason
> to get the info in Python and pass it to C via argv. The old code
> likely did this because it predates YNL.
> 
> Jakub Kicinski (5):
>   selftests: hw-net: auto-disable building the iouring C code
>   selftests: hw-net: toeplitz: make sure NICs have pure Toeplitz
>     configured
>   selftests: hw-net: toeplitz: read the RSS key directly from C
>   selftests: hw-net: toeplitz: read indirection table from the device
>   selftests: hw-net: toeplitz: give the test up to 4 seconds
> 
>  .../testing/selftests/drivers/net/hw/Makefile | 23 ++++++-
>  .../selftests/drivers/net/hw/toeplitz.c       | 65 ++++++++++++++++++-
>  .../selftests/drivers/net/hw/toeplitz.py      | 28 ++++----
>  3 files changed, 98 insertions(+), 18 deletions(-)

For the series:

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks for improving the test! Especially addressing the missing
indirection table.

