Return-Path: <linux-kselftest+bounces-34363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CBAACEDC4
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 12:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FF367A28B7
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 10:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594EF2165EC;
	Thu,  5 Jun 2025 10:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uv+MQfO1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41AB2040B6
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Jun 2025 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749119824; cv=none; b=cQUaiLsx7h5k6D5dIKul4YCm5kN7eRdp9jiGwPimaYptQm/jHHqUrmy8FKkuwDD+iUmKfpV1eSXeVL22JReTRLn5ZWGp+b8W4Pvw74jlHhG/Xf2ycJpIsetgkot0z6GnDCW6Lge7O+rb9goCdFs2dqORDoHK8NPa7L4UdsLsf+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749119824; c=relaxed/simple;
	bh=VzQyPkruYWrDZAOkmL/UT3N0xShjKnGR9pQJo0jQ/Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHxHaQsOWrsQGWNdDLRKZVnk6pbD1H1s/JYYDvhj6Pw3DQnsO2T2xWsikP2IHw4caUERlkyA+i4+kb1EIzXZMRWnAlgtIiSvxO0mRggOptGWOH1cBfcs8/4UGwMb1RBCd4GnYH6CTbv5V3KWXSfzSMSRgHiZhRierG58SqTj/tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uv+MQfO1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749119821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AdRsO2Uefrz8JMO751IFZEkS7KH/EcFqwNDUBdHYAOY=;
	b=Uv+MQfO1hJLdRNQc5RbCrFffkuT6VY62Vo/TMGCOFJBu0/GjkqEW5QL6claC+JfbUOsf8Y
	nK7N1LkCM9uXRz3UebFePpBymKvfdK/0YoDeNURLvddI7vNiSLGg+F0Hn5Vwzm2e2oS5F1
	G/8W2MBbfvmnsBtZu/UsvD8WFxZPzsk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-4pYT4vHhOsu4DCkDHKTbFg-1; Thu, 05 Jun 2025 06:37:00 -0400
X-MC-Unique: 4pYT4vHhOsu4DCkDHKTbFg-1
X-Mimecast-MFC-AGG-ID: 4pYT4vHhOsu4DCkDHKTbFg_1749119819
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4ee113461so312442f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Jun 2025 03:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749119819; x=1749724619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdRsO2Uefrz8JMO751IFZEkS7KH/EcFqwNDUBdHYAOY=;
        b=cmCoNZa1k47quklYkeHnAul/De38aMT7f/dv//OdHHsS4FkID2ESXOmP6LR0FKVcyT
         ScllOXdSEkGuDcBTolTWRXPg4WjH1ArZHZTZ5eam/+cuI+vQeo/wf1jvUNEHziYV/ABP
         U0T2kCi/hzzXFew65di2fOSF+6dSnF7XS7BsaPTP4jgcWpIvLIkNXMnnwcNk3UxaRBWX
         WQ23c/ti98trept+zB99R1KFtN6QpVbPrOvn5GhoFrIiOsgv3EqazB/pFMRvzmbWlred
         HY6c8fdb6kRwmpRts3YKsd0Bl5PuwmuSULknY2NjhubKp5tO90aPwf6Iv42N1ypnTGS4
         VIug==
X-Forwarded-Encrypted: i=1; AJvYcCW0681k3CuuXrTzALX86n3PsouRpr/KmHSRhJxsyevNUNCbVm4vWEs2nz+Tnz2zECYILjsbVfaxmRV6RQOs7Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2St+X5OAtEL1JxHdupA7Px+XB+my42uZ5v0F4W25i39nNms6W
	+igPGv51wfmSiCFnYRPb6pHKK/hsRkRcNhnpCN1c/OAg6jUIxssZN+DUh8edXgeUIiXFCQ7C6vO
	KaRJMBkyDbLOXXC8IXGWr0U5dbM34goi89EZ5FJV5R8b/R3qDAdkyendEvDjIDrmAXBxBhg==
X-Gm-Gg: ASbGncsvSZREBN7BRuMgTsITbf3sRfaUJ1uPTll6x4P4vxREPJ32Dxrvbib5+kzYhUY
	mcK4OXql6ok1gp2nfwp85aYqYlFw4YIOerugOaTaVyeJuOS+sQSc+fwsWjWp4n14PgS60aQhL+t
	eiHwkrBaqtmargg2E7E6GT8P9Cv8JGMNdzwgBE0ZmIPB79ki11g8aj4L0EQWX2rouBlDXgRJN4m
	1K5KZ9M12xfxBh0g2gVQia2C/BtTUrRydFXSay18RbYCq8Dm4nZBb8UXAxVHT1lF0A5iYo1bXOF
	fH52lzavJvy65HAlWuKMyN0xSl7mOc2wqJu0kx/n/crw+s36NV68dOkZTWzLWxouDCIYZta3dQ=
	=
X-Received: by 2002:a05:6000:144e:b0:3a3:ec58:ebf2 with SMTP id ffacd0b85a97d-3a51d8f6a68mr5594165f8f.7.1749119819364;
        Thu, 05 Jun 2025 03:36:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRjZpPO2+0jMcuZP9CR9nsUnOUJ7V0YuUBqF23a88OV3aPhw4HnJ7EZRrzi+l8ZxUNJutO1Q==
X-Received: by 2002:a05:6000:144e:b0:3a3:ec58:ebf2 with SMTP id ffacd0b85a97d-3a51d8f6a68mr5594137f8f.7.1749119819002;
        Thu, 05 Jun 2025 03:36:59 -0700 (PDT)
Received: from rh.fritz.box (p200300f6af1bce00e6fe5f11c0a7f4a1.dip0.t-ipconnect.de. [2003:f6:af1b:ce00:e6fe:5f11:c0a7:f4a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f8311ae6sm14105175e9.2.2025.06.05.03.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 03:36:58 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Cc: Colton Lewis <coltonlewis@google.com>,
	Ricardo Koller <ricarkol@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v3 1/4] KVM: arm64: selftests: fix help text for arch_timer_edge_cases
Date: Thu,  5 Jun 2025 12:36:10 +0200
Message-ID: <20250605103613.14544-2-sebott@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605103613.14544-1-sebott@redhat.com>
References: <20250605103613.14544-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the help text for arch_timer_edge_cases to show the correct
option for setting the wait time.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
index a36a7e2db434..c4716e0c1438 100644
--- a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
+++ b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
@@ -986,7 +986,7 @@ static void test_print_help(char *name)
 	pr_info("\t-b: Test both physical and virtual timers (default: true)\n");
 	pr_info("\t-l: Delta (in ms) used for long wait time test (default: %u)\n",
 	     LONG_WAIT_TEST_MS);
-	pr_info("\t-l: Delta (in ms) used for wait times (default: %u)\n",
+	pr_info("\t-w: Delta (in ms) used for wait times (default: %u)\n",
 		WAIT_TEST_MS);
 	pr_info("\t-p: Test physical timer (default: true)\n");
 	pr_info("\t-v: Test virtual timer (default: true)\n");
-- 
2.49.0


