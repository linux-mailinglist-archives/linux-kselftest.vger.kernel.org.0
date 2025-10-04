Return-Path: <linux-kselftest+bounces-42751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14037BB88DB
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 05:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC20E4E34DF
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 03:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E818D1419A9;
	Sat,  4 Oct 2025 03:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PsA3FS3c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F5E1A9F90;
	Sat,  4 Oct 2025 03:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759547969; cv=none; b=X4oWpp2VvCWprXQCwxk96FqcMD/DDHLCwjhhDLG+Er+7EACDvBmnKCEjnNi0DSQRxQaNPy37j8B+mNSUy1AWk2Stf6UoZZQVyQHvWnsj1XMyKFjmNZKCa3FwdQqgcIwFBS84W3z8jf75l2FMiZDVJLQ9nlmAxjZGCoPtdITSLDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759547969; c=relaxed/simple;
	bh=lcA3ei/1g1NUuiXoe+MFQ5C0lbbnCbV0iTNJIOEUjvE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MegzagOW9SAMgOKPfZ12Gmo6x1WBQnO0puFLcGIzfms7f5QlzupIE7/VGX9iIWc8KPyJzB8ac4nGqcW6vg6vuxhoKcXh1o4TUfuKQavlS7znNEfbRWTE2HQJe3aHGnyftpIop+JjudDyQmulwqN8Jw8TTaU2IQb7xNWqaAPqu2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PsA3FS3c; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c8b609ef-2d46-46b3-89ac-5ae84122cb93@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759547965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jHdcb3Anj/Cb6FBjokLh/jDD4Onb5Um4LvaFZMJsSPU=;
	b=PsA3FS3cwr3vZdNo9yDQIxPqw3dYCWv/KfXwvM26U6OfENbdLCjGJUFx/2+ahYSomEXTZS
	9UloR5fCPULk0Crzy0Qz+L1814Dvu68bEEjFkvcmGlLg4m9xTE+GTyevB7DUWLKTkyGiGG
	glKLer6f8wwNptIo5NKuwwQFVijpvqA=
Date: Fri, 3 Oct 2025 20:19:17 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] selftests/bpf: fix implicit-function-declaration
 errors
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Eduard Zingerman <eddyz87@gmail.com>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, alan.maguire@oracle.com
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
References: <20251003-bpf-sft-fix-build-err-6-18-v1-1-2a71170861ef@kernel.org>
 <d108d59be611a63c73303347d07fe0ba5f2b74b7.camel@gmail.com>
 <43eebdf1-5ea9-4991-88c3-f0780d7c42c6@linux.dev>
Content-Language: en-US
In-Reply-To: <43eebdf1-5ea9-4991-88c3-f0780d7c42c6@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/3/25 8:08 PM, Ihor Solodrai wrote:
> 
> 
> On 10/3/25 4:37 PM, Eduard Zingerman wrote:
>> On Fri, 2025-10-03 at 17:24 +0200, Matthieu Baerts (NGI0) wrote:
>> [...]
>>
>> Alan, Ihor, does this sound familiar?
> 
> This is most likely the issue addressed in this patch:
> https://lore.kernel.org/dwarves/f7553b3f-5827-4f50-81a9-9bd0802734b9@linux.dev/
> 
> There wasn't a new pahole release with it yet.

Not the best link, sorry. That patch wasn't picked up by lore, only
discussion remains.

Here is the commit pushed to pahole/next:
https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=next&id=09c1e9c924da02dc02bba0a3e59490e64449df96



