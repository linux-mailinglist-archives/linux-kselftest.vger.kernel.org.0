Return-Path: <linux-kselftest+bounces-6234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A29878B92
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 00:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0006B1F218B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 23:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7D658AC5;
	Mon, 11 Mar 2024 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ICS6mjMY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF49C134AB
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710200254; cv=none; b=mM3ULjJasvRrH8ilaXMeWuxD5rJWBetMVuqZMnEqRlsX1UbwJvU60ggneh/QL95WNmtCedC3cNIweFtef5GXc2UfDxsWShIe1Y9pKUDYitIAYQBy46Auhil6+QuV/M+ZRp6P/FKv4+kMCIpbspvoPtyDy0tlPgiEyNiRvixEjag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710200254; c=relaxed/simple;
	bh=UHDfEzsotiT9ePQ0y9StHgbMOf/lrrRURVo481jht18=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RLJiIrFmXx0JzI5QXP8yrjrmv3l4nOhCcPppAA3QinpAci7SsuWpcD7YRkvScl6/MPlGDvld8McaAhYegRooED8ddjot8q5GBYmh56Undxe4obk8lGvGAteU7GsHM8jE3LNgryKrWjQksAy3IHVrUHwunt+3opxmMjDDG7cURTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ICS6mjMY; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e5dddd3b95so3597082b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 16:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710200252; x=1710805052; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xm7ckg0f9VWSGYhP+vSFLa1BP8tcu5Wgr9BmHroe7cc=;
        b=ICS6mjMYCTOwufVVhmEp2JHtDfE2EDE23slTRR32ea4HpM1JIOvTmxHhy6IDIp4Yvo
         zPa5tbgk3owf/QpW4BcLKDWYKLDeRxoIl+P7K8AzOpKItmhV1jWAnKPxsLiRgrZaTAN3
         FRMRUAmk92nV1waX6t5R5HviJZLILjxjKSqSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710200252; x=1710805052;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xm7ckg0f9VWSGYhP+vSFLa1BP8tcu5Wgr9BmHroe7cc=;
        b=wgRD3qmJRilV1EIrcJTnj5VPhnkw+BeqHHgm+6lTRTXdvtGtQmPRcpa6iIRYcFHm+G
         oTYR4Rc43zyXqlULWXfp1SY7kDI44yAL/4BqX6qBxD0seYoEHGwsaGLqUMNSUx2e32RM
         tcBFquWnZsMwABDbmhM2xrnapQm4h5VlbGHgS4l0PZjLy8az0m50vWDst5VMziW2WPwP
         fiLyar+l7e8NVMT7gbcFp9Jo6yc+JPrZPaqzrHA2+hvnhnj7+dnNskm1nfP4cFveNsVb
         V6Fdg8tTY3uq7yRAjY8ogJus9Qdar+SENiDwrnbr5nwi+/yGFoSffNeZKCc2k2qCz+cg
         g8dw==
X-Forwarded-Encrypted: i=1; AJvYcCUsyMx/ZhCnl5sQUG7IsW6Dj9sELVFpz51yT6TECsKdD+fELoXAVAlKX1WgKF+FAblTuy8e+ZnjVq0SuozGbjGvJStmPyICJnTT2TtP7VUp
X-Gm-Message-State: AOJu0YxzyHVFxiVAwXEKnfqzpzHDdyH93ONISTm76nOOrA6y2/upe2lD
	Gj0VdRsYY1gSq08olGVdNQoO+tB4b7eKLQgZ9ei09rC7XsHD13/xbEir7KJxEQ==
X-Google-Smtp-Source: AGHT+IHD9UB7WtYdXSoqrw9ipbo6+l/ogripqDA2ow6WSs0p2YAHLpnIBCy3YZsyucMa8W5txpXHgQ==
X-Received: by 2002:a05:6a00:2ea8:b0:6e6:758e:4ad6 with SMTP id fd40-20020a056a002ea800b006e6758e4ad6mr11969545pfb.17.1710200252063;
        Mon, 11 Mar 2024 16:37:32 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t23-20020a62d157000000b006e56277fd45sm5138302pfl.190.2024.03.11.16.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 16:37:31 -0700 (PDT)
Date: Mon, 11 Mar 2024 16:37:31 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>,
	Kees Cook <keescook@chromium.org>, Li kunyu <kunyu@nfschina.com>,
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, Mark Brown <broonie@kernel.org>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [GIT PULL] execve updates for v6.9-rc1
Message-ID: <202403111637.203A9187C7@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these small execve updates for v6.9-rc1. Details below.

Thanks!

-Kees

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.9-rc1

for you to fetch changes up to 725d50261285ccf02501f2a1a6d10b31ce014597:

  exec: Simplify remove_arg_zero() error path (2024-03-09 13:46:30 -0800)

----------------------------------------------------------------
execve updates for v6.9-rc1

- Drop needless error path code in remove_arg_zero() (Li kunyu, Kees Cook)

- binfmt_elf_efpic: Don't use missing interpreter's properties (Max Filippov)

- Use /bin/bash for execveat selftests

----------------------------------------------------------------
Kees Cook (2):
      selftests/exec: Perform script checks with /bin/bash
      exec: Simplify remove_arg_zero() error path

Li kunyu (1):
      exec: Delete unnecessary statements in remove_arg_zero()

Max Filippov (1):
      fs: binfmt_elf_efpic: don't use missing interpreter's properties

 fs/binfmt_elf_fdpic.c                   |  2 +-
 fs/exec.c                               | 11 +++--------
 tools/testing/selftests/exec/execveat.c |  2 +-
 3 files changed, 5 insertions(+), 10 deletions(-)

-- 
Kees Cook

