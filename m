Return-Path: <linux-kselftest+bounces-28832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D49A5E2DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 18:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4C23A3613
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 17:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D761DE3C0;
	Wed, 12 Mar 2025 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GWq8BvB3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17D71D5165;
	Wed, 12 Mar 2025 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800931; cv=none; b=AtvTGQ360LVlH+WUuq+EzcH67rk0GtTGyTrU5IH4pj3UCIiqGzBGpiuGRYXkdKPWTfYwPh8p0ieHBUOzm42YnaE5FQ7zen7qdP3zzam5W1DtCEMrEJ/uEkUXah7Kc1iGzvIMCrgCOUSlWq5SvM8wpPePvmJY8TfhUj7tuqgTtjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800931; c=relaxed/simple;
	bh=Sj0dBodcvXrgrMFXTpJ7MHV3Gyurq1IDxdsqypF7r4A=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=B2TG3oGVqDr+wjbaGktqTPWXmMxmaAzSnKV3uIwgU9pTAT0Psirt9Sz3EIZr5Eok9DMkHtzpnVPWMDkhhDJoXnM8f121gyaTimHpxBpTBBWSST1QLZHAqggTWdyPypntsKgRJ/0y9pJ9ax+kYgGZ/k/Y3CmJslksab9Nij44gw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=GWq8BvB3; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741800924; x=1742405724; i=markus.elfring@web.de;
	bh=Sj0dBodcvXrgrMFXTpJ7MHV3Gyurq1IDxdsqypF7r4A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GWq8BvB3fkiJa/CrmFCk7mFYiihQYpF/Mkf9YkBZF3sIhbYK37JdraavVh2xzub4
	 4EViXzl5mhYSyYxXp+Z37ClQ7TIXIk4kbFp2wc67uihNqZBI+XHEP/9F9wrQqqMCZ
	 GDd3me7An17EKBI3YeIJmwd6aTJpMMcxYZJAdRqTYx76D9NZFtR6zzqor47yr6lXr
	 xceLHiBLroRlHsoxqUKRB95QVpxqOEcS1dOUQxgNeXptpHOB+44CgkCvYZV5Il95E
	 7eORBrRs4f36uhXNV/RMAeZcQB3hSLKsus5wCoxavJm8fHjz7YpcyMra3VVDuydU6
	 UEH6FsAKyscp999AQg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4621-1t9yLl0TpJ-013DSw; Wed, 12
 Mar 2025 18:35:24 +0100
Message-ID: <d019ce8b-5837-47a4-bd98-06c68601d2fd@web.de>
Date: Wed, 12 Mar 2025 18:35:21 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyan Yang <cyan.yang@sifive.com>, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Dev Jain <dev.jain@arm.com>,
 Shuah Khan <shuah@kernel.org>
References: <20250312043840.71799-1-cyan.yang@sifive.com>
Subject: Re: [PATCH v2] selftests/mm/cow: Fix the incorrect error handling
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250312043840.71799-1-cyan.yang@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LkVZHbR1KZMN/iEUMxpqpSyBamaRjE/UG6R/ZfvAYxbZPhKNW21
 QkYAFaiFRtldviOvDDsIu8dzEqJN061DnJ92BV//dln3xvAZBfqps4B6TKpbLcUnRFb+C1k
 D2JPN7BXIzbS9VTvFoIpcZPcg/RFvSOlWclmLWx8UFVLBqckFCGGsQWSx7bW30dG4kWTFVz
 8WXqD3wqDSkKL0j/DWhvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vs1fzCodo9A=;Upuq5OIiKyl1jNf8eF3beBL2cix
 sEjJ22Zx3zh6Gc1RXKWe4Mp9Sa1pJtmA6VYTg3GBaacszEA3FGjIxWCOwHLaiVfGXG3HnwGeV
 vGB8VJFNktX7UVGdQCflbLfOKbozwuC8QoSPe3aeIbinEZDKD3u+1bC/zYj+1gM3CpSkEloeE
 rVUA7HzoGTWURS6P3d4g2Atkxwhrv+Q5qdQZKGtuNYLVQZlFTsD60rJLmval6FxogDuiWIOGy
 ZE7ixshHRJ612M8HCAXuZQAAkdsTrX+/DuU6DhuRwY+BP1D4Lc1RKocte9YYh/lO9oSPDw/92
 hTIuFKXoWEIQpETv0TcdfJLRWzmpt5ksvV8JxpS5bXJhrYQJBCo856RhuTRq/lvrEtgXYF+RN
 UANmaih3NIXYsTr03CeoCcUDUDYsyp512b2THwQM9xmJgtjdJSMB54jgTPpDZxZJ9l+SZJNUF
 zuRvO9AIMvSAmZu4hG6WxpiPJe+aC/Y0Sk6P1nsDpIqm0wMh8CffS3je8PL9UNIAxPvzXs4un
 Je+orcvzBvvg7D1tXy+FHc0dk8MINHi7aV4J3FUUtAVJHl+YT8I7TYnIyIl7rD3x89uH4l6wk
 A18igNRAQjNKwV/DQvSgKD1ZRo5zPd+Xmna1EMITAQba44cteuDy4kcQGTIVRfuEYoDIpk6Cg
 Hk9ADjjMGqkdptU4Ti8dKgKY9DLZFISnEYD9yMNY0SJDZdnlXcUiflKSNRsYLrad7qHcqRqVF
 I8FdOhaLqGa7ILtL11MzUHmQYHHDsYTuwEvqMwtL6SsIHjTLpsRutE652AoY6BDPI2TQ3vkvj
 7L96fF4APmTyzgaHOVjxHLNEFtPDBpXx+yIA9kfNrmUGd+Hpozxkz66B3f1/wBHZQhfgLJtx6
 ZBrqB/SNduLx/MPrMdTTw8k1FAjjrEHnWjInMAbtbn5W9EtXZtFMHQ9PnDAjlBv6s8A2hP2F1
 cnUplkfdEdJHbJwph2zqQMk0SQwvlMfsu3N7G4E4/Li7q89QZHCxKg/R7kRnLbT+FzELv4g5J
 XYv6P4nXICIWwRoE21TbTN3764tV3GI3+jlCNgSxmnPb+pslUx0JthEWuZtoiDd0dK/gTOVdj
 e9H+yC3Y90xq46m40OJRzKL4n+eny0ZDrwqLU4JL7R4MVnlmKK7dx45QD/UIlDAxpteuNivAN
 m+IaiQU4WJvnbFlv359OL0gUFO8TdidTrGT61AlTRXdf4t68vwuRICgFKbirFzu4v8w1QkE5a
 8COTVMAPHUuwFeKk0DF72lvfQ1cVhJwJmyU+y3Hu04ZYXDqVZwChs6/Q0cHp130co9yeTgXQ6
 nuvrBM/ZdpQcDpJRocYD6LK0aTo7LxzOw4XeNYhQM/VorOLlfA4XqwUHH5BDurMJRoDVMjlqA
 pmJvCQs1nqP0CIFxOvXC4C/d6JznkKkvCxBgMxZU5LNldTtcjt+IQg79UmDDWCX09HQNxlX9Q
 LGaEV9drQKppKIdLwAuMSErzMbYf7TyNAuWxABhiXWF/cyt64gSzGK2i9n92sAahLkJPVRg==

=E2=80=A6
> This patch will fix it.

Will an imperative wording be more desirable for such a change description=
?
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.14-rc6#n94

Regards,
Markus

