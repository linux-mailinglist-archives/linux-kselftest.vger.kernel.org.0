Return-Path: <linux-kselftest+bounces-36187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B130AEFBD7
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 16:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5E14E0A9D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 14:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC0D277C96;
	Tue,  1 Jul 2025 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="ljnSiiB8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from jpms-ob01-os7.noc.sony.co.jp (jpms-ob01-os7.noc.sony.co.jp [211.125.139.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C80A275108;
	Tue,  1 Jul 2025 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.139.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379271; cv=none; b=tZsKxnVBDC31ONQ6IKSih6NdKkRCrhqZj6v56Y1SNv2CyTo2V6NMhWGoMYm4j8sSeQ3wXhULRLMrwHkPj5hGFaD+L0htD8YdnIv7quutSDuwMI17uc5NTJ8KDkTyeKMQ+GO6vUHO9cs3K3skHPI5C8ZVxhZyCYVAa16vyRWZ/ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379271; c=relaxed/simple;
	bh=smrHCjS0lhHMzmYuBaUKg6EvwfHNRIvCFgnZSletBGs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TjoObVqFyjDMtEATBSvr3bUZsuHDtq2qxjFvxuPqQ6FtFFnRc9Ia6m/F6FyBRVccTpnADaZIFF6u2lD+MVBuxO/arKTQ0QTWI9OZ1ZIEnjp5ibzj4qaNr9LonshQPne/KPHg65/Vo87hLwRBPkq+i3xoko7kIUCin128Q5+zHWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=ljnSiiB8; arc=none smtp.client-ip=211.125.139.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1751379269; x=1782915269;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=1iIPpxIgmlkOMy8+JW+qYAUCVTUKOXEYoeF8gab8xO0=;
  b=ljnSiiB8b4MYMHC5/aq1LyxX87ho9c4OeTbU3hYsCYvPBMd0wbctpmx9
   WLFMz0laMUiehGhgXH0mm37CYPJjXbceRLyKGPyuyGJJwWgqJHmp2/Iog
   RCoSM5h9zxcWQuls2IdvkxbncY1kjCLG3Zf5giViD0HWcVBDcayds1p83
   +Z5Rn+TpTV1c+cQ+ZM5IX6IGG1pwUOOeDs/qS7K7UJCkXKwfFLEtYtXPl
   98oUDOHBjH46DLlziBpUYg40un41y0G8s85XM9kp7HQFP77TJkyVNTmQz
   OF8dwdMx67v0240QieKIWeJ2gbZYiZucYL7CJqaalZ+xG3Tp2GBuxPU9t
   Q==;
Received: from unknown (HELO jpmta-ob02-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::7])
  by jpms-ob01-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 23:14:22 +0900
X-IronPort-AV: E=Sophos;i="6.16,279,1744038000"; 
   d="scan'208";a="3310507"
Received: from unknown (HELO [127.0.1.1]) ([IPv6:2001:cf8:1:573:0:dddd:eb3e:119e])
  by jpmta-ob02-os7.noc.sony.co.jp with ESMTP; 01 Jul 2025 23:14:22 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
Subject: [PATCH 0/2] selftests/cgroup: better bound for cpu.max tests
Date: Tue, 01 Jul 2025 23:13:54 +0900
Message-Id: <20250701-kselftest-cgroup-fix-cpu-max-v1-0-049507ad6832@sony.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACLtY2gC/x3M2wpAQBCA4VfRXJtiymG9ilywBpPTtoOUvLvN5
 ddf/wPKXlihih7wfInKvgWkcQR2areRUfpgoISyhKjAWXkZDtYD7ej30+EgN1p34tremOV5agy
 VbEwHYeE8h/zv6+Z9P+oi6l9uAAAA
X-Change-ID: 20250227-kselftest-cgroup-fix-cpu-max-56619928e99b
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>, 
 Shashank Balaji <shashank.mahadasyam@sony.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=smrHCjS0lhHMzmYuBaUKg6EvwfHNRIvCFgnZSletBGs=;
 b=owGbwMvMwCV2mPH4Ij++H1mMp9WSGDKS31r+P5fo1cPIYmjOLu6z4LQDc+HHj1kHy5eU1nZ1r
 zFx2dHYUcrCIMbFICumyPJOZt2Fg1aWTV+PM3yDmcPKBDKEgYtTACbi0MLwv3aCd8fnicaha4PC
 v+0OOa3Uo6Bzy2iqROkiZgPunIWTChgZpjuUuEv4XDN0Orzm2oUfaSYFCnPkX5TWfTJg+/hnzbQ
 XvAA=
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=EE1CAED0C13A3982F5C700F6C301C7A24E0EF86A

cpu.max selftests (both the normal one and the nested one) test the
working of throttling by setting up cpu.max, running a cpu hog process
for a specified duration, and comparing usage_usec as reported by
cpu.stat with the duration of the cpu hog: they should be far enough.

Currently, this is done by using values_close, which has two problems:

1. Semantic: values_close is used with an error percentage of 95%, which
   one will not expect on seeing "values close". The intent it's
actually going for is "values far".

2. Accuracy: the tests can pass even if usage_usec is upto around double
   the expected amount. That's too high of a margin for usage_usec.

Overall, this patchset improves the readability and accuracy of the
cpu.max tests.

Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
Shashank Balaji (2):
      selftests/cgroup: rename `expected` to `duration` in cpu.max tests
      selftests/cgroup: better bound in cpu.max tests

 tools/testing/selftests/cgroup/test_cpu.c | 42 ++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 18 deletions(-)
---
base-commit: 66701750d5565c574af42bef0b789ce0203e3071
change-id: 20250227-kselftest-cgroup-fix-cpu-max-56619928e99b

Best regards,
-- 
Shashank Balaji <shashank.mahadasyam@sony.com>


