Return-Path: <linux-kselftest+bounces-26119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BE5A2D96E
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 23:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE1077A2ABD
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 22:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9CA2441BB;
	Sat,  8 Feb 2025 22:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtU6Qut0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C44C2441A9;
	Sat,  8 Feb 2025 22:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739055168; cv=none; b=XqrbFcn3B0bdSRKz+9wq1PT5dKfMaAZk+jGFEYuxNkv6I+0gDo32RPArcmOvXX9IGiAtpLwZkmvkFLy+xuYLFPA4fotPCf2436331vNr9t+239DheCBNzA9TTg2mDZVlOJ443nUKcaJjhr71O+dSmAQvM0j18U99+3ZWxdUQnfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739055168; c=relaxed/simple;
	bh=SpWHB4Z5KMf4LSaMFuL5WRBvdcw8Q42qJix1nneUIoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rSHw4J6DrctxvYEutvsPKATUf5Ar8xaOhBEautWmBnsy8KrreMnL+MKIrSSyelROtO7w3hpetZfQ8r1cl6EVYFdggsEqk8aP4EeVVL0rnY6GvxFirGtDcVEzWA8nUKHWb0IlDBtMP/3NjW4u9ABebdS6vao4wA26ANX6HPY+gSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtU6Qut0; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46783d44db0so34211511cf.1;
        Sat, 08 Feb 2025 14:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739055163; x=1739659963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vwp2Byu00e90GrZn/qF/rycqYIQg0TgfP/aWBzdBhUo=;
        b=DtU6Qut0qaqhVrbD+Al/uQOB4gc8BxADsrWD3EhtmYeGMGeJKg4GEe25JCx+k7g4xI
         8rNCQw/lAr6F7z+q6JqdpKg3a89r4araDciKNWp7UVTDSzh2nBm5iHBlaphzeFirOpJ2
         bCVN1uDw3ugyHsOhT1/CkgZdv/Wxx0p2wSXQ4NneDqwDEXmzzeV0XE+lDuiMNmJoBkcU
         B4V/61qvoZNWU3bWr8ZM0fp5DSdGdvmTsBTaDPjyICfAJ3IafNWn7OYmm669dt3gcVvE
         rJzNSv8WjqlIYxjDGOlB2rg6QTeU+iu/VmSNGN6zHHgo/536m5fh49yM6DXQ2VylOThH
         9zEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739055163; x=1739659963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwp2Byu00e90GrZn/qF/rycqYIQg0TgfP/aWBzdBhUo=;
        b=TxZtTDBOK04fcYPJ9InCCm/6yw4fTg5cSn2IB4eiLcuWIhumFZeKDVqc1ZgI/klr9R
         sLAgUTrGKfwFaCKKaHdsFZKh4WVCsBUq24o/4a8z5Kgt1qUdK4D6j61UGE+6rsYB4I7v
         nz2EgbQ+2o/5I+S+aCIQZ+1svLVvjHWpWCrGVOLbFSLDOiwnZpUxt3XqHpvUlWPAxUlU
         TnmaeHknMPoFKA9NHc/hS8Eqgk7HZ20PoYZnL8Ot3pkYVvUJeO/H8JQFBbem8gb5Jorc
         hGZVbSmiADwZZk5O+Vhxo7DIsK7P1D6W8clAomxlt6oFFCChuntncUzyF0TWVkaptPk0
         fuyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUecN8Vt52Ho7A2cx5KE9XS+CLowhudiXH+55KjgotsoSN1AGKKwGsFhCSv0GOURpFPH5PI9SF6OoV/AGvPyu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaQwWArvNDSRlUBgu6gR9AZ23FNdhHeuNlAl1IaGGRtIS5T24G
	h5fDn5Cwvb6ndUcnCHS5/cceCAF95RgZ5C0doucIhkdWW71Qz+Mg
X-Gm-Gg: ASbGncu6VnowE7fWBRkbHuFX13pqlyxyg6PGFr7X+9x9RjxjSMsY8F10BmqICckR2mp
	6lSkIHYxOYN5wrn2xoC0K7AasiOcjKcJssINmg7j5mQxeOn+NgtMTERo7w94fFylg4YDjia0x7k
	sMXjbiAfGUAczJIKhWAhcNAhhbaXi8fsbQKcnitizyOc/P7QAXGYH0CyRQtT3e1LQMCw+1Vq5JR
	TO0oPHeZB00s9ME/QtXMTtBBCrvVhT/AaZwAj6MCCHx8RHSQb/0qxdiyYUK+OibTK7uJdapOA/r
	OZ8hmWV4QyBtiByXCEYR0CxgX2dlfGo4nONXI4z0IHQ=
X-Google-Smtp-Source: AGHT+IGtiDNS6btJC7uQ1QoSzyQJzXqvBROwPDgk45qFj+z7YcBuGg/fIg7MoW30mC8atoVqibgEYg==
X-Received: by 2002:ac8:5ac8:0:b0:466:99a9:c354 with SMTP id d75a77b69052e-47167a25e09mr115804991cf.22.1739055163335;
        Sat, 08 Feb 2025 14:52:43 -0800 (PST)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:15f6:96e9:3308:934a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4718c20a23esm310731cf.4.2025.02.08.14.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 14:52:42 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 08 Feb 2025 17:52:29 -0500
Subject: [PATCH v3 1/2] lib/math: Hook up tests/Makefile
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250208-prime_numbers-kunit-convert-v3-1-8ffd5816d8dc@gmail.com>
References: <20250208-prime_numbers-kunit-convert-v3-0-8ffd5816d8dc@gmail.com>
In-Reply-To: <20250208-prime_numbers-kunit-convert-v3-0-8ffd5816d8dc@gmail.com>
To: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Luis Felipe Hernandez <luis.hernandez093@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This Makefile has been dead code since it was added in commit
7fcc9b53216c ("lib/math: Add int_pow test suite"); the tests worked
because of the duplicated rules in the parent directory's Makefile. Wire
up tests/Makefile and remove the duplication.

Fixes: 7fcc9b53216c ("lib/math: Add int_pow test suite")
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/math/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/math/Makefile b/lib/math/Makefile
index 853f023ae537..d390da9a59fe 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -5,8 +5,8 @@ obj-$(CONFIG_CORDIC)		+= cordic.o
 obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
 obj-$(CONFIG_RATIONAL)		+= rational.o
 
-obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
 obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
 obj-$(CONFIG_TEST_MULDIV64)	+= test_mul_u64_u64_div_u64.o
 obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
-obj-$(CONFIG_INT_SQRT_KUNIT_TEST) += tests/int_sqrt_kunit.o
\ No newline at end of file
+
+obj-y += tests/

-- 
2.48.1


