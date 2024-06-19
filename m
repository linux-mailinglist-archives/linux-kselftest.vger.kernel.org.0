Return-Path: <linux-kselftest+bounces-12212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ECC90E345
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 08:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F164C2824B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 06:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ADF6F2FE;
	Wed, 19 Jun 2024 06:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Wlw7pjbC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C713073455
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718777877; cv=none; b=IMa2STH/RTHlfD4PlKLAs7cC73DH/Yz1ZVSUe8138TWvyv/5zHAuBX8hijedDfT5w+4krZYP4nak2+pKrkhuWuR6lNIHXrTHs9q4xRpzvBRvL0A1YkFcC1fozqsn2+99LUNbRmGhzL0kcEJ4sjcjag87jI19TsW4ev97W4tsVkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718777877; c=relaxed/simple;
	bh=9JxSuB2e5zHpPnsceJPM2Z4u5/cle2vjrbTlQxjKR8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hzEObybfvWNbktf2QQGm9U/+k3nv7uIm127kj9ih0iMDVppYiNQAXfvg8VRs2EX57Iz4W+SrSw/pNTlgy6r7uEW1+X1hYMcVEnPCYxNahj8pbXLYoh3LknEp7OsO0ew+2Cxapxq3HLD6Fy7EbQbbEkg/mNKmjeZ3MJZK5Ft22gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Wlw7pjbC; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3627ef1fc07so974226f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 23:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718777873; x=1719382673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q9tHSYcUn51SyAd1faMtIy/AKsEtmmYSS3K41DfIPoQ=;
        b=Wlw7pjbC25lg0bmVjKrA8SBtXNXkYcR0krkBWzmfTv1qDTeciFtKglhRg9ZW6DOquY
         IS16qPH3ZNEtw/T0FKSym+tQ3OY46h9wORjSkwVI53I0c6/2KinyMXqnlr+iRhKTpI9S
         lWCQzxMPOs55SHx0odIu5fn0tfoeIxsNC62JKQE4qpo5Bl1rawxweg94K2sUxr5way2r
         eUOKVAASeF8Hg5cVygTgz26nokM5ph65EDnafqqe98GPUAr/Ppldak/8RtsoU+CX9Gea
         Q94nbAOfEk4XcJ6IvHPMk4MLzYh4i4nTdzo30m0ctGQnc6B4NmwPwOdq7o4aQjK3juWU
         6HBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718777873; x=1719382673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9tHSYcUn51SyAd1faMtIy/AKsEtmmYSS3K41DfIPoQ=;
        b=AI/zWK3LnsBfmx0onKh5iK3Df/xaHrvr8DzvIkq89MvBzXsXOjzpNWSzQ5JfyvRpLx
         4zvkeXulmuwMtIZOlal4oax+JF8Px7IFrqtooA/77s/Dg8IzG6onHKg/BTdvoJShNEAu
         dZ9rUzsX5sK8H2pUI8ZgQoP7Rq17WpI/Du8cbum4QX4WHjTirzdNSjVBVPCjuNu7OZwt
         Ky2LkG9O2rk5i4kRmFenZ9p3IuF1x8sj10lbqfg7ajZxWPqbX5ZV48WxpD2LxJgIRgsk
         Q1Vz53uN4n6CwGNzlY0D2KP90kJBhX2yhJPmJO18/ZsX9nGyIPtDDeH3L0i9UtNwMjl0
         G2Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUrWC27jh6l6FETSMta6em4QRNW3oMRqzwSjRie5Wo759iLWGhyyvL5bqjpJaIrcJ/qAO7HfKEk3G4IN2WISvVvFvbd81r5u/jK/XAg7sGX
X-Gm-Message-State: AOJu0Yyxks4kBwwqEXIhJo5ShcZBpWhqdEWeiHcdbuOZExkNDGMoPDTc
	RiPcTFdO/mYh/L3W56SnglsN3+xUnsqLMpcJSsJSVJAU8gXUhfky31DEaWfTkgFy/mQG4qLx/GO
	6WE+2og==
X-Google-Smtp-Source: AGHT+IEdGqwuPmkL1V/kYBiEFfGbh6LP5DzFOB/llA59skIBzGQ4ntMUTADfLf03eLYt7oZOFgktEg==
X-Received: by 2002:a5d:51ce:0:b0:362:f853:603c with SMTP id ffacd0b85a97d-36317c77507mr1035090f8f.32.1718777872719;
        Tue, 18 Jun 2024 23:17:52 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3608fb0b145sm9878962f8f.102.2024.06.18.23.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 23:17:52 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	matttbe@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH net] selftests: virtio_net: add forgotten config options
Date: Wed, 19 Jun 2024 08:17:48 +0200
Message-ID: <20240619061748.1869404-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

One may use tools/testing/selftests/drivers/net/virtio_net/config
for example for vng build command like this one:
$ vng -v -b -f tools/testing/selftests/drivers/net/virtio_net/config

In that case, the needed kernel config options are not turned on.
Add the missed kernel config options.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20240617072614.75fe79e7@kernel.org/
Reported-by: Matthieu Baerts <matttbe@kernel.org>
Closes: https://lore.kernel.org/netdev/1a63f209-b1d4-4809-bc30-295a5cafa296@kernel.org/
Fixes: ccfaed04db5e ("selftests: virtio_net: add initial tests")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/testing/selftests/drivers/net/virtio_net/config | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/virtio_net/config b/tools/testing/selftests/drivers/net/virtio_net/config
index f35de0542b60..040b600d52f1 100644
--- a/tools/testing/selftests/drivers/net/virtio_net/config
+++ b/tools/testing/selftests/drivers/net/virtio_net/config
@@ -1,2 +1,8 @@
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_DEBUG=y
+CONFIG_NET_L3_MASTER_DEV=y
+CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_NET_VRF=m
+CONFIG_BPF_SYSCALL=y
+CONFIG_CGROUP_BPF=y
+CONFIG_IPV6=y
-- 
2.45.1


