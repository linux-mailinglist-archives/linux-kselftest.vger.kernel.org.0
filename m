Return-Path: <linux-kselftest+bounces-4603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F2E853F13
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 23:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64911F240C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 22:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1090634F6;
	Tue, 13 Feb 2024 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxT5bjG/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E5C633F1;
	Tue, 13 Feb 2024 22:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864423; cv=none; b=TO6ECrxUluB5qvgfFkmeh6FFAfU0z+AJPihhmQB8yYktFEE5pGendXzu226OrBo9eN0RcYjgEakK5h78uGplXCGaWJMWOfO78/LojWb3N+sh7geoajyzODMMi4dO7inBRGk6p+1i4Jwwgr8GAdq6xMaczETL2MhJpU6c28RC5yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864423; c=relaxed/simple;
	bh=LxI8B8lBhn/XmQtHholcJbNICjxQ6qBn1CW3zMr7+G4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tWBDTPGSz7OdyUE6Y2OcCjtvuOfFlhebdzALO3fBRDnzKr2TodXBsg643fAejTeXptRhIYQmkozQdrpWdGmRNqaU8wINmEQKxmq0RNjv1c8azjj7ebOPmW34wUld4Tp5dXZovwGP/QKJvcXtF8HeoEWcoMiKUhZ2eeHc5cnsf4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxT5bjG/; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5114b2b3b73so5677613e87.0;
        Tue, 13 Feb 2024 14:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707864420; x=1708469220; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kP5efisalY835Gdkg7ANhnq12G2jME8WCLfPT0go4I8=;
        b=fxT5bjG/EbpZ/zcTiTNlaYVtB6XstjeS4M7CY6IBjzj6j9FTZ700mbmCkqmpa018+a
         namiHPDGWyqFJUDJ5i/OjuVI0gmzwi1rkIhnQ8mztdeEO//bICUFH/ACr5rP+a3MVSOC
         EF6qKJ+lGbQ/8yE60urCGRjTi7BhE4gOby5JThMMHKTrkjuUi5sqO4h2s+TAPCp/eLQt
         NAbx+msoJWV6iqC6wtLjnUy9jlBuZ3H+knJHsNohOvM+3V5urHRtnrqbhOHokvpJKkqg
         38psxac96floQhQeMJpTmwKCuAj+wTNBp6N/GKU9I6IEZju89IEq+RuRr68M136Bdtw0
         Vl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707864420; x=1708469220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kP5efisalY835Gdkg7ANhnq12G2jME8WCLfPT0go4I8=;
        b=fhVj2SxutoEupQqrsYjBnO4tFa4xwbiL8V4GV7AYHmStqAGPcgslp1Mf0/BaEVyjZ4
         a3s723Zg1hU/FmmnSRdEDiPJX7CDtqf01MZQ/F6EbNMyztQx8NuHrP+wT08mXAfhlDMq
         IDWJeMXxcqqn4l6R1gHQwfFlPV0vU5XCfmtrAz8K+s8Y+TJo37YODo/lfER8oAAPxkHh
         42NAJRNGefAvFf8noQhXx34N9Voja4RwQL2mNB6eP/9gK6GrwLe6ySOXqWAV+DBw0wRW
         XNnMI/KE0jUnbTJTxvuTvYkp7rCn106EldBCxW62sJ3aCrT2n1uKj3Ih9+G+CgiuCm44
         uj+A==
X-Forwarded-Encrypted: i=1; AJvYcCUQT4SL4PGoGuBg4ra40jjJ+ZJBntDwuAl8KhiXL4kvfLOj3IplbrlkuaO6Htzp4Sy5zRJWnQnqVTCbfTN4WtgQeOlyWa31VDcoo/8BS//i
X-Gm-Message-State: AOJu0YwUBVylR0MSzRVYvdGcS4aRqV/HobZsuO0E1mr7+X9xBDCEFH1a
	3HKIDhHT7SnND8i0CsuTKonRhHIH7CUvLdW0Uz+D+Qycdr/lmvj8jC1Dhw6aPiWTyA==
X-Google-Smtp-Source: AGHT+IF+t7gw8NE+exX25J9xmMHiGEAVUDpnCrOPPo3C43LfOiXPYaT5RiT7mlS6la0torbVT1N9aQ==
X-Received: by 2002:a19:9156:0:b0:511:4db5:99f1 with SMTP id y22-20020a199156000000b005114db599f1mr755657lfj.47.1707864419657;
        Tue, 13 Feb 2024 14:46:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+e+fpkE815s9YIEA4ppg+yaXx9HNg50ERt4ElOzJM1iQaKScgv6MJ9HUkqGtwm6QItAwyMbo5ELU+a9HCBFTvvNHIbMP1wVJEd9v705O+CvCJYMxWGQhIOTNsd+dI3AiktYBn41MuBdafW9HH4fZ4jUIzJ8wiX4nqZnAhaWSX9zfBVOvnt4y++nIFPe7iTyqYSm9l6XgAsg08mR0/9d/dycahBM5bwBZfob3GH5XpiUFwMfzh9BXnMvG8eoq7Ufdebtmp
Received: from [127.0.1.1] (2a02-8389-41cf-e200-6ae3-bc23-bc27-2247.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:6ae3:bc23:bc27:2247])
        by smtp.gmail.com with ESMTPSA id b17-20020a1709062b5100b00a3cd41b3c19sm1700077ejg.199.2024.02.13.14.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:46:59 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 13 Feb 2024 23:46:53 +0100
Subject: [PATCH v3 4/4] selftests: damon: add access_memory to .gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-selftest_gitignore-v3-4-1f812368702b@gmail.com>
References: <20240213-selftest_gitignore-v3-0-1f812368702b@gmail.com>
In-Reply-To: <20240213-selftest_gitignore-v3-0-1f812368702b@gmail.com>
To: Shuah Khan <shuah@kernel.org>, SeongJae Park <sj@kernel.org>, 
 Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 damon@lists.linux.dev, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707864411; l=832;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=LxI8B8lBhn/XmQtHholcJbNICjxQ6qBn1CW3zMr7+G4=;
 b=b7oBHxTOzmxfTZ1mX8GnG3XuE9dnjr4kvcQ+VOcn/NbxWJt/LzL4uKo/vxUr/7ZICxhNHHgQe
 +PYxh4pJgPnCxOx7m1r8V2bnkLY2hhDn9vUWZii4Q5cWq8kPyoEijtd
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

This binary is missing in the .gitignore and stays as an untracked file.

Reported-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
Closes: https://lore.kernel.org/all/AS8P193MB1285C963658008F1B2702AF7E4792@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM/
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/damon/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/.gitignore b/tools/testing/selftests/damon/.gitignore
index d861701f0327..e65ef9d9cedc 100644
--- a/tools/testing/selftests/damon/.gitignore
+++ b/tools/testing/selftests/damon/.gitignore
@@ -2,3 +2,4 @@
 huge_count_read_write
 debugfs_target_ids_read_before_terminate_race
 debugfs_target_ids_pid_leak
+access_memory

-- 
2.40.1


