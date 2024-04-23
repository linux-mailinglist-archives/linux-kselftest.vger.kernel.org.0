Return-Path: <linux-kselftest+bounces-8678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A39F8AE082
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 11:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25CAF282230
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 09:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26555647F;
	Tue, 23 Apr 2024 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="rxrni5g7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B7255C3A;
	Tue, 23 Apr 2024 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862925; cv=none; b=JhZnrIQd52Alun98AtJO8ms3YwzhLSaPOXYFtIJLBTmMDlIsh3DPixYmpfsYELhZloCvnFpqOBIt4KA5dzwRZZ03Q+xN0H0SxhD/WBONz/+iujpAB98plfeT3mnxt77wYCzr5qrlavmVjw1d3PxVVdxnOukOWF5+xX4KybnvmuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862925; c=relaxed/simple;
	bh=S+8tLFz8PqdpmPk9GLNuV9GGLXz9ZgJvD9u5g+3nVz4=;
	h=Message-ID:Date:MIME-Version:To:References:Subject:From:Cc:
	 In-Reply-To:Content-Type; b=DOQJ8W39Girs7s6bXbH+dDMZW6tYlvOWAxykjENJFFiobu6KlHNbieYdqNNNgZEBj2oZnmnacWFyvruMokMxeQx5suYRpouoqttbr86+jj7NwBLeS61lWf7+QtUb0bt9fjlJFmFccjip8Ha91JT2YQitwONNjFdQA3qQNsWArtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=rxrni5g7; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713862869; x=1714467669; i=markus.elfring@web.de;
	bh=S+8tLFz8PqdpmPk9GLNuV9GGLXz9ZgJvD9u5g+3nVz4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:References:
	 Subject:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rxrni5g7R2mjSxucArVegFiiAHh9HEn6QCeJ62wj1p/Qa1zUkuivKGAkipySQeXb
	 zuFsp28xrw0yeVE1GPb70h3ish/l18kzD0x7ndBqn94ik9gLD8BL17g0tQOgeMT+9
	 jFPP3I416qtO7oHHloMIU8olBTLX1KbanSJCYIijS6Uaf4tOhOyYzqiVtBwxWS9hq
	 tKL8IwIjCegbLGivfzB+927Z/0iJFu3PC4gk2sCrxUcYW0b3CwdMrf/yIQRDVUJDl
	 +u6XHd7/8OdkA/MsjlwKyxzyNapMbEZabl3OMiic91/dyocjrm6IywAGvkeDyydfN
	 KDTBtdVWkYcRO3W0HA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIc7N-1rtN8S2RBl-000hsm; Tue, 23
 Apr 2024 11:01:09 +0200
Message-ID: <75cb62a7-d77b-47c4-9b49-9e1ef1a5de1a@web.de>
Date: Tue, 23 Apr 2024 11:00:52 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kunwu Chan <chentao@kylinos.cn>, linux-kselftest@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>
References: <20240423082102.2018886-1-chentao@kylinos.cn>
Subject: Re: [PATCH] kselftest: arm64: Add a null pointer check
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <kunwu.chan@hotmail.com>
In-Reply-To: <20240423082102.2018886-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TSDQS3DL0hGaVNjPgU+obuZkEZoMMiyjQaBK1gsN+be2j5u+Q9O
 U3NR194Pvh2OhhxfIOdUC8WYI8voMGR5sQlTeuL1ThUG3ED9O6gvPtK0XdzkFyhmPnz0EBX
 EStVyQS6KCN1/fk5IyMv6/FLrW9KJ5g36O0dLZcqqFsz4yZnTvQmsxFttXB7PX4ZIwPwGNX
 /YsmOyVUeoHUlQJzgOMaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:u351e5//zzU=;/xRPCb3L/L16rXzLLrZwlNZBJpv
 GwbW2AeYe9WWa7sreBvHTYQIh5NRYb6VjGdlkmreYAoriLmTDrJNWaCl5Eln4uuPHditeB5Rn
 MwGfnEgeTP0z1OpdbfhQRhxfzK5CzlbiAgUlvtWtD1P723GNx/4lLj6FufNDZ0p9nLmSshVmK
 JJFM6hUgdAgiEiDo7zcladJvCdfetpvZhq+L8XzS1WpcFUrSfJ+qS2zEjRYyC4VX/Fe/c4zg7
 0g4ouGnkqNQfl28OUYwGFjo9dRGtGUHsbKhKG/AfvV2Nmrobs6PFzZixYR737vL+q6r7qPcQg
 uR9W8XpKXB0shb4tqKF8XCMnUGPiL8Hgi6Y3XcW6T4nHHXg0TIUDLWv0DmK8rJ+VCF6Fjv5uF
 zvEzcbZhGT+k618t9YIMlFkqQeQVYyGksuyLXpQ5NPvvOxXrlWPpR+jwoRsg7ZbmR0uj5/bS2
 84nBl/v6n7DiJGq0hV9rpkoSVDgaDgeP1Y8ioX5uffAU575w2KZ7V+4qgQuH+wX9Ofq/x0d/V
 MaVzairF4Up3VoQT8tOvS4IVt5Jy51tYLvp5wF37GJ1u4GyYh6MtP52XSftAnMbwyKjYKlxWH
 PAt7B6UFFJH3EdZF40XLg6TKRTgt3Ip7QwCcUyn5RrVqpMYhs0vN+a709P0IW4Qr21g0SHD0e
 AIW0KL0r/P987qGI5AQ4+V0YTCC8glJL6Lb2+lCkl5QIB3+eOYhUoZpzMW6PH3UjEu30ciubq
 K8YKvETi2LcMFPBlRd9SZQxtuFqusjOCEIol4UAUFB0YpA7ChQlBmkrwK1eif4430KyuPmw6I
 Fn+y9mrOMC3Cz9qfCNEMwwP7Ms9LCjqMD04ddJkWXTq2g=

=E2=80=A6
> This patch will add the malloc failure checking
=E2=80=A6

* Please use a corresponding imperative wording for the change description=
.

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?


Regards,
Markus

