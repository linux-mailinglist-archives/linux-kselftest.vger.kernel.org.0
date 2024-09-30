Return-Path: <linux-kselftest+bounces-18645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 332E098A48E
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 15:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34611F24EAE
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 13:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3124191F7A;
	Mon, 30 Sep 2024 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPJRYZK1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ADF18F2FD;
	Mon, 30 Sep 2024 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702219; cv=none; b=dJ07AzMiw9kmMxyaBjRAGRYmCujnJHBAmSZAoxjcYZlsEV0D3A0HLwd2SVH/IkIPRJiN3erRC6Nm6GBwrWtAXzD8W5qpAj1lLJykmZ0SotXGIlkR7ixqrmNzwuJM425vrhtKwSNfkxE7q+fEtLzgtKSOvLB2eEZ2am5c8bw5Kh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702219; c=relaxed/simple;
	bh=drE6XgIHzCTCn+Vge1plxZ0J6vENXke7Ncli0nUf6Ok=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IdzppLkLLbWf/uHLAqg0Uy+vg0RIyjnpo5ayYw4w6ynBCdDI++yx0DsU5BL1f/eZf5TN8RzQ7HAqNp88mvYUuRabBHmE51MvQrIuhMcxTzc0ROfDVKeM7Tkq6WGl42E+JXwN5kUdQEU+778D6FjYqMcoNk3YpMeCwXlSN/J2tGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EPJRYZK1; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727702218; x=1759238218;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=drE6XgIHzCTCn+Vge1plxZ0J6vENXke7Ncli0nUf6Ok=;
  b=EPJRYZK1+fbctVlJr69H9yaeo8p0T5qRjBhVj/uCbepwPIYouOt5vkRD
   EhVDdMm5eZ2Wau6H5GOWNuSoU4Y0NtcC5rt2uTid3ki3gSbNYGuX8GZEo
   yKtHsOqcKYqFQOcNvJHcx7JnlHC6aWPTcQoGqzVt895Y2RrFy3grC7N3L
   bRuqBmpB2clxYOp2IKPnnSCTy4eIQ+cR3bDiOn7HAWVNrtsuc9qWvtKdX
   +jSOhJviMu6h3l7ha0QqnA8XpJO2152rL5jaTZuBhF8/LVaIytk/h7FVg
   TMnlZ3AgWgDv57wGSjCX34oXHSFZghivUwdKN8+24kJLvQKtcdtQdFw5B
   w==;
X-CSE-ConnectionGUID: /F209wi3QEC8U7Xq0T25Fg==
X-CSE-MsgGUID: EX6mfxIfRke+POx8Vu8yDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26887882"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26887882"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 06:16:57 -0700
X-CSE-ConnectionGUID: NljYa0HoT9OAWPRVZ5bDNg==
X-CSE-MsgGUID: PAyp+iLgQZWjUXBQTP3s5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="72891864"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 06:16:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 30 Sep 2024 16:16:50 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 03/13] selftests/resctrl: Fix memory overflow due to
 unhandled wraparound
In-Reply-To: <dc99091aeadca217f297c4cc0d4015bcb80443ad.1726164080.git.reinette.chatre@intel.com>
Message-ID: <33062b69-466c-8419-5bde-a39d6438abfc@linux.intel.com>
References: <cover.1726164080.git.reinette.chatre@intel.com> <dc99091aeadca217f297c4cc0d4015bcb80443ad.1726164080.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1378347176-1727702210=:938"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1378347176-1727702210=:938
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 12 Sep 2024, Reinette Chatre wrote:

> alloc_buffer() allocates and initializes (with random data) a
> buffer of requested size. The initialization starts from the beginning
> of the allocated buffer and incrementally assigns sizeof(uint64_t) random
> data to each cache line. The initialization uses the size of the
> buffer to control the initialization flow, decrementing the amount of
> buffer needing to be initialized after each iteration.
>=20
> The size of the buffer is stored in an unsigned (size_t) variable s64
> and the test "s64 > 0" is used to decide if initialization is complete.
> The problem is that decrementing the buffer size may wrap around
> if the buffer size is not divisible by "CL_SIZE / sizeof(uint64_t)"
> resulting in the "s64 > 0" test being true and memory beyond the buffer
> "initialized".
>=20
> Use a signed value for the buffer size to support all buffer sizes.
>=20
> Fixes: a2561b12fe39 ("selftests/resctrl: Add built in benchmark")
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V1:
> - New patch.
> ---
>  tools/testing/selftests/resctrl/fill_buf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/s=
elftests/resctrl/fill_buf.c
> index ae120f1735c0..34e5df721430 100644
> --- a/tools/testing/selftests/resctrl/fill_buf.c
> +++ b/tools/testing/selftests/resctrl/fill_buf.c
> @@ -127,7 +127,7 @@ unsigned char *alloc_buffer(size_t buf_size, int memf=
lush)
>  {
>  =09void *buf =3D NULL;
>  =09uint64_t *p64;
> -=09size_t s64;
> +=09ssize_t s64;
>  =09int ret;
> =20
>  =09ret =3D posix_memalign(&buf, PAGE_SIZE, buf_size);

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1378347176-1727702210=:938--

