Return-Path: <linux-kselftest+bounces-29723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42242A6E7A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 01:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADD857A329D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 00:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8940813B58A;
	Tue, 25 Mar 2025 00:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JV9ajm4O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767097F7FC
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Mar 2025 00:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863245; cv=none; b=PQ9ikFofiJz33vhn0w6e6cSuaCD9K6ujWbDUXBUOlr5qVNbSqsGJNZum7ggbc+xyugt6AvEbR7jUJY3s6mYKF9Bduvzxy+Q7mixPdHXLWiZPPkPvjz7PXLs++E9iKQu4PwOeb9dvldtMYVKPBumuNCMCLNvTT01hx0U3WmIJXtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863245; c=relaxed/simple;
	bh=pMsuxiH98R/tg+nSDDe//UswCW249ayBOYttHK7f3/c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YN11DTAgCBSAitraonIK/OYqDVbeP4PrPHAP1VbiFefzJtR9l/Jkq0kQ7e0HtRZykctB6iBsDZ3yntvNUvsu3X9W9ZFWzitjYDqJijZtcWuj1FcFltQrnS1rLWwib9T6nOSWBA1+OdPhhjjfwS8cFOva4VLf9Xl+jkKMe1E4tlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JV9ajm4O; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2241053582dso23006825ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742863243; x=1743468043; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aYO6bJ8zL5aeSIvQoR3y8gnTb2GfsftmkAHE8LswBPM=;
        b=JV9ajm4OTiy0bUJ43a/mQtuA3yzfwiiln6r766hp/oFwojHHs/HOolyUtWepeVZ0Df
         EsV5YH0pUBRTpLIpJSnnh6YDFL60amJHa/o2upLkj9Fsx5+YvsL+xjgND1h6SUvzHXxC
         WNquyagCXTiclFSOBw+R91XqQCzEkdDIN4Y0z4sk0Aq7P8jpXMsNpx6AlB6WeukreYSq
         f9E5tnpK91Q1cK6vPJnpYblv/Yk0rE27TN1xXWG20shGFWTIIC06qkxN02h7mqNRKkak
         VUqqj7QIvRRlt31hnxCNrtFI3kMZKz1GPJ9Qk+8u21xHumDMFdBD9TpjExk6SvcUB2/i
         6jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742863243; x=1743468043;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYO6bJ8zL5aeSIvQoR3y8gnTb2GfsftmkAHE8LswBPM=;
        b=jbLCJM3LodBYHl+8svPCUF9sYbGetko4UdQPpZeBtMqus1SXRxMax5i8954/GXMmpx
         1Y0168Lzb0p5IKe/LoHJpjcXp6O9oK1O8JVv4yUqz/cSLOAQcdlsFNIiE4OO7oZeptyd
         /yDyOvf346I4Glca9lgo1E0MLgUvWonumtfdL/SAiWeVW8KNqc34tUtQGoR1Wubo1/nk
         MEfVJbreNgT2ga20+GyQS4FVcHyk3iTAN9yBgV4jVx6gFuubnWJX0/kvj0kj8NB8Qxy9
         YM5+PPtffOsNcPpEDBsCnF0LwwlbGr+hh+0G4gOoSV0uWLHMGM2sZ3rpgVwGg44uWQia
         sacg==
X-Forwarded-Encrypted: i=1; AJvYcCUIjsKc3oRo7mnxDrif/qiLQsQyRlZvNaGqEyrBFvw1vnqd84ZA+n6wKtdUdDXU+kGSjI2UkOHP8sjlM0hLy9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkYXXOq3uDEGZcPC9aOLN5P1fsKuEvEZE5JEa9pZWWrMz5DAgp
	URgHbDU5Vsy6fzjmW2yKbzSNe1tG5pHNezueXWMCIbW/dG97nXHUGnmdf+HNlOI=
X-Gm-Gg: ASbGncuDHx25yrxAX8I97jPIjbngIvJvFc4OyzTyzB0PtyPIUAYz5YKbJZEKvpoCXIq
	UIolGqbzIShqdTkQL3v5GMr752TjrjGBBJunVfjFGP9Wz9QiOuH+Wh9AjHa4fp+KNtBM03fQwti
	ilhh07pcQ1LEcf21HW9EE1SIoKNcWYraMisQfq+kK7ZaQ2bXO+WEbBHjcthSOyewQHqhtt2BhiO
	XleZn3/rUrDRWKAOsc23ln9WjCt80FOsWg4fAswqi0nQdES9pM0P1j8xaZo22sm7ur7n81EmTds
	lqaYbfrDq1+yYllkFvoL9rhlcfDMT+jINetlsHo5n+thBTxpPkN9MH7Oxg==
X-Google-Smtp-Source: AGHT+IGKaAQwHsi3qvX4TbcKN8G3Y8mGa16DOUEDVHL9bvh5YTIWSFdZiwuzP2GQ1p/HXxhaFtJWOA==
X-Received: by 2002:a05:6a00:8017:b0:736:4536:26cc with SMTP id d2e1a72fcca58-73905a2786bmr26107578b3a.23.1742863242520;
        Mon, 24 Mar 2025 17:40:42 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390600a501sm8705513b3a.79.2025.03.24.17.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 17:40:42 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Subject: [PATCH 0/3] RISC-V KVM selftests improvements
Date: Mon, 24 Mar 2025 17:40:28 -0700
Message-Id: <20250324-kvm_selftest_improve-v1-0-583620219d4f@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHz74WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyMT3eyy3Pji1Jy0ktTikvjM3IKi/LJUXcuk1JQkyzSDRLMUYyWg1oK
 i1LTMCrCx0bG1tQBKyBZkZgAAAA==
X-Change-ID: 20250324-kvm_selftest_improve-9bedb9f0a6d3
To: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

This series improves the following tests.
1. Get-reg-list : Adds vector support
2. SBI PMU test : Distinguish between different types of illegal exception

The first patch is just helper patch that adds stval support during
exception handling.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
Atish Patra (3):
      KVM: riscv: selftests: Add stval to exception handling
      KVM: riscv: selftests: Decode stval to identify exact exception type
      KVM: riscv: selftests: Add vector extension tests

 .../selftests/kvm/include/riscv/processor.h        |   1 +
 tools/testing/selftests/kvm/lib/riscv/handlers.S   |   2 +
 tools/testing/selftests/kvm/riscv/get-reg-list.c   | 111 ++++++++++++++++++++-
 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c   |  32 ++++++
 4 files changed, 145 insertions(+), 1 deletion(-)
---
base-commit: b3f263a98d30fe2e33eefea297598c590ee3560e
change-id: 20250324-kvm_selftest_improve-9bedb9f0a6d3
--
Regards,
Atish patra


