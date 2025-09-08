Return-Path: <linux-kselftest+bounces-40929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D78B488D1
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 11:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6A81B24F34
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 09:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAAF2F7AAC;
	Mon,  8 Sep 2025 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m83pJuhg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542892F0C61;
	Mon,  8 Sep 2025 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324437; cv=none; b=Vn/lJmBsuVZ/yFIqmYqKrcXUGkfaKKAm7rGW7REbRGg08oXpNrswdiGr+1/O1C+ijtUj7z45zpiu9CV6k3gORVToIgRJRSfNuWJDmtlRjN8ZS5GLKWUdyuj+gHghAUaA4zuH3QzNRJ/+Dl/C9zM/RQEFbVgPbiSHZb/90rL8gN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324437; c=relaxed/simple;
	bh=QpvSsLIC3y/1f4C/dkwxyE/M1TIZ63GqjD5Z54UA2wQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJODRgKqSG/MDd9cPw9rSgdFk/mlvInjD8twUYvA92q1aic9AUcbJxW4vQroHW6C2os7WHWSdi/JmosVmZpeE92yuV4WwWFhu5A5d9NA1U3FY1hmk6M9NfXMg62Evr9/Jvb+Wq3h/K9ap6BLVquc/lffJf24FK6LLug2qKkOsuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m83pJuhg; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32b863ed6b6so3295285a91.2;
        Mon, 08 Sep 2025 02:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757324435; x=1757929235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qa/J+RFgG8WV3v0J/rV8y+i/k2K2qXB7AVUN7w+XBMQ=;
        b=m83pJuhghDKa4UIk7D10g79BhY/N90hgJ6E1LlZa4Gzt2/8f44i+bs04Bzt5x+QzMG
         Zc/NxV/HzQFJ+PmiCCpy2Mth55dBXzh6sWEs0/woWtodbm+uCYj23N/kfqRJuKwTbsVS
         UJzTSfJ7LW/YQTdi4wX+f+MDvfNAdv5S5U1CsWafF/W+lyKwGELvh00C9+S0PJ8vYma+
         fuFw/wm3+vfx0U4WjVi+07KAlSqDjXjU1UIB6m2Uol40sWDYBPelnzcVT1w1k+4I67ec
         3jifKwVUBKuJbjt0qrNhnlyR78cziaTnzMwOZnIZ+DQlImhYmvZGYEv4r9IGXM4GBAGu
         wgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757324435; x=1757929235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qa/J+RFgG8WV3v0J/rV8y+i/k2K2qXB7AVUN7w+XBMQ=;
        b=rtual/2EEAtZyFcJCpUQT25z0nDzZ94nzL1IsnNDxAUIEQhn+c6rr6WexZPOK7w3Yd
         CGKPEWOdVUiiugWqZT+4j9wGp3m08XTNNMQI2WzLnRIk5FartR118QGw0Y/+ARDOA+tX
         ljh+2qjzCgm6og9V9nxCmc2GnQ/mszP+nk1AfzaRH9TSDhJvTW32ms1a/DqyJ9ZaXrc3
         CudvMS/MrKAsR8u+/JgLTRPsp0MqddR0NopvuOdxX3jjs6JXCRuFtQlgk7IUNbntz1XN
         KWa6J7geyx2ozYbdkSVDje/uZ8V81bO4fvjgFudrrRo4Y9F0o5r+ha/Sarq2SbeWjPEX
         V7jA==
X-Forwarded-Encrypted: i=1; AJvYcCVAlgVTzpBtPf2+7SeX1QDEdqQicb7sZuT0kM5YIJ7ncA2DaVpDWN5VVMJHVYZlq596lfVf4KQAF7nvluI=@vger.kernel.org, AJvYcCVP3OzpmOGCT6OpvE46eAIr7xASDj7Xf6sn4zYp6oMFpVjAjAkAtaf5JVHho9hk3y8Kkw2tc9gnS6cCcWe+ZBqu@vger.kernel.org
X-Gm-Message-State: AOJu0YwVqQjcRQXf3cpTIafbAOFaU5MquVBtf4s0p5Qnzahny9bwaCPq
	yFRnNG43g92+t2AbsIjavgQdnEnWs0CMYFupO9FCGNVZlLNMFrESOxpxVfvTnhRt97qD0UphE5o
	v9eQU0XLrOwPFxpAfK/laqXs7WPdAMq8=
