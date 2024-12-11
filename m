Return-Path: <linux-kselftest+bounces-23227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38A59ED985
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 23:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD9F28239D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 22:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBDA1EC4D6;
	Wed, 11 Dec 2024 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="id9PL6jK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BAF1DB956;
	Wed, 11 Dec 2024 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955622; cv=none; b=TDwywWGCCaNB4pu13wDdtH89oZc4DqDBzHaj++qY5Fg/8SLftv9MxRmcobJ3+qCO5uxqxu2ADQv7JnVXfqHjDdmyF0ct8qy4kbwpf1ZxFNtLXRUFt8Tc4vY3L9UOZEHrnnAwk8+AdZlsNeSWvE70g7QZ2WaazEqPQI8U75PQifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955622; c=relaxed/simple;
	bh=RFX0bqtFTXdVy3Fc4rEo/xLrnwwojCZGB79un2IZYMU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Rb4GnJALec4np16A3lZpkMlzjoeA2c7gEoZYHHdlnRxogItiK5MrH+qa1HeINHgEIyO/Ox7SA/hXGFRZloeFqrsdNFMlAXeQn1qMdrNj1yiWKpzy1SexnK0q7ox6HXtD/n5KJNhgOCYBSdAiYLeQ3qqsFGLy+vrm9N2xM5axYmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=id9PL6jK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA33BC4CED2;
	Wed, 11 Dec 2024 22:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733955621;
	bh=RFX0bqtFTXdVy3Fc4rEo/xLrnwwojCZGB79un2IZYMU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=id9PL6jK/HbVJ9TOeqy/WSwNiGPIIRzyUtMQGYn39D+SrR19UO2Hu5w/5qoOV2HCs
	 UjyC8mXd5uHV3/40xPt7IKVNGDId4afAe1lgnAdCb81HCgbmkCslAxa4ouVz/kc87b
	 pXoLfZp29eto29MlCNt3gwbNamXglGc5iUUSG7y9EQzsgPiHewdw2LFn4sTkW3wD57
	 //8OZbaenov5P5XGWmzBPLNSk+KZ6CLqXh62wmRBZWZMkU4CYKANZdHe1npBSkac/c
	 2UuvN/ta/hebVCsFVGqDHKhSth1LG1oUslxLDATpZjwPWshgqLDn1+261lbfljAsqi
	 1cE9EfXycyKkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC5AD380A965;
	Wed, 11 Dec 2024 22:20:38 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes for Linux 6.13-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <e3c2e67e-c80f-417c-a44f-e2f568e90d44@linuxfoundation.org>
References: <e3c2e67e-c80f-417c-a44f-e2f568e90d44@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <e3c2e67e-c80f-417c-a44f-e2f568e90d44@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.13-rc3
X-PR-Tracked-Commit-Id: 777f290ab328de333b85558bb6807a69a59b36ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: becb337c237f9c8030fb976a1d643c0347408cf8
Message-Id: <173395563740.1746415.5799615296948212104.pr-tracker-bot@kernel.org>
Date: Wed, 11 Dec 2024 22:20:37 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 11 Dec 2024 13:37:41 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.13-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/becb337c237f9c8030fb976a1d643c0347408cf8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

