Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320B84A00A3
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 20:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346566AbiA1THw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 14:07:52 -0500
Received: from mga09.intel.com ([134.134.136.24]:31437 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233548AbiA1THv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 14:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643396871; x=1674932871;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=Xhr2I5jreAMSepe/+u2qmZD3KWJtU4aKDTPRGAajGE8=;
  b=KRalCV3opgaXK5cWWW58Xz+f0ygCQ7Cy+dbmrJRxrkfzW9sINQcE5PVM
   qHwXQCJ/pUlEFq3GFZ6tiBa9Ena82HeAkY7Q760D7u2IQGRvLsTmDWUxf
   HhKHRe7xhEISW3MT9jIJcsNHu386GyIRpyktvTT88h1Gj7psLShQoV6kJ
   fjS10VPPDp8ympkslS9TeIlaaA6+gtBkaI3tC4pp2MpzmRCUaA6bzmZXt
   fq4eLFfz/rHpl73CfT7RolD/7ZPdm9EPgfFtOAD9dKROpSaLTmK66SToT
   Dynxld7dvTDsmPHOAY62hNi04jSIwJXGq1kna0cdoANmS+xaFWvCaUIA8
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="246952818"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="246952818"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 11:07:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="697187981"
Received: from zhenkuny-mobl2.amr.corp.intel.com (HELO [10.209.84.59]) ([10.209.84.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 11:07:18 -0800
Message-ID: <ab92b3be-24bf-6fc9-aefe-266aaa16846a@intel.com>
Date:   Fri, 28 Jan 2022 11:06:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.2
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, jarkko@kernel.org,
        dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org
References: <cover.1643393473.git.reinette.chatre@intel.com>
 <ddb6554a95b0978aa018740fbfb32f786bcbd284.1643393473.git.reinette.chatre@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 3/4] selftests/sgx: Ensure enclave data available during
 debug print
In-Reply-To: <ddb6554a95b0978aa018740fbfb32f786bcbd284.1643393473.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/28/22 10:23, Reinette Chatre wrote:
> In support of debugging the SGX tests print details from
> the enclave and its memory mappings if any failure is encountered
> during enclave loading.
> 
> When a failure is encountered no data is printed because the
> printing of the data is preceded by cleanup of the data.
> 
> Move the data cleanup after the data print.

Isn't it worse than that?

>  err:
> -	encl_delete(encl);
> -
>  	for (i = 0; i < encl->nr_segments; i++) {
>  		seg = &encl->segment_tbl[i];

encl_delete() does:

	free(encl->segment_tbl);

but doesn't zero encl->nr_segments from what I can see.  That seems like
a use-after-free.

Seems like we need to really run the selftest under valgrind.
