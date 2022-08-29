Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8627D5A5584
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 22:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiH2U2J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 16:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiH2U2I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 16:28:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6B485A95;
        Mon, 29 Aug 2022 13:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661804886; x=1693340886;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hq7IoHFqicjLWVzrN2IrsHJfSlIydp8W3SDB2gI7EXc=;
  b=deDZkS3LnbDHDO9b6XO9/pU7TzBYZOu1XBM3aTJgfmJtGuyvjB7zg1v9
   HP+nryRgOE7PwoDbjm3QUuyFnEGqN287qTQThiseKQNHZBUQ2c2+T1Djj
   66/EuWy1CenXJT9hAw84lJqQIzya43CCPkErQiRJykBj0LgJejigx/xDa
   mnKnfVvuFs/vFr4jZ0d2X8d4flOHW2ee86D+gnccuCmJVF2eOYIOqitaT
   bMf3v/2ypQ/29MyKP0sWNc7/KrHVzqKxpQ/PjRNCYCTX4d+yzdc/NtA/n
   qXXsWbFBSQgdZSpml9HigED0OG4uPv4D8C7Svu3FnOD/CS3ft+hMf+VW/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="296268439"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="296268439"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 13:28:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="611432873"
Received: from rlacadex-mobl.amr.corp.intel.com (HELO [10.209.116.122]) ([10.209.116.122])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 13:28:05 -0700
Message-ID: <12ab0a8a-a286-4f21-3b44-a506a6c2d008@intel.com>
Date:   Mon, 29 Aug 2022 13:28:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v11 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220826150638.2397576-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <dcf53e6b-d60f-5d6b-029a-38df68d66302@intel.com>
 <c6ccbcac-c5b1-f460-01e2-e1b6684b6e65@linux.intel.com>
 <YwxO2L/MtCw/OHGB@kroah.com>
 <73b375c3-97a7-5f25-5abf-48d9ec6be2db@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <73b375c3-97a7-5f25-5abf-48d9ec6be2db@linux.intel.com>
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

On 8/29/22 13:09, Sathyanarayanan Kuppuswamy wrote:
> With the changed format, we avoided the holes, but it still adds 7 bytes of padding.
> 
> Total size of struct is 32 bytes.
> 
> struct tdx_report_req {
> 	__u64                      reportdata;           /*     0     8 */
> 	__u64                      tdreport;             /*     8     8 */
> 	__u32                      rpd_len;              /*    16     4 */
> 	__u32                      tdr_len;              /*    20     4 */
> 	__u8                       subtype;              /*    24     1 */
> 
> 	/* size: 32, cachelines: 1, members: 5 */
> 	/* padding: 7 */
> 	/* last cacheline: 32 bytes */
> };

Might as well make some use of the padding and add:

	u8 reserved[7];

That will ensure that the entire structure is explicitly sized *AND*
leave you room to add flags or other fun in the future without a new ABI.
