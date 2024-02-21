Return-Path: <linux-kselftest+bounces-5132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2161585CFA9
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 06:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56DBAB212AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 05:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355CA39AFE;
	Wed, 21 Feb 2024 05:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HArRftZA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB4639AF1
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708493477; cv=none; b=cUsGEGrK8cGbRGQf+xe9PnErrhdj1az1M1w8O1chQcv4tHywsQ3II7BgBMj593A+Nw7VuSqG8aX8t2KfyMVBhM3dz7vXp5hnVSIDvQFDLGV8Q8yTpHhW/IVz06vaMtW1C0sX46kaONp58qMrYlnNfjCSNk0tCYXyCREvng+tFqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708493477; c=relaxed/simple;
	bh=4kNUkPSsZ6NwsVXrjkUeOW8afEalspPvKs5WE0LwN4c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DG6pYDGJqV5g/8ZM3ply9EZeHysry+PBHawAPp/jgxPpfO2zba1TkRi3f7tQ+yaTF9eVPCIvUNT1LneiXP4BGBNpe1PASQYnjm68RI7hW6NvCdXcjk7xqe7j0HuDZS9LrhYOj2oXUbBGmVT8GdDkpOF5fee5apXI0FwQ08ohOB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HArRftZA; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3566c0309fso732605066b.1
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 21:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708493473; x=1709098273; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ee8UGbAfInlRw0mmY32iabqom41XT4N0g5e35WXpWiI=;
        b=HArRftZAYJ8B3wxTmNgb1/Orax37uyijt/C68U4lmJFxHfL72EcJveWuGQf9qsYGEh
         VJqbvZ1PQtcVtp97h17qteUjsOUqKjGwJXhECjXVKtMskUcErJmcVeNJh0xUsdrgrFo0
         UBKgsQXyOpRZDISgFr0mgLT47hxrGWxpE4AbLmcSkm8oAEQ5W+Ass+UgyIGhIPrUgHpX
         Ok/eElGpKQ+qlK0qAXZlIki3kgeXMssZHpc63EeLvriCfgxa2+xYSF+W5WiUScJhzrLQ
         O7WAWqstsFO5//3lSV/dQJFYFyWOa9G+FBd+0dnrDOmXPtDKr8XjsYmc21Aa1Mwy+myH
         /IXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708493473; x=1709098273;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ee8UGbAfInlRw0mmY32iabqom41XT4N0g5e35WXpWiI=;
        b=GcMK6InhxeRxzVDvTEkvMvN6YSV17Vdvh6oiax28vgB8nexd/RcP4sEBD4PMW05wXD
         xt3+FT0M7DwUd5pk5py3Wt/GNtc+KHiJKx7LPjySg+ZuVIPlDa9QYBWkehm8FDEQv6xz
         qXwNmuYO3jOIyu3zWs8/F8TGEFP8XdtsVEBDzNP/TYGcFbBNt/62qxrN2DNSlfwUkfm5
         cWLejpx+SscsHTXzhByQiruim/2pfIrCAlKxSO1LHT2797yBafUQIj1vlIiTLarnzrC0
         JeRP94mRAqJiVoc5uCBfzB1+tVyXMqa6Z7Rdq+QOpYnYBp/Zsk6o5GKF3WdJqfB++a2/
         ZsUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj9We/DHACqygPiIduXHPsBbYyCa+JbYqbo7vbzQfiHIhxYtBHhX2f9hdmGBX84pe+3ewRlnlMPmST/SdTuNOD9AljhHeq/njHKhOsQaHZ
X-Gm-Message-State: AOJu0YywqXjxwsbbLkI8upzwiBOaCdFl4MMtpheqxBDltcKRCpn+VS7i
	ruVdL4FNdfpVm40XonGEd81FF3Dg8RWK2sr5jxVps5MnkD9ulDM9VBlfDgx6ZZ0=
X-Google-Smtp-Source: AGHT+IEq1eFtTNdd/bmaa3GnlDQllZezHXuoSDlWDXRfmFI1MDpUwA5PpLIhedjCVEADYrw9jNbQjg==
X-Received: by 2002:a17:906:b18e:b0:a3e:8972:4404 with SMTP id w14-20020a170906b18e00b00a3e89724404mr4985261ejy.9.1708493473094;
        Tue, 20 Feb 2024 21:31:13 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ov28-20020a170906fc1c00b00a3cf9b832eesm4587301ejb.40.2024.02.20.21.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 21:31:12 -0800 (PST)
Date: Wed, 21 Feb 2024 08:31:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Menglong Dong <dongmenglong.8@bytedance.com>,
	andrii@kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	thinker.li@gmail.com, dongmenglong.8@bytedance.com,
	zhoufeng.zf@bytedance.com, davemarchevsky@fb.com, dxu@dxuuu.xyz,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH bpf-next 2/5] bpf: tracing: support to attach program to
 multi hooks
