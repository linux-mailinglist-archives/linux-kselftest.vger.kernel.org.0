Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C0C5BC101
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Sep 2022 03:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiISB16 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 18 Sep 2022 21:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiISB15 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 18 Sep 2022 21:27:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AA418382
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Sep 2022 18:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663550874;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mTlHJkSe2zwoVsxiCcbcUXVRXRosTOKrm+znhbWqwWI=;
        b=jEltpuvKknpBGp2cG2u1cMyzrj1eg8rsEbnPgeJTzymA+xbTg4qpVQzwSDC8k1GqfwwpHV
        EVDA875PpEGOdw3uImdznLxY5NikTzuCor4FOAi2MfF1hecXUISC+AsfZe43vtfjPREsDJ
        zyzH/Ezs6zBMHF1v+FuEBZoqEpTAe+A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-Iy3PoTvROFe09ARVEqroCA-1; Sun, 18 Sep 2022 21:27:51 -0400
X-MC-Unique: Iy3PoTvROFe09ARVEqroCA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 568FE85A583;
        Mon, 19 Sep 2022 01:27:50 +0000 (UTC)
Received: from [10.64.54.126] (vpn2-54-126.bne.redhat.com [10.64.54.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A6E5A40C6EC2;
        Mon, 19 Sep 2022 01:27:42 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v2 2/5] KVM: arm64: Enable ring-based dirty memory
 tracking
To:     kernel test robot <lkp@intel.com>, kvmarm@lists.cs.columbia.edu
Cc:     kbuild-all@lists.01.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, catalin.marinas@arm.com,
        linux-kselftest@vger.kernel.org, bgardon@google.com,
        shuah@kernel.org, corbet@lwn.net, maz@kernel.org,
        drjones@redhat.com, will@kernel.org, zhenyzha@redhat.com,
        dmatlack@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        peterx@redhat.com, oliver.upton@linux.dev, shan.gavin@gmail.com
References: <20220916045135.154505-3-gshan@redhat.com>
 <202209180726.FLL69aKA-lkp@intel.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <fbf2bbe6-06d7-8e06-3f7f-04ca01d604c0@redhat.com>
Date:   Mon, 19 Sep 2022 11:27:40 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <202209180726.FLL69aKA-lkp@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/18/22 1:10 AM, kernel test robot wrote:
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on kvm/queue]
> [also build test WARNING on kvmarm/next linus/master v6.0-rc5 next-20220916]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Gavin-Shan/KVM-arm64-Enable-ring-based-dirty-memory-tracking/20220916-125417
> base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
> config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220918/202209180726.FLL69aKA-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/a1a4cd8f6a5e8927f800baff7d965870a1b7d7ba
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Gavin-Shan/KVM-arm64-Enable-ring-based-dirty-memory-tracking/20220916-125417
>          git checkout a1a4cd8f6a5e8927f800baff7d965870a1b7d7ba
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> arch/arm64/kvm/../../../virt/kvm/dirty_ring.c:14:12: warning: no previous prototype for 'kvm_cpu_dirty_log_size' [-Wmissing-prototypes]
>        14 | int __weak kvm_cpu_dirty_log_size(void)
>           |            ^~~~~~~~~~~~~~~~~~~~~~
> 
> 

[...]

Thanks for reporting the issue. The weak function needn't to be overrided by
ARM64. In v3, I will have a separate patch to fix the issue by moving its
declaration to kvm_dirty_ring.h.

Thanks,
Gavin


