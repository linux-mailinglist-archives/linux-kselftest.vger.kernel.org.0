Return-Path: <linux-kselftest+bounces-37110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445D7B01DF4
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 15:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB3E175015
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 13:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FFF2E5B26;
	Fri, 11 Jul 2025 13:39:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D522E54BB;
	Fri, 11 Jul 2025 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241147; cv=none; b=H0RmAYLF3DUEP3sZaGaLdDlIXjUFuKRg7AWH/apUCvYpt2uV+Xs2DKo4k2KwNbjf8SvuinTOgMJ79tL0+Atg2p6kLjIUmUGJBudVBkRbOBGQ3V4dCqkyIBoBfuzOBYou/8yHcIjx9qVF2AjGiu58huDk7NnLdSetVQeAK5sku80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241147; c=relaxed/simple;
	bh=UU5k80l2ei5TRgoTq9iRmJnyQtYBDHXCfdvXSG9D+4w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N7IjB8IcUN00GTiXafBLGgG0LLiyfE8Hs8JNyM+/KX7brxFWmBDtIGBEub9BU6E6QKpoFO27m1gm3sZfZ0DPEKvJmAPCzT4opqU9tB0+DEGqwZ5WESwYu/95NappLEDSOTacYfCfKs2iffyuoC1S/itEqrcK2az1b/iJPX3I5hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4290C4CEF0;
	Fri, 11 Jul 2025 13:39:04 +0000 (UTC)
From: Daniel Gomez <da.gomez@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
In-Reply-To: <20250711-kunit-ifdef-modules-v2-0-39443decb1f8@linutronix.de>
References: <20250711-kunit-ifdef-modules-v2-0-39443decb1f8@linutronix.de>
Subject: Re: [PATCH v2 0/3] module: make structure definitions always
 visible
Message-Id: <175224114462.57001.15162198119283395382.b4-ty@samsung.com>
Date: Fri, 11 Jul 2025 15:39:04 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev


On Fri, 11 Jul 2025 15:31:35 +0200, Thomas Weißschuh wrote:
> Code using IS_ENABLED(CONFIG_MODULES) as a C expression may need access
> to the module structure definitions to compile.
> Make sure these structure definitions are always visible.
> 
> This will conflict with commit 6bb37af62634 ("module: Move modprobe_path
> and modules_disabled ctl_tables into the module subsys") from the sysctl
> tree, but the resolution is trivial.
> 
> [...]

Applied, thanks!

[1/3] module: move 'struct module_use' to internal.h
      commit: bb02f22eaabc4d878577e2b8c46ed7b6be5f5459
[2/3] module: make structure definitions always visible
      commit: 02281b559cd1fdfdc8f7eb05bbbe3ab7b35246f0
[3/3] kunit: test: Drop CONFIG_MODULE ifdeffery
      commit: dffcba8acea3a80b3478750ac32f17bd5345b68e

Best regards,
-- 
Daniel Gomez <da.gomez@samsung.com>


