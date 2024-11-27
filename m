Return-Path: <linux-kselftest+bounces-22572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A089A9DAB56
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 17:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C805282006
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 16:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44216200B99;
	Wed, 27 Nov 2024 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="kYHq6Ita"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E084820013B
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Nov 2024 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732723442; cv=none; b=E+zblADbzB+r504Ufwwvwc9PpC4qiRQuegmbTkwscOWG1fbFSBt2enDVUn6A93idBDNytpovD3veXmkqrtXBlO/nSHg/bn/unIgMkn0hiaQtVzEJnXj0TyyTLkCvYepH8X4x+5fwWtAl49vCqKAXgsZLc79urdw2WYHprH8FG68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732723442; c=relaxed/simple;
	bh=hBFtJ6s2jOqV2rXG7eIIWHv7Ge6GEyLU7TIqXyReM9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h7jf/looIoN3Vpnsojday8PelnnOrYk/L+FTv7pOXRzwylG5BIbY87lpPPv4+kx8nvdRiyEXamCeUirl2i9RLpRBLl37nP6WyxA6vpwMeEAqpQisHkjXka3LgnRjZSQ5Ddk/sWwlV7MlcnjdAoFVUa7khsmt9FTzpS6raFlu3Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=kYHq6Ita; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Xz44Q6W3vzN2L;
	Wed, 27 Nov 2024 17:03:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1732723430;
	bh=W6hzVPG//NzKaEDwe3OCRcoZxhvanii6b6apGJF7EoA=;
	h=From:To:Cc:Subject:Date:From;
	b=kYHq6Itaao1g8uVRz9HxfhYc7KPh2gVv4htwOEF1q2dqx9roDEaGCViGJ42M+R+3o
	 9r5kftxFTCuIjLHEd7BwE+wuzHLAUVuFmH8zxA+VJ/B2KMb65k7igSb4G7nDC8O+fw
	 aM3kvkypLHVRYjE2ojzwqm1cTynpiW2zUAFsq75s=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Xz44Q0jPdzwFB;
	Wed, 27 Nov 2024 17:03:49 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH v1] selftests: ktap_helpers: Fix uninitialized variable
Date: Wed, 27 Nov 2024 17:03:40 +0100
Message-ID: <20241127160342.31472-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

__ktap_test() may be called without the optional third argument which is
an issue for scripts using `set -u` to detect uninitialized variables
and potential bugs.

Fix this optional "directive" argument by either using the third
argument or an empty string.

This was discovered while developing tests for script control execution:
https://lore.kernel.org/r/20241112191858.162021-7-mic@digikod.net

Cc: Kees Cook <kees@kernel.org>
Cc: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/kselftest/ktap_helpers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/ktap_helpers.sh b/tools/testing/selftests/kselftest/ktap_helpers.sh
index 79a125eb24c2..14e7f3ec3f84 100644
--- a/tools/testing/selftests/kselftest/ktap_helpers.sh
+++ b/tools/testing/selftests/kselftest/ktap_helpers.sh
@@ -40,7 +40,7 @@ ktap_skip_all() {
 __ktap_test() {
 	result="$1"
 	description="$2"
-	directive="$3" # optional
+	directive="${3:-}" # optional
 
 	local directive_str=
 	[ ! -z "$directive" ] && directive_str="# $directive"
-- 
2.47.1