X-Gm-Gg: ASbGncuixiksqUc/WLdnHTQ1lLSItJorfswCzniY5OYuufMSZu0JnQBaRZMsIo7/DXS
	OwtrTKpiVAXMoxQEQ1UTAQ/qyuUbkgtG9OP2Ofnsk7sPrGINyPw3AVRPcIILstnL58JJOOiirt0
	EeMAdE60cEYQOnlZas/CGmH1+LFWtIf6rDwUi1HlXPQnEPc14+6twYoP6j5JRJiLyOSRD9w3FUA
	gy3J0ql8A==
X-Google-Smtp-Source: AGHT+IGdm5EM0vwj7xDTAK7ktk2u2ufRY8rc0vUl0jh9BkX0ZbfxJ2mzIu8V2pNWy9DDkJQbOsq4m1d/5bp9TUIyWY8=
X-Received: by 2002:a17:90a:c2c7:b0:32b:7d2f:2ee7 with SMTP id
 98e67ed59e1d1-32d43f18825mr8606342a91.13.1757324435524; Mon, 08 Sep 2025
 02:40:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906170440.3513399-1-mmyangfl@gmail.com> <aL59Jl5p6bEtCAxo@shredder>
In-Reply-To: <aL59Jl5p6bEtCAxo@shredder>
From: Yangfl <mmyangfl@gmail.com>
Date: Mon, 8 Sep 2025 17:39:58 +0800
X-Gm-Features: Ac12FXzfSMfMuLN5WUIuosyZeC6OMMIRaaN3_bgOpAHqsn-4LrdGRJ5-CvHDUr0
Message-ID: <CAAXyoMPP19LEMj-dYWFQmwdZgGbXOq+iYbONCAFx--PNN8TNoQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] selftests: forwarding: Reorder arguments to
 obey POSIX getopt
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Amit Cohen <amcohen@nvidia.com>, 
	Li Shuang <shuali@redhat.com>, Alessandro Zanni <alessandro.zanni87@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 2:52=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> On Sun, Sep 07, 2025 at 01:04:35AM +0800, David Yang wrote:
> > Quoted from musl wiki:
> >
> >   GNU getopt permutes argv to pull options to the front, ahead of
> >   non-option arguments. musl and the POSIX standard getopt stop
> >   processing options at the first non-option argument with no
> >   permutation.
> >
> > Thus these scripts stop working on musl since non-option arguments do
> > not always come last. Fix it by reordering arguments.
> >
> > Signed-off-by: David Yang <mmyangfl@gmail.com>
> >
> > v1: https://lore.kernel.org/r/20250905173947.3164807-1-mmyangfl@gmail.c=
om
> >   - fix CI errors
> > ---
>
> A few comments:
>
> 1. You should have "---" under your SoB so that the changelog is not
> part of the commit message. Another option is to use "git notes" and
> passing "--notes" to "git format-patch".
>
> 2. Did you try a newer version of mausezahn? Seems the issue was fixed
> 2.5 years ago:
> https://github.com/netsniff-ng/netsniff-ng/pull/237/commits/f5dce56e74b00=
5daec72c771d27d55964aa8efd7
>
> I feel like this change is fragile since current usage is in accordance
> with mausezahn man page.

Sorry, I didn't notice that.

But ping is still affected:
https://github.com/iputils/iputils/blob/master/ping/ping.c#L400

It's quite suspicious just replacing getopt with getopt_long given
that mausezahn does not use any long opts.

Should I fix (ar)ping only in selftests, or fix iputils with that trick ins=
tead?

