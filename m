Return-Path: <linux-kselftest+bounces-4022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5938474A4
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 17:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42D99B28531
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 16:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1061474CB;
	Fri,  2 Feb 2024 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yqe8jl7E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2571468FF;
	Fri,  2 Feb 2024 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891124; cv=none; b=j5W7SvUi479Xt4MM92Hkg5aU+oLmMRxSG61FGRi4O3dR8rLUV1j0A2yhDtzvJoSJFa1lLgK/+uavEr14RuBEOLXug6xPtY+Jy5TeWdUU/72wV/teF2GPyD1dTYGKlUK7ym0QaCsEbPFH4j4gRbitnSCsSYz+tC2LZDS7lcz3Qj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891124; c=relaxed/simple;
	bh=5k8mKkVdz5DWjDbMmA5DXVLJ+PTi+mk9o+WFQB+6iB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6VGVmxdB/TOC8M/dzlKyn7n+UzDxQfo5L2JxR355yYs+bouWCrLPQRRRIRtXH7DHSy/BXK8EQR4mdFr/KM1GNV7D+Tae7TFf7FtK/fHdKRo0TC9FLWlmQhh/3haL/3m/HwuJeDROHshrysxlxBB/N6lVJtKarfoK8yXMwCD/gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yqe8jl7E; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7ba9f1cfe94so102439739f.1;
        Fri, 02 Feb 2024 08:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706891122; x=1707495922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5k8mKkVdz5DWjDbMmA5DXVLJ+PTi+mk9o+WFQB+6iB8=;
        b=Yqe8jl7EUQwTGVqNY1Y30jS7YpVyAZUjPztIoE5/fUn9Fmk7gZ37WPC9XZD98YL5wL
         ygSo5IuY5SnVmttl3+hnuF/7WZShqK3PQWO6kt/kjhD8IdLMt9NgzplKPb41IOP8atdn
         LQ7T9rOTfMS6xJsSsivQk/usGRE9P9pd4nKiNZx9vuApSqDONI8kmcaPpcc9t5o55NyB
         4lGSj9KjGNoSdpayvGI7XBo8jjS5kfyUMP+4IR3r48cZsAQlIIPwIcwBr7WKuOPwOQWX
         Tk6zbDJ3z0Mcgd4EpE7e8Qixdzxi00wRZXPQrwyHZ9oLeMVEPa6664C1xiqmwhrbxgfF
         7WEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891122; x=1707495922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5k8mKkVdz5DWjDbMmA5DXVLJ+PTi+mk9o+WFQB+6iB8=;
        b=DE/jUwgv0W3lfH096jcyOFMdlGMLRQehIenRT9eQo+PAsHitGVJOHZllPNiunXEwJC
         e/ORZ4aN5jwodg/YzR3viXLKta1/MLXpnTOdgpyPUeTuzyT+H0kcjDraEsUZowfRoQOP
         FB2W+zU6HJcB7Rs0MbiDKn8JN/X3Ce4POpAkiEgMYxvfMHoURHlqSQNlRWfn+tGMuot1
         XelUV6TK3rhP6RcNAbW6m/E90nKEQ4d8Vus4Jl6aD+E+kXEGtNL76mfcd3UE9yhQucj+
         LYCCgVYRvWiLdOdiYbgimjwf8s3q4WGaQ9zCu7lqoCsVMQ2FZhAnrcZffJcLi6HNls74
         hgCw==
X-Gm-Message-State: AOJu0YywPw+OKNnnBon9amRyC/OOt/VKz0HaPcWvRSCuhzSdrs3A5m6W
	e0NRKhWWPcrbc2LeA0KdkWuPHh54C8W04CYWnyuIReeFTdvfZNgVPNePByzX+97ysIo2Qgj7Pgk
	eWnI71kci2Himgtg++4AMBO8KUW8=
X-Google-Smtp-Source: AGHT+IGODY0ZLWoVirFF+z0KGkDtRIBITBqgb9qbMw2pbSlc+t5obb4QxW83V0s+9ue5Wua2TMbj3bITgfy8p5FtWA8=
X-Received: by 2002:a05:6e02:1a2f:b0:363:9f5e:c449 with SMTP id
 g15-20020a056e021a2f00b003639f5ec449mr2292546ile.1.1706891122103; Fri, 02 Feb
 2024 08:25:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f011968fee563eeaaa82bf94e760e9f612eee356.1706889875.git.pabeni@redhat.com>
In-Reply-To: <f011968fee563eeaaa82bf94e760e9f612eee356.1706889875.git.pabeni@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 2 Feb 2024 11:25:11 -0500
Message-ID: <CADvbK_cWU8-Ydo6rcOPm9MOJVhTPYyYSGX3ZTNUvJVR9ZkstKQ@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: let big_tcp test cope with slow env
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 11:07=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> In very slow environments, most big TCP cases including
> segmentation and reassembly of big TCP packets have a good
> chance to fail: by default the TCP client uses write size
> well below 64K. If the host is low enough autocorking is
> unable to build real big TCP packets.
>
> Address the issue using much larger write operations.
>
> Note that is hard to observe the issue without an extremely
> slow and/or overloaded environment; reduce the TCP transfer
> time to allow for much easier/faster reproducibility.
>
> Fixes: 6bb382bcf742 ("selftests: add a selftest for big tcp")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Xin Long <lucien.xin@gmail.com>

