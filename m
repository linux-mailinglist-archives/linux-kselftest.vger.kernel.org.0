Return-Path: <linux-kselftest+bounces-38863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57555B24DB4
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 17:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68A4BB60324
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 15:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52BE273D8D;
	Wed, 13 Aug 2025 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJ4ZwuEX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D3424501B;
	Wed, 13 Aug 2025 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099528; cv=none; b=McA5pwNDZ2OAiJsdwvjSaE6RsYOG3qTYqE6Nd4rcOIEmQZ1aX+ZnJ9tRRPzaj7Q5F4vIZXbmQZoEZXBSwaClUHLtjUvQtyA70h/IpsTt+oGVu8O3l343bkrZOR7sH4alehZMhuJa89jCqJgVlKK27L9l1WDQvzDZsR8oxNsg1C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099528; c=relaxed/simple;
	bh=qN9x0M5iZ/AJ3TuhCeARilRxngvX7v10a63t3HFI3z8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kqTM6Yu5y24CUoiEq1gD+5teKGG6GD8V03yfzNDtUy9/wwUUgmYLGNGmpoMTO4iQAAfNxWs2fICeMyt8RHq0MHJJzqzFK297mehu1AAQMB7v4mxLupTMlsLBL6+LqJXJi4HHZBE37Xhvf0RqXihTUzj5iyFtRmqU2jm/Z3Xar3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJ4ZwuEX; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2e89bebaso45070b3a.1;
        Wed, 13 Aug 2025 08:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099526; x=1755704326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FA+E4yoYzdUzcvg+5vC+lhnzGIxbCNmvdw1XMVNouhI=;
        b=BJ4ZwuEXz6uZjn01qAj32XDiOWJXHJ32SxCowjM/FN2ypzOEPZyMJ/IYJHdfWt7BCp
         b45MGv+EAg4UVY3PgdEI5f5qtcW83hZHeehJpnYaIO/sqAPHkSvh0tRNjCfX439B54fr
         KwFSgB5yYTzhyqN+8w/jtfnPKjW3exDQu88ZbWoI7N58IIAnQKklkLKeOJRiBkEPCzSg
         Q9YZEDgE7v3HBOCUc93SoGpjKiHlyFHet0u2oTvZBYzYDQo1o6vel3LGfRo07tevvcvk
         j5hT5QYhBvOrzJcnIvTXmkJydMHBjJf0VmNWOTF1G6s2Rwws0Mdhl1Z/Oe402EY4/aKx
         eyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099526; x=1755704326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FA+E4yoYzdUzcvg+5vC+lhnzGIxbCNmvdw1XMVNouhI=;
        b=h9KQZmDZBwtHn3sqKs1qKK9dlL2mns9xFcfTvSMfquzS8gMif7t1+88V0KhImQvzrM
         bAY9EvjvlDZhClxAU6+TlTfKIJmM9bgqi3uPFRKvdv1yB0erLDESPFwMQenFgC2ArHEx
         sCzfmyKKHVV9PRjukpEiz0oKyX2Z66Qsb61RtJmNFAn9NRizHhzy211d8sAVPfMQz07O
         mfzneM+6wUoCo1Jgw37IoGME4AanDDLxho9M0HSFZyJNbLRVkWlkuBzryqygZct1nr0S
         xZucDiQ675frLP66FuEjKqUyQ1e4TFOsnP4RI0Dp3NtTXJ5MR+SpJbXl7F1D9X9e5xD6
         7ppg==
X-Forwarded-Encrypted: i=1; AJvYcCU9xbiN8GiNd9bPSH+smXd1FcvIPW5evV5qGv8YbihFWizau8on4v+Y7PtTHi7I93owntYu3IpMaFUpK40DzjMZ@vger.kernel.org, AJvYcCUmRJ/lHzzbAUa52odx0l+v5AqssZ2GB9JJfSxtU+qEGA830J6QLb5Ui+qbk5ua1AVvoDw=@vger.kernel.org, AJvYcCVHvZze8OtxXX6acXLpPtSxYTXIbag/wKSyMCux+lhaR4Zi4JoWxJ6ByO/0an5H6K5Is+tNL9SOcy+6Sibx@vger.kernel.org
X-Gm-Message-State: AOJu0YxTx3tXlrXF0YHFa5BjlblppAFMF0j04DjAx1tMpwCLTbILfG1U
	gD4QwGMUSP2SrynMzT0nZGOYkEZRyAhhsCxyjr7SdVYSNqlbFJXvaYDb
X-Gm-Gg: ASbGncuthmg2pVvyvHzD1YWSPwHWhLyNq6FtiYhqcVXS7PYGnXnWkvOw0GoL92R9X1o
	gGqPQhQLQxtdJWc/5qaRdPX4XXQ6MYcFf3Sw9RQmiFsLFrixqZp61Kot73QPwQC4rJ4rS4n84Ju
	BJ61p7QDsgk/OhUapz15yxPgpK+uKmwSOtVdg3weQJaX2FDypQEOmXWTiKctAWiZnMeY+KlPiLY
	vajaX+j9VuIR4ebUkEqhi5650njzuV9ZnTuipvNgNHA/zyTEVbXOAunAQPoo2YV0vHH9PlBvo9P
	L6a1lEiOND0FiA/PtvAjlOt29EurdEPQ+B0U3YB1jFpt/qRKz9FEJme364Pqq96c+tWlO3/Nllc
	CoMgZF7XXHEjExKigv5mxkJQ01qRKJjiW6RBHlKqDhtk=
X-Google-Smtp-Source: AGHT+IG5txLJaBD2EVOoyMG9/l69czxsPDzAirfxlZMTnU+Olk1RBvYjkCxzs5/ABD4vdLuVrRvqOA==
X-Received: by 2002:a05:6a20:7d9d:b0:240:2473:57b7 with SMTP id adf61e73a8af0-240a89ffe05mr6124974637.8.1755099526416;
        Wed, 13 Aug 2025 08:38:46 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd156sm32301174b3a.84.2025.08.13.08.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:38:45 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: borntraeger@linux.ibm.com
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	frankja@linux.ibm.com,
	imbrenda@linux.ibm.com,
	david@redhat.com,
	pbonzini@redhat.com,
	shuah@kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH] KVM: selftests: fix minor typo in cpumodel_subfuncs
Date: Wed, 13 Aug 2025 21:08:36 +0530
Message-ID: <20250813153838.5470-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specifically, fix spelling of "available" in main function.

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
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
2.43.0


