Return-Path: <linux-kselftest+bounces-5482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A2B8690E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 13:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F4016286E63
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 12:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC9513A892;
	Tue, 27 Feb 2024 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVin+zwF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885291EB25;
	Tue, 27 Feb 2024 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038158; cv=none; b=kmeIERU9l5nZdSAIKoJnbZJYt6oVBPJX53dwq6T5H9tT2H4JT3pEhIXZRFNNMW9vuTWvhQVf05e/53fe/fBQW0ibFMltgBGcUyV1zfmkw9Dm61wKQchZqHMCioLS9Aj5Sd0SZujR6TSgGKAKMVwEwSXMS7szCEkEVOcsBm0aZA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038158; c=relaxed/simple;
	bh=oTWwoTX0hrUSfcNocfpLt3JaDWHEII50tRTkLPscP7Y=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SBnLfI/VhHoBkwdVtSWzsX93hEf5Pjkr8fEkIR0Hnq/5UP9lB3RoWJDe2hEftAwQHFCKNc6csQBofkYiwyQu46rfV2LbO3T3NHzdpmiAVUvEG3APErc1dJvDjwTb4vmlYXTJZ870JShyQDs1FfNXuyJMulw8IDD8518BolP8J7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVin+zwF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709038156; x=1740574156;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oTWwoTX0hrUSfcNocfpLt3JaDWHEII50tRTkLPscP7Y=;
  b=WVin+zwFzNlFnApqpIDrX73fxjFNTPcP5Ctj84APDBtHFRV76tc3Kc9Y
   nJsTUcWyfOFXp/I6PLxa+OkaNbXIfuwFx/CIX9/uHw7CtE3DwGcluLMQu
   Z1iE0gYKoI1Oa+7yYGntM7g5Z9fEfryN/VRXdnBq+ISwGdqLf2hG6H/IP
   a2VW/ENP6R67yQ4++5B3mY7jUOksw7hDZ/rFNy6fU4c6iwWu8MY1DzGEp
   Jm70QM8AfIGT6c5HnaLazO+IiX8Rpmk9Rb3ZCF779suuK8P3HZZDX57UM
   HUBHO8cb4043aF5sHh9xuL4TfBWrYQtoOsAjltQlfzIM9StlVWtcVOFA8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14815031"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="14815031"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 04:49:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7379971"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.34.61])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 04:49:14 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Feb 2024 14:49:10 +0200 (EET)
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc: Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com, 
    shuah@kernel.org, linux-kselftest@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/3] selftests/resctrl: Simplify test cleanup
 functions
In-Reply-To: <cover.1709018050.git.maciej.wieczor-retman@intel.com>
Message-ID: <7b86f718-abfb-aa8f-5d4b-ebf5dd7b3e62@linux.intel.com>
References: <cover.1709018050.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-157701625-1709038150=:1099"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-157701625-1709038150=:1099
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 27 Feb 2024, Maciej Wieczor-Retman wrote:

> Cleaning up after tests is implemented separately for individual tests
> and called at the end of each test execution. Since these functions are
> very similar and a more generalized test framework was introduced a
> function pointer in the resctrl_test struct can be used to reduce the
> amount of function calls.
>=20
> These functions are also all called in the ctrl-c handler because the
> handler isn't aware which test is currently running. Since the handler
> is implemented with a sigaction no function parameters can be passed
> there but information about what test is currently running can be passed
> with a global variable.
>=20
> Series applies cleanly on top of kselftests/next.

Thanks. For the entire series:

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-157701625-1709038150=:1099--

