Return-Path: <linux-kselftest+bounces-9218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F48B8B8D4E
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 17:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A42A1B23519
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 15:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212B312F5BC;
	Wed,  1 May 2024 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="arNoMv24"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBE4C2FD;
	Wed,  1 May 2024 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577900; cv=none; b=Yr1jSX7GnWxHHX4R0NfEbqjckl39bbuahUCE8uOGDbbUwm6KyqUAgVdN6I+bkjt2416erdZpuquuuQRXfnBfr/kXDoLLIXrWpJXNyn8JcVODy4zFXCD36tl4y2KDwHiZCV4XjN3L2Aq6IYCXeZGHBGlQ+MEsmKvepG9i5ygBVu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577900; c=relaxed/simple;
	bh=eDoeRon2FNe588ZUGUZc3+AJ6puekYfMV5lxqbbJ3gE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qHuBJhCAeslGsOsR977u9ifMK/P0gyVP0R+yG6iHRupG9w7SLRO4FDwb7fosyslU+O6ZR0xA0dplH2rhBosq/XmNnDKxR8NzJUXPyzRVMZEad9KOMkXjEx+S5rAChcNudR5JA/hidp72DWbYuizA32p+v+PTZkW6ItFeN5Q3rbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=arNoMv24; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714577820; x=1715182620; i=markus.elfring@web.de;
	bh=eDoeRon2FNe588ZUGUZc3+AJ6puekYfMV5lxqbbJ3gE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=arNoMv246RrlBebVKPsArQ2tTWPM3YvFF/URq94nk+24URwTNiIDjTRwrM4kRD9j
	 KJj9LQDUTzvR6cbeRlOQSVxs3+tNtP9TTAMDi/IzkgfKLiIAXx4/RPDvohGIHEPlF
	 1spumDATTDeKTIrhZkZ28IrT8DTMeCyJOQiSLZWLNkN4a7RtN/NdXCkYq80LQynGc
	 IOrvRfBLodljkRNVjEZljVUGVwBv0mJxtJUD9N8LDZGR+PMhHUxT8Shesf43/Q3/q
	 I2/daoFcaA/JtU1MlJ3ap+w4IVXCMY0B4KrUH8JROXRpDUwfNmjM4c/d0jqRYL2We
	 OuF/dizoGo0wzUZ1aA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MS17h-1sCp9M3Yrb-00U3Xg; Wed, 01
 May 2024 17:36:59 +0200
Message-ID: <1cdce712-f007-495b-80ef-0efe67dd5e20@web.de>
Date: Wed, 1 May 2024 17:36:54 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-team@meta.com,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
 Yosry Ahmed <yosryahmed@google.com>, Zefan Li <lizefan.x@bytedance.com>
References: <20240501100620.1461685-1-usamaarif642@gmail.com>
Subject: Re: [PATCH] selftests: cgroup: remove redundant addition of memory
 controller
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240501100620.1461685-1-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V37OePDYSXHrrNlgIy/91VHaZf4oW15rKVNXlr0apLkPnPgkYvj
 QVG0wyXvdoM0h6ld1A848+F4MW34V7/OMLkhLq4t1w4S9Pkrhgk9SDkmePtrNe02qzCN2+3
 c71O9PYKCuBiE6dacslGkPT1tMrTBKbrerG2rS6Fdyn6viqfl4PHjbFVJjZfNU0ytUy4vsy
 xzi5BouNuUXv8e66Bu+yA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kH699/Ne5mE=;WP0scAqvZ/5b5l0T3EdGVB0lKEt
 JDPTry589asK0ZpypIUQdoLm2ejtlhOcekQzTJJxPyYZs40l9muiY1bC1UMCEfxHCcl7MzLT8
 zmcZm16mnYhpo6jZIp8PvgDCuPDMt/HdonGgw1XuF0A5C58W2wmyBMQY8NnuDCFOE8alpLf2C
 MZACMjJT2fdw+mbIdi7FeWSOrgIKUryMMqVNAD+1GsQrjsw/jKBllCyx9MRZ3yDOCsPFXTJy1
 kKK0zfgSsMoKSIEamcbcD8Ke4CbiT7Ls6WpHFBblaZo8wp7BCcOLLC6SGj4uNHSMT7nMc1yfw
 ytlvrIbEOxp9m09u+PVuK834KlRayVJp9ARXiXP1929AbICWTvWEhCkKMM8dCYF/Ixr3/l67D
 CXoWJYE2+UO8h6pvQ7RvsjLLgkN5VuEvW796SQXu81SkMWVvxsIkqtSTja3NB331zgxYZRwlz
 qa42mJUWgW0+2emKkYNIO4DYUCzyZ6MQJV7GbOOVgjt9+hM4qXb6jDpSHTqBeBO+oN6Uq3qne
 mSL2SKlALeQlpGuiawl0k2tj8dIEBmbs7UTRdRHjdIji5rmFPltTxi+H3i9cYfgbg9X3aJvcg
 CoJXyKj4iVvBLbg1OPX+3UJxVUZqtV86x3Bmijadhq8GDzRvyQo50JAL1pQfjoYqoBKW0Dxfy
 CqSlulvB2/liu+XHnD4iCtQpHwvWv5hYCIFMyNfESSM5UYtTngdp1XEvuZ29T2ODUb8lXVrTy
 1TtRnUMzSHTYt5oLAnBEavJkgLl+LapqwMxVuvi15sgWk4MDGXeAQlpIBnBfvbr/oK01Hdi41
 dI8WGg0SRL6OcFl+fMSjMauPU60UbfSFtaWfIuvNWpZeY=

> This is already done in main.

Please improve this change description.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc6#n45

Will the tag =E2=80=9CFixes=E2=80=9D become relevant here (besides an impe=
rative wording)?

Regards,
Markus

