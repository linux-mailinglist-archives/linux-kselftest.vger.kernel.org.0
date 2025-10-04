Return-Path: <linux-kselftest+bounces-42761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F472BB8EFB
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 16:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2583D3C4BB1
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 14:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5751FDE39;
	Sat,  4 Oct 2025 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="E3CbVV53"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397197260F;
	Sat,  4 Oct 2025 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759589157; cv=none; b=gPJXtgAPdqxYZHeI6Xz38LaE7QX8cQqymytgnV4vOU5NWr6lux3aQJCamkQMJ6usc3Pq7Nc/rp1cGk4ka0QW1DrU/KJLwOtwysj+3I5iruus8kyWvLjHi/Xgsae6ksI67VSEum6kGD2UARaatz3ashJVP1y+TaHF2vWi+Sc+3gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759589157; c=relaxed/simple;
	bh=jZC1BOtd0LyldamzCt8vT7MOrYp+3AuVfEqGHLUN6AI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yqy7PwGuqCwGPtp1pA22mj3N5avNKgC+aWkQ2LJbP6ozcRNIlZhP+vGtxG2Zo0BncUk3s+mr4LaedCZdTstMowwpRnARENSlWcqaHy1627xn5c9owZAYz6dndj3cAg0ciUQSwxwo4u1JKmHLjHq1C1HWJcx/khThFXgk6uFOs/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=E3CbVV53; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1759588846;
	bh=aLcQxDEB2zHHil1vKTJsBzjH+TWu7SDHe03d6zrJ1F8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=E3CbVV531YZ2G/rLUJxAQJaH95CGuiiCz97SBEdDLTLUAT6A0TQW+w1FRmMsVPR2J
	 1yyyimZq9BGSbk2PjCK7XzYkvn6RbeoJ85L+tA7u0+7368FOVAF2rDPFBW+gDni22H
	 +pQ0BbGBXbpb15+ZcSuZ5CethyCB6vX+Wh4WCXd4=
Received: from [192.168.2.102] ([183.198.135.10])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id A2B218DE; Sat, 04 Oct 2025 22:40:43 +0800
X-QQ-mid: xmsmtpt1759588843tnh7o3u37
Message-ID: <tencent_0838BCA28C3E230A19B4094167455E1AA90A@qq.com>
X-QQ-XMAILINFO: NojR6Ao/DkEDkg3c0+Z9uQofb6JONCqOnZ55W0B3MJjiZ4nNrtT9ThwZw0G71z
	 m3pRzXB5tg1bagag7YBsNUy/lKZVWEC5A0QAA4QImROoN8Z88Syy+huqIrIpF/Im65jhFFMJUsmA
	 JRJntPA3RJnxHqV6WrV8iNNNzT1u6tU51v7+tJdq627teD7csWzu7OinSpb4+5N6B6P2KMTGM4ZZ
	 GXJIIY8dnUbmyq7ZIyK5IiAJ4YUX4iy9tDsBjoeB/8UaylanvAYbe8w5O1+HRMuFlc0JTtjRf53h
	 /G3Le0MdGSFE/NEFJS05+7AtCdHaFIwL83yacIuIMwsos+KBN/941DTg2QmVdg3/yKf2opgssJJx
	 uNb/L57pHo07JTaNexLeoblDM+N09DYdl6tzn+X1o6cTM3AZq67IXSeobIc3FWKwA3ApxWvuWNK5
	 xNsHJcC8GHICiwo1RwyYEnM//8G6LfjFfO4Ls4Ia0aEJdlxB7hw6xmhgNL2k5z3ur1/e6vvyqe19
	 4g9dptopDuXk+YdYsA/50ORB/mJWb6ucSRfQ28/8EXbKYRJ9hUXuD3O16bYXLNtE/ZuohtZYqBeL
	 m8tN1k9tK5rN5awAkwGvkTR7h+bEV4rQYYwaneU6olk5SZdsWaqptXiHTsfsjBVv1ss3BgGFl5fc
	 jkUGOcDo3gLiZV/yk0yPCWp7Flan6WlVHOs6mBC+0lGKxvKJiHxPra0FrQv1yQ4cN/ssCS+6OWDp
	 e4WocwxlU76QXJ0QaukrYHH6p1pM2QI5A20xpNLKMr0+eMfrLen2Msr6BjPs6hD8e1PM0AkUj9oj
	 KmBfRX9THEfm/q+iDGmR8yZ5Z7EDOGTW2aIzwb1n64UaFMFDwvYLyM1/hsHA3LZB1u//aMS43wLx
	 NUDOuqSOn49oklEyaesafGfDzQ9OGsNX+8xVClJeOgS428Pq+OS52SbpwOFz/VC7l74ZD9E3FFo8
	 EYWct3KU8Bi298xrSEmeJXMPugUfTRVqfdmC816DEw09erscW9r6YT940goDfy6L+nrWqvOQNEi/
	 9CWS/TLJM2Lm04eu1Y5a+FK6QdLvRKmndsRkZXt0ZYX59daI++dQc4TvgggftfUXUpfMzsQQ==
X-QQ-XMRINFO: MFN5R+/RXzhDMAgaz0rNTGk=
X-OQ-MSGID: <48872fbc-e896-4b9a-8a4f-3b7bdb558eb8@foxmail.com>
Date: Sat, 4 Oct 2025 22:40:42 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_strcasestr,bpf_strncasestr
 kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Viktor Malik <vmalik@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Rong Tao <rongtao@cestc.cn>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <cover.1759584052.git.rongtao@cestc.cn>
 <tencent_8AF4D15B4475031E2185ACDE4B1495995707@qq.com>
 <CAADnVQ+iERbZZ35CbPRamMqEu32ptEAXL0OQAhansfzBX+HDKQ@mail.gmail.com>
Content-Language: en-US
From: "rtoax@foxmail.com" <rtoax@foxmail.com>
In-Reply-To: <CAADnVQ+iERbZZ35CbPRamMqEu32ptEAXL0OQAhansfzBX+HDKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/4/25 10:28 PM, Alexei Starovoitov wrote:
> On Sat, Oct 4, 2025 at 6:37 AM Rong Tao <rtoax@foxmail.com> wrote:
>> -__bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, size_t len)
>> +__bpf_kfunc int __bpf_strnstr(const char *s1, const char *s2, size_t len,
>> +                                                         bool ignore_case)
>>   {
> Still __bpf_kfunc ?
Sorry about that, i'll fix it right now.
>
> pw-bot: cr


