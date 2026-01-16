Return-Path: <linux-kselftest+bounces-49134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9750BD2DE58
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EA593012BE3
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D212F747F;
	Fri, 16 Jan 2026 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mFGfKzr1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874B92F5479;
	Fri, 16 Jan 2026 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551304; cv=none; b=KbN8wxVEAmCJzoyPFizjKHP2BDbHgF4n3UkONnoeXOTDSKnc6CWMhra7RqyY8nZslEPfcuHeVKFRyDc5zx8Ww1/eEYI6T259hqrEnDJRNJIJ1foibfCYETsUyBuqtLjUOLU9z+znwDVQhz+5c3kvG2B29hZmPxmNWDy9uLqq804=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551304; c=relaxed/simple;
	bh=+3fiwSv6732JueMxzTDwScLgjNk1DqiSElb5jE5sfTk=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:Mime-Version:
	 References:In-Reply-To; b=hi7r4Wa4wfqNIoOLAvMZgGYA3iqa63QWfOmomsiRVDo9MShJN0lS69J7Dxpel5biRScZSlrzGXhKiAUQ0PRFqd1vUvJ4oXKnp8K2GgwnDoaCcbgzqghYNHai8o9QhBE8V3yRVmYUTwuJr6SPA3mYMTZFes5oeRijKYq4gYPoQSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mFGfKzr1; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AAB344E4210F;
	Fri, 16 Jan 2026 08:15:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 76F3160732;
	Fri, 16 Jan 2026 08:15:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 661CB10B6830D;
	Fri, 16 Jan 2026 09:14:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768551299; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+3fiwSv6732JueMxzTDwScLgjNk1DqiSElb5jE5sfTk=;
	b=mFGfKzr1A1TsRGptz8Mg009oefB9S9yNTcmYonHDu6aEH+7KG28S5aGtAljNiYbnBdtru+
	tY/XvXnf/BXJH/MOfZRB6sh+q+m3SPSVkNujgb6YYq38Ow5MF7OxqzyupzDmfzLHRaUnon
	10nhMa3EcYPQ43ffopjNamAtOa8cTdH3CdxGhnC+qDRp2ChQyYnwOu6aux2qc1EnQqL2B4
	1qBgqRL8kNZNDvyWRhuJU2VTrmE9jK6li+h423V4AiG4CbGSaXptr9jGrrFX9GlmwxRHa/
	DbjYs1xeUts9ffAKbPpYwwWwkH8477m2MHRh+NGpw4ynJbAlDtbo0j2W5GjdSA==
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Jan 2026 09:14:55 +0100
Message-Id: <DFPV415Z8CYX.2GG89W9HSA56U@bootlin.com>
Subject: Re: [PATCH bpf-next 2/4] bpf/selftests: introduce bptool test
 runner and a first test
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Quentin Monnet" <qmo@qmon.net>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin KaFai
 Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>, "KP
 Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao
 Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260114-bpftool-tests-v1-0-cfab1cc9beaf@bootlin.com>
 <20260114-bpftool-tests-v1-2-cfab1cc9beaf@bootlin.com>
 <d927b00a-68ef-4ff0-b655-7f45b6d5764d@qmon.net>
In-Reply-To: <d927b00a-68ef-4ff0-b655-7f45b6d5764d@qmon.net>
X-Last-TLS-Session-Version: TLSv1.3

Hi Quentin, thanks for the review !

I agree with all your comments. Andrii raised some concerns about
bringing a new runner, I'll wait for this new runner question to be
settled before bringing those changes, as it could make this series
change quite a lot.

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


