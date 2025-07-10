Return-Path: <linux-kselftest+bounces-36976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2488AB004FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 16:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C43D177F65
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 14:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F163A272E47;
	Thu, 10 Jul 2025 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNaX6MHq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17A1272814;
	Thu, 10 Jul 2025 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752157273; cv=none; b=leH4lpAAcUnu8bG69zpcH9CMGsN3zv1hm7sEGxgO0PkLaSGRaZo9m53vVbPXBPVgVuwaEUktNG8aoXcwWEy5mW+N+XwnZOHWMZnD6hIoVePq3Hoqq9QT27JMqK6KuVihCh/VxKGq8v3LrO9LrrGAlTdU3aQtKtdTXjGQ3DpWKQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752157273; c=relaxed/simple;
	bh=PiKYZARavFsgpI+GNBPD+meoU3JrO96ePdosDKUFY74=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SpVyU7q7VXBAg8dvGiXUUj2lTEjliHjgReVTg5gyZjPiJlRmnUI27ZZc/Bz+bAPSMccuqkI0t9yETMrPGRjMc45g1zIMnHChuEUDA/778IONa6rKGR4yzFNpX0jk01j4Db+45tjuTS9t+AhgL5gcScy7fs51M/IyCfaEntL6xpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNaX6MHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0620EC4CEE3;
	Thu, 10 Jul 2025 14:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752157273;
	bh=PiKYZARavFsgpI+GNBPD+meoU3JrO96ePdosDKUFY74=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JNaX6MHqnBkxAq9w3Kw8L/G+6EYfDiX02choW0sza1q/GWEIzrh5GWFVEUwUpsR/A
	 q21fqn0AnSrs1MEUfYZS6tfm7WsTLSqGWwzOGr9LuHvcxuSgM5Z/nr6iE0CRZ4c9ld
	 Lte9eh1wD4zTGqpeuX6qSgFRKsaQkMJW+KUuOqpSgoz8uC/kwdtGRPUkKYg7SXDuX8
	 FZpZCuRq+lKS1YD/ZNEWHzgwjafaA6Rd+MNypvOoRzq33rekjZ6mjRbr0xnOeGRd17
	 A8p4ohiZt4qPA+7Tw9HHk6n6mMkC7inBKmukKUD8ckHw2XbVklbW3y8qFmvCoix9o7
	 v77jUpyj3T03g==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Shuah Khan <shuah@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250709-wip-fix-ci-v1-0-b7df4c271cf8@kernel.org>
References: <20250709-wip-fix-ci-v1-0-b7df4c271cf8@kernel.org>
Subject: Re: [PATCH 0/3] selftests/hid: upgrade the python scripts to match
 hid-tools 0.10
Message-Id: <175215727176.770911.16764304017186964894.b4-ty@kernel.org>
Date: Thu, 10 Jul 2025 16:21:11 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 09 Jul 2025 11:08:48 +0200, Benjamin Tissoires wrote:
> hid-tools 0.10 fixed a test regression introduced in 6.16-rc1: the
> kernel might communicate with the uhid node while the test suite opens
> the evdev node. This leads to a full test-suite time which used to run
> in 6 minutes into an hour.
> 
> Merge the upstream hid-tools project in the selftest kernel dir to
> reduce that time to something manageable again.
> 
> [...]

Applied to hid/hid.git (for-6.17/selftests), thanks!

[1/3] selftests/hid: run ruff format on the python part
      https://git.kernel.org/hid/hid/c/c85a8cb9b8d3
[2/3] selftests/hid: sync the python tests to hid-tools 0.8
      https://git.kernel.org/hid/hid/c/642f9b2d608c
[3/3] selftests/hid: sync python tests to hid-tools 0.10
      https://git.kernel.org/hid/hid/c/1aee3a44fad2

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


