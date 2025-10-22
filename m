Return-Path: <linux-kselftest+bounces-43745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E937BFAD29
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 10:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3624F4F35AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 08:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012E838DE1;
	Wed, 22 Oct 2025 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=taskera.pl header.i=@taskera.pl header.b="bS3Vk3z2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.taskera.pl (mail.taskera.pl [51.75.73.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72033302151
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.75.73.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120805; cv=none; b=UpBwFwynEPtNMgHJ5mhUitpzpjY9yuw/Uf2q+0IcyliGke/Prb4eK1X8g5OlksWjAheelPv/0fUBe29TIOKAmRGxRwObai6DvrqwxiMh5im0j80RtnTb9e8F121292mkjb/8XZcJeJkOuP4rNm39qDMNNUsMhkvjVMi6sDliCOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120805; c=relaxed/simple;
	bh=LHmroAf0IX0JOjVUiIwqM4s8ghVxxktECxT6AQD+q2c=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=L4HuIoK/sFzRyyND+4g8YQPqV7r7QfUhnHjD2L7u5jdKXN7yGFrWZahWKpiypSII3d+3B+v5VrLTt+OoOaULJh2pVZl5FyhvVh5RN1+DcK7emL06ndB6z7+0dBMq3ZHVTDrRC+0N5Z9AF8Ja+lr9VCrPFbBdiWhUNypj4j8dWqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=taskera.pl; spf=pass smtp.mailfrom=taskera.pl; dkim=pass (2048-bit key) header.d=taskera.pl header.i=@taskera.pl header.b=bS3Vk3z2; arc=none smtp.client-ip=51.75.73.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=taskera.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taskera.pl
Received: by mail.taskera.pl (Postfix, from userid 1002)
	id 28E4025B24; Wed, 22 Oct 2025 10:11:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=taskera.pl; s=mail;
	t=1761120738; bh=LHmroAf0IX0JOjVUiIwqM4s8ghVxxktECxT6AQD+q2c=;
	h=Date:From:To:Subject:From;
	b=bS3Vk3z2aH9iwPlZzasAuY7MyWwB+JMqelEZoSGvx+1DZTzXBL5OWEnN0KyRsTGGT
	 Z7mMvR0LJmVxHD3EOpaHo8gzcJHEtvTjp2dgsnQrrOJwhLmAQNWK+18kndpxgA+UOK
	 dwXENF/MZQDy3tWL3sUP6HleL4vKoonu4qFkOmGp7x/xofb9nFHPMD7qpRqg1hz98e
	 II0i2qmjHUk8v0RctSP+azdqFh2JB7kNiM9Edadi1wIl1z8569ICw/Ysg6kmVCcLPs
	 P9tN8Y4wEIVQUTnWqg/CR74E6ECP+PIt2VhfnwpS5LsjJP8tV5mKxGpUt+IvwyM+kO
	 LNbm9ZpDkIqyA==
Received: by mail.taskera.pl for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 08:11:10 GMT
Message-ID: <20251022084500-0.1.e0.vvoz.0.w0l6bu16ed@taskera.pl>
Date: Wed, 22 Oct 2025 08:11:10 GMT
From: "Eryk Wawrzyn" <eryk.wawrzyn@taskera.pl>
To: <linux-kselftest@vger.kernel.org>
Subject: Zwrot
X-Mailer: mail.taskera.pl
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

kontaktuj=C4=99 si=C4=99 w imieniu kancelarii specjalizuj=C4=85cej si=C4=99=
 w zarz=C4=85dzaniu wierzytelno=C5=9Bciami.

Od lat wspieramy firmy w odzyskiwaniu nale=C5=BCno=C5=9Bci. Prowadzimy ko=
mpleksow=C4=85 obs=C5=82ug=C4=99 na etapach: przeds=C4=85dowym, s=C4=85do=
wym i egzekucyjnym, dostosowuj=C4=85c dzia=C5=82ania do bran=C5=BCy Klien=
ta.

Kiedy mo=C5=BCemy porozmawia=C4=87?


Pozdrawiam
Eryk Wawrzyn

