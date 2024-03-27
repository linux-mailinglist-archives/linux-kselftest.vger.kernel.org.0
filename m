Return-Path: <linux-kselftest+bounces-6750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BC988F334
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 00:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9581C25C27
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 23:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB044152505;
	Wed, 27 Mar 2024 23:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jY01f4+q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FD8152E18
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Mar 2024 23:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711582355; cv=none; b=qUScAeia74hzmoQvpEhQYkkA5KymjgVgWPNydYgHb0mxln6s2xfBeOeAwbdzbKTaIE6GoomxRsmlqSffz9mrv8jr07vAGpdVTnjH/JZQRlQY8QEHsCiVoufxtYOyzLL+yzYrvPbRo0p0NMlz2vnqx9Y83TKHfsbq0rRMzrgspXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711582355; c=relaxed/simple;
	bh=4lKPLbh212nn1J3R8IMqlEWT8QVsO3oW2MM/iClklVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCLugdIRCmo9wxl5d++hcrSyrLMDP6KdkCP9nIkAWWq5ahhZh3xa6U/mlGxb5G6s0ti2s2ravmo1luQWlriry0xx0eTLxrxkqmSJ6DlUMSh9MJL26aBqOmPEJtXHoSTLhZHhGkKJTaLa+cFZgQKwrFT2jENr8mBz6wmpovPfwrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jY01f4+q; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-428405a0205so85801cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Mar 2024 16:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711582353; x=1712187153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzRgd4Lzb951VCLO81xH04jUHM3EgKoI1UuVp5UFbtA=;
        b=jY01f4+qWD71l2GInHO8UA+d9jBvS5Dvkq9nudrptIGytrtlrP1x3HPMf5orfVWAFt
         BuG9MKrPYop/dhzxzZs7pCwkUW8kHhxh00J95EChtL5qmtVa1pbXTQNqMOZezcjZCxvC
         2IeADjgezEj44KrFMD8MVngu1tDIKoLf/OvVwCE6BZiGPzZn6k8B54ok0zp6VYHr99a2
         1jh0UGELxsb0VMNgxNAiaxa6wkK8RhN9IxxhxZCBBvyebFHaxIy5dDR6q41SoyjE4bdK
         88R9TLJ/tFJTnsOleOeUXMpk21Ml2VAWvuLoYi1qZX5eJN4yNCFHxc3UwL25SoT6xDYu
         O6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711582353; x=1712187153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzRgd4Lzb951VCLO81xH04jUHM3EgKoI1UuVp5UFbtA=;
        b=jdpFuYQ8jwJSezhy58Nt0GEuoqw/3XsivLzRhPIKm9Sjrj5CKo10MJq9THpEK4FOzP
         hMFXUsLReq+zs+Unn5EtW4Ay5ry/pgJYPy1TOvgpJJEUuJW9rkILGMTGrMi4lOYl7wbA
         QZVJ2TOEiFnHud2LYboOJXuXpaBQvOqZDqycN6D+85AGaO16CQIoDINuWIiWpshIHmcN
         fn3pgUURbW7+p2JWYAGR9CrI2m5d7dgS41WgiR+8YUZ6G99igMCwO+Zj0hbVuCe1qKVP
         SxBmLKueDQRcrjXNXYwI91bav4O6cDdxtCyeiFv2KBDy3DWSPI+aBUq0NJexHZdHp9aV
         VNnw==
X-Forwarded-Encrypted: i=1; AJvYcCXGK/S4cyeftGrlhOG/FBJsCYULcFqSRkUH+/lW12NEAsZQX5dbLuHTMfjlecBjeL0aoGrRmzY5fZrOFs/THMIgTY1TS3brHki1sKz9IcSx
X-Gm-Message-State: AOJu0YyvpycjyMbewuye9jMdZs4zBgs/cPFQhGWcPyge3SDzeYNrLGah
	UuoW9fn7S353dvl0SunQIzfywtj/dsmZgenj71sfdyc13Y4UHfXLdR59sulyoQQACY0VinCR905
	Ue9x7ETlienV7fMpc2NwNe2UdiErK0bVNJ5Ui
X-Google-Smtp-Source: AGHT+IH3l1ArfOaKqAb+rx+5i3b79wDzfvkqQHOHsJaPejnm3xgjV3o8I7pfl2e/3FeBq1yfYGAUUUedO2D5/mlX5QI=
X-Received: by 2002:a05:622a:5c99:b0:431:5aa3:313f with SMTP id
 ge25-20020a05622a5c9900b004315aa3313fmr57222qtb.11.1711582353081; Wed, 27 Mar
 2024 16:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326100740.178594-1-davidgow@google.com>
In-Reply-To: <20240326100740.178594-1-davidgow@google.com>
From: Rae Moar <rmoar@google.com>
Date: Wed, 27 Mar 2024 19:32:20 -0400
Message-ID: <CA+GJov6wuRDu2JiUsw0qtWehpbUPnxM=fK-dJxVMtOr0TejP+A@mail.gmail.com>
Subject: Re: [PATCH] kunit: configs: Enable CONFIG_DAMON_DBGFS_DEPRECATED for --alltests
To: David Gow <davidgow@google.com>
Cc: SeongJae Park <sj@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Johannes Berg <johannes.berg@intel.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 6:07=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> This is required, as CONFIG_DAMON_DEBUGFS is enabled, and --alltests UML
> builds will fail due to the missing config option otherwise.
>
> Fixes: f4cba4bf6777 ("mm/damon: rename CONFIG_DAMON_DBGFS to DAMON_DBGFS_=
DEPRECATED")
> Signed-off-by: David Gow <davidgow@google.com>

Hello!

This looks good to me. And it takes away the issue with
CONFIG_DAMON_DBGFS. But since this is deprecated now, should we move
to the DAMON sysfs tests instead in the future? No need to let that
stall this patch though.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>
> This is breaking all UML alltests builds, so we'd like to fix it sooner
> rather than later. SeongJae, would you rather take this yourself, or can
> we push it alongside any other KUnit fixes?
>
> Johannes: Does this conflict with the CONFIG_NETDEVICES / CONFIG_WLAN
> fixes to all_tests.config? I'd assume not, but I'm happy to take them
> via KUnit if you'd prefer anyway.
>
> Thanks,
> -- David
>
> ---
>  tools/testing/kunit/configs/all_tests.config | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing=
/kunit/configs/all_tests.config
> index aa5ec149f96c..f388742cf266 100644
> --- a/tools/testing/kunit/configs/all_tests.config
> +++ b/tools/testing/kunit/configs/all_tests.config
> @@ -38,6 +38,7 @@ CONFIG_DAMON_VADDR=3Dy
>  CONFIG_DAMON_PADDR=3Dy
>  CONFIG_DEBUG_FS=3Dy
>  CONFIG_DAMON_DBGFS=3Dy
> +CONFIG_DAMON_DBGFS_DEPRECATED=3Dy
>
>  CONFIG_REGMAP_BUILD=3Dy
>
> --
> 2.44.0.396.g6e790dbe36-goog
>

