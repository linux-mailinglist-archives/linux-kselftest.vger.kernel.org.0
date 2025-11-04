Return-Path: <linux-kselftest+bounces-44770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AA0C33479
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 23:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A2018C4F83
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 22:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BE634B1AE;
	Tue,  4 Nov 2025 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlnCmINT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4AE314B9F
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295963; cv=none; b=JpUK2b/MMRuLMJEeVCS9FigygKOIwRGUZYJ/6tBpDwzhFB6xpGn2CWXd3+w97HAE9fIXj35jYrU5cKLovxjmZhh/EsNksJ38rwNOMq9fe0ZPPOfqx9oOVDR3zfeH7SrpIWItGy0eEjENptKi4VLfTG+jKQI9MrQsXnjiMWBtWXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295963; c=relaxed/simple;
	bh=n+S3IdSADlP9+aYaZkaHpgaj3HAWH7tJS0ebxViFg4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N/H9zo6bo5FRyEF2KFY4BQfRcM1XLiX0FEts5A4Fb3q4Os6CuRaQgqDpxULw0sWiPCkl2YAhj8CWbZoCjFTz35oAg7Guh72bS77hdxIGElUyCf4mvu2L4SB9e3D/Mt8V04MGI7TBwpLmaUV1t9t43RAPt449ljA64o3RyafT9GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlnCmINT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2951a817541so67784285ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Nov 2025 14:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295960; x=1762900760; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=louJU79g2eVK8rdbuOIXqwqI8nr9ZueJcAcohNn7EZQ=;
        b=jlnCmINTbpWQSbKj8zW/Mh98969tNXgDbMZtEWFo19Cs79huIExaTv+VDxiOBDNFWA
         o3EsPAJYCQXDENMrMJEJEz3drbXNSJNDNq5qFd1o4gWy6XV6u3ojCw+u/IDlkqOXbCqW
         u5tJkiM5X9Nk/oLY6pGbi6VW+RLQqfNB8T2uJsNBNEceeJ67IKZy28AOtB1/qHRn4nbL
         FquzmjelJ8GXNdKHT6xh0TK0773IXq09RJxVKTgPLwEjyCb9FDEI2a5UdVwiMXWcabQK
         ROSz5if01uIT6ddKWnaJjN79QOlxFin5WOViwObl7wb2WGaBvVRDdcLC6DpEqbVgLSYE
         Y6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295960; x=1762900760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=louJU79g2eVK8rdbuOIXqwqI8nr9ZueJcAcohNn7EZQ=;
        b=psf3hQvzAoPNy4pAHvsVCRrb81JNAcRbgrKGdixqZ9QbspZpf68G1BAZmXa1OonB3a
         eK33I26XAUVJDUlt4osgD78+XMmc/PNNVM2soFgheSbH12YQL616YQcbesKk/yaXELph
         1U/3XOrtY//Sr/lj9I6GuXQWV74D4Ac8NXtGC5FzlhLN7mncQU8E15mMxsdeKVgUwtmO
         BvBW+w9SctXzmR5TJs2bLrnT0xJKaTXiLTp3Fbj2B9eF7yn7CqkIQUsxOaXHJUWjQXbR
         g+lV+g3CSTp39OifTWZZKkB/W7vM88KtomvYrlQB28vBJ272twyC/ekJ/tkJPJ6TVsGZ
         mtcw==
X-Forwarded-Encrypted: i=1; AJvYcCXWHBc3f/qI+olkv9Zgj2LXdgWC+JbghTN6estYmTb0EnYYnYkPGEMqLDYgRAsOVy0Edncs/LYHHT/JeZ0Bg2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC1lnJqX61FJDs3fHNLP3aFKdd/DXAsS+fkzwwhvKOdq/Q1CLt
	/ilmkIKZDGEVNb6owcv779BTgYVd40LIxks6EAE3NfeX7Jw8MwlVhGOp
X-Gm-Gg: ASbGncv6XpEt59Zmy3rmOOgXYCr8cQEFGR5PRwKdJ/rJyKea6bnzyO2E0stMKXQpM/i
	bwEsMjL6MwJ1WtX3+6qs96/ZGSQ9tTfsUltyyCOd1qzK08VN1BzRyJncdFRei7NIUdodipIFtzd
	IKwLvLl47S1M3QxvmgkATiVi8SW3p8NqXfK+EXeXsBcCXNlLDGTtxLbOJisYzSjZViS2l8lXGp4
	te6tYXNqZMmMeYzWI+BidmTcN0/SGDUmO0gkc+0WUmLjr4j0vNaQTl1DjE4M8qQpWwadTWbo9EK
	+VjqiV3Xqk5wBQ30KGUYWGYHJxqE3pK/xcIos426VVALJk+aT6KfKhEsW32Rcs0W7XPAi4dg2mL
	9DgSvKFnSkb37X7aSD2nzDPdA/+twD4X80xAxyEbhwNB0BfxWR1Pe6RK2q3UHQN4noOl+QHev
X-Google-Smtp-Source: AGHT+IGqM/yITUFIcVMiTb5JYv2w0Kqx9gT7akPgWVpAVZ8aDi3SBcd1PdYtAWJDT/UIWXG9sHA8og==
X-Received: by 2002:a17:903:41ca:b0:293:e5f:85b7 with SMTP id d9443c01a7336-2962ad0c942mr17413335ad.11.1762295960355;
        Tue, 04 Nov 2025 14:39:20 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f2a7db8asm3463802a12.14.2025.11.04.14.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:20 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:39:02 -0800
Subject: [PATCH net-next v2 12/12] selftests/vsock: disable shellcheck
 SC2317 and SC2119
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-12-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Disable shellcheck rules SC2317 an SC2119. These rules are being
triggered due to false positives. For SC2317, many `return
"${KSFT_PASS}"` lines are reported as unreachable, even though they are
executed during normal runs. For SC2119, the fact that
log_guest/log_host accept either stdin or arguments triggers SC2119,
despite being valid.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index cfb6b589bcba..6085e4cf56d5 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -7,6 +7,8 @@
 #		* virtme-ng
 #		* busybox-static (used by virtme-ng)
 #		* qemu	(used by virtme-ng)
+#
+# shellcheck disable=SC2317,SC2119
 
 readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
 readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)

-- 
2.47.3


