Return-Path: <linux-kselftest+bounces-2531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 962D18203E1
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Dec 2023 08:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D21B1C20AB0
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Dec 2023 07:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435FA1843;
	Sat, 30 Dec 2023 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AoqxjK3e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D92728F8;
	Sat, 30 Dec 2023 07:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703920580;
	bh=PchXuul0g9RoRBGhYz5X5+1f1bVnhlkCfxJtLzU81r0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=AoqxjK3enuMiIv7gQkxemmSAB1cfxZ7QyfK5DSY9LIlJiNyS1OcyI+S3nUMQMOwzT
	 tuj1bg2lk4rhvUrKYvUhOil3SfA1K6LMbOCG2fPV0cMubwyJ9PTR2/6BEFNdI+em3M
	 zOP2bHS3xlOfYkiMV2k/Tls5UcV1Qe1UTEHiT8vi3VkNLZCnZie3UFZ2oOff3p37i7
	 F39vkawdqUzoBxGdL1GKhX4pSIb/MyN/zVKcr1TByL455ZWr/ouHWiwarfW0dP55U+
	 xVI0IrZ3mK3HJKyGlfZjihkS/f/F0LAdDXBAKxVxhybCCpaoXvnjll/zxwKJnrfrGV
	 vYaSLDpwiVnyw==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1CD67378045F;
	Sat, 30 Dec 2023 07:16:17 +0000 (UTC)
Message-ID: <0bac8f5c-5531-40dc-8b64-b1e079f99a1c@collabora.com>
Date: Sat, 30 Dec 2023 12:16:16 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: uevent: use shared makefile library
Content-Language: en-US
To: Antonio Terceiro <antonio.terceiro@linaro.org>,
 Shuah Khan <shuah@kernel.org>
References: <20231221204908.341677-2-antonio.terceiro@linaro.org>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20231221204908.341677-2-antonio.terceiro@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/22/23 1:49 AM, Antonio Terceiro wrote:
> This makes the uevent selftests build not write to the source tree
> unconditionally, as that breaks out of tree builds when the source tree
> is read-only. It also avoids leaving a git repository in a dirty state
> after a build.
I can see what you are trying to do. The makefile has issues such as lib.mk
should be included at the end of the file. Please just clarify this in the
message.

> 
> v2: drop spurious extra SPDX-License-Identifier
> 
> Signed-off-by: Antonio Terceiro <antonio.terceiro@linaro.org>
> ---
>  tools/testing/selftests/uevent/Makefile | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/uevent/Makefile b/tools/testing/selftests/uevent/Makefile
> index f7baa9aa2932..872969f42694 100644
> --- a/tools/testing/selftests/uevent/Makefile
> +++ b/tools/testing/selftests/uevent/Makefile
> @@ -1,17 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  all:
>  
> -include ../lib.mk
> -
> -.PHONY: all clean
> -
> -BINARIES := uevent_filtering
> -CFLAGS += -Wl,-no-as-needed -Wall
> +CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
>  
> -uevent_filtering: uevent_filtering.c ../kselftest.h ../kselftest_harness.h
> -	$(CC) $(CFLAGS) $< -o $@
> +TEST_GEN_PROGS = uevent_filtering
>  
> -TEST_PROGS += $(BINARIES)
> -EXTRA_CLEAN := $(BINARIES)
> -
> -all: $(BINARIES)
> +include ../lib.mk

-- 
BR,
Muhammad Usama Anjum

