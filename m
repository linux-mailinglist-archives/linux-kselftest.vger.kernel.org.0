Return-Path: <linux-kselftest+bounces-45167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A9CC42F53
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 17:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0523B14E8
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 16:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E000724167A;
	Sat,  8 Nov 2025 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnQLgxIs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEFA23A9BD
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Nov 2025 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617718; cv=none; b=WuvDgjhaZ2JirwbRKJNlicSluC6WEryTsnwe4ScSp1atBOtS/efX3FWrz22WHgpIgqncEy6iHo0nlPndLh6+ZRXx8px6Rev4QWeUP3Otslefs2AUbXIyjeaBunUetoObVoxT/j2NatkgXVzz1YQiSBq9MxkHrJr1cfyK9yqFIXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617718; c=relaxed/simple;
	bh=vFLZWv/FUrDafqhdvi7+WMCrHvjI3U/d+lidxcdSdHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sIAgo+h1kq2M2OHcr8kL+J2GC49P8DcXtV8TLJAn8KoBQ7gIt4dZ6W3jsnCXObQhXDCbHqkMkJrS3wApUCbbQQqFkHhNDnfAPPVVnW2sk+etiz/jOxFGXbEP+oeQDaFzmAQ/3v7lATF7o4T9Xd2/u5z3zgnf9+api2QyVVMUf9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnQLgxIs; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b98983bae8eso974378a12.0
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Nov 2025 08:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617716; x=1763222516; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TzgGQWG9WGn9L//XYwS5wGYUOE0Hzr54Zzu6AsNpCQ=;
        b=jnQLgxIswzz0nLjG+u0WujrtVyeGbMRC+j2q7GE3Yn+R02GssqD+BkAksaYf97VlHX
         tl7ePsSEzgYrxm9fV/q7ufil+ri0cW7gAxv3sRmXRd6M5tJKOPR6dJN6YkCdDkCIxB/D
         CjnwlOF23bluccGhNiZrb/4lDoI1iUsNU5YUyguPev0gElKN9hZmZqZpTMTy5xdY5A16
         B+reFJgK3yh/GW3EHuQWz3jkssTxbyhyLJz3NmtMDGQrHBaY9MTXllnucRu64IVa5knc
         4ve7XVVl6m40dxi7EopsM6SbTt+55LPrLf0xk8BZm/DFltpQKt9aogdqEoQEXrBU0AEc
         KauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617716; x=1763222516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8TzgGQWG9WGn9L//XYwS5wGYUOE0Hzr54Zzu6AsNpCQ=;
        b=FgglScXulaGXXtV1YBzGi744dVF3CCWRVQOvdhcGGbzFUVOQw6rVZH0WH+kl7LmZDc
         YnjKFyCPFLWR84h7ZT8AXwfb1YZ9ITlvsylB+Cpwbhyhwr2ncrp0JO+C7cdjQTqA4zxd
         6Z/69V5YpToxsN3LmxUa9q88RvRyw6G270QYR/jhYxJBccyjBJp1IjF4+OY84l5Quhqn
         NPcTsg4Gi6i3hE06zuYwx7kJEWhXJXK83ul/EHyr+ryNoMGbTaHo6xfVqyK+mDNRTJ9f
         Hp8lGkhSuzC+MnzKCt2Mml4iYg4n8x/JkiDKTuH0ZKeg+H3lc45rfQWRGbxpqSG2IHD1
         gSJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwr5BDXpL5FPJr/2vMKhvYPU2SE2ADVmqwjIa7voZgrs4DOzUrSK6UBY3Y4pJA5zvssmj7pTgM409V3DD5pzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBprODixCeEWDtN72j5+17phZwGeIKQ3c9HIWm2mzv36voTPFJ
	5r218sLuXGXmJ0mxqtMHEdx+f2Aua7OeFak0Lm4PuPMgABK65bRPsC9Y
X-Gm-Gg: ASbGncv5mhR+awkK5D3k+clmvwJyfEYp/ZSx8WbMz5zQCqWcvM+ioGgF/qvPGJ/whfl
	i7lAAu9On0SjdDR+NL+3uTCsrP6la8PGrEU05HeWajjhXtYRKsbSAlhMjIyvr4ddN/LZLGw09WX
	HSDWdY6V4uHwbBL+W4HzHNWtcvNKBpGLqa7yk+Ljs9SR1gGuMydLCpRXLDSzi1gXF2ixJFj1+l3
	fPKhrbR3NWFNwsZa5ide8XTO0uhN4fQ4CfsfJO8lS2J+Yd3zcZWIT1HEYLmr7+p1huzPtT5kUXl
	GehV7Z+lo1Ux+X2G/qjB0tKl7//Gx4wLuCJiVpEy54pBaFxa3buDjrh5CDQGUQ/VnClnwd5cNpC
	MjPRPquXC7sBx8wZ1MYMRy9b/mZ1JkxcAEyvRLLSaIN3nTd3y4xZz2vZ5T7igiqJO5SrP0ONA5Z
	ulQRsfhCDi
X-Google-Smtp-Source: AGHT+IEfqRtwhtlx9re+8tiJC6AWXgiAQTuALNt7ZHJZ0Q9RkasCM/u0W7yOilEslz3OhmJAdBVkcA==
X-Received: by 2002:a17:903:244a:b0:295:592f:94a3 with SMTP id d9443c01a7336-297e57101bamr32706755ad.48.1762617715878;
        Sat, 08 Nov 2025 08:01:55 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cd0060sm92578535ad.108.2025.11.08.08.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:55 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:00:56 -0800
Subject: [PATCH net-next v4 05/12] selftests/vsock: do not unconditionally
 die if qemu fails
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-5-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

If QEMU fails to boot, then set the returncode (via timeout) instead of
unconditionally dying. This is in preparation for tests that expect QEMU
to fail to boot. In that case, we just want to know if the boot failed
or not so we can test the pass/fail criteria, and continue executing the
next test.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 13b685280a67..6889bdb8a31c 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -236,10 +236,8 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	if ! timeout ${WAIT_TOTAL} \
-		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'; then
-		die "failed to boot VM"
-	fi
+	timeout "${WAIT_TOTAL}" \
+		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 
 vm_wait_for_ssh() {

-- 
2.47.3


