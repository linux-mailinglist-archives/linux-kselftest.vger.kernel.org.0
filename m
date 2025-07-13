Return-Path: <linux-kselftest+bounces-37197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCE0B02F43
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 09:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279A1188D3B6
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 07:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C601DED5F;
	Sun, 13 Jul 2025 07:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWrUfmpM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36D41C3C18;
	Sun, 13 Jul 2025 07:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752393244; cv=none; b=DWHuS0bUYX9cYNyE3pRNqGdUlQxyY3Hd3lpjiaIIN2SuGr2fDGePOWw0Ztg4sAuhrK6dkBoyT2w6TWNkjRi+FLGUzuqI3eQdS8vU661M3nHl2iG7q6l23Y8nqDc7WlrSZH4B45Y8kN/jt0wvbR2+Pk1EHrVbEynP1w/KDIceDKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752393244; c=relaxed/simple;
	bh=ktqOXnNu/XVoK5UPwztxR57fsT6LOxOiNMD1Se21kig=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IsoqV34nKQFql61Vb25lKXydsUT1V+couyz5XVgPm8rr0ltUYXQHsJ2UoVbardhgm5myCcKn3Dmb/isk1nWpkFeNafW1CAbt6c/xG7z+CWIHhJ1zOeuNhSB2T/eJ9uGIyeAoWr2ppTO8OlSpB5N0NYm2EANpd7aUzF/cSSQGrTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWrUfmpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94949C4CEF1;
	Sun, 13 Jul 2025 07:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752393244;
	bh=ktqOXnNu/XVoK5UPwztxR57fsT6LOxOiNMD1Se21kig=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jWrUfmpM9bcl8Fyt61iZdGEBEso9fmSjUfnbKN1PHl+ekKx7a3fDxG60dqCv/Et5A
	 2mHg+uN3RG4OU8qrT+iWOu0W5n7aFX/wWNvATp3Z8IYF8yWP4QFbMfAR33mI4jrGyl
	 0s0hyt6hMdxOSjGoH4bFxRF/vBxof/g7Q6uDmD6A7ZEX/qRX3C63kiPpIU0gP2HGxt
	 pU0rFDUAJ67ODdDou/ed03MRNM4RwWV6QehWjbrdSPmx86R2zR8nnhfyeefyHxweLb
	 uQjsVYrLH+ZDCS+RahVfQbElFgyIA0hwcso77iY2WhaMlWO2xwAPzoiWo3mIqZTJPr
	 llrme8cb7XvkA==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
 Shuah Khan <shuah@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, 
 syzbot+8258d5439c49d4c35f43@syzkaller.appspotmail.com
In-Reply-To: <20250710-report-size-null-v2-0-ccf922b7c4e5@kernel.org>
References: <20250710-report-size-null-v2-0-ccf922b7c4e5@kernel.org>
Subject: Re: [PATCH v2 0/4] HID: core: fix __hid_request when no report ID
 is used
Message-Id: <175239324234.1701499.15395216375379684975.b4-ty@kernel.org>
Date: Sun, 13 Jul 2025 09:54:02 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 10 Jul 2025 16:01:32 +0200, Benjamin Tissoires wrote:
> New version (unchanged for patches 1-3), with a test added so we can
> detect this.
> 
> Followup of https://lore.kernel.org/linux-input/c75433e0-9b47-4072-bbe8-b1d14ea97b13@rowland.harvard.edu/
> 
> This initial series attempt at fixing the various bugs discovered by
> Alan regarding __hid_request().
> 
> [...]

Applied to hid/hid.git (for-6.16/upstream-fixes), thanks!

[1/4] HID: core: ensure the allocated report buffer can contain the reserved report ID
      https://git.kernel.org/hid/hid/c/4f15ee98304b
[2/4] HID: core: ensure __hid_request reserves the report ID as the first byte
      https://git.kernel.org/hid/hid/c/0d0777ccaa2d
[3/4] HID: core: do not bypass hid_hw_raw_request
      https://git.kernel.org/hid/hid/c/c2ca42f190b6
[4/4] selftests/hid: add a test case for the recent syzbot underflow
      https://git.kernel.org/hid/hid/c/3a1d22bd8538

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


