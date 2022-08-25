Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27025A059C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Aug 2022 03:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiHYB3H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 21:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiHYB3G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 21:29:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F2D7E816;
        Wed, 24 Aug 2022 18:29:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3758B824CF;
        Thu, 25 Aug 2022 01:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09570C433D6;
        Thu, 25 Aug 2022 01:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661390943;
        bh=zS7qPS6Vu0zW4YUqfCMKTSO52Y+PkYAPdsGESbX5r2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ahEDUsFiYyy/b5oYgueRM7g4wilFFkA+yojrDkIArZfm1FbVuk+kzgmQ9dbYQLYDL
         Rfst7f1UU9rkQYogBJSYlJ9JJaovcGJn/Nt7FOILjh8sZdiO2Uet/mSEWyHdfYwuiX
         M+wPNnM0LD1ZIK/xY23JzcudzHfrwJIywhvkUoyqYfux0qRuSFbQr3mSHzBLnqy7Ww
         e6e3qc3R4YvvAZusGDEVlpcimimTh2apLtiwuQegGAzjeVQcd3Vl/ChcF43B2CFTaD
         6NnqiyUgJInGM1PbdxOjemBLMOfx55/G2JF07t3YeBeMh8mLpspXsFhAtW13oUjJxA
         czQ2Rs0k0RXwQ==
Date:   Thu, 25 Aug 2022 04:28:56 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Dhanraj, Vijay" <vijay.dhanraj@intel.com>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests/sgx: Add SGX selftest
 augment_via_eaccept_long
Message-ID: <YwbQWL5SK0S+Nn00@kernel.org>
References: <20220815233900.11225-1-jarkko@kernel.org>
 <20220815233900.11225-2-jarkko@kernel.org>
 <6b304bb4-01cc-c88a-7299-19217a7a692b@intel.com>
 <YvwpX7pYOW3Jv+vJ@kernel.org>
 <DM8PR11MB55913534E8CE66F63460E707F66A9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <Yvz9g1dx9qbbMXJf@kernel.org>
 <DM8PR11MB55915BB75E3A6D266FC8D51DF66A9@DM8PR11MB5591.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB55915BB75E3A6D266FC8D51DF66A9@DM8PR11MB5591.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 17, 2022 at 03:39:36PM +0000, Dhanraj, Vijay wrote:
> 
> 
> > -----Original Message-----
> > From: Jarkko Sakkinen <jarkko@kernel.org>
> > Sent: Wednesday, August 17, 2022 7:39 AM
> > To: Dhanraj, Vijay <vijay.dhanraj@intel.com>
> > Cc: Chatre, Reinette <reinette.chatre@intel.com>; Dave Hansen
> > <dave.hansen@linux.intel.com>; linux-sgx@vger.kernel.org; Shuah Khan
> > <shuah@kernel.org>; open list:KERNEL SELFTEST FRAMEWORK <linux-
> > kselftest@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH 2/2] selftests/sgx: Add SGX selftest
> > augment_via_eaccept_long
> > 
> > On Wed, Aug 17, 2022 at 01:27:38AM +0000, Dhanraj, Vijay wrote:
> > > I think changing it to "int i" will cause a buffer overflow with
> > > edmm_size being 8GB.
> > 
> > Hmm.. 'i' iterates segments. Amd I missing something?
> > 
> > BR, Jarkko
> 
> It is also used when iterating over pages to eaccept. This might cause an issue.
> 
> 	for (i = 0; i < edmm_size; i += 4096) {
> 		eaccept_op.epc_addr = (uint64_t)(addr + i);
> 
> Regards, Vijay

Ah got it, thanks.

BR, Jarkko
