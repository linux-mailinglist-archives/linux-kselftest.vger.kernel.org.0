Return-Path: <linux-kselftest+bounces-21090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 554729B5FF5
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 11:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0F3CB21992
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 10:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812041E2313;
	Wed, 30 Oct 2024 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbRIkqMH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECA11990CD;
	Wed, 30 Oct 2024 10:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283754; cv=none; b=I6oRRFDCStR4zGbgFIK2vhDmROwUJX/6v3xbFmmEFaVPW+MGjFD/5jj++3LmJ+N2pUsKWVpl7dlsRYYFBy5ubqnjiVtwEhqOvz6icz/w3kfFBHKNgbopvay+sAw6UOpgQq3OAYpQFYwup8boY6W1KKDejRFZLLfvcOd33eE0GMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283754; c=relaxed/simple;
	bh=4fT801tnpCU5ccrvSwjjjBp81I2/ME0Fo9DErJwwTfg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KuHtjuhtM9cwvwO+VdLDSn7T+axBWy3kVI3j2zD6NNjN+3k6iSFa/d9rr1+B734Xv4g7PIMKGPPOG8OPfZeIMvnUzfVuTUXuZkxgGou03fm6juo2tvgimi7NyUEWu4p3ai25qnWwWXRU6tdSBjjv7hYGkJ28bCmgmuS7RjO2G8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbRIkqMH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so57969275e9.0;
        Wed, 30 Oct 2024 03:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730283751; x=1730888551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l/cqopELy2+eorysxMacWsOMH8qMdYy0akIQnwzx3HY=;
        b=VbRIkqMHQuV9FJOkojzs726bcNPqdfIj1JM2197SLEFP1OCyVQ2sl+p/dsd/3/Prdy
         KZxXN0s4rmwxuytjZDnRN6WeoNmx8H+vGEN9BSpwxUoSkahKzzpsIs4sASNWGa8eR0QY
         tEpk83HA7MuUb9fiHxbogdfg/sqsTleb6pyxkeOxOnYQKzoAoTN1tzghc3tEiP9Txn5V
         WZdQ4eBmPoEy1N9T2BHmiO5evS+MLbGghZGqxQkMnxDdIFoPdIPh01yoGQaaw0OQpIhd
         GeEW8luZsociph/8JjcF6VyKAYncmps0CknwvGIm7d0cdmqJjMrjKzsfjWRes61DuT3j
         khUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730283751; x=1730888551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/cqopELy2+eorysxMacWsOMH8qMdYy0akIQnwzx3HY=;
        b=AFueLEJgk0GzP6lMNjXGBN4taiEZyvk+fmYXf8ncBb78GaiCTTPrfjSeEHJOumB7yk
         pNos6xGg8oKn+J+/E6Z1KD6IlBcmclvzKHwvms0EH/Wbx3+tkuuCcEih9DPli9dE1uOV
         dIazjClZjmGOUzpvNgsPFxWubPg/1tHQZQ5CoGx87NMwqRq4ZD6MuLPyCoW7MQiIHGiK
         LCP4glqlm3UJFDEnPkRvuX8szUu2XDUAJ4nKHcLA0pmRtnvNVOrR+YSxsYSn42TR6bPB
         CVdwO86J+R0+sQP2Cy80wv8Pjc3PwYEmRJKEvDYr4xBokIjG6poDGB2TkdrwXxcF3n6r
         J1Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUEBufrHREfgjoCXYvHueWkl/jak3d/Vshuoaw1GbXnKZAVIwqE1VCjv3tH5gabjgp5n15tKybFxZkXf6md@vger.kernel.org, AJvYcCUOdZgJRtV6FCef69Jn0HGXY2yIUiwhvs7ZahLxSLYHCTNG5tS8Jm5lhXmTyKvWxin7r61jm4yUPnpjcer44GBB@vger.kernel.org, AJvYcCUTHcxoCAQ0IMBzRnnQ092MxPB9zWYN3JMjZ/bdxs7RPVNiY6HKQUmFsWcp6K3thbtWtrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUK3bibvvxgYIjSCGDn3Ui0qiBI2NvFh/yGWQvyURoRqFVUVCi
	sBZFdTzvYt9EplrqMxrHzHntEK+kruZABrCkps9NDO/vumvq5xBH
X-Google-Smtp-Source: AGHT+IGfo43UJNvQPjITUSCIJAK9Ze0chz0K2mNutQBnGmnznl2CM1ZwI7KvASW32glKedi/p8XYJw==
X-Received: by 2002:a05:600c:1992:b0:431:1d0a:38e2 with SMTP id 5b1f17b1804b1-4319acb1d82mr133855645e9.21.1730283750464;
        Wed, 30 Oct 2024 03:22:30 -0700 (PDT)
Received: from localhost ([194.120.133.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9ca818sm16810685e9.40.2024.10.30.03.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 03:22:30 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] KVM: s390: selftests: Fix spelling mistake "avaialable" -> "available"
Date: Wed, 30 Oct 2024 10:22:29 +0000
Message-Id: <20241030102229.3085137-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a ksft_test_result_skip message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
index 222ba1cc3cac..34e0ceceaa74 100644
--- a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
+++ b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
@@ -276,7 +276,7 @@ int main(int argc, char *argv[])
 			ksft_test_result_pass("%s\n", testlist[idx].subfunc_name);
 			free(array);
 		} else {
-			ksft_test_result_skip("%s feature is not avaialable\n",
+			ksft_test_result_skip("%s feature is not available\n",
 					      testlist[idx].subfunc_name);
 		}
 	}
-- 
2.39.5


