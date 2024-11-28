Return-Path: <linux-kselftest+bounces-22606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F939DBABD
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 16:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F4C0B224EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 15:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAE21BDAA0;
	Thu, 28 Nov 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJOyQ3Op"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8176E1BD9FD;
	Thu, 28 Nov 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732808450; cv=none; b=dGnwgCj1KJfB9a9buv7Q1JZtCstrfzyWZinL4Hu2P1BjAhZGJ6nB9T57Z9XNoHWqtfOj8d+z1DKKXkUWRp8UUm6Hf+XaSnmU4HVE6EQf1HZdVi7UORtwLH5b7TInkNlwNNejVcxDI5B11CKPjLADoq1DKnNPBwNljdFxw3lSkMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732808450; c=relaxed/simple;
	bh=3Ju+mG6AbalUNchHrJWsVy32D/Z6BPG2SJDSfMowx30=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ejs6bYq/a1M29YWhvO6HfU+eomS5lLlQOF9orC/T3A4HuPPZ8HLTSd8zznGe7mz5v0OlWEM95NAuxzIF/8N4I/pMTsqs9RNCIDCMIfJbhx7IPI5LgBfhDNqkQIShTI9Wqs/cdgT6/qGyp7DQJR6ONW0yAyWdoFOpPhpvr+Kgjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJOyQ3Op; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A437C4CED7;
	Thu, 28 Nov 2024 15:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732808450;
	bh=3Ju+mG6AbalUNchHrJWsVy32D/Z6BPG2SJDSfMowx30=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EJOyQ3OpVU47MkFzzvsp6T9VbJGl/asF+rmCSB91WjrvoKYeTVNMHyaykj5AYlsiq
	 FSw5FPzV3nt7dLbeRWmSYmMg1PSHc8Voj86e9Tg2XBVuMYwP0M+AL/DzYNWVMZOANt
	 ucY2Z5v+oeKPhU7D18oDFD9GzQe0y5fp0tLuBrjIcPt6WVN4euYM/Ns5Ndh7MktAWM
	 kx+/mfsefJ9vjH25cS/tKQ7P48yWq47e5Hal/SnRc7Z+FdqZwXPnVOfA1jVuMetuTb
	 kdk4JMQoi0YtKb68B0yAdB4cNPI2RbKhzJ0daBqKSRwFDunmJCN7kTpmx/DrAPnAhr
	 HU2kigZT24iag==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Maximilian Heyne <mheyne@amazon.de>
Cc: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241126135850.76493-1-mheyne@amazon.de>
References: <20241126135850.76493-1-mheyne@amazon.de>
Subject: Re: [PATCH] selftests: hid: fix typo and exit code
Message-Id: <173280844877.2348538.8632624571122500583.b4-ty@kernel.org>
Date: Thu, 28 Nov 2024 16:40:48 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Tue, 26 Nov 2024 13:58:50 +0000, Maximilian Heyne wrote:
> The correct exit code to mark a test as skipped is 4.
> 
> 

Applied to hid/hid.git (for-6.13/upstream-fixes), thanks!

[1/1] selftests: hid: fix typo and exit code
      https://git.kernel.org/hid/hid/c/e8f34747bdde

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


