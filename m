Return-Path: <linux-kselftest+bounces-30618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B119DA865E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 21:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4655440101
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 19:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5764326980B;
	Fri, 11 Apr 2025 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="OEKBxOfh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mIXVbHzX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B78202C50;
	Fri, 11 Apr 2025 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744398569; cv=none; b=Ki4+YBagt1zfKX7Vv7Y0vRCMNxMHIx75zxmD93+zlCz2Smxv6VURqaLZwdTgs0fnRAw3MWEN+/kDNlIOIXZTy0LpVp1fNoXXxIDcjAeB2ubdtAjXykIruH2eutjwAnB0dwGHZMqnPC9hzOXNMNUS4XIS6kShn8FQFnZ0rcOzclU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744398569; c=relaxed/simple;
	bh=YzmETj4gJTJQ6pFl7e7yHSipZeZaUJUdZAH7jETNB5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxmfbCDWqfiMbiY6zB3Myeonem9XiUVKQexBG6DUgmTLcssXBjtgKqVF78+T9KjXQK7kJj3quX8BZM3M2nucfrevCZ44dv9HdWEw5D57bm7Y7IotNLK7lexR/VKYyy8abv7lLBBLzQTVB99tYbmugnEXlw3sXIThrOz7OcXLJL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=OEKBxOfh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mIXVbHzX; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 1EDB21D403EA;
	Fri, 11 Apr 2025 15:09:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 11 Apr 2025 15:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744398564; x=1744405764; bh=zT7wTOVk8+
	9f0EyASrcxR34TnzymyvwavXCScDdNtGQ=; b=OEKBxOfhTA83r+bsxPbWqdpw9U
	nLcEeCma0le3Lm5xT8bnqIkyKQbWhdGhpj/RZrSB+v9mqkVARJFmp6FuFXjY6U94
	S2bCbWHfkNLO8diB0yOdfjd9aTg0igtkBP//zylmt2I+oCmyddOqb5RZaux3h6Cj
	mdnwB92uO827wGKXvcGSqpFHSUcemYF9PUeqhDDtNQSUQDayri0LYZGGRUJ++Ec1
	6XoEKADvEDp4JPbbo1uHsrYgdm+FjP1UTxVuP48cX9d2aqa/FxLF+csdffEkRcG8
	I3n8O4dOFAYWxV6DzmqaDf345GVF/DvXNsis4kKo4ZZgoCgqV3qKDvO1W3dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744398564; x=1744405764; bh=zT7wTOVk8+9f0EyASrcxR34TnzymyvwavXC
	ScDdNtGQ=; b=mIXVbHzXibxhFT1+Ei7XAEheOCw/kfIvYM3fAb2lRdQwQtC/gMk
	wN9Ngq74lvblJ5D7+kCSZD3MDsHvLbwtlvjlbzts1UpAulsd1BgWPXP2k5fAZuCL
	xDajxm+RXx2kO0HXbBgblPtME78wXQO2B27HCqN4yjy6JTEaVMHUIfNsLgpCq30C
	EvLlokiT9g+dRU2B1ieRCmcHEXGAUmFNuFRdzn8MjoTReye5m5DM+2pYqP1XtsiS
	dyM+PyJ1yZGrCSmdOvJows4NHoZd4H3REI0oyJdINDdM3/nyQUSk3pl5KIRyHPhu
	1A2XWhjEJTIk6vVPuKtcjcgu59Jyug68CpA==
X-ME-Sender: <xms:4mj5Z-VTurReWdkgQp2drxL418ZMK20OLx6-LBxTLS24MGu1nJD1wg>
    <xme:4mj5Z6mSx4-fzrQbSpQDdP0CVTtI2N-F1l7tq2lPn5R3tR5o_hdOa4DoTcSwPNZO0
    lv96kVLt-1Yt-6Gh3A>
X-ME-Received: <xmr:4mj5Zyag6T7QtQ7ud_4Xuo43cdMKW8sxXfYW3KQ5D5XXq1CnrTtVSa5Txw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddvieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepvfihlhgvrhcujfhitghkshcuoegtohguvgesthihhhhitghkshdrtg
    homheqnecuggftrfgrthhtvghrnhepvdehvddttdfhfefhtdfgleehfeeggfdujeeuveek
    udevkedvgeejtddtfefgleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheptghouggvsehthihhihgtkhhsrdgtohhmpdhnsggprhgtphhtthho
    peeffedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggsohhstggrtggthieslh
    hinhhugidrmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopegtohhrsggvtheslhif
    nhdrnhgvthdprhgtphhtthhopeguhhhofigvlhhlshesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtohephhgvrhgsvghrthesghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruhdprhgt
    phhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepphgruh
    hlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopehjmhhorhhrihhssehnrghm
    vghirdhorhhgpdhrtghpthhtohepshgvrhhgvgeshhgrlhhlhihnrdgtohhmpdhrtghpth
    htohepmhgrshgrhhhirhhohieskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4mj5Z1XARotXXsdFd7dEaTUm9A8IaYAdA0p0Y0WAWNYr1oESSvXi5A>
    <xmx:4mj5Z4kGjB7oqxU6HrWxsAd-JOrxu6k0sDsNIYtkfjtALqLPK-JHmQ>
    <xmx:4mj5Z6d6sCR0wqFSsLc7MByuhZIzpz9brk2RODR-vuhuoRs9NhbSTA>
    <xmx:4mj5Z6HU54PrxoVD6A-oqWG_mDPYxEZ7Ld_pevD2CWooHvOt_L4Fog>
    <xmx:5Gj5Z6vL0n8qq1K8OGPHcSRlyAV7nIDedTJ9JqFsP3GOgjm9j7yskkfA>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 15:09:20 -0400 (EDT)
