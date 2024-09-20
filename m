Return-Path: <linux-kselftest+bounces-18187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20AE97DA8A
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Sep 2024 00:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112A41C2106F
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 22:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EA118756D;
	Fri, 20 Sep 2024 22:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIHQ4v2E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4308187344;
	Fri, 20 Sep 2024 22:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726871096; cv=none; b=t/poC62A5Ib4kjRGoMbe+2rzf6i4QZbVTQHCoG8hf/4G85jUkY48Ekt5uBPKyGIafa21tfyp941d65/zmyf9Ir+D0f5aLGV8hawrmTv+OB/lRZhvE0gZXC9Y0FJdt1FgQ3qxTFe66yzh4ip5GPtVfSr79C5Kq86Rm/YY8gA9xuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726871096; c=relaxed/simple;
	bh=cKwPWEvwRv/CKPt6mfIhmX5V1j5scXEofT0XANrM3j8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=la6fTRl+RjpkfAe5qgEi3USlvykNjtAm1VVWfcflAC8joVzg30+2AFrDYXACri1iP6BTTj4Uqj81qdhDStdK+T1x76onBOXfObQB+b8X9cEXnMYN+FU4uwifR3q65yPZPKmElpt7mWUf2LiSuVM8GaH6Tq7mfITpjfgy4SThJaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIHQ4v2E; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-207115e3056so21283745ad.2;
        Fri, 20 Sep 2024 15:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726871094; x=1727475894; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cKwPWEvwRv/CKPt6mfIhmX5V1j5scXEofT0XANrM3j8=;
        b=eIHQ4v2EuJwxR1SSITSwSAAzQacZfQ3uGOpbvCQD65ord5Mqy/FClSE+uCI0I3Jfd6
         vbxZuf2yroCp/3DRCEvoIq0P25fBk0T1KyMr1+a7y1VveeQXx/WFqG9cvyS5ADOlVdN0
         0fualN2SwMMYBBYQo5nYkfu+yL5V8xeaqFcgHuPRSgQF3CUzftS/j3Oo0NV+TDU2yXDo
         VLgFcZoyJVpvuKyDMb6dFEjKQK47NGVe0qjTMpy8KEo1W4p+AY+C20IAxN508ZNYnRm3
         wRIlgffBX2FFRcrdt/6VBavUVUeSNzHF19Ymt6ja9yxLd6O7EjO/B0phHBGEBHPRcQdG
         iMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726871094; x=1727475894;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cKwPWEvwRv/CKPt6mfIhmX5V1j5scXEofT0XANrM3j8=;
        b=Z0HKnX+eVECtKygJKR9jxJrWwffPbSz7QXx5f/BipH03L8IMzXiWndXVLMrIz/0vr3
         dneZ6sY7BYKVpm+eGHVXXGguxfJik5WSRXlt+ye+B5bcjMDCd6SzXLVyoGSgVMO24HKM
         vc3h4BZW+sLAB5WgkH/kkTJi2v0FGWRhGO2wvrskJJUQElxXr+hRpz04BHkbBQot6SCu
         dmRAb1/57MO46/e8t3zSXpfs2QEHe9mStxooI9QH8Krm7Jq8zs6+bRyf92AEf/AGLpQt
         t0x9C7PyR5LJ1ngeImD/OvitbQ1I77OF2mIa8uGDHF+Qt7wludEvteMzBqJZott9G8UX
         1iaw==
X-Forwarded-Encrypted: i=1; AJvYcCVeEH/G17s1rCDx5jcTjogzIA5ps1BBCYFT5GhsRTq/JfXu547TWZ5EBIbDKDpMAf5y8hVEpRDiipiI1y8ZamdU@vger.kernel.org, AJvYcCWBUIslW+tBtHCLTqIhsYV7VipwkGZrVz7M7Hxr0uwYAXuNTMy60n19AAa6YOMdldwPF5I=@vger.kernel.org, AJvYcCWe1Rn/9ZlrpbmI9owecMbcm8cxa2qIG1tzbQOiYCYodg8Das2VJZ5vTaIwSopT6AweSHJymPrXeRKeMfu2@vger.kernel.org
X-Gm-Message-State: AOJu0YwwLnW+u5uIt1qR9ituYLVn920dpgPecd2O4IxWHmgqcHLZUvvq
	Rex1MzHza0nPuRNY4KBVnZkQ3X+OFylcRBg2SrGu/fjWiymhy1NR
X-Google-Smtp-Source: AGHT+IFdthcIXhwSG9BMFJ1QAsZxQc2rNuEsil+JHQfC8k3SHBWV5Tkim5QhQFzgMrk65eZtOfrT5g==
X-Received: by 2002:a17:903:230a:b0:202:4a35:a803 with SMTP id d9443c01a7336-208d98308bamr47445175ad.31.1726871093901;
        Fri, 20 Sep 2024 15:24:53 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da7c3sm99271745ad.8.2024.09.20.15.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 15:24:53 -0700 (PDT)
Message-ID: <8ea86aec1f8e0bc766389f3cbd47f206a9301a41.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: selftests: verifier: Add nullness
 elision tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, daniel@iogearbox.net, shuah@kernel.org, 
	andrii@kernel.org, ast@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com,  jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
Date: Fri, 20 Sep 2024 15:24:48 -0700
In-Reply-To: <1d8e11853a04ad6a6fdb2ba726090666d5bc6473.1726458273.git.dxu@dxuuu.xyz>
References: <cover.1726458273.git.dxu@dxuuu.xyz>
	 <1d8e11853a04ad6a6fdb2ba726090666d5bc6473.1726458273.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-09-15 at 21:45 -0600, Daniel Xu wrote:
> Test that nullness elision works for common use cases. For example, we
> want to check that both full and subreg stack slots are recognized. As
> well as when there's both const and non-const values of R2 leading up to
> a lookup. And obviously some bound checks.
>=20
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


