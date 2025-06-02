Return-Path: <linux-kselftest+bounces-34121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35638ACA96C
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 08:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41DFD189570B
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 06:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3601993BD;
	Mon,  2 Jun 2025 06:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sSU7IPnO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267DF19993D
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748845219; cv=none; b=PTT2aCHyt/mYsnd8HkBvYAuCuiIdOOAIRR13qd/nVpwYMQmWa6l9XGBrEL1wixbVXhcVXHMALcYgpALPmdQpBcgB8GIpE+1JX+mFPF8uqenzhZdwnIZBXxVPqSA9H016ZrVs3It3hPsG3mGTPmc4CWc9kBT65DWD+qo0pgEf/Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748845219; c=relaxed/simple;
	bh=uqhiVvUTjJUz12WNnC5vQ4AYx38ysdEHyQ+YwgWYwRo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ic5Ghzok8rsRJzIKYlDD1CUIIyB7u0mH57yjOSME2hluaZQ+jhtTiMW65izqqlWuAIIWWZFtx8OGJFRNLmb4JWbSvbpAJFWvDyfUJalAcV1DYLp8ZsI8EMfkRs9DPeUsB/tqHc5OQuW1lY55xzRUEw9VBA9LZwC0zdwsrtoHzYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sSU7IPnO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so5402185e9.1
        for <linux-kselftest@vger.kernel.org>; Sun, 01 Jun 2025 23:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748845215; x=1749450015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tOEMUoWDeDY5mzeOr4SEl8dbwxhrqozXvwOKEHtHeUk=;
        b=sSU7IPnOUUi7yGcTpR5L7oLOSaKVyOCpIH90T675LubPUAtDorfV2PnXkARETVOF4E
         eSN21BtaPO4Mp3AboQeI7H5hEH9x+yuudFzdhZ+IGQe8mN4Eb3yDjXRYywwANhgBKPuD
         zmar0EDkt2RZmDoC4L5cW3BoNNUnhffc7AxjZ1AUc1sybPS27ySDo8Fu61u+rbgtVcMj
         WmMqNQf9DLHfYY0PsgSN69SvMfiXRmMi8Vbjv9weRrJKcyUhZZXgv2hajgB/hw4BwSoG
         Or1YGfToONsRlikOEfBQx5kAyQSaaIwvQ/AW4DG5BXD67E2STBTZgIYGmg99JuXluCF1
         rSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748845215; x=1749450015;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tOEMUoWDeDY5mzeOr4SEl8dbwxhrqozXvwOKEHtHeUk=;
        b=Z7qcjhJUq/fE3HPe8lM86HeXQe0EcFwaoBkIayExS841EQ67Y/ehbqLg0zbwdHFThg
         LwWvhsVniNghCMkZpR0z4rnDCSAvKNZDIaHlU6wskYt98erz4w8JohEFuOkCEHnvwM1O
         uvv7elvlF8Oro3jHDWxofooO5DJfco6HLh+dF4txnz+ccD6ijqzunyEZzDaPPgn2nCOB
         Vp8p5Z3GidR9ElpgtFBGo5qKzixI2DHr+rltf3kdtWy5IPXB0ctYtvyIBtVPef/p5cJD
         8WmIWIorSOUHDebUR+QkIFFSwNKuXmW2UtRfDOE7mQMAR4dD4mmKibKeFIzAsxgpYKHq
         Dvgw==
X-Forwarded-Encrypted: i=1; AJvYcCULHV0xULVXCpuGd74D98bD/7iPEh9CUTqb6MYWST8d7+BR5bT2Ubk4mqxPs6fAJN0OeW/K4h79VQEE5b7hF0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza1mOczv9C/DuSfPvJap+Yc2FS+Kwu1XtZfk5vopRpYIAlHj/J
	VvoL6UhGuhWj/DhnLqLyHYqpYykPtiANHUTmMiSvkxud7Qr+6ABBczcY0QmapvjcoQk=
X-Gm-Gg: ASbGncsXO7JyFBWIr5y7YuKZdTqtLxSleEeQHpxOGnQFG0jflLoxjbN4N0cmxRGeSJY
	3bkMmOzKK+W880aEAajr12gDvRBVsxeuB8vPKngv5M7KB23fxt8QyQqNEA3HnYPVnIOrN7Kr4zv
	3ja/PUo+cIuEPYzfNofQjRk8FclqGk7pTV/lH4aXsCr2Pf1cUjMssSgqbdig1qj3kbBLhi+g9Hp
	T4/ud2nBLmiNeDsqlpHQ9HpE4Wd8Z7YpQX92DTrrRryMYp0hlDwYtvyFQ+GBBSvclUXuOOPW7F4
	NSg5DW9Uuk0/kyCvBJTTomLUIgGYBdTEG27ulrtS2un7vn4iWU3U5LY=
