Return-Path: <linux-kselftest+bounces-30760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C098A88CD6
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 22:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40731899EB3
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 20:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D87D1DC9AF;
	Mon, 14 Apr 2025 20:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DGcER8U0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F651B4233;
	Mon, 14 Apr 2025 20:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744661482; cv=none; b=SSaPIGZuTq4vMCqqzvoXITgrHKqMpsYGTL95QisvEYClYwHTTOTaB18vaqYONcaEOGf1+siOe/LLK68t/A/l61lKaX6SKyC7EtuRIH+LMhfBQzz0tcBEcLhJkZno3MNR7RxK0y0Wo+UxrmzIeEWieKOV57rxg0dEsH6Yg7xg1kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744661482; c=relaxed/simple;
	bh=m9gUHGSqqjzXCUNW6X/n+Ri/iJ5aMnBxw6nMVp+5E6M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QyURcX1XBSpvhS+UJvbqehcfgTXb6BQ4mMUaOdHE4NQqX9u2R2hDLjWYFfPZLY5Zie0EoRNhX1Xt0kMhb3Z3wrDYiV5aD+WHXrilxvO0d8t7QZ5TbPn5IZlpGf+o7Ly4oS5m8ZNIZloLVt003zBZ3Rn+7qOLRS2t21XaT1HP7bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DGcER8U0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3E98D210C426;
	Mon, 14 Apr 2025 13:11:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3E98D210C426
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744661480;
	bh=P556LurTOELheJsvrtJpXaQl7rF2eMtCrBpdxv4c0g8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DGcER8U0Lp6LIp5x8dw8dW/kKK1vADezhCEhZACHXla6ONsZ/FiK3dfjlQd/DeITL
	 6lyD6wH7iWHkvv5LbIiMagDI/VQwjUWpO/P+F21KKUt2eFOC3eYPU3j6gOs5oqok7S
	 SMP1E1bth48QsO3rcIBsYXqH09fmAhbiTS24RlfI=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Tyler Hicks <code@tyhicks.com>
Cc: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
 <davem@davemloft.net>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Masahiro Yamada
 <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas
 Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, =?utf-8?Q?Mick?=
 =?utf-8?Q?a=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Nick
 Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Jarkko Sakkinen
 <jarkko@kernel.org>, Jan Stancek <jstancek@redhat.com>, Neal Gompa
 <neal@gompa.dev>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 llvm@lists.linux.dev, nkapron@google.com, teknoraver@meta.com,
 roberto.sassu@huawei.com, xiyou.wangcong@gmail.com
Subject: Re: [PATCH v2 security-next 1/4] security: Hornet LSM
In-Reply-To: <Z/lo3iVcJgB2pfQX@redbud>
References: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com>
 <20250404215527.1563146-2-bboscaccy@linux.microsoft.com>
 <Z/lo3iVcJgB2pfQX@redbud>
Date: Mon, 14 Apr 2025 13:11:09 -0700
Message-ID: <87lds2jyg2.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tyler Hicks <code@tyhicks.com> writes:

