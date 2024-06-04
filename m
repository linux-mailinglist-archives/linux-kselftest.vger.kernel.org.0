Return-Path: <linux-kselftest+bounces-11214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6098FBB2B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 20:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBFDA1C24C41
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 18:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232B114A4D2;
	Tue,  4 Jun 2024 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pW4TGh08"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3F0149006;
	Tue,  4 Jun 2024 18:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524226; cv=none; b=GUSddCkeUzZ03TvsZxBLvP00gOw6dymMG6q8Pyl7iB85Ce3WPXlqEUZHXpQcI9gNkxNcB1mFvHTRSh1VwIOY+jc3CCss+lO336KXzz0xg51VLT/gf0KZUPhXrG+9BjJibtYVRSUlKPN+JPAkOzZM4Cp9HRkiwhgBdM5wkAZAylw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524226; c=relaxed/simple;
	bh=gI4CxovZ1R7D2BHM3Q5+eNcDWBkPguDByZrrv42aIM8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WxRRvmR9Nbx6gVqSBgEYHF5IFoS2ojZCauOD0HSdQF3yOyo/dArzghQOy/LaSkTuW/+EhOQzAM8Z7AxR4EbEmRXc5waBvtD6nlcKZzyvPAqpETTaYnyK5/zxstp35zbsVjNrHZES5Tp6SGkcPUxFqX8Nq8uARU7AQuzLMFY7P2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pW4TGh08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69C2BC2BBFC;
	Tue,  4 Jun 2024 18:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717524225;
	bh=gI4CxovZ1R7D2BHM3Q5+eNcDWBkPguDByZrrv42aIM8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pW4TGh08K7HAcV3ZFYmihWB0wwoFltwa4v7u/hzHy7xn1TqbHUr9TJN5sV5HEILcV
	 qFPmm6nycIhLzNxwYACYqwd9fdlvamdIPDOO/Vq3J1WTC47JZaSsLaTWluBaaFsmSC
	 Ncl2igzRirEcMs+t/9q92S/s4ja7mfb7xZkaROHRzakHbWGLjFNgNRQghcpXwoIN5f
	 QSYlHRbDlOr/opjRSxT7iOIElApJCGPeSswLVF9/aQdApwemh3i7cW/z+NwZ9Y81Ix
	 p7ALnqXxEY+GXSbVQlKCg8bptYqdINz6IBUD4NYTjmpBSnoSdLwEEATOVxmqiOzvFD
	 JzvK2djoZ1WgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E7D2C43333;
	Tue,  4 Jun 2024 18:03:45 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes for Linux 6.10-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <f32f0c51-f11d-421f-95c2-1a9e94be1a32@linuxfoundation.org>
References: <f32f0c51-f11d-421f-95c2-1a9e94be1a32@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f32f0c51-f11d-421f-95c2-1a9e94be1a32@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.10-rc3
X-PR-Tracked-Commit-Id: 4bf15b1c657d22d1d70173e43264e4606dfe75ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32f88d65f01bf6f45476d7edbe675e44fb9e1d58
Message-Id: <171752422537.11221.4948230575855271735.pr-tracker-bot@kernel.org>
Date: Tue, 04 Jun 2024 18:03:45 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 4 Jun 2024 09:37:55 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.10-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32f88d65f01bf6f45476d7edbe675e44fb9e1d58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

