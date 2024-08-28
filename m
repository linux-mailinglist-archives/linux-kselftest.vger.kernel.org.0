Return-Path: <linux-kselftest+bounces-16639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CF696367E
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 01:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3468B1F22CAB
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 23:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146DF1AC89F;
	Wed, 28 Aug 2024 23:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRovZ2ru"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44060165EE4;
	Wed, 28 Aug 2024 23:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724889290; cv=none; b=KWJxfCGzF0aO6/RxqyH6qOKg66PoXJ+7aQzMgfuzCehosYRGojGlN9TTmovBVQb2jVf9GsHqtb4QMhV/1q8eMMaFmHp4o2ghrfYUPR1Ono0QtHd7BzYyXMJE+zzuNdzqSVklJ4jg/eePI4+Iusj6KiChCPKrOq1xlWZe7Ei2vks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724889290; c=relaxed/simple;
	bh=8VSOcFdfDv6f9/k5iOXaUzEb2pcQtBEwynE7I7i2sxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ir2F00ph3TNS2/sZ7wkw8PkcEmNdIOLwSB/tL/+7lPvk4zqX0KC5SVRxB+ln3rPwZThF02y0fmFsnpNeJyWj/nNGzJ3nzdl/eDEaA0cS5D0cvOAp14Tl2099blLbRFUBywG1q2Qqp4/gb2mMAKn7fmy+neslbyTJ107re+kzBUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRovZ2ru; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82a13d1c8f9so5532539f.1;
        Wed, 28 Aug 2024 16:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724889286; x=1725494086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VSOcFdfDv6f9/k5iOXaUzEb2pcQtBEwynE7I7i2sxo=;
        b=lRovZ2ruJM3JvWkg7yE3ahUf9R/B+DiUjqBdeiVvLs+zygF5vR/a3Xo+20RCmyds9e
         Bi636jK8S9xuypxfZAM18slaD11IYLrBOXCyh/Vl2vxJx2z1pHmfYyM9zv78uRMQY0H3
         aw0F5uQXRkck6gWSwjdAjlqA535KDLViatTzB7JNU8LIoE9GH+ZKWJuXH/cw0KOQoass
         sw4S9HGatvQcW5Tj0pltrXUfIXz9Yg4ENyci4AaQR3BbpBrQXQJiJYposJYYnVuoMlWC
         l0dKN4QZEkUxVhL+IG+VP5toEjQqpmVOtk/8+R8knvfbVs0CkWZ9HH/GzN1GaGn0vAN4
         NC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724889286; x=1725494086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VSOcFdfDv6f9/k5iOXaUzEb2pcQtBEwynE7I7i2sxo=;
        b=ok+Lvu94EzRlvwaD/ZQsCgOB+tqAnsJr5tDEifjtNgndJy5abJ5d+imyW+zjhNdyj6
         ozKOGQ5edTGjwk8DYiCpysju5WUJ1R2vz6Zst3fFhOtl8Xlkq+Vd7aQAvVN0RfJ7K9F0
         G64DglaVzTZE9ScJyXJyfD7ECjt+naVQ7vGswnE0wK12ASXkeWTk9K+aKYe+pwFEWwTt
         qMg5Kz1a11laIfF58lLTZU4tT0c++JRIiNq2U4CEd/eKrUXLW8+uVT1J/HAJGbC+2C/r
         sMo8c7oM4hh1oVCLrQ1YVqP3CvnU4akrL/6CH97UDG0O9X6E8FXfIwmQGqliNrYpYFmF
         Hxtg==
X-Forwarded-Encrypted: i=1; AJvYcCWlO7HXeQwwYP7nhvqSrmKcms1t+zJSbUJCRwxfPV/LIEO80Z+Wp18zLhBzmhnpq4D30BcyLoaG+3UB+ksS/3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW+GQdNAW3Kw/BZYivyxNxn8IDj6QUdG9WB/J07s8RGAXcq3vu
	GHRqeBLArVebnq468/Doy+l9KdRO4gNQlJjuOzS9Jl1Pqjn36/gTa5LokYWnzY44KiYt3q0H6N7
	bcJuq/uiZmITVHOT/99nnjj0S/ig=
X-Google-Smtp-Source: AGHT+IH0gQ4BAb2ZIkcy7Eklko6P1H0eoe2g9ZfiheeJfyikHZWxBQfymE8TB4mXd6Z/K+aUodo5hl8ZuzWvF5Puj7I=
X-Received: by 2002:a05:6e02:1a45:b0:395:e85e:f30d with SMTP id
 e9e14a558f8ab-39f377cb2e2mr16942645ab.2.1724889286272; Wed, 28 Aug 2024
 16:54:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828183752.660267-1-jmaloy@redhat.com> <20240828183752.660267-2-jmaloy@redhat.com>
In-Reply-To: <20240828183752.660267-2-jmaloy@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 29 Aug 2024 07:54:08 +0800
Message-ID: <CAL+tcoDHFyARbonRxv=kKiywgbqci=TKeYiCWmQ8R2jAkek-Gg@mail.gmail.com>
Subject: Re: [net-next, v3 1/2] tcp: add SO_PEEK_OFF socket option tor TCPv6
To: jmaloy@redhat.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com, 
	lvivier@redhat.com, dgibson@redhat.com, eric.dumazet@gmail.com, 
	edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 2:38=E2=80=AFAM <jmaloy@redhat.com> wrote:
>
> From: Jon Maloy <jmaloy@redhat.com>
>
> When doing further testing of the recently added SO_PEEK_OFF feature
> for TCP I realized I had omitted to add it for TCP/IPv6.
>
> I do that here.
>
> Fixes: 05ea491641d3 ("tcp: add support for SO_PEEK_OFF socket option")
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> Tested-by: Stefano Brivio <sbrivio@redhat.com>
> Signed-off-by: Jon Maloy <jmaloy@redhat.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

