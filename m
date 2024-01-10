Return-Path: <linux-kselftest+bounces-2788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E349082932E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 06:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81DA11F269BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 05:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EF0CA4A;
	Wed, 10 Jan 2024 05:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VualP6Tk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F73CDDA9
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Jan 2024 05:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-205f223639fso2505967fac.2
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jan 2024 21:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704863412; x=1705468212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqYcNWY0+b4B+ZSOG0sn5MgB4C9W0WVUcXjDmWofD1Y=;
        b=VualP6TkUfHsIjmRB07FzILzkiQk8aUT4StQEsGMZPVngz6NTLiejhQpAcjItTlTMX
         gDycuVtkj3RPxxCrCYCdgkEPjQ2+wKvj7C8GOU2VucCbkjsBy5Wt4N7ALv9KgW7XCnTK
         moSDemU4A5teYf3TFFZnUoprQW7a4FjdL/vUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704863412; x=1705468212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqYcNWY0+b4B+ZSOG0sn5MgB4C9W0WVUcXjDmWofD1Y=;
        b=ZBTfLYZnd9EtqK/Lsa6gHAQuqd4zBns26sOaxZS4LPKNAUZz1b1mdib7G8OcBPR+vQ
         WEbJOp1b0BgnyTveq4brRwFwwGgARLRknX6Msp42FSABgpvI77db3+zsk/tCDogt/cg3
         4evBxFumGjInubiLPWwFM4VCDZ5REItYuga5LpZ0kEIbgQhXWCDddYFKM9i8FqrC2T+p
         /akUqnzJwo4QXe7tTpiO3K8dkTl2Yxi2kMkp5q+OacUpjsnqOWulda266bUr3Mhpto/D
         ZmR7ys1bwOjZyjz5FoBsU+be23qknpI3SgKGMaIEwvU4Q/ITlGXQiFzDQixfHOcUQ5Nx
         3v/w==
X-Gm-Message-State: AOJu0Yz5Ab6jBAIay5ux95IXTWDdbSnFQAXerLUxtTtofWzRiBo/2lEU
	xxk6bUm4aMn6iJEhYbmIm67L52kiVNodicmwzK7RpCrQC/Jy
X-Google-Smtp-Source: AGHT+IGNsvR7puufHhdh8BMcPQbS0gnnOxM0dRuq29mQYdK8iwWzGA1wLv0fQE2MxP5JUCfTd+Ie7pgIvAzCeOBeYqE=
X-Received: by 2002:a05:6870:1b8e:b0:203:ea22:4d98 with SMTP id
 hm14-20020a0568701b8e00b00203ea224d98mr235952oab.87.1704863412576; Tue, 09
 Jan 2024 21:10:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109154547.1839886-1-jeffxu@chromium.org> <202401091144.2C203AA7@keescook>
In-Reply-To: <202401091144.2C203AA7@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 9 Jan 2024 21:10:01 -0800
Message-ID: <CABi2SkVGW5n0NJqa_1RHnXt=GEizm0ixvGiu+F_mStFwx7pjQw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/4] Introduce mseal()
To: Kees Cook <keescook@chromium.org>
Cc: akpm@linux-foundation.org, jannh@google.com, sroettger@google.com, 
	willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 11:47=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Tue, Jan 09, 2024 at 03:45:38PM +0000, jeffxu@chromium.org wrote:
> > This patchset proposes a new mseal() syscall for the Linux kernel.
>
> Thanks for continuing to work on this! Given Linus's general approval
> on the v4, I think this series can also drop the "RFC" part -- this code
> is looking to land. :)
>
OK.

> Since we're in the merge window right now, it'll likely be a couple
> weeks before akpm will consider putting this in -next. But given timing,
> this means it'll have a long time to bake in -next, which is good.
>
Thanks for the heads up.
-Jeff

> -Kees

>
> --
> Kees Cook

