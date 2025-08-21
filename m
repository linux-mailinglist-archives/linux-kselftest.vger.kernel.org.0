Return-Path: <linux-kselftest+bounces-39549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F42BB303FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A01AC1147
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA49035337F;
	Thu, 21 Aug 2025 20:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOIX/qy0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44F4353350
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 20:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806841; cv=none; b=H4TcJRIzOZwZnAku3qUX6+0SwtZou8ROpV5z5D0UbUWgScTpXAN4s9k4IEaXAaxEEsnAfWp9qD6a6AudAyySIFdACogEngX8bx5j5Ak7nddAH8sGm8IRtm8oHby4lKNAtNfm/HC+l9a2LlIq4A1TTnO7v0fFvFhDoKMY9r5lvgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806841; c=relaxed/simple;
	bh=3FOM28sJXvbUF2Tn/5jLCVekviR1dLu1+OtM4m//AQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rr6y7haQGV9+e8zAhYsJO7h/B303Ug98uFrLkTsEgOBPYeYaZKdmBjYl0t2YTTEjeTNdEQJRyIX70e9m9AfsP0kuGg+ETsKP+PQ9YBcfdeuWAEYECKvWv9RR6uW8BMexHPj0NFPrate4iGldq4dqB3sG2FlDsMugteyd66Dm4k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UOIX/qy0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7sWLap5u4LkaWlbSo2T/W3JLtp2tuveUv2Z9sucaeo0=;
	b=UOIX/qy0qd4UJ49d7l4MNk7nDiW141L16mOksv03urBDSQfKxzfJB1qEtz4oxiYIGVqYV8
	flTcnNFzBSfAXrsC2EUygznvH1dPVwsFgn0eLUL12C6T0QXoDnjZLmPhIqwvkmBC+7jCwA
	ath4VJhJBqa5l6PMDUXROFPrFuVeGM0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-aBf9XEDQPNiEwhJugDaAJA-1; Thu, 21 Aug 2025 16:07:17 -0400
X-MC-Unique: aBf9XEDQPNiEwhJugDaAJA-1
X-Mimecast-MFC-AGG-ID: aBf9XEDQPNiEwhJugDaAJA_1755806836
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0ccb6cso6964425e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806836; x=1756411636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sWLap5u4LkaWlbSo2T/W3JLtp2tuveUv2Z9sucaeo0=;
        b=ZplPvci7nqg6ZR/n6c5Ykh4lHMCq9xJV23QJC+dcTiReMAxiVZS6uvGeLPAJttVuSQ
         b4ob6l1tlHQQusLNLcDZAqYz7sdWfe5Uma8cJEojqAsAQBe2z7sFehLYNjMfOPBJnilX
         OlK2MoCe07fcN1BrBJKqdYOBdYcXW/byPRzjFdlXc4Parsr5PROwk4G7BWIqoYrxbcOY
         fQ5QUYJN1KSbuT7R2wUmbm1LGxZsljFRCd5AbkpFt0VAxyUewjAJqnGM9Mru9IBIGiu/
         q3Q7K6vmk5053mFEFRl3fLWBFf2pRi6vlalSyfXCVJlJADQm6qArWoF+EMhH3XTm61Gq
         ir+A==
X-Forwarded-Encrypted: i=1; AJvYcCV6KppYnPGCd4v8PGrW1hfNYht2v6/gsHbMxX5AVHZOzu76ddOZuvOPwkw3wGNphCrwXxPkWgiV6tSP60css/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydy2OPX1e24D03y0uK6T0Z6AGZOn8ptS3tpiZTfwBUIu6VRhpe
	+rdFQzT+45YqLO7Bwz04bzVDwnu2iDur6J6MOUOUDXuItAxkV41mrob9np61/Mafx/AsenBsamG
	S7mTlo83Gz1IRBBXNlo5KTTs9o0j9A+HLNk1+o7rhB5/9frc77VcQB01Qu7y25NBzZLiUag==
X-Gm-Gg: ASbGncs2y9ISQKxGS2/VvRXNSfhMlxf64x4Chjy1cFiJV0SXI2tyN6BbmrYw8Y4eTn1
	Wtx5IetSmTQ1gEM1IkhI755bd36Acaj+QFdpy1B02Vn2WvjDm82bShZfgCwj6+xmd9Aih2w7dzu
	CEgPS0uNYA+koWQPl+AwjHY5ZfS8YIPS853mnkEhfrXJFPwdus84c1I1xJE5lNYG9ftVcsfc7tc
	mLWHfQ8A7Z1+yiR595XxJtZX0yUmx+A0OD3LByRCU2JYTV02Z6IayZ8sv7K3I2ms6TpCoN+l6WM
	vFZb2NwUmH1xmscr6imCCBL9aO6UDtKcrnP8UW7jrmvqR0BadZxL+vm1KNYCrMzOMoRUvP21qrY
	O2na+bi7cJLFHo7h3f1jz/A==
X-Received: by 2002:a05:600c:1d06:b0:455:ed48:144f with SMTP id 5b1f17b1804b1-45b5179669dmr2598375e9.14.1755806833356;
        Thu, 21 Aug 2025 13:07:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSutx6qbatKffMJ28UfT2ZDXFlSv+vNq81oYks3KAGI73zxxTWKo8ClwQ/mmPq6W0wDfVQow==
X-Received: by 2002:a05:600c:1d06:b0:455:ed48:144f with SMTP id 5b1f17b1804b1-45b5179669dmr2597955e9.14.1755806832889;
        Thu, 21 Aug 2025 13:07:12 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c0771c166bsm12916801f8f.33.2025.08.21.13.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:11 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 02/35] arm64: Kconfig: drop superfluous "select SPARSEMEM_VMEMMAP"
Date: Thu, 21 Aug 2025 22:06:28 +0200
Message-ID: <20250821200701.1329277-3-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now handled by the core automatically once SPARSEMEM_VMEMMAP_ENABLE
is selected.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e9bbfacc35a64..b1d1f2ff2493b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1570,7 +1570,6 @@ source "kernel/Kconfig.hz"
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_VMEMMAP_ENABLE
-	select SPARSEMEM_VMEMMAP
 
 config HW_PERF_EVENTS
 	def_bool y
-- 
2.50.1


