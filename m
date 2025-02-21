Return-Path: <linux-kselftest+bounces-27146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DADA3F05C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 10:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47653188FFBF
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 09:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F065202C5C;
	Fri, 21 Feb 2025 09:33:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0E51F4299
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130416; cv=none; b=YblkFinlY7GBHc/JWOq12QH+QftYpa13KxwEiiSknMkAQrxlvg3OsZBqTU2QTmjBkfjCJsmpvmIfAMirbm1yMsSEE7Ojlf8t12Q6yQvvvJQNCz1SVL1sFSvBRkhFGg6PReOfZovu03czcAXAsqxsFjTVBseNG9BJ4WbnZH4wJGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130416; c=relaxed/simple;
	bh=ZJBW8GSp4qyddv3ydxRQ3CEnkWVZOCVS6lbOg4bBig8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RlPCO5PjARu8F3NCLyKf1fwP5TOvinKwj1/KjNHB0uLE99QQJ3wxogBUxeBk/HFiVJ+E69fmg8+OUvsKwTLNqtFxjLDFYShAwJxhhZXq9CkZDNurFa9kOaYgh+Za/aHVDGq6nmYbUtY+zbWj2KjlPC4zOF6JWe/OOHdTP9U/hL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F38C4CED6;
	Fri, 21 Feb 2025 09:33:34 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 0/2] kselftest/arm64: mte: Minor fixes to the MTE hugetlb test
Date: Fri, 21 Feb 2025 09:33:29 +0000
Message-Id: <20250221093331.2184245-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch makes use of the correct terminology for synchronous and
asynchronous errors. The second patch checks whether PROT_MTE is
supported on hugetlb mappings before continuing with the tests. Such
support was added in 6.13 but people tend to use current kselftests on
older kernels. Avoid the failure reporting on such kernels, just skip
the tests.

Catalin Marinas (2):
  kselftest/arm64: mte: Use the correct naming for tag check modes in
    check_hugetlb_options.c
  kselftest/arm64: mte: Skip the hugetlb tests if MTE not supported on
    such mappings

 .../arm64/mte/check_hugetlb_options.c         | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)


