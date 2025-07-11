Return-Path: <linux-kselftest+bounces-37102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F121B01D55
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 15:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C13F3BDDC6
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 13:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5102D3226;
	Fri, 11 Jul 2025 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGw/7bQ1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06BD70810;
	Fri, 11 Jul 2025 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240271; cv=none; b=S6uYlxSn6V5U6JumATeF5SqnwxRc8dAxUx7flOWyr52TWD0m5qT663MxWfud+WcTGzSRH+AS/8/7gZdUsFfxZhLaK4zRZfSuSGIMEJxUDJmC2YTC8c5aKXdINbQR2say9DzGpfAJ1eJlepOGnmzt84oP2E2GfNCo/D+CIC3+0SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240271; c=relaxed/simple;
	bh=+4NNW2YqeuzxeOwxdYm+u0ttWrOey3Yi9xQrrEUAR1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asJmCmdocvA0a26k9VpmdhrX0mSBNQ1faKRvOcoRf2GJ8gztCXR1x/wJGXnv7Q3hDRGt51jmI+gqEaNrrbzDXgqc9c/Pe9aXl11HnuHFiTAbdqeogvAR8QMGG6bA/7p2eyVqV+0LgTN4jL0cC+I34PBo8KSDfH1kEMvXkW/AX3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGw/7bQ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F53C4CEF6;
	Fri, 11 Jul 2025 13:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752240271;
	bh=+4NNW2YqeuzxeOwxdYm+u0ttWrOey3Yi9xQrrEUAR1I=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fGw/7bQ18cGvpwIqKknl7SqZbYd5xbiZdDPXh5uia3qg3lz+l58wPI0lN5bPUIER0
	 HTiGNXENDNLx+9TQpB0pqb8D+lk01koQNAPcDRekPUhJAeTYgKfb0xuCG1T2AsIAql
	 0hqw8XWtuq7dBVH0aP9P3xizCRsBV4iOe6Juo5fgsv4DTlWrKR1Yifax2p+yXe6gl2
	 2ssix5Aj7pNKEf5tnhDFmiAXjTvrej8slFubOyS76xv4MtZ3CmCbOq42zKASO7HYVm
	 z6DxxEAZSlZZSyaJvlW+rMilHWgb5xBZHGYs5cD0jIBhS0EhrqMXYwl98GOdLf53Eb
	 vtmf94RIOyUJQ==
Message-ID: <7ccb0a97-fc20-4493-8187-48ecfd07bac2@kernel.org>
Date: Fri, 11 Jul 2025 15:24:25 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 2/3] module: make structure definitions always visible
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20250612-kunit-ifdef-modules-v1-0-fdccd42dcff8@linutronix.de>
 <20250612-kunit-ifdef-modules-v1-2-fdccd42dcff8@linutronix.de>
 <a9eade27-9b77-431f-b7c8-24c3fb891673@kernel.org>
 <20250711081047-ea2c1e83-1b87-4331-acad-cbbfe6be67d8@linutronix.de>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250711081047-ea2c1e83-1b87-4331-acad-cbbfe6be67d8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/07/2025 08.29, Thomas WeiÃschuh wrote:
> On Mon, Jul 07, 2025 at 09:11:05PM +0200, Daniel Gomez wrote:
>> On 12/06/2025 16.53, Thomas WeiÃschuh wrote:
>>> To write code that works with both CONFIG_MODULES=y and CONFIG_MODULES=n
>>> it is convenient to use "if (IS_ENABLED(CONFIG_MODULES))" over raw #ifdef.
>>> The code will still fully typechecked but the unreachable parts are
>>> discarded by the compiler. This prevents accidental breakage when a certain
>>> kconfig combination was not specifically tested by the developer.
>>> This pattern is already supported to some extend by module.h defining
>>> empty stub functions if CONFIG_MODULES=n.
>>> However some users of module.h work on the structured defined by module.h.
>>>
>>> Therefore these structure definitions need to be visible, too.
>>
>> We are missing here which structures are needed. + we are making more things
>> visible than what we actually need.
>>
>>>
>>> Many structure members are still gated by specific configuration settings.
>>> The assumption for those is that the code using them will be gated behind
>>> the same configuration setting anyways.
>>
>> I think code and kconfig need to reflect the actual dependencies. For example,
>> if CONFIG_LIVEPATCH depends on CONFIG_MODULES, we need to specify that in
>> Kconfig with depends on, as well as keep the code gated by these 2 configs with
>> ifdef/IS_ENABLED.
> 
> If CONFIG_LIVEPATCH depends on CONFIG_MODULES in kconfig then
> IS_ENABLED(CONFIG_LIVEPATCH) will depend on CONFIG_MODULES automatically.
> There is no need for another explicit IS_ENABLED(CONFIG_MODULES).

This makes sense to me. My assessment before to reflect in code what we have in
kconfig does not scale. Thanks.

> 
>>>
>>> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>>> ---
>>>  include/linux/module.h | 23 ++++++++++++-----------
>>>  1 file changed, 12 insertions(+), 11 deletions(-)

{...}

>>
>> After the patch, mod_tree_node is not needed externally.
> 
> Can you explain what you mean with "not needed externally"?
> 'struct mod_tree_node' is only ever used by core module code.
> It is only public because it is embedded in the public 'struct module'

But only when MODULES_TREE_LOOKUP is enabled. Now, all kernels (regardless of
that config) will define mod_tree_node data structure.

However, Petr already stated that is harmless to do so. I was trying here to
not be useless.

With that, changes look good to me:

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>

