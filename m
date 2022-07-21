Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B471857D4A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jul 2022 22:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiGUUIi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jul 2022 16:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGUUIh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jul 2022 16:08:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9682070E41;
        Thu, 21 Jul 2022 13:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658434116; x=1689970116;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=OccuQOvw58fitsF+Y9v7/Ek6LJ0XIfcSUxQyOpEgXCA=;
  b=MdHv1Z3RPkJD1PpqYPY5japJAmlIlW3WQKGAhI8HiGnggINjXJgjF0m4
   5E6v6mhDlc5qq9qwRR+J+D32LTKDSdXJCCmW/J4/Ibw5qwjiuFiFzSkBv
   enZduN2jq5yf/vkYfwAMuJSY47ng0lp/egnJAm8CkAnVxmmfVRISjbEaf
   6E5MWGR93zc6ZYUECm4U5v2qN8kIRHu7LVGDBcVzxoCbMEZgoKqcFjLKN
   IOHNScnZin02yDX9rAN24hKP/IAbQXU92mojA6TGKcrkv4vF9YAguPoYS
   84a/uKwBq2bMngVAUEeCcP1oMFnRmAT/QorY/JH5si67qn1MnGpEi1aGk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="266937903"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="266937903"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 13:08:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="548918613"
Received: from kputtann-mobl1.amr.corp.intel.com (HELO [10.251.21.112]) ([10.251.21.112])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 13:08:35 -0700
Message-ID: <aa561e423906b175c73afbd6248a0a5dff0b079c.camel@linux.intel.com>
Subject: Re: [PATCH] selftests/sgx: Ignore OpenSSL 3.0 deprecated functions
 warning
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org
Date:   Thu, 21 Jul 2022 13:08:25 -0700
In-Reply-To: <bf154be9-1cc0-a555-47f5-04e5df1d6c31@intel.com>
References: <20220721194041.43970-1-kristen@linux.intel.com>
         <bf154be9-1cc0-a555-47f5-04e5df1d6c31@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2022-07-21 at 13:02 -0700, Dave Hansen wrote:
> On 7/21/22 12:40, Kristen Carlson Accardi wrote:
> > OpenSSL 3.0 deprecates some of the functions used in the SGX
> > selftests, causing build errors on new distros. For now ignore
> > the warnings until support for the functions is no longer
> > available.
>=20
> Are there some better functions we should be moving to?

I looked into this actually as my first choice, but the problem I had
was that the recommended new functions weren't available on other
OpenSSL libraries, and we'd have to add compatibility macros and stuff,
so it seemed to me that the less complicated thing to do was wait till
OpenSSL 1 was just not widely deployed anymore. This strategy is also
being used in other scripts in the kernel.


