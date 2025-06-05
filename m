Return-Path: <linux-kselftest+bounces-34367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B57B9ACEDCC
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 12:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03FD11888766
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 10:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA92A221FB8;
	Thu,  5 Jun 2025 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKuHr8/Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2753F21930A
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Jun 2025 10:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749119828; cv=none; b=b7Q4bWDcLVuihhkPWBRc7U/s9ysLJ3NV5O9/nhSoH5Gw7G/Fw5fMK+tyKamUExBr/O+rbI2jZWyIvDw/gXMv3Gkr8HAmVeQpBQAVekeo+IsSXHCIyEhpG+fZQasRNDfpvoYX64nnPu8GC2z+TMmIRi6e2pJAEmPAqO+Zit0pvwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749119828; c=relaxed/simple;
	bh=9XeYGeARuady+jct2m+tvWS5mZLD2RXXr/jmj8/Q/5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJfb45MfCEXQa2isudOZ+TOSmf6MS2e9eChzrwtQyPSn2NyTV+lv9YIOfL93YfC4M0edHGWjVfsrdjzxgcgcJr8oS6H/dhtF/E7k0/KsntSn9MHxpZ2L1FzL1N/oKUV8jFPbdeBwxDuU3JHWIsCR8ByRDWcuQXDQa04KhM6IuKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gKuHr8/Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749119826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0rVhjvVcIXx5T86Gzf/rZsso5uT7BOLjFW6qVNZ4D4g=;
	b=gKuHr8/QQutFNiIwdqshmF9EhcumleERero7/u1Zw0lQbAgekTS/KaJXCd5Th7Et3pyi3S
	1dGgYpXUTbsy9WoX5JmrsB6rG0Esu1/2S/k+nlw7qVfyyxSSC4mH+6wXAuzltyKKYvC3WW
	qdJ1kAmF1QttH4NEqt91zxtBz14mqhU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-T6_s-HglMrK5lH0dVQsw8w-1; Thu, 05 Jun 2025 06:37:03 -0400
X-MC-Unique: T6_s-HglMrK5lH0dVQsw8w-1
X-Mimecast-MFC-AGG-ID: T6_s-HglMrK5lH0dVQsw8w_1749119822
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43eed325461so4702375e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Jun 2025 03:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749119822; x=1749724622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rVhjvVcIXx5T86Gzf/rZsso5uT7BOLjFW6qVNZ4D4g=;
        b=OntzsE4K0Xs127IWw/Yf6QEfYSu2fWcxlCNcAjj/ShWMQcEsrwIDwQ5X8WLfBGteU8
         llQ/7wET5O9y7+JRPn43keJP0rGQM2qqJFmEMj13w3VMdvho/Ef9k+1vDn+19xibeZK2
         8gfLMMHa+cwFoUzt7LdGJeLE0NrLhhv8brxhbycq4k6ZS8FjbmD4O4lRcjY++zJPOptN
         BxpUA+M5NE9bYcGhed7xmcVTVYeeYuxV9/RBYrOW5b/Jf0S9JgmMCJNE7Ggop+/uJ1Kv
         axAj3W7yF9ZLrUBwuDoDvuUrg4Z7frn1cxdxDhC87IqXpbNSv2JxlRYfMTSJg80RSCtR
         ZTYA==
X-Forwarded-Encrypted: i=1; AJvYcCUs4ENZ6faagUZfpgNMAMQVM90mJr79Ka4ip2pFGbI0B6blBRKG5mQvnoPz4tTzwLGvKJbUsdArqvNlWekLFwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUiOE8gHv93BslIf9pH2sBoAyD9hLnhnpbaJXS05Lke/1ayBsY
	IGc812OPevAN2pRwm6JxHjDMnRPscKCJ1wfz21Turc3fJX4XeWRODBVnZ6Bps3NSvThK4vKUEae
	50jYQY/u8vd1XTzX8IgcuKdff6oSmoCrNoQ6Vp3vunCvlrHfx681+RLMoFiN1nvzUjSZ34w==
