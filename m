Return-Path: <linux-kselftest+bounces-38433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5E7B1D114
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 05:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C429E565A2E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 03:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2E81D5CE0;
	Thu,  7 Aug 2025 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOnuycQc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF7D154BF5;
	Thu,  7 Aug 2025 03:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754535619; cv=none; b=IqvOIwnQ5SOnsq1qRtPlo6DxihgAFbRUQ89fSpeH7Zu3GATj2CYbCvKbP3DZUXQ2jpSazfk76etqxLRio3nFiZnxX29WbZPOT4s+9O63lAL/280Qll16SJhqCEJ70TNxI7PFZdIhOkqgipbvbtROlmpHdunEp8JBmihFGHn3JK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754535619; c=relaxed/simple;
	bh=wsKGA0rnuLXG+4PkkqYP3gvS73WZ+qvS1OoEKN12f7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LWJEhQEnziea9w+yTRtkPYwoZ7lXOpN70lfR5tHRwJmMzRB8FkZjTr2vag1iZwGfE0569jRa5SCsP1Bvt9AjbPNLHQx2DLy1DDrwoMCGd8fNSklPd6zRbjYRzeqzl+gSZ8UxN6vbpL+16e+q/8JoexeP0pfsXJ3guLqhaN8/6g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOnuycQc; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-31efc10bb03so506188a91.0;
        Wed, 06 Aug 2025 20:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754535618; x=1755140418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3ob6AtmQmism0IsXi5kyAQfn9jSVsfY+ZMouUkLtfQ=;
        b=TOnuycQcZs+Mn7w+KhmmljrYujXoY3h6DxYvZYGmMCt1k3rEh//FCZcz46zpMiRBoo
         2bdJF3IFP3MtLBn8mmkURL8EboxejurmA2ocLqNA7bGnEFDHoCzbPXHDaDeF/OLj4VUK
         2r0t8gYr0zhJQGvwddMYXc4PlbTiqVkwOfPJ/gWBonRi51sXxZ69cB7KH1qYfpgjzK8c
         J4sv1vgIHWNF+u61dwVVAiaKqLVy5Pe3dI7zFkm4T73goMV4B2Wh6mKtN2DsH3DvLuHn
         jgyrd2NCpBkTOTjOhV3dJ6CFw6pm4+hKWubPtMSRWd9W9byRtp7kijrUXBKii9Hl5ypM
         1OEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754535618; x=1755140418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3ob6AtmQmism0IsXi5kyAQfn9jSVsfY+ZMouUkLtfQ=;
        b=nEMJuTGq48BGYpC2afjaiuPeY7FBsVVonXZbG9dwMEfbFhfLWpFbfUeqk0JpTlf/D3
         1qCJFmvxzAeeV1S7uUEcpYMoT2qhuClUG/s/viyspNp1goCAAtP1ootLyrDG+mxOy30c
         sytTditLTdAbZWcu3d6x03LCiCFjrPJywB3ixaeEWsFtSAj0e2vPfhX/3r1J7QlTogEP
         F7xldAS5fOMv6AS5m4W0ruzX/sf5U4ylYrEZkRIM5SXNi7YWBZEp1o+CzDNG2X7RWRnx
         VWlHMnHnxfpK1QaWAE5yaO9jPl9mSde0nxUTDBSqebiYipBDyLUOmD4DCnJFfhPyaKsW
         W4FA==
X-Forwarded-Encrypted: i=1; AJvYcCUPCCXNdHvC47rD34qk/UfWoIgLcP2hChTfcRma+xvuutfnt2DorPIgfdjn7uTbFNrfyxLg8sZiYWngK7f1+N00@vger.kernel.org, AJvYcCXMmlXpz+u+4i0F+MJ2aw0q4rvj7d7uuffvYKxApXt4p1OjCfeLOvYiu6aqkPQSpuk4N0kmFEC09prr5Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE9gy6jgAv78HAfdzazrFpwHGM4LUrgAI/NFoBKeIqjNJJcOJl
	hLBsWp1WhoyBGbr6/7YHCT5pXog51Yt2kKhjddi/bfDGa/1qxBtqht8j
