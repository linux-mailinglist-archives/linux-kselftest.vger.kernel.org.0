Return-Path: <linux-kselftest+bounces-6448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 906F3880CE2
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 09:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8200B21B4F
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 08:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28742E62E;
	Wed, 20 Mar 2024 08:18:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415BB2DF7D;
	Wed, 20 Mar 2024 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710922694; cv=none; b=nTftO7V3ZBKI36QVXvEGYTHk3eZKCPpX/UdSzxuJllt9ePBQpDKGklgwp7481d7HuSikCthSoD3hL/u6x6m5E0xT9N63mjCHiF6a8I7YTGLbEKKHWyaR28ObCJ5Rk2IALJWw2FuJBUloim/T3RQaBJC7ndYAfPrUY23DrqRizks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710922694; c=relaxed/simple;
	bh=60sKjZFMDkIGBZ34PBAlSHbXPnG2diZASmVrBzUBnok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NvsK+x7n3Llla4xM6zMmvLz9pjBx+LW8Z+cIvt+E0CcrBap2cWTw9TfxCBW/VgRBVysNb55ZVvUOj+8tyEiIPG3SN1FStM2RVxyhnrlkBBu7GpTXgM/m6Lep6j91AjpecglGg+Dmtn/nMs4HZU+nh42tJRqJb9dLw/2eSVcUq2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V01gH1LT4z4f3kK1;
	Wed, 20 Mar 2024 16:18:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 1085A1A0172;
	Wed, 20 Mar 2024 16:18:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP3 (Coremail) with SMTP id _Ch0CgDnpZ29m_plVnGcHQ--.12753S2;
	Wed, 20 Mar 2024 16:18:06 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com,
	corbet@lwn.net
Cc: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: kunit: correct KUNIT_VERY_SLOW to KUNIT_SPEED_VERY_SLOW
Date: Thu, 21 Mar 2024 01:14:24 +0800
Message-Id: <20240320171424.6536-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDnpZ29m_plVnGcHQ--.12753S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jry5Zry3XFyDtr4kArWxCrg_yoWDtFXEva
	4rZFn3CFW3tr9aqr4jyF1SyFn3GFW8Cr48Wr4DKF98Cr1SyasrKFyDJ3sF9r1Uur1S9a4f
	tan7ur1jvwn7AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb28YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
	AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq
	3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gc
	CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
	r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
	Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jIGQDUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

There is no KUNIT_VERY_SLOW, I guess we mean KUNIT_SPEED_VERY_SLOW.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 Documentation/dev-tools/kunit/running_tips.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
index bd689db6fdd2..482f598d141c 100644
--- a/Documentation/dev-tools/kunit/running_tips.rst
+++ b/Documentation/dev-tools/kunit/running_tips.rst
@@ -294,7 +294,7 @@ macro to define the test case instead of ``KUNIT_CASE(test_name)``.
 .. code-block:: c
 
 	static const struct kunit_attributes example_attr = {
-		.speed = KUNIT_VERY_SLOW,
+		.speed = KUNIT_SPEED_VERY_SLOW,
 	};
 
 	static struct kunit_case example_test_cases[] = {
@@ -311,7 +311,7 @@ suite definition.
 .. code-block:: c
 
 	static const struct kunit_attributes example_attr = {
-		.speed = KUNIT_VERY_SLOW,
+		.speed = KUNIT_SPEED_VERY_SLOW,
 	};
 
 	static struct kunit_suite example_test_suite = {
-- 
2.30.0


