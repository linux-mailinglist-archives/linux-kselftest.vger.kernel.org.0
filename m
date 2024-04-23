Return-Path: <linux-kselftest+bounces-8693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AE18AE392
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 13:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D9C1C21DBD
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 11:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424E182888;
	Tue, 23 Apr 2024 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ZTwkbU5H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BF4823D9;
	Tue, 23 Apr 2024 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870685; cv=none; b=nK/Tt1xSTDc1T8zYSaiYn5hXw9tavHmvr8CC72nGiCaZm/vC9B6d/G9e5ptMLuRhlgFDsK9B7tG/4seNDI2WA4s7hsA1+M5oqhV2+vC7U9uNiz8m/Zw0Wi5Aa9OiALLHk+tQgWZCUs+t9GxGV31MUsoPzIKWfEYJxJAJm7tuXLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870685; c=relaxed/simple;
	bh=UDo4ttePVrWsxEKCfdj9YbfYm7P0gTSM0kHtg8yETyA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=dCEJJefOyTxWszdGBAiJul96LBZb1DjFQ+z5HRFHKjJwhu1o0RqqA/IFY1fuxbJdnGmOCibHdwbct9XsZLnhRvTIUYzZ9nPJ5tWmuBloCNmBbFTKBboLsiiKqB+sbGx8l5eABf2P1jT//EQTCzfaFWO9PDvLrINRxiLerUI5+Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ZTwkbU5H; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713870662; x=1714475462; i=markus.elfring@web.de;
	bh=bf3YKUE5/YWw3/wAqQRtyDRSqezcCOIeyAX/DQ1RA2k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZTwkbU5HVxfSh/PuYC7rMfmzvhOfGYbYwyBJG70I2KNCyB8eZOXThrC5mwsJ6sFh
	 h5m83a1gynykRAPXphMDy9H5Ln0/4rHfQxZ9G8NUc8hCD0kiOYrPKi66sqFO+XF1v
	 LL5cT00iEpTaH02rG8ErBcLDF9+OTVeUx0Kr50yKgPYui5leYvNFFmpD8b3P5VZ/q
	 K/VRdM84RLnKcUVND9u4q7MAWOavHtYggGJNk8d/MTbamQQUbZXFoPKdOWbk7xTiA
	 gAzL/lEayxWkEHrXt9kaqei6WU6P3qB/spZpkhJ8K/7Bjur8SjnuXWtc0R/7cKj5v
	 VH+jqwKNBQPgjEXMzQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Myf3x-1svAGR0unV-012Tcc; Tue, 23
 Apr 2024 13:11:02 +0200
Message-ID: <5750611d-4c41-449a-ab37-9b234360929d@web.de>
Date: Tue, 23 Apr 2024 13:10:57 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kunwu Chan <chentao@kylinos.cn>, linux-kselftest@vger.kernel.org,
 kvm@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <kunwu.chan@hotmail.com>
References: <20240423073721.2001016-1-chentao@kylinos.cn>
Subject: Re: [PATCH] KVM: selftests: Add 'malloc' failure check in config_name
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240423073721.2001016-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l7n+uNb7WPk8WMmPsKcv3FItmU8s3wBeJuQKloutvOu88sqOFek
 ma6yKedgGQjTUdyQWtjy8BF1xDicIjkFcatqrZezmShYJtLNxhgYTjzxfe3ySgCb3ZGlWuD
 bm50wV9+4wM1VFiu2dB7Ar6T23rUC3ubw2/Fb5davcs/2oXMuMaI7KQZV+ybC7JQGuqzMQf
 0Rkx944rQwEadYHfTJdVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DN1wGof/WPs=;nJ1KDJsPeLt79srODva1rkmJKI4
 7lse3jXCi6+hORSlFZ3FSnlF3FBXPgXmDBN5BPROgVhIkrVcSz7+keFYRREDdVN9HhpG9ewoL
 2DBzjm6dRZNijkypsvt+1T3Yx/e8JKHv+XJz1kwmQ0rrjuVw+/k6nPNPMKhKhHwDAajVVJJ/m
 iJ6EL/fkgir9DzN6cL2VgFg0r3D592gpjcx8cIlED+l7y7z2T0K3mmnSjBQ0FNfQt/ZjFyRfS
 2LcViB6rB0Tw5YHuYneUSXDAXsJjhGu27QczqfhCKuOSyE03c/1OeW94ZjbaFkV/ZPRhd7ePf
 7JpTbexWeIem+3+0W0C4SilGskqCyK5PEFEu4PlnsCyUBwhCXoyGHZcvYNJjk1ut8WYnqARgL
 PPHDM0ZS89kyf3khFzCNDG64e7GvtDVRxA34oHyVULX4Er9BHLgl8JMnbc7hpEcPb0f12vUGO
 azyADWcheuk0wPzj1jhNBYbDpwh/CHwXyVcOZ/TCQI+E7NinKAFbydeARoLet8ob4jSb4Nz/h
 amJbqiU5N8f4B6Y5nkGxO1kbUL9AeJ1or10F4E7bB1vudHU1tF4y/nRxATli7rNB8rhnDzA2l
 UfUdcHwRvxQCSqcHA6dlZqYGoVAQlSyLoEfQOG8Rw9VJSKmguGkWz+ngw0y/ZPEhqgpXD8SpA
 hbyzuHXwAc9/ig+C4xCOSCdHsZrFYG0yHW1akuR/tHuJ8HRYlMHj8anZ70K+/hxbPYGPkSnmz
 VqFBbvVVVcOS0gm+Zuey37IgOJcWJEjXQWnUSlL1Bm5bKwX98r49qID8q7x4I0nGH4IvbNo+b
 lRqVOneO7oQlLXwhxqYXmeLNe7dRHXzkMxiXM0afvorbA=

=E2=80=A6
> This patch will add the malloc failure checking
=E2=80=A6

* Please use a corresponding imperative wording for the change description=
.

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?


=E2=80=A6
> +++ b/tools/testing/selftests/kvm/get-reg-list.c
> @@ -66,6 +66,7 @@ static const char *config_name(struct vcpu_reg_list *c=
)
>  		len +=3D strlen(s->name) + 1;
>
>  	c->name =3D malloc(len);
> +	TEST_ASSERT(c->name, "-ENOMEM when allocating config name");
=E2=80=A6

Can =E2=80=9Cerrno=E2=80=9D be relevant for the error message construction=
?

Regards,
Markus

