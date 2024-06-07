Return-Path: <linux-kselftest+bounces-11417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1515C900A75
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 18:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252161C20C81
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 16:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BDF19D090;
	Fri,  7 Jun 2024 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzKgewzc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C1619D086;
	Fri,  7 Jun 2024 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777883; cv=none; b=aAEH9OSQ5GM49CPxhYKAYYBVvhV2U8VjYElrZsygZ5scEN9UwDNlnzkVxQ6RzxRHJ+wl43xvjPaOuoyduj9M4zgixoO+nEjm4PtU34sgQJOc/tHw0OKa1sP8d/xTiYXNcaGMLmWNd594FUXMuVJvjZZ4iR2pzbnuVnidHG0k0hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777883; c=relaxed/simple;
	bh=aPJpHAeNe0wKoflzT/D8579aR4XIiEdzgLQY7rq35Zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WgCos98DK9yJUPtHRMZIIqW/uDU+aYiN/cLTOZoUKUJXHCcJi+lVElNexD1xlRJ6XImTa7LCaRitjJgZDVMWjBgfKyZG4O/A5Jk19ife+KGnnv+f9mESe8qoch2RlUnIIGA6e+K1t7oB1IFKj7LQEXEWVrpuLkZvcUd13nAuRYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzKgewzc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49FDC3277B;
	Fri,  7 Jun 2024 16:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717777883;
	bh=aPJpHAeNe0wKoflzT/D8579aR4XIiEdzgLQY7rq35Zw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SzKgewzcFNF32RlgUw6Umri7LeDgOGpHE6JurGv11qO0PQ7tlpHuXGZpMfKJGBJol
	 rDaAQ0eNuAD8ixbfc9wWFr1eLLRdr4Z84u4conjQVIjHtO9Zf9eGVbh+L6fYlBToJ/
	 4hO0G2ZUz/XQ0d8marXn3xoZEZaznnoJT7sRyueHJgUBeOGGN1F4RfESfGh5z88KN9
	 weZPmNst9snwy4/lLUMyhY0Y/x4av1b7E4UL7e6YyFQIL+o7da9gMzPMrBnjhRHkJu
	 JwZ5d540XXyj+DG8TU5UQ9aXKPkNcNd1QXDvSFtI1nv1FEWEk6dgpTZax2GeAFxCkZ
	 sWxzLzBSfP+ag==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Jun 2024 18:31:04 +0200
Subject: [PATCH net-next 3/6] selftests: net: lib: do not set ns var as
 readonly
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-3-e36986faac94@kernel.org>
References: <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-0-e36986faac94@kernel.org>
In-Reply-To: <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-0-e36986faac94@kernel.org>
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1425; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=aPJpHAeNe0wKoflzT/D8579aR4XIiEdzgLQY7rq35Zw=;
 b=kA0DAAgB9reCT0JpoHMByyZiAGZjNc+g+wpgVr54enYiE3MSQI9jbS1MMPC63CqfS0ScQ0nvy
 YkCMwQAAQgAHRYhBOjLhfdodwV6bif3eva3gk9CaaBzBQJmYzXPAAoJEPa3gk9CaaBzkcYP/Rzh
 85Zlt1I6xcrSsf3+TPwS7H/AxPlVAV5RGb3na/7sbAx2SmbZPvjhjAqv1wPQ0g370JZnJ0bL6aD
 /NSCQQ/Us5lx05oJc7rI5uSrEyIbdAwXS4jgwaSMA7RSPmVMVN+rz8WgSe7HUU4NqY9P2q2Yrtb
 z+pBx7PP154tYLkoGUNupj94PCaE3jbkNXGLAxQv7bGJGfJyZvCu0VFF6n+nPmfWcad6sFMw959
 BlZLyxZQcBTQ04J7TKs6Hjv3fUvcf+JqjP615+pKWp1mRNZJIwZppRyF1llO4Od2O54f01Agxsw
 bclkHb3CZ1eYKxJP1619yomF6F3+O4olglcI5vRk4bx9JZGxL36DR1sb2tbYqhw/DUtrwkO8HCU
 z+YILY+09zrEg92v01XS+/N/v82PB9xuFJcGID7lKN0jc3P7HHBe2bFAJGcx9R7cKL2vB8EYKk+
 dte8g4xkqqrREJ11X2FcemVjQbNhLxsJws9szYnt7iBtS2LydgR8rg7Ws+ffNNLGMpE0X17ZkFX
 cQ0Iqtb55seWu4vfsRTCFV1OcGuhq1Qzznu+OoYpYEKmKiBgbcW2fYiAPHD5Bgjns6cCRkcQ/VG
 ftFDDPDQiWGMEPHSSNbWAPJdBb6sPI1biTwqhrIDp9Kqs0vhQeJgrkhCP6seRNuzxP1xWV3VqyY
 T4Wuh
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It sounds good to mark the global netns variable as 'readonly', but Bash
doesn't allow the creation of local variables with the same name.

Because it looks like 'readonly' is mainly used here to check if a netns
with that name has already been set, it sounds fine to check if a
variable with this name has already been set instead. By doing that, we
avoid having to modify helpers from MPTCP selftests using the same
variable name as the one used to store the created netns name.

While at it, also avoid an unnecessary call to 'eval' to set a local
variable.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/lib.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index c7a8cfb477cc..114b927fee25 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -172,11 +172,11 @@ setup_ns()
 	local ns_list=()
 	for ns_name in "$@"; do
 		# Some test may setup/remove same netns multi times
-		if unset ${ns_name} 2> /dev/null; then
+		if [ -z "${!ns_name}" ]; then
 			ns="${ns_name,,}-$(mktemp -u XXXXXX)"
-			eval readonly ${ns_name}="$ns"
+			eval "${ns_name}=${ns}"
 		else
-			eval ns='$'${ns_name}
+			ns="${!ns_name}"
 			cleanup_ns "$ns"
 		fi
 

-- 
2.43.0