X-Google-Smtp-Source: AGHT+IEhg9lSTzexUaVbkdcQrdyWsGg7a4BXZ1AHF91UKUvvwVHEH4xwEI9JAg73XATTsIBgax4M7A==
X-Received: by 2002:a05:600c:4f05:b0:43c:ea1a:720c with SMTP id 5b1f17b1804b1-4511ee13fb8mr65790875e9.18.1748845215311;
        Sun, 01 Jun 2025 23:20:15 -0700 (PDT)
Received: from localhost ([41.210.143.146])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-450d7fa24c6sm108973155e9.12.2025.06.01.23.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 23:20:14 -0700 (PDT)
Date: Mon, 2 Jun 2025 09:20:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Rong Tao <rtoax@foxmail.com>, ast@kernel.org,
	daniel@iogearbox.net
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, rtoax@foxmail.com,
	rongtao@cestc.cn, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Juntong Deng <juntong.deng@outlook.com>,
	Amery Hung <amery.hung@bytedance.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	Hou Tao <houtao1@huawei.com>,
	"(open list:BPF (Safe Dynamic Programs and Tools))" <bpf@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bpf_task_cwd_from_pid() kfunc
Message-ID: <202505300432.nZC50gOu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_97F8B56B340F51DB604B482FEBF012460505@qq.com>

Hi Rong,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Rong-Tao/selftests-bpf-Add-selftests-for-bpf_task_cwd_from_pid/20250529-113933
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/tencent_97F8B56B340F51DB604B482FEBF012460505%40qq.com
patch subject: [PATCH bpf-next 1/2] bpf: Add bpf_task_cwd_from_pid() kfunc
config: x86_64-randconfig-161-20250529 (https://download.01.org/0day-ci/archive/20250530/202505300432.nZC50gOu-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202505300432.nZC50gOu-lkp@intel.com/

smatch warnings:
kernel/bpf/helpers.c:2687 bpf_task_cwd_from_pid() warn: inconsistent returns 'rcu_read'.

vim +/rcu_read +2687 kernel/bpf/helpers.c

b24383bde5a454 Rong Tao     2025-05-29  2657  __bpf_kfunc int bpf_task_cwd_from_pid(s32 pid, char *buf, u32 buf_len)
b24383bde5a454 Rong Tao     2025-05-29  2658  {
b24383bde5a454 Rong Tao     2025-05-29  2659  	struct path pwd;
b24383bde5a454 Rong Tao     2025-05-29  2660  	char kpath[256], *path;
b24383bde5a454 Rong Tao     2025-05-29  2661  	struct task_struct *task;
b24383bde5a454 Rong Tao     2025-05-29  2662  
b24383bde5a454 Rong Tao     2025-05-29  2663  	if (!buf || buf_len == 0)
b24383bde5a454 Rong Tao     2025-05-29  2664  		return -EINVAL;
b24383bde5a454 Rong Tao     2025-05-29  2665  
b24383bde5a454 Rong Tao     2025-05-29  2666  	rcu_read_lock();
b24383bde5a454 Rong Tao     2025-05-29  2667  	task = pid_task(find_vpid(pid), PIDTYPE_PID);
b24383bde5a454 Rong Tao     2025-05-29  2668  	if (!task) {
b24383bde5a454 Rong Tao     2025-05-29  2669  		rcu_read_unlock();
b24383bde5a454 Rong Tao     2025-05-29  2670  		return -ESRCH;
b24383bde5a454 Rong Tao     2025-05-29  2671  	}
b24383bde5a454 Rong Tao     2025-05-29  2672  	task_lock(task);
b24383bde5a454 Rong Tao     2025-05-29  2673  	if (!task->fs) {
b24383bde5a454 Rong Tao     2025-05-29  2674  		task_unlock(task);
b24383bde5a454 Rong Tao     2025-05-29  2675  		return -ENOENT;

rcu_read_unlock();

b24383bde5a454 Rong Tao     2025-05-29  2676  	}
b24383bde5a454 Rong Tao     2025-05-29  2677  	get_fs_pwd(task->fs, &pwd);
b24383bde5a454 Rong Tao     2025-05-29  2678  	task_unlock(task);
b24383bde5a454 Rong Tao     2025-05-29  2679  	rcu_read_unlock();
b24383bde5a454 Rong Tao     2025-05-29  2680  
b24383bde5a454 Rong Tao     2025-05-29  2681  	path = d_path(&pwd, kpath, sizeof(kpath));
b24383bde5a454 Rong Tao     2025-05-29  2682  	path_put(&pwd);
b24383bde5a454 Rong Tao     2025-05-29  2683  	if (IS_ERR(path))
b24383bde5a454 Rong Tao     2025-05-29  2684  		return PTR_ERR(path);
b24383bde5a454 Rong Tao     2025-05-29  2685  
b24383bde5a454 Rong Tao     2025-05-29  2686  	strncpy(buf, path, buf_len);
b24383bde5a454 Rong Tao     2025-05-29 @2687  	return 0;
b24383bde5a454 Rong Tao     2025-05-29  2688  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


