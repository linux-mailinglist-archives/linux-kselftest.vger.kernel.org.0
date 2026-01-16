Return-Path: <linux-kselftest+bounces-49147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B0CD32367
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 14:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 173D630081A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 13:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A04281368;
	Fri, 16 Jan 2026 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="unEYD31Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0332505AA
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768571891; cv=none; b=M/LfBLkzO6o8sVVnu5TR9mexNzkvSe9oTMifqxHoyZHD+XgYN0vskscrLsrJXLBTPTwQr6kURtPkHinqKEqZRTMKG3LsChU+tEHGa/CmBNbd9/PspsIz+/I27Ui3e96c1P40VcEr1wKYa8uJDXR8vhsthjx/PCsY4FIRdQckQXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768571891; c=relaxed/simple;
	bh=tp/RuFxl25c/3MAHh/OGbpkoPnnqRe0fleAQ03AG4lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fx0Y7HatCsvdo3xE3JMB6iMB9Z/BH8TK3StI162MGu9gC5y8Vd1rNOqkfdAlLESiSN+yXOkEBjRj7xg+hmXr1rmUie9ZS0pFCgItzGx8bVYKudgRC3QyzH/3kG7+433yIXjVp60eF843+IBHYiRjZ5wgAiWx7cnkkptm3HdBBVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=unEYD31Y; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3b0fa14d-a11d-4ed7-8f28-2e99d74f6b46@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768571887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Im3pXRquGmKg1XDHvYG50pWNpmpor53XZzJQHnENrGo=;
	b=unEYD31YS7QXZeQ/1xU7bRf697wc8+qsW4C791IXzV19kwBtQnh7DpvcxQko0VpUdrGKyG
	zl+uimAv7RvYE+Hzzpq0tDD/LLu20sw+sjUyXSzuhu+QOrqnBjfIMAlen8melDzEYBMScy
	9mmSBX9VyyK8MBI6Ilf4YWjqrBGJXv4=
Date: Fri, 16 Jan 2026 21:57:47 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 2/9] libbpf: Add support for extended bpf
 syscall
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>,
 Andrey Albershteyn <aalbersh@redhat.com>,
 Willem de Bruijn <willemb@google.com>, Jason Xing
 <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>,
 Mykyta Yatsenko <yatsenko@meta.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung
 <ameryhung@gmail.com>, Rong Tao <rongtao@cestc.cn>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
References: <20260112145616.44195-1-leon.hwang@linux.dev>
 <20260112145616.44195-3-leon.hwang@linux.dev>
 <CAEf4BzYRC+=J05C6QDwgzbJ7gO7gZD4xcEcj9ixCaJ=xaRuSsQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzYRC+=J05C6QDwgzbJ7gO7gZD4xcEcj9ixCaJ=xaRuSsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/1/16 08:42, Andrii Nakryiko wrote:
