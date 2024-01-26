Return-Path: <linux-kselftest+bounces-3631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC6483DF0F
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 17:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417441C23928
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 16:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B921DA32;
	Fri, 26 Jan 2024 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUT6PgVC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1021DA22;
	Fri, 26 Jan 2024 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287411; cv=none; b=O9Lj2oWq/8j6xK2CxrPyWfWHxu9mH0PUdfunohXKw4K3w8cAXJdKa2HiL/KPuftMRPktPud/mT3HwGZGcsCnKV01YGw+DT3ZTCRucyhqUWKBXM1U4VG6PI3pzzGt6iO8iE2YCWKo8pNJ/i3TigZcuT2DysZbxtiz5RnbLNHbBgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287411; c=relaxed/simple;
	bh=cEO41twJm//21sagSm9cB4brBkFrMocXWpD2Ra1FT0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ImUdQqSoCi7eUl7QuvRQHx7tk8Pae+uwR/2x7/9ari7XPIW47raaMMNaws7k3ScMSZpM+akGxNNo88vDH90w+iCwF5Qjr/0NdkiSjMsaPPdrYBt5dGnj5tc/M+dE64F3436OFJo6uDRpPJm8zAuys1lUCo2KEuEi286LsMdSyE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUT6PgVC; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc24ead4428so418552276.1;
        Fri, 26 Jan 2024 08:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706287409; x=1706892209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/IyLD9a01+rfYxTXTwEcJ4aZx88KemGpDUHBOx8Yi8=;
        b=fUT6PgVCKJtVp/I1oUd5raMbRhLU9f0NjW5uqAX4Dw5QIH3Do2z55lYLecoqi2KzsL
         X5QPy0Hoas/XBCuIOXmgB2Ez1Ud03n5WuE8ZVSBkRbovPcUxLliCEmZQlDU6cG04owpj
         w4jctekMADKhGVshYU+7FVkiYZZdoQXkrs2kQi3/YiR+MEXGJabHScc2nsGDyUgrE0wC
         txa/OViHRl8y4W6/VSkLyKWOt+LYL1A2EBI4Staw/eGAjDLRWC8ZF2NjnwMZw2KmjC2K
         rmMCTNe0YuZv2mq7bdrCOpYbx9e0djsxEuD5MaiSSGW/QLrjoO6gp0OHVms+SrokRXJ6
         T2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706287409; x=1706892209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/IyLD9a01+rfYxTXTwEcJ4aZx88KemGpDUHBOx8Yi8=;
        b=SkM3SzYUkh6JYNp5ZV9XKWkWWUbYeDvau/B/SNe1XIT8v9epQNmM72i/CzEqplv8aR
         81Vpras0GH61f4JhlXxDsmtaAQ52yFwUi5yTbYNCAG4u2dcmEmbNAM/B5YrIlbWiZZ3U
         ubuOeW0lywSr4XYjNEMhsyhOIx3fqY4ZuB1zIb8E+RNVQ1v8zZtdfVOYRQ0Ylh4jll0Z
         E8w1NfC68F+Xs6CnNLJZINaBqgd4tyn+kPexNDTV5wTNsgh8pi77a3S3UOlzn2TK69E3
         5om4yr8egp4Ia1f71co28T3hQaS+w9rqNU5UjHKDFXMUEu2cBctYUf519rESjMTHdgkp
         3GtQ==
X-Gm-Message-State: AOJu0YwTkLdC8se5XYCL4uwCLQGksOh36/0UkS7sgoBRovCSmrtqeE7S
	55683d26oM9BChUTcDFE+ewWDnVus+hsPCDUrs3XkxTGA/mSq6yE4YNCl+3HuoxicejJF/+A/uO
	H5MlaVJGUHXPclUBaSyiy/X3pfs2zr9NHlij46Q==
X-Google-Smtp-Source: AGHT+IFuUx5RRLX37uksYAMBVchsLD1bTOxNVRHSPfoNOSy1ZsSStsQJ6vkzesCWh4mPJv/w/thwZYSLb/ME1zeANdM=
X-Received: by 2002:a25:ab04:0:b0:dc2:4053:b813 with SMTP id
 u4-20020a25ab04000000b00dc24053b813mr148087ybi.42.1706287409382; Fri, 26 Jan
 2024 08:43:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <21630ecea872fea13f071342ac64ef52a991a9b5.1706282943.git.pabeni@redhat.com>
In-Reply-To: <21630ecea872fea13f071342ac64ef52a991a9b5.1706282943.git.pabeni@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 26 Jan 2024 11:43:18 -0500
Message-ID: <CADvbK_fzaAKNNyK5BBQfr+OwdDhSxGVMAcUdhhAj67C7ZErOrQ@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: add missing config for big tcp tests
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Florian Westphal <fw@strlen.de>, Aaron Conole <aconole@redhat.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 10:32=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> The big_tcp test-case requires a few kernel knobs currently
> not specified in the net selftests config, causing the
> following failure:
>
>   # selftests: net: big_tcp.sh
>   # Error: Failed to load TC action module.
>   # We have an error talking to the kernel
> ...
>   # Testing for BIG TCP:
>   # CLI GSO | GW GRO | GW GSO | SER GRO
>   # ./big_tcp.sh: line 107: test: !=3D: unary operator expected
> ...
>   # on        on       on       on      : [FAIL_on_link1]
>
> Add the missing configs
>
> Fixes: 6bb382bcf742 ("selftests: add a selftest for big tcp")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Acked-by: Xin Long <lucien.xin@gmail.com>