X-Gm-Gg: ASbGnctRGkoqxhKaUHsT+LGMksgsiSCw04J4OKpWUoQ9oIriuogFw3uncEZi65I5w9q
	Nv1M43KAnZSIokjpR5aLGZPMa08nDizTvXIH8f4uPDVgQMrCpp1AQ4N/3PPvrq3MTV7AYa34diq
	T9Fa0ruUztWcg60CiD84DM0jij0Tpx3c14n4EXzczehU70TXE+VFpM68O2ZduseuhNeGrsK5djb
	Mr29jsB5mEfZw5hnNOBtgIY68i7U++XwuWHUPdYehoQoiSbWgyNY+t+sHrJgmnkegnJTZ7sdbPn
	6VssMjfKVDb6kjPh6xFqwNxz5HBZkf+nh7UtidUwwHv5evwDiKidJKgIDo0U7btoKg8Jsz01Ww=
	=
X-Received: by 2002:a05:600c:46d1:b0:450:d5f6:55f5 with SMTP id 5b1f17b1804b1-451f0a6a475mr59189905e9.6.1749119821942;
        Thu, 05 Jun 2025 03:37:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl6x7gVIPWibQhMLU8nel9VytzISKQ2PPkA0o/8Tg4UeXbk96NsVZsi/1KR13ZEgWYC/qLMQ==
X-Received: by 2002:a05:600c:46d1:b0:450:d5f6:55f5 with SMTP id 5b1f17b1804b1-451f0a6a475mr59189665e9.6.1749119821528;
        Thu, 05 Jun 2025 03:37:01 -0700 (PDT)
Received: from rh.fritz.box (p200300f6af1bce00e6fe5f11c0a7f4a1.dip0.t-ipconnect.de. [2003:f6:af1b:ce00:e6fe:5f11:c0a7:f4a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f8311ae6sm14105175e9.2.2025.06.05.03.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 03:37:00 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Cc: Colton Lewis <coltonlewis@google.com>,
	Ricardo Koller <ricarkol@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v3 3/4] KVM: arm64: selftests: arch_timer_edge_cases - fix xval init
Date: Thu,  5 Jun 2025 12:36:12 +0200
Message-ID: <20250605103613.14544-4-sebott@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605103613.14544-1-sebott@redhat.com>
References: <20250605103613.14544-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch_timer_edge_cases hits the following assertion in < 10% of the test runs:

==== Test Assertion Failure ====
  arm64/arch_timer_edge_cases.c:490: timer_get_cntct(timer) >= DEF_CNT + (timer_get_cntfrq() * (uint64_t)(delta_2_ms) / 1000)
  pid=17110 tid=17110 errno=4 - Interrupted system call
     1  0x0000000000404ec7: test_run at arch_timer_edge_cases.c:945
     2  0x0000000000401fa3: main at arch_timer_edge_cases.c:1074
     3  0x0000ffffa774b587: ?? ??:0
     4  0x0000ffffa774b65f: ?? ??:0
     5  0x000000000040206f: _start at ??:?
  timer_get_cntct(timer) >= DEF_CNT + msec_to_cycles(delta_2_ms)

Enabling the timer without proper xval initialization in set_tval_irq()
resulted in an early interrupt during timer reprogramming. Make sure
to set the xval before setting the enable bit.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
index a813b4c6c817..be8bbedc933b 100644
--- a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
+++ b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
@@ -191,8 +191,8 @@ static void set_tval_irq(enum arch_timer timer, uint64_t tval_cycles,
 {
 	atomic_set(&shared_data.handled, 0);
 	atomic_set(&shared_data.spurious, 0);
-	timer_set_ctl(timer, ctl);
 	timer_set_tval(timer, tval_cycles);
+	timer_set_ctl(timer, ctl);
 }
 
 static void set_xval_irq(enum arch_timer timer, uint64_t xval, uint32_t ctl,
-- 
2.49.0


