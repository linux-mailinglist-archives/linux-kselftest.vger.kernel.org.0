Return-Path: <linux-kselftest+bounces-7684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85F88A0B6A
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 10:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E963F1C22C97
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 08:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC6313FD94;
	Thu, 11 Apr 2024 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qhh7A5m3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BCF1E50B;
	Thu, 11 Apr 2024 08:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824618; cv=none; b=sh9SL1SwdceOZwPWAJzvXReLKtM0m2JrTePOfVBmdlY5b0557LTSj1X67lph1VL0dPwpYG3gcGpeX2ZbdbxtjdXaCetWSIOiXFfmLiuFSW4LcV+DRcXMNDENtx9DwzAZCescbrNfDZS/omPa/nRKFLzE2ZmkXBH5257zBp3WSwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824618; c=relaxed/simple;
	bh=unC3x+nKSIK9u/ndQdxIJyL6zS/jbDXkiDpSXnhD5yQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVkmx9DZ1X4Kg+kDSpTyFVG7Me+wj6h5q0diHBKLdQQOgU03D7rGbL9bgQK066Vo/lgzhqomt6JLYo3+OxYfOkMD30R7SuoaAs4PDc3f7DZCChMc/IfYv7QVKEZgzRsZSAk20blrKj62Vd4jq1kprzEaaxkb4ueQP4tM0/pplDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qhh7A5m3; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d858501412so96282021fa.0;
        Thu, 11 Apr 2024 01:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712824615; x=1713429415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1u+KIu05ihNMsOZBDu+U/wU/eh0uP4ZgU6yLRCPBFzw=;
        b=Qhh7A5m3QaviOs4Q519VzWvhnC85Px3d2g45XBjZOwbAFINvyYOwdPP+Mpim2zH0kN
         UkLzkOVUsuLFRd0JuloScIFe2stPs8/BC6NZLdgBUgDJLoeofO25EV2jcf2Du0XRwFQb
         6/rh+upmd9ATBNJnTu82X7lDn/lEkKA8F69VTJK3woNtqjR04cy4nc7a4m5cLHfUZH++
         VhX9kZXA72mDD2pdhoTqXb9HdyM8i8ZiMajwSMLEwvbElWQaV8/TrPBbEFk7DCDMwijP
         cyECFeVr2hsJHsQszOauiLW6EaNJnUAmpQSZzOY5zw0KMJgRUWodg2CWbIGUVMIYoCZU
         YPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712824615; x=1713429415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1u+KIu05ihNMsOZBDu+U/wU/eh0uP4ZgU6yLRCPBFzw=;
        b=TLUl6WHMvhtT7/Np7+53WinkO/4i9AlFXibo7BN/8tBhC0VAq0Or16S/lNmRAp7A7F
         ZrtsRpcQO+Uxw+ThVzE+d+No9f+1FLLp7OI7lWj1Mf7Xv3Tqv9GeBRjRALto5N4uI/vF
         /75lRNau7SYJXivrUMI0v8Vko2rb6uFUXWHQ+fnaE/fw8jaM5g6XhHc4BCwpDd9Z7rAv
         wH6F7VsZHHi9V4stF9bSUvY8WCRhSJm3zkX9Re3qY0FPoGBJ+cFPYuVtyVAZn9W3rSlF
         ZJsJ5m77SL8wcUoAFhFJyEhXly/f6kQS5PDoc8o4lOLCK9USbgBKdBeihpFX4LjIJxMT
         sRYA==
X-Forwarded-Encrypted: i=1; AJvYcCU2avCOhcQ+QS6Wap+gdVvXl8q7VbYuIjHFLnmaPIN5oKufonIYlgenYwONURlTnas7wi0XhDYpYA74swozLyvNedeGLHxTNrw0626YkBQqQ+ogvrg2m3cO/MHjduiEAx/eQEgloPJPscT+67m5Zn1t0McF8ShOaFnKWF9lAqof0SeLPsIXd9vgbZOUkXEIXB6ynAP8inCNJOTsKA==
X-Gm-Message-State: AOJu0Yz6JDHJSimfUa3urdhFse5VlAGG81chkwDQvik5EaBpRzaYxDmo
	WHRapblPd1JuULdY/PBsSPwk1g2P09akr2CkKwibjD0PpTg9s+HOGtHuwGHYHnRZa4qbohFLQBQ
	lRiFCHaImdbw5f+UKh/ptrXdncjs=
X-Google-Smtp-Source: AGHT+IF4jpfgO6KrvCVpvX1EqpYoDxh3vVK9JKFWkheC89nBbr0BesQjZ1tf+Ubo6b8fD7/nohBsJkHAlSiq+ko/taY=
X-Received: by 2002:a05:651c:10a4:b0:2d8:1267:320e with SMTP id
 k4-20020a05651c10a400b002d81267320emr3245491ljn.5.1712824614314; Thu, 11 Apr
 2024 01:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327-ccb56fc7a6e80136db80876c@djalal> <20240327225334.58474-1-tixxdz@gmail.com>
 <ex2uipr54lb2odxwzwp22ycvlwplsy4mm3shx26hczo3mjtkvz@uuzyk6535prw>
 <705d7180-aced-46ba-80a6-84ac4e2b96b9@gmail.com> <eosbqsdycwdaezg6huqwpjvttxdxgbu6ptjmpxesy6i2rl276i@72w2orzveyes>
In-Reply-To: <eosbqsdycwdaezg6huqwpjvttxdxgbu6ptjmpxesy6i2rl276i@72w2orzveyes>
From: Djalal Harouni <tixxdz@gmail.com>
Date: Thu, 11 Apr 2024 10:36:27 +0200
Message-ID: <CAEiveUdCMCxp4n+gZKU_99y_xap83otQVmz+XqSaO+JAjrKM1Q@mail.gmail.com>
Subject: Re: Re: [RFC PATCH bpf-next 0/3] bpf: freeze a task cgroup from bpf
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 5:32=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
>
> Hi.
>
> On Tue, Apr 02, 2024 at 07:20:45PM +0100, Djalal Harouni <tixxdz@gmail.co=
m> wrote:
> > Thanks yes, I would expect freeze to behave like signal, and if one
> > wants to block immediately there is the LSM override return. The
> > selftest attached tries to do exactly that.
>
> Are you refering to this part:
>
>         int BPF_PROG(lsm_freeze_cgroup, int cmd, union bpf_attr *attr, un=
signed int size)
>                 ...
>                 ret =3D bpf_task_freeze_cgroup(task, 1);
>                 if (!ret) {
>                         ret =3D -EPERM;
>                         /* reset for next call */
> ?

Yes.

>
> > Could be security signals, reading sensitive files or related to any
> > operation management, for X reasons this user session should be freezed
> > or killed.
>
> What can be done with a frozen cgroup after anything of that happens?
> Anything besides killing anyway?

Some users would like to inspect.


> Killing of an offending process could be caught by its supervisor (like
> container runtime or systemd) and propagated accordingly to the whole
> cgroup.

Most bpf technologies do not run as a supervisor.

> > The kill is an effective defense against fork-bombs as an example.
>
> There are several ways how to prevent fork-bombs in kernel already, it
> looks like a contrived example.

I doubt if they are as effective, flexible and reflect today's workflow
as the cgroup way.

Thanks

