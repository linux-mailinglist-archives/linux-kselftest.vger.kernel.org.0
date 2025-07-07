Return-Path: <linux-kselftest+bounces-36704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0060DAFB750
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 17:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA923BDAA3
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C9C2BCF46;
	Mon,  7 Jul 2025 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fq925sbS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29192DEA6E;
	Mon,  7 Jul 2025 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902037; cv=none; b=I7Y4npO5C+nwBndPfmMwoZDTTr7gpXcq8BGAFlRJu+TbaQqqNSqvwautgGSlEn3PVDR6eqahdcuRXgC45B1hpaWwiyWlTecrmDjOW6aQTHmQaqmdE6VUQ2EKMpMAXw6zAXOl13G87nF4wH/hfMHFn9G9HJJGuRptfo1LITPlz0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902037; c=relaxed/simple;
	bh=XTTqaEp0xafiyS7dlnHkY4aFyy248oxQcyqSoJYTI7Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pOHsH9ESadS+WBd8Ni+L0DEE35z9lKvh3yPLSLETefeqxSIE/4943C/YLEji8Q1GejAQZVtTK5NutMxqTljTZWJ0nxofqIftkqyKwJxDtNbN8PhNiUrpoDnxV/asF3nyJwRz5X154CK4zCvXWlbVTuCiZOGr4DxS3cpscaawxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fq925sbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00D5C4CEF4;
	Mon,  7 Jul 2025 15:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751902034;
	bh=XTTqaEp0xafiyS7dlnHkY4aFyy248oxQcyqSoJYTI7Q=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Fq925sbSf3Hrv6F+NdFa+r85sG3BXr/dwNpwGKjYJwf0VwwAStOMFK5FSy8V6unl/
	 oPJo+O2SPVpwcNxAPeOBlI4YOnpQgfpTq+dEW2x+69aiLWeIFMay+SoYMO8y5gyMAX
	 WTE7SMgVWMSU0C5uVdATRjQMZ2eY73UOY1mD3Zw17YyKEbPp1x94AfUZsIZOjWnsKg
	 tia1KlS49e9ZKOmkee0PkxqbP+WEsIGIqjksawVXivlEJOJjvq4xcyWog0w2XrkdW2
	 yWedYXv3seWrwBhcCO/cL8gK8yiToTGYLH+xLt/PQg5JMU4DH6m/KKbecml8V4ZU6S
	 Kkf62LDouTm/Q==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Jul 2025 17:27:08 +0200
Message-Id: <DB5XFT4E3CBH.1LOP1V3IMNDXK@kernel.org>
Cc: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <rafael@kernel.org>,
 <viresh.kumar@linaro.org>, <gregkh@linuxfoundation.org>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <davidgow@google.com>, <nm@ti.com>
Subject: Re: [PATCH v4 2/6] rust: switch to `#[expect(...)]` in init and
 kunit
From: "Benno Lossin" <lossin@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250701053557.20859-1-work@onurozkan.dev>
 <20250701053557.20859-3-work@onurozkan.dev>
 <DB1SKFOR9W3I.1MBT3C6FGBWH7@kernel.org>
 <CANiq72kqmMTLQaE03WEFzi2UN=Sk31TLDPi3S5UuuA5bHj3O9g@mail.gmail.com>
In-Reply-To: <CANiq72kqmMTLQaE03WEFzi2UN=Sk31TLDPi3S5UuuA5bHj3O9g@mail.gmail.com>

On Mon Jul 7, 2025 at 3:02 PM CEST, Miguel Ojeda wrote:
> On Wed, Jul 2, 2025 at 8:47=E2=80=AFPM Benno Lossin <lossin@kernel.org> w=
rote:
>>
>> @Miguel are you going to pick this eventually, or do you think it should
>> have a new version with the right splitting?
>
> I guess I could take it since the series can only introduce build
> failures at worst.
>
> However, I thought we were going to do the proper split (as
> independent patches, too) and then let each maintainer pick each on
> their own pace.

I also think it's better to split it correctly.

---
Cheers,
Benno

