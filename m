Return-Path: <linux-kselftest+bounces-33921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF587AC6421
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 10:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189643BDAF6
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 08:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FFC24DD1B;
	Wed, 28 May 2025 08:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="agntaPft"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FF024501E
	for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748420033; cv=none; b=cgEzxhadIoT06d+Z/VPsRkO3fF9AqMm3+R5PVjtSZG2G5jzAcvV6UNEC/vHzmgdcqegxtFI/3FFEDCfDu5zPq6Z1IwBD2wKuSt7jqFi0ZdyJEhxMR86pUO+ptEGxw6FQ0FnG7nWCQxgHDloYQgpQ9z71JyclxOkcSTShVRkttGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748420033; c=relaxed/simple;
	bh=+Y0uRBfTZif9EgODttL1hBd9w/+qxXwFk6XTnVGQ7A8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G+2DcrJzaTgunVj2EB2RurnepHIW322rBqHp+LODecvtiGiVOGE5HNaP/eItTOt5lezPUKKF8jo8IZu7aPdsHqUkz65jKBp8R2fHIRpJOWakE91KKICYgA67mCR5lGB0xujSXvQo1MWackkxvP8kFO0KunhDSvJ24yOnsdktFcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=agntaPft; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so54808475e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 01:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748420030; x=1749024830; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q0yiIdr8kiMktQtzAz6WMndkMTPinkFXHlilIDGPLcU=;
        b=agntaPftrRvV4F7X9Oj+/cKV/e0sHa8FfLilHUrVFjqtxoftC0P9RDT8IwTvxmwK80
         rJF5xHU0xtuQGhjrdXqMkw0GVhu2HY93CGnlP3cIueqZWggD4VUdVDtBrtlW0e55xv6Q
         1jhHACcF1A9soWM/Qh3IDjs3leX353g/Nq2w2nOR0FqizTIwvoUTPsaRFFCnR2Eswa96
         EAcDxoZYAScvFmgM0UIao/pdWlpBbTxB8xgh3othv1n3BaK3gWe/1Pzd+VK5BdVt4y7C
         Ou8dVT1f0JGqBHm7fWqK4oIunxoeAeMOOt0bo0IxtgvX5N8iSjwt/uiQ9mFnByl48vbP
         yFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748420030; x=1749024830;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q0yiIdr8kiMktQtzAz6WMndkMTPinkFXHlilIDGPLcU=;
        b=i5qWgjTD8T4Z/mcBKwMK7+gzH35Q6BAIQGIp5M5uxGoB4JB5RjUBlzwWO9gmeRNJL7
         F750rQIwwQF79t7HOYmGVJ6YEvz75IfMIl1bodceLeqVOI+AxjMoTnUS+/WZy5kdCumF
         DCSAR2vx5r4ZXXJhEkcdrP/KRZKYSlxQNfDAjkKNCUF8bgHcju8nvrY0jxSKNJ8Bu8zy
         zcAJMi4KKujjQ8eBp/4OKvuOWNp9o24QLHqmJ6F/rfSFNn1rERduWTCtFdEXDWwPEqB4
         SmPlY6cNStKqwq2pCtd4pm/qRHvHuzvMAnqClj1us0K0Ne47e2x2mR0m1y4YKR3GMj7a
         SnRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9Hrq2xUTAVabP85ni28undPwhTcSSlc6F8NAumkrbnaTLzp/jmh0jj8Ic3QZENrW6FRLN0NdOmZinByqJSbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeWiAAvsVUzujNE/uiJhinE4aO0EoK1hou3z+9cNfJBbL8gXaU
	PBTxtxGUytC5H+h+eCBqeuZG4iNGaHhbE0Y4e/PYkahOhga35HLJn2/8WxB0e3kxJ5A=
X-Gm-Gg: ASbGncsnNHOC+SbNJyv2iNUap4AvnpoIIqOp3+W7L9Mo3IbO+QJZ8QKQgsTq6kSYBLB
	D85rNryoFZn/mlVJBbT7Try27/ru7U8CMVW+OWKFpIUF7bT39bibJAfI6MVPK2CJOhBNXqFo5ef
	SnH7t03qw07n2yiIRpF6hv53fhmFH+Dmf7bZ8eKtTZOUMXKmFVAsVHtm5xDyhPFSpcVdyHIbNxB
	8muKQ3HKbC2cwFGkKKc1vUpVgMWKijvNzRNylwX1RYTdZExDfhhmFGX40su2ADKHhsJ8/TdVb0y
	JmKboFYPMTUoNniyN58nRqbyRHeLnwn0Vt46ldjpJSSyFZeBNOsiffS0
X-Google-Smtp-Source: AGHT+IHwxFIuBvvAastdxx+Kytl7VBX/kiaYR4D/z8QcwH+3DXyCV3M1g6v8ommXnYfifmpBZc7UkA==
X-Received: by 2002:a05:600c:4683:b0:43c:fe5e:f03b with SMTP id 5b1f17b1804b1-44c932f9572mr154626255e9.30.1748420029682;
        Wed, 28 May 2025 01:13:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45006499727sm13341795e9.3.2025.05.28.01.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 01:13:49 -0700 (PDT)
Date: Wed, 28 May 2025 11:13:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
	Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] tools/testing: Check correct variable in open_procmap()
Message-ID: <aDbFuUTlJTBqziVd@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Check if "procmap_out->fd" is negative instead of "procmap_out" (which
is a pointer).

Fixes: bd23f293a0d5 ("tools/testing: add PROCMAP_QUERY helper functions in mm self tests")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 tools/testing/selftests/mm/vm_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 1357e2d6a7b6..61d7bf1f8c62 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -439,7 +439,7 @@ int open_procmap(pid_t pid, struct procmap_fd *procmap_out)
 	sprintf(path, "/proc/%d/maps", pid);
 	procmap_out->query.size = sizeof(procmap_out->query);
 	procmap_out->fd = open(path, O_RDONLY);
-	if (procmap_out < 0)
+	if (procmap_out->fd < 0)
 		ret = -errno;
 
 	return ret;
-- 
2.47.2


