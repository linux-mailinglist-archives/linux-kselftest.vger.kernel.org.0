Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A741173D61E
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 05:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjFZDHg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 23:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFZDHe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 23:07:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EE2133;
        Sun, 25 Jun 2023 20:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687748854; x=1719284854;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vfwCfFpazuFdAYa86uv5p39Z9QwI0hlOweK8Ngh06zU=;
  b=AUXsvY3u/2EOPg1WNGTNzDlN+LphvCbTvoLmy7pRYftPJI19BHNW2GHQ
   AKX06iWm3UYeBs65Pn8kNvhr38vXr6gApIDPwNpaqeUnEDKIrSdsdRygs
   pk7ttkZJl9cBBObb1k1x41ZuBYwlwhLIpQP/DhllxjsmCNP+O3+8YM9or
   7784IhYloLmsbmtMJ3/nHqAOF4gc1y/0mci2LWMe1AYfw5Psz5qlZid6N
   LYc8AiQKzx1YGVYgbOBMeBP7gCjP62qwBUYeZE+t7Z2mG+IK5rPonnG7s
   8iBMXz53sAs7KaL2nD3ou97Gv3oMkYVenqjDGcA28Acp5gDuW6+zUVkJZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="341499759"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="341499759"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 20:07:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="710083086"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="710083086"
Received: from dbkinder-mobl.amr.corp.intel.com (HELO [10.212.241.20]) ([10.212.241.20])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 20:07:33 -0700
Message-ID: <cdd04046-4bcb-d6fd-1688-0a85546e7b91@linux.intel.com>
Date:   Sun, 25 Jun 2023 20:07:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v3 0/3] TDX Guest Quote generation support
To:     Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Chong Cai <chongc@google.com>, Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <64966b842becf_142af8294a5@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <64966b842becf_142af8294a5@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 6/23/23 9:05 PM, Dan Williams wrote:
> Kuppuswamy Sathyanarayanan wrote:
>> Hi All,
>>
>> In TDX guest, the attestation process is used to verify the TDX guest
>> trustworthiness to other entities before provisioning secrets to the
>> guest.
>>
>> The TDX guest attestation process consists of two steps:
>>
>> 1. TDREPORT generation
>> 2. Quote generation.
>>
>> The First step (TDREPORT generation) involves getting the TDX guest
>> measurement data in the format of TDREPORT which is further used to
>> validate the authenticity of the TDX guest. The second step involves
>> sending the TDREPORT to a Quoting Enclave (QE) server to generate a
>> remotely verifiable Quote. TDREPORT by design can only be verified on
>> the local platform. To support remote verification of the TDREPORT,
>> TDX leverages Intel SGX Quoting Enclave to verify the TDREPORT
>> locally and convert it to a remotely verifiable Quote. Although
>> attestation software can use communication methods like TCP/IP or
>> vsock to send the TDREPORT to QE, not all platforms support these
>> communication models. So TDX GHCI specification [1] defines a method
>> for Quote generation via hypercalls. Please check the discussion from
>> Google [2] and Alibaba [3] which clarifies the need for hypercall based
>> Quote generation support. This patch set adds this support.
>>
>> Support for TDREPORT generation already exists in the TDX guest driver. 
>> This patchset extends the same driver to add the Quote generation
>> support.
> 
> I missed that the TDREPORT ioctl() and this character device are already
> upstream. The TDREPORT ioctl() if it is only needed for quote generation
> seems a waste because it just retrieves a blob that needs to be turned
> around and injected back into the kernel to generate a quote.

Although the end goal is to generate the quote, the method the user chooses to
achieve it may differ for a variety of reasons. In this case, we're trying to
support the use case where the user will use methods like TCP/IP or vsock to
generate the Quote. They can use the GET_REPORT IOCTL to get the TDREPORT and
send it to the quoting enclave via the above-mentioned methods.  TDVMCALL-based
quote generation is intended for users who, for a variety of security reasons, do
not wish to use the methods described above.



-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
