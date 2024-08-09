Return-Path: <linux-kselftest+bounces-15054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB65894CAFF
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 09:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B23D2837E8
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 07:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D456516DEDF;
	Fri,  9 Aug 2024 07:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="YcdXjzgq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C03816DEBB;
	Fri,  9 Aug 2024 07:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723187491; cv=pass; b=eYdvfA9QJMbjJc6woH6Xv5BJSE8n674tcr1ygA4ZmNH9EiIL2MRguDCpF8GXLmamiv9eUM1CbtSKKVjt3zzgsOjXiqV7xvGnNL9MAlGWhIxP2Ghum1bhCDM8l8EMK04cGrDj8yrrG2jkuoL88CNonpBHHS4fM/tWKXJUJWUijw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723187491; c=relaxed/simple;
	bh=y0ZyEDpNPRRdbuo8OIi/VE3ngUppSXuwJWr795c8Ow4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gHBRRA06CL5cXsqeEncAa54VWiHVpI82MLcoLrDeG7kf0RefkLP5Fb2Yp/YxSqLPJlKf3uS1+DNMnHiPA1DHCr7jO6nBEEQmuQhncmKIT0ttIftZvGZ/JG5aA5UKAs34GRs6TbwojaGDbhu9/atvZltXzP81wiETg5CE8RMiKDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=YcdXjzgq; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: usama.anjum@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723187479; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BCMhhO6O5HdH+og20V5NZ2FumgNV6vt19vFyvnXHhDQjwKrduqp5GPIWtosCMYdRQwL/HBNCl/Dz2SBCQXHU1syMqjEMP7DFjX5DWq3uq/gEf/TUcC8gq5x9QtxoZZn4WFeOjsrG/sqfUXcpVOzfWhxils6g3SVZzB/4az5/PI4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723187479; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uI4S8dyVnBEmc+33e5+h6frA0QYL5QggDkHKepLnb0E=; 
	b=htnpD8fWx93malHUyGUuucp1xrHe89od/nCgH4Yg8Dsqzd/r/Pn7JyCFQ+kBibmTdYclZUshaNveSMlii147UL/WatRScNa1/EWBRSA8EJgtcB4MJpMEnvkyc7A1awxbKKjFBXhkuSSsD+UNAgcIlvzp24FkEyZuKSeEA2RFhUE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723187479;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=uI4S8dyVnBEmc+33e5+h6frA0QYL5QggDkHKepLnb0E=;
	b=YcdXjzgqvo/4kjblktVYj8V53rfoG3hSP7IWyMCvr+Ew5QntXmX9poyEegb+AcaZ
	rcS4Q0vweInyomarg209rq8StFppZhcwJB/gqSRagK3stt/xqqDb27f9k2BwbwMlbXf
	GO4luB9VVSY72eM+OA/QoKT4SpIrytUZHaYGqHRE=
Received: by mx.zohomail.com with SMTPS id 1723187477448306.3660416071243;
	Fri, 9 Aug 2024 00:11:17 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: resctrl: ignore builds for unsupported architectures
Date: Fri,  9 Aug 2024 12:10:59 +0500
Message-Id: <20240809071059.265914-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This test doesn't have support for other architectures. Altough resctrl
is supported on x86 and ARM, but arch_supports_noncont_cat() shows that
only x86 for AMD and Intel are supported by the test. We get build
errors when built for ARM and ARM64.

Hence add support in the Makefile to build this suite only for x86 and
x86_64 architectures.

Fixes: b733143cc455 ("selftests/resctrl: Make resctrl_tests run using kselftest framework")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/resctrl/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index f408bd6bfc3d4..d5cf96315ef9b 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -3,7 +3,9 @@
 CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
 CFLAGS += $(KHDR_INCLUDES)
 
+ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
 TEST_GEN_PROGS := resctrl_tests
+endif
 
 LOCAL_HDRS += $(wildcard *.h)
 
-- 
2.39.2


