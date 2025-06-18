Return-Path: <linux-kselftest+bounces-35314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4219CADF4FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 19:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66033BB97E
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 17:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B872FCFF2;
	Wed, 18 Jun 2025 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUAq9iNP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B9F2F4303;
	Wed, 18 Jun 2025 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268667; cv=none; b=fThs+/Ha2/IylvqDfjW1IO2UBgSEfDsvHBwVPYsaa9t7FEVcSBYW9JjkYvzDPFWwOl14V84FQ4hklaMlsDFp6+/rL1o3Zhg63WCQDv/IAdEjnBpA96UJZuV7H0aQL32NYRezyEkwlBoRDUOf5agrj9Zx4kQy+o2kZq4GGnaG51I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268667; c=relaxed/simple;
	bh=J3emUuMS2sP+fVu514LS2iE2SxNv9+tMuhs+QvDPSzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GXNcmbXeA9TGpEoLQfF54LLuBWy/qB2nUgEV7lwDC55u/FJN+61CfKw9pwIgpLcRxMUgh4bgi1pis+qBs1t2GFbegz7MRfPNTwuti+VI4SoY5F0HiXMfD4Xycc0+SiYsxk/cSSvT2JN9tzpUiCGGGbHAokDccGKrtCs62i/iye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUAq9iNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86DBC4CEE7;
	Wed, 18 Jun 2025 17:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750268667;
	bh=J3emUuMS2sP+fVu514LS2iE2SxNv9+tMuhs+QvDPSzI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RUAq9iNPBOvtBZ6kjZvzyDf3azz9pNEJrtV802b0Y+7oFzo46N+wIUNg/gUWuVYNv
	 0zTcE5vpf09zObs3MB5J0eo6OqIPMHS2hzU8M6zIhoCiDCJqMS64GU9M2cvpKemyE6
	 2cQfwsDPfUcwxAICjnnffdcOSRG7xmqYXPDVZgl7Mo2lPxi8/0fvmHvNSPg0dSTHSu
	 uRRXbMuBmGgK+dW6FH4AGtLJYIu9K/KZlCp0EFVJQAiTuHA+H5PyIBduZh3y/5F0hn
	 36XXhmH+5bXNB865NML1afkhVnOFmu9mD/2qEx7ja97HEAcU+6YLo11U1bNdFcUrRV
	 sQv648YcGy5eQ==
Message-ID: <ccbc2a76-20fe-4f70-b69b-9d05b59f24b8@kernel.org>
Date: Wed, 18 Jun 2025 19:44:14 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/6] rust: enable `clippy::ptr_as_ptr` lint
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Tamir Duberstein <tamird@gmail.com>,
 Christian Brauner <brauner@kernel.org>, David Gow <davidgow@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Benno Lossin <lossin@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Breno Leitao
 <leitao@debian.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org,
 linux-block@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, linux-mm@kvack.org,
 linux-pm@vger.kernel.org, nouveau@lists.freedesktop.org
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
 <20250615-ptr-as-ptr-v12-1-f43b024581e8@gmail.com>
 <CAJ-ks9=6RSaLmNmDBv-TzJfGF8WzEi9Vd-s=1wyqBcF7_f7qQQ@mail.gmail.com>
 <CANiq72kgnKH2SSp76EdPeysExBWasqhTyf1JyReR65g6FMsidA@mail.gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <CANiq72kgnKH2SSp76EdPeysExBWasqhTyf1JyReR65g6FMsidA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/18/25 6:45 PM, Miguel Ojeda wrote:
> On Wed, Jun 18, 2025 at 3:54 PM Tamir Duberstein <tamird@gmail.com> wrote:
>>
>> @Andreas Hindborg could you please have a look for configfs?
>>
>> @Rafael J. Wysocki @Viresh Kumar could you please have a look for cpufreq?
> 
> Thanks Tamir.
> 
> Christian, Danilo, David, Greg, Tejun: It would also be nice to get
> Acked-by's for your bits. Thanks!

For the whole series and the bits I maintain:

Acked-by: Danilo Krummrich <dakr@kernel.org>

--

Independent from that, won't this potentially leave us with a lot of warnings
from code that goes through other trees in the upcoming merge window? How do we
deal with that?

