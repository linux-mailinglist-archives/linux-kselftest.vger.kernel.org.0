Return-Path: <linux-kselftest+bounces-21457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CB79BCFA8
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 15:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055651C2240C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 14:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFD43BBF0;
	Tue,  5 Nov 2024 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b="OCUz+175"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender3-op-o18.zoho.com (sender3-op-o18.zoho.com [136.143.184.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C05BA42;
	Tue,  5 Nov 2024 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730817930; cv=pass; b=mVJSvq1q5UoIwMKj51jgFytTdMs2ulqFOJMo5Ccy9Lo+Ux/zE8u24NIAQ+W7AfchgeyAvw98/GmdxPmOnWDSAy3LSEJePvrvii4z48VE17Q4rMrB1nGOvOJuEMvrQzuewNE0yFRy9U34t4cp/KAsxBoCawKAPlUsl4/k9NwzIG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730817930; c=relaxed/simple;
	bh=gzKWcucrWTtlRZyqO+yYtSNsJhTFLTP054aizZjuVlM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aNmKGo4Jygoega8FDBiWa3CsLiO4FNwVh5v68z6kFeBnVutcR23tT4l1XqOVSCOGP6Xyk0vntM7VxPQwwKE45uxGIXPpJ1LBK+x9zMMDNheKRvSePYqqj6IzQDP861h/WteOeEhVfbzFsJcjtnFfxHu5cQWgf8D3w0EXG1fNUic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b=OCUz+175; arc=pass smtp.client-ip=136.143.184.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730817924; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gvdXt5wrS1uCQYPC/18Opn1pvfm00jB4UgTrLVMVSsmMnbHkGQuKmMPpr2CFnREba6o2J9YOi/58ypXBfekdVX72ulWJiaVus4bmwE+sud9gcs2mjwrkSrmPtK27Cf6wIF5ROkZrWcDK1r0bN4Hp4L1JLK7baVuQDNKSXnyT6JI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730817924; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7xTugTmdId5LpmBx04SJn8CH/YaZvqgaoOxAHK2vlKQ=; 
	b=nkYmlp8wRhzk627dbIDJ6r/leVlbDN6+eYLdOSmZHmvnFIKyFYsOW5HjHjcjagIK7A22AYEFqrXOW7oYeWPu2Bd237b6+5beN+2WBToJFDZ0w97OUhy4JMlmTLP+5sb6ErOfDXUur+Rrfn2hSseXa/CXlxpqjfJ1TXmVkm8hkyc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=laura.nao@collabora.com;
	dmarc=pass header.from=<laura.nao@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730817924;
	s=zohomail; d=collabora.com; i=laura.nao@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=7xTugTmdId5LpmBx04SJn8CH/YaZvqgaoOxAHK2vlKQ=;
	b=OCUz+175pMVdkqcSc/Z5e5WoQt20LkrsrKUV8jLIzCa+r+ML6LVC4LU9RnvZ5GWW
	tbI/LP7/PcC6jI0XlPZHAe2qHYCg4cdSQPZq3v5qrdw8Vt8n/jNUFAw9WtyYbKLZSnW
	IsXMA7Vz1aCony3AWxo64dfQC4icoWjPNDMmdJn4=
Received: by mx.zohomail.com with SMTPS id 1730817921788987.9649850875669;
	Tue, 5 Nov 2024 06:45:21 -0800 (PST)
From: Laura Nao <laura.nao@collabora.com>
To: kernelci@lists.linux.dev
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Testing Quality Call notes - 2024-10-31
Date: Tue,  5 Nov 2024 15:45:55 +0100
Message-Id: <20241105144555.245561-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hello,

KernelCI is hosting a bi-weekly call on Thursday to discuss improvements
to existing upstream tests, the development of new tests to increase 
kernel testing coverage, and the enablement of these tests in KernelCI. 
In recent months, we at Collabora have focused on various kernel areas,
assessing the tests already available upstream and contributing patches 
to make them easily runnable in CIs.

Below is a list of the tests we've been working on and their latest
status updates, as discussed in the last meeting held on 2024-10-31:

*Boot time test*

- Sent v2:
  https://lore.kernel.org/all/20241018101439.20849-1-laura.nao@collabora.com/
- Changes in v2 driven by feedback received in the LPC session

*ACPI probe kselftest*

- RFCv2:
  https://lore.kernel.org/all/20240308144933.337107-1-laura.nao@collabora.com/
- Related upstream discussion on probe status tracking through printks:
  https://lore.kernel.org/lkml/dc7af563-530d-4e1f-bcbb-90bcfc2fe11a@stanley.mountain/

Please reply to this thread if you'd like to join the call or discuss
any of the topics further. We look forward to collaborating with the
community to improve upstream tests and expand coverage to more areas of 
interest within the kernel.

Best regards,

Laura Nao

