Return-Path: <linux-kselftest+bounces-24530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CDCA1141E
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 23:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3433A05AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 22:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9717213258;
	Tue, 14 Jan 2025 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="ebsIpuzu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D749314A609;
	Tue, 14 Jan 2025 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736893930; cv=none; b=YaJsp+MNSu4gaNVwTdztup17kip8vk/7vwWQHKii9qd2be4wT7dfJfPGgYHZFKQEItbDqcDtuYU0xtw04r/3ejCYlz2YgbELJDPCgzhJNwd/+DeVon6P0x7FZCqNRzHr9a/nefvKWbBFRCqidfIZx8jl7W+Frby0VvXbC9kLF+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736893930; c=relaxed/simple;
	bh=gCyW+qFefQLCZCdyZmgttG6Uv6bmyarn6x6WAQfoxvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mKo67g6+uEpUAXrJ3Y366FVxc//ZgTlAlbZdc7lk9smJD9lTvYRbz04EwEwvtxQtE/F2V7MBd2DXnWXMNUzagdXpAhlM8RWdmubO+m/8wE0cZahAinr2gakDOholLJFIV2K02wBqmOLTXlOaLN8uCPz9xKOtM3RC8ZDgi9spES8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=ebsIpuzu; arc=none smtp.client-ip=173.37.142.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2589; q=dns/txt; s=iport;
  t=1736893928; x=1738103528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XcR7ArXYthKmMKSfoAEeX8zvPOHz40yremfyEvSSaxI=;
  b=ebsIpuzuPTSvCpImrlwR0AHCi0XLBQ0CtiIKHByFMOSjlZux9WyaKprw
   7Iq4rB9zD08mY0bQ30pJ0lxsEGq0Wv7CoemeIzxGko9BNJbY85YLvLhMC
   2pf4US3PDUXdNcs1UlGl4s36vd+/1u7q1v2rC/4aUOlh0l+6YyHX5eHJJ
   Y=;
X-CSE-ConnectionGUID: Xb1zNljATBeV8b58vxbIGA==
X-CSE-MsgGUID: PEUK3YXyTYapVviauClCfg==
X-IPAS-Result: =?us-ascii?q?A0ANAADq5IZn/5T/Ja1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYF/BgEBAQsBgkp2WUNIjHJfpw2BJQNWDwEBAQ85CwQBAYUHAop0AiY0C?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4V7DYZbAgEDM?=
 =?us-ascii?q?gFGEFErKwcSgwEBgmQDEbMhgiyBAd4zgWcGgUgBhWqHX3CEdycbgUlEgRWDa?=
 =?us-ascii?q?IJhAgIBgiqFdwSDeYNuixSTZUiBIQNZLAFVEw0KCwcFgTo6AyILCwwLFBwVA?=
 =?us-ascii?q?hUeEAYQBG1EN4JGaUk3Ag0CNYIeJFiCK4RchEeEVYJHVIJHghR6gReEN0ADC?=
 =?us-ascii?q?xgNSBEsNwYOGwY+bgebOgE8g3J7FCuBEYE9LKUKoQOEJYFjijWVLhozqlMuh?=
 =?us-ascii?q?2SQaiKNYpZDhGaBZzyBWTMaCBsVgyJSGQ+OWYhWulUlMjwCBwsBAQMJkVMBA?=
 =?us-ascii?q?Q?=
IronPort-Data: A9a23:XDV7vaq/H/4amr0u0CnG9lwLdM9eBmIsZBIvgKrLsJaIsI4StFCzt
 garIBmDb/7bN2unfdtwYN63pBkCu5bcydNlTVdv+CAwRSMS8ePIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9T8kiPngqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYQXNNwJcaDpOtvra8U8355wehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0tZ9WHNo8
 f4xFBoAUECJ2rKo0LiaZcA506zPLOGzVG8ekmtrwTecCbMtRorOBvyTo9RZxzw3wMtJGJ4yZ
 eJANmEpN0uGOUASfA5LWPrSn8/w7pX7Wz9fqFSZrK46y2PS1wd2lrPqNbI5f/TWH5UKwhbD9
 juuE2LROjwnF4eu+Su5w3u0uPHOlD7QXKkcG+jtnhJtqBjJroAJMzUNWVWTr/68i0W+VswZL
 kF80jUvqaw/8UaDQd76UBm15nWDu3Y0WMdaGsU55RuLx66S5ByWbkAfTiNIaPQludUwSDhs0
 UWG9/vtBDpyoPiWRGib+7O8szy/I24WIHUEaCtCShEKi/HnoYcunlfMVdtnHrK4lcHdBz792
 XaJoTI4irFVitQEv5hX5njdiD6q45yMRQkv60COBySu7xhyY8iuYInABUXn0Mus5b2xFjGp1
 EXoUeDEhAzSJflhTBCwfdg=
