Return-Path: <linux-kselftest+bounces-13007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E16F91E111
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 15:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CBCF1C2149A
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 13:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B230314B96E;
	Mon,  1 Jul 2024 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSlOq3FG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E90B1EEF8;
	Mon,  1 Jul 2024 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841601; cv=none; b=kfehG14slVnTILjxp5S/oEh4We6y3LjQ7mpqJbCSRcgWjcZtduAS3a4MTL3Ej2F0klmz/OUCcDG+x6avjXzwti6KlrPa3uo6n4qNjLkRVhDL54xVSvSY6nZWq4FVyZAi6wmrddoKntqlztVywH+8hJQ6Aa0UGUPAw6UPPEL/N6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841601; c=relaxed/simple;
	bh=Ya0S5zdi+7SsyR/6A/c4L3sTSewdGTHlOAshJGwLjKU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=txHs/9Uu6azgfAQvFTl/YNAAa7NfkI8laWLA30Mo+ukQB4v+KyU1f4Xkru622KSJ8Y/jjzCknJ6hYhsS9QbJ+eMkFPSNj2Xbmqc5mLIUQU2D76oGP4yH+RD+X4k8WnjZGAEaxNf2HwI+Qie/W6Qp1yave88w6ut0oKWzd/D03ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSlOq3FG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48561C4AF0A;
	Mon,  1 Jul 2024 13:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719841601;
	bh=Ya0S5zdi+7SsyR/6A/c4L3sTSewdGTHlOAshJGwLjKU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cSlOq3FG8SZuh4akDuACZJxd2A4gtLhs3pFh0tx9ufyM4qJRfpx6cixnhO0YyLMQU
	 KqBFXcrk5WrmVgthXrf1PtMTtA1zDLMpgalrmgJESpgRzvFe7xDYx/4X9Kgv0daPor
	 LO7xWI0dM6BKRXTaqiXkOVDwIBXSmOZmlXDBWGMKFiKYBLlVjoSqpHVErrHPNyaIps
	 lSSBpSrWzJF5DjH1c/fKwqRr5TOoODrU72VH0b7TUbBbgbIvD1y9UL/pB4py5Rft+w
	 fkC45O3nuqyL2XCH5h3gCPjojgsbHemesLXpoTiLkfX+TzidQlVeNL0PmrQXfJ1BT9
	 fCbqiXyaNMWhg==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Stephen Rothwell <sfr@canb.auug.org.au>, 
 Mirsad Todorovac <mtodorovac69@gmail.com>
In-Reply-To: <20240701-fix-cki-v2-0-20564e2e1393@kernel.org>
References: <20240701-fix-cki-v2-0-20564e2e1393@kernel.org>
Subject: Re: [PATCH v2 0/4] Fix warnings in for-6.11/bpf
Message-Id: <171984159899.804118.13748285528625314885.b4-ty@kernel.org>
Date: Mon, 01 Jul 2024 15:46:38 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0

On Mon, 01 Jul 2024 14:39:48 +0200, Benjamin Tissoires wrote:
> We had several complains in linux-next that there were warnings:
> 
> CKI was not happy: it was the same situation than in an early report
> when HID-BPF was initially included: the automatically generated
> vmlinux.h doesn't contain all of the required structs and the
> compilation of the bpf program fails.
> 
> [...]

Applied to hid/hid.git (for-6.11/bpf), thanks!

[1/4] selftests/hid: ensure CKI can compile our new tests on old kernels
      https://git.kernel.org/hid/hid/c/fcdf830ea634
[2/4] HID: bpf: fix gcc warning and unify __u64 into u64
      https://git.kernel.org/hid/hid/c/762ced1630a9
[3/4] HID: bpf: doc fixes for hid_hw_request() hooks
      https://git.kernel.org/hid/hid/c/c79de517a226
[4/4] HID: bpf: doc fixes for hid_hw_request() hooks
      https://git.kernel.org/hid/hid/c/c79de517a226

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


