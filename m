Return-Path: <linux-kselftest+bounces-28484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CA9A566BB
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 12:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73AEB3AA6CC
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 11:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF57218AC8;
	Fri,  7 Mar 2025 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihGuXyDm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62134218AB9;
	Fri,  7 Mar 2025 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346880; cv=none; b=dbPuFSe5Du8MM+EoYs09aeOJhIiUT2INwoVJFr6+vGX+C5dGyLqBM3D5o3phWgYALeMrgEVVlZ811HMDfQJ725AElljtYSX0XEUeT9odssFENTC8qbg9zb5bsijGMO+ry6+crgsvJDhwbuzV7XTNIZZnpBp/gXf8QvZntJuCtwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346880; c=relaxed/simple;
	bh=XAPt2hMRpJcoX7Q/8QZUNRBbEIb2Ha291wFDULtaVjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=szEWD4AOs53Ae//cGKTva4wn2hMzQ4F0TP4mrVSj+kgP63FnGC+K4GUCxvWKAQxqZZnjBLhr61j1Qj8HsRj5NpuKwRxukhgUchsG4gkO8tp5cORiRShmGs9krN282+wcOSGLNKtjFkr9a8T19PicdNR0ZNWR0bRZQTX1zE3zNEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihGuXyDm; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4750bc8d102so17088781cf.1;
        Fri, 07 Mar 2025 03:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741346876; x=1741951676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31PomiHHU86LsHEGynVcWWWqYDG8021vY4wNIw/Q+wI=;
        b=ihGuXyDm3jsXXfB/01l8c5ZTvxn9+UvjfrABPUih99lpQBpRK0ej3quKZm7f2SCpBK
         sz0tnsRYmCJfXMCFUT7NkRH3vGdCh2OteCU6Zyrg1xpx/BH0PcdbtHZIIzHNkr/c3qrI
         BpitiK6XCKhd5FOx3OsHJvOGOjoX1VcLqdIHUpahV2qB2IG76Cs5x5alVcRtz4gQG3dl
         jTUrG/X3JroZYlaadUrSusFTEtKWZ+N6V1VLE9C+x7hjib56h4YH/sU0uP98LE9ksSfn
         pFg1LEItlzXywsmsR7gLQlyk41dAhAbHOlcWVX1lej2TkhikkZeyYBTR+/HWbwIBGZHU
         NBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741346876; x=1741951676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31PomiHHU86LsHEGynVcWWWqYDG8021vY4wNIw/Q+wI=;
        b=QpFtu1y6lh2iz+ziwmymG64fnbwoIX6e2Bh0NBF1opqlq+zO7aQ9azKxU9ESwJZHo0
         m472lnAHQMENrOVx9KTPQZ/cgViDwh3rUs/qCaR8Sr0FW1bFabT11s5DQMJ8j8V93tf9
         5jYDoSeoFFoFDWHb+I9/pXqIsC3DW4VFSoWYfq7DN/Ed1qfI3fUBFuIetH7gJzV/6B9O
         ZotBYQ8XEra4tHbVXLFcJnX6YXCziwl52lo29aIXwCK6Bm8ApSoBswkPIPoPJDsseEyQ
         flSTwDlG4PdLS7qLIQRbt4q2m/V5QxmbRlzCu2W/xRCiSbQIIN2snLKk6/UwD0EaoAn2
         uajw==
X-Forwarded-Encrypted: i=1; AJvYcCUVNRIQmfmCkjKdMSgRDKZIu5W6t0zNnGhBflCyIM32eUdnWyXVK1eVYtIYdP3ybaKXeewd5v6cYg2OTCzdmOa4@vger.kernel.org, AJvYcCXwYezGDtO/UmxqwQRdagCtwlCY9+MByQVUYZxz/43F2lP/H5OWGEvJr7poo7JvdJIaECBjQYi8rwpM+dI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy56g/WHq40amnU/mhBbBPgWVTAoidEX/1JO9+Dc6sNHF8/SMi/
	MJ+FtkyYfD18ybUG/tlJjPwMF8xLVn07sMTD9PwpZ5uH0j9LaARlA/B97EtaguE=
X-Gm-Gg: ASbGnctItkHCA6db5+Nh6clIb+ThshVn9GEk8Z6cJMS5yltEsHAUDscJiigZjBsPjcC
	mqZ1gbnOjz+etrKtWIv7sKuz9IqrFZCe1ILt64Uv048j4WyZxmndbh7xofW4As1v4xuSg3zIyk0
	XRrla5c7VI+9R8kE3crNORjWkEEypfseAeIK5sSeVsk8kO8G4WMqKTp4plBkbOs/jsyD1j01qcI
	70dedkELrs5iasHwF0rriLQrS7DSpL+rLl21J42nahrkn87GWy0idVh2Oyw595FrQRkm4egUUpu
	DRuKhqyCrxGzSvRoGhV4Yv8Ghk+u2ABc0BVvVvx/ps1xq+uMfJANE5kyAVwNHuP8vDw=
X-Google-Smtp-Source: AGHT+IEqhaq3ZgA/0PcbCayAXpD+pLQMctKa8GTROYQoX8uqkKxEST1IZc507Aqnlx5ErlKEPTvBSA==
X-Received: by 2002:ad4:500c:0:b0:6e6:6c7c:984a with SMTP id 6a1803df08f44-6e9006776admr24793786d6.29.1741346876387;
        Fri, 07 Mar 2025 03:27:56 -0800 (PST)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:f0dd:49a0:8ab6:b3b6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70a446dsm18509416d6.56.2025.03.07.03.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:27:55 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 07 Mar 2025 06:27:38 -0500
Subject: [PATCH v9 5/6] scanf: tidy header `#include`s
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-scanf-kunit-convert-v9-5-b98820fa39ff@gmail.com>
References: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>
In-Reply-To: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>
To: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Remove the unused `kernel.h`. Replace `string.h` with `sprintf.h` as the
former doesn't seem to be used directly.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/tests/scanf_kunit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/tests/scanf_kunit.c b/lib/tests/scanf_kunit.c
index e9a36ed80575..d96d7ca85b52 100644
--- a/lib/tests/scanf_kunit.c
+++ b/lib/tests/scanf_kunit.c
@@ -5,12 +5,11 @@
 
 #include <kunit/test.h>
 #include <linux/bitops.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/overflow.h>
 #include <linux/prandom.h>
 #include <linux/slab.h>
-#include <linux/string.h>
+#include <linux/sprintf.h>
 
 #define BUF_SIZE 1024
 

-- 
2.48.1


