Return-Path: <linux-kselftest+bounces-25975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692F8A2BBCE
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 07:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A3B87A2CCB
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 06:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1BA18A6AB;
	Fri,  7 Feb 2025 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrLnlCV0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1B014A4F0;
	Fri,  7 Feb 2025 06:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738910977; cv=none; b=c7Fh53/fxZdR4XWKfi1fFX8HXolNN5H1KBhpK/BJfLeKKF1b6PsmHeaxLpaPFd5BVypvrYo6MfHpC8WbJDWHsNf8o6Lrtw0uQdKINyMoNZMPcyAraP8sUlXrtmOdLsX8kLapyHRBs1jEZGMN7eRM3ToZF+d9fYQiOjziwdiyjOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738910977; c=relaxed/simple;
	bh=cuBBZ7Jd8w735y7vZBgoCsfnvsDNzJSaLzMyJc/FSM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekLBibid2GxoE3c7aM7lDuBkvBArjKDRtN1MJSHYsTEmbTlE8YkMbfi2wCRsN1nlecZtKV0oZiFHRgnTJ8FqA0pWY0zyIkkmTC18iII2cGzU1yTk/IrjLLvRLQrPwYUy9Xn7jqsjW9puYEIRMXjSG5XbBnpCOzsuLEbT33Db05I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrLnlCV0; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3cfc79a8a95so5379855ab.2;
        Thu, 06 Feb 2025 22:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738910974; x=1739515774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=samJguVg29xPNPhl39k0sFbJm2g3iV5+Y8a1y8Fqnkw=;
        b=nrLnlCV0NRDdYg5bsEvIoFktLiV1lt1Dg2a4FgYjgpgCjbHa/uuQKSJBhdBguLZu/z
         W8QWLoN/PHGUDT+j6Mp1Y4w6/98bOVYOkFDYMF+Y06+GmftIE291vI7kljqyI75B2961
         5pcRJixBQNrNQGBzn+ioyQLX51oHxwNQZTWAtS5IfKJlO+MxION8ixKtDk6PS0sZapES
         KtBH8G3Vu1rw6vXLE1BlgJEx9vzKyVjY413gJQ/ToX+DBc6MFv/dPhZjZ+DYHyiQ0+XT
         YRSsDaXOtWegzF2cU0uvxT1AGb3VobUxdZPpo+BggmHN3Irk1aqzLUvLwpgLi3r8TdIC
         i3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738910974; x=1739515774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=samJguVg29xPNPhl39k0sFbJm2g3iV5+Y8a1y8Fqnkw=;
        b=bMXe9sksO6rAc6sGYbHg0Yki912acmUrSLNPhIqF3D+Pt9VEmLaM3QQNb8jjnK7NT8
         YW5DsS0TFLRklXbhPR8Uhoxmj3QYTGNB9sD6+th99xjUDLN7wgKza6gyhfu8t3NeE/E4
         DvQrgI259hVS+12dJOP0wNBwr0vccfIyrmXwtvjOEQHOyaBSjGZiz0fT00l1Cilx206V
         P6TuMjB0Y1GgIV2Rz425RtuQQsTuGGxmclJ3Fgts0fG7I1564AoOMBm8XUd6Irlrm7uO
         +k0N2n5eNLtSmeENmhcaL4UkzCIE6IAlXIAL7AUVWSOGkBFhgXud05Ob8r2F7wHZuWDA
         7B2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdg6jRl79o74y17rWJancT22CoPZ5ejbMrHG/bpbUSSJZlHtthtOecz0WMq659eA6/aSw=@vger.kernel.org, AJvYcCXWw3dOZWRERGZgO0NJ6s8cAQtCLpE8xZiCu/jYOH/k5dgRMXl4D1O4WkmnhsK5QP9yD6nEpGB/5sO5I4pu7CTe@vger.kernel.org
X-Gm-Message-State: AOJu0YyvIs3ki7bajVnj9kMMhs0VTmRm7aYkwboffHrnAJ44ipRfRgO9
	GuSG3VQyHZxXpDw/qINdN0N6w03kDUwIuT0OtMHyE/sSfIUI09IwnskZe8SJTjzgxWOSHdOTaZL
	BbeyRrJo+Gpwo8b3FATZxixwAmrkrTQ21f1gXAQ==
X-Gm-Gg: ASbGnctFckr9y2fi4p+ezeXmiDhOIDkoHRUAJoD/fnmzMaVGn7k2lyncKRoloOaeMkd
	e61uA2oihptzLzIz+FvKhR603i743q5PKoi+La7QQrovmHuCvVZZdkU/WKdZjUyqGSLnhjIQ=
X-Google-Smtp-Source: AGHT+IG0D4d7wxd7XN6lbusi1BMaL2bDy+8jdzYwLphp/L0mBulIcdxB5SXFAyqeTVFH2QTwvNQo2IEx9KCpKPucZy8=
X-Received: by 2002:a05:6e02:20c8:b0:3d0:21aa:a752 with SMTP id
 e9e14a558f8ab-3d13dd2c035mr15943555ab.2.1738910974015; Thu, 06 Feb 2025
 22:49:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204023946.16031-1-kerneljasonxing@gmail.com>
 <20250204023946.16031-2-kerneljasonxing@gmail.com> <7b348ab7-7378-40bc-98e7-98eb1377f9c2@linux.dev>
In-Reply-To: <7b348ab7-7378-40bc-98e7-98eb1377f9c2@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 7 Feb 2025 14:48:57 +0800
X-Gm-Features: AWEUYZl6nZR380Ih9p0XjeuA67cvdJbvPefw64JmabsuDQHjcptMKBBZCfXEn-I
Message-ID: <CAL+tcoA2wV1CvAV1TZAvrRuxOntb0fEDpgOsC2-FVtYr-go=1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: changes_pkt_data: correct the 'main' error
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	mykolal@fb.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 2:04=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 2/3/25 6:39 PM, Jason Xing wrote:
> > When compiling the selftests, the following error is printed out:
> > selftests/bpf/prog_tests/changes_pkt_data.c: In function =E2=80=98test_=
aux=E2=80=99:
> > selftests/bpf/prog_tests/changes_pkt_data.c:22:27: error: =E2=80=98main=
=E2=80=99 is usually a function [-Werror=3Dmain]
> >    struct changes_pkt_data *main =3D NULL;
>
> The bpf CI has been testing this piece with different compilers. I also d=
on't
> see it in my environment. How to reproduce it and which compiler?

The gcc version is "gcc version 8.5.0" which is an old one. Yep, there
are some cases sometimes where bpf CI doesn't report because the
compilation relies on the system environment? Sorry that I have no
clue about this happening. One thing I know is that if using some old
distros and cloud services, it's not hard to see this.

In this series, rename it to avoid error messages which could stop the
local compilation.

Thanks,
Jason

