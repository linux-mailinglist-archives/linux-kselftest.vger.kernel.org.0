Return-Path: <linux-kselftest+bounces-5270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F2385F507
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 10:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF0E1F23BC6
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 09:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16ECE383BA;
	Thu, 22 Feb 2024 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+va+wK+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A63C1799E;
	Thu, 22 Feb 2024 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708595564; cv=none; b=jhce5Se1+R2dti59stAstzk8Drwjn8vfcg8A874gpNeMFroxVr8/5QIPeWjOFD1pzwZcKmAKb7SJmBbGKN024VcOCcgVEZe8jqn4yNeWJiMP8458HaTbCACeI4+gq+zyMLBWKdT81Fyu1MIQw9qgf544jf7Yex5sizgOhETH6bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708595564; c=relaxed/simple;
	bh=UtQejpj2ub5GgwVa1H1jgT4JT5ap+riBEaepGdBSwnc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NvBKnfLVE91Vl30F20L0kdbkoZQizACiTSN1/y8MbPN8DY2woU43jDXaEXc6C1KjfTPhjd4d0/XSGkNRwkFyTGTPX9oYeHlLAfvyqstYWO3+btAeEgNXbnpkJD+FYWY0xlHa1q728yiyLPBs1m9bZDWqafsbjA+EQqup1Bmn1+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+va+wK+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708595562; x=1740131562;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=UtQejpj2ub5GgwVa1H1jgT4JT5ap+riBEaepGdBSwnc=;
  b=L+va+wK+ZTtRqbj97rIJq3ZdF7U7hDDI3KHshzoz2ZF3CJOohcWjeV3b
   Vqm4Zw+812RfDYT01Dxo9PgZTyExlBEJR1Y4ABvPYsfHEnbgYu49AdTNW
   NI6Sq9NrnQf+TUrQOkAhf5kcnqmAv2kcwukIQNcn+4K/77YDso7tzkIZy
   nSlDZA58AbxP0ObXVpepYGuAGWvhdFTjiMfGzXv5pskGXTeL5YPaW95XY
   3Ktl+OT4TGFQZ8TiDwp/fW6DUCyevxzK14y8GnBQma01DDDSThC8hnqLI
   UqFmNfSgt+cmvvt/uieBgdzEq6jS9Yqe3FIdM+Lo/I7nYBNaOo11Ei5iD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13430390"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="13430390"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 01:52:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="10132604"
Received: from binm223x-mobl2.gar.corp.intel.com (HELO [10.249.254.168]) ([10.249.254.168])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 01:52:34 -0800
Message-ID: <ee268c7d6d2dd490a42bc86ad518dceb878e1f52.camel@linux.intel.com>
Subject: Re: [PATCH 8/9] drm/xe/tests: Fix printf format specifiers in
 xe_migrate test
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: David Gow <davidgow@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>, Matthew
 Auld <matthew.auld@intel.com>,  Arunpravin Paneer Selvam
 <arunpravin.paneerselvam@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Kees Cook <keescook@chromium.org>,
 =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,  Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Matthew Brost <matthew.brost@intel.com>, Willem
 de Bruijn <willemb@google.com>, Florian Westphal <fw@strlen.de>, Cassio
 Neri <cassio.neri@gmail.com>, Javier Martinez Canillas
 <javierm@redhat.com>,  Arthur Grillo <arthur.grillo@usp.br>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Daniel Latypov
 <dlatypov@google.com>, Stephen Boyd <sboyd@kernel.org>, David Airlie
 <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, 
 linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
 netdev@vger.kernel.org
Date: Thu, 22 Feb 2024 10:52:31 +0100
In-Reply-To: <20240221092728.1281499-9-davidgow@google.com>
References: <20240221092728.1281499-1-davidgow@google.com>
	 <20240221092728.1281499-9-davidgow@google.com>
Autocrypt: addr=thomas.hellstrom@linux.intel.com; prefer-encrypt=mutual;
 keydata=mDMEZaWU6xYJKwYBBAHaRw8BAQdAj/We1UBCIrAm9H5t5Z7+elYJowdlhiYE8zUXgxcFz360SFRob21hcyBIZWxsc3Ryw7ZtIChJbnRlbCBMaW51eCBlbWFpbCkgPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPoiTBBMWCgA7FiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQuBaTVQrGBr/yQAD/Z1B+Kzy2JTuIy9LsKfC9FJmt1K/4qgaVeZMIKCAxf2UBAJhmZ5jmkDIf6YghfINZlYq6ixyWnOkWMuSLmELwOsgPuDgEZaWU6xIKKwYBBAGXVQEFAQEHQF9v/LNGegctctMWGHvmV/6oKOWWf/vd4MeqoSYTxVBTAwEIB4h4BBgWCgAgFiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwwACgkQuBaTVQrGBr/P2QD9Gts6Ee91w3SzOelNjsus/DcCTBb3fRugJoqcfxjKU0gBAKIFVMvVUGbhlEi6EFTZmBZ0QIZEIzOOVfkaIgWelFEH
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-21 at 17:27 +0800, David Gow wrote:
> KUNIT_FAIL() is used to fail the xe_migrate test when an error
> occurs.
> However, there's a mismatch in the format specifier: '%li' is used to
> log 'err', which is an 'int'.
>=20
> Use '%i' instead of '%li', and for the case where we're printing an
> error pointer, just use '%pe', instead of extracting the error code
> manually with PTR_ERR(). (This also results in a nicer output when
> the
> error code is known.)
>=20
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
> GPUs")
> Signed-off-by: David Gow <davidgow@google.com>

Ack to merge through the Kunit tree.
Acked-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>



