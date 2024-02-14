Return-Path: <linux-kselftest+bounces-4609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2638E8540A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 01:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88381F22758
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 00:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893A3385;
	Wed, 14 Feb 2024 00:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYiIOZdx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D9FA932;
	Wed, 14 Feb 2024 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869022; cv=none; b=chIoWq0H5AdxNeVo03g5jSa9uDDGyaiDvQs7Sua/hu9AmA+A1Z7gRqHlBFEgapwD3tifz8Z61fyjP3N/cuT6mCxFMQiLiog6kxppZE9DgI9yp2LXlmFrfDI7YeLYpwWiCtoIW904k/D6MpVbcSKLm1xU3A5j2TX/9pmZvuxnv0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869022; c=relaxed/simple;
	bh=79sVC2xwZcWf9em7+im8l8pxbyWTZViteqZQC3s1w5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HdKlH4yFmTeih5kNz0df9vqCHQ5lBS7AIcS0AsWnCtnwPAtsCADUmLkRt5nNY+wW2OQvs/6eH6h8iQOXSaX2nFSVGjWPpXWLCdeAPmJQCm+5+OzFdSq8aY+A1aDqiDTp7FuVs3GOQZOSRXiXnClNeowVPv0ZkvtwjgWOsnN2jV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYiIOZdx; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5114c05806eso8068853e87.1;
        Tue, 13 Feb 2024 16:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707869018; x=1708473818; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPG8iWh4xmglJXdCUV2hXb98YGfDYIZwCuRxjUIHlFc=;
        b=GYiIOZdxndcm+Y2Q5giWWC6z9LXv0uxph9skjsNnrz8oD+9MStC8JyOCnXwPa2G3DB
         pYg9ase5E7BDgIrUMLgG0/TjMGWBq8Vt8x6WzgYwUa/h8ANQ3cOHA8GoLffsulLx38sA
         EkAaX5WkwVVh3wcNe8ljwpdiO9zwEOBfqvfLI+Tculnl4BQmrMHEO/atqD27dC/MIbXZ
         ujUcVmZ8dBU3v8ULpuz0dNDFAx7RACmzouKi0sfjAOui0OfC/eHQb2h+MdzxGTKJc3nl
         bhodQM/MrfXY7ZcPbHY5j/bsy8e+9anQWDEt+N453b2YT+Fl4a8IVe4cUm8U00SQvjM6
         cRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707869018; x=1708473818;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPG8iWh4xmglJXdCUV2hXb98YGfDYIZwCuRxjUIHlFc=;
        b=k5bcTWb2o3TL3Ji+YkpV23DyO3akPU1xqg2I2/q82TKSjYVj/zuzuwNL0DFtByrCe9
         EFqivdA8xFPS8E9nwW4TsLAn5AFXEa7uEw+MMlq/Advt6ZLsuTxJRjUFif4bvJnzWsqO
         2NqUPCRFDyBfsM+qf9cjCjf4oCm0NELR5AAaKZpM2qvKpo2JB+QLXdL78t/7uJ3N/hvq
         AFPFzdmZbAlGFi4vNFXRmqfc/GXIZA3ycFEGLIKDTwwX4APseVXLMhYwvgghP5LEe0Ih
         COiXyWoZQOnpPBWTLur3SfY+diwicn1sz29JU0NCMxub+8t4p+S9OpadGcV+gzeNnEIF
         wC+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXijFG+8058RoFLPXWz65tKV90bb3PLQnODg84hKvM1TGf9s4uDpXe4rp3dxIaRp5SxFwsQPZnb51lI8DddSY77VfOc19Ac2I0fuN7PTRvQ
X-Gm-Message-State: AOJu0Yyl+Dk+oH8uI8qREFjPCPdl8il/MW5cuimK6iin7OSACw6d+lFA
	HGgnB3PHbe1aOCLvO2OGZplvAnFc92/uWa+45b1dIPkERI7ljQ2TthEotoh0dc1kXQ==
X-Google-Smtp-Source: AGHT+IET62gNEP1TryO/d84l1nhoAgvco1Q5Vupuj/VHXjdXg4J0vxT36LXpI5G2dRrT7m5fX8uUWA==
X-Received: by 2002:a05:6512:3da7:b0:511:893f:11af with SMTP id k39-20020a0565123da700b00511893f11afmr899724lfv.38.1707869017963;
        Tue, 13 Feb 2024 16:03:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVz1gJHO0Pro85TeecuMzEBKdPk4bSzrESmyT3oaBHYedzf1V+D7XyP2YR0odvYol2yY0ov64Gs3AHAftwVE2nWj8a9Y9qc9BZ0LXVbSIQl+uaaE6stTTe1vJkLCo56BVqTzgX2qfGQt/kp63HMpEkMShIaSFblPaz6RQU57Sg=
Received: from [127.0.1.1] (2a02-8389-41cf-e200-68a7-7041-4298-e66b.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:68a7:7041:4298:e66b])
        by smtp.gmail.com with ESMTPSA id vo10-20020a170907a80a00b00a3cfd838f32sm1160901ejc.178.2024.02.13.16.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 16:03:37 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 14 Feb 2024 01:03:33 +0100
Subject: [PATCH v4 3/3] selftests: thermal: intel: workload_hint: add
 missing gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-selftest_gitignore-v4-3-857b39cef2fa@gmail.com>
References: <20240214-selftest_gitignore-v4-0-857b39cef2fa@gmail.com>
In-Reply-To: <20240214-selftest_gitignore-v4-0-857b39cef2fa@gmail.com>
To: Shuah Khan <shuah@kernel.org>, SeongJae Park <sj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707869012; l=762;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=79sVC2xwZcWf9em7+im8l8pxbyWTZViteqZQC3s1w5c=;
 b=5SsMXg3tFDxHLWhLV1lbLNaBCmtK1ct7Uf1t5HahyCW144hMccM7X5o2Pv24Rsx23vx29bt+V
 Vyq85n9BVOXDEeuSn8INA67lvHvzhbV9uqntY6/Sk3rypPPdM6NeSvQ
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The 'workload_hint_test' test generates an object with the same name,
but there is no .gitignore file in the directory to add the object as
stated in the selftest documentation.

Add the missing .gitignore file and include 'workload_hint_test'.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/thermal/intel/workload_hint/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/thermal/intel/workload_hint/.gitignore b/tools/testing/selftests/thermal/intel/workload_hint/.gitignore
new file mode 100644
index 000000000000..d697b034a3a8
--- /dev/null
+++ b/tools/testing/selftests/thermal/intel/workload_hint/.gitignore
@@ -0,0 +1 @@
+workload_hint_test

-- 
2.40.1


