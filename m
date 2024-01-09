Return-Path: <linux-kselftest+bounces-2768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2A0828F4A
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 22:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E92C28583C
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 21:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ECE3DB9A;
	Tue,  9 Jan 2024 21:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="tcuMtN/P";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="INdqGZ5b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2523DB98;
	Tue,  9 Jan 2024 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 0F31260177;
	Tue,  9 Jan 2024 22:54:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704837269; bh=dRxFw5p+aq6ymY6wMk/W0bLOKcB81JXGCstzbRw+IUA=;
	h=From:To:Cc:Subject:Date:From;
	b=tcuMtN/PcH/XqAqDun2ldK+Yl8EEeZXBW0srFj9O+NKybqeEngKHW6R0rI1mK94jE
	 fzHWV0P5cuqpRXqLQWDeoTDMisFJgXjdPwf74mE5NUokC6tT7Xs8EAZ9s8DMH9M0uC
	 a+K4A/SP+GWp62+qO8NtaTSUOcPnvohkkxOodQhcewnHbT73SWwWLGnHygQWikNTR6
	 cLbJAs4DmRmMBr62W/3QqIFQj1Tqt70FKh+OCV186NYok4DW7PkZDOVysEfqXlwIxu
	 /GqJ7ypK5X+3bfHPjOU8cTLwlm5ChYQKCnPZ/xRhhCF+lgc/snUSe5Wg2DpcCJHsX5
	 hJ2D1oiKByQPg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PodAykXuILWA; Tue,  9 Jan 2024 22:54:27 +0100 (CET)
Received: from defiant.. (unknown [95.168.105.29])
	by domac.alu.hr (Postfix) with ESMTPSA id 8131960171;
	Tue,  9 Jan 2024 22:54:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704837267; bh=dRxFw5p+aq6ymY6wMk/W0bLOKcB81JXGCstzbRw+IUA=;
	h=From:To:Cc:Subject:Date:From;
	b=INdqGZ5b0eWMwJia7/6cnjs4dx5XCJwP6X118wJeJbV/895EK/ApROZmwNhJv8dRI
	 PC7fkfZQIa88m4uZ+gYn5j+zmfQRqZ+yKV6YtAJSPXUbk2u3PnPD1VfgQAXG72q+gs
	 0XNR4GSf/t5Lsewezb2yXO1UNJ1wifX81DExW8WZlbjnb+hvly9kZQRtzKxfjEADOQ
	 ua+4RPbDwDU9xZ2tZ6cO5qGbAWScao8f7Wkteq5mEdEP7Z8q6Qf2ytR7djIzHCDKj8
	 NB18YA9WG2XMJ1fEJNSQnYl8JTEKaj9PexCTh9mtFKiG+AHASdLw+uddG8sGDkWCjc
	 Viy4CmYpqh6Yw==
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>
Subject: [PATCH v1 0/2] selftest: breakpoints: minor format string fixes
Date: Tue,  9 Jan 2024 22:54:04 +0100
Message-Id: <20240109215406.18218-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Minor consistency fixes.

They clear a couple of compiler format string warnings.

[1/2] is the fix of an obvious typo in the format specifier
[2/2] is securing the print function against spurious format specifiers
	in passed paramater string

Mirsad Todorovac (2):
  selftest: breakpoints: fix a minor typo in the format string
  selftest: breakpoints: clear the format string warning and secure the
    output

 tools/testing/selftests/breakpoints/breakpoint_test.c         | 4 ++--
 tools/testing/selftests/breakpoints/step_after_suspend_test.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.40.1


