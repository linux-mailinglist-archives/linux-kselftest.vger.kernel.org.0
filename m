Return-Path: <linux-kselftest+bounces-48400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D604CFE32F
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 15:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A61CF30CB135
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 14:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A036B32AACA;
	Wed,  7 Jan 2026 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiBdgWqb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E874D32AAAA;
	Wed,  7 Jan 2026 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767794761; cv=none; b=VQv538RzF4Ooi7vl8vHNGcODZw5wKcoa4OScTbOXpqHM691yTWY0oHvYluNd1soBD9/H3Cq6KXgsYA/eittHyzlJ0maySlBggN0IKz9yYPepk0HcC2psCEXeaUVnr+FRHR/JyqfO6eOT3zLhmw5H994I96olhSEORqwsd+967d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767794761; c=relaxed/simple;
	bh=zYIJmFazs8a8UbOvC417oGs4hr8jcdzla1AvklOBR80=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MSn+zG2xDrojmcIS9IhdyWDFz9mLX63JgfMUC3uyT8v64CzGJNF/foU+DWNid48nsDe52h4KxypHh2SsW23dYIQ9zQunU5w4n7zTZK86QOoUXX5FreIE3Ow/Gym3vKxt5/6jTkOX8RGe5Obc/CiU1Jmtapannpk0mRW4jW+S4hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiBdgWqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01B9C4CEF1;
	Wed,  7 Jan 2026 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767794760;
	bh=zYIJmFazs8a8UbOvC417oGs4hr8jcdzla1AvklOBR80=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tiBdgWqb0zcOW73o8b/OJxN4/RmqKV1vNFyO8P4mcJ1ZOt5aki2Yj9WpwrzP+naio
	 5Z3dEgTCUjGOhvnjs9Vt1QC5Xdt11kikjLYbn0qkILpbQtR8DI3ognLOE75i5t47k6
	 8sCPnWOC/DTTJyrSyJiro6IFkVRH1m1bOZTo2FLicc+WxJeJnTekyM3o4l9fYBd4bO
	 uCOI4uBS3OG2CI9LyMTeVtwkKJzXp6K2bENaaYiA1WANSo2tnqDmzNLbTqdXMVOsTC
	 moyd2V9FKTXtLZwmSCL3sY5d8XFv4qauUgpy9S34KnnYxRayOLHU4r0HUVmNxkIviD
	 5GXf2t4NYdk3A==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
In-Reply-To: <20260106-wip-fix-bpf-compilation-v1-0-0b29c85f1157@kernel.org>
References: <20260106-wip-fix-bpf-compilation-v1-0-0b29c85f1157@kernel.org>
Subject: Re: [PATCH 0/2] HID: bpf: fix HID-BPF CI due to new compiler flags
Message-Id: <176779475850.3423301.194230291511293758.b4-ty@kernel.org>
Date: Wed, 07 Jan 2026 15:05:58 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev

On Tue, 06 Jan 2026 16:30:53 +0100, Benjamin Tissoires wrote:
> Since the merge with v6.19-rc my CI is broken because of the newly
> enabled -fms-extensions.
> 
> Add the missing flags when generating the CFLAGS for bpf.o to solve this
> and continue running the tests while applying the patches.
> 
> Cheers,
> Benjamin
> 
> [...]

Applied to hid/hid.git (for-6.19/upstream-fixes), thanks!

[1/2] HID: bpf: fix bpf compilation with -fms-extensions
      https://git.kernel.org/hid/hid/c/b7666c891cc7
[2/2] selftests/hid: fix bpf compilations due to -fms-extensions
      https://git.kernel.org/hid/hid/c/e03fb369b083

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


