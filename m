Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4609857D47A
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jul 2022 22:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiGUUCw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jul 2022 16:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGUUCv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jul 2022 16:02:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2516D9DF;
        Thu, 21 Jul 2022 13:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658433770; x=1689969770;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AIWDz8Enaa2pqpdX9by6W/d9pncH2KZT3VuoAKhnMMQ=;
  b=S/FmKkp7XEkBXyXOBlOvv1xNXiw2VmxsIvwjJKW//8hkVZgctWSxG0xV
   U1x6B9Y3mXhdKr0SXJPeMsj0cO3n2BGWuO/9dcT5z9g7iVytUUYri8Zp8
   ig3fTI7rVr9zFdMxkzXgsWTeKkosAfm7smYqtWHCLUb3qHszPgzQM8Cxf
   JkyhEn2y9tJJ/nZ4aoMojnjWZrReT/D4+6Yqx9YdPgWbw0aP5y9+KsNzi
   d9aFfa1Z7Y8wAXrxRufP35sYPkv6F6WH5GpU2/YzPljtmxIUHw2tgFZDe
   ka/VWuNJtBj21UbmsLhxsBZXez1oKWbF+7LfWhdsOjDEU8Mqw47pGhK+c
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="312879813"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="312879813"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 13:02:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="573889640"
Received: from vasantgx-mobl.amr.corp.intel.com (HELO [10.212.244.191]) ([10.212.244.191])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 13:02:48 -0700
Message-ID: <bf154be9-1cc0-a555-47f5-04e5df1d6c31@intel.com>
Date:   Thu, 21 Jul 2022 13:02:48 -0700
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220721194041.43970-1-kristen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/21/22 12:40, Kristen Carlson Accardi wrote:
> OpenSSL 3.0 deprecates some of the functions used in the SGX
> selftests, causing build errors on new distros. For now ignore
> the warnings until support for the functions is no longer
> available.

Are there some better functions we should be moving to?
