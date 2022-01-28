Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8829E4A00A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 20:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350710AbiA1THy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 14:07:54 -0500
Received: from mga17.intel.com ([192.55.52.151]:28644 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233548AbiA1THy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 14:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643396874; x=1674932874;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eFxN0UtY/vzByCM0BHOh2T2Q7qd+Nj8TWuAlCkRYGNA=;
  b=Nei7bLVGgZosGq+BBL1nDjCDJVwrQ3MKs/JQ9qra+XH/RcnNRw3Bp1oj
   OME2pQi3cieY1DF7zsW4MQs6yDVffcRtgd7RtbVO2TZGKeubrRpUfGoQv
   06rELCMrP7tv+kPrf1j6ud8v6FGvYrJxPDg2wbci8CUZhNgQOFoP0tEp8
   CpPQZVrayyRAmJr62pPGoCHKRoMWoW8KQr2uwbsQnB3i5oh8yN4iOY5CT
   I6Ci5XNqX+E11dlWM8vGlm3uLFqsOT3JTkXzD1HqoYEjYd3rD4RBSH3A6
   jWAtxiVeZkG96vX8lbtC1yXneO2WiG7Tv9igD2J5R1UQy721lwSh0O9Pb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="227850102"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="227850102"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 11:07:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="697188340"
Received: from zhenkuny-mobl2.amr.corp.intel.com (HELO [10.209.84.59]) ([10.209.84.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 11:07:52 -0800
Message-ID: <6542ccc7-53dd-e445-d5d1-79c51b1e4d9a@intel.com>
Date:   Fri, 28 Jan 2022 11:07:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.2
Subject: Re: [PATCH 4/4] selftests/sgx: Remove extra newlines in test output
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, jarkko@kernel.org,
        dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org
References: <cover.1643393473.git.reinette.chatre@intel.com>
 <699e4e1382e005386722bc296602d1b270a28b1e.1643393473.git.reinette.chatre@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <699e4e1382e005386722bc296602d1b270a28b1e.1643393473.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/28/22 10:23, Reinette Chatre wrote:
> The TH_LOG() macro is an optional debug logging function made
> available by kselftest itself. When TH_LOG_ENABLED is set it
> prints the provided message with additional information and
> formatting that already includes a newline.
> 
> Providing a newline to the message printed by TH_LOG() results
> in a double newline that produces irregular test output.
> 
> Remove the unnecessary newlines from the text provided to
> TH_LOG().

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
