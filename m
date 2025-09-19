Return-Path: <linux-kselftest+bounces-41931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A463FB89360
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 13:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1F61740DF
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 11:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842E730C349;
	Fri, 19 Sep 2025 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yk5LMGmc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5835C1B87C0;
	Fri, 19 Sep 2025 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758280379; cv=none; b=rG+DFXGJpvcTzSLVUkiUUvrCVLsD4EK1C0VMxqTY2IaA4UBUpdjna1hbkeMgirM4YgN8VkTZbVYUR7BPnoiMqzHfs3BZCBf+JmagQ/sHfSIjhOq8VS2fI8lcOg7/LguuDeCm02QeF8Ho4/hA9zOqqTkNKlSc5our1OaveQGxA+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758280379; c=relaxed/simple;
	bh=kOxTviwXNRHsQQgggVwmctRXiPP9/ssgo2oomiAxsFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kEUdNQYGmjrInsVjtZWL0/dwtE4blo5VNy7m7SQizag8WpPrzIYcVV1bsaNGOzy5jzvZqiZWhfNqYtCTyYzf18khoIz0/wa9sHH1AgmPA4or1psqY/WCEjXKw0seYOC5RZh+MEuSlwflGMsRfS8irOyiKliHBY65D0BYf3Kh28o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yk5LMGmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C449C4CEF1;
	Fri, 19 Sep 2025 11:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758280378;
	bh=kOxTviwXNRHsQQgggVwmctRXiPP9/ssgo2oomiAxsFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yk5LMGmcaQ68u3a/5seV1E/lDuF0QXENOW924lwYJOKp41QvCGuzHpUkAE5pjuJBR
	 N4f8qi6b5OHlgZfuBvzR2EmZ2Zy59tySp4FdvXaMz0vNrAzD8l5rMvWWN05Q6dlN7j
	 yAOmxtSqqLy6BMYNWD5xraYeEUo3+tLbsuFLZBIJTHvONC65frXsbJMauKIkN6ItAq
	 SVZK95FAQ/hqmoMj7w2LQCHmhmCI2fDhk7rm2M421I4Z6yFKRfn1xUr4xFqlCrNgl+
	 /U8fH1Y7hlGyemwngJWdvD2ZLTN8GjqJfvuoHPH4x+XMeNyjkLekdrYX3lYQjMdRiU
	 0VxMGa3yQwQjw==
From: Christian Brauner <brauner@kernel.org>
To: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	jannh@google.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v21 0/8] fork: Support shadow stacks in clone3()
Date: Fri, 19 Sep 2025 13:12:46 +0200
Message-ID: <20250919-eruption-apokalypse-75d57366bff4@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916-clone3-shadow-stack-v21-0-910493527013@kernel.org>
References: <20250916-clone3-shadow-stack-v21-0-910493527013@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2291; i=brauner@kernel.org; h=from:subject:message-id; bh=kOxTviwXNRHsQQgggVwmctRXiPP9/ssgo2oomiAxsFc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSctdqYt9oywOm76JlGmfeZJin9Ws/P7nuQp6Sfr3vUO FDivoh+RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEROv2D4H/IiyeegzlRBSf+z ck9+Hn/v9sfwzx5xAaGXj5focH72+c/wP6dv7Sv/0203On4bp02I0VnceH+J66Tig1Lr2hWPVLL lsQIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 16 Sep 2025 00:12:05 +0100, Mark Brown wrote:
> [ I think at this point everyone is OK with the ABI, and the x86
>   implementation has been tested so hopefully we are near to being
>   able to get this merged?  If there are any outstanding issues let
>   me know and I can look at addressing them.  The one possible issue
>   I am aware of is that the RISC-V shadow stack support was briefly
>   in -next but got dropped along with the general RISC-V issues during
>   the last merge window, rebasing for that is still in progress.  I
>   guess ideally this could be applied on a branch and then pulled into
>   the RISC-V tree? ]
> 
> [...]

Applied to the kernel-6.18.clone3 branch of the vfs/vfs.git tree.
Patches in the kernel-6.18.clone3 branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: kernel-6.18.clone3

[1/8] arm64/gcs: Return a success value from gcs_alloc_thread_stack()
      https://git.kernel.org/vfs/vfs/c/053b5d3aac29
[2/8] Documentation: userspace-api: Add shadow stack API documentation
      https://git.kernel.org/vfs/vfs/c/b495e1f0502e
[3/8] selftests: Provide helper header for shadow stack testing
      https://git.kernel.org/vfs/vfs/c/0ba39d41c241
[4/8] fork: Add shadow stack support to clone3()
      https://git.kernel.org/vfs/vfs/c/871b4dc7c705
[5/8] selftests/clone3: Remove redundant flushes of output streams
      https://git.kernel.org/vfs/vfs/c/c4aef60520c3
[6/8] selftests/clone3: Factor more of main loop into test_clone3()
      https://git.kernel.org/vfs/vfs/c/b3925f5b857b
[7/8] selftests/clone3: Allow tests to flag if -E2BIG is a valid error code
      https://git.kernel.org/vfs/vfs/c/9012e184d017
[8/8] selftests/clone3: Test shadow stack support
      https://git.kernel.org/vfs/vfs/c/c764fa47e7ec

