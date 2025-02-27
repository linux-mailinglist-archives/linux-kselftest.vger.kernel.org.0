Return-Path: <linux-kselftest+bounces-27817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD36A48C4E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 00:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BECA91886DC5
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 23:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA90626FDA0;
	Thu, 27 Feb 2025 23:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRpQX/iv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ABD26F469;
	Thu, 27 Feb 2025 23:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697424; cv=none; b=REwWBJuwkXTx5FlbJyKT7wtFji3UKf2qy34lwAipeLMTccD4LnqQpa1tM07y7uEI2nflHq0ViU7MwTRuPxUJt4jiTC9XmTEuGRliOnwR1pxJ+8FIx0lAABXy/5NbI6peeVYkm3W57DuY5zrVLr1vUNZXvel+sLWwJjnIPRrXbKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697424; c=relaxed/simple;
	bh=0iT8jAYbTIV6/JT+rArq6GBtNxLmL5SGdbTXp05TjXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jtxiC980zEwYEbU8RdAIuJ37GUCKbfXVzJRhfuIFWHNxjf4JM59MDRo6WeOCzOtaQ/lcSU7A2tZG+pLvDoJQ/xDgzVtwdcX7XCwVrp4oWWyM7q4rMeiy+t802ET7hawTv4lQInj9yBzcNGzdruQsdDDau5LWuD4Jd1o7Gxd4fIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRpQX/iv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4397dff185fso13391485e9.2;
        Thu, 27 Feb 2025 15:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740697420; x=1741302220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k2YPodslC9xBCdYDOuo4n6OjeMEfkunhm0xpWdMwxIc=;
        b=RRpQX/ivm47wrAeBfbXMS8KPbUuDWKgGLMXh8UIa851J6UIVzEQaQ+81NJQROA17O0
         +KIdG0R3qm5qx2aDdWFIl7WXxUe6TA8En7ufcp7/+DCgMtTlJWpn+5w9rg4+iiC6LvNX
         aDFqsRfQV/dltPcEq1nuSi0Ejuj+giNl+/ixJhyFM1/JPLTU3Ekp1vgVp8axEMabHrXP
         PaDZ1rCYKC1ut7t8Jlnnfm30GQPTNMWgYl61ih0ve/kxQacT242YZbhXY8sv5Kcdkw/C
         qS8bAydytjo3RYDqaeRnS0hZnuukDCxRzqcDhJ2/fopnP+whlCTyT525Bj3syBUfvgCu
         Qp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740697420; x=1741302220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2YPodslC9xBCdYDOuo4n6OjeMEfkunhm0xpWdMwxIc=;
        b=JbwbTVj0TL5MhD/Y6B5bYqT56Yde8MF/dhLhmFqmPOeuvgDZ4iA8eDV3zblxoLH7S0
         +BecXtKde6S6Y3Y+hpXo3qcVujujmHRRaX8Cx6P09Fct4f4awUKmbAfPfuGqaKjzwjXe
         n2QreHNwubKlAPaCnRCItw+B0SK1pZfFOZdpInMJf10oLyM7H2kkOIlm5MctltyyW5a0
         /BEV7lHkD6bcVsAQ0IzQq7iCFrKIC5sKcqfzxj40dUpkZ8fANVvY3n8ltsrm0wRUWQtg
         PynfcZzqmj0Kp2UmHQsHKnk25+Ze2LTg867/+1dA/n4vz4zDEqreF4SPdZ2ZjqDisXiW
         1Mjg==
X-Forwarded-Encrypted: i=1; AJvYcCUuc11ck380BfqEfOuEOzOo3Rx/7cS8M5ZrgHWSuE9EGrpfWKB8RIV68UY0Plm6YGY/56a5NtFVWY/UF9OA@vger.kernel.org, AJvYcCWIxLsO89g8mpMKMrMCQ+HTdzu8WRheawETWVmLehSGKubsNH4G59Zsx54IR6aaqRHOAvrHtuELZuKQJDUyah5K@vger.kernel.org, AJvYcCWWkk39OM+0Nen4JBcVXdPWgubzT8YypgRVOp14fMvpbxz5P6cDBgiFHR9YM2hK4AtaNJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEyBLZkVZoEU3YyBAuK6TwX1oQY5GLxhP31FqIzQ4KCzjC7Um4
	DFwpI58fAX/zgea9hyKfOAOYEaUCXuVzEY8QlYN/rEzBG0AC0YxG
X-Gm-Gg: ASbGncvDajIXb7Zceb8PlkOYIDNliCENyFJ/m4D95itx6RqOMrhBtsjIj/6g0xKn0TD
	bSMmCDczkZgtllZlyKVDD7v2IYrxJ7JbxnWErWpgNEejJoKZHNfKIqNsxE9/7H3/dCHb5CWWcmk
	OLvACNZt+gtATvWSA/xAlTRScpx8QOhu04wErYD7yVDa0N4MjWLTAdpizTPAQaAn2Znko7mY2gE
	sGvZ8cM8GpoYNWpT1F35fJL17473HmptUTdvDcT5BXdvgaCy1az9cr9S6Afa23CS6Kz13LiXKEN
	4JR32LcLMFk4jaPUug1mjFbrmkQ=
X-Google-Smtp-Source: AGHT+IGcaB+hVpAE6LBoJnhlL/n+Tz4TaOAFX4qtUtqkkdfljnpRgZpXncHbzLr1fz6F1NkHPqjcJQ==
X-Received: by 2002:a05:6000:20c6:b0:390:e3d7:11e3 with SMTP id ffacd0b85a97d-390ec9bccc9mr642887f8f.22.1740697420443;
        Thu, 27 Feb 2025 15:03:40 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e47b6cd8sm3285274f8f.44.2025.02.27.15.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 15:03:40 -0800 (PST)
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
Subject: [PATCH][next] KVM: selftests: Fix spelling mistake "avaialable" -> "available"
Date: Thu, 27 Feb 2025 23:03:05 +0000
Message-ID: <20250227230305.661761-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
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
 tools/testing/selftests/kvm/s390/cpumodel_subfuncs_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/s390/cpumodel_subfuncs_test.c b/tools/testing/selftests/kvm/s390/cpumodel_subfuncs_test.c
index 27255880dabd..aded795d42be 100644
--- a/tools/testing/selftests/kvm/s390/cpumodel_subfuncs_test.c
+++ b/tools/testing/selftests/kvm/s390/cpumodel_subfuncs_test.c
@@ -291,7 +291,7 @@ int main(int argc, char *argv[])
 			ksft_test_result_pass("%s\n", testlist[idx].subfunc_name);
 			free(array);
 		} else {
-			ksft_test_result_skip("%s feature is not avaialable\n",
+			ksft_test_result_skip("%s feature is not available\n",
 					      testlist[idx].subfunc_name);
 		}
 	}
-- 
2.47.2


