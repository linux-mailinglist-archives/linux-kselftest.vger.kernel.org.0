Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC48C6066C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Oct 2022 19:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiJTRJK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Oct 2022 13:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiJTRJI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Oct 2022 13:09:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4EE1A5B09;
        Thu, 20 Oct 2022 10:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666285747; x=1697821747;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OlzdSXYboENTBrdi9bhDa2ItnEOzKmNLunjkKtlJrBg=;
  b=k4ziil6b1mae30B+HiNJgi6r1KhhI3g6Q7tTAA0gLb3zznlt7kju1pTH
   h8j1Napgekeavf+cV6uqZtut21HBDtALxqS2+nc4lYYyZ/csvkY5dK/0e
   4eF3Yk+5j7jtO30fl5XxLh+i/JADKuQopb5US8Gqj98JWB52n9Q5jNKyV
   XMcb53J3EE7XX9tWFNBoJ5EpwKXj6wd6f+I7EM94R68Tyo4/45NLTRW+6
   RzoNiDsZpGBTaBAQpd32r9m0Pihh00c0yXe7M3CwfxisDXqbut1lBzIMT
   rwv8BgEWCxn1b/t26Xq8/pG9udh7MfZjJYj2FPJU6w023/BEpIe8rEWyM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="306770191"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="306770191"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 10:08:52 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="805017090"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="805017090"
Received: from amancuso-mobl.amr.corp.intel.com (HELO [10.209.121.211]) ([10.209.121.211])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 10:08:48 -0700
Message-ID: <95240a74-0c49-d051-a609-775c48b22bf5@intel.com>
Date:   Thu, 20 Oct 2022 10:08:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v15 0/3]] Add TDX Guest Attestation support
Content-Language: en-US
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20221020045828.2354731-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221020045828.2354731-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/19/22 21:58, Kuppuswamy Sathyanarayanan wrote:
> Following are the details of the patch set:
> 
> Patch 1/3 -> Preparatory patch for adding attestation support.
> Patch 2/3 -> Adds user interface driver to support attestation.
> Patch 3/3 -> Adds selftest support for TDREPORT feature.
> 
> Commit log history is maintained in the individual patches.

I really appreciate when folks come out and say what they think should
be done with the series.  Is this ready to be applied?  Or, is it just
being thrown over the fence in the general direction of the maintainers
with the hope that they'll divine its true purpose?
