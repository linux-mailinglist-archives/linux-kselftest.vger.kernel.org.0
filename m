Return-Path: <linux-kselftest+bounces-18386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6080B986F69
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 10:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBC51C21D8B
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 08:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4431A726C;
	Thu, 26 Sep 2024 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzH3qq4J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3CF1A7256;
	Thu, 26 Sep 2024 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340963; cv=none; b=tkVwcn7PumCQrc3w+q0Oxj9HwD3ExvtAOvn9JKgdVqENL9PujdzEqzuvUF3muGhVJlDBnrt3DnUK2MhtClKcY6Ye1tyw3DPRiDcZAcO1oNRDRp8VN/QlLspa/psw6ZXFkM2UYIjbUB/OEdPwKkLNMSMIKmYqZowbEjmt3Umt1WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340963; c=relaxed/simple;
	bh=N/MdxSZRRgXw6t3FZKYPDKlvTtCCPAM4Bq/l5Av5B0Q=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tnrCTXF/jqrBFrHmb1s6KAHTQ1U0mT+kfUiu67EJqN7auixqb4WnJ0jZ1NI90PH+NKhQz+UrCigv1qHrO3Dm7Qn0VXy+89WJW8N7k0jbFUTxE6vHOccsY7PzI/CiZKlv5WshFq5DuXtu0IgKi6oFyiZssP95jvI2LWAozaDqRTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzH3qq4J; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5365c512b00so877098e87.3;
        Thu, 26 Sep 2024 01:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727340960; x=1727945760; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/MdxSZRRgXw6t3FZKYPDKlvTtCCPAM4Bq/l5Av5B0Q=;
        b=VzH3qq4J6UhrWLgoEJy+061mlEkDyf+60fk4+psrb2zsYRr7+Ik0/jleeJnYpwwTLh
         1yTVrvlG3Mxl1P+VMfBr4krYO7VMFrL+Pxf6sPSdYeasaCukVTLcqcdmJs4jy6AXyBCW
         H1JuubBJRvI8WP34ME/trQXJ2Xcqm/598E4ASh2Q1YreFaBddHYBcz7nD9J8qwtazXhU
         yqQdUU0Fv9jamXdL541TzGiT5rlHjUrnZz7Rl9J0ZdZSuktXg63nj7LHfAiosIt71wkI
         XYEPkLjEFe+AruqBjpgi9x8pupvgfmWLkJAkjEe4CpHSusATN8BLfLL8JIacdwcha0+0
         YxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727340960; x=1727945760;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N/MdxSZRRgXw6t3FZKYPDKlvTtCCPAM4Bq/l5Av5B0Q=;
        b=elVbZc9Fq7RjLDxQMlccj2weUE3bksBRF5oIBVP3r9KFd4QSQhAdjCa7kqFCfvW1qB
         vd5Pn2xdcsne/BWPeGZ1p/tBH6oyhHN5rm3SKemd+uI7HtwsP9i0yRQ7lo+CpjUiliRE
         KqbucLJbS3oynLspFtyjQWbu2bsTfcvRozvfl01rim1rPFN3/ouW9LcAP81f44ewleVS
         wI+7oPMTRJ0aGAbDo6KuuZLZtneN7PRqaHocGwbQ0EpDlIEcGr+ulRKXMGERh1YVTJLS
         YQOrqXN043njMXy4aoYtahzpqVZe8icb7ikSopk+Xdtu2UsmlJMH93uHijKrQonf1djd
         kjdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKhj1i2SXAcflFtVpAKqWFtBPeUfBrPDn/ZhlCu2+DM260AjhqTiTJQizPKqwCiEk9pOPzcScLbDtr@vger.kernel.org, AJvYcCVdSWFCTSdV8GBzmKngJEcbfNCsWvDOBtJTwdpQcpNdJRzSJqJ/nr/5OmN4fsemP/RNalyXyPVBi3pKc1eC@vger.kernel.org, AJvYcCW4x7TJibjXQWPaJqKP8QbJkdzbrX9SR17yyQQxaEDRUivz7EB0L8uvIQj4KG/LRa5OmW8=@vger.kernel.org, AJvYcCWh6a2ViwT43xpy0invLvDdOqHbjPEEevnW4n88rqmdyP6VrqRlwaHAM8wQz6EqaaLZ3F6xIDnGwuQ=@vger.kernel.org, AJvYcCWqTUNxlfN9WCa8pHE6ngboze6zKXaTG0rwOEz2xf6jhIHltbeEKVJuu/qa8RUyyryQHS0DlRjjqvUyKR7cOuWW@vger.kernel.org
X-Gm-Message-State: AOJu0YzrAftNrIBVkGaMDFtLpASnRoqAl8FmZCzarXeU+IfSca2G6RMU
	t5yMJQzG5lXh6iZgej5KpFfqYkyjSsFq/w1lHMX3hBwUBBIuZqCm
X-Google-Smtp-Source: AGHT+IHhrS4QXSILHTgsdhqbb5hO7tNCXVRYEYz1SUiLl+OS5YyvI4GPgvxdfXnxwqpZqVHN5fGjFQ==
X-Received: by 2002:a05:6512:33cc:b0:536:55cc:9641 with SMTP id 2adb3069b0e04-53877538012mr3938709e87.16.1727340959984;
        Thu, 26 Sep 2024 01:55:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:5d29:f42d:438a:71d4:3b8a:6ddf? ([2001:b07:5d29:f42d:438a:71d4:3b8a:6ddf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4c52aesm2878777a12.59.2024.09.26.01.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 01:55:59 -0700 (PDT)
Message-ID: <15f38d57ca10606e444ca422f802e0961908f02f.camel@gmail.com>
Subject: Re: [PATCH v4 1/6] firmware/psci: Add definitions for PSCI v1.3
 specification
From: Francesco Lavra <francescolavra.fl@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini
 <pbonzini@redhat.com>,  Jonathan Corbet <corbet@lwn.net>, Marc Zyngier
 <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, James Morse
 <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui
 Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Shuah Khan
 <shuah@kernel.org>, David Woodhouse <dwmw@amazon.co.uk>,
 kvm@vger.kernel.org,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev,  linux-pm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Thu, 26 Sep 2024 10:55:57 +0200
In-Reply-To: <20240924160512.4138879-1-dwmw2@infradead.org>
References: <20240924160512.4138879-1-dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-24 at 17:05 +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
>=20
> The v1.3 PSCI spec (https://developer.arm.com/documentation/den0022)
> adds
> SYSTEM_OFF2, CLEAN_INV_MEMREGION and CLEAN_INV_MEMREGION_ATTRIBUTES
> functions. Add definitions for them and their parameters, along with
> the
> new TIMEOUT, RATE_LIMITED and BUSY error values.

The CLEAN_INV_MEMREGION and CLEAN_INV_MEMREGION_ATTRIBUTES
functions were added in the alpha release of the spec but have been
dropped in the beta release, and are not included in the final spec. So
IMO the uapi header file should not contain these definitions.
The same goes for the TIMEOUT, RATE_LIMITED and BUSY error values.

