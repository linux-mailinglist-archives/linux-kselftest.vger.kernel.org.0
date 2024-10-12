Return-Path: <linux-kselftest+bounces-19585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1737A99AFC4
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 02:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467E21C21BA7
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 00:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AEE946C;
	Sat, 12 Oct 2024 00:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qEW6n8uY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2C99463
	for <linux-kselftest@vger.kernel.org>; Sat, 12 Oct 2024 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728694178; cv=none; b=sepA7WNpcKWLP3S2MI2B4tJdmMEcT4uFo3ag52wt/Yey0EwrWhqfBrjhWRtfCCpZHu2q1Y4bCfUTmzDlNxxpFd+OXKvE5bq2Tonh/5H5AWe+APox7m9NjFTzCXhw8L+0YvO23SOs2dFzQee5xBidB/zNDcET8aWkR50UxN7CAi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728694178; c=relaxed/simple;
	bh=v2JwS1UTnR/w9yH5prGw1z77Kz2sKJTsYb8NNgJgq4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSZK5UTLIwr8g+PogDhftOQGJWIUIKHKRjCdDhRmnqGeRACb7iRCHKN2KWn5/uW8ISAtU5wlEjLSemSY7br1XqpOn7RJrtDO+WGhCxRX+kYc2Onrrv18bh/IETzBd693wxMfLI7/fnwHaEVh26vRu3CBPdH/QTzUguSqjGqSWqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qEW6n8uY; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a99422c796eso415092466b.3
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 17:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728694176; x=1729298976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2JwS1UTnR/w9yH5prGw1z77Kz2sKJTsYb8NNgJgq4s=;
        b=qEW6n8uYfKLZTOQIn9t/t4zPve+R+CM0xrT77+fuMKuZ924MCnx6PC0L0fpuWMFu8M
         24BfaXRyrmDjG/GHqY4sxx4Al4QlNOqp2SclUAp2l1CTrWh/keTjSbjzZEaiyXrQ5a7k
         4zKwo6Av21f6KYhL20EM8LH/B5ILkZroqCz3AythlRmeqwIN7UYXG4ei7UATC3RG5OLR
         O++xxakK2qlYbZOqqOY+5bgMgcLLLDR9KBSw3VBpco90+OZnrKhBsN0xTM6Xi6EOYPjv
         8WdpuJApUY6+j3Vi1bsK34wlORV7Cd5UHd8UHwCbpOpfJayxXq06wlxJ7h6HoFdka+lT
         8AGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728694176; x=1729298976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2JwS1UTnR/w9yH5prGw1z77Kz2sKJTsYb8NNgJgq4s=;
        b=LZPlMEmpaepp+uoxK8O2No6e06M03zU7hP/CKGcTFbnGi+ALuYmRKn4YLvvYaweLym
         /9Bj9eVauevxx8Mcw4UXPFL6tUlEr0NvZIsS2eENlE4XnabqnebScf0o9rmYXcrqolKi
         OigCjeR51yd3jE7ypbLDJN4lnjCNa2QVK4MJg2z6htm83RLxkl+keIliMS+2t6oYCwWn
         MIkWXhErkQS/L1KDgrX+klHwvlttURZuFo5zoaHsTEnR/3QFMIMysOKi690m8ferwSV7
         tKP3O4cMMjhBe2j4veZ6DZBsSES2dPQpcGKlEbxKFPXORIZ6vmQ9U8co5pw36eqEAZPC
         5oKw==
X-Forwarded-Encrypted: i=1; AJvYcCXfQMn3RHRafvvYm3Ys78AcBCqSP/B7eBs6qsj6Fy0OmxxkmClO15Abicfv+LwrOr1nkotOeSYUGI/Qerz3bMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3tGcEGDwRX/TTaj5xo0UJuawCB4aU9HLrYS0tfock5ScXDGT8
	cza94bubfDbs0VzMmqIS/GFJgIYRY2KfDlUhpmlIII1nIRka3BtwKxxmbsYsUnN0kkn1QBvw5jP
	4Hab7xrHVpuVA5jSrbwNCNS6AHNy5aRtwPiWQKQJ3SbayDPrl140=
X-Google-Smtp-Source: AGHT+IGS8ZCj/bXavpD+pncaTo7L+3ClWpptP/uSRW/S6IMTfpj+XauibqknO437caqQwGLJ+1VE6nBvb9FyoCdaI1E=
X-Received: by 2002:a17:906:dc92:b0:a99:4f5f:c9aa with SMTP id
 a640c23a62f3a-a99b95bade3mr263119866b.50.1728694175635; Fri, 11 Oct 2024
 17:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011225236.27677-1-skhan@linuxfoundation.org>
In-Reply-To: <20241011225236.27677-1-skhan@linuxfoundation.org>
From: John Stultz <jstultz@google.com>
Date: Fri, 11 Oct 2024 17:49:24 -0700
Message-ID: <CANDhNCo5q05xUgdXQaDfxUGbiKaV2mXmfttA-=oVrftBF0PERA@mail.gmail.com>
Subject: Re: [PATCH] selftests:timers: remove local CLOCKID defines
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: tglx@linutronix.de, sboyd@kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 3:52=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> timers tests defines CLOCKIDs locally. Remove all local CLOCKIDs except
> CLOCK_HWSPECIFIC and use defines from time.h header file.
>
> CLOCK_HWSPECIFIC and CLOCK_SGI_CYCLE are the same and CLOCK_SGI_CYCLE
> is deprecated,
>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks for doing this cleanup!

Acked-by: John Stultz <jstultz@google.com>

