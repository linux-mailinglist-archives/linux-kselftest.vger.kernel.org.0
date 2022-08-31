Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D93B5A855D
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 20:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiHaSTb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 14:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiHaSTJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 14:19:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFBD9A9CC;
        Wed, 31 Aug 2022 11:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661969729; x=1693505729;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wfUhKvUcNyE2J2x0SokgiD+eOtEV7vGJq38abRIn1Sw=;
  b=augAJ+9hXBdnzGOTypORSsDoDQeBhxyt44tAthJIQnQlnSMDaXrdpCUG
   FmCM48zy3Oe1t4bG22ungsDZLLtgSJmJsO/MnRsp2pLq/Fc9DujsGlsm5
   Y69KyAIafxgDC0ITMmDeThAPZrGtIry+8TUx6uea5cNBtcJMWm2T0NCg8
   ZdiyUpso6HM8bemeiCIAlXmBZZaMW7nMKKMySb/gPVVAsCakOV895CNm4
   Uf3dJpaukanjcdO9+eXBvIU7t0cqQC/UXa77AQ7j52a1c24p/dxkPF0v9
   c0s4ah2dkHS0nVB0L8UrxU5WhFlJnY4djqbl+rOYWa4P1n6KaeSnZ4BQA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="357230366"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="357230366"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 11:14:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="612184409"
Received: from nkrobins-mobl2.amr.corp.intel.com (HELO [10.212.220.19]) ([10.212.220.19])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 11:14:02 -0700
Message-ID: <709d9f58-0ae9-833a-ca54-7b50307b377e@intel.com>
Date:   Wed, 31 Aug 2022 11:14:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/6] selftests/sgx: retry the ioctls returned with EAGAIN
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-6-jarkko@kernel.org>
 <5d19be91-3aef-5cbe-6063-3ff3dbd5572b@intel.com>
 <Yw7IFcnjbfm3Xgqk@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Yw7IFcnjbfm3Xgqk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/30/22 19:31, Jarkko Sakkinen wrote:
>> On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
>>> From: Haitao Huang <haitao.huang@linux.intel.com>
>>>
>>> For EMODT and EREMOVE ioctls with a large range, kernel
>> ioctl()s?
> Ioctl is common enough to be considered as noun and is
> widely phrased like that in commit messages. I don't
> see any added clarity.

I definitely prefer ioctl().
