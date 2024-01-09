Return-Path: <linux-kselftest+bounces-2758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BC7828A17
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 17:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B55286501
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 16:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C433B38FB0;
	Tue,  9 Jan 2024 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="NQSIW+Fx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15427A958;
	Tue,  9 Jan 2024 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4T8c4F2QBSzDqkN;
	Tue,  9 Jan 2024 16:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1704818141; bh=4IwUrh1PT92qWc9c2N0S9TdMX9WHGSfIgwxgb7z8SEY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NQSIW+FxPa7Go5W1SE+eGxNhLxhrtZkBMu1AmdudGhnMHzkrlgSTS+ZEEf+tommyT
	 PKROpIJ3TrpD28IcMB3pyZhLz/xKmAebJGSKmry65IIscz10kC68VAxX9+W/ERVDuv
	 a54nNP6iJWxFzxmVxULFTXkDtIewwFaJ3nMdvBpk=
X-Riseup-User-ID: F0A92EC5488E9A630E9C5503415F03FC1DC31F5466B1F318574148657E4242A3
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4T8c4C0FnwzJn3h;
	Tue,  9 Jan 2024 16:35:38 +0000 (UTC)
Message-ID: <bfcc2166-5655-4733-8252-aaac84b5d6e5@riseup.net>
Date: Tue, 9 Jan 2024 13:35:34 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] Documentation: KUnit: Update the instructions on how
 to test static functions
Content-Language: en-US
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
 Jonathan Corbet <corbet@lwn.net>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240108-kunit-doc-export-v2-1-8f2dd3395fed@riseup.net>
 <CABVgOSn=Wjwy6efMjNSWGVFDfSftRnYPXE5WdsBOzeaFM2FSEQ@mail.gmail.com>
From: Arthur Grillo <arthurgrillo@riseup.net>
In-Reply-To: <CABVgOSn=Wjwy6efMjNSWGVFDfSftRnYPXE5WdsBOzeaFM2FSEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 09/01/24 02:44, David Gow wrote:
> On Tue, 9 Jan 2024 at 04:24, Arthur Grillo <arthurgrillo@riseup.net> wrote:
>>
>> Now that we have the VISIBLE_IF_KUNIT and EXPORT_SYMBOL_IF_KUNIT macros,
>> update the instructions to stop recommending including .c files.
>>
>> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
>> ---
>> Changes in v2:
>> - Fix #if condition
>> - Link to v1: https://lore.kernel.org/r/20240108-kunit-doc-export-v1-1-119368df0d96@riseup.net
>> ---
> 
> Thanks very much: I think we definitely should be recommending
> VISIBLE_IF_KUNIT and EXPORT_SYMBOL_IF_KUNIT more.
> 
> I do wonder, though, whether we should also keep the conditional
> ``#include`` example. There are some tests already using it, and it
> can be more convenient than exporting lots of symbols in some cases. I
> still think we should encourage the
> VISIBLE_IF_KUNIT/EXPORT_SYMBOL_IF_KUNIT features more, but maybe we
> leave the existing documentation there underneath. (e.g.
> "Alternatively, we can conditionally…")

I agree that, in some cases, the include way can be convenient. So, if
it's not discouraged/deprecated, I think it's better to keep the old
way.

I sent this patch because of a comment in a patch that I sent[1]. That
was when I discovered these macros and noticed the absence of
documentation on them.

[1]: https://lore.kernel.org/all/5z66ivuhfrzrnuzt6lwjfm5fuozxlgqsco3qb5rfzyf6mil5ms@2svqtlcncyjj/

~Arthur Grillo

> 
> Otherwise, this looks good, and if people think that we should avoid
> recommending the conditional-#include method (which _is_ ugly), then
> I'm happy to accept this as-is.
> 
> Thoughts?
> 
> -- David