X-Gm-Gg: ASbGnct/tT2KPWMniqq6ZMN3vnRH1xthejaDBrxqyShkD655r/XPPwEnXJ67hev1+h/
	aQwKG+motaGQlFKua7EqkY9XHGJv04PksiNdR3Fm67cRVPCtsfcgiu8cKnBBTHTROo/T5uk/j//
	fJQzCPGYRvnif7ctMZzqRsZuR4ETOOBKcD2cgE1c5DlBWYLmwZwlPAGkBmx3dDrNPF8DVeJj/j+
	mMquOeGpsRupRJ+4lRNllrrpKdj1U45Meu2pygBv/cRqtn3/r3iNmM4NPlIDtIuHrYGSuwsp5jv
	fGOmfsjwJhku14s/jl5tXfM+y2NPSpPv8QM7cj3Iw44OErMBOyyMclvYSpZpIPhN9GITiGcF0UA
	eB/wmcYZH2ito+dRlIpoyuo9E5U+g76Yb9tX54e4pPsWAQCizUBEQ0/sN
X-Google-Smtp-Source: AGHT+IGMTLZn86RSz9+7SPg6P2DUvVV5GzT2KGNr+O4lPPUaJRWr72Uejisfcsm6HAFjyl0/A7ORGA==
X-Received: by 2002:a17:90b:4ac1:b0:31e:cb27:9de4 with SMTP id 98e67ed59e1d1-32166cb2fb2mr6982196a91.24.1754535617508;
        Wed, 06 Aug 2025 20:00:17 -0700 (PDT)
Received: from localhost.localdomain ([2409:8900:21f8:86c:614d:c5fd:9908:c9d9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b424ca987desm9771651a12.40.2025.08.06.20.00.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Aug 2025 20:00:16 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: ziy@nvidia.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	david@redhat.com,
	dev.jain@arm.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	npache@redhat.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shuah@kernel.org,
	surenb@google.com,
	vbabka@suse.cz,
	wang lian <lianux.mm@gmail.com>
Subject: RE:[PATCH 3/4] selftests/mm: add check_folio_orders() helper.
Date: Thu,  7 Aug 2025 11:00:00 +0800
Message-Id: <20250807030000.33303-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250806022045.342824-4-ziy@nvidia.com>
References: <20250806022045.342824-4-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Zi,

Thanks for the patch.

I have a nit suggestion to centralize some of the macro definitions
for better consistency and reusability.

On [Date of patch], Zi Yan wrote:
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
> ...
> +#define PGMAP_PRESENT		(1UL << 63)
> +#define KPF_COMPOUND_HEAD	(1UL << 15)
> +#define KPF_COMPOUND_TAIL	(1UL << 16)
> +#define KPF_THP			(1UL << 22)
> +#define PFN_MASK		((1UL<<55)-1)

Currently, these macros and `PGMAP_PRESENT` are defined locally in
`vm_util.c`. It would be cleaner to move them to the shared header
`vm_util.h`.

This would also allow us to consistently use `PM_PRESENT` (from the
header) instead of the local `PGMAP_PRESENT` duplicate. I noticed the
patch is already moving in this direction, and we can complete this
cleanup.

How about a change like this?

--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -17,17 +17,6 @@
 #define STATUS_FILE_PATH "/proc/self/status"
 #define MAX_LINE_LENGTH 500
 
-#define PGMAP_PRESENT          (1UL << 63)
-#define KPF_COMPOUND_HEAD      (1UL << 15)
-#define KPF_COMPOUND_TAIL      (1UL << 16)
-#define KPF_THP                        (1UL << 22)
-#define PFN_MASK     ((1UL<<55)-1)
-
 unsigned int __page_size;
 unsigned int __page_shift;
 
@@ -360,7 +349,7 @@ static int get_page_flags(uint64_t vpn, int pagemap_file, int kpageflags_file,
 	 * Treat non-present page as a page without any flag, so that
 	 * gather_folio_orders() just record the current folio order.
 	 */
-	if (!(pfn & PGMAP_PRESENT)) {
+	if (!(pfn & PM_PRESENT)) {
 		*flags = 0;
 		return 0;
 	}
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -17,6 +17,11 @@
 #define PM_FILE                        BIT_ULL(61)
 #define PM_SWAP                        BIT_ULL(62)
 #define PM_PRESENT             BIT_ULL(63)
+#define KPF_COMPOUND_HEAD      (1UL << 15)
+#define KPF_COMPOUND_TAIL      (1UL << 16)
+#define KPF_THP                        (1UL << 22)
+#define PFN_MASK     ((1UL<<55)-1)
 
 extern unsigned int __page_size;
 extern unsigned int __page_shift;


Best regards,
wang lian

