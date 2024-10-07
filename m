Return-Path: <linux-kselftest+bounces-19144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F9499284E
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 11:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E321F2378D
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 09:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5D318F2F2;
	Mon,  7 Oct 2024 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b="fBi7Vgk7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90011433CA;
	Mon,  7 Oct 2024 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728294061; cv=pass; b=kDoFFi+4BJFCjktM0Ah8tCHHGi7/81AS8SSlhpUlym2sjGg7upfqlKjbzN68vlguANKMlFABJZziRduN7JmzgiNBstuIYtGk4ArxJ2LO+F/TwzlIEqqm4vQVtKVr5BnC+WdOaD+rOAhQwL3Zy/wfG6DFo+HWWQOCvmUNDdThE7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728294061; c=relaxed/simple;
	bh=SwdsTsngSuvz6QeG10QNqbVsW20XU1qVdprd/BgSiQs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TWTzbnyu2AOAMPixMMUpYvPHm8OPf9AkpyCYmJN1XIC3mm4h2wczvFwWKaDoCYEHLYwXGVlQlyvLUxA2nH+lZQa4u4Eee6+xH7SanBC+OyvuMCbBtMyIdB5KT4L3O7HXsT6lq+by3s8tG0tGzyoBnGTHog1FdBcg7EFXE/b3fSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b=fBi7Vgk7; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1728294056; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EFbzVR2KiLoMfc/GCa0cflXGvkw3jIX1UVVIt/1csc5jbZbWEvR4kdZ8YD2qZSda2W/DUShJaYiPdxIVt88aOX6QwzPKgTs5q4U2Kf27jTUUf6+lcNP7iZiEAw5yqsrfuIS06NBWOuctVfYDWcvKeo80g37OSwFeXwqHBNEb7NE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728294056; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ia7bVofVVswAbaGXu/q9y8haQ9Yf6IOtNOhLDyMshXg=; 
	b=FalYJF19k1uNVTGIbMM53fFa0LIClMcBmBemf3Om2VHAQc/cCkaBQPvN/hl7UcavTUnwt6pgZgqKt4tNvHTrOhCZOYBC7wJhN5RMvULV2ahyBwKlWo3BvByn+kBuRyoiNFaCCIidMafCYXmvrV4mdjQA+48NOwp5djd1a7aBEkE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=laura.nao@collabora.com;
	dmarc=pass header.from=<laura.nao@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728294056;
	s=zohomail; d=collabora.com; i=laura.nao@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=ia7bVofVVswAbaGXu/q9y8haQ9Yf6IOtNOhLDyMshXg=;
	b=fBi7Vgk7f/dMR0kEeVBccvi2f61NT6DN0pslF4YZdoyjSco7o5SmmpTdH75lp90C
	4AQDgztxcs/vrCDqwIPOW4j1PXV3p1RKghqGzkP3BR++rLK/UBlb71EovbJxpqCFNmr
	wPPGZesOf9O9fKt/tPFsR9TSr6uAR9VtVKl82ero=
Received: by mx.zohomail.com with SMTPS id 1728294054769331.59808967692425;
	Mon, 7 Oct 2024 02:40:54 -0700 (PDT)
From: Laura Nao <laura.nao@collabora.com>
To: kernelci@lists.linux.dev
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Testing Quality Call notes - 2024-11-03
Date: Mon,  7 Oct 2024 11:41:22 +0200
Message-Id: <20241007094122.22023-1-laura.nao@collabora.com>
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

Below is a list of the tests the community has been working on and their 
latest status updates, as discussed in the last meeting held on 
2024-11-03:

*Missing devices kselftest*

- Proposing new kselftest to report devices that go missing in the system
(v2):
https://lore.kernel.org/all/20240928-kselftest-dev-exist-v2-1-fab07de6b80b@collabora.com/
- Sent v2 addressing feedback received on the RFCv1 and during the session
at LPC 2024:
https://www.youtube.com/live/kcr8NXEbzcg?si=QWBvJAOjj7tg264o&t=11283

*Boot time test*

- RFC:
https://lore.kernel.org/all/20240725110622.96301-1-laura.nao@collabora.com/T/#ma568382acdc81af65c30fe3823a7be3e49f98108
- Discussed proposal at LPC2024:
https://www.youtube.com/live/8XQwzUZxLK4?feature=shared&t=16944 
- Planning on preparing v2, based on feedback received in the session 
- Suggestions for improvements and additional features include: exploring 
bootloader tracing via pre-filled ftrace buffers, adding support for 
specifying variance values on a per-event basis, investigating the use of 
ftrace histograms for initcalls

*Device testing documentation*

- Patch:
https://lore.kernel.org/all/20241001-kselftest-device-docs-v1-1-be28b70dd855@collabora.com/
- Submitted documentation on device testing, detailing the types of
kselftests available, their requirements, and the coverage they provide.
The goal is to guide users in selecting the appropriate tests for their
devices.

*GPIO test*

- RFC:
https://lore.kernel.org/all/20240909-kselftest-gpio-set-get-config-v1-0-16a065afc3c1@collabora.com/
- Proposed a new kselftest to verify the GPIO driver functionality. The
test uses a YAML-based test plan that specifies the configurations to be
checked. It sets each pin configuration and retrieves it to ensure they
match. Currently, the test only verifies bias settings, but it can be
easily extended to cover additional pin configurations.

Please reply to this thread if you'd like to join the call or discuss any
of the topics further. We look forward to collaborating with the community
to improve upstream tests and expand coverage to more areas of interest
within the kernel.

Best regards,

Laura Nao


