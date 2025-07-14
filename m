Return-Path: <linux-kselftest+bounces-37317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2491FB04BDE
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 01:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 582127B4A48
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 23:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B38285C9A;
	Mon, 14 Jul 2025 23:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELUVVQtz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB0A2798EB;
	Mon, 14 Jul 2025 23:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752534071; cv=none; b=DZ2V4YtMIRWv71Ul4v9hSwzMcmujRdYh1F/+K07pVfQHOHyUAji1IIuvZzvlRz5PdPhHgfpzAXlDgDpwHCErPKgXZhfss9IxgIFQuaufFLYdSVMLIftwa9jWmhG4KjW1YPk+g06YTMjG+83LkjqWYfcmphrQWMD3cu8JH74KLkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752534071; c=relaxed/simple;
	bh=mPLTnzcVFo9sN65SMALh1jphtLFazvHx38AA1rV6i+U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=plXauDsfVqaOgpInFYb1LKxRItfA8T8KR4gr/CGKcH0V9Azx5oYMyvmKBhSpiO1CwYWOYSOK3beOWKKOngzw3QIJSnV/NiYTl9SLLtUoFfKZoK6g4Wlz7VoGoflpRCwVLIKftG9R5To1scrzQJOwmzS70BLFE7gmYW2WgoR/q3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELUVVQtz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40833C4CEED;
	Mon, 14 Jul 2025 23:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752534071;
	bh=mPLTnzcVFo9sN65SMALh1jphtLFazvHx38AA1rV6i+U=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=ELUVVQtzuqw6JTxxdFsFhtriDeda9srP++Rv3asswi6OjWHKSXYKOPoS1KBPeO1Ca
	 Zy14vH0+UIo+OJSGpKWFB9c/1xo2qB0vjSFWqV2V8ErBgxzlG3Qs5k+HqdIjvla/f9
	 r7NyBekKBYE39LvIZrLA6ZF9L+HJZfepTl/lg+nK8/ZeuqVNDe81B2TSBINLc6QRQ7
	 dwALd9Xj+E+iY5BKnj6QMcxr9lbf3JcEc1c1xSSGBPDMNVPD9bdhk9QujvsPFhoQuX
	 EUvYRyAFjlLr0zqBwCygM922l4935WY1lOGY/QHctTduZQvw+AW4Sl4MednorXi950
	 7OztcNnEJwLlw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D4246CE0BAF; Mon, 14 Jul 2025 16:01:10 -0700 (PDT)
Date: Mon, 14 Jul 2025 16:01:10 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH RFC] selftests/pidfd: Fix duplicate-symbol warnings for
 SCHED_ CPP symbols
Message-ID: <5b53702c-0dab-46c4-9cb0-448b4da36c2e@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The pidfd selftests run in userspace and include both userspace and kernel
header files.  On some distros (for example, CentOS), this results in
duplicate-symbol warnings in allmodconfig builds, while on other distros
(for example, Ubuntu) it does not.  (This happens in recent -next trees,
including next-20250714.)

Therefore, use #undef to get rid of the userspace definitions in favor
of the kernel definitions.

Other ways of handling this include splitting up the selftest code so
that the userspace definitions go into one translation unit and the
kernel definitions into another (which might or might not be feasible)
or to adjust compiler command-line options to suppress the warnings
(which might or might not be desirable).

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: <linux-kselftest@vger.kernel.org>

---
 pidfd.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index efd74063126eb..6ff495398e872 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -16,6 +16,10 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 
+#undef SCHED_NORMAL
+#undef SCHED_FLAG_KEEP_ALL
+#undef SCHED_FLAG_UTIL_CLAMP
+
 #include "../kselftest.h"
 #include "../clone3/clone3_selftests.h"
 

