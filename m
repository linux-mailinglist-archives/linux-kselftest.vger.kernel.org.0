Return-Path: <linux-kselftest+bounces-4238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853C484CBAB
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 14:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D9A1C210E1
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 13:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBA377622;
	Wed,  7 Feb 2024 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XQdu5pnq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA2D59B76;
	Wed,  7 Feb 2024 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707312961; cv=none; b=sUg8FVusPK2bZ/6U/DiWJeA+6NtW8dmR+u/P3gKtTnSSlI39AxK1VCrIja9a34Utt386WfxqB0IMrJqi1DkzrfKvhAO94n1xGE3kYSKD/GV9Km/e8kwDGv/6UeYZc+e6vI39s2ZIOiqLiAqxvMKEZEnKOAwh8eX1hrERkbT13ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707312961; c=relaxed/simple;
	bh=/ccbhvQ4GC+RIE+K+c3gsvN+o/lIl323mNlKNYRaMNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nDl0KgNqKBc1bG62FgOm/qjsHCbVImdRSwob8krv22k6uuMEcMa8/VbofLllqYPAwcHbUTsg6stf/GmJPqfKzEprHjTdVZLHHDm+4sYuHx6+89g5b6pRV7VZAAr+C6WeB6ZeqlLU+u297Jt0c+HAXl3AN78qahsyKrQ+iPdfRXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XQdu5pnq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707312959; x=1738848959;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=/ccbhvQ4GC+RIE+K+c3gsvN+o/lIl323mNlKNYRaMNc=;
  b=XQdu5pnqAAEVx9OBXhoTjQLe3zwuTCt8/e4TA8ifHNRjjJj8bww+zQkE
   raiF33KnbaFveIfmEhouEnug5+zarGdKa5MtPWSGv7x4UWkEBkDGFrEu1
   Z/phBe+q4bOMWag5pEK4BApChZP/KAQCA5MnskRKYkPpoGTniQQAIGCxZ
   z79TauvRSgDkzJo+4HlT2JuIOzsPKQLxKg/WSCvVXIn46exvZ5FjBKxIt
   yE2bg8JNIc8ceT8TnooafCKtpfuhnS46PRZL0ONyxam09br8Wd73pUEjK
   a5MwP5rpHSTRH96GgUVug1PyOHo3z+NVinJ2Ny6XdHQnperU/EhEj2Tc+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="12345399"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="12345399"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 05:35:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="5946169"
Received: from andreial-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.61.47])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 05:35:53 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Rae Moar <rmoar@google.com>, David Gow <davidgow@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Brendan Higgins <brendan.higgins@linux.dev>,
 Maxime Ripard <mripard@kernel.org>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, Chaitanya Kumar
 <chaitanya.kumar.borah@intel.com>, Jani <jani.saarinen@intel.com>, Richard
 Fitzgerald <rf@opensource.cirrus.com>, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] kunit: device: Unregister the kunit_bus on shutdown
In-Reply-To: <CA+GJov6Swgvc+wrCvW3Ujqh_UW1BSRDrp9ccHUX2CVRjWpe1dQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240201060437.861155-2-davidgow@google.com>
 <CA+GJov6Swgvc+wrCvW3Ujqh_UW1BSRDrp9ccHUX2CVRjWpe1dQ@mail.gmail.com>
Date: Wed, 07 Feb 2024 15:35:49 +0200
Message-ID: <878r3wcs7e.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 02 Feb 2024, Rae Moar <rmoar@google.com> wrote:
> On Thu, Feb 1, 2024 at 1:06=E2=80=AFAM David Gow <davidgow@google.com> wr=
ote:
>>
>> If KUnit is built as a module, and it's unloaded, the kunit_bus is not
>> unregistered. This causes an error if it's then re-loaded later, as we
>> try to re-register the bus.
>>
>> Unregister the bus and root_device on shutdown, if it looks valid.
>>
>> In addition, be more specific about the value of kunit_bus_device. It
>> is:
>> - a valid struct device* if the kunit_bus initialised correctly.
>> - an ERR_PTR if it failed to initialise.
>> - NULL before initialisation and after shutdown.
>>
>> Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
>> Signed-off-by: David Gow <davidgow@google.com>
>
> Hello,
>
> I have tested this with modules and it looks good to me!
>
> Thanks!
> -Rae
>
> Reviewed-by: Rae Moar <rmoar@google.com>

Thanks for the patch and review!

Is this on its way to some v6.8-rc's? The regression in -rc1 is hurting
our CI.


Thanks,
Jani.


--=20
Jani Nikula, Intel

