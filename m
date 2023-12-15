Return-Path: <linux-kselftest+bounces-2069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B672B814B7B
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539471F239FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E88B3A8F1;
	Fri, 15 Dec 2023 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1bagiSq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6767D3FE44
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702653224; x=1734189224;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UXAqKDnLJZFCXaf2Fb2e7GjEWeMKLKBSsFBT7sI4xhE=;
  b=n1bagiSq7PM6tiZNtLD9+amh3T/xPGNBPkhng3HLpsbuHVe4Jcn3jiMP
   7ica/7T71VzvLejPctgA7ZnJoisy2+j55z6ZRMhb1WIwXwAoeCSg945NM
   2jwPd8D6a+bjd5m/ogfkgoytt9SvfzLRE6XPQJqZwhWXQt+y1+uUuLiNr
   nUCsGmnI2tk1zpFlf5eYdyvvlm+COjGxxvZkxJsOhp9JeS9X0yMgbt6n6
   LmVfNiLoTMpfTq5znENdcEQQbfKxrkdsbd+YeekUdREbf/A7zb16sw9GG
   5FbdMKyE9ief0kraIMTGjnK1HLkdKWez5SBQwX2MENdMPl1mBKKhKaf9f
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="8645414"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="8645414"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:13:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="840692227"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="840692227"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.144.211])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:13:41 -0800
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>
Subject: [PATCH 0/2] kunit: Reset test->priv after each param iteration
Date: Fri, 15 Dec 2023 16:13:25 +0100
Message-Id: <20231215151327.1835-1-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we run parameterized test that uses test->priv to prepare some
custom data, then value of test->priv will leak to the next param
iteration and may be unexpected.

Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>

Michal Wajdeczko (2):
  kunit: Add example for using test->priv
  kunit: Reset test->priv after each param iteration

 lib/kunit/kunit-example-test.c | 15 +++++++++++++++
 lib/kunit/test.c               |  1 +
 2 files changed, 16 insertions(+)

-- 
2.25.1


