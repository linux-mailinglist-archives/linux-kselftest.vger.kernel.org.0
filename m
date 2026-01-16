Return-Path: <linux-kselftest+bounces-49151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 432A5D327C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 15:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D66630C6124
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 14:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAA831A7F1;
	Fri, 16 Jan 2026 14:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ckUPJAd3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA34C30FC35
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573070; cv=none; b=YfwtjCQPdRq/ydPjltAg3fCRtAiiPUI6ilynyO6r11I8GA9JXTNFarC7d+Pl2BDB78u8hLwQeVQscLEMBa/OruY3VnNtlsmkrU48OsRTnhycyU0u2zrvqvmIYtg6LNQOC7RQEFy1faXWQnHkf+RHk5v17yj/D94MGzTHp1Eyum0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573070; c=relaxed/simple;
	bh=tFAb7kU+GUoUou6pVG4vlKLk0Na2EuYIDz5ZFMRn7jQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c79rtum4OuPjFTfZydwKh6aK2oIvPgFVdleNafz5/lnRJqCmUZHq9b6Dt6HqkK+mKyCCfI4G/zd2OtgFh6uvODN5VVne11LHWqSOtVu4TysI+qfKe7BJAA1NXDa2iZpMJNN3MXyrVy5tA2Wkt1s61FHjOm3ujqN4IBSkVRkM3uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ckUPJAd3; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <22e0de9a-8963-454b-8b35-f8c9be15dee3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768573055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AyxPKtVnYEhbqY5ej9xEJpQHHwFramyrAhZn0x12s5U=;
	b=ckUPJAd3AWNAzWG97rpe0cF0VTKDfX59rtFnngz7SQij8DTo8BgeJF3Ln4lP7Ic9HbHP61
	mqpyDrYxm7kU0I5vONV/s4RuQf1ugVizWLwm/dh92y5Nn5kfNarN8fi82Vpo9htNbHJn40
	xLjerGNKDdt38fClMkTqaSxZfZLCCXU=
Date: Fri, 16 Jan 2026 22:17:20 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 8/9] libbpf: Add common attr support for
 map_create
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
 <20260112145616.44195-9-leon.hwang@linux.dev>
 <CAEf4BzarSrW1aTRcjrheLWqxFCh1FFd7vwJ4OQup1dbT13EapQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzarSrW1aTRcjrheLWqxFCh1FFd7vwJ4OQup1dbT13EapQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/1/16 09:03, Andrii Nakryiko wrote:
> On Mon, Jan 12, 2026 at 6:59 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> With the previous commit adding common attribute support for
>> BPF_MAP_CREATE, users can now retrieve detailed error messages when map
>> creation fails via the log_buf field.
>>
>> Introduce struct bpf_syscall_common_attr_opts with the following fields:
>> log_buf, log_size, log_level, and log_true_size.
>>
>> Extend bpf_map_create_opts with a new field common_attr_opts, allowing
>> users to capture and inspect log messages on map creation failures.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  tools/lib/bpf/bpf.c | 15 ++++++++++++++-
>>  tools/lib/bpf/bpf.h | 17 ++++++++++++++++-
>>  2 files changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> index d44e667aaf02..d65df1b7b2be 100644
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
>> @@ -207,6 +207,9 @@ int bpf_map_create(enum bpf_map_type map_type,
>>                    const struct bpf_map_create_opts *opts)
>>  {
>>         const size_t attr_sz = offsetofend(union bpf_attr, excl_prog_hash_size);
>> +       const size_t common_attr_sz = sizeof(struct bpf_common_attr);
>> +       struct bpf_syscall_common_attr_opts *common_attr_opts;
>> +       struct bpf_common_attr common_attr;
>>         union bpf_attr attr;
>>         int fd;
>>
>> @@ -240,7 +243,17 @@ int bpf_map_create(enum bpf_map_type map_type,
>>         attr.excl_prog_hash = ptr_to_u64(OPTS_GET(opts, excl_prog_hash, NULL));
>>         attr.excl_prog_hash_size = OPTS_GET(opts, excl_prog_hash_size, 0);
>>
>> -       fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
>> +       common_attr_opts = OPTS_GET(opts, common_attr_opts, NULL);
>> +       if (common_attr_opts && feat_supported(NULL, FEAT_EXTENDED_SYSCALL)) {
>> +               memset(&common_attr, 0, common_attr_sz);
>> +               common_attr.log_buf = ptr_to_u64(OPTS_GET(common_attr_opts, log_buf, NULL));
>> +               common_attr.log_size = OPTS_GET(common_attr_opts, log_size, 0);
>> +               common_attr.log_level = OPTS_GET(common_attr_opts, log_level, 0);
>> +               fd = sys_bpf_ext_fd(BPF_MAP_CREATE, &attr, attr_sz, &common_attr, common_attr_sz);
>> +               OPTS_SET(common_attr_opts, log_true_size, common_attr.log_true_size);
>> +       } else {
>> +               fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> 
> OPTS_SET(log_true_size) to zero here, maybe?
> 

Unnecessary, but ok to do it.

>> +       }
>>         return libbpf_err_errno(fd);
>>  }
>>
>> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
>> index 2c8e88ddb674..c4a26e6b71ea 100644
>> --- a/tools/lib/bpf/bpf.h
>> +++ b/tools/lib/bpf/bpf.h
>> @@ -37,6 +37,18 @@ extern "C" {
>>
>>  LIBBPF_API int libbpf_set_memlock_rlim(size_t memlock_bytes);
>>
>> +struct bpf_syscall_common_attr_opts {
>> +       size_t sz; /* size of this struct for forward/backward compatibility */
>> +
>> +       char *log_buf;
>> +       __u32 log_size;
>> +       __u32 log_level;
>> +       __u32 log_true_size;
>> +
>> +       size_t :0;
>> +};
>> +#define bpf_syscall_common_attr_opts__last_field log_true_size
> 
> see below, let's drop this struct and just add these 4 fields directly
> to bpf_map_create_opts
> 
>> +
>>  struct bpf_map_create_opts {
>>         size_t sz; /* size of this struct for forward/backward compatibility */
>>
>> @@ -57,9 +69,12 @@ struct bpf_map_create_opts {
>>
>>         const void *excl_prog_hash;
>>         __u32 excl_prog_hash_size;
>> +
>> +       struct bpf_syscall_common_attr_opts *common_attr_opts;
> 
> maybe let's just add those log_xxx fields here directly? This whole
> extra bpf_syscall_common_attr_opts pointer and struct seems like a
> cumbersome API.
> 

Oops... This struct was suggested by the v3 discussion [1].

This struct was used to report 'log_true_size' without changing
'bpf_map_create()' API.

Links
[1]
https://lore.kernel.org/bpf/CAEf4Bzaw9cboFSf1OXmD84S7pKaeyj=bcQg_diUzGwAkFsjUgg@mail.gmail.com/

Thanks,
Leon

>> +
>>         size_t :0;
>>  };
>> -#define bpf_map_create_opts__last_field excl_prog_hash_size
>> +#define bpf_map_create_opts__last_field common_attr_opts
>>
>>  LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
>>                               const char *map_name,
>> --
>> 2.52.0
>>


