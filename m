Return-Path: <linux-kselftest+bounces-13595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED12C92EC06
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 17:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5B91C22A01
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 15:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238F616C859;
	Thu, 11 Jul 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="qNrm3aXV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D81A28FF;
	Thu, 11 Jul 2024 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713362; cv=none; b=IlRfXixNHTvUs2jz8FneAmod6I/Ju8E945POpCW84HVSLScz6ZTN+vMzTjQ9IetLZctJ31OptJAR2093G/C6daqN7d/FHvrACZJrA6+w+feEQw+sU/3Ggl28sRX40F/wGqtHR/SzOr6ndPG0tzT4gb9NCKy253i7o7APGnvxn/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713362; c=relaxed/simple;
	bh=pvwZQWKRM8P3abXf9MKAFwoT+CyflxB2xiAXKKtM8o0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=G3YjarjLreh/YYvYnw4i2fbCKaFTIK445yqqYZmsBiWgBsrpSp89Snb28jOi+q1zLpuNaOoLaLMt2Rj/IS1/z+Ilf709I0pHPqcwrqI4yPk6nyRfSKKFA+iut4Vilt/E5JZNwpCSqtgsFcNnl5w2wG6sDniB/p0IfNXiBtkhIwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=qNrm3aXV; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=COVnHoaV6XQK+0UAiwgzJJpAqirYx+8+7V18TlawizU=; b=qNrm3aXVoxJJ9bN0EsVCVSRHlI
	x+24kwbaPNkZRu4HFgvkwfM5vDNyuoknBivTehKIjog6wpPLIG9WlNk2XLrl4K4xWf9FcueAP/nhW
	XsQA07d5ONdYw3R+d4RrMVlMoCxf+YwFbPEPyuf5LhUdsE1TPVPdddQWWd4Qu5/2yOszJukh1OCxl
	1YAn8cG1EdbO32Ga7WdJHT8NSVw476vANsJWrAAAzTyReAzFJtJKTzA32rpN2byrVRyy4Lv+n2uRh
	F/cy0Globu5FOxLW6kzV5+vcSyViHM1a+Xna4lx1s85sYXYcVcs8J536FX78IFvz8/PN8SOli7Uww
	0+BIH56w==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sRw93-000LSe-4J; Thu, 11 Jul 2024 17:55:45 +0200
Received: from [178.197.248.35] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sRw92-0009bc-2C;
	Thu, 11 Jul 2024 17:55:44 +0200
Subject: Re: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
To: Puranjay Mohan <puranjay@kernel.org>, Manu Bretelle <chantra@meta.com>,
 KP Singh <kpsingh@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@meta.com>,
 Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Florent Revest <revest@google.com>
References: <20240705145009.32340-1-puranjay@kernel.org>
 <c0ef7ecf-595b-375a-7785-d7bf50040c6b@iogearbox.net>
 <mb61pjzhwvshc.fsf@kernel.org>
 <CACYkzJ7d_u=aRzbubBypSVhnUSjBQnbZjPuGXhqnMzbp0tJm_g@mail.gmail.com>
 <224eeadb-fc5f-baeb-0808-a4f9916afa3c@iogearbox.net>
 <mb61ped836gn7.fsf@kernel.org>
 <d36b0c2e-fdf2-d3b0-46a8-7936e0eda5a8@iogearbox.net>
 <CACYkzJ5E+3xYkNsH7JoVkjabzSwnZZCzzTz5B50qDB7bLYkmMA@mail.gmail.com>
 <890d23f2-636e-12d1-31cc-eb6469f2a9ac@iogearbox.net>
 <SJ0PR15MB461564D3F7E7A763498CA6A8CBDB2@SJ0PR15MB4615.namprd15.prod.outlook.com>
 <mb61p5xtcyqo5.fsf@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9b188f97-f5ef-8f06-50a2-26a43b58f7ed@iogearbox.net>
Date: Thu, 11 Jul 2024 17:55:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <mb61p5xtcyqo5.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27333/Thu Jul 11 10:35:59 2024)

On 7/11/24 4:00 PM, Puranjay Mohan wrote:
> 
> Hi,
> I was able find the root cause of this bug and will send a fix soon!
> 
>> Unable to handle kernel paging request at virtual address ffff0000c2a80e68
> 
> We are running this test on Qemu with '-cpu max', this means 52-bit
> virtual addresses are being used.
> 
> The trampolines generation code has the following two lines:
> 
> 		emit_addr_mov_i64(A64_R(0), (const u64)im, ctx);
> 		emit_call((const u64)__bpf_tramp_enter, ctx);
> 
> here the address of struct bpf_tramp_image is moved to R0 and passed as
> an argument to __bpf_tramp_enter().
> 
> emit_addr_mov_i64() assumes that the address passed to it is in the
> vmalloc space and uses at most 48 bits. It sets all the remaining bits
> to 1.
> 
> but struct bpf_tramp_image is allocated using kzalloc() and when 52-bit
> VAs are used, its address is not guaranteed to be 48-bit, therefore we
> see this bug, where  0xfff[0]0000c2a80e68 is converted to
> 0xfff[f]0000c2a80e68 when the trampoline is generated.
> 
> The fix would be use emit_a64_mov_i64() for moving this address into R0.

Excellent find!

