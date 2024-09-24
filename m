Return-Path: <linux-kselftest+bounces-18302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E23A98462D
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 14:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F3D284A20
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 12:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576AA1AB52C;
	Tue, 24 Sep 2024 12:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5uGi3Qr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC8A1AB504;
	Tue, 24 Sep 2024 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727182163; cv=none; b=njXqWY2VJK93l83z52X7HsetRkjG3EbWVuugr8NFYTT2jM2uCVa6QiD970jYRioy+cftO6UbLsCnnO2HygQbkywWKLDITtc7O3/rb818+x8bUjJ/5dqIjlWpyiAI5NasBq8SyE8fvCiuHfkVM7tz4Rb/6t4UjElUdWqX9WULqg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727182163; c=relaxed/simple;
	bh=LO5Ym51W/lCnuuYgauXLYWJ18Q2yPGpmI6+acNF2LEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rdjneHTP5GFwlEuGvcK+U605pDk31FtmZQTSLEHlEqR0ZUx9GGWdMZNuFKZmXc5TUgq1Ryfl5cloXv21s1aZh+JTYkA6sYSK3F9fHa7kG3rXfKgINgSiEe9uOKGCafd3K52WoQ1FPlpSr30hHy0PLEvCkd5JPZkbdF6nf8Ew/f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5uGi3Qr; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so8486445a12.0;
        Tue, 24 Sep 2024 05:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727182160; x=1727786960; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ATLND/ulVBImOJZTRJjgPvVJmcSH41Oohznm0kzcbok=;
        b=D5uGi3QrwWWzSZsmpcN8nRZXEEURTVG7qJr1uMfHTBTBX1m9/0ySTuDCYQpOe4giwA
         IsBL4xRUhrfRZqaIT/6IdNV5Fkex4uChOCpYXQI8wdNB0loDrrWgKtupFZ8hfg76+GUs
         3Ub0HnKOX+t7J4ITwINJ5YLKE9PfmPfWhRq4hCMOyE+PEnVUH8YQ9CjVAfGTiTRg1oUa
         23ZFWJowRaHB3Sfkmc7lPIrNDnmYxSfVJQCwoy5cpKWLfzDzHLPbh0eeHwwaBI64XWh1
         +bEte0Wlr907LX7pVvRgiB9nz48ei+05rOot0r+oxRIcidE97fN5Z7dxuh5n2/Cxq9Fn
         Tr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727182160; x=1727786960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATLND/ulVBImOJZTRJjgPvVJmcSH41Oohznm0kzcbok=;
        b=cK+DQx0+AAM5ntTjXKjrYWT+WJFK9F/UXN53KtLlanlTEckXSwT5thTTvjZWfxzWBv
         /ZU7CczwfvbBUYrMBsNb5ljPdSayV+PgDrUla1QlNwLGu3yizEMG84K0ZeCd80kaDyW3
         A4c66rrmLsuKtxGQYvBVYTv27Y17/c3ML8lmVJNTfUszSFjtM/XLnOigNfuAZBST5/oY
         zwBpes300NuNcjuO/ZZwLEdWHCg5rrJ+iZ1cnMPrtFhIi7jFl91DqczJF9w8KoxM4sFe
         eS3JEVnHS0kE6PwmAhAjeoWEH5BykiRrN4pq8WaZYgtAUeANqrEjDqFTtXlcChIZtN11
         8cQw==
X-Forwarded-Encrypted: i=1; AJvYcCU3eamxsEHK9+VzN4bHIJmEuPGvDdFQjkLFaStGLwN/p8zEiDXWFWk9jDHWf+wLPuI/E0LL0gLET0n4a6U=@vger.kernel.org, AJvYcCUIOkvaO/HANj5/M8g9Xm+htu+cUuBKhGxFJ9RWAaAjF/IrJfiEh/Y+uKjmbBk1rpM/768Al5Sa@vger.kernel.org, AJvYcCVEO6w+fI2DuckoGg1zN3+IAPOWpAwAM0PbC6xY5ANTS21OPyCzK6dUwV50fO4SuJBZPv6rOaZh2Pvabg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYnrm18w0DzvGP1S4cRnE9wi0Q2OEMQM8Vq4cXRtmT53SYekYe
	HiK2wKIi994YtvJ2alJ9aKCdPkeP0CbguwCtJOVm1VVrDecEJTM9
X-Google-Smtp-Source: AGHT+IHamjTFjQYq1vldIPMubyb9QkSRWS2ewigU+YzaRt6cjVj54GmmaARVLhVKcpK+0v115j7RLg==
X-Received: by 2002:a05:6402:27c7:b0:5be:e9f8:9ba4 with SMTP id 4fb4d7f45d1cf-5c5cdfa92famr3483435a12.4.1727182159802;
        Tue, 24 Sep 2024 05:49:19 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4c500dsm704932a12.61.2024.09.24.05.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:49:18 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 24 Sep 2024 14:49:10 +0200
Subject: [PATCH 4/4] selftests: exec: update gitignore for load_address
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-selftests-gitignore-v1-4-9755ac883388@gmail.com>
References: <20240924-selftests-gitignore-v1-0-9755ac883388@gmail.com>
In-Reply-To: <20240924-selftests-gitignore-v1-0-9755ac883388@gmail.com>
To: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Allison Henderson <allison.henderson@oracle.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727182152; l=787;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=LO5Ym51W/lCnuuYgauXLYWJ18Q2yPGpmI6+acNF2LEU=;
 b=4lT98Ddiwcm581PsZpKvMmrifpf2qtf19A4uwmebrnAAQY8KnFZ6AVUchH88aHOF0UEVdv9ZN
 fpgSpAQjBvbAAutqUqnMMflIT0n6wJq4bblytG719m51YGgisKqyt3S
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The name of the "load_address" objects has been modified, but the
corresponding entry in the gitignore file must be updated.

Update the load_address entry in the gitignore file to account for
the new names.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/exec/.gitignore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
index 90c238ba6a4b..4d9fb7b20ea7 100644
--- a/tools/testing/selftests/exec/.gitignore
+++ b/tools/testing/selftests/exec/.gitignore
@@ -9,7 +9,7 @@ execveat.ephemeral
 execveat.denatured
 non-regular
 null-argv
-/load_address_*
+/load_address.*
 /recursion-depth
 xxxxxxxx*
 pipe

-- 
2.43.0


