Return-Path: <linux-kselftest+bounces-22464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1509D6703
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Nov 2024 02:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C636A161643
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Nov 2024 01:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C980815C144;
	Sat, 23 Nov 2024 01:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZ9Ua32F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AB1770FE;
	Sat, 23 Nov 2024 01:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732325396; cv=none; b=VsigaTTM7RBGASIcSFcj1Y2jpTPsDG6SSolrPS4+ASUcnRXUcXvd/a6Zg/bi1BdCR/SC3l4tzLJ6D78NV4g8o8lSneMBCLjbZNIeZUKeeNQJLMdLrzsBUJ1Ylb41Svf18l7JyGmJ0a9F4T6IQK+rWkezaKycaYAuZHdo6KGNex4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732325396; c=relaxed/simple;
	bh=Qauzjxox3kAHfnfmajW0ehQqp1C3uPDzLuTFySHrwbc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=J2CyINt3XjSXEzwfZs7H7pDEh+II+ZWKykiJONssxqNCIbswsahqeYlF+4CCXCIeaGSVOucYd83AiLUHANkhrM+dPZb8RJfTfRZDqyATvky1nnYZR7Zhe0MkWfuVPcO3aj187ws460izEWc1h3VtsC9PHL7902Y9WZDBRttXHds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZ9Ua32F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450DCC4CECE;
	Sat, 23 Nov 2024 01:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732325396;
	bh=Qauzjxox3kAHfnfmajW0ehQqp1C3uPDzLuTFySHrwbc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bZ9Ua32F81GNpB0pruGu3eqD6/T+tTM2C9R4kJ5P3mMudX+04g8kxhFSgA+nul39k
	 2hdf2GS5JHFJ2u+UKSpBchc20p9XlJ4pjqYtWZ1phUJFdYfqeMJjB0WhRFbxaCYYXm
	 VMGgdHsDEMXX3fmzoj3czRd0K51M0yfaIWyK4QY56ULAx0lg1327ZMeMHJI9JUT68D
	 Nb4/FfSv0ShlcqOFN8tOhUIcntEfvR6cZsbQeEqs3OHQT03ACeX2pmaXXNCmk73YBj
	 EoOFfWDWh5jHLND8MH1Waom8RS2Oa7n2kSjZH6VmKB2nd/dXzuALHZMqldSy0RRaib
	 hKjm7rkRnLEKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEEBC3809A00;
	Sat, 23 Nov 2024 01:30:09 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit update for Linux 6.13-rc1-fixed
From: pr-tracker-bot@kernel.org
In-Reply-To: <9ac83205-add4-4971-8cf3-70be10282e1c@linuxfoundation.org>
References: <9ac83205-add4-4971-8cf3-70be10282e1c@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <9ac83205-add4-4971-8cf3-70be10282e1c@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.13-rc1-fixed
X-PR-Tracked-Commit-Id: 62adcae479fe5bc04fa3b6c3f93bd340441f8b25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e288c352a4a5716babf2edad4cba10ec6002a20a
Message-Id: <173232540839.2863978.3117516865769299457.pr-tracker-bot@kernel.org>
Date: Sat, 23 Nov 2024 01:30:08 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Nov 2024 17:54:55 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.13-rc1-fixed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e288c352a4a5716babf2edad4cba10ec6002a20a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

