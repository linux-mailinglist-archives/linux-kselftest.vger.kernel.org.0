Return-Path: <linux-kselftest+bounces-3596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9833083CB46
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 19:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB8F28EB03
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 18:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094A61EF18;
	Thu, 25 Jan 2024 18:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IWZ77zs9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6309A1BDD3
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706207978; cv=none; b=ge0I8zloF6rBYlyie1Fqvb3sUfh3AL4SQrL0VivrdvQP7zXnxWU42XIPnBf+Mlod3yiW9YOdvhJFxKGfSMd8Mk3kEytWImwSFno4FSy6RqzVJi9eYtyoEhUDPIL9Ljxy8fFjdnCAaTRutLPaJaIjquZ6rrMYc0huE8r+GEs89DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706207978; c=relaxed/simple;
	bh=+qzr72NVpztS+VsR8Xuz4H4tBUfqz1ueMQ10iqiK5so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djISfo8ZTQz47FJZNVHhqA8gX0sahadNdeLAWO5xUBQTVjI3x2kaRq4B1z4XgipBa+jRU0V6jD1EKmLR/u36Zf8f67c9yF6dYpOc5s+HY0X1x1v7YfSFoOzww3FVri45c/dEmqpKwacxBRSr2yL1BS5no3SRjWzT6Tb1XeVrhRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IWZ77zs9; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55d1d32d781so1183a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 10:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706207975; x=1706812775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qzr72NVpztS+VsR8Xuz4H4tBUfqz1ueMQ10iqiK5so=;
        b=IWZ77zs9J/qoWM5QZKQB4pfqTSLSiqa9VJk/UmhF5N99G5vD/eiT8tCHlzT1efZKL4
         uvKO9ekrDpy8n5GCcfRKhDE9A87K7pMzlueZ+Kps5W5PJqUEPU2gwzRatU51zhMRgpEF
         VxCKhC7mrzmRcpZXfZyaxdNVVaU65IJic5gV9wGuXKLK2CRgtXe5dLgxPniUVk+Zdz2N
         lGvtpfaqJzFEPPE8U59i3T1Xv8galiP+rRbM01rL37XNwjZSKGLOMmOniUXxHI8thW5w
         XemnqDvhyyTI/BlH91JWBqqNugncsA9/RclTAyJTycWTHzjRm2BbGfSyzHCvcfo6L4hQ
         utcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706207975; x=1706812775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qzr72NVpztS+VsR8Xuz4H4tBUfqz1ueMQ10iqiK5so=;
        b=A54icgZKa302yi3V9hdJh/iULHNM7KjhBsPXILLGHvv3FpmCi33UbECWjD0AhY1TiI
         SVhv4bh7R5iIHwsma8aqR01NA8ZbAyg1gV7wo9vhU9jynQfAWCLAPvtdomuAzoL7ijRG
         BPFhsO4QEYCQL8CSP8Ca9kWNHW0z1v1BwOvEf5Lp3nnLO+YHeymuWz8nPF+Wb/sZFhTw
         pkiN8qXaFBH4p3WUrtmJncYLjAehY1oobZ+rOH6zRtIQbo5knzUpxDvaL2E9GgTr9Oqt
         uRRt2K/N6oaCpUuRgr52F6l8/Ru5hFKIE8MCGtq6jN7Z2c/E4+EEGQwXxoDhGEy13ATc
         URsw==
X-Gm-Message-State: AOJu0YwHYnEZE2ykg27ff/fcsnCP92g87DyDyJLpKxOAcRjYwEeK6z1X
	OYZxLQVr4s9kvau1cjsthEQgX1KwN88FTcat+mvLPKupx94JPh40rqvqph1lRf+iY6YVbqiZ3Dd
	zCZvYaruMEbMbmOodRKgftakrgYgto3RC5V2X
X-Google-Smtp-Source: AGHT+IE9TufAul9ACVnK63eRhhh6wJX0wYTC4/+m7Dv2ToPVvg2UJpJEaTqAJohERIMgBrXj9v5cbCdqcG0/q3edQzs=
X-Received: by 2002:a05:6402:a44:b0:55c:ebca:e69e with SMTP id
 bt4-20020a0564020a4400b0055cebcae69emr221508edb.5.1706207975328; Thu, 25 Jan
 2024 10:39:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bffec2beab3a5672dd13ecabe4fad81d2155b367.1706206101.git.pabeni@redhat.com>
In-Reply-To: <bffec2beab3a5672dd13ecabe4fad81d2155b367.1706206101.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Jan 2024 19:39:22 +0100
Message-ID: <CANn89iLjpY=YZRBQdJdqOTvS_HKdSXeuaOA1OY2k5VujATz3iQ@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: give more time for GRO aggregation
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 7:09=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> The gro.sh test-case relay on the gro_flush_timeout to ensure
> that all the segments belonging to any given batch are properly
> aggregated.
>
> The other end, the sender is a user-space program transmitting
> each packet with a separate write syscall. A busy host and/or
> stracing the sender program can make the relevant segments reach
> the GRO engine after the flush timeout triggers.
>
> Give the GRO flush timeout more slack, to avoid sporadic self-tests
> failures.
>
> Fixes: 9af771d2ec04 ("selftests/net: allow GRO coalesce test on veth")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
Tested-by: Eric Dumazet <edumazet@google.com>

