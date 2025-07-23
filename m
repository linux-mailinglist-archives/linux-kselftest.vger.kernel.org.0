Return-Path: <linux-kselftest+bounces-37899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4580EB0FD34
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 01:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 185CA7A0504
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 23:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F6D24C07F;
	Wed, 23 Jul 2025 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JU1W6Nk0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCE4282F5;
	Wed, 23 Jul 2025 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753312426; cv=none; b=YCLGpXrZKWII6JN1ZHJGOLLrryDNLJuOGLxo/xrkV6k1ocVqR6HjF882f+gO/p+oKyiSUJwrJIB1eHl0sHMl7LrhfiVm3ETDG5VEZf+81xqXhQkFWWeylrMTESJrgrCvwojo2T0a2Yoe42osj/eFzzlB/nkDKyZRQV+szGDI0y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753312426; c=relaxed/simple;
	bh=fXMV2vvKm4llTIOGAsPGj+uZg1KmKtboQwMEFSX2GQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBhwpfpdRW0Utmtjglsa/tY3wP0Cs4dLeYdqYvEtCZAiCbNXvkRy1mtAzYYmkt93eVwDTBb5dkxsXxV8IBtRg1IbiQPXbNq1pDCMz8DIzLKl1Sei1qGEn3XIZHR755aKphD9rgAGYRTBT6JukhJ8l9bYigGHmsvY37IhzhSlrd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JU1W6Nk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69A8C4CEE7;
	Wed, 23 Jul 2025 23:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753312425;
	bh=fXMV2vvKm4llTIOGAsPGj+uZg1KmKtboQwMEFSX2GQ4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JU1W6Nk0UOOt2PVIEt6wJ3kFu9s3j0Avky/E3GhopdrMKG4JlDRPQigeDLgzkzSyu
	 +p8kSbvQsXXWcOfzI4mA2IxfmvjABbNGxkZeRZ2EM9kj85j5p/3QQMt6C78j755EE0
	 zSqHN3tkNdz1FdOCmtjHIGkssAdUOMNy1HndU8CB9a0z7oqKxefKtWbdQmDWPIDLVQ
	 KEhoWpiXD4YFzZQUJTpU4uJ6Air/4AF95vaUYAvToVn4BG7UT8ZrPqzBAJF1we16hF
	 qPeAdVenxoLdGRWBRkyje2qQptrIdxj1R9MAtLT5VkisCGIzHqc1FzM8tTaLGT0Xnh
	 oaCjiOGnzaN8A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 53F27CE127E; Wed, 23 Jul 2025 16:13:45 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:13:45 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2] selftests/pidfd: Fix duplicate-symbol warnings for SCHED_
 CPP symbols
Message-ID: <cc7e4fe7-299f-4bf3-af46-df6551d61997@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <5b53702c-0dab-46c4-9cb0-448b4da36c2e@paulmck-laptop>
 <f82e3092-31ab-4ceb-a51f-208d13e7b2ec@linuxfoundation.org>
 <dbb9ca63-15d5-4547-beb4-5c4044938967@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbb9ca63-15d5-4547-beb4-5c4044938967@paulmck-laptop>

The pidfd selftests run in userspace and include both userspace and kernel
header files.  On some distros (for example, CentOS), this results in
duplicate-symbol warnings in allmodconfig builds, while on other distros
(for example, Ubuntu) it does not.

Therefore, use #undef to get rid of the userspace definitions in favor
of the kernel definitions.

Other ways of handling this include splitting up the selftest code so
that the userspace definitions go into one translation unit and the
kernel definitions into another (which might or might not be feasible)
or to adjust compiler command-line options to suppress the warnings
(which might or might not be desirable).

[ paulmck: Apply Shuah Khan feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: <linux-kselftest@vger.kernel.org>

---
 pidfd.h |    9 +++++++++
 1 file changed, 9 insertions(+)

Changes since v1 (RFC):

o	Added comment explaining the purpose of the #undef calls per
	Shuah Khan feedback.

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index efd74063126eb..254eaa6cc4dfa 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -16,6 +16,15 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 
+/*
+ * Remove the userspace definitions of the following preprocessor symbols
+ * to avoid duplicate-definition warnings from the subsequent in-kernel
+ * definitions.
+ */
+#undef SCHED_NORMAL
+#undef SCHED_FLAG_KEEP_ALL
+#undef SCHED_FLAG_UTIL_CLAMP
+
 #include "../kselftest.h"
 #include "../clone3/clone3_selftests.h"
 

