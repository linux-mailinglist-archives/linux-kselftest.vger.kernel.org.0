Return-Path: <linux-kselftest+bounces-8258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 864CD8A876C
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 17:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7DD41C212F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 15:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15299146A88;
	Wed, 17 Apr 2024 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGNVU1Ip"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF8212FF8F;
	Wed, 17 Apr 2024 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367347; cv=none; b=mBUwmm62uqX2LO8vbFLRyM5ZzobEDq1XL7nDm6WnmSqsFnyZFvNLTHTFaOBEwvxTdUvz9OkEpc3eLDDqHVuhPebdefgYu33jy4Nnd23Z7Jvc77ib42An6vMdmZ3aHseBuiklf1xAlWD+wJunRkzR8JdFY67t18HCQ4YtMA++WUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367347; c=relaxed/simple;
	bh=R7eexDiWtpHE6pflmf16kCzGylzB9hhf1fHTGg8yAnY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k5fLfItviOy2f4zmfdYRECgvSwN610kNsAVuKP+ZZefeyVRMH2LSK+mWBsB0ztrXCA2ECl6OLwDd+VMYc9+cgIGRdrvX3rdEjuYk99Ntbkqu8tOSPMd2qvl5nsO/VDcSsPecgoOA00JAP3oYxROfDtlD4xNWSCHhVJ76Gn6AiNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGNVU1Ip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C87C072AA;
	Wed, 17 Apr 2024 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713367344;
	bh=R7eexDiWtpHE6pflmf16kCzGylzB9hhf1fHTGg8yAnY=;
	h=Date:From:To:Cc:Subject:From;
	b=pGNVU1IpwXIU5PqjzgTBDHQe330aAY9WNuWKz0D/aZk/u7eZ3CqVNAarfdLsMzE5U
	 3UJ6utn397gm2ZQQvP1C495FjuykPn4b+lGfDaEsAQOHqhbEIGXeTQmdEaErEQrey8
	 igIzn5LX2r7vgWodYbKf3KOJyFvqF1W+ttc7kk9nN8ri+lfBe4GPTPqumrTOxr8hSS
	 RONTUwqKXeEIH4pxuj4KSfFhucFitX+rVz83a8DWLudptxnAykcaKyWIogi10STXbn
	 J7Sx12QW3Qey3ovlVLzUGwgLeeZhsa7HxAS8u6mf2WO+SjnaDWfrypZtgNCvpizngj
	 wFM6GKevhtvXw==
Date: Wed, 17 Apr 2024 08:22:22 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: tools/testing/selftests/clone3/clone3_set_tid.c appears to always
 pass?
Message-ID: <20240417152222.GA1517581@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christian,

I am looking at tools/testing/selftests/clone3/clone3_set_tid.c as part
of a patch to clean up the uses of 'return ksft_exit_...();' throughout
the selftests (as they call exit() so they do not return) and I noticed
that it seems to always pass even when there may have been an error?

      if (waitpid(ns_pid, &status, 0) < 0) {
          ksft_print_msg("Child returned %s\n", strerror(errno));
          ret = -errno;
          goto out;
      }

      ...
  out:
      ret = 0;

      return !ret ? ksft_exit_pass() : ksft_exit_fail();
  }

Should the ret and out label positions be switched? Alternatively, it
seems like ret and out do not have that many uses, perhaps it would just
be better to call the ksft_exit_...() directly in their respective
paths? I am not going to touch it as part of my patch but I felt it was
worth reporting since it appears to have been there since the
introduction of this test in commit 41585bbeeef9 ("selftests: add tests
for clone3() with *set_tid").

Cheers,
Nathan

