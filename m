Return-Path: <linux-kselftest+bounces-18003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478719794D6
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Sep 2024 08:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F7B2811F7
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Sep 2024 06:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8123A24B34;
	Sun, 15 Sep 2024 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iobofBEk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71011EEF9
	for <linux-kselftest@vger.kernel.org>; Sun, 15 Sep 2024 06:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726382711; cv=none; b=O9+nJ6DXI/QcPaFnLHhkZPy13hHaAx885lA9rQHYi0KumKkeZkF7mon2ZZfDfRJzZf5H555ILtA3PSe7A08f+CkmpnU65B00ODU9oly0iMgnyEgIWrw/gZflqy3aA/IWFQiz/uBxq6YNlaOqLNiL2fO+CN22dEkhJYigNCT2FYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726382711; c=relaxed/simple;
	bh=2cDl6WtLGXTvVPOzxG2CUri0osMteN44h5R/YVStwWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBskf+4vDjKWHtdwB5qDt5PBNSbGSIRtrj8f8J5qUQcHmougiLpWRoms0OIRdjhFavNHncLHibbfOak1bPY3r2GFFlTYEQvniywgQ0N2Zq5Wl+/Ysl+UW+Xe0wJhwTLkQvOPUhnrGpSTCPQvdEAkUrz2sAFb+O+srdAtrpMabiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iobofBEk; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-458150a2593so4600041cf.1
        for <linux-kselftest@vger.kernel.org>; Sat, 14 Sep 2024 23:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726382708; x=1726987508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kb0CxTCYk7wgmKngYZCf/JDr8PtnKr7Ci97TV3E52U=;
        b=iobofBEk3uO8tg12v8CtnMaVBVfjJtPYXX9I6gCfTkUeUMhZRKhsK3A33JEdUGQCwf
         D8FlW77ioEimNfY8iOpK2euyKW3ZXHrfFpheFXlV2icRdbb9ZaZuJCJIOcz2M0qlHx4u
         3jtcoMyXb64lLB/KRCpVaEzRAIojSo73ZfIWipuSiiZGI2+K3ckr45VBWabMhJ5UHxdc
         I4GBUx2135K379VSHSI9OuRg5+KDIhoY5tx/FeOmp6ca+fEpitvW1ewUmqsxEJdybCEC
         sYlbtMAlYjpSA4ASiwEhcQxOXLvMuQI5Ar6XvWcquDyl/Nr2xmLXum5av/869/MjHnS4
         XA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726382708; x=1726987508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kb0CxTCYk7wgmKngYZCf/JDr8PtnKr7Ci97TV3E52U=;
        b=HwhJINX3QjZIEkGOuVXoJKgjg8jwMIQszvlEtp58sQVmcv1hP3hzHY/C608KynShe2
         f1VOnmUmoCcTehLxmIGm2MCjRMDx/kWZDr9WvGBbYYPL4pn7mVtVfnJzbIRVQN51KTd0
         hFOGuhlDcD+9nEQ6g5z8w85G+7J6+YfSnA85WcKfUbgrsti6Ht4XrB+RZ3xARWGmkML5
         JEBmF/WM7JglBy3qFdIaAufQnqswDmqWBEkuQ17za+AC7mzIMDYG+esiFXSnQMilDwYW
         X0LDYT9LS9EopI8ck8gUUAEpwM9s5Du+kdmurhxEW32kcT8Ru0zBl84fLzZOOvUEH6yr
         Zxtw==
X-Forwarded-Encrypted: i=1; AJvYcCXLsSDfm7OcA5+YxGFw7Yfmp4Hj01tGiCWZikz9RxAQxq5XqlX4nGCsGR5xHG91lFBpgOTTZS6di0ND+Gv7FM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG7389qQs1uu21hajBxIq30x13/8f3HPPOSOYp4tLh85cYfbSu
	0NsePFb4PWCtSIb5aMIqMLVssR7FG7N0e0Rah1dba4s0Jq2coWu7xFWSwslbldw9r/r2dZDcu8Q
	YGt3NhWxBFc7Kg+XEBvZTtpwC553ZmXGIM9iNCA==
X-Google-Smtp-Source: AGHT+IF/ArzWzaDvqW1hMJiWIaZQtLFS3pCkl4+VCpIgUFNI2XO2aPdLmQayQukDhNtDDDF2Gf2lCPW4OZYIKEDHba0=
X-Received: by 2002:ad4:4ee4:0:b0:6c5:1572:4423 with SMTP id
 6a1803df08f44-6c57350a89dmr83197946d6.2.1726382708374; Sat, 14 Sep 2024
 23:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912063119.1277322-1-anders.roxell@linaro.org> <20240912082307.556db015@kernel.org>
In-Reply-To: <20240912082307.556db015@kernel.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Sun, 15 Sep 2024 08:44:57 +0200
Message-ID: <CADYN=9+OTGJtN-z_ffQx9C+UA=a_9rpF7bGtnunFJoq0BWL3vQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: Makefile: add missing 'net/lib' to targets
To: Jakub Kicinski <kuba@kernel.org>
Cc: shuah@kernel.org, willemb@google.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Sept 2024 at 17:23, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 12 Sep 2024 08:31:18 +0200 Anders Roxell wrote:
> > Fixes: 1d0dc857b5d8 ("selftests: drv-net: add checksum tests")
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  tools/testing/selftests/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests=
/Makefile
> > index 3b7df5477317..fc3681270afe 100644
> > --- a/tools/testing/selftests/Makefile
> > +++ b/tools/testing/selftests/Makefile
> > @@ -64,6 +64,7 @@ TARGETS +=3D net
> >  TARGETS +=3D net/af_unix
> >  TARGETS +=3D net/forwarding
> >  TARGETS +=3D net/hsr
> > +TARGETS +=3D net/lib
> >  TARGETS +=3D net/mptcp
> >  TARGETS +=3D net/netfilter
> >  TARGETS +=3D net/openvswitch
>
> Please make sure you always include a commit message. Among other
> things writing one would force you to understand the code, and
> in this case understand that this target is intentionally left out.
> Look around the Makefile for references to net/lib, you'll figure
> it out.
>
> The patch is incorrect.

You=E2=80=99re right, the patch is incorrect, I could have explained better=
.
I=E2=80=99m seeing an issue with an out-of-tree cross compilation build of
kselftest and can=E2=80=99t figure out what=E2=80=99s wrong.

make --keep-going --jobs=3D32 O=3D/tmp/build
INSTALL_PATH=3D/tmp/build/kselftest_install \
     ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- \
     CROSS_COMPILE_COMPAT=3Darm-linux-gnueabihf- kselftest-install

[...]
make[4]: Entering directory
'/home/anders/src/kernel/linux/tools/testing/selftests/net/lib'
  CC       csum
/usr/lib/gcc-cross/aarch64-linux-gnu/13/../../../../aarch64-linux-gnu/bin/l=
d:
cannot open output file /tmp/build/kselftest/net/lib/csum: No such
file or directory
collect2: error: ld returned 1 exit status
[...]

Any thoughts on what might be causing this?

Cheers,
Anders