Message-ID: <d0607bff-b589-4548-98e1-a94d227b4e93@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240220035105.34626-3-dongmenglong.8@bytedance.com>

Hi Menglong,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/bpf-tracing-add-support-to-record-and-check-the-accessed-args/20240220-115317
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240220035105.34626-3-dongmenglong.8%40bytedance.com
patch subject: [PATCH bpf-next 2/5] bpf: tracing: support to attach program to multi hooks
config: m68k-randconfig-r071-20240220 (https://download.01.org/0day-ci/archive/20240221/202402210534.siGKEfus-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202402210534.siGKEfus-lkp@intel.com/

smatch warnings:
kernel/bpf/syscall.c:3325 bpf_tracing_prog_attach() warn: passing zero to 'PTR_ERR'
kernel/bpf/syscall.c:3485 bpf_tracing_prog_attach() error: uninitialized symbol 'link'.

vim +/PTR_ERR +3325 kernel/bpf/syscall.c

4a1e7c0c63e02d Toke Høiland-Jørgensen 2020-09-29  3255  static int bpf_tracing_prog_attach(struct bpf_prog *prog,
4a1e7c0c63e02d Toke Høiland-Jørgensen 2020-09-29  3256  				   int tgt_prog_fd,
2fcc82411e74e5 Kui-Feng Lee           2022-05-10  3257  				   u32 btf_id,
2fcc82411e74e5 Kui-Feng Lee           2022-05-10  3258  				   u64 bpf_cookie)
fec56f5890d93f Alexei Starovoitov     2019-11-14  3259  {
a3b80e1078943d Andrii Nakryiko        2020-04-28  3260  	struct bpf_link_primer link_primer;
3aac1ead5eb6b7 Toke Høiland-Jørgensen 2020-09-29  3261  	struct bpf_prog *tgt_prog = NULL;
4a1e7c0c63e02d Toke Høiland-Jørgensen 2020-09-29  3262  	struct bpf_trampoline *tr = NULL;
5f80eb32851d7a Menglong Dong          2024-02-20  3263  	struct btf *attach_btf = NULL;
70ed506c3bbcfa Andrii Nakryiko        2020-03-02  3264  	struct bpf_tracing_link *link;
5f80eb32851d7a Menglong Dong          2024-02-20  3265  	struct module *mod = NULL;
4a1e7c0c63e02d Toke Høiland-Jørgensen 2020-09-29  3266  	u64 key = 0;
a3b80e1078943d Andrii Nakryiko        2020-04-28  3267  	int err;
fec56f5890d93f Alexei Starovoitov     2019-11-14  3268  
9e4e01dfd3254c KP Singh               2020-03-29  3269  	switch (prog->type) {
9e4e01dfd3254c KP Singh               2020-03-29  3270  	case BPF_PROG_TYPE_TRACING:
fec56f5890d93f Alexei Starovoitov     2019-11-14  3271  		if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
be8704ff07d237 Alexei Starovoitov     2020-01-20  3272  		    prog->expected_attach_type != BPF_TRACE_FEXIT &&
9e4e01dfd3254c KP Singh               2020-03-29  3273  		    prog->expected_attach_type != BPF_MODIFY_RETURN) {
9e4e01dfd3254c KP Singh               2020-03-29  3274  			err = -EINVAL;
9e4e01dfd3254c KP Singh               2020-03-29  3275  			goto out_put_prog;
9e4e01dfd3254c KP Singh               2020-03-29  3276  		}
9e4e01dfd3254c KP Singh               2020-03-29  3277  		break;
9e4e01dfd3254c KP Singh               2020-03-29  3278  	case BPF_PROG_TYPE_EXT:
9e4e01dfd3254c KP Singh               2020-03-29  3279  		if (prog->expected_attach_type != 0) {
9e4e01dfd3254c KP Singh               2020-03-29  3280  			err = -EINVAL;
9e4e01dfd3254c KP Singh               2020-03-29  3281  			goto out_put_prog;
9e4e01dfd3254c KP Singh               2020-03-29  3282  		}
9e4e01dfd3254c KP Singh               2020-03-29  3283  		break;
9e4e01dfd3254c KP Singh               2020-03-29  3284  	case BPF_PROG_TYPE_LSM:
9e4e01dfd3254c KP Singh               2020-03-29  3285  		if (prog->expected_attach_type != BPF_LSM_MAC) {
9e4e01dfd3254c KP Singh               2020-03-29  3286  			err = -EINVAL;
9e4e01dfd3254c KP Singh               2020-03-29  3287  			goto out_put_prog;
9e4e01dfd3254c KP Singh               2020-03-29  3288  		}
9e4e01dfd3254c KP Singh               2020-03-29  3289  		break;
9e4e01dfd3254c KP Singh               2020-03-29  3290  	default:
fec56f5890d93f Alexei Starovoitov     2019-11-14  3291  		err = -EINVAL;
fec56f5890d93f Alexei Starovoitov     2019-11-14  3292  		goto out_put_prog;
fec56f5890d93f Alexei Starovoitov     2019-11-14  3293  	}
fec56f5890d93f Alexei Starovoitov     2019-11-14  3294  
4a1e7c0c63e02d Toke Høiland-Jørgensen 2020-09-29  3295  	if (tgt_prog_fd) {
5f80eb32851d7a Menglong Dong          2024-02-20  3296  		if (!btf_id) {
4a1e7c0c63e02d Toke Høiland-Jørgensen 2020-09-29  3297  			err = -EINVAL;
4a1e7c0c63e02d Toke Høiland-Jørgensen 2020-09-29  3298  			goto out_put_prog;
4a1e7c0c63e02d Toke Høiland-Jørgensen 2020-09-29  3299  		}
4a1e7c0c63e02d Toke Høiland-Jørgensen 2020-09-29  3300  		tgt_prog = bpf_prog_get(tgt_prog_fd);
4a1e7c0c63e02d Toke Høiland-Jørgensen 2020-09-29  3301  		if (IS_ERR(tgt_prog)) {
4a1e7c0c63e02d Toke Høiland-Jørgensen 2020-09-29  3302  			tgt_prog = NULL;
5f80eb32851d7a Menglong Dong          2024-02-20  3303  			/* tgt_prog_fd is the fd of the kernel module BTF */
5f80eb32851d7a Menglong Dong          2024-02-20  3304  			attach_btf = btf_get_by_fd(tgt_prog_fd);
5f80eb32851d7a Menglong Dong          2024-02-20  3305  			if (IS_ERR(attach_btf)) {
5f80eb32851d7a Menglong Dong          2024-02-20  3306  				attach_btf = NULL;
5f80eb32851d7a Menglong Dong          2024-02-20  3307  				err = -EINVAL;
4a1e7c0c63e02d Toke Høiland-Jørgensen 2020-09-29  3308  				goto out_put_prog;
4a1e7c0c63e02d Toke Høiland-Jørgensen 2020-09-29  3309  			}
5f80eb32851d7a Menglong Dong          2024-02-20  3310  			if (!btf_is_kernel(attach_btf)) {
5f80eb32851d7a Menglong Dong          2024-02-20  3311  				btf_put(attach_btf);
5f80eb32851d7a Menglong Dong          2024-02-20  3312  				err = -EOPNOTSUPP;
5f80eb32851d7a Menglong Dong          2024-02-20  3313  				goto out_put_prog;
5f80eb32851d7a Menglong Dong          2024-02-20  3314  			}
5f80eb32851d7a Menglong Dong          2024-02-20  3315  		} else if (prog->type == BPF_PROG_TYPE_TRACING &&
5f80eb32851d7a Menglong Dong          2024-02-20  3316  			   tgt_prog->type == BPF_PROG_TYPE_TRACING) {
5f80eb32851d7a Menglong Dong          2024-02-20  3317  			prog->aux->attach_tracing_prog = true;
5f80eb32851d7a Menglong Dong          2024-02-20  3318  		}
5f80eb32851d7a Menglong Dong          2024-02-20  3319  		key = bpf_trampoline_compute_key(tgt_prog, attach_btf,
5f80eb32851d7a Menglong Dong          2024-02-20  3320  						 btf_id);
5f80eb32851d7a Menglong Dong          2024-02-20  3321  	} else if (btf_id) {
5f80eb32851d7a Menglong Dong          2024-02-20  3322  		attach_btf = bpf_get_btf_vmlinux();
5f80eb32851d7a Menglong Dong          2024-02-20  3323  		if (IS_ERR(attach_btf)) {
5f80eb32851d7a Menglong Dong          2024-02-20  3324  			attach_btf = NULL;
                                                                                ^^^^^^^^^^^^^^^^^^
This needs to be done after the "err = " assignment on the next line.

5f80eb32851d7a Menglong Dong          2024-02-20 @3325  			err = PTR_ERR(attach_btf);
                                                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^
Here.

5f80eb32851d7a Menglong Dong          2024-02-20  3326  			goto out_unlock;
5f80eb32851d7a Menglong Dong          2024-02-20  3327  		}
5f80eb32851d7a Menglong Dong          2024-02-20  3328  		if (!attach_btf) {
5f80eb32851d7a Menglong Dong          2024-02-20  3329  			err = -EINVAL;
5f80eb32851d7a Menglong Dong          2024-02-20  3330  			goto out_unlock;

"link" is not initialized on this goto path so it leads to an
uninitialized variable warning.

5f80eb32851d7a Menglong Dong          2024-02-20  3331  		}
5f80eb32851d7a Menglong Dong          2024-02-20  3332  		btf_get(attach_btf);
5f80eb32851d7a Menglong Dong          2024-02-20  3333  		key = bpf_trampoline_compute_key(NULL, attach_btf, btf_id);
5f80eb32851d7a Menglong Dong          2024-02-20  3334  	} else {
5f80eb32851d7a Menglong Dong          2024-02-20  3335  		attach_btf = prog->aux->attach_btf;
5f80eb32851d7a Menglong Dong          2024-02-20  3336  		/* get the reference of the btf for bpf link */
5f80eb32851d7a Menglong Dong          2024-02-20  3337  		if (attach_btf)
5f80eb32851d7a Menglong Dong          2024-02-20  3338  			btf_get(attach_btf);
4a1e7c0c63e02d Toke Høiland-Jørgensen 2020-09-29  3339  	}
4a1e7c0c63e02d Toke Høiland-Jørgensen 2020-09-29  3340  
70ed506c3bbcfa Andrii Nakryiko        2020-03-02  3341  	link = kzalloc(sizeof(*link), GFP_USER);
70ed506c3bbcfa Andrii Nakryiko        2020-03-02  3342  	if (!link) {
70ed506c3bbcfa Andrii Nakryiko        2020-03-02  3343  		err = -ENOMEM;
70ed506c3bbcfa Andrii Nakryiko        2020-03-02  3344  		goto out_put_prog;
70ed506c3bbcfa Andrii Nakryiko        2020-03-02  3345  	}
f7e0beaf39d386 Kui-Feng Lee           2022-05-10  3346  	bpf_link_init(&link->link.link, BPF_LINK_TYPE_TRACING,
f2e10bff16a0fd Andrii Nakryiko        2020-04-28  3347  		      &bpf_tracing_link_lops, prog);
f2e10bff16a0fd Andrii Nakryiko        2020-04-28  3348  	link->attach_type = prog->expected_attach_type;
2fcc82411e74e5 Kui-Feng Lee           2022-05-10  3349  	link->link.cookie = bpf_cookie;
70ed506c3bbcfa Andrii Nakryiko        2020-03-02  3350  

[ snip ]

3aac1ead5eb6b7 Toke Høiland-Jørgensen 2020-09-29  3474  	prog->aux->dst_trampoline = NULL;
5f80eb32851d7a Menglong Dong          2024-02-20  3475  	prog->aux->mod = NULL;
3aac1ead5eb6b7 Toke Høiland-Jørgensen 2020-09-29  3476  	mutex_unlock(&prog->aux->dst_mutex);
3aac1ead5eb6b7 Toke Høiland-Jørgensen 2020-09-29  3477  
a3b80e1078943d Andrii Nakryiko        2020-04-28  3478  	return bpf_link_settle(&link_primer);
3aac1ead5eb6b7 Toke Høiland-Jørgensen 2020-09-29  3479  out_unlock:
4a1e7c0c63e02d Toke Høiland-Jørgensen 2020-09-29  3480  	if (tr && tr != prog->aux->dst_trampoline)
4a1e7c0c63e02d Toke Høiland-Jørgensen 2020-09-29  3481  		bpf_trampoline_put(tr);
5f80eb32851d7a Menglong Dong          2024-02-20  3482  	if (mod && mod != prog->aux->mod)
5f80eb32851d7a Menglong Dong          2024-02-20  3483  		module_put(mod);
3aac1ead5eb6b7 Toke Høiland-Jørgensen 2020-09-29  3484  	mutex_unlock(&prog->aux->dst_mutex);
3aac1ead5eb6b7 Toke Høiland-Jørgensen 2020-09-29 @3485  	kfree(link);
                                                                      ^^^^

fec56f5890d93f Alexei Starovoitov     2019-11-14  3486  out_put_prog:
4a1e7c0c63e02d Toke Høiland-Jørgensen 2020-09-29  3487  	if (tgt_prog_fd && tgt_prog)
4a1e7c0c63e02d Toke Høiland-Jørgensen 2020-09-29  3488  		bpf_prog_put(tgt_prog);
5f80eb32851d7a Menglong Dong          2024-02-20  3489  	btf_put(attach_btf);
fec56f5890d93f Alexei Starovoitov     2019-11-14  3490  	return err;
fec56f5890d93f Alexei Starovoitov     2019-11-14  3491  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


