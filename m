Return-Path: <linux-kselftest+bounces-184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 745407ED5E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 22:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44E61C2093E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 21:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2270364D1;
	Wed, 15 Nov 2023 21:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQ/yAiIj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8713ECE
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 13:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700083086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+AAJRoNFb+NoS3KMWG2rvbhxYwWgV66EeFRyHv0H4g=;
	b=QQ/yAiIj8WIZ12XYPOKmoZn4Ilh6vQqD5YpGd+Do5OqZKcgtBdcGY/XqH4YJx9UOLrx0vp
	01LWAd/5opqwCR22Cq4FwYQKuMGE7vswX4HrmHXUww4l0keelr0nGyeBwWWcsGnPucb1K8
	WvCv1cr3PEMsgN/6ZpwsKuoLHjqw9Rs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-8rha03oRNsqcXim3L5cd9Q-1; Wed, 15 Nov 2023 16:18:03 -0500
X-MC-Unique: 8rha03oRNsqcXim3L5cd9Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB46085CBE1;
	Wed, 15 Nov 2023 21:18:01 +0000 (UTC)
Received: from [10.22.9.184] (unknown [10.22.9.184])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 24A9B40C6EB9;
	Wed, 15 Nov 2023 21:18:01 +0000 (UTC)
Message-ID: <6c4ac1fb-f53a-496b-bab6-07e70c2197c7@redhat.com>
Date: Wed, 15 Nov 2023 16:18:01 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] workqueue: Make workqueue_set_unbound_cpumask()
 static
To: kernel test robot <lkp@intel.com>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jonathan Corbet <corbet@lwn.net>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Peter Hunt <pehunt@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20231115170359.163299-2-longman@redhat.com>
 <202311160353.FAdfQwO3-lkp@intel.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <202311160353.FAdfQwO3-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


On 11/15/23 14:12, kernel test robot wrote:
> Hi Waiman,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on shuah-kselftest/next]
> [also build test WARNING on shuah-kselftest/fixes linus/master v6.7-rc1]
> [cannot apply to tj-cgroup/for-next tj-wq/for-next next-20231115]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Waiman-Long/workqueue-Make-workqueue_set_unbound_cpumask-static/20231116-010940
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
> patch link:    https://lore.kernel.org/r/20231115170359.163299-2-longman%40redhat.com
> patch subject: [PATCH v3 1/5] workqueue: Make workqueue_set_unbound_cpumask() static
> config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20231116/202311160353.FAdfQwO3-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160353.FAdfQwO3-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311160353.FAdfQwO3-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>>> kernel/workqueue.c:4421:13: warning: 'apply_wqattrs_unlock' defined but not used [-Wunused-function]
>      4421 | static void apply_wqattrs_unlock(void)
>           |             ^~~~~~~~~~~~~~~~~~~~
>>> kernel/workqueue.c:4414:13: warning: 'apply_wqattrs_lock' defined but not used [-Wunused-function]
>      4414 | static void apply_wqattrs_lock(void)
>           |             ^~~~~~~~~~~~~~~~~~
>
>
> vim +/apply_wqattrs_unlock +4421 kernel/workqueue.c
>
> 8864b4e59f7945 Tejun Heo                 2013-03-12  4413
> a0111cf6710bd1 Lai Jiangshan             2015-05-19 @4414  static void apply_wqattrs_lock(void)
> a0111cf6710bd1 Lai Jiangshan             2015-05-19  4415  {
> a0111cf6710bd1 Lai Jiangshan             2015-05-19  4416  	/* CPUs should stay stable across pwq creations and installations */
> ffd8bea81fbb5a Sebastian Andrzej Siewior 2021-08-03  4417  	cpus_read_lock();
> a0111cf6710bd1 Lai Jiangshan             2015-05-19  4418  	mutex_lock(&wq_pool_mutex);
> a0111cf6710bd1 Lai Jiangshan             2015-05-19  4419  }
> a0111cf6710bd1 Lai Jiangshan             2015-05-19  4420
> a0111cf6710bd1 Lai Jiangshan             2015-05-19 @4421  static void apply_wqattrs_unlock(void)
> a0111cf6710bd1 Lai Jiangshan             2015-05-19  4422  {
> a0111cf6710bd1 Lai Jiangshan             2015-05-19  4423  	mutex_unlock(&wq_pool_mutex);
> ffd8bea81fbb5a Sebastian Andrzej Siewior 2021-08-03  4424  	cpus_read_unlock();
> a0111cf6710bd1 Lai Jiangshan             2015-05-19  4425  }
> a0111cf6710bd1 Lai Jiangshan             2015-05-19  4426
>
OK, there are more functions that are CONFIG_SYSFS specific and need to 
be moved as well.

Will post another version to fix that :-(

Regards,
Longman


