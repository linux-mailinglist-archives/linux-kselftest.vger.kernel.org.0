Return-Path: <linux-kselftest+bounces-25019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60511A1A746
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 16:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD0D3AD36E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 15:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E4921322B;
	Thu, 23 Jan 2025 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bFFqU0IR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133D7212B29
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737647237; cv=none; b=hWAl9fCBEqZWf+FgEjx27U1WH0sLVAMLeBYCmdeYhZm8C6pzDcWzFEx+Z2gU82M75h2yptGqpjmZw3BCNfhkhid9vm4R87KhedADH3sN2M+o+2UgVTYyU0egWp8t4b5kC/MGzGh2ZEBMmUohM994WYzot0DjN+FM7LLvYwkykmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737647237; c=relaxed/simple;
	bh=C+6VTFf4oQZgdC2iMUDsKcOtxuNkydWnEcm+CAZfMB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqlgzUYcZSCk1qb3yUorJXZKzh56aDw+7UZ47+X93O2VJr/wUeA0vIM7ByOhKBxdOdHv+ACpdxD26tJX9D0OwGsvuZ5c2X0mq4b2pxHesjiCFdbpeThARStROPA13AJd3b81z6+q6eFVLptarHy4CbxhoNX3zFq12Gg//7Bedgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bFFqU0IR; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaedd529ba1so164885366b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 07:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737647233; x=1738252033; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5c1ACikcoZvFxPEfQa5a/N07yqND3XkMMWgBnWWCeno=;
        b=bFFqU0IRjNdMUzRSXVh5rZzD3xarGo19WaJryyrrcDl2885rAV2LbOZh6NUaUVzk70
         iIj2uL9Vsec/eU70OwZt/2tzQE7iOpI/r60kFaauGOiz2RC06P9jX72noBGEWp7K/9uP
         gCDq4+7CamW29YDsSI2zYEuKZNfPKDuuiUk9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737647233; x=1738252033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5c1ACikcoZvFxPEfQa5a/N07yqND3XkMMWgBnWWCeno=;
        b=dg/SLanZ9DWi/zeKuLef63Oeg8t6vqXQ+zxC1bIf0MHv4xFqp5oTAFdef0z4YyHoDH
         LgZFrUXkz1HyZ7jjv4SzR6bjWZQlMlk1x22Uo2ZknJFA4M1Z1dqBuWyz3K64uWoRHycE
         sUWEN0i3XssDUck8ekfFTaTs9J4h9vtDCVMAhADe3jgZu9hzGDnFYYsWyH9FnPy1PF/Y
         zq5m4I9Y6E4xOEFhLG5sObAUg1xKgganpzuPnAfIuR4Rm3Da+OAC4gqdWhKH/CDE6uIl
         r4cZ9AwBPLHMDgxNudI1+ZVkIrnQASqA+lWj+9L78rwxVAIV0UhRs45D+DiR+zdYH2s+
         tWxw==
X-Forwarded-Encrypted: i=1; AJvYcCWYgXMIla5Yjuwtr9ZtCxdw2rd/Ikidn8qRSiootCxNpXsLx/5Bobm8F2Qzcli4UAXXkGkqCsR3mMYR6Wo6XO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnfaClt+i57Ti0R/VCoowKBw9UvBOLyozdEPiyR4pxOoTKjy1w
	BX7GrIbO6xo0C6NhufDrhPzWT3e+vHyXfLwrsRMO3ALKL5shM9azzBsmRJmIE3GecMufRH7VRk3
	jOsA=
X-Gm-Gg: ASbGncs4DR1vWYzdOJtiz2yC98Zy+oFo84KbtpWL2e6ZC0Y97SIy+hmjcubHh7QpYKv
	PQSuwyodGMPutdwasxwytbQztoj/G57i+cj6gb5fhxEoaz5CL4hUdRHScwGrgxVZTp0WECAVQcc
	WGlUNhhxe9Tezca593d9sE6VfYVLJGrOjVw9OKMOmEnkuV+cbbMXmgs0qVGooANKTz5htr+FeKd
	7myw1YBxoDhUvO6mCT73yBo/ODYkK0MH/pMiFMri/2lMqto65dNqDxH3l7r4PGEc4m/N+x7rddP
	cmwRvGhZYfCOkqh/wA6EkOdmyMtip9K9gPvvhuSfUBYqllXuO6nDdw==