IronPort-HdrOrdr: A9a23:/PRLEK9P1b3TepqSgeBuk+DfI+orL9Y04lQ7vn2ZhyY7TiX+rb
 HIoB11737JYVoqNU3I3OrwWpVoIkmskaKdn7NwAV7KZmCP0wGVxcNZnO7fKlbbdREWmNQw6U
 4ZSdkcNDU1ZmIK9PoTJ2KDYrAd/OU=
X-Talos-CUID: 9a23:pD6EjmO6Tr9Q+e5DaCM+5mgQGOkZWHDjnH2Nc1GoA0dGYejA
X-Talos-MUID: =?us-ascii?q?9a23=3AMJmhwAza31mIT1Wow2wKsiuxCb6aqJyDNWNWoKU?=
 =?us-ascii?q?Xh/iNLRJuOj6ApzCcTIByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,315,1728950400"; 
   d="scan'208";a="428748381"
Received: from rcdn-l-core-11.cisco.com ([173.37.255.148])
  by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 14 Jan 2025 22:32:02 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-11.cisco.com (Postfix) with ESMTP id 47E8718000253;
	Tue, 14 Jan 2025 22:32:02 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 220043FAB9C4; Tue, 14 Jan 2025 14:32:02 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: shuah@kernel.org,
	kuba@kernel.org,
	sdf@fomichev.me,
	willemb@google.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: John Daley <johndale@cisco.com>
Subject: [PATCH net-next 1/1] selftests: drv-net-hw: inject pp_alloc_fail errors in the right place
Date: Tue, 14 Jan 2025 14:31:59 -0800
Message-Id: <20250114223159.29677-2-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250114223159.29677-1-johndale@cisco.com>
References: <20250114223159.29677-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-11.cisco.com

The tool pp_alloc_fail.py tested error recovery by injecting errors
into the function page_pool_alloc_pages(). The page pool allocation
function page_pool_dev_alloc() does not end up calling
page_pool_alloc_pages(). page_pool_alloc_netmems() seems to be the
function that is called by all of the page pool alloc functions in
the API, so move error injection to that function instead.

Signed-off-by: John Daley <johndale@cisco.com>
---
 net/core/page_pool.c                                    | 2 +-
 tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 9733206d6406..a3de752c5178 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -595,13 +595,13 @@ netmem_ref page_pool_alloc_netmems(struct page_pool *pool, gfp_t gfp)
 	return netmem;
 }
 EXPORT_SYMBOL(page_pool_alloc_netmems);
+ALLOW_ERROR_INJECTION(page_pool_alloc_netmems, NULL);
 
 struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp)
 {
 	return netmem_to_page(page_pool_alloc_netmems(pool, gfp));
 }
 EXPORT_SYMBOL(page_pool_alloc_pages);
-ALLOW_ERROR_INJECTION(page_pool_alloc_pages, NULL);
 
 /* Calculate distance between two u32 values, valid if distance is below 2^(31)
  *  https://en.wikipedia.org/wiki/Serial_number_arithmetic#General_Solution
diff --git a/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py b/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
index 05b6fbb3fcdd..ad192fef3117 100755
--- a/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
+++ b/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
@@ -21,9 +21,9 @@ def _enable_pp_allocation_fail():
     if not os.path.exists("/sys/kernel/debug/fail_function"):
         raise KsftSkipEx("Kernel built without function error injection (or DebugFS)")
 
-    if not os.path.exists("/sys/kernel/debug/fail_function/page_pool_alloc_pages"):
+    if not os.path.exists("/sys/kernel/debug/fail_function/page_pool_alloc_netmems"):
         with open("/sys/kernel/debug/fail_function/inject", "w") as fp:
-            fp.write("page_pool_alloc_pages\n")
+            fp.write("page_pool_alloc_netmems\n")
 
     _write_fail_config({
         "verbose": 0,
@@ -37,7 +37,7 @@ def _disable_pp_allocation_fail():
     if not os.path.exists("/sys/kernel/debug/fail_function"):
         return
 
-    if os.path.exists("/sys/kernel/debug/fail_function/page_pool_alloc_pages"):
+    if os.path.exists("/sys/kernel/debug/fail_function/page_pool_alloc_netmems"):
         with open("/sys/kernel/debug/fail_function/inject", "w") as fp:
             fp.write("\n")
 
-- 
2.44.0


