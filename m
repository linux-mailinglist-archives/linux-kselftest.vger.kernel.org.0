Return-Path: <linux-kselftest+bounces-35845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F084AE988E
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 10:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9476A02BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 08:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CE4293C57;
	Thu, 26 Jun 2025 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FP0ISR/K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658B828725E;
	Thu, 26 Jun 2025 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926916; cv=none; b=CNewIsfKhNPpBHPWmetu00zymsEPOn6abHHjX2h/zSC/R2XCdQJmWSliL1ImOqt2rFr5HFiF56jD8l+chmqN5Lmyl+OT9SmEL8Dfo9k/AeN/yXZfoyE4Z6PYM9XIYCDIBHja2I2PT3oCdsQWJZISVeqiSzqZ5tPSYtRcvGR3ax8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926916; c=relaxed/simple;
	bh=nHUZ668U+MnRs1YAZ7/aO4LbEwCxp+qT3jC3qnd47PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITVWJbBlunb3YXwKkLT3HCvqWiL2qUjrPdvJaRG0KTzm3VDZQ8eKrlAjb7QHdpNSJFiqlCSBHoLHdaeqtLPxZdKgCo2zYaOUCuSdIFdgS4OAMJWq0x1cI1rZLPMEfahJsSHk0d7vs0fHCm8C6DZ8fPeQRNDSHDVG/6NtZpQ9kQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FP0ISR/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B791C4CEEB;
	Thu, 26 Jun 2025 08:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750926916;
	bh=nHUZ668U+MnRs1YAZ7/aO4LbEwCxp+qT3jC3qnd47PU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FP0ISR/KkbU8MDlw/EEwLR9YHqsTvWvkgcUOdis6QPGmCj+MtHk8YcmUgNWTK8xaR
	 gQufPOuWtEcSxcK/UOgDoO08S1DzoIes0S3W/yG7Z4lowW1VignwLyjz5f2+Av6sAM
	 QmYJ8ocjop8hUzRjponRhMzL5Pmh2zUM5IUR2DG1bnyjzdJYbLnKMdDQZT8AUE/k6R
	 Se3pc/EovVh51EioT0R926xbqAw/t9o4VN6mZC2tyD+SzWUjcNexRGIL7r0xO19A56
	 f7hiMoVnJX2GB9cPH8DM6+zWqgupkCdFH65foBLsxda+1quxPQZA9xp4juoXnk4qMy
	 SeaGOsa5TJugw==
Date: Thu, 26 Jun 2025 09:35:12 +0100
From: Simon Horman <horms@kernel.org>
To: Malaya Kumar Rout <malayarout91@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: net: fix resource leak  in napi_id_helper.c
Message-ID: <20250626083512.GT1562@horms.kernel.org>
References: <20250625153334.434747-1-malayarout91@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625153334.434747-1-malayarout91@gmail.com>

On Wed, Jun 25, 2025 at 09:03:07PM +0530, Malaya Kumar Rout wrote:
> Resolve minor resource leaks reported by cppcheck in napi_id_helper.c
> 
> cppcheck output before this patch:
> tools/testing/selftests/drivers/net/napi_id_helper.c:37:3: error: Resource leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:46:3: error: Resource leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:51:3: error: Resource leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:59:3: error: Resource leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:67:3: error: Resource leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:76:3: error: Resource leak: server [resourceLeak]
> 
> cppcheck output after this patch:
> No resource leaks found
> 
> Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>

Thanks,

I agree that it is nice to address these warnings.
But for completeness doesn't client also need to be closed
if an error occurs after it is accepted?

Also, I'd suggest using a ladder of goto labels for error handling,
as is common in (Neworking?) kernel code.

E.g. (compile tested only!!)

diff --git a/tools/testing/selftests/drivers/net/napi_id_helper.c b/tools/testing/selftests/drivers/net/napi_id_helper.c
index eecd610c2109..105517dc315d 100644
--- a/tools/testing/selftests/drivers/net/napi_id_helper.c
+++ b/tools/testing/selftests/drivers/net/napi_id_helper.c
@@ -34,7 +34,7 @@ int main(int argc, char *argv[])
 
 	if (setsockopt(server, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt))) {
 		perror("setsockopt");
-		return 1;
+		goto err_close_server;
 	}
 
 	address.sin_family = AF_INET;
@@ -43,12 +43,12 @@ int main(int argc, char *argv[])
 
 	if (bind(server, (struct sockaddr *)&address, sizeof(address)) < 0) {
 		perror("bind failed");
-		return 1;
+		goto err_close_server;
 	}
 
 	if (listen(server, 1) < 0) {
 		perror("listen");
-		return 1;
+		goto err_close_server;
 	}
 
 	ksft_ready();
@@ -56,7 +56,7 @@ int main(int argc, char *argv[])
 	client = accept(server, NULL, 0);
 	if (client < 0) {
 		perror("accept");
-		return 1;
+		goto err_close_server;
 	}
 
 	optlen = sizeof(napi_id);
@@ -64,7 +64,7 @@ int main(int argc, char *argv[])
 			 &optlen);
 	if (ret != 0) {
 		perror("getsockopt");
-		return 1;
+		goto err_close_client;
 	}
 
 	read(client, buf, 1024);
@@ -73,11 +73,17 @@ int main(int argc, char *argv[])
 
 	if (napi_id == 0) {
 		fprintf(stderr, "napi ID is 0\n");
-		return 1;
+		goto err_close_client;
 	}
 
 	close(client);
 	close(server);
 
 	return 0;
+
+err_close_client:
+	close(client);
+err_close_server:
+	close(server);
+	return 1;
 }

