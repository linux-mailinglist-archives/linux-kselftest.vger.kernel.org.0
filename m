Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EF829DC1E
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Oct 2020 01:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgJ2AUJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Oct 2020 20:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgJ2ATo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Oct 2020 20:19:44 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFDFC0613CF;
        Wed, 28 Oct 2020 17:19:44 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id w191so1521379oif.2;
        Wed, 28 Oct 2020 17:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=daqGeah5qeywVoAuLBg8Y6KIKasDVKjxTXjK84iaWEs=;
        b=HVrer6T7d0T+GjdVSj+2+Dz2/JPNeBULNRibNIUtYid9vS5do7nuoExI4yDQTvZXTM
         T696F2zaQ235UYis8VfguwT83/U618FNpLg2t2EI6Heuk6izgP5W0mUlfoGd89bMDYk4
         81JmM7cPbe+hnE8WF1AX5L8Qa8fhs+Pb32FkVrObEXYhS/1cYCb64pyEA5XxgF4oZlrf
         /IWxHFHhZdyNkQGDXNwRn3Di31qTkCZbInc2LvPnhrtN2TTJ6j0nPZ1bhMjfMd0PpniC
         DGQxn64JdNsTLdAMFA4Mh5pkCsHmRw8ebkOVtyOCdFPxN2Xdk8bwfHmgK/daFNDWlcca
         TNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=daqGeah5qeywVoAuLBg8Y6KIKasDVKjxTXjK84iaWEs=;
        b=BDXhB7LQry6/SsNsJzeE6+hLTP1ZrAYgZAiLPPMgPWoTh42f6BicZ7zzch4Sr15O6H
         7SFYXJreYVMQwGoa2j85Yf3WlK7NnOYqo8rfV/Tx9NlrlTW7xnBy1eLH8c9VZBIuMyZo
         hdc2yggrH/bRLxVBuFHLHjxq1cVf+VnkSJciTbgMybDQWe8TWBJ9SKWpSkEbSl9qylb8
         wCFNwcqsSJ816JH9LUTLieD1Y6pv1TD8bTQkhrjISWaVMve1MPqiUlG4Jliglr8tjzkg
         18rbkaRu0XrIodmcaOthXIHdsmjTmWiw632r47FgiVtS7tMd4vcAkCPeUNOFpz/TfdS6
         ecIA==
X-Gm-Message-State: AOAM531rXiSd7StZPFZaRXRwvYXb27bVCKyS4ec7o+jizl3Qn/E51q1E
        KOnoC0mkQE7OqC2eLGsrQzvEnz1o2nTDGOiV
X-Google-Smtp-Source: ABdhPJx2kNXlO2vhAlZ0BqC2uYccLNQAvRVJpNEnBI1Oj2F7U+swuUQXYjsqEpJFyyFeT1tdUPqQ1w==
X-Received: by 2002:a17:90a:4488:: with SMTP id t8mr5655128pjg.43.1603874853693;
        Wed, 28 Oct 2020 01:47:33 -0700 (PDT)
Received: from [192.168.86.81] ([106.51.242.167])
        by smtp.gmail.com with ESMTPSA id ei4sm4414196pjb.4.2020.10.28.01.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 01:47:33 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] fs: ext4: Modify inode-test.c to use KUnit
 parameterized testing feature
To:     Marco Elver <elver@google.com>, kernel test robot <lkp@intel.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        skhan@linuxfoundation.org, Iurii Zaikin <yzaikin@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        kbuild-all@lists.01.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20201027174726.85284-1-98.arpi@gmail.com>
 <202010280748.WUyq8OoJ-lkp@intel.com>
 <CANpmjNON4e6Gh7-NQw4CT4e--vOrH_rFyGi9U9TiUNS_zn+_vw@mail.gmail.com>
From:   Arpitha Raghunandan <98.arpi@gmail.com>
Message-ID: <2721816d-53da-fa8a-d017-fe05bf6cb099@gmail.com>
Date:   Wed, 28 Oct 2020 14:17:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANpmjNON4e6Gh7-NQw4CT4e--vOrH_rFyGi9U9TiUNS_zn+_vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 28/10/20 2:00 pm, Marco Elver wrote:
> On Wed, 28 Oct 2020 at 00:50, kernel test robot <lkp@intel.com> wrote:
>>
>> Hi Arpitha,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on ext4/dev]
>> [also build test WARNING on linus/master v5.10-rc1 next-20201027]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Arpitha-Raghunandan/kunit-Support-for-Parameterized-Testing/20201028-015018
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
>> config: mips-randconfig-r016-20201027 (attached as .config)
>> compiler: mipsel-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # https://github.com/0day-ci/linux/commit/2de1e52708cd83d1dc4c718876683f6809045a98
>>         git remote add linux-review https://github.com/0day-ci/linux
>>         git fetch --no-tags linux-review Arpitha-Raghunandan/kunit-Support-for-Parameterized-Testing/20201028-015018
>>         git checkout 2de1e52708cd83d1dc4c718876683f6809045a98
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>    In file included from fs/ext4/inode-test.c:7:
>>    fs/ext4/inode-test.c: In function 'ext4_inode_gen_params':
>>>> include/kunit/test.h:1735:58: warning: return discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>>     1735 |   return __next - (array) < ARRAY_SIZE((array)) ? __next : NULL;   \
>>    fs/ext4/inode-test.c:214:1: note: in expansion of macro 'KUNIT_ARRAY_PARAM'
>>      214 | KUNIT_ARRAY_PARAM(ext4_inode, test_data);
>>          | ^~~~~~~~~~~~~~~~~
> 
> So this means we probably want to make the param_value, and the return
> and prev types of the generator "const void*".
> 
> Thanks,
> -- Marco
> 

Okay, I'll fix this.
Thanks!
