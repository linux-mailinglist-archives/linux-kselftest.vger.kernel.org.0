Return-Path: <linux-kselftest+bounces-45179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6A9C432FB
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 19:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03BBD188A721
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 18:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3812E264F9C;
	Sat,  8 Nov 2025 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="S9hLBHQN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD8F24C676
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Nov 2025 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762625631; cv=none; b=Mz6Oqol4JlMNmNqhOgscIFloS7KEuOnZcx/4v5T9eYC2OWiT/+mv8di2IqiT3z3XzlwLtFDjnBwFzfclpNP8OB0u3uLgUDvqEYd/Wf53M1suMqScIBulqlJh8ALYJFo+K0rKo+T6Q60xB3LbE82DlFrgYnkrlvmG70K7ovjpwkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762625631; c=relaxed/simple;
	bh=5sZTDtiz5vzvED+ms8GWFDwBiYLlGH1PPrJhewd5pPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/NTKIouopulKKWz02+VmAuVeB60ku2qnMxuv3oNrP0ghQcCJ2XGe4RHBoAUPP6MUAt53gJmM/a4tWJkaApVWS2N5p2yqAD4LjGB1LnAOTr643/rlWKeInQ7MLJpLqcSKXK8plRJccd/5n9yvPO75OPeXGwSrojhEze6gaeB0Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=S9hLBHQN; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso3150284a12.3
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Nov 2025 10:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762625628; x=1763230428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91HNoa+3K2lfUaegKxi2k7ABbReKqG9R1eEkUGhEO1o=;
        b=S9hLBHQNudBCwJ8l0eixW7cvJMhCJXZhH8tHBmxC3aE4DMLxqIf3/3O3v45hXib+Nk
         XF4ZsnsdhFEOuw/x+cZUN5/66OT1+sPX63xn6DN3MYZ7PZKZrAcMkrwWFybmyOVxb9gO
         K4FCd9p9n3Qg0wAhUK95Ttm1UjHHac3V/4PrZ/ymX71xsfjlpvH+K3lMQIYX9IS4J91Z
         L2Wz2yVL4eacIf5UUJLTci/B1O9muAqpHAJXSvbrg4dUbIZZTaVu7hP9FUwdKAqlRusq
         rUXkadwN/4Nn48b7K2NOZcunv5EUERS1FJFMZB4Z8RF1THcxwJhbGPleGdd20ktkMOO6
         DpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762625628; x=1763230428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=91HNoa+3K2lfUaegKxi2k7ABbReKqG9R1eEkUGhEO1o=;
        b=FxwmwzVzRifz++d209STDCr2mFcMe02Q45jZf0b0b0eeRS0ad+5dnHJSaNKAP0HhPk
         ROdQcr0/aQXQGDqPlUfOiHByhRfepXKHlRpEBnTZ0sUrkGj35iSpkOskY9K+zsZfe2Ff
         CYgjIEOx2+73w/yqFjkB/3b5zB96b8Fr7SW/zGOsuJWzDu7sF/8ONuxJNjwaOoy7Gn7a
         f1SDN+UxL8MtSV8drJazbukAr/t3SwUnPV2D/06ePqxbTg4Vh5HZoA4673B7Rtxg+Ehq
         riT8J57CMTomvrbp2xhe140EclS2LmqICcGVVT8VYAbOeGQuJ7TF2lIHKuN0CrmgA22e
         CqxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyzsoDJ5RbnqsG484EDBd4LGde7fo+4fjATvLJVHIXbPM28T7uoItFOVmwpVfz+us2Y10odyro5jVvMJCneKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLNCUBFroXSi3OvKjRKzlztzf1FW1ZwrD9tdlAAUJLiYQ1tFFm
	gUyKBdtNoDXGXEyII1nTtZxFy9bvMa9tAAKQEabzCNZrjpFXmYkjYItDL8RV5oKUMHuJ7nvcuQ/
	K/sZzJlc7k0ZsjbpdHaYPYaHqIeHDiyBOloo0f3Tg0w==
X-Gm-Gg: ASbGncseA9ZDwVKnOC5Wmd9seMjXaqKNChvDfSjJD/GcoXZGAD7ycO2VwFhHTmFZk+f
	a63uRBJBZ2qWe2Lx4tA4wpNBHYYlUT52QU7ujPB1LsYir+2xwVqCu1A2jKBGy2NlwIE4+MXhJOE
	xBYYmSLI/Z4GiSvJ+V4PK0KcxDK24S8iJJx3VAG2Um84GL/6W/YbVCseeVSGnhDF8ngTwyTuDEw
	SQok/3LWBlnM60HpmK3fgt0nYT5yvKMTZa71lm3Uofmm+8h95M88m5zgQsDoj/Ryik2OvD8iTYv
	EqSyZvvey7fc9wkCNw==
