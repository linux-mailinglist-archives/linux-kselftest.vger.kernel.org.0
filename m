Return-Path: <linux-kselftest+bounces-22491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D93D9D6FA0
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 14:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C892161F4F
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 13:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196141F709A;
	Sun, 24 Nov 2024 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bad/w3Bx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12EF1F7094;
	Sun, 24 Nov 2024 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452751; cv=none; b=TjIoNALpSDeUJO9fcZPJCM5YE4G9h2MDJtgjkbfPkcYfvCkKGbgC1F6QSiJ4Mrg0LbYbR08bfuT8QA/YudtGOSLERTFzeGgrtSc3W/ocUUj2j6r+rWY+xShE7AegBcrnzxuD0VGLSsWeAi3dQ90RirvTUnzAOZPE9wilg42B80k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452751; c=relaxed/simple;
	bh=kCm1YCI6V48RKknhFTwB8m8Gp1l72xVFaMsZCoH7Bus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cxAN2A/LjpaZtdBrGDzzmidO9ymRBr0OIVT01Ph+wgSRyGINeQovodwy3Nqajyu510IFf1b+MVqKLtVPsZvFYHV2YBb/HU+TtoaIqdI/75MairnXRTO/unx3n46H923zrGVySNAjIKe34InHLeelfjQjCe+bQguvgokGdS8hPP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bad/w3Bx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A70C4CED3;
	Sun, 24 Nov 2024 12:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452750;
	bh=kCm1YCI6V48RKknhFTwB8m8Gp1l72xVFaMsZCoH7Bus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bad/w3Bxr0tTJ6iwTIe1f2iAB5K3uOJOM2cDYzp8SSnhKjVJJBpheEv7V7lk3JQ8/
	 M/wvudGgr01AX03eA5ZEW4Cg1pXzN34/7hgntQ11bsfYhxvjNNb5oLoV7esE9pTNNF
	 iqljnXA8pbbbJ4yd0GzA6oSx6hs+sLSH6auTgQhI4ZBjkFviZ0td0CzmEQbsoqmYPm
	 xB0t9Kebh1sPSFWtUTcgOLmRzCzWwEmgPR9ChsHYg7Tnj9+jAB8laSaA5VZatiLkiX
	 mkpT70xcR04pC6wrtmKc1lnw5nalbtS/ZcvQ/pcHfW2JBGFQI90psAheGYZo/YOieG
	 2HwsXQ1uRaHhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	fenghua.yu@intel.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 18/20] selftests/resctrl: Protect against array overflow when reading strings
Date: Sun, 24 Nov 2024 07:50:48 -0500
Message-ID: <20241124125124.3339648-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124125124.3339648-1-sashal@kernel.org>
References: <20241124125124.3339648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Reinette Chatre <reinette.chatre@intel.com>

[ Upstream commit 46058430fc5d39c114f7e1b9c6ff14c9f41bd531 ]

resctrl selftests discover system properties via a variety of sysfs files.
The MBM and MBA tests need to discover the event and umask with which to
configure the performance event used to measure read memory bandwidth.
This is done by parsing the contents of
/sys/bus/event_source/devices/uncore_imc_<imc instance>/events/cas_count_read
Similarly, the resctrl selftests discover the cache size via
/sys/bus/cpu/devices/cpu<id>/cache/index<index>/size.

Take care to do bounds checking when using fscanf() to read the
contents of files into a string buffer because by default fscanf() assumes
arbitrarily long strings. If the file contains more bytes than the array
can accommodate then an overflow will occur.

Provide a maximum field width to the conversion specifier to protect
against array overflow. The maximum is one less than the array size because
string input stores a terminating null byte that is not covered by the
maximum field width.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 4 ++--
 tools/testing/selftests/resctrl/resctrlfs.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 8c275f6b4dd77..1bba85e4c0675 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -160,7 +160,7 @@ static int read_from_imc_dir(char *imc_dir, int count)
 
 		return -1;
 	}
-	if (fscanf(fp, "%s", cas_count_cfg) <= 0) {
+	if (fscanf(fp, "%1023s", cas_count_cfg) <= 0) {
 		ksft_perror("Could not get iMC cas count read");
 		fclose(fp);
 
@@ -178,7 +178,7 @@ static int read_from_imc_dir(char *imc_dir, int count)
 
 		return -1;
 	}
-	if  (fscanf(fp, "%s", cas_count_cfg) <= 0) {
+	if  (fscanf(fp, "%1023s", cas_count_cfg) <= 0) {
 		ksft_perror("Could not get iMC cas count write");
 		fclose(fp);
 
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 250c320349a78..a53cd1cb6e0c6 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -182,7 +182,7 @@ int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size
 
 		return -1;
 	}
-	if (fscanf(fp, "%s", cache_str) <= 0) {
+	if (fscanf(fp, "%63s", cache_str) <= 0) {
 		ksft_perror("Could not get cache_size");
 		fclose(fp);
 
-- 
2.43.0


