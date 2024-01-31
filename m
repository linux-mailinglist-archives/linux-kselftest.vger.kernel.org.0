Return-Path: <linux-kselftest+bounces-3832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C7784412A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 14:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C6728E987
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 13:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F14180C1D;
	Wed, 31 Jan 2024 13:58:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9337C7BAFA;
	Wed, 31 Jan 2024 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709495; cv=none; b=l+VHppatUt1YLGj82yigADPftkM0m/9G5OUvqB+ocWkDWcVNBkkqTQ29s7Vcm2iDWHTwdZxV56/dz5IkbVwi1E3EqommmfxaLL+nnQqVss+MlcpOfck/m5hYiKUs37w4YvDFbqyL06hcyC3KtOR7TALgztDb0w9KiWFpo9EHVZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709495; c=relaxed/simple;
	bh=td42V5WtxJ5A7xupTMIxEkM8quiEk1wi7aSb6k8B9E4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfB6KMJowkfQZaNnSh6ggJlRgdek1sUIC1OQ8CmmnPLl8bL+UtcTm4VpvoiUL5OzXsdYIhlLVetWPHoPa4OzRB+KO0B1r7mg2vb859Y8KfIdAm6G1zplfMgvHijqy/9BaI8s68nDBRqigRkyy/iWf62UgSgWNY+YvymajXpcUak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59a1e21b0ebso889979eaf.1;
        Wed, 31 Jan 2024 05:58:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706709493; x=1707314293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=td42V5WtxJ5A7xupTMIxEkM8quiEk1wi7aSb6k8B9E4=;
        b=msaMTh9cXydxpOK8s3rQ+SJlaisKxHVWAMPoguu5Sash4Jc5vgZrQwLZLomZn3PvUL
         XjFnTyHUg5PqCFnNLQjn/OSBI5KKDERhyu9sg6r3HzoDahim6AenzBGo1dTMG4gGyzXQ
         XGfKjUeMZBfdufByMohJT0PC8pgD1vqa1OLHz+x3NYnQDrDaeEWZd0tPe4vuSgsn+fWZ
         7iRrOVZFjqEom/AYwh6IxqIzd53AC3NNjL6Y2AkR3Z74zOWqUOAeJgQUrUhC6I5VA0ug
         WiB8s1MhtPpCFMh8yHQlib+bykAGiItbjSEobos75QDEQWM91Y32RhlAVt0GVLEvzkS9
         qFtA==
X-Gm-Message-State: AOJu0YwEo6LO1YwAaKRVLOUPA6Wi7BNrdfUzq6J7BExI+mcTP/j6Pk4Z
	SjUv7IeMOwRCtjy7sUEs8x9bEKzxv10rgNzpscS5bksScZ8e0Y9noT4NG+Fgaz2C0juRGuUVSYB
	NnKRwfuh28FMnwR1XwTOfIUuhs+8=
X-Google-Smtp-Source: AGHT+IGknvzqH81VSV0dvAw4O75J0y/Wp3wRWa45qzduvyN05yPyp6U2FaoaAhJ67DaS0Zr+WLrzTtvYhkAYbJhslrw=
X-Received: by 2002:a05:6820:606:b0:599:6d16:353c with SMTP id
 e6-20020a056820060600b005996d16353cmr2065521oow.1.1706709493563; Wed, 31 Jan
 2024 05:58:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119090502.3869695-1-li.meng@amd.com> <CAJZ5v0gzKdjZJBypEw1+czGN-SHbx0s0-h=Lq96+MDVAO11PYQ@mail.gmail.com>
 <20240129153311.GDZbfFN0Twxkw4FnKX@fat_crate.local>
In-Reply-To: <20240129153311.GDZbfFN0Twxkw4FnKX@fat_crate.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 31 Jan 2024 14:58:02 +0100
Message-ID: <CAJZ5v0hRk3tME7yeC+1r0RM4-oPPrnSu2=JCsOshBbJp_Nq2Hg@mail.gmail.com>
Subject: Re: [PATCH V14 0/7] amd-pstate preferred core
To: Borislav Petkov <bp@alien8.de>, Meng Li <li.meng@amd.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Huang Rui <ray.huang@amd.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-acpi@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kselftest@vger.kernel.org, Nathan Fontenot <nathan.fontenot@amd.com>, 
	Deepak Sharma <deepak.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Shimmer Huang <shimmer.huang@amd.com>, 
	Perry Yuan <Perry.Yuan@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Oleksandr Natalenko <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 4:33=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Mon, Jan 29, 2024 at 04:18:02PM +0100, Rafael J. Wysocki wrote:
> > You've had comments on the previous version of this.
> >
> > Have they all been addressed?
>
> Yeah, see patch 1.

Thanks!

So the whole lot has been applied as 6.9 material, with some patch
subjects changed and a couple of changelogs edited.

Thank you!