X-Google-Smtp-Source: AGHT+IEXDH1FqbkC5rWUOH7HqBR7LAH7GSQlub0ijk7/XUTLeBfu0HojtU667K8ZZH3DDVAzZFsa0g==
X-Received: by 2002:a05:6402:849:b0:5d9:857e:b259 with SMTP id 4fb4d7f45d1cf-5db7db2becemr55685721a12.31.1737647232959;
        Thu, 23 Jan 2025 07:47:12 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f8442esm1077912566b.129.2025.01.23.07.47.11
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 07:47:11 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so1612510a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 07:47:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWCZ0HUFTczOkp0csfyMWYNm+zR21U7eu8hGP15kgBbvhor723YUqpT0mqdEQWxqICiNDB/1m0qJ2cvoGsvpI=@vger.kernel.org
X-Received: by 2002:a05:6402:3595:b0:5db:f4fc:8a08 with SMTP id
 4fb4d7f45d1cf-5dbf4fc8bf6mr18353711a12.6.1737647230858; Thu, 23 Jan 2025
 07:47:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123135342.1468787-1-vignesh.raman@collabora.com> <20250123135342.1468787-6-vignesh.raman@collabora.com>
In-Reply-To: <20250123135342.1468787-6-vignesh.raman@collabora.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Thu, 23 Jan 2025 07:46:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWcw-aPcMvWYqJDqxopPYXnPnVgFYAUSkvkRPTjO83uQ@mail.gmail.com>
X-Gm-Features: AWEUYZkvzfVO2hileHLKdeINWEzbU9zhoxsfXAWcm9kmxXjIcn6s0um9krEKyaE
Message-ID: <CAHk-=wiWcw-aPcMvWYqJDqxopPYXnPnVgFYAUSkvkRPTjO83uQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] kci-gitlab: docs: Add images
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: kernelci@lists.linux.dev, linuxtv-ci@linuxtv.org, 
	dave.pigott@collabora.com, mripard@kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, 
	gustavo.padovan@collabora.com, pawiecz@collabora.com, spbnick@gmail.com, 
	tales.aparecida@gmail.com, workflows@vger.kernel.org, 
	skhan@linuxfoundation.org, kunit-dev@googlegroups.com, 
	nfraprado@collabora.com, davidgow@google.com, cocci@inria.fr, 
	Julia.Lawall@inria.fr, laura.nao@collabora.com, kernel@collabora.com, 
	gregkh@linuxfoundation.org, daniels@collabora.com, helen.koike@collabora.com, 
	shreeya.patel@collabora.com, denys.f@collabora.com, 
	nicolas.dufresne@collabora.com, louis.chauvet@bootlin.com, 
	hamohammed.sa@gmail.com, melissa.srw@gmail.com, simona@ffwll.ch, 
	airlied@gmail.com, Tim.Bird@sony.com, laurent.pinchart@ideasonboard.com, 
	broonie@kernel.org, leobras.c@gmail.com, groeck@google.com, 
	rdunlap@infradead.org, geert@linux-m68k.org, michel.daenzer@mailbox.org, 
	sakari.ailus@iki.fi, jarkko@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Jan 2025 at 05:56, Vignesh Raman <vignesh.raman@collabora.com> wrote:
>
>  Documentation/ci/gitlab-ci/images/drm-vkms.png | Bin 0 -> 73810 bytes
>  .../ci/gitlab-ci/images/job-matrix.png         | Bin 0 -> 20000 bytes
>  .../ci/gitlab-ci/images/new-project-runner.png | Bin 0 -> 607737 bytes
>  .../ci/gitlab-ci/images/pipelines-on-push.png  | Bin 0 -> 532143 bytes
>  .../ci/gitlab-ci/images/the-pipeline.png       | Bin 0 -> 62464 bytes
>  .../ci/gitlab-ci/images/variables.png          | Bin 0 -> 277518 bytes


This seems excessive.

We have a few images in the tree, but they tend to be either the
penguin logo or various source SVGs.

Not a set of random screenshots or whatever.

         Linus

