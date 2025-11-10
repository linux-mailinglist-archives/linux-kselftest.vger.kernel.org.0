Return-Path: <linux-kselftest+bounces-45231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC8EC478FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 16:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 187904F288C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 15:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9564224677A;
	Mon, 10 Nov 2025 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Nl4Gl5OE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDB0231827
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788447; cv=none; b=B9LvPzsJFIubRcuPwfsGiggLueny9mZEnvyCuDk5N1tVZjB62R7J5+dotnudcaD/9+x/+MxjfCKppgVSBy728Z5qeXmjwEATOGqf8q2pT10LL+HLkQHrIugw52iaQ5txtTosm5u5KCqeE274fySbdf9CcqYW2mT3cTgCpBuXcFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788447; c=relaxed/simple;
	bh=tTrwyqMXKGOusM8XR8JCOt9JF5xyhgL7Lhk3o4N59YM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsVcuWNPMu0vAhcjJsnE+Kr/OK7R/IYQCblQi8Fq0FNjmFW/VhzTirsHHHxFLERJ0xin9WsLsLpz3cU7SKNpsm9RctgQAUvlfRcmVc8QnDeykVTfnwI8U2htAeHnw4JeZMiE/1Xou1+eDJzZFtVwA8yO23bPY74FnijAXVp3624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Nl4Gl5OE; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6407e617ad4so5422166a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 07:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762788443; x=1763393243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xx5VH4vrYCNCYpVzx/bKqrzvT5nCviGfQ8I1/CSh6+0=;
        b=Nl4Gl5OE9iAy2SFBh7TKwjJiL6RnNxRn+CjzmE0AvQNEeqIhWihGv3XIqfAQWjIMe2
         r3jTOtc2g4bdkBSlpdN9oGTMO+TPtaHNZkNYhc+4wFD5BU6Y0pafCUK8WUJGx4UumWHp
         zGxqvDrHei8EJlKNOfKJvxqnNQZV330pryuuz5lDaCe34rsaPpyd9rCZE07oAxJ9gd0t
         fyJMY+dAy7YT52D6VQd+308G+Y4nI+rXiiaT8TlxknKzKJhLoRr1NKw8tVl/1xTHF+bG
         IbJX3VZAh5h/MLdTz1B0WyWljiLeiE1I7OcATfWm0+L3L7NX1r3orf5EAt3/9AY1DcpV
         L9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762788443; x=1763393243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xx5VH4vrYCNCYpVzx/bKqrzvT5nCviGfQ8I1/CSh6+0=;
        b=lPe2y4BWjrWzpx1x2twLFKDUS9xpvUHuipUbKYGPRu2+kV5kYsAQq057YlCozKc5B5
         v9mL/Bha0kYY8w3AFZib/0Sbr4hwnfK47peBAkdWnuVs9nxhm1wa8WahDOwhWjpBv4w1
         rQ+bG058Gsi4ROr/E5NhsdFacUxM1ENyQuRfnEG8oR0LOKGfmJ0+DQfmTzM5ciH3d3cy
         80eqBA9UjSI5LjQopDy4xXTutaVEPoxdHZU8oQ1gF8LBGMqk40K3jpXxQ8d1Yhh4OPf2
         6P0RiIbCl9PVTmabemaYMZFq+M88t5/ix5MxoGmApyykqAEkLAav/IZ/YaKZe4G1GA5l
         CXDg==
X-Forwarded-Encrypted: i=1; AJvYcCXbxWagyDbU7Eqwnp9bX5LC5aBbXIBr02RTs0BJn5tUb3od5ic1uDajCDi7cSdC3W9dbKD/xEh2Bqfdk7sz7RU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTbO+gBo6lOVViP0t4BRCi13ocrKyHCvPQg3l7Ipgr8d3FkSko
	1PPNxUOEthuP9anUaeJVxpEiYLetS/JtqRn/Vb5QHNdgvzNlzNUYwqCno8uKMPEUoLzB+VV7ps/
	AQxjmgQDTpwzXqxo4zfLBvGNEWrmH6sUxZWSJdG4vig==
X-Gm-Gg: ASbGncsr2tgKLcZhlqAg2c01czGVBkCVIOb+sL+FLLytw9XNBQInrYd6A62vlNJ9PcS
	FcYgmD9MfdKdnvpVxK/w0BB5ode8cWF6f7n9q89+CYdR7iYDB4IfDXrBkwc5zAnEaEcp26Rh19N
	gitOTmKgDWMPHEmKDR7pT/79+b3IU8+KNfocr5BmqQMU2E8sGdYUS51mjbSah1V0q366ltqcxvH
	2RCnApnF75mEF4oJspFRHKs38kkvHX2zv4rTl7NWmg2d9q/TtmY0ycvEH7GRx+WUTPX
