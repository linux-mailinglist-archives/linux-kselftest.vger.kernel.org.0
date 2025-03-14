Return-Path: <linux-kselftest+bounces-29072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F57DA61D61
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 22:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2E1883C00
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 20:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2DE1CCEC8;
	Fri, 14 Mar 2025 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oq9RGNzS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58E619E7D0;
	Fri, 14 Mar 2025 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741986003; cv=none; b=NkS+x4MN6Z+lo1m1c4QwJZ5jyS2kt3gvUFPFf5ROhFquNDM+8TT2ile7kIcmHRmugKpapGY3A0xvqU9wZuM5acHckkrrolHB2i8KZ93iXBGJCOsGsxsznScjBldiIQzmUSJWZlEjLqjEhx7qp64rLlBG+TkIPKjc04YWHe0ENig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741986003; c=relaxed/simple;
	bh=8Ccq2FrCkRmh50koBGuV/jVa139ky6hOsEJQjokKvPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxx4qHrsD+CVBw+5DwjeHge3IvLJR3uHajA5yt/ilkkOmhjRFlcggYh/wqgBbGjpCN3ivEPpFF0vIErPFWovptOZW5T925EdC4Ihk18ccZMekD70vklLWTFdngeZmAg8H3wxp27Mu0dVpCZ+lQZKDV94vZgD2dk/vUT/U8+fggM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oq9RGNzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A633C4CEE3;
	Fri, 14 Mar 2025 21:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741986003;
	bh=8Ccq2FrCkRmh50koBGuV/jVa139ky6hOsEJQjokKvPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oq9RGNzSD20i+qbD1q4y3DDffLW79X+4q+XPWbq3D2se3l2EpQQcdpFI8qdKCVjxG
	 8n+/C0UkMFi6fboYwt/+zGqWtzukoUtmwXCHGssGy4T47dB7l9VRR6vHkqlow46NU+
	 pkfxHT5mtw43Xq+bY1X2XDy8xgokEj7i6B/Ebfz6JL3xO6SVTLd8pq2S4HB/8Qsxbb
	 SENpexJiyfABT7UKkauWfFXNTKhZUbSEl32wQ1fqg4KnIPgk4xcvLshcDTyFybKD0l
	 4LLm5yOFxcNPAG+h3LUoHAeOy5+YrHGF2kdKcrohpRldufqiUbTEF0MiV+DlwSDnfN
	 bbyDUizZFgFwg==
From: Kees Cook <kees@kernel.org>
To: David Gow <davidgow@google.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Tamir Duberstein <tamird@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: (subset) [PATCH v9 0/6] scanf: convert self-test to KUnit
Date: Fri, 14 Mar 2025 13:59:29 -0700
Message-Id: <174198596655.151146.11778711834752944011.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>
References: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 07 Mar 2025 06:27:33 -0500, Tamir Duberstein wrote:
> This is one of just 3 remaining "Test Module" kselftests (the others
> being bitmap and printf), the rest having been converted to KUnit. In
> addition to the enclosed patch, please consider this an RFC on the
> removal of the "Test Module" kselftest machinery.
> 
> I tested this using:
> 
> [...]

(I had to rebase on the printf move, but I think it got it all.)

Applied to for-next/move-kunit-tests, thanks!

[1/6] scanf: implicate test line in failure messages
      https://git.kernel.org/kees/c/5866730da723
[2/6] scanf: remove redundant debug logs
      https://git.kernel.org/kees/c/6340d61b9005
[3/6] scanf: convert self-test to KUnit
      https://git.kernel.org/kees/c/97c1f302f2bc
[4/6] scanf: break kunit into test cases
      https://git.kernel.org/kees/c/d62f8c95470c

Take care,

-- 
Kees Cook