X-Google-Smtp-Source: AGHT+IHZVBu8RRU1a/y3GTlLoIpZY/OsExrxtTacQ9lQl4JW8XPO7BtLSQRu2xOrmaWsBZtcsYsebXOpI3F0m4hWrgg=
X-Received: by 2002:a05:6402:1462:b0:640:eea7:c950 with SMTP id
 4fb4d7f45d1cf-6415dc0e21dmr2539062a12.13.1762625627658; Sat, 08 Nov 2025
 10:13:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
 <20251101142325.1326536-2-pasha.tatashin@soleen.com> <d7651272-f979-4972-ae41-bab2faa8473a@linux.dev>
 <CA+CK2bDSvtuwrrXGOC07Rj42yGFHWR4Sse7Q5z1z8f1ZFHWQ2Q@mail.gmail.com>
 <CA+CK2bC_+repP-q183hjAuYYB2-Yx7fr_U3zr2cxysAWx5hzpg@mail.gmail.com> <029090cf-9a4d-4f79-b857-04c3ada83323@linux.dev>
In-Reply-To: <029090cf-9a4d-4f79-b857-04c3ada83323@linux.dev>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 8 Nov 2025 13:13:11 -0500
X-Gm-Features: AWmQ_bmVwf9f5yvXg9QPmQc_QNNOtI32RAdJxezzIrbImc5UQioX_PtDH5nvgb8
Message-ID: <CA+CK2bByYPJXSNOh6R3swqFrGsS02m3Dfh=ZU7YhNjNX6siyqg@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] kho: make debugfs interface optional
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org, 
	tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 6:36=E2=80=AFPM Yanjun.Zhu <yanjun.zhu@linux.dev> wr=
ote:
>
>
> On 11/7/25 4:02 AM, Pasha Tatashin wrote:
> > On Fri, Nov 7, 2025 at 7:00=E2=80=AFAM Pasha Tatashin <pasha.tatashin@s=
oleen.com> wrote:
> >>> Hi, Pasha
> >>>
> >>> In our previous discussion, we talked about counting the number of ti=
mes
> >>> the kernel is rebooted via kexec. At that time, you suggested adding =
a
> >>> variable in debugfs to keep track of this count.
> >>> However, since debugfs is now optional, where would be an appropriate
> >>> place to store this variable?
> >> It is an optional config and can still be enabled if the live update
> >> reboot number value needs to be accessed through debugfs. However,
> >> given that debugfs does not guarantee a stable interface, tooling
> >> should not be built to require these interfaces.
> >>
> >> In the WIP LUO [1] I have, I pr_info() the live update number during
> >> boot and also store it in the incoming LUO FDT tree, which can also be
> >> accessed through this optional debugfs interface.
> >>
> >> The pr_info message appears like this during boot:
> >> [    0.000000] luo: Retrieved live update data, liveupdate number: 17
> >>
> >> Pasha
> > Forgot to add link to WIP LUOv5:
> > [1] https://github.com/soleen/linux/tree/luo/v5rc04
>
>
> Thanks a lot. I=E2=80=99ve carefully read this commit:
> https://github.com/soleen/linux/commit/60205b9a95c319dc9965f119303a1d83f0=
ff08fa.
>
> To be honest, I=E2=80=99d like to run some tests with who/luo, including =
the
> selftest for kho/luo. Could you please share the steps with me?
>
> If the testing steps have already been documented somewhere, could you
> please share the link?

Currently the test performs in-kernel tests for FLB data, it creates a
number of FLB for every registered LUO file-handler, which at the
moment is only memfd.

It works together with any of the kexec based live update tests. In
v5, I introduce two tests:
luo_kexec_simple
luo_multi_session

For example, with luo_multi_session:
# ./luo_multi_session
# [STAGE 1] Starting pre-kexec setup for multi-session test...
# [STAGE 1] Creating state file for next stage (2)...
# [STAGE 1] Creating empty sessions 'multi-test-empty-1' and
'multi-test-empty-2'...
# [STAGE 1] Creating session 'multi-test-files-1' with one memfd...
# [STAGE 1] Creating session 'multi-test-files-2' with two memfds...
# [STAGE 1] Executing kexec...

... reboot ...
After reboot:

$ ./luo_multi_session
# [STAGE 2] Starting post-kexec verification...
# [STAGE 2] Retrieving all sessions...
# [STAGE 2] Verifying contents of session 'multi-test-files-1'...
# [STAGE 2] Verifying contents of session 'multi-test-files-2'...
# [STAGE 2] Test data verified successfully.
# [STAGE 2] Finalizing all test sessions...
# [STAGE 2] Finalizing state session...
#
--- MULTI-SESSION KEXEC TEST PASSED ---

Dmesg data, shows that in-kernel live update test was also successful:

[    0.000000] luo: Retrieved live update data, liveupdate number: 1
[    0.034513] liveupdate test: test-flb-v0: found flb data from the
previous boot
[    0.034517] liveupdate test: test-flb-v1: found flb data from the
previous boot
[    0.034518] liveupdate test: test-flb-v2: found flb data from the
previous boot
[    0.676891] liveupdate test: Registered 3 FLBs with file handler: [memfd=
-v1]

Pasha

> Best Regards,
>
> Yanjun.Zhu
>

