Return-Path: <linux-kselftest+bounces-26338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3573A304E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 08:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A6218855B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 07:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5031EE006;
	Tue, 11 Feb 2025 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXVdZJNb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD571E9B39;
	Tue, 11 Feb 2025 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260370; cv=none; b=GuLyC2JrteW+dHyVfwoF87ZEuzrQMnnY/HktkrW9O5UKnDcxjhOc0en2nsbMMKuzU1ox856DVJZQK5a1AJUqi9TJSEVpXPUzwA8W1AZve/bPL4rDlmpnv5aesTXyGtdZCTrE+MJpm+o7cOGSJecVekqxh733g/1fd3TmKL/7QQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260370; c=relaxed/simple;
	bh=2FiwY+x4GGYE7ozcjCNXBgyPvVhL9yzMg38BGRbpZDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQWnE7IqOHh6aF0iPNLnHXvXi24TIyy6yLT1ZosdYiXPQRxdhJuOmlFccTokNw0uUWp1Pcdp5q52j3wFDSSylLyLpUBohw2DaTDJCxhVAo0Sp2ECaF14SO2/nP07Y24iEG8pQtb8JQJ3ThtkLDTdB6Kr2th64JSuwxY+iLcAlsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXVdZJNb; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d03d2bd7d2so53399075ab.0;
        Mon, 10 Feb 2025 23:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739260368; x=1739865168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyEJstYWIX8JPmw+qk0ND4qW6t7HyV1qVikO+FNreek=;
        b=ZXVdZJNbjhXCWmvf3qDRzHigH4Z8B3bBCu2q+AjrH0XcYujUzp+2vJ2e92zmm2jRtg
         kygnxuahP9Ivm3wB/QIhkjtf4yiDwNyyA1CllKyZsWIbVvO/Hw/L/Kaa0FnbETBZ8yxk
         Mx9a+kA/AZnpnvYQGg3dSXg5xPwdDpzXGFmpAsIky06L5NRPWsUkgKJCsEMJ+X8SuFPM
         KpcnA4xY2P3Jya5LEX271mOL0lQofZIhCIwPFTgECv84ieedDirpzeJqqNstev/F55Q/
         wNeKi9DxOB2wzDJfPNKHzAnyShZsp27vml3PQp3TOTAHysWVUw+13ypYM/EaGOyVOccX
         pkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739260368; x=1739865168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyEJstYWIX8JPmw+qk0ND4qW6t7HyV1qVikO+FNreek=;
        b=HggJwSWDt/G1sX/6WPxbcR4EHti1+f4JtcUuNfq5+/lVfKFy9QlikJVWbKnGMBHJdp
         gW4Cc4EtrxyIrfJJ4Ea96fCrNINuoYgfT2PCOpKmJRkX4xWN1SZ8AlZ7r3pvuE4ixjW+
         7hYNKXc6kI9i/6o1RI/+ccXiKkTRo6Xv8EJNbuT0sYjPm47gxbjcyYuDu9sUu+TA89Sz
         odMtnKrLBTe3hXWcLlZQrLZAcJsRfgx2oUZd1VsCaP9UsbDDaCkGj/NiPHhzAX+zVBoU
         l9Q7+snPQdfEbkLgdkzHXOBUT6NpkWd3lB/Kt6h7QTwe471atqm5QNgAHRRoAFlmzYVH
         bfzg==
X-Forwarded-Encrypted: i=1; AJvYcCUukqdUDK4QaWxktbev2Oa1EClci3DAealOul2WKnhpk2/e2TE014whZq+i4MJWRZ2GsmBSR9q9BmiphauqqcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzC1ysIk/7A/iXVCsWegVuq98Ac+EEff17wf3Zu4gGk47KVV+A
	/JEO+MM2YvxBCsOmvpujl0PNVs9zPvNezatGbrndCSu7XYPmubjicYVdsvChwj2N4xORskEkaE+
	xa884syaK2ZXXlYG1GhEoj7q9EKs=
X-Gm-Gg: ASbGncsodiJpGPSM95CTMM5npdYi1rKU5NXRQgGM9SYTjqshdmv3up2lZJ8LjkLOcX8
	jePqc84UHB/nJjOeiiIBoO1aX1aUczcHWcybV1qyOK/63VJe3JujH/IGrKjDGNOqAWfG04WhL
X-Google-Smtp-Source: AGHT+IEfaGfrD1rUjB9s+MqSahYI/ZJk/Sk5Hm66Oc8ZSWk7aGbN+bgGcczuBQHroZqGZAL3JDRgpYDJ/PhEOSURd8E=
X-Received: by 2002:a05:6e02:3421:b0:3d0:3851:c3cc with SMTP id
 e9e14a558f8ab-3d13df2249bmr147795145ab.16.1739260368306; Mon, 10 Feb 2025
 23:52:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204023946.16031-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250204023946.16031-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 11 Feb 2025 15:52:10 +0800
X-Gm-Features: AWEUYZkRY_S1KhVsCI89OwVfX8y4TlmjzzQ5bw4gokp7zFxwq6X8HHUP_MaQ7jc
Message-ID: <CAL+tcoAAm_7sxhF7_-GBHmeF7jMtRjMGYqNuz_H4xH9mz4xLjw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/2] selftests: fix two small compilation errors
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	mykolal@fb.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maintainers from bpf,

On Tue, Feb 4, 2025 at 10:39=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Fix them separately in each patch.

I'd like to know if it's possible to merge the series because it does
harm to some old distro with only updating the kernel?

Thanks,
Jason

>
> Jason Xing (2):
>   bpf: changes_pkt_data: correct the 'main' error
>   bpf: sockopt_sk: fix 'undeclared' definition error
>
>  .../selftests/bpf/prog_tests/changes_pkt_data.c      | 12 ++++++------
>  tools/testing/selftests/bpf/prog_tests/sockopt_sk.c  |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> --
> 2.43.5
>

