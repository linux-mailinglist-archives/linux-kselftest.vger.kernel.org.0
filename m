Return-Path: <linux-kselftest+bounces-18022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC39D979C4E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 09:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA651C20B2E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 07:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4187A13AA2E;
	Mon, 16 Sep 2024 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l4zd0qIB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F97D3FE4A
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Sep 2024 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726473225; cv=none; b=r/j1IPh93k6cacPAvxzB1wpC9P/4FTP+bFyBceqplZjZWWNfZzLziW129A6PZOmFmxFTT7UY67ardq506VI29l3Jkrft2ZAaybKFyGHbkZtoVl34jEf9foPJf4emJIXFDmlv14PLA7Z7gMfHCOoNG7y3yhvTxZF3d42W6anVkw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726473225; c=relaxed/simple;
	bh=UESzZbWJagDjGAm6yzO3qfkMGoY/KtJI5SPqHZ1LKT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QonRiijzr+nGnPznBWvZX7U1Dmi8svFrX18s9s/qbKdb0PIZAcS2oS2qMcJKMbKrL48dY8TjTfcPmmBA+XTj+rlK77Ii9bFIwe0NkcKJnll2x11A9ZGl0dI3MUBVVBmmK8Ew8+0sJY/XEL6q23rhBa+eE6qGvr1Ye1qevYMiSvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l4zd0qIB; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-45823ee8e62so3656731cf.2
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Sep 2024 00:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726473222; x=1727078022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1+Fzx+4YrRS/cKJGxzXlTeMMFWc7wgTxgXJnmtIXTc=;
        b=l4zd0qIBkLsjI6M9jSIIYOX6N+NYM/jUovYDaGSsyDtehC8UFrgW15C00EL+QuuMg6
         BS8Q5+UeR43tcfUiWDV8U9x1AmLGDx5kaDlKLKTXN/kiAn0S6+DPcZwJtKQt/iIoz5da
         Z58owTHfZz9tPxzxxh8lg47pUOZVWnuiA8Xk7iaiSipZvGmrFgNMX4exIL9PnKjn3Ryy
         2LGIh1b9L+d2eyJ4EDd3JsF4zSQa9JYfCEqdIhlbQjixmzn8+IoHWcmq7entJdJYH/UK
         dO+qqrxlMvs9soWoY0YFr84ILKu/fqKBCiDRRUDG5HDC7d7jfirIadIr7azTy04+9n4n
         0VDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726473222; x=1727078022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1+Fzx+4YrRS/cKJGxzXlTeMMFWc7wgTxgXJnmtIXTc=;
        b=j1ypKdhP64cOY6xShdNG/TBQ9WUVXKMJUA9EGUch8QJ6ExAZDfZCoWSJNd4qhk3Vcc
         Aeg1tDaMMBIBuKQtqhOd2Dx64EvM1lBJWwhpXUmJIF5T9sV4C2nEU44v0GGE4vQauIz3
         CtanPqsCI6/k1zelZmRFeYJO287gsHX1mVqzoz6+kjMmaDnQwcUhbBZ8vRYOnyqsrjjT
         UT21tJDs1lWFPWkCEqV99p8zbDtR4qQ0tKXMncriP2NJYX6Q2g5JcQDeqfJiGQrL/1UF
         O6PzZKuieUshVAnZBz1tke6jzBY5tqdTnfrrSEYCv0jBOKSyvRhVVNw8cDRAZq99P3jg
         nn8g==
X-Forwarded-Encrypted: i=1; AJvYcCVZcUp+rEjzKrU5C86uc4Lde7IQghXdvJ4CoXWC5u/K/4jqL9LL82G7ZfPz2n8UiD5WI0bEMoKDK3+h+es4Rc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFqvhazshejYXiVDD3gJ9v74z+RtWng05T6SJnhRDiMs0OyvlY
	aptU55ms6hrKM4XyCXTLe+xt8NfhWEpE7946xIQ1FeVPfPRoQPovry170iu9G6TPNeOvu3yZvLw
	//XyhneLt53vf1q8XkpPzGRgoE7cxw9v8NOIZJQ==