X-Google-Smtp-Source: AGHT+IH3MMnfCX6a3z6KUPljUpeObG5OPDBsINyyjGmXqmi/rDT84EI39PSGtuUazEgx1PPu0eGaSKu77yp++hDXvLE=
X-Received: by 2002:a05:6402:2813:b0:640:9bb0:a059 with SMTP id
 4fb4d7f45d1cf-6415a078158mr7201302a12.10.1762788442919; Mon, 10 Nov 2025
 07:27:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
 <20251101142325.1326536-2-pasha.tatashin@soleen.com> <d7651272-f979-4972-ae41-bab2faa8473a@linux.dev>
 <CA+CK2bDSvtuwrrXGOC07Rj42yGFHWR4Sse7Q5z1z8f1ZFHWQ2Q@mail.gmail.com>
 <CA+CK2bC_+repP-q183hjAuYYB2-Yx7fr_U3zr2cxysAWx5hzpg@mail.gmail.com>
 <029090cf-9a4d-4f79-b857-04c3ada83323@linux.dev> <CA+CK2bByYPJXSNOh6R3swqFrGsS02m3Dfh=ZU7YhNjNX6siyqg@mail.gmail.com>
 <442fa82e-16ef-4bde-84eb-743450222468@linux.dev> <mafs0qzu69gei.fsf@kernel.org>
In-Reply-To: <mafs0qzu69gei.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 10 Nov 2025 10:26:46 -0500
X-Gm-Features: AWmQ_bmW_CU-wm8DFynzZQ_qvdh98IjjlGR3MaYCYIdL41bju3LuBNxGSfrd-pM
Message-ID: <CA+CK2bBEe16x0em1gRxQD3jhfV9t3QA2vx5ifk2pKb_WEoMTeg@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] kho: make debugfs interface optional
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, akpm@linux-foundation.org, brauner@kernel.org, 
	corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 8:16=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> On Sun, Nov 09 2025, Zhu Yanjun wrote:
>
> > =E5=9C=A8 2025/11/8 10:13, Pasha Tatashin =E5=86=99=E9=81=93:
> >> On Fri, Nov 7, 2025 at 6:36=E2=80=AFPM Yanjun.Zhu <yanjun.zhu@linux.de=
v> wrote:
> >>>
> >>> On 11/7/25 4:02 AM, Pasha Tatashin wrote:
> >>>> On Fri, Nov 7, 2025 at 7:00=E2=80=AFAM Pasha Tatashin <pasha.tatashi=
n@soleen.com> wrote:
> >>>>>> Hi, Pasha
> >>>>>>
> >>>>>> In our previous discussion, we talked about counting the number of=
 times
> >>>>>> the kernel is rebooted via kexec. At that time, you suggested addi=
ng a
> >>>>>> variable in debugfs to keep track of this count.
> >>>>>> However, since debugfs is now optional, where would be an appropri=
ate
> >>>>>> place to store this variable?
> >>>>> It is an optional config and can still be enabled if the live updat=
e
> >>>>> reboot number value needs to be accessed through debugfs. However,
> >>>>> given that debugfs does not guarantee a stable interface, tooling
> >>>>> should not be built to require these interfaces.
> >>>>>
> >>>>> In the WIP LUO [1] I have, I pr_info() the live update number durin=
g
> >>>>> boot and also store it in the incoming LUO FDT tree, which can also=
 be
> >>>>> accessed through this optional debugfs interface.
> >>>>>
> >>>>> The pr_info message appears like this during boot:
> >>>>> [    0.000000] luo: Retrieved live update data, liveupdate number: =
17
> >>>>>
> >>>>> Pasha
> >>>> Forgot to add link to WIP LUOv5:
> >>>> [1] https://github.com/soleen/linux/tree/luo/v5rc04
> >>>
> >>> Thanks a lot. I=E2=80=99ve carefully read this commit:
> >>> https://github.com/soleen/linux/commit/60205b9a95c319dc9965f119303a1d=
83f0ff08fa.
> >>>
> >>> To be honest, I=E2=80=99d like to run some tests with who/luo, includ=
ing the
> >>> selftest for kho/luo. Could you please share the steps with me?
> >>>
> >>> If the testing steps have already been documented somewhere, could yo=
u
> >>> please share the link?
> >> Currently the test performs in-kernel tests for FLB data, it creates a
> >> number of FLB for every registered LUO file-handler, which at the
> >> moment is only memfd.
> >>
> >> It works together with any of the kexec based live update tests. In
> >> v5, I introduce two tests:
> >> luo_kexec_simple
> >> luo_multi_session
> >>
> >> For example, with luo_multi_session:
> >
> > Hi, Pasha
> >
> > I enabled "CONFIG_LIVEUPDATE=3Dy"
> >
> > # ./luo_multi_session
> > 1..0 # SKIP Failed to open /dev/liveupdate. Is the luo module loaded?
> >
> > # ls /dev/liveupdate
> > ls: cannot access '/dev/liveupdate': No such file or directory
> >
> > # grep "LIVEUPDATE" -inrHI /boot/config-`uname -r`
> > /boot/config-next-20251107-luo+:349:CONFIG_LIVEUPDATE=3Dy
> > /boot/config-next-20251107-luo+:11985:CONFIG_LIVEUPDATE_TEST=3Dy
> >
> > I made tests on FC42. But /dev/liveupdate is missing.
>
> You need to add liveupdate=3D1 to your kernel cmdline to enable LUO and
> get /dev/liveupdate.

+1, kernel parameters require: kho=3D1 liveupdate=3D1

>
> Pasha, your LUO series doesn't add the liveupdate parameter to
> kernel-parameters.txt. I think it should be done in the next version to
> this parameter is discoverable.

Yeah, that is missing, I will update that in a standalone patch, or in
a next version.

Thanks,
Pasha

