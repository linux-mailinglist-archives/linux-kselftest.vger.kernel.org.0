Return-Path: <linux-kselftest+bounces-5802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 609C986F5EC
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Mar 2024 16:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE3FEB22169
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Mar 2024 15:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C5C67C4E;
	Sun,  3 Mar 2024 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="gRzx/h4V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770D167C74;
	Sun,  3 Mar 2024 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709480114; cv=none; b=hSpXz+S84qzqwswxJ5YIZuoKEZpwEESSFEuhQ6OTfvrG2yIoUtfrhXewtuzVOTQbUPbcWmFli0bMkvTFfaG4tnw+6rMKYdqFxpEOAeqAm+3IjAIz0mv+F0/HYvMYztREtvSy1Oo6nl7BAdikwDPYm3bQRKB27jlp6CwGNbNx61U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709480114; c=relaxed/simple;
	bh=J1rKlv0QptsyaOZm/cu/A0gnZSOEK20bfTcqTL6hjWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cu5cc1hAZ3elXiOU5eLMR3EOhmFfkSfqRPV6DZPmRnDmXGSGnE3J8jd4xNpPsZXMJtDRYn24MQNKzMSu0x4JOppAMXsKHM/YQm81KTG99BjkQUPkbwKPBYl4pg3sSzbVrjTY+tkEm+oeZ4CLBovLULhgWKTMCjktPz3kSEERIBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=gRzx/h4V; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=valentinobst.de;
	s=s1-ionos; t=1709480104; x=1710084904; i=kernel@valentinobst.de;
	bh=J1rKlv0QptsyaOZm/cu/A0gnZSOEK20bfTcqTL6hjWA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=gRzx/h4VmDhnnkT5ed1o2MnufKxrqha0WjEPS90AwiBQK7BEIlYLPZfG7kzjJs/8
	 aBcElFg0qzH8EM8rpzOdjLWuUl7BFnHmbbomc/gZpA6zaY/dQP8F1PnEFkBS/RdBU
	 qt7PBwm03aVYfpohi076RB73HMwjDNT/F3vMp4kRk+c/v2EuPB1deDKZN4+IbKcgw
	 iUfw8J4UwER9ynkzWjC9IvGjo0OhYXSFl6JQZNE85I/7ATlCgvwIPAZQ2bVBDLp+v
	 UTGtis/vO5I7E/Z8ZeZrc4X5s+SxSTspI6Kk9jL5urpzLbuI51dfS+jvZTTCcgcaf
	 gNdZwrU1U0oph8Z0oQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from archbook.speedport.ip ([80.133.137.1]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MVaQW-1rFONH0AHU-00RcDR; Sun, 03 Mar 2024 15:49:03 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: laura.nao@collabora.com
Cc: a.hindborg@samsung.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	kernel@collabora.com,
	kernel@valentinobst.de,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	sergio.collado@gmail.com,
	shuah@kernel.org,
	usama.anjum@collabora.com,
	wedsonaf@gmail.com,
	Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH v5] kselftest: Add basic test for probing the rust sample modules
Date: Sun,  3 Mar 2024 15:48:57 +0100
Message-ID: <20240303144857.22733-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240229155235.263157-1-laura.nao@collabora.com>
References: <20240229155235.263157-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:O1P97DOM4jgrahyMeAR2tBK7dMmKKRstg0K4U156wgJCHTA+z42
 v8C2reGcPJM5I+wQvyQEbBltI2ugLivq769T6daBguSi8/QITNR8PiI08rh190+DiNOvTKw
 sLIBNSOQYnlppnlzXx4czGaxKLHdGroEif2vvbKvno6s7JmH3ls9jckqqkVjDGviIsm79iU
 vvQqIu2pKKrbS3eBNRMHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6nQpzSL+oWU=;bOKAzYAD5DSYsoAOUG00Pgj3ffU
 kj4w7BeH0+5FZJ7i8e4Lx+UULAKHa0dx1AjqQWcz/VL+5HN+uv66YU7g9wiqskc0j6RZpVQEM
 8XSmASrvCc6aj6Ja60g2+QzW034+XbGVHn4LOeqSXUuTtR+xu8fzIf1z1LFvlYiW0WthcFRky
 LvzToT9mtQGX0FBAuptdpKv/+3ICUQZnP4xxf0jypQSJN9vYEW9nTMJq3cnMdJTn8299z3S10
 UA+vaaa4kf3a5o/D69q8p1CXWPI8MmIKiHrcAgu4Gfpd2kSlRLAHYlrh3VdeIb2i2wXMjBMaN
 rFhNsnET+o15dqPiGJzuYZ3JLW3CZK2837v9iLULkK01q6Qcvbcp7pcSd/buNyaB6otdYS4GH
 gZLA6hRxcoocKqmYKzVlIdq3wgXTAKOSNd6pqdlbySnTU/YsY2Z9iZp1kZ6Yr0pfM37qEyS/J
 CebfM+B1tgpX3kNs3/mEoXTcvgD39XtoFRJHfvS4E2ZPtOlCyMdPXfiao0ltKZQmvBaL1qC4J
 7B6colu74E0UgoQFTU38wXlA9JsIZIQzh8ffHUAvpKCJ7uX7AQzczsysFuGqoJlPr0UZP5U6l
 hFCfNnT3Z27CkFVYIHmm+RUzkn441TF8XIcVTAViHqB2ookCixQ+OVDRz+D/TZ9N4DZcOZnHd
 5XEtYJmHDtcYKMq+5C7TekAm8t3TZiIyYN9GaS2lcz9EefFqqcYPL0HOC5pLnItEUek6sEnKX
 rNbECbdrDYvsOB92kWzsadGXZWdg/ogCgDtUfVBnHKIAfnuofUQZBs=

Perhaps we can also add a section about these tests to the new
`Documentation/rust/testing.rst` [1]. We could mention that they exist,
how to run them, and link to the kselftest documentation for further
information.

Not necessary to resend, perhaps we can do that in a separate patch when
this patch and the one by Dirk are merged.

    - Best Valentin

Cc: Dirk Behme <dirk.behme@de.bosch.com>
Link: https://lore.kernel.org/r/20240130075117.4137360-1-dirk.behme@de.bosch.com [1]

