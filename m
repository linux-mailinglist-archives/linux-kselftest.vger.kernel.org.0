Return-Path: <linux-kselftest+bounces-33679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DEDAC2AC9
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 22:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB9217F2AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 20:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4331F418E;
	Fri, 23 May 2025 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDKFhX9X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE822338;
	Fri, 23 May 2025 20:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748031774; cv=none; b=JS8090hByO3CE8FiSn/6B83h8afZZa66r89eDvkYrXwq/mBXUposoXD+bwz9HrVKfmkUJv2BhUZ+7j6oNmZEc7gGzX6EYEC25H/EBWKrAFz3bGizsi1HiVhXY/7mMRqRs97Q8ACP/GA637vJteYeeWLmwfJHkBimHp2Z+AQqIGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748031774; c=relaxed/simple;
	bh=gdGOZhES5ZVdb0Ry/4gXsJos5Ia7PWWzwWxwDVw7X1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QsrKzVcjFGZAniju6LJBrXSVwtP5WJkjtkSPNR8DdkD48RimAocOXnPve8T4yECDXRTOko4+W6kiX+dQzMWxd8Lt8q6bvYZxXIMga0N1+KKGI1eBFRIV+XS3mK1xysJly11fmjS5lniuXR5i34CjsN8bDDfXW3IrG25bfLcZqgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDKFhX9X; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60236e3d093so359209a12.3;
        Fri, 23 May 2025 13:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748031771; x=1748636571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LQGGRhDFzfYXAwRufYqCszOLJOQpXO5dLAyeYhV8EXg=;
        b=CDKFhX9X3xqANwLTcvJ6DPDK+nLFQjYiQ79Ni9mnAlCr20bMH89SUSJQmcXDrlT6Ud
         PAqRci6ewLVfmGAVi9gh46J1m5vakBLKsolH76Fcd8z0n86BA274Z5we2dpaiUJB7Cnm
         2Uir0IVpFN9PLX48VZjmSAZKuMTOXl3PiiHZbauZtszmYm5kx4tB/E55hp5t5h00lxl9
         63AjNxhjuk7CX+3HhJvSf93Xr2bkd8ImcwDfJEET6VsRKxlJoJkUL4HuccdAAKXq6wou
         08A5U20AcxngFz2rHh5qKrMgpDvOkytIzOEcAtEuJdf2LXBNSbXMn6D96c3C76eYmXS1
         Ne+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748031771; x=1748636571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQGGRhDFzfYXAwRufYqCszOLJOQpXO5dLAyeYhV8EXg=;
        b=ZtM1qsqXe+bSSUbw2N/tyD+tLqxEIvUv8xC8sXdC+mDqlp+LpMy1FdhbtP3igs6wZR
         WBlICotOccJXd8N8AhFFhfUzSasRSUIV73g8VScu3eyxtTKfo8EfayEnQfFkglk5uhrX
         ZD4C6eTU9iSdcgISfXsJbAttRkP0b8+s2GnZXIh6Qw5TEpWeDVPzz/D8/CXxSAoUGoIo
         RNSpxZyTiYzXJmGj13nAyGNOFlEAD5mr1fZVImV89UjxNd6g4HxDAi0uEpCkLinjrD9M
         FxjO6cLr9vxMdFttcwv1ZOqZsqNrdyFV0sfym+XfUCp6gKyQf5YCMWAiYRDuQ9VXYTW3
         Qk7g==
X-Forwarded-Encrypted: i=1; AJvYcCUs5YnedrZtSWaAA6lcJjNyHxvlpXFzzmIYg31wSC1NSnuhErfAEach6cjFx61APWGuOWQdZhheI1TM/Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhLq8KXncxRPJ16oxu9usQOrbSThgiitv7xjM6Sr+VvgEtusFd
	JA3TWd+3wC+AlwA0NtkDr65M0ZWWYRoh7ixI2t7GyGNFvTxzherhttc=
X-Gm-Gg: ASbGncv0dQ5fUbiC07sT99tTk6cvvI+TpLLqNJQPUNLvv9WjhI8UKI3OoJxlHM5sSCK
	sg/F0ZVAdNY7VTgTtttFtOfCgW19rKhia2SoJJhQUxTFcRB6A7KaXs4MVFj17jUMWGnt9Qktz8M
	iXP6vhrEDbdlrdksUGnHl9bJSp/fzmvXxCNBRHOAjXy43BaW5J6cycZWGkZ/+EOebm1IKc1NZfT
	eHFoyC2XGlbJVLhtS1NKqWsdXvZ17ipZBd7Qudff1ra4n6grCJiCi3cYjl9oTWXi3GqnA91wzMJ
	QwNpGvSl2YVMeNpU7qbk0PhJQGG8e0JH5uJ65R/Rm+hEB/CQCxl/Po7Oo8rcgq6clmeW4r0=
X-Google-Smtp-Source: AGHT+IFaJs+4iZ7OReznLn2Mt6fklkBCNbKteZfnNxAJkKtYhynt4wiC7/6CVaTQFRcQSDTdg40P+A==
X-Received: by 2002:a17:907:9718:b0:ac7:3912:5ea5 with SMTP id a640c23a62f3a-ad85b2a6042mr49141166b.58.1748031770318;
        Fri, 23 May 2025 13:22:50 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:42f:b2e:ea5a:d342:ee:1a7a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d278290sm1274299466b.78.2025.05.23.13.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 13:22:49 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: shuah@kernel.org,
	skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v2] selftests/cpu-hotplug: fix typo in hotplaggable_offline_cpus function name
Date: Fri, 23 May 2025 22:22:39 +0200
Message-Id: <20250523202239.276760-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"hotplaggable" is replaced by "hotpluggable"

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 Changes in v2:
 - specify the subsusystem in the change log
 - Link to v1: https://lore.kernel.org/all/20250517011928.673585-1-jihed.chaibi.dev@gmail.com/
---
 tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
index d5dc7e0dc..6232a46ca 100755
--- a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
+++ b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
@@ -67,7 +67,7 @@ hotpluggable_cpus()
 	done
 }
 
-hotplaggable_offline_cpus()
+hotpluggable_offline_cpus()
 {
 	hotpluggable_cpus 0
 }
@@ -151,7 +151,7 @@ offline_cpu_expect_fail()
 
 online_all_hot_pluggable_cpus()
 {
-	for cpu in `hotplaggable_offline_cpus`; do
+	for cpu in `hotpluggable_offline_cpus`; do
 		online_cpu_expect_success $cpu
 	done
 }
-- 
2.39.5


