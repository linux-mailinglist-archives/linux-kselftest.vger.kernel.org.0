Return-Path: <linux-kselftest+bounces-33424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB82ABE4A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 22:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD903A91E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 20:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EEB28935B;
	Tue, 20 May 2025 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2ENa6CP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D42288C04;
	Tue, 20 May 2025 20:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747772278; cv=none; b=Jhg5kCxaID9f9/rjDhax2tVaf+gmMEpA7cblZncekV690nW/HSzZUiBVDyweZLP6TgHGbM9P2nq5O7rV+XgkBedqrSdgbYspM0Ektex1A34DqsBLzzKLMrVa4qSNFWhp57YrYS0mYevB1FnFs2TDzN3/hg0+S/q5VskieszhDv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747772278; c=relaxed/simple;
	bh=KvwuRwVE1fC6juXTUpk5QEDX6PLHXD/T6Q7Xf0x2WXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSQABFMph3zkOziXcIP5Svmta0nZfuOk7anq+Mt0gXDky5a2bfe/lsqPMqaLw8uyvfLh91O7zU/Stv7KDn46g44f0nFlM9CM5PuB0FjmM7D44JeRbJM+FuYjQyua7t3rh5QU+CcgySwTCQ7fU0A9ZLOE4y66P1EsGb5ObcyhKhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2ENa6CP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80108C4CEE9;
	Tue, 20 May 2025 20:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747772277;
	bh=KvwuRwVE1fC6juXTUpk5QEDX6PLHXD/T6Q7Xf0x2WXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q2ENa6CPyCheVK9dtZXt0nhOFSdUKauMF//oLx4suR7cFof02tdqmzDzKiAuZL3h6
	 wXdd5RdS8qwotZkSWf89z1qAmmhOq+QKrA8O3TE4cLAjOrVPU4ZivPNJrOxMS9f7NW
	 lGqAJgSkzKSCe+tM3gYtOUAeg37Deref3vKik7fJ25ghHe1xcBSR6dmbdNobgN3hP1
	 kFq3pVkF0ul77zsEd/ei6HBAwKM5xoAXAg1ebLtH36whY5fqfJoL0QdWmoBr93xncw
	 A88vySL4PFR8FDvySaFy52lWQhyH5WdsRQeicsWnNCaTzwL5HRMJ1Unamz2DuoKyuC
	 ZqFZAaBNdh3Eg==
From: Kees Cook <kees@kernel.org>
To: skhan@linuxfoundation.org,
	luto@amacapital.net,
	wad@chromium.org,
	shuah@kernel.org,
	Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: seccomp: Fix "performace" to "performance"
Date: Tue, 20 May 2025 13:17:53 -0700
Message-Id: <174777227286.2634989.17167804698984646014.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250517011725.1149510-1-sumanth.gavini@yahoo.com>
References: <20250517011725.1149510-1-sumanth.gavini.ref@yahoo.com> <20250517011725.1149510-1-sumanth.gavini@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 16 May 2025 18:17:22 -0700, Sumanth Gavini wrote:
> Fix misspelling reported by codespell
> 
> 

Applied to for-next/seccomp, thanks!

[1/1] selftests: seccomp: Fix "performace" to "performance"
      https://git.kernel.org/kees/c/a9b33aae79ce

Take care,

-- 
Kees Cook


