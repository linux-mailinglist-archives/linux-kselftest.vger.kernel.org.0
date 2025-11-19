Return-Path: <linux-kselftest+bounces-45955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA659C6D9C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 10:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 888324E8F66
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 09:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C800C32F76D;
	Wed, 19 Nov 2025 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=novencio.pl header.i=@novencio.pl header.b="nbSqe0cr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.novencio.pl (mail.novencio.pl [162.19.155.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ED3330B07
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.19.155.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542913; cv=none; b=f9uBAETbChHQ32GmHkMN2c1/SPD8fpn6z+zeCqglbYLIGeSz0qFAAQkT7lxXNNgJeMCYS9WX1NGGfF/L+MtZw0JEpfHSHH97i3nJ3n20p4j5oJ3pAeNK0aDPZedySvgUO8+QMydOgSBHO6v1s0PRSKNp8wF3R6kfNdHZL3zbdoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542913; c=relaxed/simple;
	bh=fIh67CnJs35z4uTVN1yEzBZIG1sWJSjOc8Phu/rB5ug=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=m//rLrdQlIwfK1TwiHCRiBRsr9KGGeHPi6iADXSFjeTsKO1Yq99Ci7PLByhbvSQ8wo+W715gt+11UQXiMzXwUXxRFhvQTSjw6mcN1rXoIjnVAhlPVArOUSb8G7uEIqeso3miYtYVAhqnipikKClLBj4+pIJPmcd5tCK1aaUWLcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=novencio.pl; spf=pass smtp.mailfrom=novencio.pl; dkim=pass (2048-bit key) header.d=novencio.pl header.i=@novencio.pl header.b=nbSqe0cr; arc=none smtp.client-ip=162.19.155.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=novencio.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novencio.pl
Received: by mail.novencio.pl (Postfix, from userid 1002)
	id AFA2A22EC3; Wed, 19 Nov 2025 09:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=novencio.pl; s=mail;
	t=1763542909; bh=fIh67CnJs35z4uTVN1yEzBZIG1sWJSjOc8Phu/rB5ug=;
	h=Date:From:To:Subject:From;
	b=nbSqe0cri2SM0cclH/kW6kQZh5njYUOtFTSQ/1DUk7MFw5LJmXKCNM0MHMSnQ0Bup
	 HX5Cq7SEVqv4aWu8h9JyBn7HJU9/nOd62w6QPT0xAtz/eMPy5+uTG9dqgLUyNgx0Z0
	 kH5trmZYLnogn6IDNVKz8c+3MvdiJnjF26lDoPm7VjDxuIQdqnLOfWoSHcjseNxFdG
	 1fx6QBOfqh7KoTXscI+ZZaEkF/YFWeacF+qnNnVfm3XvG4tOT2Jwp9DoIO5xUVKAAf
	 azlUmTna8QsGkgIS1bS85pHfhcEYFAiJhQsm+y72rGZp9sr9Pc6h+zBWtg8jReyEkb
	 XFrSwz/j84BoQ==
Received: by mail.novencio.pl for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 09:01:03 GMT
Message-ID: <20251119074742-0.1.5y.z4gk.0.8gphi5e6a6@novencio.pl>
Date: Wed, 19 Nov 2025 09:01:03 GMT
From: "Marek Poradecki" <marek.poradecki@novencio.pl>
To: <linux-kselftest@vger.kernel.org>
Subject: =?UTF-8?Q?Wiadomo=C5=9B=C4=87_z_ksi=C4=99gowo=C5=9Bci?=
X-Mailer: mail.novencio.pl
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

pomagamy przedsi=C4=99biorcom wprowadzi=C4=87 model wymiany walut, kt=C3=B3=
ry minimalizuje wahania koszt=C3=B3w przy rozliczeniach mi=C4=99dzynarodo=
wych.

Kiedyv mo=C5=BCemy um=C3=B3wi=C4=87 si=C4=99 na 15-minutow=C4=85 rozmow=C4=
=99, aby zaprezentowa=C4=87, jak taki model m=C3=B3g=C5=82by dzia=C5=82a=C4=
=87 w Pa=C5=84stwa firmie - z gwarancj=C4=85 indywidualnych kurs=C3=B3w i=
 pe=C5=82nym uproszczeniem p=C5=82atno=C5=9Bci? Prosz=C4=99 o propozycj=C4=
=99 dogodnego terminu.


Pozdrawiam
Marek Poradecki

