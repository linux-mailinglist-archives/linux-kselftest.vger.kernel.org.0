Return-Path: <linux-kselftest+bounces-38812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296B9B23DEA
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 03:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E0A6E67E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 01:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E490199223;
	Wed, 13 Aug 2025 01:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDmca9Pq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430D013BC0C;
	Wed, 13 Aug 2025 01:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755049784; cv=none; b=rr+DL86/1enSOlWGO4qT+ZPLo48QDPDHZ3qkZE95/cWJ+9Aze5CKSct2Y3iFv91MD7OLZ+ADV7Z7DhG+faTvG7k7EYTZ8wXrzql+FCB/F1CVxR+EHI0NpAVLQweGkV2msRiABC59xPIMPkdTy8uhnSOR43Zppj2s9Ze/QIM36WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755049784; c=relaxed/simple;
	bh=dPOWDZ5li1du9dNQ6jbMsqrTaDrZLreTRbx8e97neT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3cQ4DLwB+SDb7He15wP2VCQ52yyslrUuiGFjchk0Zszvn4OfbNSiisINApY4EfivEjw3Kykq9kvVzvI0zI4a3LQEbTAcU3hh6Q4fW67omhqN8BrJI+G5yqKbEPrKKJuw9L3lcU4gfOzgC3m//Brcnl276exWTo0fF8Kch5MxB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDmca9Pq; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-61bc97d9c28so87988eaf.0;
        Tue, 12 Aug 2025 18:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755049781; x=1755654581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aql2mwv9JTABH+xYsNRLchplJ9jbZwWvArEPle7Cru8=;
        b=CDmca9PqTy0ivU/K0cZXpLm1fuLgyKEXuuw88+I/xsQbYoBtbftwiinSoqitozuKsj
         NbkdqcO97SZWD0lZ5HyKIPc+C7oC0RJWm+BMU2ZC6r4M/i8Hx4dt2zFOFxcSR1PaBbYJ
         m6nDY3tQvjT9wEjpC6NYXztbHcJxaV2w5mkHsPVI892uHB+6ABa8lgd53m28pZLV5qBG
         r91gHET/WliRHHwTgFzutKhdgyB/u5qsD1Hn/LW9ZMF7xXyrFvBY+Mum4EHeX2lpVftM
         wfSNg7n/IRWhqwwzZGxAFsq4SK4KE+N1F0qCAxFnB/o9VzGbk7wI/ceN5NXprIOTjzCI
         8m4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755049781; x=1755654581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aql2mwv9JTABH+xYsNRLchplJ9jbZwWvArEPle7Cru8=;
        b=km5w4J8Idz0T8D6KuFGSaAp3377So26HZ/swBaqJyU5wGqWbi9ybwA+klPXa2MLryW
         dMQzNsBFJGjfwiZH5xT1DKIPRkPyj1OoeOBXQ+Ia9Nkg9/RJdgXxNqUBvp92B6MUm7x5
         3K3xhcCbD7wuEMkxLbpkx0dy3Bk06aiuwxusM5Q5DrgvjCol2Wj/jbyZKt6tkh+v2K+w
         f0730tXogkrxCXAd3mvOznYMauRUwe2vM4osoDQk032St2IAPaqsrXekyBzM0WFUA+tZ
         +FRxamD7NP2fm0cyzsCbRjP5sKgAP7IGaq+wUvU5AzvgJKFYtySeJjyLM8Kb+BeH8oTM
         Gwow==
X-Forwarded-Encrypted: i=1; AJvYcCX0bZB3aukM3RJOtlsA9yX5siPgSxiIOcHevNBnX6Cx50ipHBaK6oRymFoHcIBse+OYyEbMax/lugHXbt3iYiMx@vger.kernel.org, AJvYcCX7pxy26rB/qJHjvmd6/dL3N76KgFTlF+jyvNkkyWnHFEWSvhxHIZpsPwGzu2qt7yWwcc8mvfOhgPHiU/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxk3UIfWHzEDn3EOtF0mGpjzntcLiUqoCTBjMKpmfEKHAFGpIK
	ws06GNjmFKUIa6SfOvenwPKSR8HN9Osm7lTJfBDL4vstZpPyxoL8w3FBQdzL92H79m+A0NSelmR
	CtYt3ZykCPwfwGIVVsE/oKcLHiypYuecWIuwxeS/fSg==
