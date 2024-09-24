Return-Path: <linux-kselftest+bounces-18301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41003984628
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 14:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F98281574
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 12:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596F31AAE37;
	Tue, 24 Sep 2024 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyIQE3/D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0251A7AE7;
	Tue, 24 Sep 2024 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727182161; cv=none; b=KsgVn+XUH+53BEWcbTpfwXY74Z/372d+ODBVNxVo75OLLaYd7yhPDHkgzpnnjbBMCiTzyXj5VT45Ys7vA7Vty5Vfj7mEtOGC2IyCaIfWhJubXhFP2B4Tz7kLWJGU5UvqHb1E+52wSA+K/t05HimfziT5ZulIMScHqc0NGhh8ozU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727182161; c=relaxed/simple;
	bh=MP9vBuLqT8dLmaw8LBr47kBsCnDmu1boT0JdMMm/05A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rXyDkIUCYimRDeZJuO+FzvmFFYexnISyHRTZdbZSwlMndXcXl6Hq4frsHNBf+I/mVTt6MHp19osFeSDYYru54/tJS/djswLEq/zMhdH47IfIzBweaWqu2yv4A7bJXeANOkfMuqeKU/mlIl5WMR+Y7JlrpRYLHZRy39qRCGyIrDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyIQE3/D; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c44e1cde53so6953588a12.0;
        Tue, 24 Sep 2024 05:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727182158; x=1727786958; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Znk46+nZJFO11Wuv0JpeJ3teEeBD5U6k7fvkM/58UNM=;
        b=LyIQE3/D7CfY7yoMLJDyaMbzfUn5erAhn0hxjIZEMG1ezjXqb1a4arM08/PLIYSN7j
         j/dwSlerdJJzglVgNz/W2B2Y/2plWqz25MCdqb/hP3/C4fY7mbPApIjBIj/32AgEaguk
         yYeMNrzIuN+oIuB0lt7Ihe7pdqY5C/suv58Y3UEUqeAXn1+ZV+cUyuPkawcT23nt0W3I
         hR9VwGUEvfMtjdCgr8YH6oJhkSb3ZMuYG8IjdkQjtESuHQj9MVNk8z0Kr9UlKZfpAL2n
         lekfQVJe558PIS88vPKaluYvJhH1tZ2bST8ngdtxRCnQAjOAfvGmGvQhQDwGQe/8+gwo
         J6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727182158; x=1727786958;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Znk46+nZJFO11Wuv0JpeJ3teEeBD5U6k7fvkM/58UNM=;
        b=NZuIkKsa3Qv0GSjRdYU2MtOevFdNqksFeajGGxs//bYN9rx3n5pmPonM/74A5Zuwr0
         Rc4zePSOUs1N5BFuu0IDPoW7VTZ59+r/bUHe+4AEZXU0LjiBqQ6M2Uc1QxRDaZXJrEMr
         NlBj86+KjopjGWRYOMS/ANNK1obXSx/NSNJzfrd/FnS/EwEJ2jGEc+HPcZd/4cBv9C7J
         zFM2/cDdknQXf4aXhRMnmZXQAxxOG+Lexmtt48BgmFop/x9fEXYE26u9eOfg2xbtObe3
         b24e9qPcfRe5zA2TQ71NKFFTk7gwl+qxznRY5ak2n5f7/IWOUpjUDBywt8KiOkMZRbWc
         0vRw==
X-Forwarded-Encrypted: i=1; AJvYcCUA+umY0zV/0UjS4vAGdXRvD68wCI8EdQsWEqUibE9zxoQu6sSpbUMeq78RggTakyhjAMXUEJsbeXbO5A==@vger.kernel.org, AJvYcCURCqCVqQTHHh0GodqJ6XPOm7RqJfWoKF1j0XaDJ/MjurKE/X9AxyHll7jU/y6KIFO5Sa/Bfzt/rNwE/MU=@vger.kernel.org, AJvYcCVWFJ15d+x/uRuZvD4YoiCMz3+S1RYzqBZokDyz/KAlGNIZIez0ZkEbiQBEVkmcjwPXGaRoaV3w@vger.kernel.org
X-Gm-Message-State: AOJu0YwFuuZsDYzgNhNi9pxwTOeQjrTjSRzjLmheT/BGrATGpqp4OevP
	jFAJVFoj1O0RZtKsuuScugWtjU9oOLvGVNsf7sL60XaHPg+sMRBf
X-Google-Smtp-Source: AGHT+IFX0JoFecLLO498LIlmeIERyaV2dTxoC+FHAg02GNFb7iXWyuMVZCVkQY78ru6Uv8cZp7Nu6Q==
X-Received: by 2002:a05:6402:26d4:b0:5bf:c8:78a with SMTP id 4fb4d7f45d1cf-5c464a3f713mr10892889a12.17.1727182157522;
        Tue, 24 Sep 2024 05:49:17 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4c500dsm704932a12.61.2024.09.24.05.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:49:17 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 24 Sep 2024 14:49:09 +0200
Subject: [PATCH 3/4] selftests: rds: add gitignore file for include.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-selftests-gitignore-v1-3-9755ac883388@gmail.com>
References: <20240924-selftests-gitignore-v1-0-9755ac883388@gmail.com>
In-Reply-To: <20240924-selftests-gitignore-v1-0-9755ac883388@gmail.com>
To: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Allison Henderson <allison.henderson@oracle.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727182152; l=530;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=MP9vBuLqT8dLmaw8LBr47kBsCnDmu1boT0JdMMm/05A=;
 b=jmRwYrn+3y5nw63xdZhyOjmaCXvvjkiWbdZGQS1OY4t7MsNzetz4BSEGqOTCKlZmejoYG1dVV
 Skc39h2M82CDrtVuv6pWiJBZwpRAGGFoHJOCV5KTCuXKEmJ6zL3HJBa
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The generated include.sh should be ignored by git. Create a new
gitignore and add the file to the list.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/net/rds/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/rds/.gitignore b/tools/testing/selftests/net/rds/.gitignore
new file mode 100644
index 000000000000..1c6f04e2aa11
--- /dev/null
+++ b/tools/testing/selftests/net/rds/.gitignore
@@ -0,0 +1 @@
+include.sh

-- 
2.43.0


