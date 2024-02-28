Return-Path: <linux-kselftest+bounces-5518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62CD86AA30
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 09:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6818EB22BE6
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 08:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C56025778;
	Wed, 28 Feb 2024 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT+gq4Wx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443CE2263A;
	Wed, 28 Feb 2024 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109449; cv=none; b=eYQW/ceA9oo8Ls1FxPRkinG2AVQWexdt4ZV7l9q7ZEKUUh1tY2dU3YJMXAp7ekC1u2/ubXN+OJuQQBJ+EGpIgjvAhEBC2+nmS5ERidJiQZt3TgwBTAJnwkbvhComIrqymYQEptUj5MDE+sZ1uzSju1CR5br7SHyjCwYhoR22XB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109449; c=relaxed/simple;
	bh=DKje+K8ippA0ZYfJntuI0R7Vbe0XtsQE0B+iMwY1OGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bv1HA0dY2WLR1cpwljNiGGuE5Gam/Qm3ityPgyGDSbrEACYJQ5mFcZDiwHEZEL0WnhU+A2gCozTa7oV82sUeakXCtN07cD/3khLUdDiYT63GKrVICfXoPfWuMJ0XnQcFTsg5qrE1xlUX1ljmJUcpZglFFky3tGSJ4UtqYsMPJaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cT+gq4Wx; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-565ef8af2f5so3812387a12.3;
        Wed, 28 Feb 2024 00:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709109446; x=1709714246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/Z7R/WO7svFjmJZnbr0mJ+YCtxsZi714lKpVsB3CcM=;
        b=cT+gq4Wxrhitfs4uyp99unDIdut0Xy3jOQHB7/TClgiuMMmjgh6gg0rKjhzyUxknMd
         pT/tWBCgdDIt9Swx9H4bzJUHuJ41ITArskhE3nytckStSOgREoijD5CZShl2bhxLVNsP
         twLK36MHMGncFLnAJIsVSq5S6U0hSHzBBjW/4t0iFa2iVQjNdq/HDNJfDDaNPjqCGvtn
         8b+NFYDfaY4qilH/+2lgnHWDIMWLSu9Tb1nRMvtYNKsHMhuv4bbSkM0BSCCoGpzOcrvk
         sQGe0vNjhW/QFxeL/9llVkYlY0Jzygu9xGoahA22O8mJuPRkEbWyYjxgBy0OvUcMXGdW
         t4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709109446; x=1709714246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/Z7R/WO7svFjmJZnbr0mJ+YCtxsZi714lKpVsB3CcM=;
        b=qwhHN5e8D0h1eBy4CFIvwMUS1MoVsgkalDgYKLtjyr+lpbIfIUlEA0+0Kwkdwy2XVR
         ObxDIcIBKnCVpvOghsCk+oprD1tY6weioTZc/y1AzLHTo9XD6KdcjTrecNoZQyc8yL15
         zddkYWGzaZVW8g5uwE+PWX66XiLxPqo+uvU73pTc4YRAGdn61gS3vBu+55dNMdU0BhsX
         uKT7CqTvw4bc2WW25BWxzFhp3DpY66jvmq5DlajVgCP+siDflq1VGU4wHRtDjddrB17Y
         pMs3tLMoKq3jh5ow8MkdKDb/Yyyo/fcrU92Dq8RIq1YVC0ec2Rp7/nhvoFgIe7HH9gx5
         5faw==
X-Forwarded-Encrypted: i=1; AJvYcCUaas0AV79S6CbUQR2GC84WUcasrfhHGRogIf2Ee5zaoUKzcJTYGsxt6FckD27zjJVWxb84HrQlW6rwFtcs/6JtmtRamGzXlSQuSpH0OdEBPOIQDs1YMRhm+rSLbrjoci7bZWZOi+ZmskJ3YVZLqHu7WNbkNnmbVWB2JF42f07O2mxdBqfs
X-Gm-Message-State: AOJu0YwAB4nZUJBaJVrfYarxL4zXqN4ZwZN1mHd4whpVtUerAKGJcNbS
	8h1BCH5YpLl2tUoqqqY9ISz38x1mBzlYjf25hcpxjWMUXhxBRdUHitDjQzNMR2XT0uE8CxUjeQT
	fOS6xChobpo/tTqVttC5866nLs5LiHHWA
X-Google-Smtp-Source: AGHT+IFNvSAXabzN2nbl2W0qjTBC+1N7DmsqETrbocOgun/hMCcIBi55sNngK16abSZgxl0HOTI2tULKXE9JpWseKGw=
X-Received: by 2002:a05:6402:180a:b0:566:4047:7106 with SMTP id
 g10-20020a056402180a00b0056640477106mr2727639edy.25.1709109446418; Wed, 28
 Feb 2024 00:37:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227175513.8703-1-pvkumar5749404@gmail.com> <Zd7lqr8Cz4XrNoI8@nanopsycho>
In-Reply-To: <Zd7lqr8Cz4XrNoI8@nanopsycho>
From: prabhav kumar <pvkumar5749404@gmail.com>
Date: Wed, 28 Feb 2024 14:07:12 +0530
Message-ID: <CAH8oh8U21HASqhQAUAR08V9322NpHVDZOrkEWibzNEeWM4N6vw@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: net: Correctcouple of spelling mistakes
To: Jiri Pirko <jiri@resnulli.us>
Cc: shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, petrm@nvidia.com, idosch@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 1:20=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Please fix the patch subject to include appropriate prefixes and
> rephrase a bit like this:
>
> Subject: [PATCH net-next] selftests: net: Correct couple of spelling mist=
akes
>
> pw-bot: cr
>
>
> Tue, Feb 27, 2024 at 06:55:13PM CET, pvkumar5749404@gmail.com wrote:
> >Changes :
> >       - "excercise" is corrected to "exercise" in drivers/net/mlxsw/spe=
ctrum-2/tc_flower.sh
> >       - "mutliple" is corrected to "multiple" in drivers/net/netdevsim/=
ethtool-fec.sh
> >
> >Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
> >---
> > .../testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh | 2 +-
> > tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh    | 2 +-
> > 2 files changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flo=
wer.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
> >index 616d3581419c..31252bc8775e 100755
> >--- a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
> >+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
> >@@ -869,7 +869,7 @@ bloom_simple_test()
> > bloom_complex_test()
> > {
> >       # Bloom filter index computation is affected from region ID, eRP
> >-      # ID and from the region key size. In order to excercise those pa=
rts
> >+      # ID and from the region key size. In order to exercise those par=
ts
> >       # of the Bloom filter code, use a series of regions, each with a
> >       # different key size and send packet that should hit all of them.
> >       local index
> >diff --git a/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.s=
h b/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh
> >index 7d7829f57550..6c52ce1b0450 100755
> >--- a/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh
> >+++ b/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh
> >@@ -49,7 +49,7 @@ for o in llrs rs; do
> > Active FEC encoding: ${o^^}"
> > done
> >
> >-# Test mutliple bits
> >+# Test multiple bits
> > $ETHTOOL --set-fec $NSIM_NETDEV encoding rs llrs
> > check $?
> > s=3D$($ETHTOOL --show-fec $NSIM_NETDEV | tail -2)
> >--
> >2.34.1
> >
> >

