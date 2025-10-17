Return-Path: <linux-kselftest+bounces-43432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAFBBEB920
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 22:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 367F64F8E81
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 20:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83609346771;
	Fri, 17 Oct 2025 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NuP58Gri"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F06333432
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732005; cv=none; b=aqocofKCOmQhOcV7By/jJvSTeeI0Fr6ZsbJuVFu+w9OsKcOKmCFXthGMkrTD0rFrTpzAd5cqIiLvW2974TdbQEhlJn4LASli0EoFyYRv+pi8WrFSsjO9DN8DVBBRNuyLs2TmF6/wys+wGNwySIkt2b1CzJDt+5YWvMwWjOHHSos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732005; c=relaxed/simple;
	bh=pYKBot2ZFPxjHn41Rx3POFDHdmgMc5n7n/60l8iw6Js=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fWsKEKhkJOcKs6edWx6w0AtD8kHBn3wswkRpt/35SJObP05r8t3qGXu1uSB0NfrnGdpvAoWYR5uzmTIEOiCj1faTm5qOLa2OFm1H7mgYomwpMRQO6jnr4pdrls9PWo3OUR7AJaAbMusqfAcoVJv6BAxY+gVmqPTjOqoXPeSODQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NuP58Gri; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33bcb7796d4so1739034a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 13:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731995; x=1761336795; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rCewMYqxXPuHiPBbi42+xYZpayTKmLgOBxtIOtY8RZ4=;
        b=NuP58GritMifmgKjkCVFkwaWorqiPNPOxSaRPSMI4YdwTAUJFJV6M+r0qGSlIc0Hck
         5rUIDt3VbT4mQEYOgVW4zm+YJV8RokFGsL3MEYWdV8je1K0xam25QJw/hBl+rDF27yr1
         w9i8dZ9lNanhEz/c8BGtHH06s8DhR/v/a56q2VjT5KklAY8MuCikXUEet3BkkYDGXiLy
         7Q3/+xEwaeSShQ9KFdibI9fW7HCSCt0aL0EWDM8YqN13ZLafTh4v3iIFJ07xFm2wpIIX
         XWwJ0LC87rd2yTe59o0SzM7G42vkx9pogiCGK8h5P6lME8OkAVTqN5SVCbMKYyGwI8rx
         AygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731995; x=1761336795;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rCewMYqxXPuHiPBbi42+xYZpayTKmLgOBxtIOtY8RZ4=;
        b=Cc5iFTMst4jWpal3IYrLV+qGF2PLB/FC3OeJ5ZBZb2koG7fJKhlv/C24vlLf8vrKBm
         4/5r6eE9dwmA9UvQVhYRZrOw0lbmakvmQXfqXq0HpMJuInCV6wllVT1D44hYDNy5Pnyr
         ZSw1ua8Hyw5BD/wkPbepnWvFaMzPNRBlRd+/R/exYEMZLFgfgRrnEUDgfRu5IqqG7hmF
         4T84coqNZx+/HvUXHiJc42y0GfhbHHElb4rGBt0BvlsGsR2QL8T0vuXBfXB5TTiHEeoB
         cQKlipgxh/+qBaCq342WUY3bWHCr6UXmTWxzusPwveZTACONyPGvti2d/LBM9jAtg7a7
         3vhA==
X-Forwarded-Encrypted: i=1; AJvYcCU+cnJQ9DKi0P5DtvljFoAlEoEyBI1Yj8eX02B296Z76ZUA3jwmxsS6tHxPVHVyrjVjIboTzzFrNeut6MOgaZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwkPNyATcSHDiSp07Fb+dnZ2hDKxeIEyYAOnPnRsqkxgGxxX24
	e1Jhd/j4Aq7YJeI2+LU6VLuROgOfDUVQ67olu3/tAPYsVDiCjiNhYTf9tQXNKzElQ+XPiTlud2K
	bUK2l2lZS3GImSxBIodbTtZzCTA==
X-Google-Smtp-Source: AGHT+IFk3Hw62d7/r96Jo38iwe7JLO3gBGrZmfcJ9SUMrFMKpoodh3do4Odo5xum34HLvYJfnprfSWfSqL0bHUBCCw==
X-Received: from pjtf14.prod.google.com ([2002:a17:90a:c28e:b0:33b:51fe:1a85])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2d06:b0:336:b563:993f with SMTP id 98e67ed59e1d1-33bcf9486cemr5545688a91.34.1760731995171;
 Fri, 17 Oct 2025 13:13:15 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:09 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <e1889532e84ec5cb4d93b10a982ea99608c26419.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 28/37] KVM: selftests: Reset shared memory after hole-punching
From: Ackerley Tng <ackerleytng@google.com>
To: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

The private_mem_conversions_test resets shared memory to an initial
pattern at the end of each test iteration. This reset is currently
performed before the (re)mapping pages as shared.

FALLOC_FL_PUNCH_HOLE indirectly zeroes memory, since old folios were
released and new folios are zeroed. This "clobbers" the intended
initial pattern, leaving the memory as all-zeroes for the next
iteration.

Move the memset() to occur after the hole-punch operation to ensure
the memory is correctly re-initialized with the desired pattern. While
at it, update the memset() to reset the entire data region, not just
the portion used in the last loop, to provide a fully clean slate for
the next iteration.

This was not observed before because guest_memfd was only used for
private memory, hence shared memory contents were not zeroed by the
hole punch operation.

Opportunistically add a test/check that truncation zeroes memory.

Fixes: 43f623f350ce1 ("KVM: selftests: Add x86-only selftest for private memory conversions")
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/x86/private_mem_conversions_test.c  | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
index 41f6b38f04071..814187d06fcca 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
@@ -202,15 +202,20 @@ static void guest_test_explicit_conversion(uint64_t base_gpa, bool do_fallocate)
 		guest_sync_shared(gpa, size, p3, p4);
 		memcmp_g(gpa, p4, size);
 
-		/* Reset the shared memory back to the initial pattern. */
-		memset((void *)gpa, init_p, size);
-
 		/*
 		 * Free (via PUNCH_HOLE) *all* private memory so that the next
 		 * iteration starts from a clean slate, e.g. with respect to
 		 * whether or not there are pages/folios in guest_mem.
 		 */
 		guest_map_shared(base_gpa, PER_CPU_DATA_SIZE, true);
+
+		/*
+		 * Test that fallocate(PUNCH_HOLE) because hole-punching zeroes
+		 * memory, then reset the entire block back to the initial
+		 * pattern for the next GUEST_STAGE.
+		 */
+		memcmp_g(base_gpa, 0, PER_CPU_DATA_SIZE);
+		memset((void *)base_gpa, init_p, PER_CPU_DATA_SIZE);
 	}
 }
 
-- 
2.51.0.858.gf9c4a03a3a-goog