X-Gm-Gg: ASbGncu3pUZzZCBdJFl71r0EvoyJrdIdthQsH1j99nX+gkbirhkSNs7BCU8inGOtlDc
	8Jbfr8grLpjjoCEy7AFqKb4H+2KyivQjjL3ore0xPYGcmU9o+Wr4UF4BavW9QCqSoRt19lvGdOj
	Xc3BKPF12Xn4gdiffqBsGHPkKni+GkirCuVM+k24vIiRuMyUfbDec8csmeqjm+zVq1YyneHFU4E
	dps
X-Google-Smtp-Source: AGHT+IE1J0i1gE3lpjE8L3r6M3x9LWFRM4yO8xP7DHLQDKGQcNPsPKYKJZsVHZVkCkUSbZlkd0WOpEdDB5+y8llfm/M=
X-Received: by 2002:a05:6870:80cf:b0:30b:6fa2:6974 with SMTP id
 586e51a60fabf-30cb59e360cmr834687fac.3.1755049781191; Tue, 12 Aug 2025
 18:49:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABFDxMEQYx7fdx4T7meUb01FoqJaHcW_2RoYnBwJ8GzmJTexzQ@mail.gmail.com>
 <20250812172001.57104-1-sj@kernel.org>
In-Reply-To: <20250812172001.57104-1-sj@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Wed, 13 Aug 2025 10:49:30 +0900
X-Gm-Features: Ac12FXx-U5LfozvxZM7PlT1XRtOr9ed905rkP1AtucJXvK8shutEgO6eRp4XuMg
Message-ID: <CABFDxMHjYDZDf6cObeKMSWmh2p-eYy_Nggzg9FK9HOXB-Pvpeg@mail.gmail.com>
Subject: Re: [PATCH] selftests/damon: fix damon selftests by installing _common.sh
To: SeongJae Park <sj@kernel.org>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>, Shuah Khan <shuah@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Enze Li <lienze@kylinos.cn>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 2:20=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Tue, 12 Aug 2025 22:27:00 +0900 Sang-Heon Jeon <ekffu200098@gmail.com>=
 wrote:
>
> > Hello, Alexandre
> >
> > On Tue, Aug 12, 2025 at 9:32=E2=80=AFPM Sang-Heon Jeon <ekffu200098@gma=
il.com> wrote:
> > >
> > > Hello, Alexandre
> > >
> > > On Tue, Aug 12, 2025 at 5:13=E2=80=AFPM Alexandre Ghiti <alexghiti@ri=
vosinc.com> wrote:
> > > >
> > > > _common.sh was recently introduced but is not installed and then
> > > > triggers an error when trying to run the damon selftests:
> > > >
> > > > selftests: damon: sysfs.sh
> > > > ./sysfs.sh: line 4: _common.sh: No such file or directory
> > > >
> > > > Install this file to avoid this error.
> > >
> > > I tried to reproduce those error with my vm environment but I failed;
> > > with my workaround test method, it doesn't exist.
> > > If you're okay, could you please tell me line by line how you execute
> > > tests in what environment?
> > > I'm also struggling with the test environment, as well.
> >
> > I succeeded to reproduce and also check that this patch removes those e=
rrors.
> >
> > > > Fixes: 511914506d19 ("selftests/damon: introduce _common.sh to host=
 shared function")
> > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > ---
> >
> > Tested-by: Sang-Heon Jeon <ekffu200098@gmail.com>
>
> Thank you, Sang-Heon :)
>
> [...]
> > > > ---
> > > > base-commit: 2754d549af31f8f029f02d02cd8e574676229b3d
> > >
> > > Does this commit exist in `mm-new` or `damon-next`?  I failed to setu=
p
> > > the same base-commit environment.
> >
> > However, I'm still not sure that this patch is in the correct
> > baseline. maybe it will not cause any problems with the merge
> > though... but I'm not sure. So I didn't add a reviewed-by tag.
>
> I think unclear baseline of a patch shouldn't be a blocker of Reviewed-by=
 tags.
> Since most DAMON patches are recommended to use mm-new[1], as long as the=
 patch
> can cleanly applied on latest mm-new and you don't see anything wrong, I =
think
> you can assume it is based on mm-new.
>
> [1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile=
.html#scm-trees

Thanks for the notice! I'll keep that in mind. And also thank you for
always being kind.

>
> Thanks,
> SJ
>
> [...]

Best Regards.
Sang-Heon Jeon

