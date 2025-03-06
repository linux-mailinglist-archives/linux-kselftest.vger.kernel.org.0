Return-Path: <linux-kselftest+bounces-28433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF87A55916
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 22:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B40189A0C1
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 21:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD2027603F;
	Thu,  6 Mar 2025 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbWkDGSx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08AB206F37;
	Thu,  6 Mar 2025 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297927; cv=none; b=JUeKqw0qojB5WFkcPtFlc38dKRgxwvuYv35ofvAYTFl+O41Y/Py/e5ekHS/Pu52BHVQdiFoUVlkVCjzTWwWBdrY3JhkbnhqQ2cot9cbBWUlV8sJctu+vSfUZOMkv0ZKE4BlpAKA9GKVqrrJDxzfTQJl3PL8+9jUB9cSeocu+0E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297927; c=relaxed/simple;
	bh=M18lmg3jbS0cvipMCmwsKOy9o2ceYd8ajV/LUibTal4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jQQsEuuHIfGdZMC7kypM3CbirAzIcWIQz0u7S9FSC2xEcsyWmgj8uuwFLX+Id92/Oa6RKzpIjXmkyxtfgYLtXej3UQxJ0wg+Q5r5zm/5/W4/9s27zqHfb//kuIz8KpBb2i29tVxYQxUrs7zBQ80wH2gya6EbGHyQvjNuwi8NXso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbWkDGSx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22113560c57so22385975ad.2;
        Thu, 06 Mar 2025 13:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741297925; x=1741902725; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WDKro83c60U5TWWT7yKI9Ym3S5pwd6hN8B1wBkncDXs=;
        b=gbWkDGSxwY/ZBgAbPhN7oF5fsaufbq/ORAotpsyioYDyHnXG/FqIy3C3yF9l8axTqY
         Hky8wYXmT7inH0b8saenB2j41PQT8DEPIvd1aW3RcY4PcxPBNtAbCytokF7KwaiVLOvz
         40W00ClWKXNGJ3fcbqIlSuxG5XyCS1mePGQoSoN+jUKusfOJesjtIiOXWSByjozRgACb
         nTSBzvVlZskQTx1M0DRVFZ0Hw0WqYkMDbrTj95aMP5C8CSZD+FI3IgpN4bv2HGI1S8Zx
         lK0c4qHFxI6z+2zaf2LRXA9iqc3HSlurZUwuRNRS7pAILKqAPcqyWEsKYOa781KQlIOU
         RH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741297925; x=1741902725;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDKro83c60U5TWWT7yKI9Ym3S5pwd6hN8B1wBkncDXs=;
        b=W9D5skVIwss+/aomdaZTRqUs8iU40LgcACn+HS6riS6Hs5NgaVEOHLeCJmGOs9nJFs
         BzRHRhTMmlF1MD7ethYZKPbuEGB+Y1LHc4wL7/EXlV2yZeATLhrvWW7Se0n2N8hWAIzF
         WjGpYD7e6jgDubv637R7P3dSdaQ4cuLhVLKUdNFnYYGuULLEHgI3MxsaY+w/0R4us4l9
         XoSFdTNmtgSdu6eq9Csx5l3tjkuYpC4K1C0a3JhbYAjyHMy8fRA1/d1T0tpdWudBlsM1
         wAY8fSCfkMb46WWFZkhOdkD++o2WbpR26XudXWN2sDaMLDUh+oe9mF0f886VnZJn0MFq
         jLGA==
X-Forwarded-Encrypted: i=1; AJvYcCUKidl3a14G7LpmxrHhDhjAIx/umcCn7GM8cXURHREKh5AzEwNd1taj7uFwhq/d3P++syTiBjsTa1ljDiw=@vger.kernel.org, AJvYcCVSEYj7cLos3ur6XUQIMn4i0EL7o5tY5r0RIR3ecgTVcMUXpbDP2+Itul72rbv9T7HXn0F62zJ0fwKag9ZHBQLg@vger.kernel.org
X-Gm-Message-State: AOJu0YwqqLIbi71YJ45+fypbsBd0cYJPNbnyhHUSNsynIcA27ymRvMrh
	e3YDImfgk40fsi61vOfKCKMlcNv+HB4vcQ0jLy1PcsiqCulj1QFY
X-Gm-Gg: ASbGncuOMt7PaSZVsdewVAwJ9DcpchTBowULrPV0Ylk3irF2/9MBeog9KLrjrNBAjEk
	VD5Jc6qYv6atdpsfMlyq98SSfTj5An98qGG3RzcskefJJ+PvjWpoCHSpPUK0mDFFHdTU5aT+bS3
	AzmBi/dBjDQPbVrGoSPByZIfxJSxszGVqomeBEFZhS+mHrr+LLZN1psgY3Y8/9sx/BTH09P1fLB
	fj3JaN+R6MEPxxCQJKa5Ia8/aRvYZJXXs9eh6+fQkQ2agfLVZ+1uV60UZ08jNRbN6jhFEMJ+O95
	shiMU10dPvtX/1rmzdrJkB/JsSfCHHieiUufSpg3ewq9KeXbi4Ib
X-Google-Smtp-Source: AGHT+IHuxYOLq4TAKe0YaWxaQVSKNweQt763jTASPmjhuo75Pu5xNYSeqX4OQnu58XCFO6DoXhf48g==
X-Received: by 2002:a05:6a00:194b:b0:736:55ec:ea94 with SMTP id d2e1a72fcca58-736aab13baemr1425776b3a.20.1741297925237;
        Thu, 06 Mar 2025 13:52:05 -0800 (PST)
Received: from fedora.local ([2804:d57:4e50:a700:f33d:65d1:e22e:109b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7369824554bsm1923651b3a.69.2025.03.06.13.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 13:52:04 -0800 (PST)
From: Filipe Xavier <felipeaggger@gmail.com>
Subject: [PATCH 0/2] selftests: livepatch: test if ftrace can trace a
 livepatched function
Date: Thu, 06 Mar 2025 18:51:41 -0300
Message-Id: <20250306-ftrace-sftest-livepatch-v1-0-a6f1dfc30e17@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO0YymcC/x3MQQqAIBBA0avErBswK6OuEi1ExxyICkciiO6et
 HyL/x8QSkwCU/VAoouFj72gqStw0e4rIfti0Er3qlUGQ07WEUrIJBk3vui02UU0yo/edYPWbQ+
 lPhMFvv/zvLzvB95KW2NpAAAA
X-Change-ID: 20250306-ftrace-sftest-livepatch-60d9dc472235
To: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, felipe_life@live.com, 
 Filipe Xavier <felipeaggger@gmail.com>
X-Mailer: b4 0.14.2

This patchset add ftrace helpers functions and
add a new test makes sure that ftrace can trace
a function that was introduced by a livepatch.

Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
---
Filipe Xavier (2):
      selftests: livepatch: add new ftrace helpers functions
      selftests: livepatch: test if ftrace can trace a livepatched function

 tools/testing/selftests/livepatch/functions.sh   | 45 ++++++++++++++++++++++++
 tools/testing/selftests/livepatch/test-ftrace.sh | 35 ++++++++++++++++++
 2 files changed, 80 insertions(+)
---
base-commit: 848e076317446f9c663771ddec142d7c2eb4cb43
change-id: 20250306-ftrace-sftest-livepatch-60d9dc472235

Best regards,
-- 
Filipe Xavier <felipeaggger@gmail.com>


