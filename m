Return-Path: <linux-kselftest+bounces-28968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E539A5FDC4
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 18:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355ED880122
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 17:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E1616F8E9;
	Thu, 13 Mar 2025 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsiJ1vS4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AFD12CD88;
	Thu, 13 Mar 2025 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886939; cv=none; b=akdWVFGE36tFFRXuGjDQz9nobRABRxkOSX2rTwVTY+mvkQ9WaHOTsWxJisoTZRc5OsYbDPEYI0Zjk1H8dgk/J60sc7PqW2PpOhGQuvShPCOahALKUK3rWGTj/hcD9tpLtQn0uoWG6aNqWjqqxPyP36WE2eBykQjuz+pfXeLzBtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886939; c=relaxed/simple;
	bh=pCKx8h4RdPEXnrliEof7w9TGctCJ+lkyJAvPxZvj8as=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liW8s5H1NxzBeCRiIcQJdhCxAjugRR2ma55gP5ZLu5BPx0W8jO47KebiC4Lh6Yn9BaMynJtavHE6ut1qHkym9j1Le3oUD8+W4h+ZYOvnHcZwq6iMyHJNI1laGUP9pqVJPm2xvuS9L8S9eJIVSt78TzFoob3/E3VwT54e7pBdYZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsiJ1vS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78296C4CEDD;
	Thu, 13 Mar 2025 17:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741886938;
	bh=pCKx8h4RdPEXnrliEof7w9TGctCJ+lkyJAvPxZvj8as=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WsiJ1vS4VkmRkEQ91gUkBcXJpHCkjiQdXuKiOQrrIiFFBXTiyzWC1lNxpbasmhUpq
	 3JfyOHYn+nAM5kLaFI7eKKMk0HVf0PYt9MfKkoBJ8D20YQKw1ngGTv9SXVphquEE2h
	 5FlTV4pustJ2ITwpRF1Mfnt55HA7MhFAT/DH8k8bfDg8uSfYhcoZzDsRwQ4++FKCuA
	 ot/lfD8WMiYADiTKuF+3761zflCg4viKvvK9vcUUI5qt7A6AsUxSPP/q9N2rzjlyFr
	 zE/pTffZvM1VqP7YEYZUp20FKgVv5uizsSJhZI1T/0EIjucCggWl2hxTSmb3uw6p4S
	 9WKQ0vOSUIRTA==
From: Kees Cook <kees@kernel.org>
To: Arpitha Raghunandan <98.arpi@gmail.com>,
	David Gow <davidgow@google.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Tamir Duberstein <tamird@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org,
	workflows@vger.kernel.org
Subject: Re: [PATCH v6 0/3] printf: convert self-test to KUnit
Date: Thu, 13 Mar 2025 10:28:50 -0700
Message-Id: <174188692856.3317505.16138391415680640168.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307-printf-kunit-convert-v6-0-4d85c361c241@gmail.com>
References: <20250307-printf-kunit-convert-v6-0-4d85c361c241@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 07 Mar 2025 17:08:55 -0500, Tamir Duberstein wrote:
> This is one of just 3 remaining "Test Module" kselftests (the others
> being bitmap and scanf), the rest having been converted to KUnit.
> 
> I tested this using:
> 
> $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 printf
> 
> [...]

Applied to for-next/move-kunit-tests, thanks!

[1/3] printf: convert self-test to KUnit
      https://git.kernel.org/kees/c/7a79e7daa84e
[2/3] printf: break kunit into test cases
      https://git.kernel.org/kees/c/81a03aa9b88c
[3/3] printf: implicate test line in failure messages
      https://git.kernel.org/kees/c/034bee685fd4

Take care,

-- 
Kees Cook


