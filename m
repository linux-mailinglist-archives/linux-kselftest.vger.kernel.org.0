Return-Path: <linux-kselftest+bounces-3496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA50483B579
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 00:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F03E6B2080C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 23:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABE1136662;
	Wed, 24 Jan 2024 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="cTbN8dia"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E71313664A
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 23:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706138056; cv=none; b=SfnpxUXZBIrgzILh4KwB1zEjdN+FzKh1EKASuPP0Z/u7HgDW6IQGAuinkfsw8mCKJYDKOvSwHSGbEyygqZ1CcUju/Bn9dwlJzspSV3+H1Xi3ZORjJ5V2PMZptHgZs9WFuLM40D4P61ve0XlRT9CDmDhLf+JHRchhpiKUhm5hDiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706138056; c=relaxed/simple;
	bh=RL1FPGFx97vdxv8Lfa1KUrrT8VXdTufY9VgzHnoZztk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snQPhEveofPFFoOS49R4KBOT74w6VlaoZh+BBUTNHGluR7VwqwLXNJadYjrq9V4HMWLN+sKBG1+3AxJ04zvxf/KDn38rTEY3p7CmcguvSvKl791CqFuNFMLBqisGN1kxRb7SgP/OnIcgwvNfIaGOCHJsG8Yjp5WoNOX5a5Nhjps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=cTbN8dia; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bc32b0fdadso285218339f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 15:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706138052; x=1706742852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rzq4IXd4HXuOrpuiNgMIMKbhN5u0gdDI1Cp6D3KRaEc=;
        b=cTbN8diaKTeW025xYlqgK50yqpP7jh7Or+AGa+p1B5XbsUE4CNHnSlFYh4adYm7l5q
         CYKE/v9qXVIkPqcbWuJ4oSNGx/RFDD8MKPge+kIagbXDkRvty744ed5/0ZjJnez50Y9f
         LjNsobYYthT0p3vFQaIyBiVk4Blw9iGAXX9CsY0ozq3tqYcuK1XKyZ9HgpLa6zJRhK9X
         qvVsstF7dolpGQX9RkeawFqkZ5G4WciDDrd6nQ0cYkurbQkZmOmYO+kA4gtZbbtixPyJ
         j7JjzcdTkGlKbM7uDNkvTp/ZR48E1gI6/qDQ43inF+BAL2ChGFPjjCzgzdEF7HZIhBhO
         4TTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706138052; x=1706742852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rzq4IXd4HXuOrpuiNgMIMKbhN5u0gdDI1Cp6D3KRaEc=;
        b=V1uMvvWZRZOo38yjHad6ijV3p5f6imuRMsFculSiOpJTXVluCrvQ5Y9C6qCvZWPrTL
         WIaelghV6PJujanirbVw05lIZiQb07TqT1jghafirltoAFjtDdmVdpRJMdxg+rHfPE+5
         rnfy35T+Z5/IdTXhSTRx/F0G3kvWm5bat9SfBjJ59kIVJy6e5xIxfhXxO9tK9XEmwxK4
         7r7HxYHW7lI9uTGSeYMfMkMUO3jMTE+FMeqAdZvPAgFGW+nXQ4skPjTMr9DhPcpi8Qjr
         WPlUOT9Kzb506Aim72lUNPZqFB/zBsX9JdvM9gK45WTfNS6IO9PumdvO+0aUaWfwaL8q
         ZfFg==
X-Gm-Message-State: AOJu0YwAOBeQt8KfGpMja2+BAyu0VvZndjRsjPd8nvNeZ6Lcxm9ldARZ
	kj+sy8Ne/UcCcrXpBnp7Jj+GRtBOjPyMTkqA3ZJPLMTOPxwKVGLZU6pA/jgXOAVn5vAJcNnEs1Q
	uA0b9OLN9Gu0Id9zh6znAnZPgkD6W7Q602CN4
X-Google-Smtp-Source: AGHT+IEXXopI18+SvzNJ4aBmsQG4SsHXjOJ3gep0MqsEIFoyePoRbQekeBjAEitxSJ5J2kCUMHZC+cOdpFHQ835LP5Q=
X-Received: by 2002:a05:6e02:923:b0:361:989e:b09 with SMTP id
 o3-20020a056e02092300b00361989e0b09mr163478ilt.83.1706138052517; Wed, 24 Jan
 2024 15:14:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124181933.75724-1-pctammela@mojatatu.com>
In-Reply-To: <20240124181933.75724-1-pctammela@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 24 Jan 2024 18:14:01 -0500
Message-ID: <CAM0EoMkocaasvDNZNim-mDjtEY72BJ-MP=db92oUTP+9PU=4DA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/5] selftests: tc-testing: misc changes for tdc
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	shuah@kernel.org, kuba@kernel.org, vladimir.oltean@nxp.com, 
	dcaratti@redhat.com, edumazet@google.com, pabeni@redhat.com, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 1:19=E2=80=AFPM Pedro Tammela <pctammela@mojatatu.c=
om> wrote:
>
> Patches 1 and 3 are fixes for tdc that were discovered when running it
> using defconfig + tc-testing config and against the latest iproute2.
>
> Patch 2 improves the taprio tests.
>
> Patch 4 enables all tdc tests.
>
> Patch 5 fixes the return code of tdc for when a test fails
> setup/teardown.
>
> v1->v2: Suggestions by Davide
>

For the patchset
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> Pedro Tammela (5):
>   selftests: tc-testing: add missing netfilter config
>   selftests: tc-testing: check if 'jq' is available in taprio tests
>   selftests: tc-testing: adjust fq test to latest iproute2
>   selftests: tc-testing: enable all tdc tests
>   selftests: tc-testing: return fail if a test fails in setup/teardown
>
>  tools/testing/selftests/tc-testing/config                      | 1 +
>  tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json     | 2 +-
>  tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json | 2 ++
>  tools/testing/selftests/tc-testing/tdc.py                      | 2 +-
>  tools/testing/selftests/tc-testing/tdc.sh                      | 3 +--
>  5 files changed, 6 insertions(+), 4 deletions(-)
>
> --
> 2.40.1
>