> On Mon, Jan 12, 2026 at 6:58 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> To support the extended BPF syscall introduced in the previous commit,
>> introduce the following internal APIs:
>>
>> * 'sys_bpf_ext()'
>> * 'sys_bpf_ext_fd()'
>>   They wrap the raw 'syscall()' interface to support passing extended
>>   attributes.
>> * 'probe_sys_bpf_ext()'
>>   Check whether current kernel supports the extended attributes.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  tools/lib/bpf/bpf.c             | 34 +++++++++++++++++++++++++++++++++
>>  tools/lib/bpf/features.c        |  8 ++++++++
>>  tools/lib/bpf/libbpf_internal.h |  3 +++
>>  3 files changed, 45 insertions(+)
>>
>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> index 21b57a629916..d44e667aaf02 100644
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
>> @@ -69,6 +69,40 @@ static inline __u64 ptr_to_u64(const void *ptr)
>>         return (__u64) (unsigned long) ptr;
>>  }
>>
>> +static inline int sys_bpf_ext(enum bpf_cmd cmd, union bpf_attr *attr,
>> +                             unsigned int size,
>> +                             struct bpf_common_attr *common_attr,
> 
> nit: kernel uses consistent attr_common/size_common pattern, but here
> you are inverting attr_common -> common_attr, let's not?
> 

Ack.

I'll keep the same pattern.

>> +                             unsigned int size_common)
>> +{
>> +       cmd = common_attr ? (cmd | BPF_COMMON_ATTRS) : (cmd & ~BPF_COMMON_ATTRS);
>> +       return syscall(__NR_bpf, cmd, attr, size, common_attr, size_common);
>> +}
>> +
>> +static inline int sys_bpf_ext_fd(enum bpf_cmd cmd, union bpf_attr *attr,
>> +                                unsigned int size,
>> +                                struct bpf_common_attr *common_attr,
>> +                                unsigned int size_common)
>> +{
>> +       int fd;
>> +
>> +       fd = sys_bpf_ext(cmd, attr, size, common_attr, size_common);
>> +       return ensure_good_fd(fd);
>> +}
>> +
>> +int probe_sys_bpf_ext(void)
>> +{
>> +       const size_t attr_sz = offsetofend(union bpf_attr, prog_token_fd);
>> +       union bpf_attr attr;
>> +       int fd;
>> +
>> +       memset(&attr, 0, attr_sz);
>> +       fd = syscall(__NR_bpf, BPF_PROG_LOAD | BPF_COMMON_ATTRS, &attr, attr_sz, NULL,
>> +                    sizeof(struct bpf_common_attr));
>> +       if (fd >= 0)
>> +               close(fd);
> 
> hm... close can change errno, this is fragile. If fd >= 0, something
> is wrong with our detection, just return error right away?
> 

How about capture errno before closing?

err = errno;
if (fd >= 0)
	close(fd);
return err = EFAULT;

Then, we can wrap all details in probe_sys_bpf_ext().

>> +       return errno == EFAULT;
>> +}
>> +
>>  static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
>>                           unsigned int size)
>>  {
>> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
>> index b842b83e2480..d786a815f1ae 100644
>> --- a/tools/lib/bpf/features.c
>> +++ b/tools/lib/bpf/features.c
>> @@ -506,6 +506,11 @@ static int probe_kern_arg_ctx_tag(int token_fd)
>>         return probe_fd(prog_fd);
>>  }
>>
>> +static int probe_kern_extended_syscall(int token_fd)
>> +{
>> +       return probe_sys_bpf_ext();
>> +}
>> +
>>  typedef int (*feature_probe_fn)(int /* token_fd */);
>>
>>  static struct kern_feature_cache feature_cache;
>> @@ -581,6 +586,9 @@ static struct kern_feature_desc {
>>         [FEAT_BTF_QMARK_DATASEC] = {
>>                 "BTF DATASEC names starting from '?'", probe_kern_btf_qmark_datasec,
>>         },
>> +       [FEAT_EXTENDED_SYSCALL] = {
>> +               "Kernel supports extended syscall", probe_kern_extended_syscall,
> 
> "extended syscall" is a bit vague... We specifically detect common
> attrs support, maybe say that?
> 

Ack.

I'll update it to "BPF syscall common attributes support."

>> +       },
>>  };
>>
>>  bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
>> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
>> index fc59b21b51b5..e2a6ef4b45ae 100644
>> --- a/tools/lib/bpf/libbpf_internal.h
>> +++ b/tools/lib/bpf/libbpf_internal.h
>> @@ -392,6 +392,8 @@ enum kern_feature_id {
>>         FEAT_ARG_CTX_TAG,
>>         /* Kernel supports '?' at the front of datasec names */
>>         FEAT_BTF_QMARK_DATASEC,
>> +       /* Kernel supports extended syscall */
>> +       FEAT_EXTENDED_SYSCALL,
> 
> FEAT_BPF_COMMON_ATTRS ?
> 

FEAT_BPF_SYSCALL_COMMON_ATTRS seems more accurate.

Thanks,
Leon

>>         __FEAT_CNT,
>>  };
>>
>> @@ -757,4 +759,5 @@ int probe_fd(int fd);
>>  #define SHA256_DWORD_SIZE SHA256_DIGEST_LENGTH / sizeof(__u64)
>>
>>  void libbpf_sha256(const void *data, size_t len, __u8 out[SHA256_DIGEST_LENGTH]);
>> +int probe_sys_bpf_ext(void);
>>  #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
>> --
>> 2.52.0
>>


