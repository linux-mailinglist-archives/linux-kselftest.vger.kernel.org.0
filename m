Return-Path: <linux-kselftest+bounces-4170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAFF84AB98
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 02:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2CE285AD3
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 01:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94209EDE;
	Tue,  6 Feb 2024 01:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTyNYxnA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7E76FD7;
	Tue,  6 Feb 2024 01:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707183153; cv=none; b=J9r/uyuKb4goshrEnWjpQH+W5NFh3DZUe5WsZOCkHCtWwOasjdvyzkz0YpqgrIUt0FqDJbglYVxxtG7iG/rAmM3jzsbYG7lCMWNQ03p3nA3gWTQhdF+0+3mmL3YA5MsXakJ+etYMDa7JQDOkL0Kkpdq1hhB0eOBDDtO1eHUMCK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707183153; c=relaxed/simple;
	bh=rVAbmPsAGtvO+Qd+Hb1hgCb6dIT6VZnul4EDRYLBi3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSH+uHPlaCsHrPrkpk8CAKxkyYqzya8STAck5LxgjoTStchlTFCMIFpW19txQ4jh6IvefhYEPaL4MqpHMeEvyy7J7Did464+53t+lXAeglN6e7yiekLux9tVRcu+ScNiqiFz3Mrp7feCcxSENUUdXkktwBnRJaFnxPDw8/uQB74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTyNYxnA; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51117bfd452so8537073e87.3;
        Mon, 05 Feb 2024 17:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707183150; x=1707787950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QApOFbEPm/JI1t7SVH7QEk9OREXHhc6+siBSRqc1pgw=;
        b=CTyNYxnAIHsFXvHZt5a29ozgN5S8mTqntvSbdG3GzjyEn5FFfa9ZMEgzZHcUX+Xqdj
         xBEY/askJRPnoh0TFupSiul0yI2QAgsNYDiiv4jr5pWeUOoe7gI3YxVQKiDtVS36lRtA
         Z4UE1unTfeQKxa8KxjKVknSbfUZPx86Al2Av/Vraj9MsMz/CfPG2NDB1g2p5YxBoo2Oi
         Dek7XdFcEFZmWqhuFQdt5GQLW/kluUgsBBWGxSjpZzm+JjJESN7ZoKp+/XUSljluJMwt
         lwc1bCIDBalWymL8ScwdiCuU8scR0dJLfD/GMttHbtENwMxk4+kuGYRni8EFTqazr7ag
         89ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707183150; x=1707787950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QApOFbEPm/JI1t7SVH7QEk9OREXHhc6+siBSRqc1pgw=;
        b=UUJUHXdq+q9Tc+epl2ko1n6klC6htUtnqyrBePL0re5nvPciplaixFSwy0AFiN9rL7
         HzQUiEERU8sXsQkwdGdNAuMnxZcuIbYyvy93R1DHcLFOAymklCbM4ZuBGVvahslXp0Cu
         5FqgDvScyBFk1W9wjJFG6FkMzModxiMzzAjBaxWur5Lj4IDJBla58OQlX6CgmBBY/Bb/
         PKSGPD5VscuDqdRnzmZQxIb8t8lu0XLX6qfo1/5X5rCKSFSu0ROd8huIqgPrl1iKJMwA
         /8NG+dfMPEz7ikEuol+y0QuiLjbF7wft/LsaLeug8RseF/BnoFLH19k1sazNISySozKO
         xFnw==
X-Gm-Message-State: AOJu0YwDJumQG8x4qYFdOSdjHsZ8iEQKdyY8zUFW9AA47B59K1gXNd2Y
	kA6sxymMjD0esTkmTEse9Aw3D6AKHa3Wa+NgbYax956rVSczSTmxOsFQ4xnF5gbwDwAEMvjqPsP
	eXhSU9+ewn19qceS8xkQmEmRnr6I=
X-Google-Smtp-Source: AGHT+IHUMaYOGTgK+RnvIZj4DE1FVEUcXcafoRoI1YyaPAB0kLsdo4GRcmUByonmfL4zI4Q8fbXBT9T2+pTV4cvG+FU=
X-Received: by 2002:ac2:47ee:0:b0:511:3058:735c with SMTP id
 b14-20020ac247ee000000b005113058735cmr548346lfp.23.1707183149595; Mon, 05 Feb
 2024 17:32:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705916069.git.haibo1.xu@intel.com> <CAJve8onDbX44Ph6a-FdO2+p7QOQLah-7OyF+yUc06wud+SvmQQ@mail.gmail.com>
 <86zfwe6frn.wl-maz@kernel.org>
In-Reply-To: <86zfwe6frn.wl-maz@kernel.org>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Tue, 6 Feb 2024 09:32:17 +0800
Message-ID: <CAJve8okvg=UTWgmE=TpJT=nQJB3i6R_Tn_0AS1MtsD0mP8i3JQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] RISCV: Add kvm Sstc timer selftests
To: Marc Zyngier <maz@kernel.org>
Cc: Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
	wchen <waylingii@gmail.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Samuel Holland <samuel@sholland.org>, 
	Minda Chen <minda.chen@starfivetech.com>, Sean Christopherson <seanjc@google.com>, 
	Peter Xu <peterx@redhat.com>, Like Xu <likexu@tencent.com>, 
	Vipin Sharma <vipinsh@google.com>, Thomas Huth <thuth@redhat.com>, 
	Aaron Lewis <aaronlewis@google.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 12:24=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Mon, 05 Feb 2024 13:10:26 +0000,
> Haibo Xu <xiaobo55x@gmail.com> wrote:
> >
> > Hi Marc,
> >
> > Could you help review the first 3 patches in this series?
>
> For these 3 patches:
>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
>

Thanks for the review!

> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

