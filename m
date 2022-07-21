Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A3F57D4AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jul 2022 22:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiGUUOj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jul 2022 16:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGUUOj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jul 2022 16:14:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CD380508;
        Thu, 21 Jul 2022 13:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658434478; x=1689970478;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rQUBthPET6q5FGLNvCZ/F6J4F5U3JKEDaMppPwXUMck=;
  b=SpvBvvNWn0UJJtgT90AqZd77kvNsZ1YYO1SCH2xZ3xoSOOhk4SIE79j0
   GvIT1MuT5JOYXVdjOl7iIlJ+p0xboLy35OeQbgdMf2iyqn+StTn1RyCtA
   oIsW0zTpZslPgrKHjX0IH9+48oM9kfgce5gYPYdi4vlhnIuLN+TM2igIw
   LpYKj/Lf6kIFmQRsT6LLtwr9J41IH+SnM9HX1si8E7RBg/ysNblqEZvhv
   YOTGkDoPz8wUYIwzKgRSwOh8yY4K8gTJqtz3J2Ry5vvrZldfV0UbG6X2L
   f7MHX3sI5qD5G7G2J1WardhKV0owMVhiT9NQk2RA1+Kw6qADsURiIM7V2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="270198600"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="270198600"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 13:14:37 -0700
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="573893626"
Received: from vasantgx-mobl.amr.corp.intel.com (HELO [10.212.244.191]) ([10.212.244.191])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 13:14:37 -0700
Message-ID: <edc3b57b-f67c-b413-0ebc-40a4914a8bb6@intel.com>
Date:   Thu, 21 Jul 2022 13:14:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] selftests/sgx: Ignore OpenSSL 3.0 deprecated functions
 warning
Content-Language: en-US
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20220721194041.43970-1-kristen@linux.intel.com>
 <bf154be9-1cc0-a555-47f5-04e5df1d6c31@intel.com>
 <aa561e423906b175c73afbd6248a0a5dff0b079c.camel@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <aa561e423906b175c73afbd6248a0a5dff0b079c.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/21/22 13:08, Kristen Carlson Accardi wrote:
> On Thu, 2022-07-21 at 13:02 -0700, Dave Hansen wrote:
>> On 7/21/22 12:40, Kristen Carlson Accardi wrote:
>>> OpenSSL 3.0 deprecates some of the functions used in the SGX
>>> selftests, causing build errors on new distros. For now ignore
>>> the warnings until support for the functions is no longer
>>> available.
>> Are there some better functions we should be moving to?
> I looked into this actually as my first choice, but the problem I had
> was that the recommended new functions weren't available on other
> OpenSSL libraries, and we'd have to add compatibility macros and stuff,
> so it seemed to me that the less complicated thing to do was wait till
> OpenSSL 1 was just not widely deployed anymore. This strategy is also
> being used in other scripts in the kernel.

Sounds sane to me.  Thanks for the explanation.

