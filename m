Return-Path: <linux-kselftest+bounces-31183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F28D3A93EDF
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 22:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3C246372A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 20:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CADD24501C;
	Fri, 18 Apr 2025 20:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUhkvDnW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C9C78F29;
	Fri, 18 Apr 2025 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745008038; cv=none; b=Jzj0fd/hphlRPod4EynBDInYBZ9aqFxLj5j0qOj+J94gwayh/T+uBh/6NjEkS0o41EiTkWmmFYOZINpKpe+4J9ZNBn5N6RpSotAj0kN5v1G3KZozvCK8qWwhxOe5/fu0OycjgrIHiVM9BS9bDD2pcGtD0T0UrM+gifV+4zZuHgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745008038; c=relaxed/simple;
	bh=8DwSSKPuQ0MU27bQND2C3BiwMrVGXG7tgzTttqJNoo8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uEG8xxMb/01HRGtttTMYe6xYmTQiSBLhv1Uun2VfpPHDhLWp3eQ4n4pQPxZLh/pXax2SksvBSGihsFXnYuSHclR44EtVi8En2cQlD280vxymH5BuCZ2CHXHLMYWCBkdmDCH8n3AvZhe6v4Qa8Va79qE+fGgDZh96gR89Z6TLMKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUhkvDnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA54DC4CEE2;
	Fri, 18 Apr 2025 20:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745008037;
	bh=8DwSSKPuQ0MU27bQND2C3BiwMrVGXG7tgzTttqJNoo8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rUhkvDnWeVdefSCLQf1HV+SaWvVSz7qdAR+K9P8GNLFRA8AUEibT7+BP70Ku1E9WZ
	 asBXErENgyFCXlGTsILzxPNv7gomKw2KUo45RQM/Od1VXU5rkpJLaEmkJEPuSvRLwp
	 +1J6mLZx0RLmtTKRAXE5z48yaUpLReGxjTlOzmWSCJ4I7kVTBWV7QRbpte7a8mZu8F
	 76gPVWr7Sw/8EUEzdZlsDdckivsWR8DdLDywN+U7y5Xr/A4R+BDlfYcd2vgR+LIth9
	 QsNPX5py2CBh9H5Qp/q5U9/smhmgu1wvQcFjRftLcaAz5aBDAavRvRZ6Ewa2cJhszt
	 lro91ojxfM10Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34F1B3822E09;
	Fri, 18 Apr 2025 20:27:57 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 6.15-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <e8852bc2-6013-4486-997b-e001f3dc9909@linuxfoundation.org>
References: <e8852bc2-6013-4486-997b-e001f3dc9909@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e8852bc2-6013-4486-997b-e001f3dc9909@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.15-rc3
X-PR-Tracked-Commit-Id: 07be53cfa81afe94b14fb4bfee8243f2e0125d5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 338d40ceef38d9a36b48164e22768b40d6f89701
Message-Id: <174500807582.316726.12946861351338489425.pr-tracker-bot@kernel.org>
Date: Fri, 18 Apr 2025 20:27:55 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Apr 2025 11:23:27 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.15-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/338d40ceef38d9a36b48164e22768b40d6f89701

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

