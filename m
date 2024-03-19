Return-Path: <linux-kselftest+bounces-6417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3E487FCBD
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 12:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E50C1C226A2
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 11:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AC07E78F;
	Tue, 19 Mar 2024 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="LjhvZ6Ol"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98617E10C;
	Tue, 19 Mar 2024 11:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710847511; cv=none; b=qwNx5q3ZeKgVfFngVeW8k2xSZUP6uN/W05J5kGVqdNpePxNx5l0wh7/OF1FWOntisjU8ZIP2LSJEsC7cnde0ha7JChj9i/hWd97aJlAH+CmmO9ixwOmzdlJF1VYXlb/uN7jBFcLv4C1WIZyyoRqsFLvhzRJyL2vs151zsZLYJeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710847511; c=relaxed/simple;
	bh=3aelQnJnbfnuWgwLuYNDCnxY1/98huemq/BeKZzHgOk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Gc1M0WAMOHdo/BrJ7g7gsoW9ByhviLKEMLI5k6+JjHWNEhBsW9iyC5CaeNrzeQiQKi33LGhoNmTbuDs3qYha3bUnwlQ+mQu4NylxFjBFqR9Y20xunQw9lMeI/SFNPUFVzQjRHMJ2i+KUoGat1y+rgGoSFoUgaGnbeLE6nMX8Gd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=LjhvZ6Ol; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id B63C911823C9;
	Tue, 19 Mar 2024 14:17:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru B63C911823C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1710847027; bh=3aelQnJnbfnuWgwLuYNDCnxY1/98huemq/BeKZzHgOk=;
	h=From:To:CC:Subject:Date:From;
	b=LjhvZ6OlnSxTN+U27sVqgbxrumV4POjyWdSOfUQmcJaKbQKeb006AuCaLMFf/TKUb
	 Xgwfrz7enz4Jsps6mrwTCkSlauu6YTrwDwukIyVx5+5heHkF9tVJInzHwaF+1h3oMy
	 Iv8mBIishxhz6JZS7vlU/v+gcD4J0evmrPMCOkwU=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id A97723194AFC;
	Tue, 19 Mar 2024 14:17:07 +0300 (MSK)
From: Khannanov Lenar <Lenar.Khannanov@infotecs.ru>
To: "usama.anjum@collabora.com" <usama.anjum@collabora.com>
CC: "broonie@kernel.org" <broonie@kernel.org>, "ebiederm@xmission.com"
	<ebiederm@xmission.com>, "keescook@chromium.org" <keescook@chromium.org>,
	"kernel@collabora.com" <kernel@collabora.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"shuah@kernel.org" <shuah@kernel.org>
Subject: Re: [Test Failure Report] exec: Test failures in execveat
Thread-Topic: [Test Failure Report] exec: Test failures in execveat
Thread-Index: Adp57W2n37A1/0hjScaK2/H8pOXfEw==
Date: Tue, 19 Mar 2024 11:17:07 +0000
Message-ID: <da3b180375de44f9b983b466d5637899@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2024/03/19 09:15:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/03/19 05:26:00 #24286518
X-KLMS-AntiVirus-Status: Clean, skipped


Try to disable tomoyo lsm.

