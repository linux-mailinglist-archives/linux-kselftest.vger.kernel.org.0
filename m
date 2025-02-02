Return-Path: <linux-kselftest+bounces-25523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E33CA24CB5
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Feb 2025 07:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E945618841D5
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Feb 2025 06:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6A441C6E;
	Sun,  2 Feb 2025 06:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HYpdriww"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF7D35958
	for <linux-kselftest@vger.kernel.org>; Sun,  2 Feb 2025 06:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738477354; cv=none; b=K0nR3Zf0TaCVtmqhhqOVmssCNWFJNYXtuCZnAhFKG4Wr/k34V9eUbFxZQirA5hAZxy0w7M4QVuvhq0HnSp9ZXxc7InsJVu6u4dCIBainmrFUhDhofwJHRNlsyvzNP6wnAsKlYO9slMxZ71GcrePshywdRVfzGI8QxrOC5GyUFRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738477354; c=relaxed/simple;
	bh=T9jjr5yNJujIiKaW63A2Y58cBrapCoUrLyJT07flpW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUOyj8IFuyNq5SeU+B9R1lcIrs9Ytv6IT9sT2mbGCX9G1UA4EigfxLU1IcuZ+zQUPWrivzKeHPfxPcmxpMrzlSHOHp5B2yv7Tc42FDKn2xJ2t2dlyrm2Fr57gMvRbueXOPgjCd7Nj/39JWQkE9VyjLM7lnFjWpVnL8ZJHimbbJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HYpdriww; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1b7ae999-c081-45c8-a914-f215c829d57e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738477335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VX6SmOLzx1meiUouVUG4j5d233T4zSo6WdF6Bre80cU=;
	b=HYpdriwwjDJVozqO86kstPzP/UohWn8OJaVLab46/fI1sZkPvasOyAvX5XB6vp04m2j3h+
	knbMs7p6IPCxJVv6QOcCwXo+4HIRzGoOpF4y9vUlLP6oHvgDayh39EFRq759Vau5mTNm1c
	9Xbw61w4kJzmKpdV0D6Ek37gw9SuVMc=
Date: Sat, 1 Feb 2025 22:22:07 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests: bpf: Support dynamic linking LLVM if static
 not available
Content-Language: en-GB
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: shuah@kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 nathan@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <872b64e93de9a6cd6a7a10e6a5c5e7893704f743.1738276344.git.dxu@dxuuu.xyz>
 <2d4773f9-c3a4-4512-9c5c-92f841c326f5@linux.dev>
 <rgcdc7zokwfoars7c2pzredogea3rvolbnzkvko7q6lbgjnvfx@oeyzed5zalpb>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <rgcdc7zokwfoars7c2pzredogea3rvolbnzkvko7q6lbgjnvfx@oeyzed5zalpb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 2/1/25 12:23 AM, Daniel Xu wrote:
> Hi Yonghong,
>
> On Thu, Jan 30, 2025 at 10:28:11PM -0800, Yonghong Song wrote:
>>
>>
>> On 1/30/25 2:33 PM, Daniel Xu wrote:
>>> Since 67ab80a01886 ("selftests/bpf: Prefer static linking for LLVM
>>> libraries"), only statically linking test_progs is supported. However,
>>> some distros only provide a dynamically linkable LLVM.
>>>
>>> This commit adds a fallback for dynamically linking LLVM if static
>>> linking is not available. If both options are available, static linking
>>> is chosen.
>>>
>>> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
>>> ---
>>>    tools/testing/selftests/bpf/Makefile | 11 ++++++++---
>>>    1 file changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>>> index 6722080b2107..da514030a153 100644
>>> --- a/tools/testing/selftests/bpf/Makefile
>>> +++ b/tools/testing/selftests/bpf/Makefile
>>> @@ -184,9 +184,14 @@ ifeq ($(feature-llvm),1)
>>>      LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
>>>      # both llvm-config and lib.mk add -D_GNU_SOURCE, which ends up as conflict
>>>      LLVM_CFLAGS  += $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --cflags))
>>> -  LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-static --libs $(LLVM_CONFIG_LIB_COMPONENTS))
>>> -  LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-static --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
>>> -  LLVM_LDLIBS  += -lstdc++
>>> +  # Prefer linking statically if it's available, otherwise fallback to shared
>>> +  ifeq ($(shell $(LLVM_CONFIG) --link-static --libs &> /dev/null && echo static),static)
>>> +    LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-static --libs $(LLVM_CONFIG_LIB_COMPONENTS))
>>> +    LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-static --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
>>> +    LLVM_LDLIBS  += -lstdc++
>>> +  else
>>> +    LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-shared --libs $(LLVM_CONFIG_LIB_COMPONENTS))
>>> +  endif
>>>      LLVM_LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
>>>    endif
>> Although your change looks good, but maybe you can look at bpftool Makefile?
>>
>>    # If LLVM is available, use it for JIT disassembly
>>    CFLAGS  += -DHAVE_LLVM_SUPPORT
>>    LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
>>    # llvm-config always adds -D_GNU_SOURCE, however, it may already be in CFLAGS
>>    # (e.g. when bpftool build is called from selftests build as selftests
>>    # Makefile includes lib.mk which sets -D_GNU_SOURCE) which would cause
>>    # compilation error due to redefinition. Let's filter it out here.
>>    CFLAGS  += $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --cflags))
>>    LIBS    += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
>>    ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
>>      LIBS += $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
>>      LIBS += -lstdc++
>>    endif
>>    LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
>>
>> It would be great if the selftests shared library handling to be the same as bpftool's.
> So bpftool is both an internally consumed (from selftests) dependency as
> well as a tool packaged up by distros. For the latter case, distros
> prefer dynamic linking.

I hacked llvm to have both static and shared libraries installed and indeed
`llvm-config --shared-mode` prefers shared mode.

So yes, your existing change looks good. Thanks.

>
> So unfortunately, I think these probably need to be defined separately.
> The code looks similar but the use cases are different.
>
> Thanks,
> Daniel


