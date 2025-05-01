Return-Path: <linux-kselftest+bounces-32086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36799AA617A
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 18:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36E79C497F
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 16:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F49F214A97;
	Thu,  1 May 2025 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgBwjRpR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF1520DD51;
	Thu,  1 May 2025 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746117562; cv=none; b=JzkHfrR8Qn/qla/9x3HOZj63ERbzJsBTW+el+wxVpAEHD2pgFBRjUj3cGJdnJy1IiXphvC6On6plgvBOTMJlamLSTtUSVUTc/TSVy4o827dcA9cnwVhb+vF/YgDtOko1uU6nwfp+t54R162o6xz4e92NZ7Br64JfRjEWf7FeLW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746117562; c=relaxed/simple;
	bh=FkwuUMFCd2sL7fD34oCB1Ek3AWYdosfZO9gGoOfRj08=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AXlrL4V1mAsrMfwq3SmZPGLYpKnxcGW20pLsD5eh5aoQUuctJhDpxLFMIcp19n+VrQAIb1AiVprBq2azd0ngvvaDiZzzVMKhkSWk3EOYuqFLhgdoJLzqaxZqh0FXAfZ5+nDbShh9ibArnV4BIj/C9+C8dvqhY1DOMi2cRR93Rzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgBwjRpR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2255003f4c6so13637455ad.0;
        Thu, 01 May 2025 09:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746117560; x=1746722360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TZdpeaEefEtsI5U4bsRp7ztRh4qRfGNOADZjn1xJAfk=;
        b=CgBwjRpR1kBpJnZEj24hd3Ci0Cn3OX6TvaavqdJuvVab1EHs53St71ig/GaV0FvaC7
         HOjuYwoPQPFD/KXo7772G+iVGGwMsM5QDCHa6/jX68X0axj3rQivjsApanwQyxpBiMEm
         TwmIOVmwxGjzdRQX7r8IW9PCBM1Zb0W0jK8UKTYR5o3Z3jktYnfcLYIpZopaiKW62NzK
         XXXRvs0O8qgq164hgnhoRZ1gLxMFp+jMpcmpedXoru8Cbu6Pl94CTloEfYGul0f38PKw
         GHzOr/7Th/zwaqwrIGILozdFBNOk+YD3aYMsUFubc3vs7F4ndj/3ajRhUGstT/pZFNLA
         pJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746117560; x=1746722360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZdpeaEefEtsI5U4bsRp7ztRh4qRfGNOADZjn1xJAfk=;
        b=aRX4FXTrapfTvt5T3tgWdKY9QUQEUaYy3j9eApHfpiirRGQVy104+O0f3s9eHEIZJ6
         UP3mE+IVf1mOakJiq/o4yZqKbh21CnYoICZ4t6c+tibYauzZtWOFODjuHs0OYG06NKEJ
         Faz+yrp5rfZN16uLvLx1vqXQdZ+g/s1w4VZauf3hP3JoFxE9ndXc0dcnTMdSsSy8sh5V
         ljVuWD4SoJZc5cKviIje9JkQVB3GZUbg1JMkzEBH8x/Q1cPFSXGrZ2y7avGkQidr8lEG
         LdT8yH8SdwJNXtoj1GBepO3EtCYIsNUVwSv9wEyLJVoJxC8JvXo1vHCJT8jd1oHFnZez
         vsXw==
X-Forwarded-Encrypted: i=1; AJvYcCX/w/Z3mC9Y/kiEsc2cfCH796QQiEGYwlQZBxvacvtLoOJJuVOH+sNeKy14rLC9Irzv/0VOh1zgTVnoMLpEuPMw@vger.kernel.org, AJvYcCXcd3YgZqIzR2i4whBl/cvSWyHZVBzpDCtsYc3mgqsMfmhuaJRc3wdLKCHNGCxLepbZGL0hgYUb5v54Z58=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYROGGrqwsQR6XJFnW4wUMvDo4XgHa8DEygNyvJiHtSxYkPRLb
	z1H/tMDCoUXytsuqQbi6gMiteumlwKIG/dXizbzPe+BtXSGL5to=
X-Gm-Gg: ASbGncuQiucgCR1JAJWUPceJYY979lu6gLICQzbrjkTHTAnvcu29pC20PF4RfrHIKNW
	2ElG5JyCsJ9EGa3TvqpvwtwwL9CDIxJ/t6F1pOS4Hu/BudbtLpSP0nDNwAlcoyAJ5IqMiLMd1xt
	pXAp5fgK9qJvJyz12fBssqNnewFijST0NoC+crUSjbC1CRFHig075w0NSlNhNDLdI2eiNEeR0Lq
	TuPnmqOTjqd9Hvmc7FJp0fpTRzb9GoBU7JQ5WwROay8tU/0BtQsCb5KBEce3/ChFuHzjLrgWpWY
	ztQv/lqSm0pSDw2KmkZ3f1Vm8l5IkzvM7cRcht99cX6Zmbo0OQ==
X-Google-Smtp-Source: AGHT+IFcwEYNw1wVY/04aDP3XIHmVYZkBEqwaQakpwHu+5ab04JpJku3qjLTtv6yJLXJHjahlvlAfA==
X-Received: by 2002:a17:902:ea0a:b0:220:e9ac:e746 with SMTP id d9443c01a7336-22e0865c0c9mr54769345ad.53.1746117560161;
        Thu, 01 May 2025 09:39:20 -0700 (PDT)
Received: from debian.ujwal.com ([223.185.132.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e0bc6e678sm8797525ad.132.2025.05.01.09.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 09:39:19 -0700 (PDT)
From: Ujwal Kundur <ujwal.kundur@gmail.com>
To: akpm@linux-foundation.org,
	peterx@redhat.com,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: [PATCH 0/4] selftests/mm/uffd: refactor global variables
Date: Thu,  1 May 2025 22:08:23 +0530
Message-Id: <20250501163827.2598-1-ujwal.kundur@gmail.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset refactors non-composite global variables into a common
struct that can be initialized and passed around per-test instead of
relying on the presence of global variables.

This allows:
- Better encapsulation
- Debugging becomes easier -- local variable state can be viewed per
  stack frame, and we can more easily reason about the variable
  mutations

Patch 1 needs to be applied first and can be followed by any of the
other patches.
I've ensured that the tests are passing locally (or atleast have the
same output as the code on master).

Ujwal Kundur (4):
  selftests/mm/uffd: Refactor non-composite global vars into struct
  selftests/mm/uffd: Swap global vars with global test options
  selftests/mm/uffd: Swap global variables with global test opts
  selftests/mm/uffd: Swap global variables with global test opts

 tools/testing/selftests/mm/uffd-common.c     | 269 +++++-----
 tools/testing/selftests/mm/uffd-common.h     |  78 +--
 tools/testing/selftests/mm/uffd-stress.c     | 226 ++++----
 tools/testing/selftests/mm/uffd-unit-tests.c | 523 ++++++++++---------
 tools/testing/selftests/mm/uffd-wp-mremap.c  |  23 +-
 5 files changed, 591 insertions(+), 528 deletions(-)

-- 
2.20.1