X-Google-Smtp-Source: AGHT+IHxUau9anaJf1ecbZc35ylzAAq9bwuRCagPe+N6PScWK4XORKbbig1m48BoE7NqdnM3NpVT2ckSm3d6Uho1LdE=
X-Received: by 2002:a05:6214:b69:b0:6c5:258f:26c1 with SMTP id
 6a1803df08f44-6c5736ea7eamr101669646d6.7.1726473222478; Mon, 16 Sep 2024
 00:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912063119.1277322-1-anders.roxell@linaro.org>
 <20240912082307.556db015@kernel.org> <CADYN=9+OTGJtN-z_ffQx9C+UA=a_9rpF7bGtnunFJoq0BWL3vQ@mail.gmail.com>
 <CA+FuTSc15f=+zC_p3seVShGMW164Mi+_a-XiSONzx7A83tEPqw@mail.gmail.com> <20240915164647.5b2e1db6@kernel.org>
In-Reply-To: <20240915164647.5b2e1db6@kernel.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Mon, 16 Sep 2024 09:53:31 +0200
Message-ID: <CADYN=9KsjS0sK7rzuQKuAR8U3+wF2-azNvJrr-EE8Pf7nAKpnw@mail.gmail.com>
Subject: Re: [PATCH] selftests: Makefile: add missing 'net/lib' to targets
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 15 Sept 2024 at 16:46, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Sun, 15 Sep 2024 09:36:10 +0200 Willem de Bruijn wrote:
> > > You=E2=80=99re right, the patch is incorrect, I could have explained =
better.
> > > I=E2=80=99m seeing an issue with an out-of-tree cross compilation bui=
ld of
> > > kselftest and can=E2=80=99t figure out what=E2=80=99s wrong.
> > >
> > > make --keep-going --jobs=3D32 O=3D/tmp/build
> > > INSTALL_PATH=3D/tmp/build/kselftest_install \
> > >      ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- \
> > >      CROSS_COMPILE_COMPAT=3Darm-linux-gnueabihf- kselftest-install
> > >
> > > [...]
> > > make[4]: Entering directory
> > > '/home/anders/src/kernel/linux/tools/testing/selftests/net/lib'
> > >   CC       csum
> > > /usr/lib/gcc-cross/aarch64-linux-gnu/13/../../../../aarch64-linux-gnu=
/bin/ld:
> > > cannot open output file /tmp/build/kselftest/net/lib/csum: No such
> > > file or directory
> > > collect2: error: ld returned 1 exit status
> > > [...]
> > >
> > > Any thoughts on what might be causing this?
> >
> > I wonder if this is due to the O=3D argument.
> >
> > Last week I noticed that some TARGETs explicitly have support for
> > this, like x86. Added in 2016 in commit a8ba798bc8ec6 ("selftests:
> > enable O and KBUILD_OUTPUT"). But by now this support is hardly
> > universal. amd-pstate does not have this infra, for instance.
> >
> > Though if the only breakage is in net/lib, then that does not explain i=
t fully.
>
> Some funny business with this install target, I haven't investigated
> fully but the dependency on all doesn't seem to do its job, and the
> install target has a copy/paste of all with this line missing:
>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/M=
akefile
> index 3b7df5477317..3aee8e7b9993 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -261,6 +261,7 @@ ifdef INSTALL_PATH
>         @ret=3D1; \
>         for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do \
>                 BUILD_TARGET=3D$$BUILD/$$TARGET;  \
> +               mkdir -p $$BUILD_TARGET;        \
>                 $(MAKE) OUTPUT=3D$$BUILD_TARGET -C $$TARGET install \
>                                 INSTALL_PATH=3D$(INSTALL_PATH)/$$TARGET \
>                                 SRC_PATH=3D$(shell readlink -e $$(pwd)) \
>
>
> Andres, please feel free to test / write commit message and submit this
> one liner, but even with that the build for some targets fails for me.

Thank you Jakub, that solved this issue, I'll send a patch shortly.

> "make [..] install" seems wobbly.

Yes it is.

Cheers,
Anders

