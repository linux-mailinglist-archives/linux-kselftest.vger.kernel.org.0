Return-Path: <linux-kselftest+bounces-40556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F181B3FD37
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 12:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B43206D7E
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 10:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3063E2F618A;
	Tue,  2 Sep 2025 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mMFwX3Wj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6FF2F548B
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810706; cv=none; b=fqhPpFUzdGrNA/aYXhbn5srleQADiU+BbRn2jw/Dp4IIR4DF84dW+4H7O0DZnh1uVtGYumnOSeBOlFH8gkNz+O+ztzlWy9hhE9hiz7iiujeG3bpzHS32/Xhluu0xblsogkwH6r3e8AQQ4BFHib8U1/F7IpTOXxCM7vICZ6sm/Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810706; c=relaxed/simple;
	bh=gfMxdtz4DcDDUc86U5Qw8d4o1LVk/9GYcubnw19a7Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZps2jTr0YDchRibY0hr9S/1hS5VvTj/mzCUN8kW+J7CDYD2pwVMz2UT4bjV3yNQGBA19oZevjM+7nDjvJFzUsxaMIvfr1reth8O4l6ALOG4FIg5zlTZz7VN3yc3nPpWy3sUnmguqvtSlCDAB7t16hIZd9427exLnzEg/gWZwH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mMFwX3Wj; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32326e67c95so6190904a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Sep 2025 03:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756810704; x=1757415504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfMxdtz4DcDDUc86U5Qw8d4o1LVk/9GYcubnw19a7Vo=;
        b=mMFwX3Wj5nuAkDJpkoo40mdQDRAA3EUCEa6bHkBR6aVdYFy3ZRUXmVETVTf0QZrDtk
         boc6fDVm+XlbgS/GoTXA/zHNsb02McskfEEwDzI7KTod+ih7aVlbOoRNMX9D7LSLUtfe
         6mvztAmHxgHArioLDpBGp+hFGVF7PewZBk5+ZmbzOws18ILDpL8rMKLWOkTtyWiBl6NR
         ZjumOnzD7cCAqWhsFhOAlhcmfSapafKSCYFtczMyfoqAmQYSCg2K7fmgNF+6eJSx2zAK
         a9osnR+RrJh0K/+rtemjM2Ep6y+zIOqu32Sj1DmJEcHIO9ywoGiY6uw4klN3M0u4I/S4
         i4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756810704; x=1757415504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfMxdtz4DcDDUc86U5Qw8d4o1LVk/9GYcubnw19a7Vo=;
        b=HwKHmZyyOfDLLYF4ht059zrHw3L6bpKo8+AhoPFIT9FacwKcz7mnA3ZGIvzXC6CxcW
         +6T2Zsp9q5NdgyQejvWEOWP7mzLLMjIrNoQ63+UcrDM2g5itSUf8tEk7PQXzsadDdI3Q
         xr+0sRdvh+tyU/zZzJjuEClsSuD28NxuVTTuk0x9C98gDy7itquj8GTbcPZYjNqK4skt
         7tCzuK3fIv5RiX4rXQ8o+oeIDPgQ6wpj2WQ8c/bTOql3nFrwtfUxo7YNlK9yySAm49qC
         Kzc6PVEsxSAQXCeC5OeUJBDSiydldXe/pdeX95MDA22W2EbrfbhPtuZaIVQRXvmQCA79
         Ne/g==
X-Forwarded-Encrypted: i=1; AJvYcCVVWAAnqqnlMlhfFF69AH3aiCluagdik3XKBD2chQNqyov3VAHp0IS8iqibY3oI4FJuO6waiPOVpJbc/ydelxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrWir6MMZpUgy5IKbmfZza6n3Vdcz6G1u1ttiPwvHjkgv9GgSE
	Kx3GhntonMcTc5okhKBZ13obmnvCk/3g2chjT7IpQ8ciDe391fWK/Wy5IzXC2A5CzjlyftuFIrL
	sXl3Py7EC19cP5ZybmcMZYdbhYrmC+raR1fappCty1w==
X-Gm-Gg: ASbGncv6zVLWb6jFfXzbUlBFujiC+sCd2lmQ3s/PyTTFdUZBPm0IfdV407iDltQ0xuB
	bqo1l9AYmfoRFBpt/oi+UrDw0xUssqigpgnbCTU9XlMxRfHItbqqbDO/AhWfM2mXigv3/r0iJeG
	33VkChNBXxb4rwHr87NA4G9+b10rwU02ApFsofdeTKZGKucTVyRdsnwFNZoHzB4+qb3J7vcxavi
	fRODJbMVtUPTXbSZ1TRzFDevMqqIL0t9aHqj1AF5zTdvsEKikxn15p7zdn8Gw==
X-Google-Smtp-Source: AGHT+IGJeRstlFmXn141hA2zh0v1vPIYwwf6A3NPxDQM214Prr0kW78Uc+Oyrqot7bU7+e2O3OZyDHf9cjoIhRs+pqU=
X-Received: by 2002:a17:90b:3c8a:b0:31e:ec58:62e2 with SMTP id
 98e67ed59e1d1-328156c9641mr16594645a91.19.1756810703718; Tue, 02 Sep 2025
 03:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYtktEOzRWohqWpsGegS2PAcYh7qrzAr=jWCxfUMEvVKfQ@mail.gmail.com>
 <hyqcffknmjwjuogoe4ynubs3adk47t2iw4urnpjscdgjjivqz7@b5ue6csrs2qt>
In-Reply-To: <hyqcffknmjwjuogoe4ynubs3adk47t2iw4urnpjscdgjjivqz7@b5ue6csrs2qt>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 2 Sep 2025 16:28:12 +0530
X-Gm-Features: Ac12FXyK-roq9UdfvDh1RySejuG-CgVtu9pGL08wENDIna7l8Tu1FBMlsn9aQjg
Message-ID: <CA+G9fYvA=945et87Q=_c6b-TWjSBxy4H-X9iNsb1_Pj9GCXUaw@mail.gmail.com>
Subject: Re: next-20250805: ampere: WARNING: kernel/cgroup/cpuset.c:1352 at remote_partition_disable
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Cgroups <cgroups@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, kamalesh.babulal@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Aug 2025 at 19:56, Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> Hi.
>
> On Thu, Aug 07, 2025 at 01:57:34PM +0530, Naresh Kamboju <naresh.kamboju@=
linaro.org> wrote:
> > Regressions noticed intermittently on AmpereOne while running selftest
> > cgroup testing
> > with Linux next-20250805 and earlier seen on next-20250722 tag also.
> >
> > Regression Analysis:
> > - New regression? Yes
> > - Reproducibility? Intermittent
> >
> > First seen on the next-20250722 and after next-20250805.
>
> Naresh, can you determine also the last good revision? That would be
> ideal to have some endpoints for bisection. (To look for any interacting
> changes that Waiman was getting at.)

Michal,
Since this was an intermittent issue, I do not have a good end point
of the bisection.

As I repeat,
First seen on the next-20250722 and after next-20250805
and not seen after this.

Reference:
- https://regressions.linaro.org/lkft/linux-next-master-ampere/next-2025080=
5/log-parser-test/exception-warning-kernelcgroupcpuset-at-remote_partition_=
disable/history/?page=3D1

- Naresh

>
> Thanks,
> Michal

