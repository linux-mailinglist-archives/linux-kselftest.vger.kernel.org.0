Return-Path: <linux-kselftest+bounces-24409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32107A0C340
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 22:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3C91698A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 21:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CA41B6CFF;
	Mon, 13 Jan 2025 21:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBegDzaj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF2724023A;
	Mon, 13 Jan 2025 21:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802395; cv=none; b=pOeIMhiiVHcb1KrBZn+4pIwENFOCpWR12Ayjrj6E6dOO90YM7hQoKkhTcw0XvhYDmu/2abZUE3vZY7BMC/heLTFHHLOs+6ftK17dWqpBpUhT/BpvsMpXhqQql7yIkuf9mQ27rwN7xMX0N5kmxGQyeHrctu/xqfSRalSsEXZDLgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802395; c=relaxed/simple;
	bh=1E6joxxMwdvaQ5wl/wjoDrLZBUgYA+oAW2RvWLS0UUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4ZfHWatRSjvSBaXVOQCP7abRlZYfpO80N5TRgNESIItR6Ymat93ilrfpf+UKPdE0NhSEMd/mR2BN1lKIKVg5oZGfywupGFsPMZGORR/fcnWi3X8dGZmnwsuvVRN+f5uCMVPTcG2VP5jH0S0gfq4lK8vXnt04RKocIbKW+jXm9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBegDzaj; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-303489e8775so41985001fa.3;
        Mon, 13 Jan 2025 13:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736802392; x=1737407192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1E6joxxMwdvaQ5wl/wjoDrLZBUgYA+oAW2RvWLS0UUQ=;
        b=mBegDzajtI5MbnM3emnXXCBNEBnYQHbv0yeIC/Ua4Bc/C0qI6beQph6Ns2SDjv9pes
         lI1VPumMA2LLtC40glQXHqB8r7J6s93uNumtTATyDgRQt14W8JNUrjbxeht9cbFVFvnt
         iaOq6Gcr5hx9aBcJU541yO300Iib/vxjKGF+6AgChzyZpDJ8pJgrYmOrMmmFDsiKyFIo
         iiWG+RNhwvpc3yHZ7vRic2Oj5uOKEE37IG0xzU63jkezGnvIw0EatLVoJd26EPxaZu7/
         SWSpkKqWRVn7Dq4u2MFfHXvPZ+f8PXURaEFUNpA7RrLOA2aVb7nG/ZR98zkLJDLQBV8M
         N2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736802392; x=1737407192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1E6joxxMwdvaQ5wl/wjoDrLZBUgYA+oAW2RvWLS0UUQ=;
        b=uSojKGJWwyn22l25GblfJsItva93V/PFS4CgEblKJgpoHB9//DXXLjY+boaxgaUUe+
         g4Naa0jfFVXl0Mi4OR6aO3LBjvBGgjg1GYv8EuO/UrTlUuJipYgVWoL1AhPy8CBCf4hh
         8ooC9f3h+Y5CScYWWEbyL6BujoHZyhoPZctOWR5pJ8ijaJKHICIc798dr0mzAgEfk4Na
         diDaVrZ1FqoPg2xEMb7TuedlbaRh0kUBl7/ehuCngfGBiAH35JQmN1U1SNtOXJq/JhkB
         J6bQhctTJGg3Ym1eGhVJROJy1WDYxEAVG70APX/vwarNx7FA2k/2tVGkklYr+PUeAnVw
         X9Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVlMUyrGBdo9ajxB/n/8jZaw6Ug9kdfLWvuo6A0dJ2XLlj2fIaD6iBt3Qo4kTUndro885xLMAdTO9qWvLg=@vger.kernel.org, AJvYcCWPEDMspWldqONwctC0SAYi5lw3yV+z0g2CawKgRBeECyEPAEeeuuV6PChavl7op6FLFjZy19vIKbJHurluwg0C@vger.kernel.org
X-Gm-Message-State: AOJu0YxAI1mdBr2BtwPoUkwvNSdQDK0QvN4+g8+JQJPkrinM3XgAXS17
	XqM+6rN2DkHOGCaS0TxI95qhbnqO2bJ3qoYg9/xNiIRgN99NS2okwn6SK59D+E+13/5lD7XIpP/
	mYsuDjVaOdxus3A4MYC+EOVvWNhh7kDfB1uc=
X-Gm-Gg: ASbGncunay/5hqSwmRX1Solt23jVCDvBtjt1IjUcHGqDoUztZ043QCnlA4KKb/Dim6M
	60AOdopufAGNEe2ZgOFKu1YORROub4TRlPh2EN2DxE8JMuM4kuNostg==
X-Google-Smtp-Source: AGHT+IGPnC7YhtVXJROyDwuHQp+eiBd9V8UpXkdY/tvXG/BosIsmzpRlZ2gcFXB1KdUXYuY3ffYOu4uvB4d6OdwML/0=
X-Received: by 2002:a2e:a98e:0:b0:302:1b18:2c06 with SMTP id
 38308e7fff4ca-305f458cd31mr73721961fa.17.1736802391961; Mon, 13 Jan 2025
 13:06:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102-kunit-qemu-accel-macos-v2-0-9d4579fddd20@gmail.com>
 <20241102-kunit-qemu-accel-macos-v2-1-9d4579fddd20@gmail.com>
 <CABVgOS==_+DDRYzto6Wn21kCBQCDhAHwhORU8f+AUQ2GDArXHg@mail.gmail.com> <CAJ-ks9kFEp=B9eq5JWkZNDGo4awPwu=rqGASOn9RL8EMtqBAZQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9kFEp=B9eq5JWkZNDGo4awPwu=rqGASOn9RL8EMtqBAZQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 13 Jan 2025 16:05:55 -0500
X-Gm-Features: AbW1kvaHuaeGGCg8GQ_xonBUyKPo-tS8PYPHar8Veh1-ssKbFTNH9tOZU4gS_kM
Message-ID: <CAJ-ks9=9+CzeODNP_opz73KbkO2sx5zQjgv7O+o5=jm+-ygJZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kunit: add fallback for os.sched_getaffinity
To: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Shuah Khan <skhan@linuxfoundation.org>

On Sat, Dec 7, 2024 at 1:52=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> Thanks David! While the next patch is still plausibly undergoing
> discussion, would it be possible to pick this one up? Without it
> kunit.py is not usable on macOS.

Shuah, could you pick this if you agree?

Cheers,
Tamir

