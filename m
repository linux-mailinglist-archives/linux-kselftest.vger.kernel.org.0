Return-Path: <linux-kselftest+bounces-38834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02559B243E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 10:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6757A7B77EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 08:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538712D5A14;
	Wed, 13 Aug 2025 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akzjSlKh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBE92D0C6E;
	Wed, 13 Aug 2025 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755072856; cv=none; b=LFhuZsG8BX7Y+eXdkvrh/OMbwIyBh5TGrgEPFiblrISYgZtPf/0uSYID1mRwFW5z8AboE2gg3TrAvNBtf7qp982NrnA9FDOe3ilXGqOR+OSw/MBbMqQqdpUhbsKOz1DWFKr5ROz3wBtY156FHYWJCJ0lJme0mLFrUSsdp/v1PKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755072856; c=relaxed/simple;
	bh=/4olKLtmWPWcSGHPn/cqbAjrBAM0jlr8DIHPwavONtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JxPbA+1c1afpdFUr+YL++kSDiqEf/Rah5zQOwtXLJwGInVQrYcqGugKH777d50Utplar9YsFUaFsHPIrLCZ110jnwV4B5BoSxIVKzUXPVeFnkYEiCUVpdXowzBP/eGnSHG03qRSUVcgqohNjM+e7FD6aScuBIoRzF8r/UQGRyFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akzjSlKh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a15f1a073so3581625e9.0;
        Wed, 13 Aug 2025 01:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755072853; x=1755677653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ygmsewkf5T2USbfV7/eaFtCh/3kTJRR7dvKlmbHq5Jc=;
        b=akzjSlKhk308REzi7DVeIgPs4EYS0+NIr7IeYyErhVA1OZpWNh8CZK0eQyTnIty2K9
         DPn5a7kNZ2zAksrrQxWWTqKD45OOf3LCVZYCjHoQgQWrOUV6GigMELQLvkRQgkBy4Q1N
         R/HShDvBYCCS3hXTHuE6jN4IauX+HFIdlEAwc8y6ZMP4JYwArNFw+q/SA1Lv0FTLOx7a
         hXi7BeSfQsL1SZ4qPXKcY9qr2TCxdhE8XlCcuDkpdMSI90nInHiyIG7mKhu6QXv7r2ap
         hTjjkPmX/CDIFlJ2aQQJsoPdPsj9avwCtC08gLd4dhqk9WkWlb/Ng7pAWePSBbw0uGpn
         VH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755072853; x=1755677653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ygmsewkf5T2USbfV7/eaFtCh/3kTJRR7dvKlmbHq5Jc=;
        b=Z7CtNNn6DoK50phBA/f+AMSjphZL2byJhS6tgroyXh4w+qRogKEcrc2igN4eWdWzYM
         5SN3vZB4uepgjXgs8HBgaJkxQ8vyZ21hqX2UiEP0ufsFIW6AjL0XUL1MaIMxwB+C0TVN
         kShsQU0XdFLopd+Fo2VwxKrNpypOref22FC/b83WiiLs3Pm3pHOcT37ZkvONfjNHMLQy
         2qvEUzucK6OXXAXlboKoWUJD/5ormMTu8IXW5nlCR8KbGVDSueeI3mSpSqExGU5jVMdu
         5qxgyFzuc5UyRLQg506BzURomZxRAm94JqTJdo+79vBIgQC77Pfo+AZXn7ZwUpaasXP9
         o+pg==
X-Forwarded-Encrypted: i=1; AJvYcCVa0H2Lu/gXnK6QEJ1M5URxKGrzwPBN3oeSKOH0xL03cdV/swdKUAojWKSgJ+XPVo35ncrswzEMedxsp5I=@vger.kernel.org, AJvYcCVhkHE4Ulw6UjNNHVA3+1rHf1y/VU1fGUQK4y+QbD0X04aFC0cLzUMwkakzSCucY6TXpDuN8DSu74dW/dzbwHrw@vger.kernel.org
X-Gm-Message-State: AOJu0YxRI6onPrV+BkGA2K0oqV4Yw7rTmu/F/YBTC70/toiSpiMey/2s
	Dl/7/IvXlb3ikadKos0TX3uSdqwigoNH722IDzIBR3Wb0NLRe/FEOSyb
X-Gm-Gg: ASbGncv9YlIPM5OkvGkF52+7rg8NSiPzo/26SJMT5h8gjTaS+qiVt57hXJVjGm7zyTv
	NEHBYW69IvNB2rGlZ6Zzd/KFPJf+JR59d+PKeUljcfc08D8WoXfhbDqdYxvvsAirT1pouNtkJFh
	cNXZvrvPzIFBET1I4xc1nrVt7g0yi8XN2YufTwpPv4vkB6tAPjvSTnlm8p37LNrat8WAlSn7H79
	lPpJ9kSeihLdeahtXd5So2TEIAwrsJuDYHDlPR6d11rmN+6bFjsdYmVTq7zQK7+yeAZxmxfltWn
	V58xrS5xiJoCCbFvo+4kctOUtQX0/6iBvGyTGmQRi3Pr2nDTg5WDcovwKCzFXpCY3nF3KQ3RpcH
	XzH+QhFW1/V77pk4p5+cW
X-Google-Smtp-Source: AGHT+IG3yh7PyjDQgWpA08nA+Rs57/Rf3ACPKR25hbtuA5dzYAhDSBEN6RkmUj4SepffsfVfC3aqlw==
X-Received: by 2002:a05:600c:3b10:b0:456:1281:f8dd with SMTP id 5b1f17b1804b1-45a1704e410mr12559155e9.12.1755072852760;
        Wed, 13 Aug 2025 01:14:12 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3c4beasm45554467f8f.30.2025.08.13.01.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 01:14:12 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/mm: Fix spelling mistake "mrmeap" -> "mremap"
Date: Wed, 13 Aug 2025 09:13:33 +0100
Message-ID: <20250813081333.1978096-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are spelling mistakes in perror message. Fix these.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
V2: fix typo fixes, I need more coffee
---
 tools/testing/selftests/mm/mremap_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 5bd52a951cbd..e289bb1112db 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -846,7 +846,7 @@ static void mremap_move_multi_invalid_vmas(FILE *maps_fp,
 	}
 	if (err != EFAULT) {
 		errno = err;
-		perror("mrmeap() unexpected error");
+		perror("mremap() unexpected error");
 		success = false;
 		goto out_unmap;
 	}
@@ -899,7 +899,7 @@ static void mremap_move_multi_invalid_vmas(FILE *maps_fp,
 	}
 	if (err != EFAULT) {
 		errno = err;
-		perror("mrmeap() unexpected error");
+		perror("mremap() unexpected error");
 		success = false;
 		goto out_unmap;
 	}
@@ -948,7 +948,7 @@ static void mremap_move_multi_invalid_vmas(FILE *maps_fp,
 	}
 	if (err != EFAULT) {
 		errno = err;
-		perror("mrmeap() unexpected error");
+		perror("mremap() unexpected error");
 		success = false;
 		goto out_unmap;
 	}
-- 
2.50.1


