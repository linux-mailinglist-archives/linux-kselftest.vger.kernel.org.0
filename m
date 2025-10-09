Return-Path: <linux-kselftest+bounces-42914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3689EBC71F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 09 Oct 2025 03:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 188BD4E5676
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Oct 2025 01:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAAE17A2EB;
	Thu,  9 Oct 2025 01:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="K48ecD6u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CDC154BE2;
	Thu,  9 Oct 2025 01:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759973943; cv=none; b=jKeZd4PxKGSh/1u8N996vm8wGuf7MtldTG7oZVnBuiBu4MQVo3GGWVsey8zvOafxPu7Bjkjg2zRsLeQLsgdr75DDntlLDYYaM4KBusaQ77wPmw4nk0fzZpYtMv6EPO1XKnJhTVkHp7KXpRPlvWpvuFaY90z3bL6aRzGmFuUY0e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759973943; c=relaxed/simple;
	bh=apOQAZW6AWoaMslvlgsDKl/iISVpw2hHZmBdcUhzQsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HaIZe5DqN1ysG8CtLfFwHF+ZONTUzKl4+Yi28b6i9K44SZxx4Sa0/Mejr6l+JDS7LA819GoRPGhbNMOK1vXPAJUxPBJvZ9VL3KUamn/Ra2SXDb2AwqP7BVU2D+iuVcNVf9APQ2Ag/jOCHyqlThNMBX8VVLuzq4jRqJx2kZkPJFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=K48ecD6u; arc=none smtp.client-ip=43.163.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1759973931;
	bh=tjd5N9A70oCjhg5VLw+85IbzLuTB3dBZOhfwR1b228Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K48ecD6uLVMldpdkxPx2fqQelrOA1q333YT00i1oQXbsRletydUXFCHlhZx+oSdTn
	 teKkX08s4bl3Jo+ty+GzVnFkbG2B+diXQSkIIRV5QBFnKdBcG9hz5axJCL3Cnb2loh
	 2hBLz7AwZEqZ2fuT/LYG+8QX2wr/0OwaqqsSQd0o=
Received: from [10.56.52.9] ([39.156.73.10])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 9B0016B4; Thu, 09 Oct 2025 09:38:48 +0800
X-QQ-mid: xmsmtpt1759973928tgk1z43m2
Message-ID: <tencent_339E2EE755D05F67478310C70DD6843AB209@qq.com>
X-QQ-XMAILINFO: No7DFzN00JnRbjY0trYmAOGRc/Y1F6YVrc2aqn/UnjYvdTuaEA+Beo5vlbPBCg
	 S94YFJ8tT2hdcmZWF+PF8CJLnVEgUaEy9xO7MN/0zGsWJ2AKzEJyB2yIppeCfY3XItCtlhJnv3oF
	 jJnGPDSy6WlJkHx2Cb9TFRI1HhpaxlXWMs6B828RqQlC+TCsgeEowCraE3SvPM/xsZ4hpWldhr70
	 uKHCwY5Wjbks2YZk8FzM7u83ITbWydy2jUF14zZlOqfRq2+gXnRguCDkIQqGNZyn3lE8NXifZF6x
	 LPZ99QqQShaFAMUPRFYZ89ykJpxeFH7CrdLUuLBDuaE3fhwMHmcGDqgCqCOchYvLsQdbV6jGwTYR
	 xSrDF+3hz03inf50G/tYuOzwGBSA39CP9M5W//o7cGueAIKFsUKwAdb4bfbphCuLKXyzfNChqeE7
	 v5WWgOP1BBWrsqBrQM3B9q0oQSkkGxLtImKpMDLJxPsEYFS/BG6ki6rawsuG5u9LhHrFVRok7GEW
	 YLbXB2wIVBjmY499mNAkwWYVfep02CT43U1FCCvV+svomxQanwqnAUuVBy2uDqJIHCQjBFbhx+jv
	 DzhRF7qJnCUziNeaTD16HJMeHOJDXX/ix0x39HhXAuJe4jGuzlyCgjRqOzajekgToyHuK2sdnFAV
	 PMKqdcrW6k4QRHiNeuB8hu5ymZhdRGBOl/GjVI5tMQZteggFaueLk+EnJdKKtSYrp4lYI0h9hYZU
	 6mOQmbuSygHAzCvba5ZiU6XJDQD/8C/t6uFrY9qFxX84vL9JgW60wJC6vhH0swaYMhoQfIhqGf5l
	 RwEpBIFDECcSStJ7MxCW+OmnbIHZnxv9siPaJlY3uQoQrYnk01BTRgv0rsTYvQpqVpV9xW4QYVBA
	 NPBUJNfSL5GTnFIaY+hAy/7V6q2uhzCqkN0plZDnuSqmMRbmleQ5RXan5sU7grzMMsdrFZFUt0E7
	 Prl8a2YMR0eNRSbyaCOjsfjmfDnT7qJJeqHCDv+/vkJdLD/Sq3h5cyvWbaimLIRz65IhwmfmssKF
	 3cTzYDpw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-OQ-MSGID: <88fc6ea7-157f-4bb8-b725-739b2be0409c@foxmail.com>
Date: Thu, 9 Oct 2025 09:38:47 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_strcasestr,bpf_strncasestr
 kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Viktor Malik <vmalik@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Eduard <eddyz87@gmail.com>, Rong Tao <rongtao@cestc.cn>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <cover.1759804822.git.rongtao@cestc.cn>
 <tencent_6E59062E4249590597452A06AFCDA3098808@qq.com>
 <CAADnVQJFBR5ecewWdDhTqyXTMWH_QVEPCm2PXxV_3j1wa+tWMQ@mail.gmail.com>
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <CAADnVQJFBR5ecewWdDhTqyXTMWH_QVEPCm2PXxV_3j1wa+tWMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/7/25 12:08, Alexei Starovoitov wrote:
> On Mon, Oct 6, 2025 at 8:00 PM Rong Tao <rtoax@foxmail.com> wrote:
>> +/**
>> + * bpf_strnstr - Find the first substring in a length-limited string, ignoring
>> + *               the case of the characters
>> + * @s1__ign: The string to be searched
>> + * @s2__ign: The string to search for
>> + * @len: the maximum number of characters to search
>> + *
>> + * Return:
>> + * * >=0      - Index of the first character of the first occurrence of @s2__ign
>> + *              within the first @len characters of @s1__ign
>> + * * %-ENOENT - @s2__ign not found in the first @len characters of @s1__ign
>> + * * %-EFAULT - Cannot read one of the strings
>> + * * %-E2BIG  - One of the strings is too large
>> + * * %-ERANGE - One of the strings is outside of kernel address space
>> + */
>> +__bpf_kfunc int bpf_strncasestr(const char *s1__ign, const char *s2__ign,
>> +                                                               size_t len)
> See AI review for the above part.


I just submit the v4, please review, thanks :)

Rong Tao


>
> pw-bot: cr