> On 2025-04-04 14:54:50, Blaise Boscaccy wrote:
>> +static int hornet_verify_lskel(struct bpf_prog *prog, struct hornet_maps *maps,
>> +			       void *sig, size_t sig_len)
>> +{
>> +	int fd;
>> +	u32 i;
>> +	void *buf;
>> +	void *new;
>> +	size_t buf_sz;
>> +	struct bpf_map *map;
>> +	int err = 0;
>> +	int key = 0;
>> +	union bpf_attr attr = {0};
>> +
>> +	buf = kmalloc_array(prog->len, sizeof(struct bpf_insn), GFP_KERNEL);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +	buf_sz = prog->len * sizeof(struct bpf_insn);
>> +	memcpy(buf, prog->insnsi, buf_sz);
>> +
>> +	for (i = 0; i < maps->used_map_cnt; i++) {
>> +		err = copy_from_bpfptr_offset(&fd, maps->fd_array,
>> +					      maps->used_idx[i] * sizeof(fd),
>> +					      sizeof(fd));
>> +		if (err < 0)
>> +			continue;
>> +		if (fd < 1)
>> +			continue;
>> +
>> +		map = bpf_map_get(fd);
>
> I'm not very familiar with BPF map lifetimes but I'd assume we need to have a
> corresponding bpf_map_put(map) before returning.
>
>> +		if (IS_ERR(map))
>> +			continue;
>> +
>> +		/* don't allow userspace to change map data used for signature verification */
>> +		if (!map->frozen) {
>> +			attr.map_fd = fd;
>> +			err = kern_sys_bpf(BPF_MAP_FREEZE, &attr, sizeof(attr));
>> +			if (err < 0)
>> +				goto out;
>> +		}
>> +
>> +		new = krealloc(buf, buf_sz + map->value_size, GFP_KERNEL);
>> +		if (!new) {
>> +			err = -ENOMEM;
>> +			goto out;
>> +		}
>> +		buf = new;
>> +		new = map->ops->map_lookup_elem(map, &key);
>> +		if (!new) {
>> +			err = -ENOENT;
>> +			goto out;
>> +		}
>> +		memcpy(buf + buf_sz, new, map->value_size);
>> +		buf_sz += map->value_size;
>> +	}
>> +
>> +	err = verify_pkcs7_signature(buf, buf_sz, sig, sig_len,
>> +				     VERIFY_USE_SECONDARY_KEYRING,
>> +				     VERIFYING_EBPF_SIGNATURE,
>> +				     NULL, NULL);
>> +out:
>> +	kfree(buf);
>> +	return err;
>> +}
>> +
>> +static int hornet_check_binary(struct bpf_prog *prog, union bpf_attr *attr,
>> +			       struct hornet_maps *maps)
>> +{
>> +	struct file *file = get_task_exe_file(current);
>
> We should handle get_task_exe_file() returning NULL. I don't think it is likely
> to happen when passing `current` but kernel_read_file() doesn't protect against
> it and we'll have a NULL pointer dereference when it calls file_inode(NULL).
>
>> +	const unsigned long markerlen = sizeof(EBPF_SIG_STRING) - 1;
>> +	void *buf = NULL;
>> +	size_t sz = 0, sig_len, prog_len, buf_sz;
>> +	int err = 0;
>> +	struct module_signature sig;
>> +
>> +	buf_sz = kernel_read_file(file, 0, &buf, INT_MAX, &sz, READING_EBPF);
>
> We are leaking buf in this function. kernel_read_file() allocates the memory
> for us but we never kfree(buf).
>
>> +	fput(file);
>> +	if (!buf_sz)
>> +		return -1;
>> +
>> +	prog_len = buf_sz;
>> +
>> +	if (prog_len > markerlen &&
>> +	    memcmp(buf + prog_len - markerlen, EBPF_SIG_STRING, markerlen) == 0)
>> +		prog_len -= markerlen;
>
> Why is the marker optional? Looking at module_sig_check(), which verifies the
> signature on kernel modules, I see that it refuses to proceed if the marker is
> not found. Should we do the same and refuse to operate on any unexpected input?
>

Looking at this again, there doesn't seem to be a good reason to have an
optional marker. I'll get that fixed in v3 along with the rest of these
suggestions. 

>> +
>> +	memcpy(&sig, buf + (prog_len - sizeof(sig)), sizeof(sig));
>
> We should make sure that prog_len is larger than sizeof(sig) prior to this
> memcpy(). It is probably not a real issue in practice but it would be good to
> ensure that we can't be tricked to copy and operate on any bytes proceeding
> buf.
>
> Tyler
>
>> +	sig_len = be32_to_cpu(sig.sig_len);
>> +	prog_len -= sig_len + sizeof(sig);
>> +
>> +	err = mod_check_sig(&sig, prog->len * sizeof(struct bpf_insn), "ebpf");
>> +	if (err)
>> +		return err;
>> +	return hornet_verify_lskel(prog, maps, buf + prog_len, sig_len);
>> +}

