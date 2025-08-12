Return-Path: <linux-kselftest+bounces-38799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1648B22EE2
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 19:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123903A8DF2
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 17:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F66D2FD1C4;
	Tue, 12 Aug 2025 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gM6qhym/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED6221C160;
	Tue, 12 Aug 2025 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755019204; cv=none; b=J1jnOVIER83hiZXzvojiW39pgRGl4T76+E9OIXjQloASqK8sRJFejFZPjbvmDn6BgdIsq2r7Y6GPx6Tploc9lMQPiRYLzMeXa+1Y8iinpj+P5uA33Di6rcGzwGZ7BCq1Lb2HDe42Sv0zb48uzFNx7ltYN6e2GyClKCZlaDTGH9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755019204; c=relaxed/simple;
	bh=mAC0HElfoi9Vm0ysz8JFlbF2hmtehTuzsx2QwPcA3lw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ofDhWb1iBBUb7xNkFmtTH84w7SMqUfeVA2qcL5A+mnSjNM2sAOJhkERo5h1LC469bmtPOD7Lfgly/g1ol25Vdm4eme/b7je9rrA3BwpFYSUAzEXyXVc+Np2zZ3dY2Y90WKnZzELddWM88CcrzBwibRj5DcDUzzr/ZwPg3UnVceY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gM6qhym/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFC5C4CEF0;
	Tue, 12 Aug 2025 17:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755019203;
	bh=mAC0HElfoi9Vm0ysz8JFlbF2hmtehTuzsx2QwPcA3lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gM6qhym/4a3Wazw/nb45u6yf19ToNI2AupnrQWSMRSud2rXFjWscjBM03GnmGuaLC
	 EsSxGSxYbn6bxLR4A2ABjxDsa+pL4ZQhGqWV2JTXluMQdvNFq8NiSxxMtND5gTwRzu
	 /DCJj7O5o5G9jFdLQ4APf0J10q1OuZDvhbtv2qaNCwxZni62qKDkKYUKeAtL4Ntygo
	 2GE778oQcigzTGsrra/5sdbfnFvQWrDutwQCehovhpDQS2bzt+lr/jH/3RezA9e+eI
	 SRpDHftSUOViKMiuPwCw9CW9uD00n3W1C88LhfSiOfeftXXkcznJQN+SXh6ZICgtQT
	 cT+O7nxy008Ag==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Enze Li <lienze@kylinos.cn>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/damon: fix damon selftests by installing _common.sh
Date: Tue, 12 Aug 2025 10:20:01 -0700
Message-Id: <20250812172001.57104-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CABFDxMEQYx7fdx4T7meUb01FoqJaHcW_2RoYnBwJ8GzmJTexzQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 12 Aug 2025 22:27:00 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Hello, Alexandre
> 
> On Tue, Aug 12, 2025 at 9:32 PM Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> >
> > Hello, Alexandre
> >
> > On Tue, Aug 12, 2025 at 5:13 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
> > >
> > > _common.sh was recently introduced but is not installed and then
> > > triggers an error when trying to run the damon selftests:
> > >
> > > selftests: damon: sysfs.sh
> > > ./sysfs.sh: line 4: _common.sh: No such file or directory
> > >
> > > Install this file to avoid this error.
> >
> > I tried to reproduce those error with my vm environment but I failed;
> > with my workaround test method, it doesn't exist.
> > If you're okay, could you please tell me line by line how you execute
> > tests in what environment?
> > I'm also struggling with the test environment, as well.
> 
> I succeeded to reproduce and also check that this patch removes those errors.
> 
> > > Fixes: 511914506d19 ("selftests/damon: introduce _common.sh to host shared function")
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > ---
> 
> Tested-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Thank you, Sang-Heon :)

[...]
> > > ---
> > > base-commit: 2754d549af31f8f029f02d02cd8e574676229b3d
> >
> > Does this commit exist in `mm-new` or `damon-next`?  I failed to setup
> > the same base-commit environment.
> 
> However, I'm still not sure that this patch is in the correct
> baseline. maybe it will not cause any problems with the merge
> though... but I'm not sure. So I didn't add a reviewed-by tag.

I think unclear baseline of a patch shouldn't be a blocker of Reviewed-by tags.
Since most DAMON patches are recommended to use mm-new[1], as long as the patch
can cleanly applied on latest mm-new and you don't see anything wrong, I think
you can assume it is based on mm-new.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]

