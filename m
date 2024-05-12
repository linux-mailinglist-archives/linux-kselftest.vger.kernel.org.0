Return-Path: <linux-kselftest+bounces-10121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 702AE8C3915
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 01:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A160F1C20B8A
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 May 2024 23:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF6C58236;
	Sun, 12 May 2024 23:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlBZkzZ2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31C828F5;
	Sun, 12 May 2024 23:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715554935; cv=none; b=O56MfMv1qcgO90nQtmUEjFAcyTfPm/lNBh3OaQUkICehpxtgUh+HUjLbN6f6HG4W9Nhh0MXpiKgGECwd3mATcv8Ud1THRb/UyYxvlwUEQwZA2cxAWTP6JFrfTg2X+Fr4VVz3gtbX078e5cyR4jQA7yogkKz/OhJXOwP87sCmgco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715554935; c=relaxed/simple;
	bh=7udT6qLvopAeaypjxx8J/SouJi3l8PPYFlZf9HVhP6o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hPpmImIRUNfZQHV7bteV5DeimaMu0udET8TefEWz2OTgWdOq0C44j2ng6IUln/18JLQOX1NrFekm22Ah3DYSwO6alZwmEbb1VtdYMYjcCvc2mTacD0BK/hFVgWe9cBCis/WxZVuAVNVzsbtvk3MknzI/J24Q0rkb+jfVC3WpI4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlBZkzZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA813C116B1;
	Sun, 12 May 2024 23:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715554934;
	bh=7udT6qLvopAeaypjxx8J/SouJi3l8PPYFlZf9HVhP6o=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=WlBZkzZ217pP8/OkgZY/Ko8q10sIwbKgd7uOtu7+vv19TcTy3WJzMQDRpOXolHlPC
	 Hg+ppbCLH1UsaMFGkke80zWIQ/6uNl4W7qrdRhWqV1w215nhIvnvajOgu3b5D3uldr
	 3MNz2ALgrCLZqi1IZxg2cTPKBJA8JQL9LuchkHKGETpw44AU+iHHCGqy0GsOc5SsZc
	 4VliMSpgulzTyQGJqjW+u7UlZlqjiuf8TdWcbDHMFdun7Dy9PDFJigRsM9JQggkE7X
	 9k0O9jCL8LsMM+kU2OL4kATzxDIwlpc2sAgIOaO6x6z8A6j7oWjCwbF7PMLcRh1a6p
	 7NtXka2qMjJAA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 May 2024 02:02:10 +0300
Message-Id: <D181GV24ULEA.UWQHOSM80TEV@kernel.org>
Cc: "Dave Hansen" <dave.hansen@linux.intel.com>, "Shuah Khan"
 <shuah@kernel.org>, <linux-sgx@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Edward Liaw" <edliaw@google.com>
Subject: Re: [PATCH v1 1/1] selftests/sgx: Fix the implicit declaration of
 asprintf() compiler error
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mirsad Todorovac" <mtodorovac69@gmail.com>, "John Hubbard"
 <jhubbard@nvidia.com>, <linux-kselftest@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <656c3b4a-0481-4634-9dd4-19bb9e4cd612@gmail.com>
 <4dcd5fca-c200-42d1-a8f2-3045d5430fd6@nvidia.com>
 <65a79654-90e8-42b9-a840-e2ef404fe1f2@gmail.com>
In-Reply-To: <65a79654-90e8-42b9-a840-e2ef404fe1f2@gmail.com>

On Sat May 11, 2024 at 12:02 AM EEST, Mirsad Todorovac wrote:
> On 5/10/24 22:52, John Hubbard wrote:
> > On 5/10/24 1:37 PM, Mirsad Todorovac wrote:
> > ...
> >> The fix defines __USE_GNU before including <stdio.h> in case it isn't =
already
> >> defined. After this intervention the module compiles OK.
> >=20
> > Instead of interventions, I believe the standard way to do this is to s=
imply
> > define _GNU_SOURCE before including the header file(s). For example, th=
e
> > following also fixes the compilation failure on Ubuntu:
> >=20
> > diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftes=
ts/sgx/main.c
> > index 9820b3809c69..bb6e795d06e2 100644
> > --- a/tools/testing/selftests/sgx/main.c
> > +++ b/tools/testing/selftests/sgx/main.c
> > @@ -1,6 +1,7 @@
> > =C2=A0// SPDX-License-Identifier: GPL-2.0
> > =C2=A0/*=C2=A0 Copyright(c) 2016-20 Intel Corporation. */
> > =C2=A0
> > +#define _GNU_SOURCE
> > =C2=A0#include <cpuid.h>
> > =C2=A0#include <elf.h>
> > =C2=A0#include <errno.h>
> >=20
> >=20
> > However, that's not required, because Edward Liaw is already on v4 of
> > a patchset[1] that fixes up the _GNU_SOURCE problem for all selftests.
> >=20
> > [1] https://lore.kernel.org/all/20240510000842.410729-2-edliaw@google.c=
om/
> >=20
> > thanks,
>
> Hi,
>
> Yes, I actually like Ed's solution more, because it solves the asprintf()=
 prototype
> problem with TEST_HARNESS_MAIN macro for all of the tests.
>
> Sorry for the noise and the time wasted reviewing. 8-|
>
> Best regards,
> Mirsad Todorovac

Yeah, well, it does not cause any harm and I was not sure when the patch
set is in mainline so thus gave the pointers. Anyway, never ever touch
__USE_GNU and always look at the man page from man7.org next time and
should cause less friction...

BR, Jarkko

