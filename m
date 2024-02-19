Return-Path: <linux-kselftest+bounces-4936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7497485AA51
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 18:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992BD1C2196E
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 17:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C6C4654B;
	Mon, 19 Feb 2024 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="hCcq1zsL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DB3446BD;
	Mon, 19 Feb 2024 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708364957; cv=none; b=lUHduLGDKIKwmUm7dGoVvF7EiBjZApEM5XZaEMldQOspBDc7DKYWPBIYnmxW1h9PWMrlQ21G8iNnIBiftnrMUJt4asAQYK0sk8PgNxl3Z3aunvfxHKMs3RiSBdKyGFICac3XyrvswWMgNVcvLh08hd1W8IlfUEMemTm+F5tq8E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708364957; c=relaxed/simple;
	bh=T+ilHvIJo7mvktPqiHHlT/wupzYq6gaObcSmlVAN4N0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XiB3rKINNdPFQvybxd83KfJbbFT1lEmU6mZoo2ZEtGWZ9spGY7/1lXJGqzI9zmUfpXK/eXyArI87INfaMpmHRvVCb9zqu2fsrQUR9fZYzNGIFdL+LqiJOCya4R/5+TDYEqT49G6lPnkNEHEBNCVEmbiN4xGh0fc8Z7bNGstVJXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=hCcq1zsL; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=KdPVSdquWfVokbMo6HkoK9vt0kJIUA8fT46lxDlLy60=; b=hCcq1zsLglJyIz4/JHN8EDbD0A
	yPDMggzeimuwzZcupYzSYSXn1YbU+0Q8fNaajk1LTP7DkFAY3dfynDWxNAsQWHCXd6+9n5mcfzDiT
	fDFhSNS33ZLdOCu07FGc55yt81ths3F372V1PzANHFOHBeiBjUnpdGSjiUYcTN49XvBMk0m2Pfp4i
	L6+HbF+ewX652/MoQsAXpq8dCaBxt01sq3zYiuvjaJNAno6hccTOrVI2FlKEXU4po3oDXKEBLarA9
	KxZGpubFkOzx3OeihnB5lOP7b/DZo9Uw19G6llHDvf0J/d7ekBiiFqvLR9POkBfTTZY/MpVy6G5I/
	2j6zjh7w==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rc7ky-000GeN-1B; Mon, 19 Feb 2024 18:48:44 +0100
Received: from [178.197.249.53] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rc7kw-000XAK-Of; Mon, 19 Feb 2024 18:48:42 +0100
Subject: Re: [PATCH v2] bpf: Replace bpf_lpm_trie_key 0-length array with
 flexible array
To: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Haowen Bai <baihaowen@meizu.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>,
 Anton Protopopov <aspsk@isovalent.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240216235536.it.234-kees@kernel.org>
 <e58d035c-fb74-4d29-94d5-6c22542e7513@embeddedor.com>
 <202402161902.FCFFEC322@keescook>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a74a7255-5dbd-060e-fe2f-ac3563f466fb@iogearbox.net>
Date: Mon, 19 Feb 2024 18:48:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202402161902.FCFFEC322@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27190/Mon Feb 19 10:24:27 2024)

On 2/17/24 4:03 AM, Kees Cook wrote:
> On Fri, Feb 16, 2024 at 06:27:08PM -0600, Gustavo A. R. Silva wrote:
>> On 2/16/24 17:55, Kees Cook wrote:
>>> Replace deprecated 0-length array in struct bpf_lpm_trie_key with
>>> flexible array. Found with GCC 13:
>>>
>>> ../kernel/bpf/lpm_trie.c:207:51: warning: array subscript i is outside array bounds of 'const __u8[0]' {aka 'const unsigned char[]'} [-Warray-bounds=]
>>>     207 |                                        *(__be16 *)&key->data[i]);
>>>         |                                                   ^~~~~~~~~~~~~
>>> ../include/uapi/linux/swab.h:102:54: note: in definition of macro '__swab16'
>>>     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
>>>         |                                                      ^
>>> ../include/linux/byteorder/generic.h:97:21: note: in expansion of macro '__be16_to_cpu'
>>>      97 | #define be16_to_cpu __be16_to_cpu
>>>         |                     ^~~~~~~~~~~~~
>>> ../kernel/bpf/lpm_trie.c:206:28: note: in expansion of macro 'be16_to_cpu'
>>>     206 |                 u16 diff = be16_to_cpu(*(__be16 *)&node->data[i]
>>> ^
>>>         |                            ^~~~~~~~~~~
>>> In file included from ../include/linux/bpf.h:7:
>>> ../include/uapi/linux/bpf.h:82:17: note: while referencing 'data'
>>>      82 |         __u8    data[0];        /* Arbitrary size */
>>>         |                 ^~~~
>>>
>>> And found at run-time under CONFIG_FORTIFY_SOURCE:
>>>
>>>     UBSAN: array-index-out-of-bounds in kernel/bpf/lpm_trie.c:218:49
>>>     index 0 is out of range for type '__u8 [*]'
>>>
>>> This includes fixing the selftest which was incorrectly using a
>>> variable length struct as a header, identified earlier[1]. Avoid this
>>> by just explicitly including the prefixlen member instead of struct
>>> bpf_lpm_trie_key.
>>>
>>> Note that it is not possible to simply remove the "data" member, as it
>>> is referenced by userspace
>>>
>>> cilium:
>>>           struct egress_gw_policy_key in_key = {
>>>                   .lpm_key = { 32 + 24, {} },
>>>                   .saddr   = CLIENT_IP,
>>>                   .daddr   = EXTERNAL_SVC_IP & 0Xffffff,
>>>           };
>>>
>>> systemd:
>>> 	ipv6_map_fd = bpf_map_new(
>>> 			BPF_MAP_TYPE_LPM_TRIE,
>>> 			offsetof(struct bpf_lpm_trie_key, data) + sizeof(uint32_t)*4,
>>> 			sizeof(uint64_t),
>>> 			...
>>>
>>> The only risk to UAPI would be if sizeof() were used directly on the
>>> data member, which it does not seem to be. It is only used as a static
>>> initializer destination and to find its location via offsetof().
>>>
>>> Link: https://lore.kernel.org/all/202206281009.4332AA33@keescook/ [1]
>>> Reported-by: Mark Rutland <mark.rutland@arm.com>
>>> Closes: https://paste.debian.net/hidden/ca500597/
>>
>> mmh... this URL expires: 2024-05-15
> 
> Yup, but that's why I included the run-time splat above too. :)

I don't quite follow, this basically undoes 3024d95a4c52 ("bpf: Partially revert
flexible-array member replacement") again with the small change that this 'fixes'
up the BPF selftest to not embed struct bpf_lpm_trie_key.

Outside of BPF selftests though aren't we readding the same error that we fixed
earlier for BPF programs in the wild which embed struct bpf_lpm_trie_key into their
key structure?

Thanks,
Daniel

