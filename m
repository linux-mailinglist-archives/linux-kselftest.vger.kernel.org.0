Return-Path: <linux-kselftest+bounces-18352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7941E98600F
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 16:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA9E1F26371
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 14:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0ED195980;
	Wed, 25 Sep 2024 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8NCMqu9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FADF193416;
	Wed, 25 Sep 2024 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727267049; cv=none; b=Cq8m+a1pypKnG93xuLR+4GOCtWdtmUTefSgvNqtg7Z6rDNvkUZWwkJvt8ywHzPUNRUhqSq2nreWbvR8bIW9f2cyH13EtWHS+aCsbwB3Kg676K3Y40Iscy/pwAsMvGE4gv1BmYa6LDhxUNr+YXHe65rKbrxnL+et4JwgjYSiV9Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727267049; c=relaxed/simple;
	bh=xNHnyhJFePMRWD0xmlV7oaH2NuiwOtkciszm0bIRYco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IaYdkDyZdemamnO2zFSaahwQXG1XZokCsEFaSIbcIVIcawUu/9+PiGi4E23Z6TQH2AbeEPoALgOfelmvbP3ips0suwuFZmrQX0c0p+ra//YNwZl8wrpcsTcmJ6WZOhcJA4stLocC2O1mL8GjEeUwOL6ymRkETPq9nVy7Z6Fmbmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8NCMqu9; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so931701666b.3;
        Wed, 25 Sep 2024 05:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727267045; x=1727871845; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0fLhVR1VuwGVirwx3qztf7J7hxhejcQybt+qUHv768=;
        b=g8NCMqu9Pu4oR81sSVZuDw/bU7AoL/KYEPM9p0NWW6nTrbZAaJSclN1dftnQNhN6rl
         gyWP3E0iXcUx8gdww+61cJXLTi0ScTzfPGhTuxGweso22h3zVgCFbO1Np8By9NT2NbrX
         EWqTQjdJPbsHtnI+JkXF5E3q4vNeG4nPKxJ7kpvsxXQWbXSWmQlz9u4JxIhAzHujyVjo
         CJiTUoHTdaYVX+ayZ/cBJV/CBgnrsES2Wf2BvHlb9hh6pq7XQMW6oUTKbs+/xAsl8Y3C
         0WGdGlnO2EVgw0eeZt/BMlCap++RMe9kwDjmC5fdEpzKF5IQVTufATyW9kydeerwRktR
         umPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727267045; x=1727871845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0fLhVR1VuwGVirwx3qztf7J7hxhejcQybt+qUHv768=;
        b=C4JRbCKhLmgxuhdszgZt9pjG5+1Axt0E2l0ocs+jH1EIrsyfsi3lHzfEjR2n3iBrTX
         PC9/dEXvztet/isK6M9Epf95B9dWW09sfVIudPu+8GTjB/w4m0EhC6sVybICE/WD6nKw
         NHZ6szvZmEGAzVKkwRbeV96U+u24X84Aakc56SiVJsWpShTHtT9eoJBxSrUr1ZJDDm8i
         bqyqHvUfo8cg60cssXdxIMRiRablUQV6FMKfl8KopqiTpMacMhb2Pwe8NeLswsMK9zQk
         qjt+KY10VxKzfM8QSLXsMUSg3SZ4YkoccQG0mCgkt+H/ARzenpT/SfzWHvL+zEMdkMXK
         52Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUmbzypePjGio3qPon1uiHMIS8LpWhHWxJZ/mr4tTvOQQHDfKEVak7gWeNagtcVSiecXbmDTvPv@vger.kernel.org, AJvYcCVUuhY5ghMmC0+ygm81MpPCcHO14Ql2uSTOcveZislZT/cxccCIceqVBW5XwbfOcIcSnWJTxMqkp4qbXQ==@vger.kernel.org, AJvYcCWeUEjgfJHTeZTa7O35Fr7G6UjA1gIEankrOHzt9YEdSMazVQWhsw/F5EewdU3Fg6fcSK6o3I0UWESBURs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9UndPRv4YMO1qYeY3rduwz72C4nxm1Qa/wvFZ8do163dHeKMz
	TQ5gyAfS/kvqzH0Ji+LnyijwU14OlQZO3a1Z8DYD03hKqJnLoC6tpthISh4I
X-Google-Smtp-Source: AGHT+IGoB7ZbQSfVRGt+qVasPxfDWWPF9is+1jR8nAS5gLSxrXRk4Yq26dFd559RZOy/RKOqYpRyDQ==
X-Received: by 2002:a17:907:9703:b0:a7d:e5b1:bf65 with SMTP id a640c23a62f3a-a93a038c9cdmr204213766b.21.1727267044817;
        Wed, 25 Sep 2024 05:24:04 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f8529sm204745566b.185.2024.09.25.05.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 05:24:04 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 25 Sep 2024 14:23:45 +0200
Subject: [PATCH v2 2/4] selftests: rds: add include.sh to EXTRA_CLEAN
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240925-selftests-gitignore-v2-2-bbbbdef21959@gmail.com>
References: <20240925-selftests-gitignore-v2-0-bbbbdef21959@gmail.com>
In-Reply-To: <20240925-selftests-gitignore-v2-0-bbbbdef21959@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727267039; l=849;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=xNHnyhJFePMRWD0xmlV7oaH2NuiwOtkciszm0bIRYco=;
 b=CBnd5axojppFuMYKojW9rbxZ6RnKYHtVyxREuIvuENACdTE7wO1IR4F4CjweANZfm1a8DHO5Q
 wVMd0446rqYBb7KyjOylREanqiOUdjaOT3dMSp6Trrmu6vNndK56n+V
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The include.sh file is generated when building the net/rds selftests,
but there is no rule to delete it with the clean target. Add the file to
EXTRA_CLEAN in order to remove it when required.

Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/net/rds/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/rds/Makefile b/tools/testing/selftests/net/rds/Makefile
index da9714bc7aad..0b697669ea51 100644
--- a/tools/testing/selftests/net/rds/Makefile
+++ b/tools/testing/selftests/net/rds/Makefile
@@ -7,6 +7,6 @@ TEST_PROGS := run.sh \
 	include.sh \
 	test.py
 
-EXTRA_CLEAN := /tmp/rds_logs
+EXTRA_CLEAN := /tmp/rds_logs include.sh
 
 include ../../lib.mk

-- 
2.43.0


