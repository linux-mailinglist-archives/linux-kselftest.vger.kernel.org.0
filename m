Return-Path: <linux-kselftest+bounces-2405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6052981CF5A
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 21:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EAAB286709
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 20:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408891E519;
	Fri, 22 Dec 2023 20:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCeQRapM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C861DDEC;
	Fri, 22 Dec 2023 20:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7241BC433C8;
	Fri, 22 Dec 2023 20:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703277911;
	bh=7ogi2ly0cEYHru4fztzzMgaU/rqStm+UJ0UEgi8PfnA=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=MCeQRapMpFG0ESTEKgGZzYx0J24g2VcwnVVYe9UrTumNvAb2wHpg0p7gjOTG2PLoN
	 0uCMxf4k18ZafZyJDuaEBCixKi+x3etPg8X4bBSy1enS++nVf6/IrMPL+NoGzB3ybR
	 6DNI2/4C2Gi/zm8G0EaUaxkqdRwxlCJYfFGawdpvHokf520WxvzARqL7u92ALOdyKE
	 iGCJ8EtCPnWnlzOCucJVKdTKdEyrJv+CeCUhEegMBCYxbpi3S4ws3wJ1zjAi5crgdO
	 /Rqv/FoiqLXKPtgoCTNjZ4rxH0a0Lx3ljvWBgLv5xsTrqR6WOIqeo5CmyQEMzNMBhH
	 9f93+N0H1hH/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A6A1C41620;
	Fri, 22 Dec 2023 20:45:11 +0000 (UTC)
Date: Fri, 22 Dec 2023 20:45:15 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From: "Kernel.org Bugbot" <bugbot@kernel.org>
To: hca@linux.ibm.com, borntraeger@linux.ibm.com, mbenes@suse.cz, 
 joe.lawrence@redhat.com, pmladek@suse.com, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, agordeev@linux.ibm.com, 
 live-patching@vger.kernel.org, shuah@kernel.org, bugs@lists.linux.dev, 
 jikos@kernel.org, mpdesouza@suse.com, corbet@lwn.net, 
 skhan@linuxfoundation.org, svens@linux.ibm.com, 
 linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org, 
 jpoimboe@kernel.org, gor@linux.ibm.com
Message-ID: <20231222-b218303c6-9c68cdd29b49@bugzilla.kernel.org>
In-Reply-To: <20231220-send-lp-kselftests-v4-0-3458ec1b1a38@suse.com>
References: <20231220-send-lp-kselftests-v4-0-3458ec1b1a38@suse.com>
Subject: Re: livepatch: Move modules to selftests and add a new test
X-Bugzilla-Product: Linux
X-Bugzilla-Component: Kernel
X-Mailer: peebz 0.1

mricon writes via Kernel.org Bugzilla:

Oh, hmm... I uncovered a bug in bugbot -- this was a different subthread that I started about b4 and supporting --dry-run-to that Marcos was looking for.

Not sure how to fix bugbot yet, but I'm going to close this bug for now.

Sorry about the noise, everyone.

-K

View: https://bugzilla.kernel.org/show_bug.cgi?id=218303#c6
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (peebz 0.1)