Date: Fri, 11 Apr 2025 14:09:18 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,	Justin Stitt <justinstitt@google.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,	Jan Stancek <jstancek@redhat.com>,
 Neal Gompa <neal@gompa.dev>,	linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,	keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org,	linux-security-module@vger.kernel.org,
 linux-kbuild@vger.kernel.org,	linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org,	llvm@lists.linux.dev, nkapron@google.com,
 teknoraver@meta.com,	roberto.sassu@huawei.com, xiyou.wangcong@gmail.com
Subject: Re: [PATCH v2 security-next 1/4] security: Hornet LSM
Message-ID: <Z/lo3iVcJgB2pfQX@redbud>
References: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com>
 <20250404215527.1563146-2-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404215527.1563146-2-bboscaccy@linux.microsoft.com>

On 2025-04-04 14:54:50, Blaise Boscaccy wrote:
> +static int hornet_verify_lskel(struct bpf_prog *prog, struct hornet_maps *maps,
> +			       void *sig, size_t sig_len)
> +{
> +	int fd;
> +	u32 i;
> +	void *buf;
> +	void *new;
> +	size_t buf_sz;
> +	struct bpf_map *map;
> +	int err = 0;
> +	int key = 0;
> +	union bpf_attr attr = {0};
> +
> +	buf = kmalloc_array(prog->len, sizeof(struct bpf_insn), GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +	buf_sz = prog->len * sizeof(struct bpf_insn);
> +	memcpy(buf, prog->insnsi, buf_sz);
> +
> +	for (i = 0; i < maps->used_map_cnt; i++) {
> +		err = copy_from_bpfptr_offset(&fd, maps->fd_array,
> +					      maps->used_idx[i] * sizeof(fd),
> +					      sizeof(fd));
> +		if (err < 0)
> +			continue;
> +		if (fd < 1)
> +			continue;
> +
> +		map = bpf_map_get(fd);

I'm not very familiar with BPF map lifetimes but I'd assume we need to have a
corresponding bpf_map_put(map) before returning.

> +		if (IS_ERR(map))
> +			continue;
> +
> +		/* don't allow userspace to change map data used for signature verification */
> +		if (!map->frozen) {
> +			attr.map_fd = fd;
> +			err = kern_sys_bpf(BPF_MAP_FREEZE, &attr, sizeof(attr));
> +			if (err < 0)
> +				goto out;
> +		}
> +
> +		new = krealloc(buf, buf_sz + map->value_size, GFP_KERNEL);
> +		if (!new) {
> +			err = -ENOMEM;
> +			goto out;
> +		}
> +		buf = new;
> +		new = map->ops->map_lookup_elem(map, &key);
> +		if (!new) {
> +			err = -ENOENT;
> +			goto out;
> +		}
> +		memcpy(buf + buf_sz, new, map->value_size);
> +		buf_sz += map->value_size;
> +	}
> +
> +	err = verify_pkcs7_signature(buf, buf_sz, sig, sig_len,
> +				     VERIFY_USE_SECONDARY_KEYRING,
> +				     VERIFYING_EBPF_SIGNATURE,
> +				     NULL, NULL);
> +out:
> +	kfree(buf);
> +	return err;
> +}
> +
> +static int hornet_check_binary(struct bpf_prog *prog, union bpf_attr *attr,
> +			       struct hornet_maps *maps)
> +{
> +	struct file *file = get_task_exe_file(current);

We should handle get_task_exe_file() returning NULL. I don't think it is likely
to happen when passing `current` but kernel_read_file() doesn't protect against
it and we'll have a NULL pointer dereference when it calls file_inode(NULL).

> +	const unsigned long markerlen = sizeof(EBPF_SIG_STRING) - 1;
> +	void *buf = NULL;
> +	size_t sz = 0, sig_len, prog_len, buf_sz;
> +	int err = 0;
> +	struct module_signature sig;
> +
> +	buf_sz = kernel_read_file(file, 0, &buf, INT_MAX, &sz, READING_EBPF);

We are leaking buf in this function. kernel_read_file() allocates the memory
for us but we never kfree(buf).

> +	fput(file);
> +	if (!buf_sz)
> +		return -1;
> +
> +	prog_len = buf_sz;
> +
> +	if (prog_len > markerlen &&
> +	    memcmp(buf + prog_len - markerlen, EBPF_SIG_STRING, markerlen) == 0)
> +		prog_len -= markerlen;

Why is the marker optional? Looking at module_sig_check(), which verifies the
signature on kernel modules, I see that it refuses to proceed if the marker is
not found. Should we do the same and refuse to operate on any unexpected input?

> +
> +	memcpy(&sig, buf + (prog_len - sizeof(sig)), sizeof(sig));

We should make sure that prog_len is larger than sizeof(sig) prior to this
memcpy(). It is probably not a real issue in practice but it would be good to
ensure that we can't be tricked to copy and operate on any bytes proceeding
buf.

Tyler

> +	sig_len = be32_to_cpu(sig.sig_len);
> +	prog_len -= sig_len + sizeof(sig);
> +
> +	err = mod_check_sig(&sig, prog->len * sizeof(struct bpf_insn), "ebpf");
> +	if (err)
> +		return err;
> +	return hornet_verify_lskel(prog, maps, buf + prog_len, sig_len);
> +}

